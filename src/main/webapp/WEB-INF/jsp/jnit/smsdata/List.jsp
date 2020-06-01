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
<script type="text/javaScript" language="javascript" defer="defer">
<!--
<%--
/* 글 수정 화면 function */
function fn_egov_select(smsId) {
    document.getElementById("listForm").smsId.value = smsId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/smsEdit.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/smsAdd.do'/>";
   	document.getElementById("listForm").submit();		
}
--%>

$(document).ready(function(){
	
	$("button[name='msgDel']").on("click", function(e){
		e.preventDefault();
		
		var thisVal = $(this).val();
		var url = "<c:url value="/cms/sms/delProc.do" />?seqno="+thisVal;
		$("#listForm").attr("action", url);
		$("#listForm").submit();
		
	});
	
});

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/smsdata/list.do'/>";
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
		    <input type="hidden" name="smsId" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>SMS 테이블</h3>
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover" summary="SMS 리스트">
								<thead>
									<tr>
										<th>순번</th>
										<th>보낸 번호</th>
										<th>받은 번호</th>
										<th>메세지 내용</th>
										<th>처리시각</th>
										<th>상태</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(resultList) < 1 }">
										<tr><td colspan="6" style="text-align: center;">해당 데이터가 존재하지 않습니다.</td></tr>
									</c:if>
									<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td><c:out value="${result.seqno}"/></td>
										<td><c:out value="${result.sphone1}"/>-<c:out value="${result.sphone2}"/>-<c:out value="${result.sphone3}"/></td>
										<td><c:out value="${result.rphone1}"/>-<c:out value="${result.rphone2}"/>-<c:out value="${result.rphone3}"/></td>
										<td><c:out value="${result.msg}"/></td>
										<td><c:out value="${result.indate}"/>. <c:out value="${result.intime}"/></td>
										<td><c:out value="${result.result == '0' ? '전송대기' : result.result == 'Y' ? '성공여부 확인중' : result.result == '2' ? '전송완료' :'전송실패'}"/></td>
										<td><button id="msgDel${status.count}" name="msgDel" class="btn btn-small" value="${result.seqno}">삭제</button></td>
									</tr>
									</c:forEach>
								</tbody>
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
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>