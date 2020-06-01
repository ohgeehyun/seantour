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
	
	$("#boxSelect").click(function(e){
		e.preventDefault();
		
		var boo = $("[id='resList']").is(":checked");
		
		if(boo == true){
			$("[id='resList']").attr('checked', false);
		}else{
			$("[id='resList']").attr('checked', true);
		}
		
	});
	
	$("#addList").click(function(e){
		e.preventDefault();
		
		var listSize = $("input[name=resList]:checked").size();
		var thisVal = "";
		$("[name='resList']:checked").each(function(index){
			
			thisVal = $(this).val().replace("-","").replace("-","");
			var thisSize = $("option[value='"+thisVal+"']").length;
			if(thisSize > 0){
				if(!confirm("이미 중복되는 번호가 존재 합니다.\n계속 진행 하시겠습니까?")){
					return false;
				}
			}else{
				var sizeChk = "";
					
					var valArr = $(this).val().split(",");
					var mPhone = valArr[0].replace("-","").replace("-","").replace(" ","");
					var mId = valArr[1];
					sizeChk = $("#phoneList option[value='"+mPhone+"']").length;
					
					
					if(sizeChk > 0){
						if(confirm("중복되는 핸드폰 번호가 존재합니다.("+mPhone+") \n계속 진행하시겠습니까?")){
							return false;	
						}
					}
					
					$("#phoneList").append("<option value="+mPhone+','+mId+" selected='selected'>"+mPhone+"("+mId+")</option>");
					$("#phoneList").select2();
			}
		});
		
		if(listSize == 0){
			alert("추가할 번호를 선택해주세요.");
			$("#boxSelect").focus();
			return false;
		}
	});
});
</script>
<table class="table table-bordered table-striped th_left">
	<tbody>
		<c:if test="${fn:length(result) > 0}">
			<tr>
				<button class="btn btn-small" id="boxSelect" style="float: left;">전체 선택/해제</button>
				<button class="btn btn-small" id="addList" style="float: right; margin-right: 3%;">추가</button>
			</tr>
		<c:forEach var="item" items="${result}" varStatus="status">
		<c:if test="${item.mobile != '' && fn:substring(item.mobile,0,3) == '010' || fn:substring(item.mobile,0,3) == '011' || fn:substring(item.mobile,0,3) == '016' || fn:substring(item.mobile,0,3) == '017' || fn:substring(item.mobile,0,3) == '018' || fn:substring(item.mobile,0,3) == '019'}">
			<tr>
				<td>
					<input type="checkbox" id="resList" name="resList" value="${item.mobile},${item.mbrNm}" />&nbsp;${item.mobile}(${item.mbrNm})&nbsp;&nbsp;[${item.orgsubnm} / ${item.possubnm}]
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