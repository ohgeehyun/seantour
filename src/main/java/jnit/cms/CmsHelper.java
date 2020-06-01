/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mgmt.mgmtUtil;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.util.PathUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.com.utl.fcc.service.ThumbnailUtil;

@Controller
public class CmsHelper {	
    
	private static Log log = LogFactory.getLog(CmsHelper.class);
	
    /** 첨부파일 위치 지정 */
    private String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");

    @Resource(name = "jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    
    public static final String SEPERATOR = File.separator;
    
    public static final int BUFFER_SIZE = 8192;
    
	public static Object getAuthMbr(HttpServletRequest request) {
		JnitcmsmbrVO loginVO = new JnitcmsmbrVO();
		
		try {
			if( (JnitcmsmbrVO)request.getSession().getAttribute("loginVO") != null) {
				loginVO = (JnitcmsmbrVO)request.getSession().getAttribute("loginVO");
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e) {
			log.error(e.getMessage());
		}

		return loginVO;
	}
	
	/**
	 * 첨부파일 다운로드
	 * @param request (path, file)
	 * @param response
	 * @throws Exception
	 */
    @RequestMapping(value="/cms/getFile.do",method=RequestMethod.GET)
    public void downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	Boolean isloacl = StringUtil.isExistString(request.getRequestURL().toString(), "local");
		String subPath = NullUtil.nullString(request.getParameter("path"));
		String physical = request.getParameter("file");
		String orgname = request.getParameter("orgname");		
		String useThumb = NullUtil.nullString(request.getParameter("thumb"));
		String root = PathUtil.getRealPath(request);
		String varUploadDir = getUploadDir(request);		
						
		//2014-07-14 by.나성재 수정 특정값 있을 시 uploadDir 대체
		String filePath = NullUtil.nullString(request.getParameter("filePath"));
		if(!"".equals(filePath)){
			if(filePath.indexOf("common") > -1){
				varUploadDir = root+filePath;
			}else{
				System.out.println("filePath error");
				return;
			}
		}
		
		varUploadDir = isMgmtFile(request, varUploadDir); //파일관리 시스템	count
		varUploadDir = isEbookFile(request, varUploadDir);//ebook 시스템
		
		String attachFilePath = varUploadDir + SEPERATOR + subPath + SEPERATOR + physical;
		if(attachFilePath.indexOf("..") == -1){
			java.io.File attachFile = new File(attachFilePath);
			//섬네일 사용할경우 섬네일 파일이 있으면 섬네일이미지로.
			if(!"".equals(useThumb)){
				String thumbFilePath = uploadDir + SEPERATOR + subPath + SEPERATOR + "thumb_" + physical;
				java.io.File thumbFile = new File(thumbFilePath);
				
				if(!thumbFile.exists()) {
					ThumbnailUtil.createThumbnail(attachFilePath, thumbFile.getPath(), 150);
				}
				if(thumbFile.exists()){
					physical = "thumb_" + physical;
				}
			}
			if(!attachFile.exists()){
				String realPath = PathUtil.getRealPath(request);
				varUploadDir = realPath;
				subPath = "images";
				physical = "nofile.gif";
			}
			downloadFileExec(request, response, varUploadDir, subPath, physical, java.net.URLDecoder.decode(orgname, "utf-8"));
		}else{
			System.out.println("file path error");
		}
    }
    
	/**
	 * 예산파일 다운로드
	 * @param request (path, file)
	 * @param response
	 * @throws Exception
	 */
    @RequestMapping(value="/cms/getYsFile.do",method=RequestMethod.GET)
    public void ysdownloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subPath = request.getParameter("filepath");
		String physical = request.getParameter("filename");
		String realPath = PathUtil.getRealPath(request);
		
		String attachFilePath = realPath + SEPERATOR + subPath + SEPERATOR + physical;
		//System.out.println("attachFilePath : " + attachFilePath);
		java.io.File attachFile = new File(attachFilePath);
		if(!attachFile.exists()){
			throw new FileNotFoundException(physical);
		}
		downloadFileExec(request, response, realPath, subPath, physical, java.net.URLDecoder.decode(physical, "utf-8"));
    }
    
