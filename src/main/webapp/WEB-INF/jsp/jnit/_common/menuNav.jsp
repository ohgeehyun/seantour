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
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${menuMap.depth > 0}">
	&nbsp;	
	<c:forEach begin="1" end="${menuMap.depth}" step="1" var="menuDepth" varStatus="status">		
		<c:set var="currentDepth" value="depth${menuDepth}" />
		<span class="${currentDepth}"><c:out value="${menuMap[currentDepth].name}" /></span>
		<c:if test="${status.last != true}">
		<span class="gt">&gt;</span>
		</c:if>
	</c:forEach>  
</c:if>