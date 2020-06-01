<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>


<c:set var="registerFlag" value="${empty result ? '등록' : '수정'}"/>			

<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.extends.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jnit.extend.js"/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

var arrListParam = new Array();
var arrListKey = new Array();


$(document).ready(function(){
	
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
		if(clippingKeyNameInList == '' || clippingKeyClassInList == '' || clippingKeyCssQueryInList == ''|| clippingKeyPatternInList == ''){
			alert("Key이름, CssQuery, 패턴을 모두 입력해 주세요.");
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
	
	$('#fwrite').validate({
		rules: {
			url: "required"
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
			if(arrListKey.length == 0){
				alert("수집할 데이터를 입력해 주세요.");
				return false;
			}
			$("#clippingListParam").val(JSON.stringify(arrListParam));
			$("#clippingListKey").val(JSON.stringify(arrListKey));
			form.submit();
		}
	});
});

/* 글 등록 function */
function fn_egov_save() {	
	if($("#url").val() == ''){
		alert("URL을 입력해 주세요.");
		return false;
	}
	if(arrListKey.length == 0){
		alert("수집할 데이터를 입력해 주세요.");
		return false;
	}
	$("#clippingListParam").val(JSON.stringify(arrListParam));
	$("#clippingListKey").val(JSON.stringify(arrListKey));
	
	$("#myModal").modal('toggle');
	$("#myModal .modal-body").html("");
	$.ajax({
		url:"<c:url value="/cms/clipping/crawler/test/urlAction.do" />"
		,data:$("#fwrite").serialize()
		,type:"POST"
		,success:function(data){
			$("#myModal .modal-body").html(data);
		}
		,fail:function(xhr){
			console.log(xhr);
		}
	});
	return false;
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
}

/* 리스트Key 렌더링 */
function renderingListKey(){
	var html = "";
	for(var i = 0; i < arrListKey.length; i++){
		html += "<tr>";
		html += "	<td>" + $("<p/>").text(arrListKey[i].name).html() + "</td>";
		//html += "	<td>" + $("<p/>").text(arrListKey[i].keyClass).html() + "</td>";
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
                   		<h3>수집테스트(URL)</h3>
						<a href="#" onclick="fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 테스트하기</a>
                    </div>
					<div class="widget-content nopadding">
						<form id="fwrite" name="fwrite" method="post" action="<c:url value="/cms/clipping/crawler/parserTestAction.do" />">
						<input type="hidden" id="retUrl" name="retUrl" value="" />
						
						<input type="hidden" id="clippingListParam" name="clippingListParam" value="" />
						<input type="hidden" id="clippingListKey" name="clippingListKey" value="" />
						    <table class="table table-bordered table-striped th_left" summary="수집사이트 등록">
						        <tbody>
						            <tr>
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> URL</th>
						                <td colspan="2"><input type="text" id="url" name="url" value="" placeholder="파라메터를 제외한 URL을 입력해주세요" style="width:98%"/></td>
						            </tr>
						            <tr>
						            	<th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 호출메소드</th>
						                <td colspan="2">
							                <input type="radio" id="clippingConfListMethod_0" name="method" value="GET" <c:if test="${empty result || result.method == 'GET'}">checked="checked"</c:if>/>
							                <label for="clippingConfListMethod_0">GET</label>
							                <input type="radio" id="clippingConfListMethod_1" name="method" value="POST" <c:if test="${result.method == 'POST'}">checked="checked"</c:if>/>
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
						                <th class="Jnit_boardDepth2" width="10%"><font color="red">*</font> 수집데이터</th>
						                <td colspan="2">
										<table class="table table-bordered table-striped table-hover" summary="키추가" style="margin-bottom: 0px;">
											<tbody>
												<tr>
													<th>개별추가</th>
													<td>
												        <label for="clippingKeyNameInList">Key이름 <i class="icon-question-sign tip-bottom" data-original-title="Key이름값이 존재하면 수정됩니다."></i>:</label><input type="text" id="clippingKeyNameInList" name="clippingKeyNameInList" value="" />
												        <label for="clippingKeyClassInList">분석Class :</label><input type="text" id="clippingKeyClassInList" name="clippingKeyClassInList" value="${defaultParser }" />
												        <label for="clippingKeyCssQueryInList">CssQuery :</label><input type="text" id="clippingKeyCssQueryInList" name="clippingKeyCssQueryInList" value="" />
												        <label for="clippingKeyNameInList">패턴 :</label><input type="text" id="clippingKeyPatternInList" name="clippingKeyPatternInList" value="" />
												        <label for="isdetailidInList">고유ID여부 <i class="icon-question-sign tip-bottom" data-original-title="상세페이지 호출시 사용됩니다."></i>:</label><input type="checkbox" id="isdetailidInList" name="isdetailidInList" value="1" />
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
								                		<th>Pattern</th>
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

<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel"></h3>
	</div>
	<div class="modal-body">
		
	</div>
	<div class="modal-footer">
		<span id="actionBtn"></span>
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>		
	</div>
</div>

<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<c:set var="noform" value="Y" />
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>