    public static void downloadFileExec(HttpServletRequest request, HttpServletResponse response, String where, String serverSubPath, String physicalName, String original) throws Exception {
    	String downFileName = where + SEPERATOR + serverSubPath + SEPERATOR + physicalName;    	
    	File file = new File(EgovWebUtil.filePathBlackList(downFileName));    	
    	if (!file.exists()) {
    	    throw new FileNotFoundException(downFileName);
    	}

    	if (!file.isFile()) {
    	    throw new FileNotFoundException(downFileName);
    	}

    	byte[] b = new byte[BUFFER_SIZE];
    	
    	String browser = getBrowser(request);
    	String encodeFileName = getDisposition(original, browser);    	
    	response.setContentType("application/octet-stream;");
    	response.setHeader("Content-Disposition", "attachment; filename=" + encodeFileName + ";");
    	response.setHeader("Content-Transfer-Encoding", "binary");
    	response.setHeader("Pragma", "no-cache");
    	response.setHeader("Expires", "0");

    	BufferedInputStream fin = null;
    	BufferedOutputStream outs = null;
    	FileInputStream fis = null;

	    	try {
	    		fis = new FileInputStream(file);
	    	    fin = new BufferedInputStream(fis);
	    	    outs = new BufferedOutputStream(response.getOutputStream());
	
	    	    int read = 0;
	
	    	    while ((read = fin.read(b)) != -1) {
		    		outs.write(b, 0, read);
	    	    }
	    	} finally {
	    	    if (outs != null) {
	    	    	outs.close();
	    	    }
	
	    	    if (fin != null) {
	    	    	fin.close();
	    	    }
				if(fis != null){
					fis.close();
				}
	    	}

    }
  
    /**
     * 첨부파일 폼 샘플
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cms/upFileForm.do")
    public String upFileForm(Model model) throws Exception {

        return "/jnit/cms/upfile";
    }
    
    /**
     * 첨부파일 처리 샘플
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/cms/upFile.do", method=RequestMethod.POST)
    public String upFile(HttpServletRequest request, Model model) throws Exception {
    	
    	try {
    		// Spring multipartResolver 미사용 시 (commons-fileupload 활용)
    		//List<EgovFormBasedFileVo> list = EgovFormBasedFileUtil.uploadFiles(request, uploadDir, maxFileSize);

    		// Spring multipartResolver 사용시
    		//List<EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFiles(request, uploadDir, maxFileSize);
    		
    		HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);

    	    model.addAttribute("getcheck1", ( list.get("upfile1") != null ? "true" : "false") );
    	    model.addAttribute("getcheck2", ( list.get("upfile2") != null ? "true" : "false") );
    	    model.addAttribute("getcheck3", ( list.get("upfile3") != null ? "true" : "false") );
    	    model.addAttribute("getcheck4", ( list.get("upfile4") != null ? "true" : "false") );
    	    model.addAttribute("getcheck5", ( list.get("upfile5") != null ? "true" : "false") );
    		
        	if (list.size() > 0) {
        		//System.out.println("files: "+ list);
        		
        		Set<String> keys = list.keySet();
        		Object[] keyArray = keys.toArray();
        		for(int i=0; i<keys.size(); i++) {
	        		EgovFormBasedFileVo vo = list.get(keyArray[i]);
	        		
	        	    //EgovFormBasedFileVo vo = list.get(0); // 첫번째 이미지
	        	            		
	        	    String url = "/cms/getFile.do?"
	        	    + "path=" + vo.getServerSubPath()
	        	    + "&file=" + vo.getPhysicalName()
	        	    + "&orgname=" + vo.getFileName();
	
	        	    String realpath = uploadDir + vo.getServerSubPath() + "/" + vo.getPhysicalName();
	        	    
	        	    int j=i+1;
	        	    model.addAttribute("inputname"+j, keyArray[i] );
	        	    model.addAttribute("url"+j, url );
	        	    model.addAttribute("realpath"+j, realpath );
	        	    model.addAttribute("path"+j, vo.getServerSubPath() );
	        	    model.addAttribute("filenm"+j, vo.getPhysicalName() );
	        	    model.addAttribute("fileorgnm"+j, vo.getFileName());
	        	    model.addAttribute("filesize"+j, vo.getSize());
	        	    model.addAttribute("mimetype"+j, vo.getContentType());
        		}
        		
        	    return "/jnit/cms/upfileview";
        	}
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e) {
    		log.error( e.getMessage() );
    	}
    	
    	return "/jnit/cms/upfileview";
    }
    
    /**
     * CMS 사이트 세션을 처리한다
     */
    @RequestMapping("/cms/setSessSiteId.do")
    public String setSessSiteId(HttpServletRequest request, Model model) throws Exception {
    	
    	CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");
    	if(vo == null) vo = new CmsSessionVO();
    	
   		vo.setSiteId(request.getParameter("siteId"));
   		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
   		jnitcmssiteVO.setSiteId(request.getParameter("siteId"));
   		jnitcmssiteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);
   		vo.setSiteNm(jnitcmssiteVO.getSiteNm());
   		vo.setLang(jnitcmssiteVO.getLang());
   		request.getSession().setAttribute("cmsSessionVO", vo);
    	model.addAttribute("siteId", vo.getSiteId());
    	
