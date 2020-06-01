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
	if($("#boardId").length > 0){
		if($("#boardId").val() =='' || $("#boardId").val() == null){
			alert("불러올 게시판 데이터를 선택해주세요.");
			$("#boardId").focus();
			return false;
		}
	}


	var mgmtSort = $("#mgmtSort").val();
	/*
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
	}
	*/
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
				var boardSkin = $("#boardSkin option:selected").val();
				var mgmtboardSkin = "${jnitcmsmgmtVO.boardSkin}";
				if(boardSkin != mgmtboardSkin && mgmtboardSkin != '' ){
					if(confirm("기존의 스킨과 다릅니다 저장하시겠습니까?")){
						formSubmit();
					}
				}else{
					formSubmit();
				}
			}
		});
	}
}

function formSubmit(){
	<c:if test="${registerFlag == '수정'}">
		frm.action = "<c:url value='/cms/mgmt/editProc.do'/>";
		frm.submit();
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/cms/mgmt/addProc.do'/>";
		frm.submit();
	</c:if>
}

function fn_history(){
	var mgmtId = $("#mgmtId").val();
	var mgmtType = $("#mgmtType").val();
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/mgmt/hist/list.do' />",
		data:"mgmtId="+mgmtId+"&mgmtType="+mgmtType
	}).done(function(data){
		Jnit_modalEmpty();
		$("#listModal").append(data);
		$('#myModal').modal('toggle');
	});
}

//최근게시물 skin ajax
function ajaxBoardlatest(){
	var boardSkin = $("#boardSkin option:selected").val();
	var mgmtType = $("#mgmtType").val();
	$.ajax({
		type:"post",
		url : "<c:url value='/cms/ajax/mgmt/boardLatest.do'/>",
		data : "boardSkin="+boardSkin+"&mgmtType="+mgmtType
	}).done(function(data){
		var json = $.parseJSON(data);
		if(json.mgmtContent != ''){
			$("#mgmtContent").val(json.mgmtContent);
		}else{
			$("#mgmtContent").val("");
		}
	});
}

function Jnit_boardSkin(){
	var boardSkin = $("#boardSkin option:selected").val();
	if(confirm(boardSkin+" 스킨유형으로 추가 하시겠습니까?")){
		var listModal = "스킨 이름 : <input type='text' name='boardSkinNm' id='boardSkinNm' /> <span style='float:right'>선택유형 : "+boardSkin+"<span>";
		var modalBtn = "<a href='javascript:Jnit_boardSkinAdd();' class='btn btn-primary'>추가</a>";

		Jnit_modalEmpty();
		$("#listModal").append(listModal);
		$("#modalBtn").append(modalBtn);
		$('#myModal').modal('toggle');
	}
}

function Jnit_boardSkinAdd(){
	var boardSkinNm = $("#boardSkinNm").val();
	var boardSkin = $("#boardSkin option:selected").val();
	if(boardSkinNm != ''){
		$.ajax({
			type : "post",
			url : "<c:url value='/cms/ajax/mgmt/boardLatest/skin.do'/>",
			data:"boardSkinNm="+boardSkinNM+"&boardSkin="+boardSkin
		}).done(function(data){
			var json = $.parseJSON(data);
			if(json.status == 'success'){
				alert("정상처리 되었습니다.");
				$('#myModal').modal('toggle');

			}
		});
	}else{
		alert("스킨이름을 입력해주시기 바랍니다.");
		$("#boardSkinNm").focus();
	}
}

