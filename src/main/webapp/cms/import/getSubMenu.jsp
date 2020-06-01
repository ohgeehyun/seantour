<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%--
<c:import url="/menu/getSubMenu.do">
  <c:param name="uri" value="${fn:replace(pageContext.request.requestURI, pageContext.request.contextPath, '')}"/>
</c:import>
--%>
<jsp:include page="/menu/getSubMenu.do">
  <jsp:param name="uri" value="${fn:replace(pageContext.request.requestURI, pageContext.request.contextPath, '')}"/>
</jsp:include>