<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache");
//response.setHeader("X-Frame-Options","GOFORIT");
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type='text/javascript'>
	<c:if test="${not empty alert}">
	alert('<c:out value="${alert}" escapeXml="true" />');
	</c:if>
	<c:if test="${not empty path}">
	<c:choose>
		<c:when test="${fn:contains(path,'://')}">
		document.location.href = '<c:out value="${path}" escapeXml="false" />';
		</c:when>
		<c:otherwise>
		document.location.href = '<c:url value="${path}"/>';
		</c:otherwise>
	</c:choose>
	</c:if>	
	<c:if test="${not empty listPath}">
	parent.document.getElementById("ifmList").src = '<c:url value="${listPath}"/>';
	</c:if>
	<c:if test="${not empty contentPath}">
	parent.document.getElementById("ifmContent").src = '<c:url value="${contentPath}"/>';
	</c:if>
</script>