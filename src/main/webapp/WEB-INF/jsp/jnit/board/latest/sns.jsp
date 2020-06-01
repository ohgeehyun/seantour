<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<c:forEach var="result" items="${resultList}" varStatus="status">
	<dd <c:out value="${status.index>=1? 'style=\"display:none;\"' : ''}" escapeXml="false" />><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${fn:substring(fn:trim(result.content),0,38)}"/></a></dd>
</c:forEach>