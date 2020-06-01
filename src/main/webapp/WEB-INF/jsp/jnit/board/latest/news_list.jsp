<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
	<ul class="news_list">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<li>
				<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
					<c:out value="${result.title}"/>
					<c:if test="${result.created > today}">
						<img src="/resources/img/new_icon.gif" alt="새로운 게시물" />
					</c:if>
				</a>	
			</li>
		</c:forEach>
			<c:if test="${empty resultList}">
			<li>조회된 게시물이 없습니다.</li>
		</c:if>
	</ul>
