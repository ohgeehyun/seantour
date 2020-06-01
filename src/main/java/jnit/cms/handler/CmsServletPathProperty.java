/**
 * @version 3.2.0.1
 */
package jnit.cms.handler;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class CmsServletPathProperty {

	public static Log log = LogFactory.getLog(CmsServletPathProperty.class);
	
	public static String getProp(String servletPath, String propkey)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		
		String str = "";
		Properties prop = new Properties();		
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(!"".equals(servletPath)){			
			
			String propDir = request.getSession().getServletContext().getRealPath(""); 
			String PropFileDir = propDir + servletPath+".prop";		
			
			File propFile = new File(PropFileDir);
			
			if(propFile.exists()){
				try {
					fis = new FileInputStream(propFile);
					isr = new InputStreamReader(fis);
					prop.load(isr);
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}finally{
					if(isr != null){
						isr.close();
					}
					if(fis != null){
						fis.close();
					}
				}				
				try {
					str = prop.get(propkey).toString();
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}			
			}else{
					
			}
		}		
		return str;
	}
	
	/**
	 * 로그인템플릿, 회원관련 템플릿인지 확인
	 * @param servletPath
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean isTpl(String servletPath)throws Exception{
		String[] tplList = {"/login.jsp","/login.jsp","/mbr/signupAdd.jsp","/mbr/signupSuccess.jsp"
				, "/mbr/myPage.jsp","/mbr/memberCancel.jsp","/mbr/idFind.jsp","/mbr/pwFind.jsp","/mbr/sign.jsp","/mbr/signupKid.jsp"};
		for(int i=0; i<tplList.length; i++){
			if(servletPath.indexOf(tplList[i]) > -1){
				return true;				
			}
		}
		return false;
	}
}
