/**
 * @version 3.2.0.1
 */
package jnit.board.file;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
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
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitboardfileController.java
 * @Description : Jnitboardfile Controller class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitboardfileVO.class)
public class JnitboardfileController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitboardfileService")
    private JnitboardfileService jnitboardfileService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

	/** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String debug = EgovProperties.getProperty("Globals.Debug");
    
    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    
    public static final String SEPERATOR = File.separator;

    @RequestMapping("/board/addFile.do")
    public String ajaxFileUpload(Model model,HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	try {
    		HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);
    		if(debug.equals("true")) log.debug("files : " + list.size() + " , object : " + list );
    		for(int i=0; i<list.size(); i++) {
    			final String thisFile = "file_"+String.valueOf(i);
    			
    			if(list.get(thisFile).getSize() > 0) {
    				if("true".equals(debug)) log.debug("is "+ thisFile);
    	    		EgovFormBasedFileVo vo = list.get(thisFile);
    	
    	    	    String fileUrl = request.getContextPath() 
    	    	    +	"/cms/getFile.do?"
    	    	    + "path=" + vo.getServerSubPath()
    	    	    + "&file=" + vo.getPhysicalName()
    	    	    + "&orgname=" + vo.getFileName();
    	
    	    	    
    	            JnitboardfileVO jnitboardfileVO = new JnitboardfileVO();    	            
    	            jnitboardfileVO.setFileUrl(fileUrl);
    	            jnitboardfileVO.setFilePath(vo.getServerSubPath());
    	            jnitboardfileVO.setFileNm(vo.getPhysicalName());
    	            jnitboardfileVO.setFileOnm(vo.getFileName());
    	            jnitboardfileVO.setExt01("BOARD_EDITOR_TEMP");
    	            jnitboardfileVO.setFileId(jnitboardfileService.insertJnitboardfile(jnitboardfileVO));
    	            
    	            JSONObject jo = new JSONObject();
    	            jo.put("url", fileUrl);
    	            jo.put("filename", vo.getFileName());
    	            jo.put("size", vo.getSize());
    	            jo.put("fileid", jnitboardfileVO.getFileId());
    	            model.addAttribute("json",jo.toJSONString());
    			}
    		}
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e) {
    		log.error(e.getMessage());
    		//
    	}    	

        //resultJson
        return "/jnit/util/json";
    }
    /**
	 * jnitboardfile 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitboardfileDefaultVO
	 * @return "/jnit/tpl-temp/jnitboardfile/JnitboardfileList"
	 * @exception Exception
	 */
    @RequestMapping(value="/jnitboardfile/JnitboardfileList.do")
    public String selectJnitboardfileList(@ModelAttribute("searchVO") JnitboardfileDefaultVO searchVO, 
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
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List jnitboardfileList = jnitboardfileService.selectJnitboardfileList(searchVO);
        model.addAttribute("resultList", jnitboardfileList);
        
        int totCnt = jnitboardfileService.selectJnitboardfileListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/tpl-temp/jnitboardfile/JnitboardfileList";
    } 
    
    @RequestMapping("/jnitboardfile/addJnitboardfileView.do")
    public String addJnitboardfileView(
            @ModelAttribute("searchVO") JnitboardfileDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitboardfileService.getLastIdJnitboardfile());
        model.addAttribute("jnitboardfileVO", new JnitboardfileVO());
        return "/jnit/tpl-temp/jnitboardfile/JnitboardfileRegister";
    }
    
    @RequestMapping("/jnitboardfile/addJnitboardfile.do")
    public String addJnitboardfile(
            @ModelAttribute("searchVO") JnitboardfileDefaultVO searchVO,
	    @ModelAttribute("jnitboardfileVO") JnitboardfileVO jnitboardfileVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitboardfileVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitboardfile/JnitboardfileRegister";
	// }
    	if(jnitboardfileVO != null){
    		jnitboardfileService.insertJnitboardfile(jnitboardfileVO);
            status.setComplete();
    	}
        return "forward:/jnitboardfile/JnitboardfileList.do";
    }
    
    @RequestMapping("/jnitboardfile/updateJnitboardfileView.do")
    public String updateJnitboardfileView(
            @RequestParam("fileId") java.lang.String fileId ,
            @ModelAttribute("searchVO") JnitboardfileDefaultVO searchVO, Model model)
            throws Exception {
        JnitboardfileVO jnitboardfileVO = new JnitboardfileVO();
        jnitboardfileVO.setFileId(fileId);        
        // 변수명은 CoC 에 따라 jnitboardfileVO
        model.addAttribute(selectJnitboardfile(jnitboardfileVO, searchVO));
        return "/jnit/tpl-temp/jnitboardfile/JnitboardfileRegister";
    }

    @RequestMapping("/jnitboardfile/selectJnitboardfile.do")
    public @ModelAttribute("jnitboardfileVO")
    JnitboardfileVO selectJnitboardfile(
            JnitboardfileVO jnitboardfileVO,
            @ModelAttribute("searchVO") JnitboardfileDefaultVO searchVO) throws Exception {
        return jnitboardfileService.selectJnitboardfile(jnitboardfileVO);
    }

    @RequestMapping("/jnitboardfile/updateJnitboardfile.do")
    public String updateJnitboardfile(
            @ModelAttribute("searchVO") JnitboardfileDefaultVO searchVO,
	    @ModelAttribute("jnitboardfileVO") JnitboardfileVO jnitboardfileVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitboardfileVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitboardfile/JnitboardfileRegister";
	// }

        jnitboardfileService.updateJnitboardfile(jnitboardfileVO);
        status.setComplete();
        return "forward:/jnitboardfile/JnitboardfileList.do";
    }
    
    @RequestMapping("/jnitboardfile/deleteJnitboardfile.do")
    public String deleteJnitboardfile(
            JnitboardfileVO jnitboardfileVO,
            @ModelAttribute("searchVO") JnitboardfileDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitboardfileService.deleteJnitboardfile(jnitboardfileVO);
        status.setComplete();
        return "forward:/jnitboardfile/JnitboardfileList.do";
    }

}
