<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<%
request.setAttribute("reslash","\\");
request.setAttribute("reslashdouble","\\\\");
%>


<c:set var="registerFlag" value="${empty result ? '등록' : '수정'}"/>			

<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.extends.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jnit.extend.js"/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
var arrSite = new Array();
<c:forEach items="${clippingSiteList }" var="site">
	arrSite.push({"clippingSiteId":"${site.clippingSiteId}","realClippingUrl":"<c:out value="${site.realClippingUrl}" />"});
</c:forEach>


var arrListParam = new Array();
var arrDetailParam = new Array();
var arrListKey = new Array();
var arrDetailKey = new Array();

$(document).ready(function(){
<c:forEach items="${result.clippingParamList}" var="clippingParam">
	add${clippingParam.clippingParamType == 'LIST'?'List':'Detail'}Param("<c:out value="${clippingParam.clippingParamName}" />","<c:out value="${clippingParam.clippingParamValue}" />");
</c:forEach>
<c:forEach items="${result.clippingKeyList}" var="clippingKey">
	add${clippingKey.clippingKeyType == 'LIST'?'List':'Detail'}Key(
			"<c:out value="${clippingKey.clippingKeyName}" />", 
			"<c:out value="${clippingKey.clippingKeyClass}" />", 
			$("<p/>").html("<c:out value="${fn:replace(clippingKey.clippingKeyCssQuery,reslash,reslashdouble)}" />").text(), 
			$("<p/>").html("<c:out value="${fn:replace(clippingKey.clippingKeyPattern,reslash,reslashdouble)}" />").text(), 
			"${clippingKey.isdetailid?'1':'0'}"
		);
</c:forEach>

	
	
	$("#clippingSiteId").change(function(){
		var realClippingUrl = "";
		for(var i = 0; i < arrSite.length; i++){
			if(this.value == arrSite[i].clippingSiteId){
				realClippingUrl = arrSite[i].realClippingUrl;	
			}			
		}
		$("#realClippingUrl").html(realClippingUrl);
	});
	$("#clippingSiteId").trigger("change");
	
	// 리스트파라메터 추가/수정
	$("#btnListParamAdd").click(function(){
		
		var listParamName = $("#listParamName").val();
		var listParamValue = $("#listParamValue").val();
		
		if(listParamName == '' || listParamValue == ''){
			alert("NAME과 VALUE 값을 모두 입력해 주세요.");
			return false;
		}
		
		addListParam(listParamName, listParamValue);
		$("#listParamName").val("");
		$("#listParamValue").val("");
		renderingListParam();
		return false;
	});
	renderingListParam();
	

	// 리스트Key 추가/수정
	$("#btnListKeyAdd").click(function(){
		
		var clippingKeyNameInList = $("#clippingKeyNameInList").val();
		var clippingKeyClassInList = $("#clippingKeyClassInList").val();
		var clippingKeyCssQueryInList = $("#clippingKeyCssQueryInList").val();
		var clippingKeyPatternInList = $("#clippingKeyPatternInList").val();
		var isdetailidInList = $("#isdetailidInList").is(":checked")?'1':'0';
		if(clippingKeyNameInList == '' || clippingKeyClassInList == '' || clippingKeyCssQueryInList == '' ){
			alert("Key이름, 클래스, CssQuery는 필수값입니다.");
			return false;
		}
		
		addListKey(clippingKeyNameInList, clippingKeyClassInList, clippingKeyCssQueryInList, clippingKeyPatternInList, isdetailidInList);
		$("#clippingKeyNameInList").val("");
		$("#clippingKeyClassInList").val("${defaultParser}");
		$("#clippingKeyCssQueryInList").val("");
		$("#clippingKeyPatternInList").val("");
		$("#isdetailidInList").prop("checked",false);
		$("#isdetailidInList").parent().removeClass("checked");
		renderingListKey();
		return false;
	});
	renderingListKey();
	
	
	//상세페이지 수집 설정
	$("input[name=clippingConfDetailUse]").click(function(){
		$("#trDetailUrl").hide();
		$("#trDetailMethod").hide();
		$("#trDetailParam").hide();
		$("#trDetailKey").hide();
		if(this.value == 1){
			if(existObjectInArray(arrListKey,{"isid":'1'},"isid") == -1){
				alert("리스트수집의 수집데이터에 고유ID로 설정된 Key값이 하나 이상 존재해야 합니다.");
				$("#clippingConfDetailUse_1").parent().removeClass("checked");
				$("#clippingConfDetailUse_1").attr("checked",false);
				$("#clippingConfDetailUse_0").parent().addClass("checked");
				$("#clippingConfDetailUse_0").attr("checked",true);
				return false;
			}
			$("#trDetailUrl").show();
			$("#trDetailMethod").show();
			$("#trDetailParam").show();
			$("#trDetailKey").show();
		}else{
			
		}
		
	});
	if($("#clippingConfDetailUse_1").is(":checked")){
		$("#clippingConfDetailUse_1").trigger("click");	
	}else{
		$("#clippingConfDetailUse_0").trigger("click");
	}
	

	// 상세파라메터 추가/수정
	$("#btnDetailParamAdd").click(function(){
		
		var detailParamName = $("#detailParamName").val();
		var detailParamValue = $("#detailParamValue").val();
		
		if(detailParamName == '' || detailParamValue == ''){
			alert("NAME과 VALUE 값을 모두 입력해 주세요.");
			return false;
		}
		
		//리스트 키에 고유ID로 존재하는지 체크
		var listKeyIdx = existObjectInArray(arrListKey,{"name":detailParamName},"name");
		if(listKeyIdx > -1){
			if(arrListKey[listKeyIdx].isid == '1'){
				alert("리스트 수집데이터의 고유ID로 이미 설정되어있습니다.");
				return false;
			}
		}
		
		addDetailParam(detailParamName, detailParamValue);
		$("#detailParamName").val("");
		$("#detailParamValue").val("");
		renderingDetailParam();
		return false;
	});
	renderingDetailParam();
	
	// 상세Key 추가/수정
	$("#btnDetailKeyAdd").click(function(){
		
		var clippingKeyNameInDetail = $("#clippingKeyNameInDetail").val();
		var clippingKeyClassInDetail = $("#clippingKeyClassInDetail").val();
		var clippingKeyCssQueryInDetail = $("#clippingKeyCssQueryInDetail").val();
		var clippingKeyPatternInDetail = $("#clippingKeyPatternInDetail").val();
		var isdetailidInDetail = $("#isdetailidInDetail").is(":checked")?'1':'0';
		if(clippingKeyNameInDetail == '' || clippingKeyClassInDetail == '' || clippingKeyCssQueryInDetail == ''){
			alert("Key이름, 클래스, CssQuery는 필수값입니다.");
			return false;
		}
		
		addDetailKey(clippingKeyNameInDetail, clippingKeyClassInDetail, clippingKeyCssQueryInDetail, clippingKeyPatternInDetail, isdetailidInDetail);
		$("#clippingKeyNameInDetail").val("");
		$("#clippingKeyClassInDetail").val("${defaultParser}");
		$("#clippingKeyCssQueryInDetail").val("");
		$("#clippingKeyPatternInDetail").val("");
		renderingDetailKey();
		return false;
	});
	renderingDetailKey();
	
	
	$('#fwrite').validate({
		rules: {
			clippingConfName: "required"
			,clippingConfRepeatInterval: "required"
			,clippingConfListUrl: "required"
			,clippingConfListMethod: "required"
			,clippingConfListPageParam: "required"
			,clippingConfListPageParamMax: {"required":true,number:true,min:1}
		},
		errorClass: 'help-block',
		errorElement: 'span',
		highlight: function(element, errorClass, validClass) {
			$(element).removeClass('has-success').addClass('has-error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).removeClass('has-error').addClass('has-success');
		},
		submitHandler:function(form){
			$("#clippingListParam").val(JSON.stringify(arrListParam));
			$("#clippingListKey").val(JSON.stringify(arrListKey));
			$("#clippingDetailParam").val(JSON.stringify(arrDetailParam));
			$("#clippingDetailKey").val(JSON.stringify(arrDetailKey));
			form.submit();
		}
	});
});

/* 글 목록 화면 function */
function fn_egov_selectList() {
   	history.back();
}

function Jnit_delete(){
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			type:"post",
			url:"<c:url value='/cms/clipping/conf/index.do'/>",
			data:{ccMode:"deleteAction",clippingConfId:$("#clippingConfId").val()},
			dataType : "json"
		}).done(function(data){			
			if(data.isSuccess == true){
				alert("정상처리되었습니다");
				location.href= "<c:url value='?'/>";
			}else{
				alert("삭제에 실패하였습니다.");				
			}
		});
	}
}
/* 글 등록 function */
function fn_egov_save() {	
	$("#fwrite").submit();
}

