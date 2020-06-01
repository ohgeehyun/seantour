/**
 * @version 3.2.0.1
 */
package jnit.cms;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jnit.cms.menutree.JnitcmsmenutreeDefaultVO;
import jnit.cms.menutree.JnitcmsmenutreeService;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.utl.fcc.service.NullUtil;

public class MenuUtil extends HandlerInterceptorAdapter {
   @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView){
	   
	   /*
	   System.out.println("menuUtil -- in");
	   System.out.println("request menuId ::: "+request.getParameter("menuId"));
	   System.out.println("request getsession ::: "+request.getSession().getAttribute("menuId"));
	   	String menuLink="";
	   	String Uri = NullUtil.nullString(request.getRequestURI());
	   	String QueryString = NullUtil.nullString(request.getQueryString());
	   	if(!QueryString.equals("")){
	   		menuLink = Uri+"?"+QueryString;
	   	}else{
	   		menuLink = Uri;
	   	}
	   	JnitcmsmenutreeDefaultVO searchVO = new JnitcmsmenutreeDefaultVO();
		searchVO.setSearchKeyword(menuLink);
		String menuId = NullUtil.nullString(request.getParameter("menuId"));
	      HttpSession session = request.getSession();
	      ServletContext context = session.getServletContext();
	      WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
	      JnitcmsmenutreeService jnitCmsmenutreeService = (JnitcmsmenutreeService) wContext.getBean("jnitcmsmenutreeService");
		
		if(!menuId.equals("") && !menuId.equals(null)){
			request.setAttribute("menuId",menuId);
			request.getSession().setAttribute("menuId",menuId);
		}else{
			request.setAttribute("menuId", request.getSession().getAttribute("menuId"));
		}
		
		System.out.println("menuUtil -- out");
		*/
	}
    
}