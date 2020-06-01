/**
 * @version 3.2.0.1
 */
package jnit.ebook;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.com.utl.fcc.service.ThumbnailUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.AdminUtil;
import jnit.cms.handler.CmsHandler;
import jnit.com.util.DBType;
import jnit.com.util.FileCopy;
import jnit.ebook.file.JnitebookfileService;
import jnit.ebook.file.JnitebookfileVO;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;
import oracle.sql.CLOB;

/**
 * @Class Name : JnitebookController.java
 * @Description : Jnitebook Controller class
 * @Modification Information
 *
 * @author JNITEBOOK
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitebookVO.class)
public class JnitebookController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitebookService")
    private JnitebookService jnitebookService;
    
    @Resource(name = "jnitebookfileService")
    private JnitebookfileService jnitebookfileService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    private static final String SEPARATOR = File.separator;
    /** 업로드 위치 파일 지정 */    
    private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    private static final String EBOOK_UPLOAD_PATH = uploadDir + SEPARATOR + "ebook";     
    private static final String[] fileDotList = {"bmp","jpeg","gif","png","jpg"};
    /** 업로드 파일 크기 */
    private final long maxfileSize = 1024 * 1024 * 100;
    /** 책자 업로드 파일 크기 */
    private final long maxAjaxFileSize = 1024 * 1024 * 5;
    private static String uploadFileId = "";
    private final static String deDug = EgovProperties.getProperty("Globals.Debug"); 
    public static final String SEPERATOR = File.separator;
    
    /**
	 * JNITEBOOK 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitebookDefaultVO
	 * @return "/jnit/ebook/jnitebook/JnitebookList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/ebook/list.do")
    public String selectJnitebookList(@ModelAttribute("searchVO") JnitebookDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m06110000");
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
		
        List jnitebookList = jnitebookService.selectJnitebookList(searchVO);
        model.addAttribute("resultList", jnitebookList);
        
        int totCnt = jnitebookService.selectJnitebookListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/ebook/ebookList";
    } 
    
    @RequestMapping("/cms/ebook/add.do")
    public String addJnitebookView(
            @ModelAttribute("searchVO") JnitebookDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m06110000");    	
        model.addAttribute("nid",  jnitebookService.getLastIdJnitebook());
        model.addAttribute("jnitebookVO", new JnitebookVO());
        return "/jnit/ebook/ebookStep1";
    }
    
    @RequestMapping("/cms/ebook/addProc.do")
    public String addJnitebook(
            @ModelAttribute("searchVO") JnitebookDefaultVO searchVO,
	    @ModelAttribute("jnitebookVO") JnitebookVO jnitebookVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    MultipartHttpServletRequest mptRequest,
	    ModelMap model,
	    SessionStatus status)
            throws Exception {
    	
        return "forword:/cms/ebook/edit.do";
    }
    
    @RequestMapping("/cms/ebook/edit.do")
    public String updateJnitebookView(HttpServletRequest request
            , Model model)
            throws Exception {
    	
    	AdminUtil.setMenuId("m06110000");
    	String root = PathUtil.getRealPath(request);
        String ebookId = NullUtil.nullString(request.getParameter("ebookId"));
        
        String step = NullUtil.nullString(request.getParameter("step"));
        if("".equals(ebookId) && "1".equals(step)){
        	JnitebookVO jnitebookVO = new JnitebookVO();
        	jnitebookVO.setEbookTitle(NullUtil.nullString(request.getParameter("ebookTitle")));
        	jnitebookVO.setPageWidth(NullUtil.nullInt(request.getParameter("pageWidth")));
        	jnitebookVO.setPageHeight(NullUtil.nullInt(request.getParameter("pageHeight")));
        	jnitebookVO.setThumbYn(NullUtil.nullString(request.getParameter("thumbYn")));
        	jnitebookVO.setThumbAotoHide(NullUtil.nullInt(request.getParameter("thumbAotoHide")));
        	jnitebookVO.setThumbWidth(NullUtil.nullInt(request.getParameter("thumbWidth")));
        	jnitebookVO.setThumbHeight(NullUtil.nullInt(request.getParameter("thumbHeight")));
        	jnitebookVO.setShareLink(NullUtil.nullString(request.getParameter("shareLink")));
        	jnitebookVO.setShareText(NullUtil.nullString(request.getParameter("shareText")));
        	jnitebookVO.setShareVia(NullUtil.nullString(request.getParameter("shareVia")));       	
        	
        	String id = jnitebookService.insertJnitebook(jnitebookVO);
        	String upPath = getUpPath(request, id);
        	//파일 복사
        	makeEbookDir(request, id);
        	
        	//index.html 생성
        	if(!makeIndexFile(upPath, jnitebookVO, request)){
        		jnitebookVO.setEbookId(id);
        		jnitebookVO.setIsdelYn("N");
        		jnitebookService.deleteJnitebook(jnitebookVO);
        		String deleteEbookDir = EBOOK_UPLOAD_PATH + SEPARATOR + id;
        		if(StringUtil.isExistString(request.getRequestURL().toString(), "local")) deleteEbookDir =  root+"/upload/ebook/"+id;
        		
        		deleteFile(deleteEbookDir);
        		model.addAttribute("alert", "기본파일생성에 오류가 발생하였습니다.");
                model.addAttribute("path", "/cms/ebook/add.do");
                return "/jnit/util/alertMove";
        	}
        	ebookId = id;
        }        
        JnitebookVO jnitebookVO = new JnitebookVO();
        jnitebookVO.setEbookId(ebookId);
        jnitebookVO = jnitebookService.selectJnitebook(jnitebookVO);
        
        HashMap<String, JnitebookfileVO> contentVOMap = new HashMap<String, JnitebookfileVO>();        
        JSONObject JSON = new JSONObject();
        
        JnitebookfileVO coverFileVO = new JnitebookfileVO();
        coverFileVO.setEbookFileId(ebookId);
        coverFileVO.setPageYn("N");
        coverFileVO.setOrderbyCondition("1");
        coverFileVO.setSearchCondition("3");
        List fileList = jnitebookfileService.selectJnitebookfileList(coverFileVO);
        
        JSON = mapJSON(fileList);
        HashMap<String, String> fileNmMap = (HashMap<String, String>) JSON.toBean((JSONObject) JSON.get("fileNmMap"), HashMap.class);
        HashMap<String, String> fileNm2Map = (HashMap<String, String>) JSON.toBean((JSONObject) JSON.get("fileNm2Map"), HashMap.class);
        HashMap<String, String> htmlFileNmMap = (HashMap<String, String>) JSON.toBean((JSONObject) JSON.get("htmlFileNmMap"), HashMap.class);
        JSON = new JSONObject().fromObject(JSON.get("contentVOMap"));
        Iterator itr = JSON.keys();
        while (itr.hasNext()) {
			String key = (String) itr.next();
			JnitebookfileVO fileVO = (JnitebookfileVO) JSON.toBean((JSONObject) JSON.get(key), JnitebookfileVO.class);
			contentVOMap.put(key, fileVO);			
		}
        coverFileVO.setSearchCondition("4");        
        List uploadFileList = jnitebookfileService.selectJnitebookfileList(coverFileVO);
        JSON = mapJSON(uploadFileList);        
        HashMap<String, String> upFileNmMap = (HashMap<String, String>) JSON.toBean((JSONObject) JSON.get("upFileNmMap"), HashMap.class);
        
        model.addAttribute("htmlFileNmMap", htmlFileNmMap);
        model.addAttribute("upFileNmMap", upFileNmMap);
        model.addAttribute("uploadAddFields", uploadFileList.size());
        model.addAttribute("uploadFileList", uploadFileList);
        model.addAttribute("fileNm2Map", fileNm2Map);
        model.addAttribute("fileNmMap", fileNmMap);
        model.addAttribute("root", root);
        model.addAttribute("contentVOMap", contentVOMap);
        model.addAttribute("fileList", fileList);
        model.addAttribute("countAddFields", fileList.size());
        model.addAttribute("jnitebookVO", jnitebookVO);        
        return "/jnit/ebook/ebookEdit";
    }

    @RequestMapping("/jnitebook/selectJnitebook.do")
    public @ModelAttribute("jnitebookVO")
    JnitebookVO selectJnitebook(
            JnitebookVO jnitebookVO,
            @ModelAttribute("searchVO") JnitebookDefaultVO searchVO) throws Exception {
        return jnitebookService.selectJnitebook(jnitebookVO);
    }

    @RequestMapping("/cms/ebook/editProc.do")
    public String updateJnitebook(
            @ModelAttribute("searchVO") JnitebookDefaultVO searchVO,
	    @ModelAttribute("jnitebookVO") JnitebookVO jnitebookVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    MultipartHttpServletRequest mptRequest,
	    ModelMap model,
	    SessionStatus status)
            throws Exception {    	
    	String id = jnitebookVO.getEbookId();    	
    	
    	String upPath = getUpPath(mptRequest, id);
    	//기본파일 생성
    	makeEbookDir(mptRequest, id);
    	//index파일 생성
    	if(!makeIndexFile(upPath, jnitebookVO, request)){
    		model.addAttribute("alert", "기본파일생성에 오류가 발생하였습니다.");
            model.addAttribute("path", "/cms/ebook/edit.do?ebookId="+jnitebookVO.getEbookId());
            return "/jnit/util/alertMove";
    	}
    	//모바일 폴더가 없을경우 새로 생성
    	java.io.File MoFile = new File(upPath+SEPERATOR+"mobile");
    	if (! MoFile.exists()) {
    		MoFile.mkdirs();
    		JnitebookfileVO fileVO = new JnitebookfileVO();
        	fileVO.setEbookFileId(id);
        	fileVO.setPageYn("N");
    		fileVO.setOrderbyCondition("1");
    		
    		List fileLsit = jnitebookfileService.selectJnitebookfileList(fileVO);
        	Iterator fileIterator = fileLsit.iterator();
        	StringBuffer sb = new StringBuffer();
        	for(int i=0; i<fileLsit.size(); i++){
        		try{
	        		EgovMap fileEgovMap = (EgovMap) fileIterator.next();
	    			String backgroundFileNm = NullUtil.nullString(String.valueOf(fileEgovMap.get("fileNm")));
    			
        			String filePath = NullUtil.nullString(String.valueOf(fileEgovMap.get("filePath")));
                	
        			java.io.File file = new File(upPath+SEPERATOR+filePath+SEPERATOR+backgroundFileNm);
            		ThumbnailUtil.createThumbnail(file.getPath(), upPath+SEPERATOR+"mobile"+SEPERATOR+backgroundFileNm, 450, 637);
        		} catch (NullPointerException e){
        			log.error(e.getMessage());
            	}catch (Exception e) {
            		log.error(e.getMessage());
				}
    			
        	}
    		
    	}
    	
    	//height,width 값이 다르면, 파일들을 수정된 값으로 다시 저장한다.
    	JnitebookVO jnitebookVO_old = new JnitebookVO();
    	jnitebookVO_old = jnitebookService.selectJnitebook(jnitebookVO);
    	if((jnitebookVO.getPageHeight()!=jnitebookVO_old.getPageHeight())||((jnitebookVO.getPageWidth()!=jnitebookVO_old.getPageWidth()))){
    		JnitebookfileVO coverFileVO = new JnitebookfileVO();
            coverFileVO.setEbookFileId(id);
            coverFileVO.setPageYn("N");
            coverFileVO.setOrderbyCondition("1");
            coverFileVO.setSearchCondition("3");
            List fileList = jnitebookfileService.selectJnitebookfileList(coverFileVO);
            Iterator fileItr = fileList.iterator();
            while(fileItr.hasNext()){
            	try{
                	EgovMap fileEgovMap = (EgovMap)fileItr.next();
                	String backgroundFileNm = NullUtil.nullString(String.valueOf(fileEgovMap.get("fileNm")));
        			String filePath = NullUtil.nullString(String.valueOf(fileEgovMap.get("filePath")));
                	
        			java.io.File file = new File(upPath+SEPERATOR+filePath+SEPERATOR+backgroundFileNm);
            		int width = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageWidth()));
                	int height = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageHeight()));
                	ThumbnailUtil.createThumbnail(file.getPath(), file.getPath(), width, height);
            	} catch (NullPointerException e){
        			log.error(e.getMessage());
            	}catch (Exception e) {
            		log.error(e.getMessage());
				}
            }
    	}
    	
    	if((jnitebookVO.getThumbHeight()!=jnitebookVO_old.getThumbHeight())||((jnitebookVO.getThumbWidth()!=jnitebookVO_old.getThumbWidth()))){
    		JnitebookfileVO coverFileVO = new JnitebookfileVO();
            coverFileVO.setEbookFileId(id);
            coverFileVO.setPageYn("N");
            coverFileVO.setOrderbyCondition("1");
            coverFileVO.setSearchCondition("3");
            List fileList = jnitebookfileService.selectJnitebookfileList(coverFileVO);
            Iterator fileItr = fileList.iterator();
            while(fileItr.hasNext()){
            	try{
                	EgovMap fileEgovMap = (EgovMap)fileItr.next();
                	String thumbnailFileNm = NullUtil.nullString(String.valueOf(fileEgovMap.get("fileNm2")));
        			String filePath2 = NullUtil.nullString(String.valueOf(fileEgovMap.get("filePath2")));
        			
        			java.io.File file = new File(upPath+SEPERATOR+filePath2+SEPERATOR+thumbnailFileNm);
            		int width = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageWidth()));
                	int height = NullUtil.nullInt(Integer.toString(jnitebookVO.getPageHeight()));
                	ThumbnailUtil.createThumbnail(file.getPath(), file.getPath(), width, height);
            	} catch (NullPointerException e){
        			log.error(e.getMessage());
            	}catch (Exception e) {
            		log.error(e.getMessage());
				}
            }
    	}
    	
    	try {
    		//각 파일 업데이트
        	updateFiles(request, id, upPath);
    	} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}   	
    	try {
    		//업로드 파일 업데이트
        	uploadFiles(request, id, upPath, jnitebookVO);
    	} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
    	//MeetpageFlip 생성
    	StringBuffer sb = new StringBuffer();    	
    	sb = makeStringBufferFile(mptRequest, id, upPath);
    	makeMeetpageFlipFile(upPath, sb);
    	
    	sb = makeStringBufferFileMobile(mptRequest, id, upPath);
    	makeMobileMeetpageFlipFile(upPath, sb);
    	
    	jnitebookVO.setExt01(NullUtil.nullString(request.getParameter("countAddFields")));    	
        jnitebookService.updateJnitebook(jnitebookVO);
        
        
        model.addAttribute("alert", "정상처리되었습니다.");
        model.addAttribute("path", "/cms/ebook/list.do");
        return "/jnit/util/alertMove";
    }
    
    @RequestMapping("/ebook/delete.do")
    public String deleteJnitebook(
            JnitebookVO jnitebookVO,
            @ModelAttribute("searchVO") JnitebookDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitebookService.deleteJnitebook(jnitebookVO);
        status.setComplete();
        return "forward:/cms/ebook/list.do";
    }
    
    @RequestMapping("/cms/ebook/file/delete/ajax.do")
    public String ebookfileDetateAjax(HttpServletRequest request, ModelMap model)throws Exception{
    	String fileId = NullUtil.nullString(request.getParameter("fileId"));
    	String type = NullUtil.nullString(request.getParameter("type"));
    	
    	JnitebookfileVO fileVO = new JnitebookfileVO();
    	fileVO.setFileId(fileId);
    	fileVO = jnitebookfileService.selectJnitebookfile(fileVO);
    	String upPath = getUpPath(request, fileVO.getEbookFileId());
    	
    	JSONObject json = new JSONObject();
    	if("file".equals(type)){
    		try {
        		//background
            	String backgroundFileDir = upPath+"/backgroundFile/"+fileVO.getFileNm();
            	deleteFile(backgroundFileDir);
            	String backgroundOriginDir = upPath+"/backgroundFile/origin/"+fileVO.getFileNm();   
            	deleteFile(backgroundOriginDir);
            	
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
        	} catch (Exception e) {
        		log.error(e.getMessage());
    		}
        	try {
        		//썸네일
            	String thumbnailFileDir = upPath+"/thumbnailFile/"+fileVO.getFileNm2();
            	deleteFile(thumbnailFileDir);
            	String thumbnailOriginDir = upPath+"/thumbnailFile/origin/"+fileVO.getFileNm2();
            	deleteFile(thumbnailOriginDir);
        	} catch (NullPointerException e){
    			log.error(e.getMessage());
    		} catch (Exception e) {
    			log.error(e.getMessage());
    		}
    		try {
        		//모바일
        		String mobileDir = upPath+"/mobile/"+fileVO.getFileNm();   
            	deleteFile(mobileDir);
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
    		} catch (Exception e) {
    			log.error(e.getMessage());
    		}
    		try {
        		//html 파일
            	String htmlFileDir = upPath+"/htmlFile/"+fileVO.getFileHtmlNm();
            	deleteFile(htmlFileDir);
            	String htmlOriginDir = upPath+"/htmlFile/origin/"+fileVO.getFileHtmlNm();
            	deleteFile(htmlOriginDir);
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
    		} catch (Exception e) {
    			log.error(e.getMessage());
    		}
    	}else{
    		try {
        		//업로드파일
            	String uploadFileDir = upPath+"/uploadFile/"+fileVO.getFileNm();
            	deleteFile(uploadFileDir);
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
    		} catch (Exception e) {
    			log.error(e.getMessage());
    		}
    	}    	
		try {
			jnitebookfileService.deleteJnitebookfile(fileVO);
			if("file".equals(type)){
				StringBuffer sb = new StringBuffer();
				sb = makeStringBufferFile(request, fileVO.getEbookFileId(), upPath);
				makeMeetpageFlipFile(upPath, sb);
				
				sb = makeStringBufferFileMobile(request, fileVO.getEbookFileId(), upPath);
				makeMobileMeetpageFlipFile(upPath, sb);
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			json.put("status", "error");
			json.put("message", "오류가 발생하여 삭제하지 못하였습니다.");
			model.addAttribute("json", json.toString());
	    	return "/jnit/util/json";
		} catch (Exception e) {
			log.error(e.getMessage());
			json.put("status", "error");
			json.put("message", "오류가 발생하여 삭제하지 못하였습니다.");
			model.addAttribute("json", json.toString());
	    	return "/jnit/util/json";
		}
		json.put("status", "success");
		json.put("message", "삭제가 정상처리되었습니다.");
		model.addAttribute("json", json.toString());
    	return "/jnit/util/json";
    }
    
    @RequestMapping("/cms/ebook/popup.do")
    public String ebookPopup(@ModelAttribute("jnitebookfileVO") JnitebookfileVO jnitebookfileVO
    		, HttpServletRequest request
    		, ModelMap model)throws Exception{
    	String fileId = NullUtil.nullString(request.getParameter("fileId"));
    	String type = NullUtil.nullString(request.getParameter("type"));
    	String mode = NullUtil.nullString(request.getParameter("mode"));
    	String content = NullUtil.nullString(request.getParameter("ebookContent"));    	
    	if("".equals(mode)) mode = "list";
    	
    	JSONObject JSON = new JSONObject();    	
    	JnitebookfileVO fileVO = new JnitebookfileVO();
    	fileVO.setFileId(fileId);
    	try {
    		fileVO = jnitebookfileService.selectJnitebookfile(fileVO);
    		String upPath = getUpPath(request, fileVO.getEbookFileId());
    		
    		String fileDir = upPath + "/" + type + "/" + fileVO.getFileNm();
    		if("htmlFile".equals(type)) fileDir = upPath + "/" + type + "/" + fileVO.getFileHtmlNm();
    		if("thumbnailFile".equals(type)) fileDir = upPath + "/" + type + "/" + fileVO.getFileNm2();
    			
    		if("".equals(content)){
    			content = CmsHandler.readFile(fileDir);
    		}else{
    			content = CmsHandler.writeFile(fileDir, content);
    			JSON.put("status", "success");
    		}
    	} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			 log.error(e.getMessage());
		}
		
		model.addAttribute("type", type);
		model.addAttribute("json", JSON.toString());
		model.addAttribute("jnitebookfileVO", fileVO);
		model.addAttribute("content", content);
		
		if("proc".equals(mode)){ //저장
			return "/jnit/util/json";
		}else{ //list
			return "/jnit/ebook/ebookPopup";
		}
    }
    
    @RequestMapping("/cms/ebook/importCode.do")
    public String ebookImportCode()throws Exception{    	
    	return "/jnit/ebook/importCode";
    }
    
    @RequestMapping("/ebook/load/file.do")
    public String uploadFileAjax(@ModelAttribute("jnitebookVO") JnitebookVO jnitebookVO
    		, HttpServletRequest request, ModelMap model)throws Exception{
    	
    	String num = NullUtil.nullString(request.getParameter("num"));
    	String name = NullUtil.nullString(request.getParameter("name"));
    	
    	String fileId = NullUtil.nullString(request.getParameter("fileId"));    	
    	String upPath = getUpPath(request, NullUtil.nullString(jnitebookVO.getEbookId()));
    	String path = "";
    	String fileType = "";
    	JSONObject JSON = new JSONObject();
    	jnitebookVO = jnitebookService.selectJnitebook(jnitebookVO);
    	
    	JSON.put("name", name);
    	JSON.put("num", num);
    	try {
    		//파일 업로드
    		String status = ajaxUploadFiles(request, name, upPath, num, jnitebookVO);
    		if("maxSizeError".equals(status)){
    			JSON.put("status", "error");
    			JSON.put("code", "FAIL 1");
    			model.addAttribute("json", JSON.toString());
    			return "/jnit/util/json";
    		}else if("imgTypeError".equals(status)){
    			JSON.put("status", "error");
    			JSON.put("code", "FAIL 2");
    			model.addAttribute("json", JSON.toString());
    			return "/jnit/util/json";
    		}
    	} catch (NullPointerException e){
    		log.error(e.getMessage());
			JSON.put("status", "error");
			model.addAttribute("json", JSON.toString());
	    	return "/jnit/util/json";
		} catch (Exception e) {
			log.error(e.getMessage());
			JSON.put("status", "error");
			model.addAttribute("json", JSON.toString());
	    	return "/jnit/util/json";
		}
		try {
    		StringBuffer sb = new StringBuffer();
        	sb = makeStringBufferFile(request, jnitebookVO.getEbookId(), upPath);
        	//html파일생성
        	makeMeetpageFlipFile(upPath, sb);
        	
        	sb = makeStringBufferFileMobile(request, jnitebookVO.getEbookId(), upPath);
        	makeMobileMeetpageFlipFile(upPath, sb);
		} catch (NullPointerException e){
			log.error(e.getMessage());
			JSON.put("status", "error");
			model.addAttribute("json", JSON.toString());
	    	return "/jnit/util/json";
		} catch (Exception e) {
			log.error(e.getMessage());
			JSON.put("status", "error");
			model.addAttribute("json", JSON.toString());
	    	return "/jnit/util/json";
		}
    	
    	JnitebookfileVO fileVO = new JnitebookfileVO();
    	fileId = "".equals(fileId) ? uploadFileId : fileId;
    	fileVO.setFileId(fileId);
    	fileVO = jnitebookfileService.selectJnitebookfile(fileVO);
    	
    	if(name.indexOf("background") > -1) {
    		path = fileVO.getBackgroundFile();
    		fileType = isThumbnailFile(fileVO.getFileNm()) ? "img" : "file";    		
    		JSON.put("fileNm", fileVO.getFileNm());
    		JSON.put("subPath", fileVO.getFilePath());
    	}
    	if(name.indexOf("thumb") > -1) {
    		path = fileVO.getThumbnailImage();
    		fileType = isThumbnailFile(fileVO.getFileNm2()) ? "img" : "file";    	
    		JSON.put("fileNm", fileVO.getFileNm2());
    		JSON.put("subPath", fileVO.getFilePath2());
    	}
    	
    	if(name.indexOf("Html") > -1) {
    		path = fileVO.getHtmlFile();
    		fileType = isThumbnailFile(fileVO.getFileHtmlNm()) ? "img" : "file";    		
    		JSON.put("fileNm", fileVO.getFileHtmlNm());
    		JSON.put("subPath", fileVO.getFileHtmlPath());
    	}
    	
    	JSON.put("fileId", fileId);
    	JSON.put("fileType", fileType);
    	JSON.put("status", "success");
    	JSON.put("path", path);    	
    	model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }   
    
   /**
    * 책자 파일등록 파일들을 업데이트 한다.
    * @param request
    * @param id - ebookId
    * @param upPath -  실제파일경로
    * @throws Exception
    * {@link JnitebookController#updateJnitebook}
    */
	private void updateFiles(HttpServletRequest request, String id, String upPath)throws Exception{
    	int countAddFields = NullUtil.nullInt(request.getParameter("countAddFields"));
    	
    	Boolean firsetIn = false;
    	if(countAddFields > 0){
    		for(int i=0; i<countAddFields; i++){
    			String num = String.valueOf((i+1));    			
    			JnitebookfileVO fileVO = new JnitebookfileVO();
    			String step1 =  NullUtil.nullString(request.getParameter("step1_"+num));    			    			
    			String disableEmbossing = NullUtil.nullString(request.getParameter("disableEmbossing"+num));
    			String transparentPage = NullUtil.nullString(request.getParameter("transparentPage"+num));
    			String pageNumber = NullUtil.nullString(request.getParameter("pageNumber"+num));
    			String pageName = NullUtil.nullString(request.getParameter("pageName"+num));
    			String pageLabel = NullUtil.nullString(request.getParameter("pageLabel"+num));
    			String data = NullUtil.nullString(request.getParameter("data"+num));
    			String dataUnload = NullUtil.nullString(request.getParameter("dataUnload"+num));
    			String content = NullUtil.nullString(request.getParameter("content"+num));    			
    			String fileId = NullUtil.nullString(request.getParameter("fileId"+num));
    			int mode = NullUtil.nullInt(request.getParameter("ext02"));
    			
    			String fileClass = "";
    			if(!"".equals(step1)){
    				fileVO.setEbookFileId(id);
    				fileVO.setFileType(step1);
    				if(!firsetIn){
    					fileClass = mode == 1 ? "outerpage" : "page";
    					fileVO.setFileClass(fileClass);
    					firsetIn = true;
    				}else{
    					fileClass = "page";
    					fileVO.setFileClass(fileClass);
    				}
    				fileVO.setDisableEmbossing(disableEmbossing);
    				fileVO.setTransparentPage(transparentPage);
    				fileVO.setPageNumber(pageNumber);
    				fileVO.setPageName(pageName);
    				fileVO.setDataUnload(dataUnload);
    				if("img".equals(step1)){
    					fileVO.setUpdateCondition("0");
    				}if("html".equals(step1)){
    					fileVO.setUpdateCondition("3");
    				}else if("user".equals(step1)){
    					fileVO.setContent(content);
    					fileVO.setUpdateCondition("4");
    				}
    				if("".equals(fileId)){
    					jnitebookfileService.insertJnitebookfile(fileVO);
    				}else{
    					fileVO.setFileId(fileId);
    					if("3".equals(fileVO.getUpdateCondition())){
    						dummyFileDelete(upPath, fileId, fileVO, "background");//파일은 삭제
    					}else if("4".equals(fileVO.getUpdateCondition())){
    						dummyFileDelete(upPath, fileId, fileVO, "background");//파일은 삭제
    						dummyFileDelete(upPath, fileId, fileVO, "html");//파일은 삭제
    					}else{
    						dummyFileDelete(upPath, fileId, fileVO, null);//수정건 파일은 삭제
    						dummyFileDelete(upPath, fileId, fileVO, "html");//파일은 삭제
    					}
    					jnitebookfileService.updateJnitebookfile(fileVO);
    				}
    			}
    		}
    	}
    }
	/**
	 * 책차 파일 등록의 div의 옵션들을 제어한다.
	 * @param request
	 * @param id - ebookId
	 * @param upPath - 업로드 실제경로
	 * @return StringBuffer - div 값
	 * @throws Exception
	 * {@link JnitebookController#updateJnitebook}
	 * {@link JnitebookController#ebookfileDetateAjax}
	 * {@link JnitebookController#uploadFileAjax}
	 */
    private StringBuffer makeStringBufferFile(HttpServletRequest request, String id, String upPath)throws Exception{
    	JnitebookfileVO fileVO = new JnitebookfileVO();
    	fileVO.setEbookFileId(id);
    	fileVO.setPageYn("N");
		fileVO.setOrderbyCondition("1");
		
		List fileLsit = jnitebookfileService.selectJnitebookfileList(fileVO);
    	Iterator fileIterator = fileLsit.iterator();
    	StringBuffer sb = new StringBuffer();
    	for(int i=0; i<fileLsit.size(); i++){
    		EgovMap fileEgovMap = (EgovMap) fileIterator.next();
    		String fileClass =  NullUtil.nullString(String.valueOf(fileEgovMap.get("fileClass")));
			String htmlFile =  NullUtil.nullString(String.valueOf(fileEgovMap.get("htmlFile")));
			String disableEmbossing = NullUtil.nullString(String.valueOf(fileEgovMap.get("disableEmbossing")));
			String transparentPage = NullUtil.nullString(String.valueOf(fileEgovMap.get("transparentPage")));
			String dataUnload = NullUtil.nullString(request.getParameter(String.valueOf(fileEgovMap.get("dataUnload"))));
			String backgroundFileNm = NullUtil.nullString(String.valueOf(fileEgovMap.get("fileNm")));
			String thumbnailFileNm = NullUtil.nullString(String.valueOf(fileEgovMap.get("fileNm2")));
			
			if(!fileClass.equals("")){
				sb.append("<div class=\""+fileClass+"\" "
						+(!"".equals(htmlFile) ? "data-html-file=\""+htmlFile+"\" " : "")
						+(!"".equals(backgroundFileNm) ? "data-background-file=\"backgroundFile/"+backgroundFileNm+"\" " : "")
						+(!"false".equals(disableEmbossing) ? "data-disable-embossing=\""+disableEmbossing+"\" " : "" )
						+(!"false".equals(transparentPage) ? "data-transparent-page=\""+transparentPage+"\" " : "")	
						+(!"".equals(thumbnailFileNm) ? "data-thumbnail-image=\"thumbnailFile/"+thumbnailFileNm+"\" " : "")
						+(!"".equals(dataUnload) ? "data-unload=\""+dataUnload+"\" " : "")
						+">\r\n");
				if(DBType.getDbTypeBoolean("oracle")){
					CLOB content =  (CLOB) fileEgovMap.get("content");
					StringBuffer resultContent = new StringBuffer();
					
					if(content != null){
						 Reader reader = content.getCharacterStream();
						 BufferedReader br = new BufferedReader(reader);				 				 
						 String line = "";
						 while ((line = br.readLine()) != null) {
							resultContent.append(line+"\r\n");
						 }				 
						 br.close();
					}
					if(!"".equals(resultContent.toString())){
						sb.append(resultContent.toString()+"\r\n");
					}
				}else if(DBType.getDbTypeBoolean("tibero")){
					com.tmax.tibero.jdbc.TbClob content =  (com.tmax.tibero.jdbc.TbClob) fileEgovMap.get("content");
					StringBuffer resultContent = new StringBuffer();
					
					if(content != null){
						 Reader reader = content.getCharacterStream();
						 BufferedReader br = new BufferedReader(reader);				 				 
						 String line = "";
						 while ((line = br.readLine()) != null) {
							resultContent.append(line+"\r\n");
						 }				 
						 br.close();
					}
					if(!"".equals(resultContent.toString())){
						sb.append(resultContent.toString()+"\r\n");
					}
				}else if(DBType.getDbTypeBoolean("cubrid")){
					String content = NullUtil.nullString(String.valueOf(fileEgovMap.get("content")));
					if(!"".equals(content)) sb.append(content);
				}
				sb.append("</div>");
			
			}
    	}
    	return sb;
    }
    
    /**
	 * 모바일 버전용 책차 파일 등록의 div의 옵션들을 제어한다.
	 * @param request
	 * @param id - ebookId
	 * @param upPath - 업로드 실제경로
	 * @return StringBuffer - div 값
	 * @throws Exception
	 * {@link JnitebookController#updateJnitebook}
	 * {@link JnitebookController#ebookfileDetateAjax}
	 * {@link JnitebookController#uploadFileAjax}
	 */
    private StringBuffer makeStringBufferFileMobile(HttpServletRequest request, String id, String upPath)throws Exception{
    	JnitebookfileVO fileVO = new JnitebookfileVO();
    	fileVO.setEbookFileId(id);
    	fileVO.setPageYn("N");
		fileVO.setOrderbyCondition("1");
		
		List fileLsit = jnitebookfileService.selectJnitebookfileList(fileVO);
    	Iterator fileIterator = fileLsit.iterator();
    	StringBuffer sb = new StringBuffer();
    	for(int i=0; i<fileLsit.size(); i++){
    		EgovMap fileEgovMap = (EgovMap) fileIterator.next();
    		String fileClass =  NullUtil.nullString(String.valueOf(fileEgovMap.get("fileClass")));
			String htmlFile =  NullUtil.nullString(String.valueOf(fileEgovMap.get("htmlFile")));
			String disableEmbossing = NullUtil.nullString(String.valueOf(fileEgovMap.get("disableEmbossing")));
			String transparentPage = NullUtil.nullString(String.valueOf(fileEgovMap.get("transparentPage")));
			String dataUnload = NullUtil.nullString(request.getParameter(String.valueOf(fileEgovMap.get("dataUnload"))));
			String backgroundFileNm = NullUtil.nullString(String.valueOf(fileEgovMap.get("fileNm")));
			String thumbnailFileNm = NullUtil.nullString(String.valueOf(fileEgovMap.get("fileNm2")));
			if(!fileClass.equals("")){
				sb.append("<div class=\""+fileClass+"\" "
						+(!"".equals(htmlFile) ? "data-html-file=\""+htmlFile+"\" " : "")
						+(!"".equals(backgroundFileNm) ? "data-background-file=\"mobile/"+backgroundFileNm+"\" " : "")
						+(!"false".equals(disableEmbossing) ? "data-disable-embossing=\""+disableEmbossing+"\" " : "" )
						+(!"false".equals(transparentPage) ? "data-transparent-page=\""+transparentPage+"\" " : "")	
						+(!"".equals(thumbnailFileNm) ? "data-thumbnail-image=\"thumbnailFile/"+thumbnailFileNm+"\" " : "")
						+(!"".equals(dataUnload) ? "data-unload=\""+dataUnload+"\" " : "")
						+">\r\n");
				if(DBType.getDbTypeBoolean("oracle")){
					CLOB content =  (CLOB) fileEgovMap.get("content");
					StringBuffer resultContent = new StringBuffer();
					
					if(content != null){
						 Reader reader = content.getCharacterStream();
						 BufferedReader br = new BufferedReader(reader);				 				 
						 String line = "";
						 while ((line = br.readLine()) != null) {
							resultContent.append(line+"\r\n");
						 }				 
						 br.close();
					}
					if(!"".equals(resultContent.toString())){
						sb.append(resultContent.toString()+"\r\n");
					}
				}else if(DBType.getDbTypeBoolean("tibero")){
					com.tmax.tibero.jdbc.TbClob content =  (com.tmax.tibero.jdbc.TbClob) fileEgovMap.get("content");
					StringBuffer resultContent = new StringBuffer();
					
					if(content != null){
						 Reader reader = content.getCharacterStream();
						 BufferedReader br = new BufferedReader(reader);				 				 
						 String line = "";
						 while ((line = br.readLine()) != null) {
							resultContent.append(line+"\r\n");
						 }				 
						 br.close();
					}
					if(!"".equals(resultContent.toString())){
						sb.append(resultContent.toString()+"\r\n");
					}
				}else if(DBType.getDbTypeBoolean("cubrid")){
					String content = NullUtil.nullString(String.valueOf(fileEgovMap.get("content")));
					if(!"".equals(content)) sb.append(content);
				}
				sb.append("</div>");
			}
    	}
    	return sb;
    }
    
    /**
     * 임의 파일관리 파일들을 제어한다.
     * @param request
     * @param id - ebookId
     * @param upPath - 업로드 실제경로
     * @param jnitebookVO
     * @return StringBuffer - div 값
     * @throws Exception
     * {@link JnitebookController#updateJnitebook}
     */
    public StringBuffer uploadFiles(HttpServletRequest request, String id, String upPath, JnitebookVO jnitebookVO)throws Exception{
    	StringBuffer sb = new StringBuffer();
    	HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadEbookFiles(request, upPath, maxfileSize, jnitebookVO);
    	int uploadAddFields = NullUtil.nullInt(request.getParameter("uploadAddFields"));
    	
    	if(uploadAddFields > 0){
    		for(int i=0; i<uploadAddFields; i++){
    			String num = String.valueOf(i+1);
    			if(list.get("uploadFile"+num) != null){    			
        			EgovFormBasedFileVo vo = list.get("uploadFile"+num);
        			String fileId = NullUtil.nullString(request.getParameter("uploadFileId"+num));
        			JnitebookfileVO fileVO = new JnitebookfileVO();
        			fileVO.setEbookFileId(id);
        			fileVO.setFileNm(vo.getPhysicalName());
        			fileVO.setFilePath(vo.getServerSubPath());
        			fileVO.setUploadFile("/cms/getFile.do?path="+vo.getServerSubPath()+"&file="+vo.getPhysicalName()+"&orgname="+vo.getPhysicalName()+"&ebookId="+jnitebookVO.getEbookId());
        			if("".equals(fileId)){
        				jnitebookfileService.insertJnitebookfile(fileVO);
        			}else{
        				fileVO.setFileId(fileId);
        				fileVO.setUpdateCondition("2");
        				dummyFileDelete(upPath, fileId, fileVO, null); //수정건 파일은 삭제
        				jnitebookfileService.updateJnitebookfile(fileVO);
        			}
    			}
    		}
    	}
    	return sb;
    }
    
    /**
     * 파일 선택시 바로 업로드를 제어한다.
     * @param request
     * @param upPath - 업로드 기본 경로
     * @param num - 순서
     * @param jnitebookVO
     * @throws Exception
     * {@link JnitebookController#uploadFileAjax}
     */
    public String ajaxUploadFiles(HttpServletRequest request, String inputFileName, String upPath, String num, JnitebookVO jnitebookVO)throws Exception{
    	String status = "";
    	HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFileName(request, inputFileName, upPath, maxAjaxFileSize, jnitebookVO);
    	
    	if(list.get("maxSizeError") != null){
    		status = "maxSizeError";
    		return status;
    	}
    	if(list.get("imgTypeError") != null){    		
    		status = "imgTypeError";
    		return status;
    	}
		EgovFormBasedFileVo backgroundVO = list.get("upbackgroundFile"+num);
		EgovFormBasedFileVo thumbnailVO = list.get("upthumbnailFile"+num);
		EgovFormBasedFileVo htmlVO = list.get("upHtmlFile"+num);
		
		JnitebookfileVO fileVO = new JnitebookfileVO();
		
		String step1 =  NullUtil.nullString(request.getParameter("step1_"+num));
		String disableEmbossing = NullUtil.nullString(request.getParameter("disableEmbossing"+num));
		String transparentPage = NullUtil.nullString(request.getParameter("transparentPage"+num));
		String dataUnload = NullUtil.nullString(request.getParameter("dataUnload"+num));
		String content = NullUtil.nullString(request.getParameter("content"+num));	
		String mode = NullUtil.nullString(request.getParameter("ext02"));
		int index = NullUtil.nullInt(request.getParameter("index"));
		String fileId = NullUtil.nullString(request.getParameter("fileId"+num));
		if("".equals(fileId)) fileId= NullUtil.nullString(request.getParameter("fileId"));
		String fileClass = "page";
		
		fileVO.setEbookFileId(jnitebookVO.getEbookId());
		fileVO.setFileType(step1);
		if("0".equals(mode)) fileClass =  index == 0 ? "outerpage" : "page";
		fileVO.setFileClass(fileClass);
			
		if(list.get("upbackgroundFile"+num) != null){
			fileVO.setBackgroundFile("/cms/getFile.do?path="+backgroundVO.getServerSubPath()+"&file="+backgroundVO.getPhysicalName()+"&orgname="+backgroundVO.getPhysicalName()+"&ebookId="+jnitebookVO.getEbookId());
			fileVO.setFileNm(backgroundVO.getPhysicalName());
			fileVO.setFilePath(backgroundVO.getServerSubPath());
			
			if(isThumbnailFile(backgroundVO.getPhysicalName())){
				fileVO.setThumbnailImage("/cms/getFile.do?path=thumbnailFile&file="+backgroundVO.getPhysicalName()+"&orgname="+backgroundVO.getPhysicalName()+"&ebookId="+jnitebookVO.getEbookId());
				fileVO.setFileNm2(backgroundVO.getPhysicalName());
				fileVO.setFilePath2("thumbnailFile");
			}
		}
		
		if(list.get("upthumbnailFile"+num) != null){
			fileVO.setThumbnailImage("/cms/getFile.do?path="+thumbnailVO.getServerSubPath()+"&file="+thumbnailVO.getPhysicalName()+"&orgname="+thumbnailVO.getPhysicalName()+"&ebookId="+jnitebookVO.getEbookId());
			fileVO.setFileNm2(thumbnailVO.getPhysicalName());
			fileVO.setFilePath2(thumbnailVO.getServerSubPath());
		}
		
		if(list.get("upHtmlFile"+num) != null){
			fileVO.setHtmlFile("/cms/getFile.do?path="+htmlVO.getServerSubPath()+"&file="+htmlVO.getPhysicalName()+"&orgname="+htmlVO.getPhysicalName()+"&ebookId="+jnitebookVO.getEbookId());
			fileVO.setFileHtmlNm(htmlVO.getPhysicalName());
			fileVO.setFileHtmlPath(htmlVO.getServerSubPath());
		}
		if("img".equals(step1)){
			fileVO.setUpdateCondition("0");
		}if("html".equals(step1)){
			fileVO.setUpdateCondition("3");
		}else if("user".equals(step1)){
			fileVO.setContent(content);
			fileVO.setUpdateCondition("4");
		}
		fileVO.setDisableEmbossing(disableEmbossing);
		fileVO.setTransparentPage(transparentPage);		
		fileVO.setDataUnload(dataUnload);
		if("".equals(fileId)){
			uploadFileId = jnitebookfileService.insertJnitebookfile(fileVO);			
		}else{
			fileVO.setFileId(fileId);
			if("3".equals(fileVO.getUpdateCondition())){
				dummyFileDelete(upPath, fileId, fileVO, "background");//파일은 삭제
			}else if("4".equals(fileVO.getUpdateCondition())){
				dummyFileDelete(upPath, fileId, fileVO, "background");//파일은 삭제
				dummyFileDelete(upPath, fileId, fileVO, "html");//파일은 삭제
			}else{
				dummyFileDelete(upPath, fileId, fileVO, null);//수정건 파일은 삭제
				dummyFileDelete(upPath, fileId, fileVO, "html");//파일은 삭제
			}
			jnitebookfileService.updateJnitebookfile(fileVO);
		}
		return status;
    }
    
    /**
     * 책자 html 파일을 생성한다.
     * @param upPath - 업로드 기본경로
     * @param sb - 완성된 문자열
     * @return Boolean
     * @throws Exception
     */
    private Boolean makeMeetpageFlipFile(String upPath, StringBuffer sb)throws Exception{
    	try {
    		String meetpageflipFileDir = upPath + SEPARATOR + "meetpageflip/meetpageflip.html";
    		File file = new File(upPath + SEPARATOR + "meetpageflip");
    		if(!file.exists()) file.mkdirs();
        	CmsHandler.writeFile(meetpageflipFileDir, sb.toString());
    	} catch (IOException e){
    		log.error(e.getMessage());
			return false;
		} catch (Exception e) {
			log.error(e.getMessage());
			return false;
		}
    	return true;
    }
    
    /**
     * 모바일 책자 html 파일을 생성한다.
     * @param upPath - 업로드 기본경로
     * @param sb - 완성된 문자열
     * @return Boolean
     * @throws Exception
     */
    private Boolean makeMobileMeetpageFlipFile(String upPath, StringBuffer sb)throws Exception{
    	try {
    		String meetpageflipFileDir = upPath + SEPARATOR + "meetpageflip/mo_meetpageflip.html";
    		File file = new File(upPath + SEPARATOR + "meetpageflip");
    		if(!file.exists()) file.mkdirs();
        	CmsHandler.writeFile(meetpageflipFileDir, sb.toString());
    	} catch (IOException e){
    		log.error(e.getMessage());
			return false;
		} catch (Exception e) {
			log.error(e.getMessage());
			return false;
		}
    	return true;
    }
    
    /**
     * ebook 등록시 업로드 경로에 default파일을 복사한다.
     * @param request
     * @param id
     * @throws Exception
     * {@link JnitebookController#addJnitebook}
     * {@link JnitebookController#updateJnitebook}
     */
    private void makeEbookDir(HttpServletRequest request, String id)throws Exception{
    	String root = PathUtil.getRealPath(request);
    	String baseFileDir = root+ "upload/base_ebook";    	
		String targetFileDir = EBOOK_UPLOAD_PATH + SEPARATOR + id;
		if(StringUtil.isExistString(request.getRequestURL().toString(), "local")) targetFileDir = root+"/upload/ebook/"+id;
		
		File baseFile = new File(baseFileDir);
		File targetFile = new File(targetFileDir);
		if(!targetFile.exists()){
			targetFile.mkdirs();
			FileCopy.copyDirectory(baseFile, targetFile);
		}
		
		File ebookDirFile = new File(getUpPath(request, id));
		if(!ebookDirFile.exists())ebookDirFile.mkdirs();		
    }
    
    /**
     * 파일 리스트를 각 Hashmap에 담아 JSONObject로 리턴한다.
     * @param fileList
     * @return JSONObject
     * @throws Exception
     */
    private JSONObject mapJSON(List fileList)throws Exception  {
	    JSONObject JSON = new JSONObject();
	    HashMap<String, String> fileNmMap = new HashMap<String, String>();
	    HashMap<String, String> fileNm2Map = new HashMap<String, String>();
	    HashMap<String, JnitebookfileVO> contentVOMap = new HashMap<String, JnitebookfileVO>();
	    HashMap<String, String> upFileNmMap = new HashMap<String, String>();
	    HashMap<String, String> htmlFileNmMap = new HashMap<String, String>();
	    
    	Iterator fileIterator = fileList.iterator();        
        if(fileList.size() > 0){
        	for(int i=0; i<fileList.size();  i++){
            	EgovMap contentEgovMap = (EgovMap) fileIterator.next();
            	String fileId = String.valueOf(contentEgovMap.get("fileId"));
            	JnitebookfileVO fileVO = new JnitebookfileVO();
            	fileVO.setFileId(fileId);
            	try {
            		fileVO = jnitebookfileService.selectJnitebookfile(fileVO);
            		if(!"".equals(NullUtil.nullString(fileVO.getBackgroundFile()))){
            			String extension = fileVO.getFileNm().substring(fileVO.getFileNm().lastIndexOf(".")+1);
            			boolean fileExtension = false;
            			   
            		    for(int k = 0; k<fileDotList.length; k++){
            				if(fileDotList[k].contains(extension.toLowerCase())){
            					fileExtension = true;/*허용리스트에 포함되어 있다면 true*/
            				}
            			}
            			if(fileExtension){
            				fileNmMap.put(fileId, "img");
            			}else{
            				fileNmMap.put(fileId, "file");
            			}
            		}
            		if(!"".equals(NullUtil.nullString(fileVO.getThumbnailImage()))){
            			String extension = fileVO.getFileNm2().substring(fileVO.getFileNm2().lastIndexOf(".")+1);
            			boolean fileExtension = false;
         			   
            		    for(int k = 0; k<fileDotList.length; k++){
            				if(fileDotList[k].contains(extension.toLowerCase())){
            					fileExtension = true;/*허용리스트에 포함되어 있다면 true*/
            				}
            			}
            			if(fileExtension){
            				fileNm2Map.put(fileId, "img");
            			}else{
            				fileNm2Map.put(fileId, "file");
            			}            			
            		}
            		if(!"".equals(NullUtil.nullString(fileVO.getUploadFile()))){
            			String extension = fileVO.getFileNm().substring(fileVO.getFileNm().lastIndexOf(".")+1);
            			boolean fileExtension = false;
          			   
            		    for(int k = 0; k<fileDotList.length; k++){
            				if(fileDotList[k].contains(extension.toLowerCase())){
            					fileExtension = true;/*허용리스트에 포함되어 있다면 true*/
            				}
            			}
            			if(fileExtension){
            				upFileNmMap.put(fileId, "img");
            			}else{
            				upFileNmMap.put(fileId, "file");
            			}            			
            		}
            		if(!"".equals(NullUtil.nullString(fileVO.getHtmlFile()))){
            			String extension = fileVO.getFileHtmlNm().substring(fileVO.getFileHtmlNm().lastIndexOf(".")+1);
            			boolean fileExtension = false;
           			   
            		    for(int k = 0; k<fileDotList.length; k++){
            				if(fileDotList[k].contains(extension.toLowerCase())){
            					fileExtension = true;/*허용리스트에 포함되어 있다면 true*/
            				}
            			}
            			if(fileExtension){
            				htmlFileNmMap.put(fileId, "img");
            			}else{
            				htmlFileNmMap.put(fileId, "file");
            			}            			
            		}
            		contentVOMap.put(fileId, fileVO);
            	} catch (NullPointerException e){
        			log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
            }
        }        
        
        JSON.put("htmlFileNmMap", htmlFileNmMap);
        JSON.put("upFileNmMap", upFileNmMap);
        JSON.put("fileNmMap", fileNmMap);
        JSON.put("fileNm2Map", fileNm2Map);
        JSON.put("contentVOMap", contentVOMap);
        return JSON;
    }   
    /**
     * 파일설정에따라 파일 삭제
     * @param upPath - 업로드 경로
     * @param fileId
     * @param fileVO
     * @param type - 선택삭제
     * @throws Exception
     */
    private void dummyFileDelete(String upPath, String fileId, JnitebookfileVO fileVO, String type)throws Exception{
    	JnitebookfileVO dummyFileVO = new JnitebookfileVO();
		dummyFileVO.setFileId(fileId);
		try {
			dummyFileVO = jnitebookfileService.selectJnitebookfile(dummyFileVO);
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}		
		if(!"".equals(NullUtil.nullString(fileVO.getFileNm())) && !fileVO.getFileNm().equals(dummyFileVO.getFileNm()) || "background".equals(type)){
			String dummyFileDir = upPath+"/"+dummyFileVO.getFilePath()+"/"+dummyFileVO.getFileNm();
			deleteFile(dummyFileDir);
			String dummyOriginFileDir = upPath+"/"+dummyFileVO.getFilePath()+"/origin/"+dummyFileVO.getFileNm();
			deleteFile(dummyOriginFileDir);
		}
		if(!"".equals(NullUtil.nullString(fileVO.getFileNm2())) && !fileVO.getFileNm2().equals(dummyFileVO.getFileNm2()) || "thumbnail".equals(type)){
			String dummyFileDir = upPath+"/"+dummyFileVO.getFilePath2()+"/"+dummyFileVO.getFileNm2();
			deleteFile(dummyFileDir);
			String dummyOriginFileDir = upPath+"/"+dummyFileVO.getFilePath2()+"/origin/"+dummyFileVO.getFileNm2();
			deleteFile(dummyOriginFileDir);
		}
		if(!"".equals(NullUtil.nullString(fileVO.getFileHtmlNm())) && !fileVO.getFileHtmlNm().equals(dummyFileVO.getFileHtmlNm()) || "html".equals(type)){
			String dummyFileDir = upPath+"/"+dummyFileVO.getFileHtmlPath()+"/"+dummyFileVO.getFileHtmlNm();
			deleteFile(dummyFileDir);
			String dummyOriginFileDir = upPath+"/"+dummyFileVO.getFileHtmlPath()+"/origin/"+dummyFileVO.getFileHtmlNm();
			deleteFile(dummyOriginFileDir);
		}
    }
    
    /**
     * 파일 삭제 하위내용까지
     * @param dir - 파일경로
     */
    private void deleteFile(String dir){
    	dir = NullUtil.nullString(dir);
    	if(!"".equals(dir)){
    		File file = new File(dir);
    		if(file.exists()){    			
    			if(file.isDirectory()){
    				File[] files = file.listFiles();
    				for(File childrenFile: files){
        				if(childrenFile.isDirectory()){
        					deleteFile(childrenFile.getPath());
        				}else{
        					childrenFile.delete();
        				}
        			}
    			}			
    			file.delete();
    		}
    	}
    }
   /**
    * 생성된 index.html 제어 
    * @param upPath - 업로드 기본경로
    * @param jnitebookVO
    * @return Boolean
    * @throws Exception
    * {@link JnitebookController#addJnitebook}
    * {@link JnitebookController#updateJnitebook}
    */
   private Boolean makeIndexFile(String upPath, JnitebookVO jnitebookVO, HttpServletRequest request)throws Exception{	   
		String indexDir = upPath + "/index.html";
		String basePath = getBasePath(request) + "/index.html";
		try {			
			String indexSrc = CmsHandler.readFile(basePath).split("/[*] ebook config [*]/")[0];
			StringBuffer indexSb = new StringBuffer();
			String beforeSrc = indexSrc;
			String ebookTitle = beforeSrc.substring(beforeSrc.indexOf("<title>"), beforeSrc.indexOf("</title>")+8);
			indexSrc = indexSrc.replace(ebookTitle, "<title>"+NullUtil.nullString(jnitebookVO.getEbookTitle())+"</title>");			
			indexSb.append(indexSrc);
			indexSb.append("/* ebook config */\r\n");
			indexSb.append("					PageWidth: "+"(isMobile ? 450 : "+NullUtil.nullInt(Integer.toString(jnitebookVO.getPageWidth()))+"),\r\n");
			indexSb.append("					PageHeight: "+"(isMobile ? 637 : "+NullUtil.nullInt(Integer.toString(jnitebookVO.getPageHeight()))+"),\r\n");
			indexSb.append("					Thumbnails: "+jnitebookVO.getThumbYn()+",\r\n");
			indexSb.append("					ThumbnailsAutoHide: "+NullUtil.nullInt(Integer.toString(jnitebookVO.getThumbAotoHide()))+",\r\n");
			indexSb.append("					ThumbnailWidth: "+NullUtil.nullInt(Integer.toString(jnitebookVO.getThumbWidth()))+",\r\n");
			indexSb.append("					ThumbnailHeight: "+NullUtil.nullInt(Integer.toString(jnitebookVO.getThumbHeight()))+",\r\n");
			indexSb.append("					ShareLink: \""+("".equals(NullUtil.nullString(jnitebookVO.getShareLink())) ? "" : jnitebookVO.getShareLink())+"\",\r\n");
			indexSb.append("					ShareText: \""+("".equals(NullUtil.nullString(jnitebookVO.getShareText())) ? "" : jnitebookVO.getShareText())+"\",\r\n");
			indexSb.append("					ShareVia: \""+("".equals(NullUtil.nullString(jnitebookVO.getShareVia())) ? "" : jnitebookVO.getShareVia())+"\"\r\n");
			indexSb.append("					/* book ID - used as CSS class name */\r\n");
			indexSb.append("				}, \"meetpageflip\" );\r\n");
			indexSb.append("		</script>\r\n");
			indexSb.append("	<!-- end script needed to run pageflip -->\r\n");
			indexSb.append("	</body>\r\n");
			indexSb.append("</html>\r\n");
			if("true".equals(deDug)) log.debug("index ="+indexSb.toString());
			CmsHandler.writeFile(indexDir, indexSb.toString());
		} catch (NullPointerException e){
			log.error(e.getMessage());
			return false;
		} catch (Exception e) {
			log.error(e.getMessage());
			return false;
		}	
		return true;
   }
   /**
    * 업로드 기본경로
    * @param request
    * @param id - ebookId
    * @return upPath
    * @throws Exception
    */
   private String getUpPath(HttpServletRequest request, String id)throws Exception{
	   String root = PathUtil.getRealPath(request);
	   String upPath = EBOOK_UPLOAD_PATH + SEPARATOR + id+"/ebook";
	   if(StringUtil.isExistString(request.getRequestURL().toString(), "local")) upPath =  root+"/upload/ebook/"+id+"/ebook";
	   return upPath;
   }
   /**
    * 업로드 base file 경로
    * @param request
    * @param id - ebookId
    * @return upPath
    * @throws Exception
    */
   private String getBasePath(HttpServletRequest request)throws Exception{
	   String root = PathUtil.getRealPath(request);
	   String upPath = uploadDir + SEPARATOR + "base_ebook/ebook";
	   if(StringUtil.isExistString(request.getRequestURL().toString(), "local")) upPath =  root+"/upload/base_ebook/ebook";
	   return upPath;
   }
   
   private Boolean isThumbnailFile(String str)throws Exception{
	   str = NullUtil.nullString(str);
	   if(!"".equals(str)){
		   str = str.substring(str.lastIndexOf(".")+1);
		   boolean fileExtension = false;
			   
		    for(int k = 0; k<fileDotList.length; k++){
				if(fileDotList[k].contains(str.toLowerCase())){
					fileExtension = true;/*허용리스트에 포함되어 있다면 true*/
				}
			}
		   if(fileExtension) return true;
	   }
	   return false;
   }
   
   
}