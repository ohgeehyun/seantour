/**
 * @version 3.2.0.1
 */
package jnit.cms.file;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tika.Tika;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.FileUtil;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.handler.CmsHandler;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplVO;

@Controller
public class CmsFileController {
	
	private Log log = LogFactory.getLog(getClass());
	
	private static String DIR_TYPE_CSS = "css";
	private static String DIR_TYPE_JS = "js";
	private static String DIR_TYPE_FILE = "file";
	
    /** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    
    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    @RequestMapping(value="/cms/file/list.do")
    public String fileList(
    		 @RequestParam("bindType") java.lang.String bindType,
    		 @RequestParam("dirType") java.lang.String dirType,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {
    	String sitePath = "";
    	String bindDir = "";
    	
    	if(bindType.trim().equals("site")) {
    		if(CmsHelper.getSessionSiteId(request).equals("")) {
    			return "jnit/cms/sub4_msg-nosite";
    		}
    		
			JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
	    	siteSearchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
			JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
			sitePath = vo.getSitePath();
    	}

    	String docRoot = request.getSession().getServletContext().getRealPath("");
    	String contextPath = request.getContextPath();
    	String contextUri = request.getRequestURI();
    	String localUri = request.getServletPath();
    	
    	if("true".equals(deDug)){
    		log.error("docRoot:" + docRoot);
    		log.error("contextPath:" + contextPath);
    		log.error("contextUri:" + contextUri);
    		log.error("localUri:" + localUri);
    	}
    	
    	if(dirType.equals(DIR_TYPE_CSS)) {
    		bindDir = "common/css";
    		if(bindType.trim().equals("site")) {
    			AdminUtil.setMenuId("m02030000");
    		}else if(bindType.trim().equals("all")){
    			AdminUtil.setMenuId("m04020000");
    		}
    		
    	}else if(dirType.equals(DIR_TYPE_JS)) {
    		bindDir = "common/js";
    		if(bindType.trim().equals("site")) {
    			AdminUtil.setMenuId("m02040000");
    		}else if(bindType.trim().equals("all")){
    			AdminUtil.setMenuId("m04030000");
    		}
    	}else if(dirType.equals(DIR_TYPE_FILE)) {
    		bindDir = "common/file";
    		if(bindType.trim().equals("site")) {
    			AdminUtil.setMenuId("m02050000");
    		}else if(bindType.trim().equals("all")){
    			AdminUtil.setMenuId("m04040000");
    		}
        	
    	}
    	log.error("type:" + bindDir);
    	    	
    	String fileDir = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir;
    	final File df = new File(fileDir);
    	if(df.exists() == false) {
    		df.mkdirs();
    	}
    	
    	String filePath = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir;
    	log.error("filePath" + filePath);
    	
    	List<String> filelist = new ArrayList<String>();
    	List<HashMap> files = new ArrayList<HashMap>();
    	try {
    		filelist = FileUtil.getFileList(new File(filePath));
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e) {
    		log.error("error: "+ e.getStackTrace());
    	}
    	
    	for(int i=0; i<filelist.size(); i++) {
    		final HashMap<String, Object> onceFile = new HashMap<String, Object>();
    		onceFile.put("name", filelist.get(i));
    		final File f = new File(filePath + "/" + filelist.get(i));
    		onceFile.put("date", new Date(f.lastModified()));
    		onceFile.put("size", f.length() / 1000);
    		String mimeType = null;
    		try {
    		    Tika tika = new Tika();
    		    mimeType = tika.detect(f);
    		} catch (IOException e){
    			log.error(e.getMessage());
    		} 
    		catch (Exception e) {
    		    log.error("오류: tika");
    		}
    		onceFile.put("mime", mimeType);

    		System.out.print( filelist.get(i).trim().toLowerCase() );
        	if(dirType.equals(DIR_TYPE_CSS)) {
        		if(filelist.get(i).trim().toLowerCase().matches(".*\\.css$") == true) {
        			files.add(onceFile);
        		}
        	}else if(dirType.equals(DIR_TYPE_JS)) {
        		if(filelist.get(i).trim().toLowerCase().matches(".*\\.js$") == true) {
        			files.add(onceFile);
        		}
        	}else if(dirType.equals(DIR_TYPE_FILE)) {
        		files.add(onceFile);
        	}
    	}
    	
    	model.addAttribute("sitePath", sitePath);
    	log.error("files" + files);
    	
    	model.addAttribute("files", files);
    	
    	return "/jnit/cms/file/list";
    }
    
    @RequestMapping(value="/cms/file/view.do")
    public String fileView(
    		 @RequestParam("bindType") java.lang.String bindType,
    		 @RequestParam("dirType") java.lang.String dirType,
    		 @RequestParam("fileName") java.lang.String fileName,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {

    	String sitePath = "";
    	String bindDir = "";
    	String fileNm = StringUtil.replaceAllRegExp(NullUtil.nullString(fileName), "", "\\.\\.|\\/|\\\\|\\.\\/|\\.\\\\");

    	log.error(fileNm);
    	
    	if(bindType.trim().equals("site")) {
    		if(CmsHelper.getSessionSiteId(request).equals("")) {
    			return "jnit/cms/sub4_msg-nosite";
    		}
    		
			JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
	    	siteSearchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
			JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
			sitePath = vo.getSitePath();
    	}
    	
    	log.error("site:" + sitePath);

    	String docRoot = request.getSession().getServletContext().getRealPath("");
    	String contextPath = request.getContextPath();
    	String contextUri = request.getRequestURI();
    	String localUri = request.getServletPath();
    	if("true".equals(deDug)) {
    		log.error("docRoot:" + docRoot);
    		log.error("contextPath:" + contextPath);
    		log.error("contextUri:" + contextUri);
    		log.error("localUri:" + localUri);
    	}
    	
    	if(dirType.equals(DIR_TYPE_CSS)) {
    		bindDir = "common/css";
    	}else if(dirType.equals(DIR_TYPE_JS)) {
    		bindDir = "common/js";
    	}else if(dirType.equals(DIR_TYPE_FILE)) {
    		bindDir = "common/file";
    	}
    	log.error("type:" + bindDir);
    	
    	String filePath = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir + "/" + fileNm;
    	log.error("filePath" + filePath);
    	
    	final HashMap<String, Object> onceFile = new HashMap<String, Object>();
    	final File f = new File(filePath);
		
		String mimeType = null;    	
		String mimeHeader = null;
    	String viewPath = null;
    	if(f.exists()) {
    		onceFile.put("name", fileNm);
    		onceFile.put("linkpath", "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir + "/" + fileNm);
    		onceFile.put("date", new Date(f.lastModified()));
    		onceFile.put("size", f.length() / 1000);

    		try {
    		    Tika tika = new Tika();
    		    mimeType = tika.detect(f);
    		} catch (IOException e){
    			log.error(e.getMessage());
    		} 
    		catch (Exception e) {
    		    log.error("오류: tika");
    		}
    		onceFile.put("mime", mimeType);
    		
        	
        	String[] mimeSplit = mimeType.split("/");
        	mimeHeader = mimeSplit[0];
    	}else {
    		mimeHeader = "unknown";
    	}

    	model.addAttribute("sitePath", sitePath);
    	model.addAttribute("file", onceFile);

    	if(mimeHeader.toLowerCase().equals("image")) {
    		viewPath = "/jnit/cms/file/imageview";
    	}else if(mimeHeader.toLowerCase().equals("text") || mimeType.toLowerCase().equals("application/javascript")) {
    		viewPath = "/jnit/cms/file/textview";
    		JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
    		
    		jnitcmstplVO.setTplSrc(FileUtil.getFileContent(f));
    		
    		model.addAttribute("jnitcmstplVO", jnitcmstplVO);
    		//@ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
    	}else {
    		viewPath = "/jnit/cms/file/fileview";
    	}

    	return viewPath;
    }
    
    @RequestMapping(value="/cms/file/save.do")
    public String fileSave(
    		 @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {
    	
    	String[] parseTexts = jnitcmstplVO.getSearchKeyword().toString().split(",");
    	String bindType = parseTexts[0];
    	String dirType = parseTexts[1];
    	String fileName = parseTexts[2];

    	String sitePath = "";
    	String bindDir = "";
    	String fileNm = StringUtil.replaceAllRegExp(NullUtil.nullString(fileName), "", "\\.\\.|\\/|\\\\|\\.\\/|\\.\\\\");

    	
    	
    	if(bindType.trim().equals("site")) {
    		if(CmsHelper.getSessionSiteId(request).equals("")) {
    			return "jnit/cms/sub4_msg-nosite";
    		}
    		
			JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
	    	siteSearchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
			JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
			sitePath = vo.getSitePath();
    	}
    	
    	String docRoot = request.getSession().getServletContext().getRealPath("");
    	String contextPath = request.getContextPath();
    	String contextUri = request.getRequestURI();
    	String localUri = request.getServletPath();
    	
    	if("true".equals(deDug)){
    		log.error("param:"+jnitcmstplVO.getSearchKeyword());
    		log.error("sitepath:"+jnitcmstplVO.getSitePath());
    		log.error("src:"+jnitcmstplVO.getTplSrc());
    		log.error("docRoot:" + docRoot);
    		log.error("contextPath:" + contextPath);
    		log.error("contextUri:" + contextUri);
    		log.error("localUri:" + localUri);
    	}
    	
    	if(dirType.equals(DIR_TYPE_CSS)) {
    		bindDir = "common/css";
    	}else if(dirType.equals(DIR_TYPE_JS)) {
    		bindDir = "common/js";
    	}else if(dirType.equals(DIR_TYPE_FILE)) {
    		bindDir = "common/file";
    	}
    	log.error("type:" + bindDir);
    	
    	String filePath = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir + "/" + fileNm;
    	log.error("filePath" + filePath);
    	
    	if(NullUtil.nullString(jnitcmstplVO.getTplId()).equals("uniq")) {
			File f = new File(filePath);
			if(f.exists()) {
				String newFilePath = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir + "/";
				String newFileName = fileNm;
	    		while(true) {
	    			Date fd = new Date();
	    			String nFileName = String.valueOf(fd.getTime()) + "_" + newFileName;
	    			File f1 = new File(newFilePath + nFileName);
	    			if(!f1.exists()) {
	    				filePath = newFilePath + nFileName;
	    				fileNm = nFileName;
	    				log.error(filePath);
	    				break;
	    			}
	    		}				
			}
    	}
    	CmsHandler.writeFile(filePath, NullUtil.nullString(jnitcmstplVO.getTplSrc()));
    	
    	//model.addAttribute("msg", "<script src='<c:url value='/resources/js/jquery.min.js'/>'></script><script type='text/javascript'> $(document).ready(function(){ $(top.document).find('#ifmList').attr('src', $(top.document).find('#ifmList').attr('src')); $(top.document).find('#ifmContent').attr('src', '"+contextPath+"/cms/file/view.do?bindType="+bindType+"&dirType="+dirType+"&fileName="+fileNm+"'); }); </script>");
    	String msg = "<script type='text/javascript' src='../../resources/js/jquery.min.js'></script><script type='text/javascript'> $(document).ready(function(){parent.location.href='"+contextPath+"/cms/file/list.do?bindType="+bindType+"&dirType="+dirType+"';}); </script>";
    	if(NullUtil.nullString(request.getParameter("fileSave")).equals("fileSave")){
    		msg = "<script type='text/javascript' src='../../resources/js/jquery.min.js'></script><script type='text/javascript'> $(document).ready(function(){$(top.document).find('#ifmContent').attr('src', '"+contextPath+"/cms/file/view.do?bindType="+bindType+"&dirType="+dirType+"&fileName="+fileNm+"');}); </script>";
    	}
    	model.addAttribute("msg",msg);
    	return "jnit/msg";
    }
    
    @RequestMapping(value="/cms/file/new.do")
    public String fileNew(
             HttpServletRequest request,
             ModelMap model)
             throws Exception {
    	
    	String bindType = NullUtil.nullString(request.getParameter("bindType"));
    	String dirType = NullUtil.nullString(request.getParameter("dirType"));
    	
		JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
		model.addAttribute("jnitcmstplVO", jnitcmstplVO);
		
    	model.addAttribute("bindType", bindType);
    	model.addAttribute("dirType", dirType);
    	
    	return "/jnit/cms/file/new";
    }

    @RequestMapping(value="/cms/file/upfile.do")
    public String fileUpload(
             HttpServletRequest request,
             ModelMap model)
             throws Exception {
    	
    	String bindType = NullUtil.nullString(request.getParameter("bindType"));
    	String dirType = NullUtil.nullString(request.getParameter("dirType"));
    	
		JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
		model.addAttribute("jnitcmstplVO", jnitcmstplVO);
		
    	model.addAttribute("bindType", bindType);
    	model.addAttribute("dirType", dirType);
    	
    	return "/jnit/cms/file/upload";
    }
    
    @RequestMapping(value="/cms/file/saveupfile.do")
    public String fileSaveUpload(
    		 @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {
    	
    	
    	
    	String[] parseTexts = jnitcmstplVO.getSearchKeyword().toString().split(",");
    	String bindType = NullUtil.nullString(parseTexts[0]);
    	String dirType = NullUtil.nullString(parseTexts[1]);

    	String sitePath = "";
    	String bindDir = "";
    	String fileNm = "";
    	String srcfilePath = ""; 
    	
		HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);
		if(list.get("upfile") != null) {
    		EgovFormBasedFileVo fvo = list.get("upfile");
    	            		
    	    String url = "/cms/getFile.do?"
    	    + "path=" + fvo.getServerSubPath()
    	    + "&file=" + fvo.getPhysicalName()
    	    + "&orgname=" + fvo.getFileName();

    	    srcfilePath = uploadDir + fvo.getServerSubPath() + "/" + fvo.getPhysicalName();
    	    
    	    fileNm = StringUtil.replaceAllRegExp(NullUtil.nullString(fvo.getFileName()), "", "\\.\\.|\\/|\\\\|\\.\\/|\\.\\\\");
		}
    	log.error(fileNm);
    	
    	if(bindType.trim().equals("site")) {
    		if(CmsHelper.getSessionSiteId(request).equals("")) {
    			return "jnit/cms/sub4_msg-nosite";
    		}
    		
			JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
	    	siteSearchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
			JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
			sitePath = vo.getSitePath();
    	}
    	String docRoot = request.getSession().getServletContext().getRealPath("");
    	String contextPath = request.getContextPath();
    	String contextUri = request.getRequestURI();
    	String localUri = request.getServletPath();
    	
    	if("true".equals(deDug)){
    		log.error("param:"+jnitcmstplVO.getSearchKeyword());
    		log.error("sitepath:"+jnitcmstplVO.getSitePath());
    		log.error("src:"+jnitcmstplVO.getTplSrc());
    		log.error("docRoot:" + docRoot);
    		log.error("contextPath:" + contextPath);
    		log.error("contextUri:" + contextUri);
    		log.error("localUri:" + localUri);
    	}
    	
    	if(dirType.equals(DIR_TYPE_CSS)) {
    		bindDir = "common/css";
    	}else if(dirType.equals(DIR_TYPE_JS)) {
    		bindDir = "common/js";
    	}else if(dirType.equals(DIR_TYPE_FILE)) {
    		bindDir = "common/file";
    	}
    	if("true".equals(deDug)) log.error("type:" + bindDir);
    	
    	String filePath = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir + "/" + fileNm;
    	if("true".equals(deDug)) log.error("filePath" + filePath);
    	
    	if(NullUtil.nullString(jnitcmstplVO.getTplId()).equals("uniq")) {
			File f = new File(filePath);
			if(f.exists()) {
				String newFilePath = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir + "/";
				String newFileName = fileNm;
	    		while(true) {
	    			Date fd = new Date();
	    			String nFileName = String.valueOf(fd.getTime()) + "_" + newFileName;
	    			File f1 = new File(newFilePath + nFileName);
	    			if(!f1.exists()) {
	    				filePath = newFilePath + nFileName;
	    				fileNm = nFileName;
	    				if("true".equals(deDug)) log.error(filePath);
	    				break;
	    			}
	    		}				
			}
    	}
    	File nf = new File(srcfilePath);
    	nf.renameTo(new File(filePath));
    	//CmsHandler.writeFile(filePath, NullUtil.nullString(jnitcmstplVO.getTplSrc()));
    	String msg = "<script type='text/javascript' src='../../resources/js/jquery.min.js'></script><script type='text/javascript'> $(document).ready(function(){parent.location.href='"+contextPath+"/cms/file/list.do?bindType="+bindType+"&dirType="+dirType+"';});</script>";
    	//msg = "<script type='text/javascript' src='../../resources/js/jquery.min.js'></script><script type='text/javascript'> $(document).ready(function(){ $(top.document).find('#ifmList').attr('src', $(top.document).find('#ifmList').attr('src')); $(top.document).find('#ifmContent').attr('src', '"+contextPath+"/cms/file/view.do?bindType="+bindType+"&dirType="+dirType+"&fileName="+fileNm+"'); }); </script>";
    	model.addAttribute("msg", msg);
    	
    	return "jnit/msg";
    }
}
