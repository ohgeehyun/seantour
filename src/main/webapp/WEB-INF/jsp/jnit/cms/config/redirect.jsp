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
function Jnit_save(){
	frm = document.getElementById("redirectForm");
	frm.action = "<c:url value='/cms/config/redirectSave.do'/>";
	frm.submit();
}

function Jnit_add(){
	var num = Number($("#addCount").val())+1;
	var html =	 ""
				+"<tr>"
					+"<td>"+num+"</td>"
					+"<td><input type='text' id='redirectNm"+num+"' name='redirectNm"+num+"' style='width: 98%'/></td>"
					+"<td><input type='text' id='redirectValue"+num+"' name='redirectValue"+num+"' style='width: 98%'/><td>"
				+"</tr>";
	$("#redirectTable").append(html);
	$("#addCount").val(num);
	$(".table td").css('text-align','center');
	$(".table td").css('vertical-align','middle');
	//$("#redirectNm"+num).focus();
}
/*
function Jnit_delete(trId){
	if(confirm("정말 삭제 하시겠습니까?")){
		$("#"+trId).remove();
	}
}
*/
$(document).ready(function(){
	//기본세팅
	$(".table td").css('text-align','center');
	$(".table td").css('vertical-align','middle');
});
//-->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form id="redirectForm" name="redirectForm" method="post">
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:Jnit_save();" class="btn btn-small">저장</a>
						<a href="javascript:Jnit_add();" class="btn btn-small">추가</a>						
					</div>
					<div class="widget-content nopadding">
						<input type="hidden" id="addCount" name="addCount" value="${redirectCount}"/> 
						<table id="redirectTable" class="table table-bordered">
							<tr>
								<th>번호</th>
								<th>도메인</th>
								<th colspan="2">redirect</th>								
							</tr>							
							<c:forEach var="result" items="${resultList }" varStatus="status">
							<tr id="redirectTr${status.count }">
								<td><c:out value="${status.count }"/></td>
								<td><input type="text" id="redirectNm${status.count }" name="redirectNm${status.count }" value="${result.key }" style="width: 98%"/></td>
								<td><input type="text" id="redirectValue${status.count }" name="redirectValue${status.count }" value="${result.value }" style="width: 98%"/></td>
								<td><a href="javascript:Jnit_delete('redirectTr${status.count }');">삭제</a></td>
							</tr>
							</c:forEach>							
						</table>
					</div>
				</div>
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>