/* 리스트파라메터 추가/수정(같은 파라메터가 존재하면 수정) */
function addListParam(paramName, paramValue){
	var obj = {"name":paramName, "value":paramValue};
	pushUniqueObjectInArray(arrListParam,obj,"name");
}

/* 리스트파라메터 렌더링 */
function renderingListParam(){
	var html = "";
	for(var i = 0; i < arrListParam.length; i++){
		html += "<tr>";
		html += "	<td>" + $("<p/>").text(arrListParam[i].name).html() + "</td>";
		html += "	<td>" + $("<p/>").text(arrListParam[i].value).html() + "</td>";
		html += "	<td><button class='btn btn-small' style='float: rigth; margin-right: 10px;'>삭제</button></td>";
		html += "</tr>";
	}
	$("#ajax-listClippingParam tbody").html(html);
	$("#ajax-listClippingParam tbody button").click(function(e){
		var obj = {"name":$(e.target).parent().parent().children().eq(0).text()};
		removeObjectInArray(arrListParam,obj,"name");
		renderingListParam();
	});
}



/* 리스트Key 추가/수정(같은 Key가 존재하면 수정) */
function addListKey(name, keyClass, keyCssQuery, keyPattern, isid){
	var obj = {"name":name, "keyClass":keyClass, "keyCssQuery":keyCssQuery, "keyPattern":keyPattern, "isid":isid};
	pushUniqueObjectInArray(arrListKey,obj,"name");
	console.log(arrListKey);
}

