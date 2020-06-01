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
	
	$("#addList").click(function(e){
		e.preventDefault();

		var listSize = $("input[name=resList]:checked").size();
		var grpTypeVal = $.trim($("#grpTypeAjax").val());
		var size = "";
		
		if(listSize == 0){
			alert("추가할 번호를 선택해주세요.");
			$("#boxSelect").focus();
			return false;
		}else if(grpTypeVal == ''){
			alert("추가할 주소록을 선택해주세요.");
			$("#grpTypeAjax").focus();
			return false;
		}
		
		$("#smsAjaxForm").submit();
		window.location.href="#";
	});
	
	$("#boxSelect").click(function(e){
		e.preventDefault();
		
		var boo = $("[name='resList']").is(":checked");
		
		if(boo == true){
			$("[name='resList']").attr('checked', false);
		}else{
			$("[name='resList']").attr('checked', true);
		}
		
	});
});
</script>
<form id="smsAjaxForm" action="<c:url value="/cms/sms/addressbookAjaxAddProc.do"/>" method="post">
<table class="table table-bordered table-striped th_left">
	<tbody>
		<c:if test="${fn:length(result) > 0}">
			<tr>
				<th>
					<select id="grpTypeAjax" name="grpTypeAjax">
					
					</select>
					<button class="btn btn-small" id="boxSelect" style="float: left; margin-right: 10px;">전체 선택/해제</button>
					<button class="btn btn-small" id="addList" style="float: right; margin-right: 3%;">추가</button>
				</th>
			</tr>
		<c:forEach var="item" items="${result}" varStatus="status">
		<c:if test="${item.mobile != '' && fn:substring(item.mobile,0,3) == '010' || fn:substring(item.mobile,0,3) == '011' || fn:substring(item.mobile,0,3) == '016' || fn:substring(item.mobile,0,3) == '017' || fn:substring(item.mobile,0,3) == '018' || fn:substring(item.mobile,0,3) == '019'}">
			<tr>
				<td>
					<input type="checkbox" name="resList" value="${item.mobile},${item.mbrNm}" />&nbsp;${item.mobile}(${item.mbrNm})&nbsp;&nbsp;[${item.orgsubnm} / ${item.possubnm}]
				</td>
			</tr>
		</c:if>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(result) == 0}">
			<tr>
				<td style="text-align: center;"><strong style="color: black;">검색 결과가 존재하지 않습니다.</strong></td>
			</tr>
		</c:if>
	</tbody>
</table>
</form>