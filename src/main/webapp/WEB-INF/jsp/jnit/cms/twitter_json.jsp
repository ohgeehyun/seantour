<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<c:out value="${jsonData}" escapeXml="false" />