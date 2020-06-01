<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="header.jsp" %>

<c:if test="${not empty type || not empty skin }">
<%--
<c:catch var="e">
	<c:if test="${not empty skin}">
		<jsp:include page="latest/${fn:replace(type,'..','')}_${fn:replace(skin,'..','')}.jsp" />
	</c:if>
	<c:if test="${empty skin}">
		<jsp:include page="latest/${fn:replace(type,'..','')}.jsp" />
	</c:if>
</c:catch>
--%>
<c:if test="${not empty e}">
	올바른 Type이 아닙니다.
	<c:out value="${e}" />
</c:if>
</c:if>
<c:if test="${empty type && empty skin }">
	<ul>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<a href="${result.pageUrl}">
				<img src="/seo/images/main/img_${status.count}.gif" alt="${status.count} 번째" />
				<c:out value="${fn:substring(result.menuNm,0,16)}${fn:length(result.menuNm)>16?'...':''}"/>
			</a>
			<%--<span style="float: right;">${result.pageView}</span></li>--%>
	</c:forEach>
	</ul>
</c:if>