function Jnit_importCode(){
	//var boardId = $("#boardId option:selected").val();
	var mgmtNm = $("#mgmtNm").val();
	var boardSkin = $("#boardSkin option:selected").val();
	var mgmtId = "${jnitcmsmgmtVO.mgmtId}";
	var importCode = ""
					+"<textarea id='importCode' rows='17' style='width:97%;'>"
						+"<"+"%--\r"
						+"    *** 미니게시판 삽입 code 설명 ***\r"
						//+"    board_id : 게시판 아이디를 콤마(,)로 구분하여 입력\r"
						//+"    latestImgUrls : 이미지경로를 콤마(,)로 구분하여 입력\r"
						//+"    useHit : 조회순 정렬 사용여부 (true, false)\r"
						//+"    count : 가져올 게시물수\r"
						//+"    miniboardSkin: 미니게시판에 디자인이 적용된 miniboardSkin코드를 value값에 삽입\r"
						+"    base_path : 해당 게시판 실제 삽입된 페이지 경로(게시물클릭시 이동기본 참조URL,다중 게시판 데이터 사용시 ,로 구분하여 입력)\r"
						//+"    skin : 미니게시판 이름\r"
						+"--%"+">\r"
						+"<"+"c:catch var ='catchException'>\r"
						+"<"+"jsp:include page='/WEB-INF/jsp/jnit/board/latest/skin/${siteVO.siteId}/"+mgmtNm+".jsp'>\r"
							//+"    <"+"jsp:param name='board_id' value='게시판 아이디를 콤마(,)로 구분하여 입력' />\r"
							//+"    <"+"jsp:param name='latestImgUrls' value='이미지경로를 콤마(,)로 구분하여 입력' />\r"
							//+"    <"+"jsp:param name='category' value='검색할 카테고리 입력'/>\r"
							//+"    <"+"jsp:param name='useHit' value='false'/>\r"
							//+"    <"+"jsp:param name='count' value='7'/>\r"
							//+"    <"+"jsp:param name='type' value='"+boardSkin+"' />\r"
							//+"	  <"+"jsp:param name='miniboardSkin' value='"+mgmtId+"' />\r"
							//+"    <"+"jsp:param name='siteId' value='${siteVO.siteId}' />\r"
							//+"    <"+"jsp:param name='skin' value='"+mgmtNm+"' />\r"
							+"    <"+"jsp:param name='base_path' value='콘텐츠경로를 입력해주시기 바랍니다.'/>\r"
						+"<"+"/jsp:include>\r"
						+"<"+"/c:catch>\r"
					+"</textarea>\r";
	var modalBtn =  "<a href=javascript:Jnit_copy('importCode'); class='btn btn-samll btn-primary'>복사</a>";
	Jnit_modalEmpty();
	$("#listModal").append(importCode);
	$("#modalBtn").append(modalBtn);
	$('#myModal').modal('toggle');
}

function Jnit_copy(id){
	var importCode = $("#importCode").val();
	var IE=(document.all)?true:false;
	if (IE) {
		window.clipboardData.setData("Text", importCode);
	}else {
		temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", importCode);
	}
}

function Jnit_modalEmpty(){
	$("#listModal").empty();
	$("#modalBtn").empty();
}

$(document).ready(function(){
	//초기셋팅
	$("#mgmtScriptType").select2();
	$("#mgmtHearderYn").select2();
	$("#boardSkin").select2();
	$("#boardId").select2();
	$("#upfile").uniform();
	$("#s2id_mgmtScriptType").css("width","162px");
	$("#s2id_boardSkin").css("width","40%");
	$("#s2id_boardId").css("width","67%");

	//boardSkin change
	$("#boardSkin").change(function(){
		var activeBoardSkin = $(this).val();
		var boardSkin = "${jnitcmsmgmtVO.boardSkin}";

		if(activeBoardSkin == boardSkin && boardSkin != ''){
			if(confirm("새로 데이터를 로드하시겠습니까?")){
				ajaxBoardlatest();
			}else{
				$("#mgmtContent").val($("#beforeContent").val());
			}
		}else{
			ajaxBoardlatest();
		}
	});
	<c:if test="${registerFlag == '수정' }">
		$("#mgmtContent").keyup(function(){
			$("#beforeContent").val('');
			$("#beforeContent").html($("#mgmtContent").val());
			$("#beforeContent").val($("#mgmtContent").val());
		});
	</c:if>
});
// -->
</script>
<%-- Contents Start --%>
<form:form commandName="jnitcmsmgmtVO" method="post" enctype="multipart/form-data" onsubmit="return false;">
<input type="hidden" name="mgmtType" id="mgmtType" value="${mgmtType }"/>
<c:if test="${registerFlag == '수정' }">
	<textarea name="beforeContent" id="beforeContent" style="display: none;" >${jnitcmsmgmtVO.mgmtContent }</textarea>
