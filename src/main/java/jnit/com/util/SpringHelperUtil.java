package jnit.com.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

/**
* 스프링 관련 헬퍼 Util
* 
*/
public class SpringHelperUtil {

	/**
	 * request객체 리턴.
	 * @return
	 */
	public static HttpServletRequest getRequest(){
		return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	}
	
	/**
	 * 사용자 IP 가져오기
	 * @return
	 */
	public static String getRemoteAddr(){
		return getRequest().getLocalAddr();
	}
	
	/**
	 * 스프링 빈 객체 가져오기.
	 * @param springServletName
	 * @param beanName
	 * @return
	 */
	public static Object getBean(String springServletName, String beanName){
		WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getRequest().getSession().getServletContext(), FrameworkServlet.SERVLET_CONTEXT_PREFIX + springServletName );
		return ctx.getBean(beanName);
	}
	
	
}


