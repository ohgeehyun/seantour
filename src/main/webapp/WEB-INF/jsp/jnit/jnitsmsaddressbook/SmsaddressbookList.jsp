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
<script>
<!--
/* 글 수정 화면 function */


function fn_egov_select(addrId) {
    document.getElementById("listForm").addrId.value = addrId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/jnitsmsaddressbook/updateJnitsmsaddressbookView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitsmsaddressbook/addJnitsmsaddressbookView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jnitsmsaddressbook/JnitsmsaddressbookList.do'/>";
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
		    <input type="hidden" name="addrId" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>SMS 주소록 테이블</h3>
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover" summary="SMS 리스트">
								<tbody> 
									<tr>
										<th>ID</th>
										<th>회원 ID</th>
										<th>회원 이름</th>
										<th>회원 전화번호</th>
									</tr>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
					 						<td><c:out value="${result.addrId}" /></a></td>
											<td><c:out value="${result.addrMbrId}" /></td>
											<td><c:out value="${result.addrName}" /></td>
											<td><c:out value="${result.addrPhone}" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<%--
			<div id="page_navi" class="pagination">
				<ul>
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="fn_egov_link_page"
							   />
					<form:hidden path="pageIndex" />
				</ul>
			</div>
			--%>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>