/* 리스트Key 렌더링 */
function renderingListKey(){
	var html = "";
	for(var i = 0; i < arrListKey.length; i++){
		html += "<tr>";
		html += "	<td>" + $("<p/>").text(arrListKey[i].name).html() + "</td>";
		html += "	<td>" + $("<p/>").text(arrListKey[i].keyClass).html() + "</td>";
		html += "	<td>" + $("<p/>").text(arrListKey[i].keyCssQuery).html() + "</td>";
		html += "	<td>" + $("<p/>").text(arrListKey[i].keyPattern).html() + "</td>";
		html += "	<td>" + ((arrListKey[i].isid == '1')?"Y":"") + "</td>";
		html += "	<td><button class='btn btn-small' style='float: rigth; margin-right: 10px;'>삭제</button></td>";
		html += "</tr>";
	}
	$("#ajax-listClippingKey tbody").html(html);
	$("#ajax-listClippingKey tbody button").click(function(e){
		var obj = {"name":$(e.target).parent().parent().children().eq(0).text()};
		removeObjectInArray(arrListKey,obj,"name");
		renderingListKey();
	});
	
	// 상세수집확인
	if($("#clippingConfDetailUse_1").is(":checked")){
		$("#clippingConfDetailUse_1").trigger("click");
	}
}



/* 상세파라메터 추가/수정(같은 파라메터가 존재하면 수정) */
function addDetailParam(paramName, paramValue){
	var obj = {"name":paramName, "value":paramValue};
	pushUniqueObjectInArray(arrDetailParam,obj,"name");
}

