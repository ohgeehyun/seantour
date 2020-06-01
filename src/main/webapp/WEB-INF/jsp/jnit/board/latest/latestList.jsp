<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>

<table class="bbsList table table-bordered table-hover" summary="최근게시글의 게시글 목록으로 번호,제목,등록일로 구성되어 있습니다.">
	<caption>최근게시글</caption>
	<colgroup>
							<col width="6%">
							<col width="70%">
							<col width="24%">
	</colgroup>
	<thead>
		<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">등록일</th>
								
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:set var="created" value="${result.created}" />
		<fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
			<tr>
					<td class="tc">
						<c:out value="${status.count}" />
					</td>
					<td class="tc">
						<a href="${result.writer}"><c:out value="${result.title}" /></a>
					</td>
					<td class="tc">
						<a href="${result.writer}"><fmt:formatDate value="${created}" pattern="yyyy.MM.dd" /> </a>
					</td>
			</tr>
		</c:forEach>
		<c:if test="${empty resultList}">
			<tr><td class="tc">조회된 게시물이 없습니다.</td></tr>
		</c:if>
		
	</tbody>
</table>