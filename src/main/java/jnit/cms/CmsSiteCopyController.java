/**
 * @version 3.2.0.1
 */
package jnit.cms;

/**
 * 사이트관리
 */
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.FileUtil;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.excel.impl.EgovExcelServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.menu.JnitcmsmenuDefaultVO;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteDefaultVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplDefaultVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.com.util.DBType;
import jnit.util.PathUtil;
import jxl.Workbook;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.model.FileHeader;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;
import oracle.sql.CLOB;

@Controller
@SessionAttributes(types=JnitcmssiteVO.class)
public class CmsSiteCopyController {
	private Log log = LogFactory.getLog(getClass());
    public static final String SEPERATOR = File.separator;
    public static final int BUFFER_SIZE = 8192;
    
    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;
    
    @Resource(name = "jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    @Resource(name = "jnitcmstplService")
    private JnitcmstplService jnitcmstplService;
        
    @Resource(name="jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
    @Resource(name = "jnitcmscntService")
    private JnitcmscntService jnitcmscntService;
    
    @Autowired
	private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    

    // 사이트관리 > 사이트복사 > 폼
    @RequestMapping(value="/cms/copySite/select.do")
    public String selectJnitcmssiteList(@ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(10000);
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List jnitcmssiteList = jnitcmssiteService.selectJnitcmssiteList(searchVO);
        model.addAttribute("resultList", jnitcmssiteList);
        
        AdminUtil.setMenuId("m01040000");
        model.addAttribute("nid",  jnitcmssiteService.getLastIdJnitcmssite());
        JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
        jnitcmssiteVO.setSiteOrd(jnitcmssiteService.getNextOrdJnitcmssite());
        model.addAttribute("jnitcmssiteVO", jnitcmssiteVO);
        
        
        return "jnit/cms/siteCopy";
    }
    

    @RequestMapping("/cms/copySite/start.do")
    public String addJnitcmssite(
            @ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO,
            @ModelAttribute("jnitcmssiteVO") JnitcmssiteVO jnitcmssiteVO,
            BindingResult bindingResult,
            HttpServletRequest request,
            HttpServletResponse response,
            SessionStatus status,
            Model model)
            throws Exception {
    	String parentSiteId = NullUtil.nullString(request.getParameter("parentSiteId"));
    	String ctxDir = request.getSession().getServletContext().getRealPath(SEPERATOR);
    	String backupDir = ctxDir + SEPERATOR +"WEB-INF" + SEPERATOR + "_backup";
    	String copyDir = ctxDir + SEPERATOR +"WEB-INF" + SEPERATOR + "_backup" +  SEPERATOR + "copy" +  SEPERATOR + parentSiteId;
    	String siteDir = "";
    	String zipoutDir = ctxDir + jnitcmssiteVO.getSitePath();
    	String sitePath = jnitcmssiteVO.getSitePath();
    	String siteId = jnitcmssiteService.insertJnitcmssite(jnitcmssiteVO);
    	
    	jnitcmssiteVO.setSiteId(parentSiteId);
    	jnitcmssiteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);  
    	siteDir = ctxDir + SEPERATOR + jnitcmssiteVO.getSitePath();
    	
    	beanValidator.validate(jnitcmssiteVO, bindingResult); //validation 수행
		if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
			return "jnit/cms/sub3_1-2";
		}
		File copyDirFile = new File(copyDir);
    	if(copyDirFile.exists() == false) {
    		copyDirFile.mkdirs();
    	}
    	File outDirFile = new File(zipoutDir);
    	if(outDirFile.exists() == false) {
    		outDirFile.mkdirs();
    	}
    	File oldZipFile = new File(copyDir + SEPERATOR + parentSiteId + ".dat");
		if(oldZipFile.exists()) {
			boolean delOld = oldZipFile.delete();
			//log.error(delOld);
		}	
		
		ZipFile zipFile = new ZipFile(oldZipFile.getPath());
		ZipParameters parameters = new ZipParameters();
		parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);
		parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
		parameters.setEncryptFiles(true);
		parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_AES);
		parameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);
		
		// Set password
		parameters.setPassword(EgovProperties.getProperty("Globals.BACKUP.passwd"));
		
		List<String> filelist = new ArrayList<String>();
    	try {
    		filelist = FileUtil.getFileList(new File(siteDir));
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e) {
    		if("true".equals(deDug)) log.error("error: "+ e.getMessage());
    	}
    	for(int i=0; i<filelist.size(); i++) {
    		//log.error(filePath + "\\" + filelist.get(i));
    		zipFile.addFile(new File(siteDir + SEPERATOR + filelist.get(i)), parameters);
    	}
    	
		List<String> dirlist = new ArrayList<String>();
    	try {
    		dirlist = FileUtil.getDirectoryList(new File(siteDir));
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e) {
    		if("true".equals(deDug)) log.error("error: "+ e.getMessage());
    	}
    	for(int j=0; j<dirlist.size(); j++) {
    		//log.error(filePath + "\\" + dirlist.get(j));
    		zipFile.addFolder(siteDir + SEPERATOR + dirlist.get(j), parameters);
    	}
    	
    	List fileHeaderList = zipFile.getFileHeaders();
    	List<String> removeList = new ArrayList<String>();
		// Loop through the file headers
		for (int k = 0; k < fileHeaderList.size(); k++) {
			FileHeader fileHeader = (FileHeader)fileHeaderList.get(k);				
			//log.error(fileHeader.getFileName().matches(".*\\.svn.*"));
			
			if(fileHeader.getFileName().matches(".*\\.svn.*")) {
				removeList.add(fileHeader.getFileName());
			}
		}
		
		for(int j = 0; j < removeList.size(); j++) {
			zipFile.removeFile(removeList.get(j));
			
		}
		String zipfile = copyDir + SEPERATOR + parentSiteId +".dat";
		if("true".equals(deDug)) log.error(zipoutDir);
		zipFile.setPassword(EgovProperties.getProperty("Globals.BACKUP.passwd"));
		zipFile.extractAll(zipoutDir);
		
        WritableWorkbook workbook = Workbook.createWorkbook(new File(copyDir + SEPERATOR + "tpl.xls"));
       
        WritableSheet sheet = workbook.createSheet("Sheet1", 0);
        jxl.write.WritableCellFormat format= new WritableCellFormat();
        jxl.write.WritableCellFormat format0= new WritableCellFormat();
        // 워크시트 생성
        sheet.setColumnView(0,8);
        jxl.write.Label label =null;
        jxl.write.Blank blank=null;
      
        
        JnitcmstplDefaultVO tplsearchVO = new JnitcmstplDefaultVO();
        tplsearchVO.setSiteId(parentSiteId);
        List tplList = jnitcmstplService.selectJnitcmstplCopyList(tplsearchVO);
        Iterator tplItr = tplList.iterator();
        
        int i = 0;
        int h = 0;
        String oraTd = "";
        String oraTs = "";
        while(tplItr.hasNext()){
        	EgovMap tmpMap = (EgovMap)tplItr.next();
        	if("true".equals(deDug)) log.error(tmpMap);
        	/*
	        objCell1.setCellValue(String.valueOf(tmpMap.get("site_id")));
	        objCell2.setCellValue(String.valueOf(tmpMap.get("tpl_id")));
	        objCell3.setCellValue(String.valueOf(tmpMap.get("tpl_type")));
	        objCell4.setCellValue(String.valueOf(tmpMap.get("tpl_nm")));
	        objCell5.setCellValue("test");
        	for(int h=1;h<51;h++)//1~51행
            {
            	for(int i=0;i<10;i++)//0~9 10열
            	{
            		label = new jxl.write.Label(i, h, "("+i+","+h+")",format0);
            		sheet.addCell(label);
            	}
            } 
        	*/
        	//oracle
    		if(DBType.getDbTypeBoolean("oracle")){
    			
    					CLOB tplDesc = (CLOB) tmpMap.get("tplDesc");				
    					if(tplDesc != null){
    						StringBuffer sbTd = new StringBuffer();				
    						try {
    							Reader reader = tplDesc.getCharacterStream();
    							BufferedReader br = new BufferedReader(reader);
    							
    							String line = "";
    							while ((line = br.readLine()) != null) {
    								sbTd.append(line+"\r\n");
    							}
    							br.close();
    						} catch (IOException e){
    							log.error(e.getMessage());
    						} catch (Exception e) {
    							log.error(e.getMessage());
    						}
    						oraTd = sbTd.toString();
    					}
    					CLOB tplSrc = (CLOB) tmpMap.get("tplSrc");				
    					if(tplSrc != null){
    						StringBuffer sbTs = new StringBuffer();				
    						try {
    							Reader reader = tplSrc.getCharacterStream();
    							BufferedReader br = new BufferedReader(reader);
    							
    							String line = "";
    							while ((line = br.readLine()) != null) {
    								sbTs.append(line+"\r\n");
    							}
    							br.close();
    						} catch (IOException e){
    							log.error(e.getMessage());
    						} catch (Exception e) {
    							log.error(e.getMessage());
    						}
    						oraTs = sbTs.toString();
    					}
    			//End of CLOB contentMap 처리
    		}else if(DBType.getDbTypeBoolean("tibero")){
    			com.tmax.tibero.jdbc.TbClob tplDesc = (com.tmax.tibero.jdbc.TbClob) tmpMap.get("tplDesc");				
					if(tplDesc != null){
						StringBuffer sbTd = new StringBuffer();				
						try {
							Reader reader = tplDesc.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);
							
							String line = "";
							while ((line = br.readLine()) != null) {
								sbTd.append(line+"\r\n");
							}
							br.close();
						} catch (IOException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						oraTd = sbTd.toString();
					}
					com.tmax.tibero.jdbc.TbClob tplSrc = (com.tmax.tibero.jdbc.TbClob) tmpMap.get("tplSrc");				
					if(tplSrc != null){
						StringBuffer sbTs = new StringBuffer();				
						try {
							Reader reader = tplSrc.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);
							
							String line = "";
							while ((line = br.readLine()) != null) {
								sbTs.append(line+"\r\n");
							}
							br.close();
						} catch (IOException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						oraTs = sbTs.toString();
					}
			//End of CLOB contentMap 처리
    		}else{
    			oraTd=String.valueOf(tmpMap.get("tplDesc"));
    			oraTs=String.valueOf(tmpMap.get("tplSrc"));
    		}
    		//End of oracle
        	label = new jxl.write.Label(0, h, String.valueOf(tmpMap.get("siteId")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(1, h, String.valueOf(tmpMap.get("tplId")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(2, h, String.valueOf(tmpMap.get("tplType")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(3, h, String.valueOf(tmpMap.get("tplNm")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(4, h, oraTd,format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(5, h, oraTs,format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(6, h, String.valueOf(tmpMap.get("created")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(7, h, String.valueOf(tmpMap.get("modified")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(8, h, String.valueOf(tmpMap.get("isdel")),format0);
    		sheet.addCell(label);
    		h++;
        }
        workbook.write();
        workbook.close();
        
        
        JnitcmsmenuDefaultVO menusearchVO = new JnitcmsmenuDefaultVO();
        menusearchVO.setSiteId(parentSiteId);
        menusearchVO.setPageUnit(100000);
        menusearchVO.setPageSize(propertiesService.getInt("pageSize"));
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(menusearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(menusearchVO.getPageUnit());
		paginationInfo.setPageSize(menusearchVO.getPageSize());
		
		menusearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		menusearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		menusearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        
        List menuList = jnitcmsmenuService.selectJnitcmsmenuList(menusearchVO);
        Iterator menuItr = menuList.iterator();
        
        workbook = Workbook.createWorkbook(new File(copyDir + SEPERATOR + "menu.xls"));
        
        sheet = workbook.createSheet("Sheet1", 0);
        // 워크시트 생성
        sheet.setColumnView(0,23);
        i = 0;
        h = 0;
        while(menuItr.hasNext()){
        	EgovMap tmpMap = (EgovMap)menuItr.next();
        	log.error(tmpMap);
 
        	label = new jxl.write.Label(0, h, String.valueOf(tmpMap.get("siteId")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(1, h, String.valueOf(tmpMap.get("menuId")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(2, h, String.valueOf(tmpMap.get("menuNm")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(3, h, String.valueOf(tmpMap.get("menuPath")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(4, h, String.valueOf(tmpMap.get("pid")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(5, h, String.valueOf(tmpMap.get("depth")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(6, h, String.valueOf(tmpMap.get("method")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(7, h, String.valueOf(tmpMap.get("islink")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(8, h, String.valueOf(tmpMap.get("iscnt")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(9, h, String.valueOf(tmpMap.get("linkurl")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(10, h, String.valueOf(tmpMap.get("linkgt")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(11, h, String.valueOf(tmpMap.get("tplId")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(12, h, String.valueOf(tmpMap.get("cntId")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(13, h, String.valueOf(tmpMap.get("defMenu")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(14, h, String.valueOf(tmpMap.get("menuImgFile")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(15, h, String.valueOf(tmpMap.get("menuImgPath")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(16, h, String.valueOf(tmpMap.get("menuImgOnm")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(17, h, String.valueOf(tmpMap.get("menuImgUrl")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(18, h, String.valueOf(tmpMap.get("admMbrId")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(19, h, String.valueOf(tmpMap.get("active")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(20, h, String.valueOf(tmpMap.get("ccl")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(21, h, String.valueOf(tmpMap.get("created")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(22, h, String.valueOf(tmpMap.get("modified")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(23, h, String.valueOf(tmpMap.get("isdel")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(24, h, String.valueOf(tmpMap.get("contentSearchChk")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(25, h, String.valueOf(tmpMap.get("robotYn")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(26, h, String.valueOf(tmpMap.get("hDel")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(27, h, String.valueOf(tmpMap.get("lDel")),format0);
    		sheet.addCell(label);
    		label = new jxl.write.Label(28, h, String.valueOf(tmpMap.get("sDel")),format0);
    		sheet.addCell(label);
    		
    		h++;
        }
        workbook.write();
        workbook.close();
        /*
         * 
     // TPL File 저장
        String tplDir = PathUtil.getRealPath(request)
					+ "/" + jnitcmssiteVO.getSitePath();
        File f = new File(tplDir);
        if(f.exists()) {
        	model.addAttribute("errormsg", "이미 존재하는 경로입니다.");
        	return "jnit/cms/sub3_1-2";
        }
		
		String siteId = jnitcmssiteService.insertJnitcmssite(jnitcmssiteVO);
        
		f.mkdirs();
		*/
        
        
		HashMap<String, String> changeId = new HashMap<String, String>();
		String insertId = "";
		String excelId ="";
		EgovExcelServiceImpl excelService = new EgovExcelServiceImpl();
 		HSSFWorkbook wb = new HSSFWorkbook();
			wb = (HSSFWorkbook) excelService.loadWorkbook(copyDir + SEPERATOR + "tpl.xls");
			if("true".equals(deDug)){
				log.error("realpath ==== " + copyDir + SEPERATOR + "tpl.xls");
				log.error("wb === " + wb);
			}
			
			HSSFSheet sheetT = wb.getSheet("Sheet1");
			int rows = sheetT.getPhysicalNumberOfRows(); 
			
			if("true".equals(deDug)) log.error("rows ==== " + rows);
			
			for (i = 0; i < rows; i++) {
				//시트에 대한 행을 하나씩 추출
				HSSFRow row1 = sheetT.getRow(i);
				if(row1 != null){
					int cells = row1.getPhysicalNumberOfCells();
					
					JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
				
				for (int j = 0; j < cells; j++) {
					HSSFCell cell1 = row1.getCell((short) j);
					
						if(cell1 != null){
							String value = null;
							
							switch (cell1.getCellType()) {
                         case HSSFCell.CELL_TYPE_FORMULA :
                         	value = cell1.getCellFormula();
                             break;
                         case HSSFCell.CELL_TYPE_NUMERIC :
                             value = Long.toString(new Double(cell1.getNumericCellValue()).longValue()); //double
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
                     	   value = Integer.toBinaryString(cell1.getErrorCellValue()); // byte
                     	   break;
                         default :
						}
							if("true".equals(deDug)) log.error("CELL row ==== " + row1.getRowNum() + " col === " + cell1.getCellNum() + " values ==== " + value);
							/*insert 하기 때문에 tpl_id 는 자동 생성 치환을 위해 저장함*/
							if(cell1.getCellNum() == 0 ){
								
								if(value != null){
									jnitcmstplVO.setSiteId(siteId);
								}
							}
							if(cell1.getCellNum() == 1 ){
								if(value != null){
									jnitcmstplVO.setTplId(value.toString());
								}	
							}
							
							if(cell1.getCellNum() == 2 ){
								if(value != null){
									
									jnitcmstplVO.setTplType(value.toString());
								}	
							}
							
							if(cell1.getCellNum() == 3 ){
								if(value != null){
									jnitcmstplVO.setTplNm(value.toString());
								}	
							}
							
							if(cell1.getCellNum() == 4 ){
								if(value != null){
									
									jnitcmstplVO.setTplDesc(changeId.get(value.toString()));
								}
							}
							
							if(cell1.getCellNum() == 5 ){
								if(value != null){
									jnitcmstplVO.setTplSrc(value.toString());
								}
							}
							
					}
				}
				excelId = jnitcmstplVO.getTplId();
				insertId = jnitcmstplService.insertJnitcmstpl(jnitcmstplVO);
				changeId.put(excelId, insertId);
				
	    		model.addAttribute("result", "OK");
			}		
		} 
			/*
			//업로드한 파일 삭제
			f = new File(copyDir + SEPERATOR + "tpl.xls");
    		if(f.exists() == true) {
    			f.delete();
    		}
    		*/
    		
    		/**********************************************/
    		excelService = new EgovExcelServiceImpl();
     		wb = new HSSFWorkbook();
    			wb = (HSSFWorkbook) excelService.loadWorkbook(copyDir + SEPERATOR + "menu.xls");
    			if("true".equals(deDug)){
    				log.error("realpath ==== " + copyDir + SEPERATOR + "menu.xls");
    				log.error("wb === " + wb);
    			}
    			
    			sheetT = wb.getSheet("Sheet1");
    			rows = sheetT.getPhysicalNumberOfRows(); 
    			
    			if("true".equals(deDug)) log.error("rows ==== " + rows);
    			
    			for (i = 0; i < rows; i++) {
    				//시트에 대한 행을 하나씩 추출
    				HSSFRow row1 = sheetT.getRow(i);
    				if(row1 != null){
    					int cells = row1.getPhysicalNumberOfCells();
    					
    					JnitcmsmenuVO jnitcmsmenuVO = new JnitcmsmenuVO();
    				
    				for (int j = 0; j < cells; j++) {
    					HSSFCell cell1 = row1.getCell((short) j);
    					
    						if(cell1 != null){
    							String value = null;
    							
    							switch (cell1.getCellType()) {
                             case HSSFCell.CELL_TYPE_FORMULA :
                             	value = cell1.getCellFormula();
                                 break;
                             case HSSFCell.CELL_TYPE_NUMERIC :
                                 value = Long.toString(new Double(cell1.getNumericCellValue()).longValue()); //double
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
                         	   value = Integer.toBinaryString(cell1.getErrorCellValue()); // byte
                         	   break;
                             default :
    						}
    							if("true".equals(deDug)) log.error("CELL row ==== " + row1.getRowNum() + " col === " + cell1.getCellNum() + " values ==== " + value);
    							/*insert 하기 때문에 tpl_id 는 자동 생성 치환을 위해 저장함*/
    							if(cell1.getCellNum() == 0 ){
    								
    								if(value != null){
    									jnitcmsmenuVO.setSiteId(siteId);
    								}
    							}
    							
    							if(cell1.getCellNum() == 1 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setMenuId(value.toString());
    								}	
    							}
    							
    							if(cell1.getCellNum() == 2 ){
    								if(value != null){
    									jnitcmsmenuVO.setMenuNm(value.toString());
    								}	
    							}
    							
    							if(cell1.getCellNum() == 3 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setMenuPath(value.toString());
    								}
    							}
    							
    							if(cell1.getCellNum() == 4 ){
    								if(value != null){
    									jnitcmsmenuVO.setPid(changeId.get(value.toString()));//pid = menuId
    								}
    							}
    							if(cell1.getCellNum() == 5 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setDepth(Integer.parseInt(value.toString()));
    								}
    							}
    							if(cell1.getCellNum() == 6 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setMethod(Integer.parseInt(value.toString()));
    								}
    							}
    							if(cell1.getCellNum() == 7 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setIslink(Integer.parseInt(value.toString()));
    								}
    							}
    							if(cell1.getCellNum() == 8 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setIscnt(Integer.parseInt(value.toString()));
    								}
    							}
    							if(cell1.getCellNum() == 9 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setLinkurl(value.toString());
    								}
    							}

    							if(cell1.getCellNum() == 10 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setLinktgt(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 11 ){
    								if(value != null){    									
    									if("true".equals(deDug)) log.error(changeId);
    									jnitcmsmenuVO.setTplId(changeId.get(value.toString()));//tplId
    								}
    							}
    							if(cell1.getCellNum() == 12 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setCntId(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 13 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setDefMenu(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 14 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setMenuImgFile(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 15 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setMenuImgPath(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 16 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setMenuImgOnm(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 17 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setMenuImgUrl(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 18 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setAdmMbrId(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 19 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setActive(Integer.parseInt(value.toString()));
    								}
    							}
    							if(cell1.getCellNum() == 20 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setCcl(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 24 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setContentSearchChk(Integer.parseInt(value.toString()));
    								}
    							}
    							if(cell1.getCellNum() == 25 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setRobotYn(Integer.parseInt(value.toString()));
    								}
    							}
    							if(cell1.getCellNum() == 26 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.sethDel(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 27 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setlDel(value.toString());
    								}
    							}
    							if(cell1.getCellNum() == 28 ){
    								if(value != null){
    									
    									jnitcmsmenuVO.setsDel(value.toString());
    								}
    							}
    							
    							
	    					}
	    				}
	    				excelId = jnitcmsmenuVO.getMenuId();
	    				insertId = jnitcmsmenuService.insertJnitcmsmenuCopy(jnitcmsmenuVO);
	    				changeId.put(excelId, insertId);
	    				if(jnitcmsmenuVO.getIscnt() == 1) {
	    					JnitcmscntVO cntVO = new JnitcmscntVO();
	    					cntVO.setSiteId(jnitcmsmenuVO.getSiteId());
	    					cntVO.setMenuId(jnitcmsmenuVO.getMenuId());
	    					cntVO.setTplId(NullUtil.nullString(jnitcmsmenuVO.getTplId()));
	    					String cntId = jnitcmscntService.insertJnitcmscnt(cntVO);
	    					
	    					jnitcmsmenuVO.setCntId(cntId);
	    					jnitcmsmenuService.updateJnitcmsmenu(jnitcmsmenuVO);
	    				}
	    				
	    	    		model.addAttribute("result", "OK");
	    			}		
	    		} 
    			/*
    			//업로드한 파일 삭제
    			f = new File(copyDir + SEPERATOR + "menu.xls");
        		if(f.exists() == true) {
        			f.delete();
        		}
    			 */
    			String root = PathUtil.getRealPath(request);
    			CmsManageSub3Controller sitePathFiles = new CmsManageSub3Controller();
    			jnitcmssiteVO.setSiteId(siteId);
    	    	jnitcmssiteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);
    			sitePathFiles.sitePathFiles(root, jnitcmssiteVO);
        
        
        status.setComplete();
        return "forward:/cms/sub3/0101.do";
    }    
    
    public void subDirList(String path,String parentName,String copyName){
		File dir = new File(path); 
		File[] fileList = dir.listFiles();
		if(fileList == null) fileList = new File[0];
		try{
			for(int i = 0 ; i < fileList.length ; i++){
				File file = fileList[i]; 
				if(file.isFile()){
					// 파일이 있다면 파일 이름 출력
					if("true".equals(deDug)) log.error("\t 파일 이름 = " + file.getName());
				}else if(file.isDirectory()){
					if("true".equals(deDug)) log.error("디렉토리 이름 = " + file.getName());
					// 서브디렉토리가 존재하면 재귀적 방법으로 다시 탐색
					subDirList(file.getCanonicalPath().toString(), copyName, copyName); 
				}
			}
		}catch(IOException e){
			log.error(e.getMessage());
		}
	}
}