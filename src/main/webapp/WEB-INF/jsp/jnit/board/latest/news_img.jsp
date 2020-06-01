<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
	
	<c:forEach var="result" items="${resultList}" varStatus="status">
				<p class="news_img">
					<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
						<img src="<c:out value="${result.fileUrl}" />" alt="<c:out value="${result.title} 관련된 이미지 입니다" />" />
					</a>
				</p>
					<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
						<c:out value="${result.title}" />
					</a>
					<fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
					<span><fmt:formatDate value="${created}" pattern="yyyy.MM.dd" /></span>
	</c:forEach>