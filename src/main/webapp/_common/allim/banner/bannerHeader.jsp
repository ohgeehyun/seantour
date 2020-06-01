<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="sitePath" value="${fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,'')}"/>	      
<c:forTokens var="token" items="${sitePath }" delims="/" varStatus="status">	    	
	<c:if test="${status.count == 1 }"><c:set var="getSite" value="${token }"/></c:if>
</c:forTokens>
<% 
	String bannerMorePath = "";
	if(request.getParameter("bannerMorePath") != null){
		bannerMorePath = request.getParameter("bannerMorePath");		
%>
	<c:set var="bannerMorePath" value="<%= bannerMorePath %>"/>
<%  } %>
<input type="hidden" id="bannerMorePath" value="${bannerMorePath }"/>
<script type="text/javascript">
<!--
	$(document).ready(function(){				
		var href = "${pageContext.request.contextPath}${bannerMorePath }";
		$("#more").attr("href",href);
	});
//-->
</script>