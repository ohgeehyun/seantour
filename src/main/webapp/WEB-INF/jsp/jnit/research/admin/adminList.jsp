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
<style>
	table.content2_table th{text-align:left;padding-left:8px;}
	table.content2_table td{padding-left:10px;}
	table.content2_table table td{padding-left:0;}
</style>
<script src="<c:url value="/resources/js/jquery.form.js"/> "></script>
<script type="text/javascript">
<!--
function fn_egov_del(adminId){
	if(confirm("삭제하시겠습니까?")){
		document.getElementById("listForm").adminId.value =adminId;
		document.getElementById("listForm").screenMode.value = "up";
		document.getElementById("listForm").pageIndex.value = "1";
		document.getElementById("listForm").action = "<c:url value='/cms/admin/deladminProc.do'/>";
		document.getElementById("listForm").submit();
	}
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	$("#mbrSearch").empty();
	$.ajax({
		typw : "POST",
		url : "<c:url value='/cms/admin/addView.do'/>?ajax=Y&contentEdit=adm",
		data : ""
	}).done(function(data){
		$("#mbrSearch").append(data);
		$("#myModal").modal("toggle");
	});
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/admin/adminList.do'/>";
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
						<h3>관리자</h3>
						<c:if test="${isAdmin == ture}">
							<a href="javascript:fn_egov_addView();" class="btn btn-small">등록</a>
						</c:if>
					</div>
					<div class="widget-content nopadding">
					    <input type="hidden" name="screenMode" />
					    <input type="hidden" name="adminId" id="adminId" />
						
						<table class="table table-bordered table-striped table-hover">
							<thead>
								<tr>
									<th width="25%">관리자ID</th>
									<th>이름</th>
									<th>직급</th>
									<th>부서</th>
									<th>등록일</th>
									<th>등록자</th>
									<c:if test="${isAdmin == ture}">
										<th></th>
									</c:if>
								</tr>
							</thead>
							<tbody>	
								
								<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td><c:out value="${result.mbrLogin}"/></a></td>
									<td><c:out value="${result.mbrNm}"/></td>
									<td><c:out value="${result.posNm}"/></td>
									<td><c:out value="${result.orgNm}"/></td>
									<td><c:out value="${result.created}"/></td>
									<td><c:out value="${result.createWho}"/></td>
									<c:if test="${isAdmin == ture}">
										<td><a href="javascript:fn_egov_del('<c:out value="${result.adminId }"/>');" class="btn btn-small">삭제</a></td>
									</c:if>
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
				<div class="row-fluid">
					<div class="widget-box">
						<div class="widget-content nopadding cmstipbox">
							<table class="table table-bordered table-striped th_left">
							<caption>cms TIP</caption>
							<tbody>
							<tr>
								<th colspan="2">
									<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
								</th>
								<td>
									<b>설문조사의 관리 권한을 갖는 아이디를 등록합니다.</b>
								</td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
  </div>
  <div class="modal-body">
	<div id="mbrSearch"></div>
  </div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>