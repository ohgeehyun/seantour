<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--
/* 글 수정 화면 function */


function fn_egov_select(categoryId) {
	document.getElementById("listForm").categoryId.value = categoryId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/mgmt/item/eidt.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/mgmt/item/add.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/mgmt/item/list.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	    <input type="hidden" name="screenMode" />
		<input type="hidden" name="categoryId" />
		<input type="hidden" name="mgmtType" id="mgmtType" value="${mgmtType }" />
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:fn_egov_addView();" class="btn btn-small"><i class="icon-plus-sign"></i> 임의추가</a>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">			 
							<tr>
								<th>이름</th>
								<th>값</th>
								<th>표시순서</th>								
							</tr>
							<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>							
								<td><a href="javascript:fn_egov_select('<c:out value="${result.categoryId}"/>')"><c:out value="${result.categoryNm}"/></a></td>
								<td><a href="javascript:fn_egov_select('<c:out value="${result.categoryId}"/>')"><c:out value="${result.categoryVal}"/></a></td>
								<td><a href="javascript:fn_egov_select('<c:out value="${result.categoryId}"/>')"><c:out value="${result.categorySort}"/></a></td>
				   			</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="page_navi" class="pagination">
			<ui:pagination paginationInfo = "${paginationInfo}"
					   type="jnitDefault"
					   jsFunction="fn_egov_link_page"
					   />
			<form:hidden path="pageIndex" />
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>