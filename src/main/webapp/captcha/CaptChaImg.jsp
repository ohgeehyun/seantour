<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="nl.captcha.CaptChaServlet"%><%try{
	out.clear();
	pageContext.pushBody();
	new CaptChaServlet().getCaptCha(request, response);	
} catch(Exception e){
	e.printStackTrace();
}%>