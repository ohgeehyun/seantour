/**
 * @version 3.2.0.1
 */
package jnit.cms.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import egovframework.com.cmm.service.EgovProperties;

public class CmsClientProperty implements Serializable {
	private Log log = LogFactory.getLog(getClass());
	private static final long serialVersionUID = -1748141834833058054L;

	public HttpServletRequest request;
	
	public String docRoot;
	public String contextPath;
	public String contextUri;
	public String localUri;
	
	public String siteId;
	public String menuId;
	public String cntId;
	public String menuPath;
	public String pageCode;
	public String pageTitle;
	public String pageCcl;
	public String pageImgTitle;
	public String pageNav;
	public String pageLinkNav;
	public String pageHash;
	public String pageNavTitle;
	
	public String admNm;
	public String admTel;
	public String admId;
	
	public String admNm2;
	public String admTel2;
	public String admId2;
	
	public String robotYn;
	
	public String cntModified;
	
	public HashMap<String, HttpServletRequest>  multipartRequest = new HashMap<String, HttpServletRequest>();
	public HashMap<String, HttpServletRequest>  boardRequest = new HashMap<String, HttpServletRequest>();
	
	public CmsClientProperty() {
    }
	
	@Autowired
	public void init(HttpServletRequest request) throws IOException {
		String debug = EgovProperties.getProperty("Globals.Debug");
		if(debug.equals("true")) {
			log.debug("request:"+request);
			log.debug("request class Name:"+request.getClass().getName()); 
			log.debug("sessid:"+request.getRequestedSessionId());
			log.debug("uri:"+request.getRequestURI());			
		}

		if( request.getClass().getName().indexOf("MultipartResolver") != -1 ) {
		//log.debug("request.getParameter(mode) : " + request.getParameter("mode"));
			multipartRequest.put(request.getRequestedSessionId(), request);
			request.getSession().setAttribute("multipart", request);
			if(debug.equals("true")) log.debug("CmsProperty.multipartRequest:"+ multipartRequest );
		}else{
			request.getSession().setAttribute("multipart", null);
		}
		
		/*
		if( NullUtil.nullString(request.getParameter("mode")).equals("proc") && ! NullUtil.nullString(request.getParameter("proc")).equals("delete") ) {
			CmsProperty.boardRequest.put(request.getRequestedSessionId(), request);
			if(debug.equals("true")) log.debug("CmsProperty.boardRequest:"+ CmsProperty.boardRequest );
		}
		*/
		
		this.request = request;
		if(debug.equals("true")) log.debug("CmsProperty init.");
		if(debug.equals("true")) log.debug(request.getRemoteAddr() + ":" + request);
		
		docRoot = request.getSession().getServletContext().getRealPath("");
		contextPath = request.getContextPath();
		contextUri = request.getRequestURI();
		localUri = request.getServletPath();
		
		File currentPropFile = new File(docRoot+localUri+".prop");
		if(debug.equals("true")) log.debug(currentPropFile.getPath());
		
		FileInputStream fis = null;
		InputStreamReader isr = null;
		if(currentPropFile.exists()) {
			if(debug.equals("true")) log.debug("use props.");
			
			Properties cProps = new Properties();			
			try {
				fis = new FileInputStream(currentPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				cProps.load(isr);
			} catch (FileNotFoundException e) {				
				if(debug.equals("true")) log.error(e.getMessage());
			} catch (IOException e) {				
				if(debug.equals("true")) log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			siteId = cProps.getProperty("siteId", "");
			menuId = cProps.getProperty("menuId", "");
			cntId = cProps.getProperty("cntId", "");
			menuPath = cProps.getProperty("menuPath", "");
			pageCode = cProps.getProperty("pageCode", "");
			pageTitle = cProps.getProperty("pageTitle", "");
			pageCcl = cProps.getProperty("pageCcl", "");
			pageImgTitle = cProps.getProperty("pageImgTitle", "");
			pageNav = cProps.getProperty("pageNav", "");
			pageLinkNav = cProps.getProperty("pageLinkNav", "");
			pageHash = cProps.getProperty("pageHash", "");
			pageNavTitle = cProps.getProperty("pageNavTitle","");
			
			admNm = cProps.getProperty("admNm","");
			admTel = cProps.getProperty("admTel","");
			admId = cProps.getProperty("admId","");
			
			admNm2 = cProps.getProperty("admNm2","");
			admTel2 = cProps.getProperty("admTel2","");
			admId2 = cProps.getProperty("admId2","");
			
			robotYn = cProps.getProperty("robotYn","");
			
			cntModified = cProps.getProperty("cntModified","");
			
			if(debug.equals("true")) log.debug(cProps.toString()); 
		}else {
			siteId = "";
			menuId = "";
			cntId = "";
			menuPath = "";
			pageCode = "";
			pageTitle = "";
			pageCcl = "";
			pageImgTitle = "";
			pageNav = "";
			pageLinkNav = "";
			pageHash = "";
			pageNavTitle = "";
			
			admNm = "";
			admTel = "";
			admId = "";
			
			admNm2 = "";
			admTel2 = "";
			admId2 = "";
			
			robotYn = "";
			
			cntModified="";
			if(debug.equals("true")) log.debug("not props.");
		}
	}
}