/* 상세파라메터 렌더링 */
function renderingDetailParam(){
	var html = "";
	for(var i = 0; i < arrDetailParam.length; i++){
		html += "<tr>";
		html += "	<td>" + $("<p/>").text(arrDetailParam[i].name).html() + "</td>";
		html += "	<td>" + $("<p/>").text(arrDetailParam[i].value).html() + "</td>";
		html += "	<td><button class='btn btn-small' style='float: rigth; margin-right: 10px;'>삭제</button></td>";
		html += "</tr>";
	}
	$("#ajax-detailClippingParam tbody").html(html);
	$("#ajax-detailClippingParam tbody button").click(function(e){
		var obj = {"name":$(e.target).parent().parent().children().eq(0).text()};
		removeObjectInArray(arrDetailParam,obj,"name");
		renderingDetailParam();
	});
}


/* 상세Key 추가/수정(같은 Key가 존재하면 수정) */
function addDetailKey(name, keyClass, keyCssQuery, keyPattern){
	var obj = {"name":name, "keyClass":keyClass, "keyCssQuery":keyCssQuery, "keyPattern":keyPattern};
	pushUniqueObjectInArray(arrDetailKey,obj,"name");
}

/* 상세Key 렌더링 */
function renderingDetailKey(){
	var html = "";
	for(var i = 0; i < arrDetailKey.length; i++){
		html += "<tr>";
		html += "	<td>" + $("<p/>").text(arrDetailKey[i].name).html() + "</td>";
		html += "	<td>" + $("<p/>").text(arrDetailKey[i].keyClass).html() + "</td>";
		html += "	<td>" + $("<p/>").text(arrDetailKey[i].keyCssQuery).html() + "</td>";
		html += "	<td>" + $("<p/>").text(arrDetailKey[i].keyPattern).html() + "</td>";
		html += "	<td><button class='btn btn-small' style='float: rigth; margin-right: 10px;'>삭제</button></td>";
		html += "</tr>";
	}
	$("#ajax-detailClippingKey tbody").html(html);
	$("#ajax-detailClippingKey tbody button").click(function(e){
		var obj = {"name":$(e.target).parent().parent().children().eq(0).text()};
		removeObjectInArray(arrDetailKey,obj,"name");
		renderingDetailKey();
	});
}


// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>수집설정 ${registerFlag }</h3>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> ${registerFlag }</a>
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<c:if test="${!empty result }"><a href="javascript:Jnit_delete();" class="btn btn-small"><i class="icon-minus-sign"></i> 삭제</a></c:if>
                    </div>
					<div class="widget-content nopadding">
						<form id="fwrite" name="fwrite" method="post" action="<c:url value="/cms/clipping/conf/index.do" />">
						<input type="hidden" id="retUrl" name="retUrl" value="" />
						<input type="hidden" id="ccMode" name="ccMode" value="writeAction" />
						<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value="${searchVO.pageIndex }"/>" />
						<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value="${searchVO.searchCondition }"/>" />
						<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword }"/>" />
						
						<input type="hidden" id="clippingListParam" name="clippingListParam" value="" />
						<input type="hidden" id="clippingListKey" name="clippingListKey" value="" />
						<input type="hidden" id="clippingDetailParam" name="clippingDetailParam" value="" />
						<input type="hidden" id="clippingDetailKey" name="clippingDetailKey" value="" />
						    <table class="table table-bordered table-striped th_left" summary="수집사이트 등록">
						        <tbody>
						            <tr>
						                <th width="10%">코드</th>
						                <td colspan="3"><input type="text" id="clippingConfId" name="clippingConfId" value="<c:out value='${result.clippingConfId}'/>" readonly placeholder="자동입력됩니다."/></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 수집사이트</th>
						                <td colspan="3">
						                <select id="clippingSiteId" name="clippingSiteId">
						                <c:forEach items="${clippingSiteList }" var="site">
						                	<c:set var="selected" value="" />
						                	<c:if test="${site.clippingSiteId == result.clippingSiteId }"><c:set var="selected" value=" selected='selected'" /></c:if>
						                	<option value="${site.clippingSiteId }"${selected }><c:out value="${site.clippingSiteName }" /></option>
						                </c:forEach>
						                </select>
						                	사이트호출URL : <span id="realClippingUrl"></span>
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 수집설정명</th>
						                <td colspan="3"><input type="text" id="clippingConfName" name="clippingConfName" value="<c:out value='${result.clippingConfName}'/>" placeholder="수집설정명."/></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 반복호출간격(mSec)</th>
						                <td colspan="3"><input type="text" id="clippingConfRepeatInterval" name="clippingConfRepeatInterval" value="<c:out value='${result.clippingConfRepeatInterval}'/>" placeholder="단위:millisecond"/></td>
						            </tr>
						            <tr>
						            	<th rowspan="3">신규데이터수집</th>
						                <th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 수집주기</th>
						                <td colspan="3">
						                <c:forEach begin="0" end="23" var="i">
						                	<c:set var="checked" value="" />
						                	<c:forEach items="${result.clippingPeriodList }" var="period"><c:if test="${i == period.clippingPeriodHour }"><c:set var="checked" value=" checked='checked'" /></c:if></c:forEach>
						                	<input type="checkbox" id="clippingPeriodHour_${i }" name="clippingPeriodHour" value="${i }" ${checked }/>
						                	<label for="clippingPeriodHour_${i }">${i }시</label>
						                </c:forEach>
						                </td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 비교범위</th>
						                <td colspan="3">
						                	<input type="text" id="clippingConfListPageParamMax" name="clippingConfListPageParamMax" value="<c:out value='${result.clippingConfListPageParamMax}'/>" placeholder="페이지번호" /> Page까지
						                </td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 기존데이터관련</th>
						                <td colspan="3">
						                	<input type="radio" id="clippingConfDataUpdate_0" name="clippingConfDataUpdate" value="0" <c:if test="${empty result || !result.clippingConfDataUpdate}">checked="checked"</c:if>/>
							                <label for="clippingConfDataUpdate_0">기존데이터가 있으면 입력안함</label>
							                <input type="radio" id="clippingConfDataUpdate_1" name="clippingConfDataUpdate" value="1" <c:if test="${result.clippingConfDataUpdate}">checked="checked"</c:if>/>
							                <label for="clippingConfDataUpdate_1">기존데이터가 있으면 업데이트</label>
						                </td>
						            </tr>
						            <tr>
						            	<th rowspan="5">리스트수집설정</th>
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> URL</th>
						                <td colspan="2"><input type="text" id="clippingConfListUrl" name="clippingConfListUrl" value="<c:out value='${result.clippingConfListUrl}'/>" placeholder="사이트호출URL과 파라메터를 제외한 URL을 입력해주세요" style="width:98%"/></td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 호출메소드</th>
						                <td colspan="2">
							                <input type="radio" id="clippingConfListMethod_0" name="clippingConfListMethod" value="GET" <c:if test="${empty result || result.clippingConfListMethod == 'GET'}">checked="checked"</c:if>/>
							                <label for="clippingConfListMethod_0">GET</label>
							                <input type="radio" id="clippingConfListMethod_1" name="clippingConfListMethod" value="POST" <c:if test="${result.clippingConfListMethod == 'POST'}">checked="checked"</c:if>/>
							                <label for="clippingConfListMethod_1">POST</label>
						                </td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 호출파라메터</th>
						                <td colspan="2">
										<table class="table table-bordered table-striped table-hover" summary="키추가" style="margin-bottom: 0px;">
											<tbody>
												<tr>
													<th>개별추가</th>
													<td>
														<input type="hidden" id="listParamId" name="listParamId" value="" />
												        <label for="listParamName">NAME <i class="icon-question-sign tip-bottom" data-original-title="NAME값이 존재하면 수정됩니다."></i> :</label><input type="text" id="listParamName" name="listParamName" value="" />
												        <label for="listParamValue">VALUE :</label><input type="text" id="listParamValue" name="listParamValue" value="" />
												        <button id="btnListParamAdd" class="btn btn-small" style="float: rigth; margin-right: 10px;">추가</button>
													</td>
												</tr>
											</tbody>
										</table>
										<div style="height:200px; -ms-overflow-y: scroll;">
											<div class="widget-content nopadding">
											<table class="table table-bordered table-striped table-hover" id="ajax-listClippingParam">
							                	<thead>
								                	<tr>
								                		<th>NAME</th>
								                		<th>VALUE</th>
								                		<th width="10%">삭제</th>
								                	</tr>
							                	</thead>
							                	<tbody>
							                	</tbody>
							                </table>
											</div>
										</div>
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 페이징</th>
						                <th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 변수명</th>
						                <td><input type="text" id="clippingConfListPageParam" name="clippingConfListPageParam" value="<c:out value='${result.clippingConfListPageParam}'/>" placeholder="페이징변수" /></td>
						            </tr>
						            <tr>
						                <th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 수집데이터</th>
						                <td colspan="2">
										<table class="table table-bordered table-striped table-hover" summary="키추가" style="margin-bottom: 0px;">
											<tbody>
												<tr>
													<th>개별추가</th>
													<td>
												        <label for="clippingKeyNameInList">Key이름 <i class="icon-question-sign tip-bottom" data-original-title="Key이름값이 존재하면 수정됩니다."></i>:</label>
												        	<input type="text" id="clippingKeyNameInList" name="clippingKeyNameInList" value="" />
												        <label for="clippingKeyClassInList">분석Class :</label>
												        	<input type="text" id="clippingKeyClassInList" name="clippingKeyClassInList" value="${defaultParser }" />
												        <label for="clippingKeyCssQueryInList">CssQuery :</label>
												        	<input type="text" id="clippingKeyCssQueryInList" name="clippingKeyCssQueryInList" value="" />
												        <label for="clippingKeyPatternInList">정규식 <i class="icon-question-sign tip-bottom" data-original-title="Match데이터 첫번째 그룹을 가져옵니다.(ex. 모든데이터 : (.*) )"></i>:</label>
												        	<input type="text" id="clippingKeyPatternInList" name="clippingKeyPatternInList" value="" />
												        <label for="isdetailidInList">고유ID여부 <i class="icon-question-sign tip-bottom" data-original-title="상세페이지 호출시 사용됩니다."></i>:</label>
												        	<input type="checkbox" id="isdetailidInList" name="isdetailidInList" value="1" />
														<button id="btnListKeyAdd" class="btn btn-small" style="float: rigth; margin-right: 10px;">추가</button>
													</td>
												</tr>
											</tbody>
										</table>
										<div style="height:200px; -ms-overflow-y: scroll;">
											<div class="widget-content nopadding" id="ajax-listClippingKey">
											<table class="table table-bordered table-striped table-hover">
							                	<thead>
								                	<tr>
								                		<th>Key</th>
								                		<th>Class</th>
								                		<th>CssQuery</th>
								                		<th>정규식</th>
								                		<th>고유ID</th>
								                		<th width="10%">삭제</th>
								                	</tr>
							                	</thead>
							                	<tbody>
							                	</tbody>
							                </table>
											</div>
										</div>
						                </td>
						            </tr>
						            <tr>
						            	<th rowspan="7">상세수집설정</th>
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 수집여부</th>
						                <td colspan="2">
						                    <input type="radio" id="clippingConfDetailUse_0" name="clippingConfDetailUse" value="0" <c:if test="${empty result || !result.clippingConfDetailUse}">checked="checked"</c:if>/>
							                <label for="clippingConfDetailUse_0">수집않함</label>
							                <input type="radio" id="clippingConfDetailUse_1" name="clippingConfDetailUse" value="1" <c:if test="${result.clippingConfDetailUse}">checked="checked"</c:if>/>
							                <label for="clippingConfDetailUse_1">수집</label>
						                </td>
						            </tr>
						            <tr id="trDetailUrl">
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> URL</th>
						                <td colspan="2"><input type="text" id="clippingConfDetailUrl" name="clippingConfDetailUrl" value="<c:out value='${result.clippingConfDetailUrl}'/>" placeholder="사이트호출URL과 파라메터를 제외한 URL을 입력해주세요" style="width:98%"/></td>
						            </tr>
						            <tr id="trDetailMethod">
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 호출메소드</th>
						                <td colspan="2">
							                <input type="radio" id="clippingConfDetailMethod_0" name="clippingConfDetailMethod" value="GET" <c:if test="${empty result || result.clippingConfDetailMethod == 'GET'}">checked</c:if>/>
							                <label for="clippingConfDetailMethod_0">GET</label>
							                <input type="radio" id="clippingConfDetailMethod_1" name="clippingConfDetailMethod" value="POST" <c:if test="${result.clippingConfDetailMethod == 'POST'}">checked</c:if>/>
							                <label for="clippingConfDetailMethod_1">POST</label>
						                </td>
						            </tr>
						            <tr id="trDetailParam">
						                <th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 고유ID제외호출파라메터</th>
						                <td colspan="2">
										<table class="table table-bordered table-striped table-hover" summary="키추가" style="margin-bottom: 0px;">
											<tbody>
												<tr>
													<th>개별추가</th>
													<td>
														<input type="hidden" id="detailParamId" name="detailParamId" value="" />
												        <label for="detailParamName">NAME <i class="icon-question-sign tip-bottom" data-original-title="NAME값이 존재하면 수정됩니다."></i> :</label><input type="text" id="detailParamName" name="detailParamName" value="" />
												        <label for="detailParamValue">VALUE :</label><input type="text" id="detailParamValue" name="detailParamValue" value="" />
												        <button id="btnDetailParamAdd" class="btn btn-small" style="float: rigth; margin-right: 10px;">추가</button>
													</td>
												</tr>
											</tbody>
										</table>
										<div style="height:200px; -ms-overflow-y: scroll;">
											<div class="widget-content nopadding">
											<table class="table table-bordered table-striped table-hover" id="ajax-detailClippingParam">
							                	<thead>
								                	<tr>
								                		<th>NAME</th>
								                		<th>VALUE</th>
								                		<th width="10%">삭제</th>
								                	</tr>
							                	</thead>
							                	<tbody>
							                	</tbody>
							                </table>
											</div>
										</div>
						                </td>
						            </tr>
						            <tr id="trDetailKey">
						                <th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 수집데이터</th>
						                <td colspan="2">
										<table class="table table-bordered table-striped table-hover" summary="키추가" style="margin-bottom: 0px;">
											<tbody>
												<tr>
													<th>개별추가</th>
													<td>
												        <label for="clippingKeyNameInDetail">Key이름 <i class="icon-question-sign tip-bottom" data-original-title="Key이름값이 존재하면 수정됩니다."></i>:</label>
												        	<input type="text" id="clippingKeyNameInDetail" name="clippingKeyNameInDetail" value="" />
												        <label for="clippingKeyClassInDetail">분석Class :</label>
												        	<input type="text" id="clippingKeyClassInDetail" name="clippingKeyClassInDetail" value="${defaultParser }" />
												        <label for="clippingKeyCssQueryInDetail">CssQuery :</label>
												        	<input type="text" id="clippingKeyCssQueryInDetail" name="clippingKeyCssQueryInDetail" value="" />
												        <label for="clippingKeyPatternInDetail">정규식 <i class="icon-question-sign tip-bottom" data-original-title="Match데이터 첫번째 그룹을 가져옵니다.(ex. 모든데이터 : (.*) )"></i>:</label>
												        	<input type="text" id="clippingKeyPatternInDetail" name="clippingKeyPatternInDetail" value="" />
												        <button id="btnDetailKeyAdd" class="btn btn-small" style="float: rigth; margin-right: 10px;">추가</button>
													</td>
												</tr>
											</tbody>
										</table>
										<div style="height:200px; -ms-overflow-y: scroll;">
											<div class="widget-content nopadding" id="ajax-detailClippingKey">
											<table class="table table-bordered table-striped table-hover">
							                	<thead>
								                	<tr>
								                		<th>Key</th>
								                		<th>Class</th>
								                		<th>CssQuery</th>
								                		<th>정규식</th>
								                		<th width="10%">삭제</th>
								                	</tr>
							                	</thead>
							                	<tbody>
							                	</tbody>
							                </table>
											</div>
										</div>
						                </td>
						            </tr>
						    	</tbody>
						    </table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--콘텐츠끝-->
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<c:set var="noform" value="Y" />
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>