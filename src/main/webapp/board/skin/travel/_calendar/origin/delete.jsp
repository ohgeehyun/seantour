<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>
<%@ page import="jnit.board.BoardSession" %>
<%
	BoardSession.initBoardSession();		//게시판 세션 초기화
	BoardSession.setBoardSession();			//게시판 세션 생성 ( info : boardId, useSkeleton, fixedCategory, customSkin, customCss jsp:param 데이터를 담는다.)
%>
<%--
<%//write.jsp 참고%>
<form:form commandName="jnitboarddbVO" name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data" action="?">
--%>
<c:url value="/board/board.do" var="actionUrl"/>
<form:form commandName="jnitboarddbVO" name="bbsForm" id="bbsForm" method="post" enctype="multipart/form-data" action="${actionUrl }">
<input type="hidden" id="retUrl" name="retUrl" value="${retUrl }" />
<input type="hidden" name="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
<input type="hidden" name="mode" value="proc" />
<input type="hidden" name="proc" value="delete" />
<input type="hidden" name="cntId" value="<c:out value="${result.id}"/>" />


<table class="bbsView table table-bordered" summary="<c:out value="${boardinfoVO.boardTitle}" />의 조회 테이블입니다.">
	<caption><c:out value="${boardinfoVO.boardTitle}" /> 조회</caption>
	<thead>
		<tr>
			<th colspan="6" class="title"><c:if test="${isAdmin == true && result.isdel == 1}"><span class="delArticle">(삭제글)</span></c:if><c:out value="${result.title}" /></th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<c:if test="${not empty lbl.writer}">
		<th scope="row" class="writer"><c:out value="${lbl.writer}" /></th><td class="writer"><c:out value="${result.writer}" /></td>
		</c:if>
		<c:if test="${not empty lbl.created}">
		<th scope="row" class="created"><c:out value="${lbl.created}" /></th><td class="created"><fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd" /></td>
		</c:if>
		<c:if test="${not empty lbl.hit}">
		<th scope="row" class="hit"><c:out value="${lbl.hit}" /></th><td class="hit"><c:out value="${result.hit}" /></td>
		</c:if>
	</tr>
	<c:if test="${not empty fileList && boardinfoVO.useFile == 1}" >
	<tr>
		<th scope="row" class="file">첨부파일</th>
		<td colspan="5">
		<c:forEach var="bbsfile" items="${fileList}" varStatus="status">
			<span class="file"><img src="<c:url value="/board/_common/img/icoFile2.gif" />" alt="파일다운로드" />&nbsp;<a href="<c:url value="${bbsfile.fileUrl}"/>" target="_blank"><c:out value="${bbsfile.fileOnm}"/></a></span>
		</c:forEach>
		</td>
	</tr>
	</c:if>
	<c:forEach var="k" items="${sIdx}" varStatus="s">
	<tr>
	<c:choose>
		<c:when test="${k == 'content'}">
		<td colspan="6" class="content">
			<div class="content">
			<c:if test="${result.isHtml == 1}">
				<c:out value="${result.content}" escapeXml="false" />
			</c:if>
			<c:if test="${result.isHtml == 0}">
				<c:out value="${fn:replace(result.content,lf,'<br />')}" escapeXml="false" />
			</c:if>
			</div>
		</td>
		</c:when>
		<c:otherwise>
			<th scope="row" class="${k}"><c:out value="${f[k].lbl}" /></label></th>
			<td colspan="5">
					<c:choose>
					<%--input--%>
					<c:when test="${f[k].type == 'input'}">
					<c:out value="${result[k]}" />
					</c:when>
					<%--textarea--%>
					<c:when test="${f[k].type == 'textarea'}">
					<c:out value="${result[k]}" />
					</c:when>
					<%--date yyyy-MM-dd--%>
					<c:when test="${f[k].type == 'datetime'}">
					<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd hh:mm:ss" />
					</c:when>
					<%--date yyyy-MM-dd hh:mm:ss--%>
					<c:when test="${f[k].type == 'date'}">
					<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd" />
					</c:when>
					<%--select--%>
					<c:when test="${f[k].type == 'select'}">
					<c:out value="${result[k]}" />
					</c:when>
					<c:otherwise>
					<c:out value="${result[k]}" />
					</c:otherwise>
					</c:choose>
					</td>
				</tr>
			</td>
		</c:otherwise>
	</c:choose>
	</tr>
	</c:forEach>
	</tbody>
</table>
<div class="writebtn">
	암호 : <input name="password" value="" id="password" class="boxstyle ${k}" required type="password" />
	<button id="btnSubmit" class="btn" >삭제</button>
	<a class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=list&amp;category=${category}">목록</a> 
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${param.pageIndex}'/>"/>
</form:form>


