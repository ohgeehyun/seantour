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

<script type="text/javascript">
<!--
/* pagination 페이지 링크 function */
function fn_egov_hist_page(pageNo){	
	var mgmtId = $("#mgmtId").val();
	var mgmtType = $("#mgmtType").val();
	
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/mgmt/hist/list.do' />",
		data:"mgmtId="+mgmtId+"&mgmtType="+mgmtType+"&pageIndex="+pageNo
	}).done(function(data){	
		$("#listModal").empty();
		$("#listModal").append(data);		
	});	
}

function fn_egov_recover(histId){	
	if(confirm("정말 복구 하시겠습니까?")){
		var mgmtType = $("#mgmtType").val();
		var mgmtId = $("#mgmtId").val();
		$.ajax({
			type:"post",
			url:"<c:url value='/cms/mgmt/hist/recover.do'/>",
			data :"histId="+histId+"&mgmtId="+mgmtId+"&mgmtType="+mgmtType
		}).done(function(data){			
			var json = $.parseJSON(data);
			if(json.status == 'success'){
				alert("복구되었습니다");				
				$('#myModal').modal('toggle');
				location.href = json.path;
			}else{
				alert("복구 할 수 없습니다.");
			}						
		});
	}
}
 // -->
</script>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
   <input type="hidden" name="screenMode" />
<input type="hidden" name="histId" />

<div class="row-fluid">
	<div class="span12">
		<div class="widget-box">
			<!-- <div class="widget-title">
				
			</div> -->
			<div class="widget-content nopadding">
				<table class="table table-borderd">
				<tr>							
					<th>수정일</th>
					<th>수정한사람</th>
					<th>아이피</th>
					<th>복구</th>
				</tr>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>
						<fmt:formatDate value="${dateMap[result.histId] }" pattern="yyyy-MM-dd HH:mm"/>						
					</td>
					<td><c:out value="${mbrNmMap[result.histId]}"/></td>
					<td><c:out value="${result.mgmtActIp }"/></td>
					<td><a href="javascript:fn_egov_recover('<c:out value="${result.histId }"/>');" class="btn btn-small">선택</a></td>							
	   			</tr>
				</c:forEach>
			</table>
			</div>
		</div>
		<div id="page_navi" class="pagination">
			<ui:pagination paginationInfo = "${paginationInfo}"
					   type="jnitDefault"
					   jsFunction="fn_egov_hist_page"
					   />
			<form:hidden path="pageIndex" />
		</div>
	</div>
</div>
</form:form>