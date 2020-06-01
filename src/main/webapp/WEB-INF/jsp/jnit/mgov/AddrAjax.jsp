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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function(){
	
	$("#chkBoxAll").click(function(e){
		e.preventDefault();
		
		var chk = $("[name='chkBox']").is(":checked");
		
		if(chk == false){
			$("[name='chkBox']").attr("checked",true);
		}else{
			$("[name='chkBox']").attr("checked",false);
		}
		
		var size = $("[name='chkBox']:checked").length;
		$("#addrCount").text(" [선택 갯수 : " + size + " ]");
		
	});
	
	$("[name='chkBox']").click(function(){
		var size = $("[name='chkBox']:checked").length;
		$("#addrCount").text(" [선택 갯수 : " + size + " ]");
	});
	
});
</script>
<table class="table table-bordered table-striped table-hover" summary="SMS 주소록 리스트">
	<tbody> 
		<tr>
			<th><button id="chkBoxAll" class="btn btn-small">전체선택</button></th>
			<th>회원 이름</th>
			<th>회원 전화번호</th>
		</tr>
		<c:if test="${fn:length(resultList) < 1}">
			<tr>
				<td colspan="3">해당 데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:if test="${fn:length(resultList) > 0}">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td style="text-align: center;"><input type="checkbox" id="chkBox${status.index}" name="chkBox" value="${result.listId},${result.mbrNm},${result.phone}" /></td>
					<td><c:out value="${result.mbrNm}" /></td>
					<td><c:out value="${result.phone}" /></td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>