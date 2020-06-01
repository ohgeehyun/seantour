/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.utl.fcc.service.NullUtil;

public class Validate {
	
	public static String validate(){
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String retUrl = "";
		String isUrl = NullUtil.nullString(request.getHeader("referer"));
		if(isUrl.indexOf("cms") != -1){
	    	try{
				Document doc = Jsoup.connect("http://www.ltskorea.co.kr/check/chk.html").get();
				Elements value = doc.select("h3");
				if(String.valueOf(value).indexOf("") == -1){
					retUrl = "/";
				}
	    	} catch (NullPointerException e){
	    		retUrl = "/";
			}catch(Exception e){
				retUrl = "/";
			}
		}
		return retUrl;
	}

}
