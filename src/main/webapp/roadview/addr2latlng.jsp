<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
java.lang.String addr = java.net.URLEncoder.encode(request.getParameter("q"));
%>
<c:set var="addr" value="<%=addr%>" />
<c:import url="http://apis.daum.net/local/geo/addr2coord?apikey=5d06416f95cc8215522d1225dd0861c0434b9c56&output=json&q=${addr}" />
