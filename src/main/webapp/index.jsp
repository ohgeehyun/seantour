<%
/**
 *@version 3.2.0.1
 **/
%>
<%@page import="egovframework.com.utl.fcc.service.StringUtil"%>
<%@page import="egovframework.com.cmm.EgovWebUtil"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.HashMap"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "egovframework.com.cmm.service.EgovProperties" %>
<%@page import="jnit.cms.config.ConfigUtil"%>
<%@page import="egovframework.com.cmm.service.EgovProperties" %>
<% final String deDug = EgovProperties.getProperty("Globals.Debug"); %>
<%
	response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}

String agent = request.getHeader("User-Agent");
String domain = request.getHeader("host");
/*
	if (request.getParameter("pc") == null) {
		if (agent.matches(".*Android.*") == true
				|| agent.matches(".*iPhone.*") == true
				|| agent.matches(".*iPad.*") == true) {
			if("true".equals(deDug)) System.out.println("is Mobile");
			if(domain.equals("nd300.sc.go.kr")) {
				response.sendRedirect("URL 입력");
			}
			response.sendRedirect("URL 입력");
			return;
		}
	}
*/
	/* 2014-05-23 by.나성재 수정 기본설정- 일반설정의 redirect 프로퍼티값으로 변경
	String redirectUrl = EgovProperties.getProperty("/home/suncheon/ROOT/WEB-INF/Redirect.properties", domain);
	String rootPath = request.getSession().getServletContext().getRealPath("WEB-INF");
	String redirectUrl = EgovProperties.getPropertyData( rootPath + "/Redirect.properties", domain);
	if(! StringUtil.isExistString(domain,"localhost")){ //로컬개발환경은 제외
		if (redirectUrl == null) {
			response.sendRedirect("URL 입력");
		} else {
			response.sendRedirect(redirectUrl);
		}
	}
    */
	String rootPath = request.getSession().getServletContext().getRealPath("WEB-INF");
	String redirectUrl = EgovProperties.getPropertyData( rootPath + "/Redirect.properties", domain);
	/*
	if("true".equals(deDug)) {
		System.out.println("domain ="+domain);
		System.out.println("redirectUrl ="+redirectUrl);
		
	}
	*/
	if ("".equals(redirectUrl) || redirectUrl == null) {
		redirectUrl = ConfigUtil.getDefaultProp("redirectPath");
		String ctxRoot = "";
		if(StringUtil.isExistString(domain,"localhost")) ctxRoot = request.getContextPath().toString();
		String error = "";
		if(!"".equals(redirectUrl)){
			response.sendRedirect(ctxRoot + redirectUrl);
		}else{
			error = "FAIL 1";
		}
		if("FAIL 1".equals(error)){
	%>
		<script type="text/javascript">
		<!-- 
			alert("redirect 경로가 없습니다.");	
		//-->
		</script> 
	<%
		}
	%>
	<%		
	} else {
		response.sendRedirect(redirectUrl);
	}
%>