<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ include file='/_common/header.jsp' %>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%
	String target = request.getParameter("target");
	String menuNm = request.getParameter("menuNm");
	String depth = request.getParameter("depth");
	String order = request.getParameter("order");
%>
<%--
<c:import url="/menu/getSubMenu.do">
  <c:param name="uri" value="${fn:replace(pageContext.request.requestURI, pageContext.request.contextPath, '')}"/>
</c:import>
--%>
<jsp:include page="/menu/getTopMenu.do">
  <jsp:param name="target" value="<%=target%>"/>
  <jsp:param name="menuNm" value="<%=menuNm%>"/>
  <jsp:param name="depth" value="<%=depth%>"/>
  <jsp:param name="order" value="<%=order%>"/>
  <jsp:param name="uri" value="${fn:replace(pageContext.request.requestURI, pageContext.request.contextPath, '')}"/>
</jsp:include>