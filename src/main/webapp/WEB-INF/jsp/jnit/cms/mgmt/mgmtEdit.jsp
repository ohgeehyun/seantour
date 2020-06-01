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
<%-- <%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %> --%>

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>
<script type="text/javascript">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsmgmtVO").action = "<c:url value='/cms/mgmt/list.do'/>";
   	document.getElementById("jnitcmsmgmtVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {	
	if(confirm("정말 삭제 하시겠습니까?")){
		var mgmtId = $("#mgmtId").val();
	   	var mgmtType = $("#mgmtType").val();
	   	$.ajax({
	   		type :"post",
	   		url :"<c:url value='/mgmt/deleteProc.do'/>",
	   		data :"mgmtId="+mgmtId+"&mgmtType="+mgmtType
	   	}).done(function(data){	   		
	   		var json = $.parseJSON(data);
	   		if(json.status == 'success'){
	   			location.href = json.path;
	   		}else{
	   			if(json.code == 'ERROR 1'){
	   				alert("파일 삭제에 오류가 있습니다.");
	   			}else if(json.code == 'ERROR 2'){
	   				alert("데이터 삭제처리에 오류가 있습니다.");
	   			}else{
	   				alert("오류가 생겨 삭제 할 수 없습니다.");
	   			}
	   		}
	   	});	
	}   	
}

function Jnit_save_bln(){
	var mgmtNm = $("#mgmtNm").val();
	if(mgmtNm == '' || mgmtNm == null){
		alert("파일이름을 작성해주세요.");
		$("#mgmtNm").focus();
		return false;
	}
	var mgmtSort = $("#mgmtSort").val();
	if(mgmtSort == '' || mgmtSort == null){
		if(confirm("정렬순서 입력이 비어있습니다 초기값을 설정하시겠습니까?")){
			$("#mgmtSort").val("0");
		}else{
			$("#mgmtSort").focus();
			return false;
		}
	}else if(mgmtSort.match("^[0-9]+$") == null){
		alert("정렬순서는 숫자만 입력해주시기 바랍니다.");
		$("#mgmtSort").focus();
		return false;
	}else if($("input:checkbox[name='categoryList']:checked").length == 0){
		alert("표시설정을 선택해주시기 바랍니다.");
		$("#categoryList1").focus();
		return false;
	}
	return true;
}
/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsmgmtVO");	
	if(Jnit_save_bln()){
		$.ajax({
			type : "post",
			url : "<c:url value='/cms/ajax/file/name.do'/>",
			data : "mgmtNm="+$("#mgmtNm").val()+"&mgmtType="+$("#mgmtType").val()+"&screenMode=${searchVO.screenMode}&mgmtId="+$("#mgmtId").val()
		}).done(function(data){		
			var json = $.parseJSON(data);
			if(json.status == 'error'){ //error			
				if(json.code == null || json.code == ""){
					alert("같은 이름의 파일이 존재 합니다.");
				}else if(json.code == "ERROR 1"){
					if(confirm("Warning ! CODE "+json.code+" : 변경하신 파일이름은 이미 존재합니다 덮어 씌우시겠습니까?")){
			  			frm.action = "<c:url value='/cms/mgmt/editProc.do'/>";
			  			frm.submit();
			  		}
				}else{
					alert("CODE : "+json.code);
				}			
			}else{ //success
				<c:if test="${registerFlag == '수정'}">	
					frm.action = "<c:url value='/cms/mgmt/editProc.do'/>";
		  			frm.submit();
				</c:if>
				<c:if test="${registerFlag == '등록'}">	
					frm.action = "<c:url value='/cms/mgmt/addProc.do'/>";
					frm.submit();
				</c:if>			
			}
		});	
	}	
}

function fn_history(){	
	var mgmtId = $("#mgmtId").val();
	var mgmtType = $("#mgmtType").val();
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/mgmt/hist/list.do' />",
		data:"mgmtId="+mgmtId+"&mgmtType="+mgmtType
	}).done(function(data){	
		$("#listModal").empty();
		$("#listModal").append(data);
		$('#myModal').modal('toggle');
	});
}

$(document).ready(function(){
	//설정
	$("#mgmtScriptType").select2();
	$("#mgmtHearderYn").select2();
	$("#upfile").uniform();
	$("#s2id_mgmtScriptType").css("width","162px");
	
	//표시설정 기본설정
	<c:if test="${registerFlag == '등록'}">
		$("#categoryList1").attr("checked",true);
	</c:if>
	
	//표시설정 클릭 설정
	$("input:checkbox['categoryList']").click(function(e){		
		if($(this).val() == 'common'){
			$("input:checkbox['categoryList']").each(function(){
				if($(this).val() != 'common') {
					$(this).attr("checked",false);
				}
			});
		}else{
			if($("#categoryList1").is(":checked")){
				$("#categoryList1").attr("checked",false);
			}
		}
	});	
});

