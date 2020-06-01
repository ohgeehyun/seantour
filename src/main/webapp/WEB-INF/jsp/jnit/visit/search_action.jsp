<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	frm = document.getElementById("listForm");
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/visit/getActionLogin.do'/>";
	frm.submit();
}

 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post" >
    <input type="hidden" name="when" value="${when}"/>
 	<input type="hidden" name="action" value="${action}"/>
 	
		<table border="0" cellspacing="0" width="100%" cellpadding="0" class="table content2_table" summary="사용자 로그" style="color: #000;">
			<caption>사용자 로그</caption>
			<thaed>
				<th>접속시간</th>
				<th>접속페이지</th>
				<th>ACTION</th>
			</thaed>
		    <tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			    <tr>
			        <td align="center"><c:out value="${result.whenDatetime}"/></td>
			        <td align="center"><c:out value="${result.page}"/></td>
			        <td align="center"><c:out value="${result.userAction}"/></td>                     
			    </tr>
			</c:forEach> 
		    </tbody>
		</table>
		<div id="page_navi" class="pagination">
				<ui:pagination paginationInfo = "${paginationInfo}"
						   type="jnitDefault"
						   jsFunction="fn_egov_link_page"
						   />
				<form:hidden path="pageIndex" />
		</div>

</form:form>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>