<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/board/header.jsp" %>
<%--
<%//글쓰기%>
<form:form commandName="searchVO" name="bbsForm" id="bbsForm" method="get" action="?">
 --%>
<c:set var="actionUrl" value="${pageContext.request.contextPath }${param.retUrl }" />
<form:form commandName="searchVO" name="bbsForm" id="bbsForm" method="get" action="${actionUrl}">
<!-- 검색조건 유지 -->
<input type="hidden" name="boardId" id="boardId" value="<c:out value="${boardinfoVO.boardId}"/>" />
<input type="hidden" name="category" value="<c:out value="${param.category}"/>" />
<input type="hidden" name="mode" id="mode" value="list" />
<input type="hidden" name="cntId" id="cntId" value="<c:out value="${cntId}"/>" />
<input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
<input type="hidden" name="pageIdx" id="pageIdx" value="<c:out value="${empty param.category ? param.pageIdx : '1'}"/>"/>
</form:form>
<script type="text/javascript">
	<c:if test="${NoPasswd == null}">
		alert("<c:out value="${modeStr}" /> <%= JnitboardController.isLanguage("완료되었습니다.",lang) %>");		
	</c:if>
	<c:if test="${NoPasswd != null}">
		alert("${NoPasswd}");
	</c:if>
	<c:if test="${proc == 'write' || proc == 'edit' }">
		document.getElementById("mode").value= 'view';
	</c:if>
	<c:if test="${proc == 'delete'}">
		document.getElementById("mode").value= 'delete';
	</c:if>
	<c:if test="${param.proc == 'write' || param.proc == 'edit' }">
		document.getElementById("mode").value= 'view';
		document.getElementById("boardId").value= '<c:out value="${param.boardId}" />';
		document.getElementById("cntId").value= '<c:out value="${param.cntId == null ? cntId : param.cntId}" />';
		document.getElementById("searchCondition").value= '<c:out value="${param.searchCondition}" />';
		document.getElementById("searchKeyword").value= '<c:out value="${param.searchKeyword}" />';
		document.getElementById("pageIdx").value= '<c:out value="${param.pageIdx}" />';
	</c:if>
		document.getElementById("bbsForm").submit();
</script>
<%-- <c:out value="${boarddbVO}" /> --%>