// -->
</script>
<%-- Contents Start --%>
<form:form commandName="jnitcmsmgmtVO" method="post" enctype="multipart/form-data">
<input type="hidden" name="mgmtType" id="mgmtType" value="${mgmtType }"/>
<div class="widget-box">
	<div class="widget-title">
		<h3>${registerFlag}</h3>
		<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
		<c:if test="${registerFlag == '수정' }">
			<a href="javascript:fn_egov_delete();" class="btn btn-small btn-del" style="float: right; margin-right: 10px;"><i class="icon-minus-sign"></i> 삭제</a>
		</c:if>				
	</div>
	<div class="widget-content nopadding">
		<table class="table table-borderd ">
			<tr>
				<th style="width: 15%"><font color="red">*</font>파일이름</th>
				<td style="width: 35%">
					<form:input path="mgmtNm" id="mgmtNm"/>
					<c:if test="${!empty isExistsNm }"><br/><font color="red">같은 파일이 존재합니다.<br />이름을 변경해서 저장해주시기 바랍니다.</font></c:if>					
				</td>
				<th style="width: 15%">크기</th>
				<td style="width: 35%">
					<c:if test="${!empty fileSize }"><c:out value="${fileSize } Kb"/></c:if>
				</td>				
			</tr>
			<tr>				
				<th>형식</th>
				<td>
					<c:if test="${mgmtType == 'css' || mgmtType == 'js' }">
					<select name="mgmtScriptType" id="mgmtScriptType">
						<c:if test="${mgmtType == 'css' }">
							<option value="text/css" <c:out value="${jnitcmsmgmtVO.mgmtScriptType == 'text/css' ? 'selected' : '' }"/>>text/css</option>
						</c:if>
						<c:if test="${mgmtType == 'js' }">
							<option value="text/javascript" <c:out value="${jnitcmsmgmtVO.mgmtScriptType == 'text/javascript' ? 'selected' : '' }"/>>text/javascript</option>
						</c:if>																		
					</select>
					</c:if>
					<c:if test="${mgmtType == 'img' }">
						해당없음
					</c:if>					
				</td>
				<th>저장일시</th>
				<td>
					<c:if test="${registerFlag == '수정' }">
						<fmt:formatDate value="${jnitcmsmgmtVO.created }" pattern="yyyy-MM-dd HH:mm"/> 												
					</c:if>
				</td>
			</tr>
			<c:if test="${registerFlag == '수정' }">
			<tr>
				<th>링크경로</th>
				<td>
					<a href="<c:url value="/${siteVO.sitePath }/common/${mgmtType}/${jnitcmsmgmtVO.mgmtNm }.${mgmtType }"/>" target="_blank" title="새창으로 열립니다.">
						<c:out value="/${siteVO.sitePath }/common/${mgmtType}/${jnitcmsmgmtVO.mgmtNm }.${mgmtType }"/>
					</a>					
				</td>
				<th>수정자</th>
				<td>
					<input type="hidden" name="mgmtActId" id="mgmtActId" value="<c:out value="${jnitcmsmgmtVO.mgmtActId }" />" />
					<c:out value="${mbrNm }" />
				</td>				
			</tr>			
			<tr>
				<th>히스토리</th>
				<td colspan="3">
					<a href="javascript:fn_history();" class="btn btn-small">히스토리보기</a>
				</td>				
			</tr>
			</c:if>
			<tr>
				<th>사용여부</th>
				<td colspan="3">
					<select name="mgmtHearderYn" id="mgmtHearderYn">
						<option value="0" <c:out value="${jnitcmsmgmtVO.mgmtHearderYn == 0 ? 'selected' : '' }"/>>미사용</option>
						<option value="1" <c:out value="${jnitcmsmgmtVO.mgmtHearderYn == 1 ? 'selected' : '' }"/>>사용</option>
					</select>
					<c:if test="${!empty newFile }"><font color="red">서버에서 변경된 파일입니다.</font></c:if>
					<c:if test="${!empty notFile }"><font color="red">파일이 없습니다.</font></c:if>
				</td>				
			</tr>
			<tr>
				<th>정렬순서</th>
				<td colspan="3"><form:input path="mgmtSort" id="mgmtSort"/></td>
			</tr>
			<tr>
				<th>적용 템플릿 선택</th>
				<td colspan="3">										
					<c:forEach var="category" items="${categoryList }" varStatus="status">
						<c:if test="${(status.index % 10) != 9 }">&nbsp;</c:if>
						<label for="categoryList${status.count }"><c:out value="${category.categoryNm }" /></label> 
							<input type="checkbox" id="categoryList${status.count }" name="categoryList" value="${category.categoryVal }" ${mgmtCategoryMap[category.categoryVal] }/>
						<c:if test="${status.count == 1 }"><br /></c:if>
						<c:if test="${(status.count % 10) == 0 }"><br /></c:if>
					</c:forEach>
				</td>
			</tr>
			<c:if test="${mgmtType == 'css' || mgmtType == 'js' }">
			<tr>
				<td colspan="4">
					<textarea name="mgmtContent" id="mgmtContent" rows="25" cols="5" style="width: 99%"><c:if test="${!empty newFile}"><c:out value="${fileContent }"/></c:if><c:if test="${empty newFile}"><c:out value="${jnitcmsmgmtVO.mgmtContent }"/></c:if></textarea>
				</td>
			</tr>
			</c:if>			
		</table>
	</div>
</div>
<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">히스토리</h3>
  </div>
  <div class="modal-body">
   	<div id="listModal"></div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
    <!-- <button class="btn btn-primary">Save changes</button> -->
  </div>
</div>
<!-- 검색조건 유지 -->
<%--
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
 --%>
</form:form>
<%-- Contents End --%>