</c:if>

<div class="widget-box">
	<div class="widget-title">
		<a href="javascript:fn_egov_save();" class="btn btn-small">저장</a>
		<c:if test="${registerFlag == '수정' }">
			<a href="javascript:fn_egov_delete();" class="btn btn-small btn-del" style="float: right; margin-right: 10px;"><i class="icon-minus-sign"></i> 삭제</a>
		</c:if>
	</div>
	<div class="widget-content nopadding">
		<table class="table table-borderd">
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
				<th>최근게시물</th>
				<td colspan="3">
					<c:if test="${empty boardIdList }"><font color="red">게시판 데이터를 생성하여주시기 바랍니다.</font></c:if>
					<c:if test="${!empty boardIdList }">
					<select id="boardId" name="boardId">
						<option value="">선택</option>
						<c:forEach var="result" items="${boardIdList }">
							<option value="${result.dataId }" <c:out value="${result.dataId == jnitcmsmgmtVO.boardId ? 'selected' : ''}"/>><c:out value="${result.dataNm }" /></option>
						</c:forEach>
					</select>
					</c:if>
				</td>
			</tr>

			<c:if test="${registerFlag == '수정' }">
			<tr>
				<th>임포트코드</th>
				<td>
					<c:if test="${empty boardIdList }"><font color="red">게시판을 생성하여주시기 바랍니다.</font></c:if>
					<c:if test="${!empty boardIdList }">
						<a href="javascript:Jnit_importCode();" class="btn btn-small btn-warning">임포트코드</a>
					</c:if>
				</td>
				<th>저장일시</th>
				<td>
					<fmt:formatDate value="${jnitcmsmgmtVO.created }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
			<tr>
				<th>수정자</th>
				<td colspan="3">
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
			<%-- <tr>
				<th>정렬순서</th>
				<td colspan="3"><form:input path="mgmtSort" id="mgmtSort"/></td>
			</tr> --%>
			<tr>
				<th>샘플소스</th>
				<td colspan="3">
					<c:if test="${!empty boardLatestList }">
						<select id="boardSkin" name="boardSkin">
							<c:forEach var="latest" items="${boardLatestList }" varStatus="status">
								<option value="${fn:replace(latest,'.jsp','') }" <c:out value="${fn:replace(latest,'.jsp','') ==  jnitcmsmgmtVO.boardSkin || (empty jnitcmsmgmtVO.boardSkin && fn:replace(latest,'.jsp','') == 'main') ? 'selected' : '' }"/>>
									<c:if test="${fn:replace(latest,'.jsp','') == 'main'}"><c:out value="일반형게시판"/></c:if>
									<c:if test="${fn:replace(latest,'.jsp','') == 'gallery'}"><c:out value="갤러리형게시판"/></c:if>
									<c:if test="${fn:replace(latest,'.jsp','') == 'calendar'}"><c:out value="달력형게시판"/></c:if>
									<c:if test="${fn:replace(latest,'.jsp','') == 'schedule'}"><c:out value="스케줄형게시판"/></c:if>
								</option>
							</c:forEach>
						</select>
					</c:if>
					<%-- &nbsp;<a href="javascript:Jnit_boardSkin();" class="btn btn-small">추가</a> --%>
					<c:if test="${!empty newFile }"><font color="red">서버에서 변경된 파일입니다.</font></c:if>
					<c:if test="${!empty notFile }"><font color="red">파일이 없습니다.</font></c:if>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<textarea name="mgmtContent" id="mgmtContent" rows="25" cols="5" style="width: 99%"><c:if test="${!empty newFile}"><c:out value="${fileContent }"/></c:if><c:if test="${empty newFile}"><c:out value="${jnitcmsmgmtVO.mgmtContent }"/></c:if></textarea>
				</td>
			</tr>
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
  	<span id="modalBtn"></span>
    <button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
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