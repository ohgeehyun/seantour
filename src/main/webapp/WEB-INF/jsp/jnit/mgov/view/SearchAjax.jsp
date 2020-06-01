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
		
		var listSize = $("input[name='resList']").length;
		var boo = $("[id='resList']").is(":checked");
		
		if(listSize < 1){
			return false;
		}else if(boo == true){
			$("[name='resList']").attr('checked', false);
		}else{
			$("[name='resList']").attr('checked', true);
		}
		
	});
	
	$("#addList").click(function(e){
		e.preventDefault();
		
		var listSize = $("input[name=resList]:checked").size();
		var thisVal = "";
		
		if(listSize < 1){
			alert("1개 이상 선택해주세요.");
			return false;
		}
		
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
<button class="member_list_btn" id="boxSelect" style="float: left;">전체 선택/해제</button>
<%-- <button class="btn btn-small" id="addList" style="float: right; margin-right: 3%;">추가</button> --%>
<table class="member_list_table" summary="체크, 성명, 핸드폰번호, 부서명의 회원조회 정보를 제공합니다.">
	<caption>회원정보 조회</caption>
	<thead>
		<tr>
			<th scope="row">선택</th>
			<th scope="row">성명</th>
			<th scope="row">핸드폰번호</th>
			<th scope="row">부서명</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(result) > 0}">
			<c:forEach var="item" items="${result}" varStatus="status">
				<c:if test="${item.mobile != '' && fn:substring(item.mobile,0,3) == '010' || fn:substring(item.mobile,0,3) == '011' || fn:substring(item.mobile,0,3) == '016' || fn:substring(item.mobile,0,3) == '017' || fn:substring(item.mobile,0,3) == '018' || fn:substring(item.mobile,0,3) == '019'}">
					<tr>
						<td>
							<input type="checkbox" id="resList${status.count}" name="resList" value="${item.mobile},${item.mbrNm}" />
						</td>
						<td>
							<c:out value="${item.mbrNm}" />
						</td>
						<td>
							<c:out value="${item.mobile}" />
						</td>
						<td>
							<c:out value="${item.possubnm}" />
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(result) == 0}">
			<tr>
				<td colspan="4" style="text-align: center;"><strong>검색 결과가 존재하지 않습니다.</strong></td>
			</tr>
		</c:if>
	</tbody>
</table>