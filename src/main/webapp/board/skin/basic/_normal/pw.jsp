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
<input type="hidden" name="mode" value="pwProc" />
<input type="hidden" name="cntId" value="<c:out value="${param.cntId}"/>" />

<table class="bbsView table table-bordered" summary="<c:out value="${boardinfoVO.boardTitle}" /> <%= JnitboardController.isLanguage("의 패스워드확인 테이블입니다.",lang) %>">
	<tbody>
		<tr>
			<th><%= JnitboardController.isLanguage("패스워드 확인", lang) %></th>
			<td><input type="password" name="password" id="password"/></td>
		<tr>
	</tbody>
</table>
<div class="writebtn">
	<button id="btnSubmit" class="btn" ><%= JnitboardController.isLanguage("확인",lang) %></button>
	<a id="btnCancel" class="btn" href="?boardId=${boardinfoVO.boardId}&amp;mode=list&amp;category=${category}">취소</a>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
<input type="hidden" name="pageIdx" id="pageIdx"  value="<c:out value="${param.pageIdx}"/>" />
</form:form>