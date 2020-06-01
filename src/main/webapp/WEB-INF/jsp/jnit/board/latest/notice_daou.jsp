<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<div class="list">
	<dl>
		<c:choose>
			<c:when test="${classNm == 'NOTICE'}">
				<dt><b>NEWS</b> NOTICE&nbsp;&nbsp;&gt;</dt>			
			</c:when>
			<c:when test="${classNm == 'ELECTRONIC'}">
				<dt><b>ELECTRONIC</b></dt>
			</c:when>
			<c:otherwise>
				<dt><b>${classNm}</b></dt>
			</c:otherwise>
		</c:choose>
		<dd>
			<ul class="${classNm}_List">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<li><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${result.title}" /></a></li>
				</c:forEach>
				<c:if test="${empty resultList}">
					<li>조회된 게시물이 없습니다.</li>
				</c:if>
			</ul>
		</dd>
		<dd class="control">
			<a class="${classNm}_BtnUp" href="javascript:noticeBefore('${classNm}_List')"><img src="/kr/images/main/icon_prev.gif" alt="이전 게시물 보기"></a>
			<a class="${classNm}_BtnDown" href="javascript:noticeNext('${classNm}_List')"><img src="/kr/images/main/icon_next.gif" alt="다음 게시물 보기"></a>
		</dd>
	</dl>
</div>