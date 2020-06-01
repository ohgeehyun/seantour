<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "jnit.cms.menutree.JnitcmsmenutreeDefaultVO,jnit.cms.menutree.JnitcmsmenutreeService,egovframework.com.utl.fcc.service.NullUtil"%>
<%
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
	String setMenuId = NullUtil.nullString(request.getParameter("menuId"));
    HttpSession MenuSession = request.getSession();
    ServletContext context = MenuSession.getServletContext();
    WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    JnitcmsmenutreeService jnitCmsmenutreeService = (JnitcmsmenutreeService) wContext.getBean("jnitcmsmenutreeService");

	if(!setMenuId.equals("") && !setMenuId.equals(null)){
		request.setAttribute("menuId",setMenuId);
		request.getSession().setAttribute("menuId",setMenuId);
	}else{
		request.setAttribute("menuId", request.getSession().getAttribute("menuId"));
	}


%>