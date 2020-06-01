<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="header.jsp" %>
<c:if test="${not empty type || not empty skin }">
<c:catch var="e">
	<c:if test="${not empty skin}">
		<jsp:include page="latest/skin/${siteId }/${fn:replace(skin,'..','')}.jsp" /><%-- ${fn:replace(type,'..','')}_${fn:replace(skin,'..','')} --%>
	</c:if>
	<c:if test="${empty skin}">
		<jsp:include page="latest/${fn:replace(type,'..','')}.jsp" />
	</c:if>
</c:catch>
<c:if test="${not empty e}">
	올바른 Type이 아닙니다.
	<c:out value="${e}" />
</c:if>
</c:if>
<c:if test="${empty type && empty skin }">
	<ul>
	<c:forEach var="result" items="${resultList}">
	<c:set var="created" value="${result.created}" />
	<fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
		<li>
			<%-- <a href="${ctxRoot}${infoVOMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"> --%>
			<a href="${basePath}?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
				<c:out value="${result.title}"/>
			</a>
			<c:if test="${result.created > today}">
				<img src="/resources/img/new_icon.gif" alt="새로운 게시물" />
			</c:if>
			<span class="latestdate"><fmt:formatDate value="${created}" pattern="yyyy.MM.dd" /></span>
		</li>
	</c:forEach>
	<c:if test="${empty resultList}">
			<li>조회된 게시물이 없습니다.</li>
	</c:if>
	</ul>
</c:if>