    	return "/jnit/cms/getsesssiteid";
    }
    
    /**
     * CMS 사이트 세션을 불러온다
     */
    @RequestMapping("/cms/getSessSiteId.do")
    public String getSessSiteId(HttpServletRequest request, Model model) throws Exception {
    	CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");
    	if(vo == null) {
    		vo = new CmsSessionVO();
    	}
    	
    	model.addAttribute("siteId", vo.getSiteId());
    	
    	return "/jnit/cms/getsesssiteid";
    }
    
    public static String getSessionSiteId(HttpServletRequest request) throws Exception {
    	CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");
    	if(vo == null) {
    		vo = new CmsSessionVO();
    		vo.setSiteId("");
    	}
    	    	
    	return vo.getSiteId();
    }
    
    public static CmsSessionVO getSessionSiteVO(HttpServletRequest request) throws Exception {
    	CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");
    	if(vo == null) {
    		vo = new CmsSessionVO();
    		vo.setSiteId("");
    	}
    	return vo;
    }
    
    public static String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        } else if(header.indexOf("rv:11.0") > -1){ 
        	return "IE11";
        } else if(header.indexOf("Safari") > -1){
        	return "Safari";
        }
        return "Firefox";
    }
	
	public static String getDisposition(String filename, String browser)throws Exception {
        String encodedFilename = null;
        if (browser.equals("MSIE")) {
        	filename = filename.replaceAll("\r", "").replaceAll("\n", "");
        	filename =  java.net.URLDecoder.decode(filename, "8859_1");
        	filename =  java.net.URLEncoder.encode(filename, "UTF-8");
        	encodedFilename = filename.replaceAll("\\+", " ");
        } else if (browser.equals("Firefox")) {
            encodedFilename = new String(filename.getBytes("euc-kr"), "8859_1");
        } else if (browser.equals("Opera")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Safari")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else if (browser.equals("IE11")) {
        	filename = filename.replaceAll("\r", "").replaceAll("\n", "");
        	filename =  java.net.URLEncoder.encode(filename, "utf-8");
        	encodedFilename = filename.replaceAll("\\+", " ");
        } else {
        	filename = filename.replaceAll("\r", "").replaceAll("\n", "");
        	filename =  java.net.URLDecoder.decode(filename, "8859_1");
        	filename =  java.net.URLEncoder.encode(filename, "UTF-8");
        	encodedFilename = filename.replaceAll("\\+", " ");
        }
        return encodedFilename;
    }
	
	/**
	 * 파일관리 시스템의 업로드 기본 경로 위치를 반환한다.
	 * @param request
	 * @param varUploadDir - uploadDir
	 * @return varUploadDir - 업로드 기본 경로 
	 * @throws Exception
	 */
	private String isMgmtFile(HttpServletRequest request, String varUploadDir)throws Exception{
		varUploadDir = NullUtil.nullString(varUploadDir);		
		String siteId = NullUtil.nullString(request.getParameter("siteId"));
		String mgmtId = NullUtil.nullString(request.getParameter("mgmtId"));
		String count = NullUtil.nullString(request.getParameter("count"));		
		if("Y".equals(count) && !"".equals(mgmtId)){
			varUploadDir = mgmtUtil.updateDownloadCount(siteId, mgmtId,count);
		}		
		return varUploadDir;
	}
	
	/**
	 * ebook 시스템의 업로드 기본 경로 위치를 반환한다.
	 * @param request
	 * @param varUploadDir - uploadDir
	 * @return varUploadDir - 업로드 기본 경로
	 * @throws Exception
	 */
	private String isEbookFile(HttpServletRequest request, String varUploadDir)throws Exception{
		varUploadDir = NullUtil.nullString(varUploadDir);
		String ebookId = NullUtil.nullString(request.getParameter("ebookId"));
		String root = PathUtil.getRealPath(request);
		if(!"".equals(ebookId)){
			varUploadDir =  root + "/upload/ebook/"+ebookId+"/ebook/";
		}
		return varUploadDir;
	}
	
	private String getUploadDir(HttpServletRequest request)throws Exception{
    	Boolean islocal = StringUtil.isExistString(request.getRequestURL().toString(), "local");
    	String root = PathUtil.getRealPath(request);    	
    	if(islocal){
    		uploadDir = root+"upload";
    		File upload = new File(uploadDir);
    		if(!upload.exists()) upload.mkdirs();
    	}
    	return uploadDir;
    }
}
