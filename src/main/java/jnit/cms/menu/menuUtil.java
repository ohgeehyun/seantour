/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import jnit.cms.handler.CmsHandler;
import jnit.cms.site.JnitcmssiteVO;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.EgovProperties;

public class menuUtil {

	public static Log log = LogFactory.getLog(menuUtil.class);
	
	private final static String Debug = EgovProperties.getProperty("Globals.Debug");
	/**
	 * 각 사이트의 메타핸들링 파일을 생성한다.
	 * @param request
	 * @param siteVO - 사이트정보
	 * @return
	 * @throws Exception
	 */
	public static Boolean makeMeta(HttpServletRequest request, JnitcmssiteVO siteVO, String source)throws Exception{
		
		String root = PathUtil.getRealPath(request);
		String metaHandingDir = root+siteVO.getSitePath()+"/common/config/handing";
		File metaHanding = new File(metaHandingDir); if(!metaHanding.exists()) metaHanding.mkdirs();
		
		StringBuffer sb = new StringBuffer();
		Calendar calendar = Calendar.getInstance();
		sb.append("<"+"%--"+calendar.get(Calendar.YEAR)+"년 "+calendar.get((Calendar.MONTH)+1)+"월 "+calendar.get(Calendar.DATE)+"일"
					+ calendar.get(Calendar.HOUR)+"시 "+calendar.get(Calendar.MINUTE)+"분 "+source+"에서 수정되었습니다. 직접 수정하지마세요 --%"+">\r");
		sb.append("<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%><%@ page import=\"jnit.cms.handler.CmsServletPathProperty\" %>\r\n");
		sb.append("<% String servletPathHanding = request.getServletPath(); %>\r\n"
				+ "<% if(!\"\".equals(CmsServletPathProperty.getProp(servletPathHanding,\"metaTitle\"))){%><meta name=\"title\" content=\"<%= CmsServletPathProperty.getProp(servletPathHanding,\"metaTitle\") %>\" /><% } %>\r\n" 
				+ "<% if(!\"\".equals(CmsServletPathProperty.getProp(servletPathHanding,\"metaSubject\"))){%><meta name=\"subject\" content=\"<%= CmsServletPathProperty.getProp(servletPathHanding,\"metaSubject\") %>\" /><% } %>\r\n" 
				+ "<% if(!\"\".equals(CmsServletPathProperty.getProp(servletPathHanding,\"metaKeyword\"))){%><meta name=\"keywords\" content=\"<%= CmsServletPathProperty.getProp(servletPathHanding,\"metaKeyword\") %>\" /><% } %>\r\n" 
				+ "<% if(!\"\".equals(CmsServletPathProperty.getProp(servletPathHanding,\"metaDescription\"))){%><meta name=\"description\" content=\"<%= CmsServletPathProperty.getProp(servletPathHanding,\"metaDescription\") %>\" /><% } %>\r\n"
				+ "<% if(!\"\".equals(CmsServletPathProperty.getProp(servletPathHanding,\"metaClassification\"))){%><meta name=\"classification\" content=\"<%= CmsServletPathProperty.getProp(servletPathHanding,\"metaClassification\") %>\" /><% } %>\r\n"
				+ "<% if(!\"\".equals(CmsServletPathProperty.getProp(servletPathHanding,\"metaReply\"))){%><meta name=\"reply-to\" content=\"<%= CmsServletPathProperty.getProp(servletPathHanding,\"metaReply\") %>\" /><% } %>\r\n"
				+ "<% if(!\"\".equals(CmsServletPathProperty.getProp(servletPathHanding,\"metaLanguage\"))){%><meta name=\"content-language\" content=\"<%= CmsServletPathProperty.getProp(servletPathHanding,\"metaLanguage\") %>\" /><% } %>\r\n"
				+ "<% if(!\"\".equals(CmsServletPathProperty.getProp(servletPathHanding,\"metaBuild\"))){%><meta name=\"build\" content=\"<%= CmsServletPathProperty.getProp(servletPathHanding,\"metaBuild\") %>\" /><% } %>");
		
		if("true".equals(Debug)) log.debug(sb.toString());
		try {
			CmsHandler.writeFile(metaHandingDir+"/metaHanding.jsp", sb.toString());
		} catch (IOException e){
			if("ture".equals(Debug)) log.debug(e.getMessage());
			return false;
		} catch (Exception e) {
			if("ture".equals(Debug)) log.debug(e.getMessage());
			return false;
		}
		return true;
	}
}
