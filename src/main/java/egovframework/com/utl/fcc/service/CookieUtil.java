/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * 쿠키 관련 유틸
 * @author Egov 개발팀 김문기
 * @since 2011.11.03
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.11.03  김문기          최초 생성
 *
 * </pre>
 */
public class CookieUtil {
	/**
	 * add cookie to response
	 * @param response
	 * @param cookieName
	 * @param cookieValue
	 * @param maxAge
	 */
	public static void setCookie(HttpServletResponse response,String cookieName, String cookieValue, int maxAge){
		Cookie c = new Cookie(cookieName,cookieValue);
		c.setMaxAge(maxAge);
		response.addCookie(c);
	}
	/**
	 * add cookie to response
	 * @param response
	 * @param cookieName
	 * @param cookieValue
	 * @param maxAge
	 * @param domain
	 * @param path
	 */
	public static void setCookie(HttpServletResponse response,String cookieName, String cookieValue, int maxAge, String domain, String path){
		Cookie c = new Cookie(cookieName,cookieValue);
		c.setMaxAge(maxAge);
		if(!domain.equals(""))c.setDomain(domain);
		if(!path.equals(""))c.setPath(path);
		response.addCookie(c);
	}
	/**
	 * get cookie's value by cookie name in cookies
	 * @param request
	 * @param cookieName
	 * @return
	 */
	public static String getCookieValue(HttpServletRequest request, String cookieName){
		String ret = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(int i = 0; i < cookies.length; i++){
				Cookie c = cookies[i];
				if(NullUtil.nullString(c.getName()).equals(cookieName)){
					ret = c.getValue();
					break;
				}
			}
		}
		return ret;
	}
}
