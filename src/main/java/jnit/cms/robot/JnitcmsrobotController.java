/**
 * @version 3.2.0.1
 */
package jnit.cms.robot;

import java.io.File;
import java.io.IOException;
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
import org.terracotta.agent.repkg.de.schlichtherle.io.FileInputStream;

import jnit.util.PathUtil;

public class JnitcmsrobotController {
	
	public static Log log = LogFactory.getLog(JnitcmsrobotController.class);
	
	public static String robot(String url)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);	
		
		String robot = "0";
		if(url.equals("")){			
			return robot;
		}	
		
		url = url.replace("/index.jsp", "");
		Properties prop = new Properties();
		InputStreamReader isr = null;
		FileInputStream fis = null;
		String propDir = PathUtil.getRealPath(request) + url+"/index.jsp.prop";		
		
		File propFile = new File(propDir);
		if(propFile.exists()){
			
			try {
				fis = new FileInputStream(propFile);
				isr = new InputStreamReader(fis);
				prop.load(isr);
			} catch (IOException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}			
			if(prop.getProperty("robotYn") != null){
				robot = prop.getProperty("robotYn");
			}
		}
		
		return robot;
	}
}
