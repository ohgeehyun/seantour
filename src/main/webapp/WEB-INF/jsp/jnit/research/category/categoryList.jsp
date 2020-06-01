<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">
<!--
/* 글 수정 화면 function */


function fn_egov_select(categoryId) {
    document.getElementById("listForm").categoryId.value = categoryId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/category/editcategoryView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/category/addcategoryView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/category/categoryList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		<div class="row-fulid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>카테고리</h3>
						<c:if test="${isAdmin == ture}">
							<a href="javascript:fn_egov_addView();" class="btn btn-small">등록</a>
						</c:if>
					</div>
					<div class="widget-content nopadding">
					    <input type="hidden" name="screenMode" />
					    <input type="hidden" name="categoryId" />
						
						<table class="table table-bordered table-striped table-hover">
							<thead>
								<tr>
									<th width="25%">카테고리 번호</th>
									<%-- <th align="center">ResearchId</th>  --%>
									<th>이름</th>
									<%-- <th align="center">Isdel</th>   --%>
								</tr>
							</thead>
							<tbody>	
								
								<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td><c:if test="${isAdmin == ture}"><a href="javascript:fn_egov_select('<c:out value="${result.categoryId}"/>')"></c:if><c:out value="${result.categoryId}"/><c:if test="${isAdmin == ture}"></a></c:if></td>
									<%-- <td align="center" class="listtd"><c:out value="${result.researchId}"/>&nbsp;</td> --%>
									<td><c:out value="${result.categoryName}"/></td>
									<%-- <td align="center" class="listtd"><c:out value="${result.isdel}"/>&nbsp;</td>   --%>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!-- /List -->
				<div id="page_navi" class="pagination">
						<ui:pagination paginationInfo = "${paginationInfo}"
								   type="jnitDefault"
								   jsFunction="fn_egov_link_page"
								   />
						<form:hidden path="pageIndex" />
				</div>
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>