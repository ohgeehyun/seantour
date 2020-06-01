<%
/**
 *@version 3.2.0.1
 **/
%>
<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<c:import url="/menu/getMainMenu.do">
  <c:param name="uri" value="${fn:replace(pageContext.request.requestURI, pageContext.request.contextPath, '')}"/>
</c:import>