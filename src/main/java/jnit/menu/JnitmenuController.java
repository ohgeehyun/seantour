package jnit.menu;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.excel.impl.EgovExcelServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.AdminUtil;
import net.sf.jxls.transformer.XLSTransformer;


/**
 * @Class Name : JnitmenuController.java
 * @Description : Jnitmenu Controller class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitmenuVO.class)
public class JnitmenuController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitmenuService")
    private JnitmenuService jnitmenuService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    /** 파일 위치 지정 */
	private final String uploadDir = EgovProperties
			.getProperty("Globals.fileStorePath");
	
	/** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
	
	public static final String SEPERATOR = File.separator;
    
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	
    /**
	 * JNITMENU 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitmenuDefaultVO
	 * @return "/jnit/tpl-temp/jnitmenu/JnitmenuList"
	 * @exception Exception
	 */
    @RequestMapping(value="/menu/sub14/0101.do")
    public String selectJnitmenuList(@ModelAttribute("searchVO") JnitmenuDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m03050000");
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List jnitmenuList = jnitmenuService.selectJnitmenuList(searchVO);
        model.addAttribute("resultList", jnitmenuList);
        
        int totCnt = jnitmenuService.selectJnitmenuListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/menu/sub14_1-1";
    } 
    
    //엑셀 내려받기
    @RequestMapping(value="/menu/sub14/01excel.do")
    public void ExcelJnitmenuList(@ModelAttribute("searchVO") JnitmenuDefaultVO searchVO,
    		HttpServletRequest request, 
    		HttpServletResponse response,
    		ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(99999);
		
		List jnitmenuList = jnitmenuService.selectJnitmenuList(searchVO);
        model.addAttribute("resultList", jnitmenuList);
        
        int totCnt = jnitmenuService.selectJnitmenuListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
		String templateFiletPath	= uploadDir + SEPERATOR + "excel_report" + SEPERATOR + "menu.xls";
		String ExcelFileName		= "menuReport.xls";
		
		XLSTransformer transformer = new XLSTransformer();
		
		File uFile = new File(templateFiletPath);
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(uFile);
			Workbook wb = transformer.transformXLS(fis, model);
			response.setHeader( "Content-disposition", "attachment;filename=" + URLEncoder.encode(ExcelFileName,"UTF-8"));
			response.setContentType("application/x-msexcel");
					 
			wb.write(response.getOutputStream());
			response.getOutputStream().flush();
		} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		} finally {
			response.getOutputStream().close();
			if(fis != null){
				fis.close();
			}
		}
        return;
    } 
    
    // 메뉴 > 엑셀팝업
    @RequestMapping("/menu/sub14/01popUp.do")
    public String ExcelJnitmenuPopup(ModelMap model) throws Exception {
    	
    	return "/jnit/menu/sub14_popUp";
    }
    
    
    // 메뉴 > 엑셀업로드
    @RequestMapping("/menu/sub14/upExcel.do")
    public String uploadJnitmenu(
	    HttpServletRequest request,
	    SessionStatus status,
	    Model model)
            throws Exception {
    		
    		HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);
    		
    		
    		if(list.get("upfile") != null){
    			
    			//조직도 삭제
    			JnitmenuVO jnitmenuVO1 = new JnitmenuVO();
    			jnitmenuService.deleteJnitmenu(jnitmenuVO1);
        		
    			EgovFormBasedFileVo upfileList = list.get("upfile");
    			
    	    		EgovFormBasedFileVo vo = upfileList;
    	    		
    	    		String realpath = uploadDir + vo.getServerSubPath() + "/" + vo.getPhysicalName();
    	    		
    	    		EgovExcelServiceImpl excelService = new EgovExcelServiceImpl();
    	    		HSSFWorkbook wb = new HSSFWorkbook();
					wb = (HSSFWorkbook) excelService.loadWorkbook(realpath);
					
					if("true".equals(deDug)) log.debug("realpath ==== " + realpath);
					if("true".equals(deDug)) log.debug("wb === " + wb);
					
					HSSFSheet sheetT = wb.getSheet("메뉴리스트");
					int rows = sheetT.getPhysicalNumberOfRows(); 
					
					if("true".equals(deDug)) log.debug("rows ==== " + rows);
					
					for (int i = 8; i < rows; i++) {
						//시트에 대한 행을 하나씩 추출
						HSSFRow row1 = sheetT.getRow(i);
						if(row1 != null){
							int cells = row1.getPhysicalNumberOfCells();
							
							JnitmenuVO jnitmenuVO = new JnitmenuVO();
						
						for (int j = 0; j < cells; j++) {
							HSSFCell cell1 = row1.getCell((short) j);
							
								if(cell1 != null){
									String value = null;
									
									switch (cell1.getCellType()) {
	                                case HSSFCell.CELL_TYPE_FORMULA :
	                                	value = cell1.getCellFormula();
	                                    break;
	                                case HSSFCell.CELL_TYPE_NUMERIC :
	                                    value = cell1.getNumericCellValue() + ""; //double
	                                    break;
	                                case HSSFCell.CELL_TYPE_STRING :
	                                    value = cell1.getStringCellValue(); //String
	                                    break;
	                                case HSSFCell.CELL_TYPE_BLANK :
	                                   value = null;
	                                   break;
	                                case HSSFCell.CELL_TYPE_BOOLEAN :
	                            	   value = cell1.getBooleanCellValue() + ""; //boolean
	                            	   break;
	                                case HSSFCell.CELL_TYPE_ERROR :
	                            	   value = cell1.getErrorCellValue() + ""; // byte
	                            	   break;
	                                default :
								}
									if("true".equals(deDug)) log.debug("CELL row ==== " + row1.getRowNum() + " col === " + cell1.getCellNum() + " values ==== " + value);
								
									if(cell1.getCellNum() == 0 ){
										
										if(value != null){
											jnitmenuVO.setMenuSeq( Double.valueOf(value).intValue() );
										}
									}
									
									if(cell1.getCellNum() == 1 ){
										
										if(value != null){
											jnitmenuVO.setSiteNm(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 2 ){
										
										if(value != null){
											jnitmenuVO.setMenuDepth1(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 3 ){
										if(value != null){
											jnitmenuVO.setMenuDepth2(value.toString());
										}	
									}
									
									if(cell1.getCellNum() == 4 ){
										if(value != null){
											jnitmenuVO.setMenuDepth3(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 5 ){
										if(value != null){
											jnitmenuVO.setMenuDepth4(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 6 ){
										if(value != null){
											jnitmenuVO.setMenuDepth5(value.toString());
										}
									}
										
									if(cell1.getCellNum() == 7 ){
										if(value != null){
											jnitmenuVO.setMenuDepth6(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 8 ){
										if(value != null){
											jnitmenuVO.setMenuDepth7(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 9 ){
										if(value != null){
											jnitmenuVO.setMenuUrl(value.toString());
										}else{//primary key로 설정되어있어서 널포인트가 떨어져 공백 넣음.
											jnitmenuVO.setMenuUrl("");
										}
									}

									if(cell1.getCellNum() == 10 ){
										if(value != null){
											jnitmenuVO.setMenuDept(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 11 ){
										if(value != null){
											jnitmenuVO.setMenuPart(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 12 ){
										if(value != null){
											jnitmenuVO.setMenuTel(value.toString());
										}
									}
									
									if(cell1.getCellNum() == 13 ){
										if(value != null){
											jnitmenuVO.setMenuMemid(value.toString());
										}
									}
									
							}
						}
						
						//insert 구문
						if( 
							!NullUtil.nullString( jnitmenuVO.getMenuDept() ).equals("") ||
							!NullUtil.nullString( jnitmenuVO.getMenuPart() ).equals("") ||
							!NullUtil.nullString( jnitmenuVO.getMenuTel() ).equals("") ||
							!NullUtil.nullString( jnitmenuVO.getMenuMemid() ).equals("")
						) {
							jnitmenuService.insertJnitmenu(jnitmenuVO);
						}
						
						//업로드한 파일 삭제
						File f = new File(realpath);
			    		if(f.exists() == true) {
			    			f.delete();
			    		}
			    		
			    		model.addAttribute("result", "OK");
			    		status.setComplete();
					}		
				} 
					
				return "/jnit/menu/result";
        	}
    		
		return "/jnit/menu/sub14_popUp";
    }
    
    
    // 메뉴 > 삭제
    @RequestMapping("/menu/sub14/01delete.do")
    public String deleteJnitmenu(
            @RequestParam("menuSeq") java.lang.String menuSeq ,
            @ModelAttribute("searchVO") JnitmenuDefaultVO searchVO, SessionStatus status)
            throws Exception {
    	
    	JnitmenuVO jnitmenuVO = new JnitmenuVO();
    	jnitmenuVO.setMenuSeq(Integer.parseInt(menuSeq));
    	
        jnitmenuService.deleteJnitmenu(jnitmenuVO);
        status.setComplete();
        return "forward:/menu/sub14/0101.do";
    }
    
    
    @RequestMapping("/jnitmenu/addJnitmenuView.do")
    public String addJnitmenuView(
            @ModelAttribute("searchVO") JnitmenuDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m03050000");
        model.addAttribute("nid",  jnitmenuService.getLastIdJnitmenu());
        model.addAttribute("jnitmenuVO", new JnitmenuVO());
        return "/jnit/tpl-temp/jnitmenu/JnitmenuRegister";
    }
    
    @RequestMapping("/jnitmenu/addJnitmenu.do")
    public String addJnitmenu(
            @ModelAttribute("searchVO") JnitmenuDefaultVO searchVO,
	    @ModelAttribute("jnitmenuVO") JnitmenuVO jnitmenuVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitmenuVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitmenu/JnitmenuRegister";
	// }

        jnitmenuService.insertJnitmenu(jnitmenuVO);
        status.setComplete();
        return "forward:/jnitmenu/JnitmenuList.do";
    }
    
    @RequestMapping("/jnitmenu/updateJnitmenuView.do")
    public String updateJnitmenuView(
            @RequestParam("menuSeq") int menuSeq ,
            @ModelAttribute("searchVO") JnitmenuDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m03050000");
        JnitmenuVO jnitmenuVO = new JnitmenuVO();
        jnitmenuVO.setMenuSeq(menuSeq);        
        // 변수명은 CoC 에 따라 jnitmenuVO
        model.addAttribute(selectJnitmenu(jnitmenuVO, searchVO));
        return "/jnit/tpl-temp/jnitmenu/JnitmenuRegister";
    }

    @RequestMapping("/jnitmenu/selectJnitmenu.do")
    public @ModelAttribute("jnitmenuVO")
    JnitmenuVO selectJnitmenu(
            JnitmenuVO jnitmenuVO,
            @ModelAttribute("searchVO") JnitmenuDefaultVO searchVO) throws Exception {
        return jnitmenuService.selectJnitmenu(jnitmenuVO);
    }

    @RequestMapping("/jnitmenu/updateJnitmenu.do")
    public String updateJnitmenu(
            @ModelAttribute("searchVO") JnitmenuDefaultVO searchVO,
	    @ModelAttribute("jnitmenuVO") JnitmenuVO jnitmenuVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitmenuVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitmenu/JnitmenuRegister";
	// }

        jnitmenuService.updateJnitmenu(jnitmenuVO);
        status.setComplete();
        return "forward:/jnitmenu/JnitmenuList.do";
    }
    
    @RequestMapping("/jnitmenu/deleteJnitmenu.do")
    public String deleteJnitmenu(
            JnitmenuVO jnitmenuVO,
            @ModelAttribute("searchVO") JnitmenuDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitmenuService.deleteJnitmenu(jnitmenuVO);
        status.setComplete();
        return "forward:/jnitmenu/JnitmenuList.do";
    }

}
