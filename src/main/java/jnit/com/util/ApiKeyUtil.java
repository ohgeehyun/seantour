/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import jnit.util.PathUtil;

public class ApiKeyUtil {

	public static Log log = LogFactory.getLog(ApiKeyUtil.class);
	
	/**
	 * 
	 * @param type - daum(다음), naver(네이버), google(구글)
	 * @return type에 해당하는 API KEY
	 * @throws IOException 
	 */
	public static String getApiKey(String type) throws IOException{
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		String key = "";
		Properties prop = new Properties();
		String apiKeyPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/apiKey" + ".prop";
		
		InputStreamReader isr = null;
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(apiKeyPath);
			isr = new InputStreamReader(fis,"UTF-8");
			try {
				prop.load(isr);
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		} catch (FileNotFoundException e) {
			log.error(e.getMessage());
		} finally {
			if(isr != null){
				isr.close();
			}
			if(fis != null){
				fis.close();
			}
		}
		
		if(type.equals("daum")){
			key = prop.getProperty("daumUrl")+prop.getProperty("daumKey");
		}else if(type.equals("naver")){
			key = prop.getProperty("naverUrl")+prop.getProperty("naverKey");
		}else if(type.equals("google")){
			key = prop.getProperty("googleUrl")+prop.getProperty("googleKey");
		}
		
		return key;
	}
}
