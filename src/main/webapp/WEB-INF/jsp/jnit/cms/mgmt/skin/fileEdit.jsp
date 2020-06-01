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
	if(confirm("해당 파일을 삭제하실 경우\n\n삽입하신 삽입경로가 유효하지 않습니다.(복구불가)\n\n삭제를 원하실경우 확인을 눌러주시기 바랍니다.")){
		var mgmtId = $("#mgmtId").val();
	   	var mgmtType = $("#mgmtType").val();
	   	$.ajax({
	   		type :"post",
	   		url :"<c:url value='/mgmt/deleteProc.do'/>",
	   		data :"mgmtId="+mgmtId+"&mgmtType="+mgmtType
	   	}).done(function(data){	   		
	   		var json = $.parseJSON(data);	   		
	   		if(json.status == 'success'){
	   			alert("정상처리 되었습니다.");
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

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsmgmtVO");
	
	if(checkExt()){ //null, 확장자 check 
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
					alert("Warning ! CODE "+json.code+" : 변경하신 파일이름은 이미 존재합니다 덮어 씌우시겠습니까?");					
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
//복사
function fn_egov_link(num){
	var htmlSrc = $("#mgmtContent"+num).val();
	var IE=(document.all)?true:false;
	if (IE) {
		window.clipboardData.setData("Text", htmlSrc);
	}else {
		temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", htmlSrc);
	}		
}

//파일 확장자 체크
function checkExt(){
	if( $("#upfile").val() != "" ){
		var ext = $('#upfile').val().split('.').pop().toLowerCase();
		var whiteList = "";
		whiteList = "${whiteFile}";
		if($.inArray(ext, whiteList.split(",")) == -1) {
			alert(whiteList+' 파일만 업로드 할 수 있습니다.');
			$("upfile").focus();
			return;
		}
	}
	return true;
}

//파일선택 미리보기
function readUrl(input){
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			$("#fileImg").attr("src",e.target.result);
			$("#fileImg").css("display","block");
		};
		reader.readAsDataURL(input.files[0]);
	}
}
//삽입소스 초기화
function Jnit_reset(){
	var pageContextPath = "$"+"{pageContext"+"."+"request"+"."+"contextPath}";
	var imgHtmlSrc = "<img src='"+pageContextPath+"/${siteVO.sitePath }/common/${mgmtType}/${jnitcmsmgmtVO.mgmtFileNm }' alt='여기에 alt값을 입력해 주시기 바랍니다.' />";
	var linkSrc = "<a href='"+pageContextPath+"${fileUrl}&count=Y' class='btn'>다운로드</a>";
	$("#mgmtContent1").val(imgHtmlSrc);
	$("#mgmtContent2").val(linkSrc);
}

//첨부파일 다운로드
function Jnit_mgmtFileDown(url){	
	location.href = url+"?file=${jnitcmsmgmtVO.mgmtFileNm }&orgname="+encodeURIComponent("${jnitcmsmgmtVO.mgmtFileOrigin }")+"&siteId=${jnitcmsmgmtVO.siteId }&mgmtId=${jnitcmsmgmtVO.mgmtId }&count=Y";
	//location.href = url+"?file=${jnitcmsmgmtVO.mgmtFileNm }&orgname=${jnitcmsmgmtVO.mgmtFileOrigin }&siteId=${jnitcmsmgmtVO.siteId }&mgmtId=${jnitcmsmgmtVO.mgmtId }&count=Y";
}

$(document).ready(function(){	
	$("#mgmtScriptType").select2();
	$("#mgmtHearderYn").select2();
	$("#upfile").uniform();
	$("#s2id_mgmtScriptType").css("width","162px");
	
	<c:if test="${registerFlag == '수정'}">	
		//img 삽입소스 세팅
		//var mgmtContent = "${mgmtContentNullYn}";				
		//if(mgmtContent == ''){
			Jnit_reset(); //초기화
		//}		
		//css 세팅		
		$("#.table td").css('vertical-align','middle'); //bootstrap.css( index : 2002)
	</c:if>
		
	/* $("body a").click(function(){
		if($(this).attr("href").indexOf("/cms/getFile.do?") > -1){
			alert("a");
			alert($(this).attr("href"));
		}
	}); */
	
});

// -->
</script>
<%-- Contents Start --%>
<form:form commandName="jnitcmsmgmtVO" method="post" enctype="multipart/form-data">
<input type="hidden" name="mgmtType" id="mgmtType" value="${mgmtType }"/>
<div class="widget-box">
	<div class="widget-title">
		<h3>${registerFlag}</h3>
		<a href="javascript:fn_egov_save();" class="btn btn-small">저장</a>
		<c:if test="${registerFlag == '수정' }">
			<a href="javascript:fn_egov_delete();" class="btn btn-small btn-del" style="float: right; margin-right: 10px;"><i class="icon-minus-sign"></i> 삭제</a>
		</c:if>
		<c:if test="${!empty notFile }">&nbsp;&nbsp;<font color="red">파일이 없습니다.</font></c:if>				
	</div>
	<div class="widget-content nopadding">
		<table id="imgEditTable" class="table table-borderd" >
			<tr>
				<th>파일업로드</th>
				<td colspan="3">
					<c:if test="${registerFlag == '등록' }">
						<img id="fileImg" src="" alt="미리보기" width="100" height="100" style="display: none"/><br/>
					</c:if>
					<c:if test="${registerFlag == '수정' }">
						<c:if test="${imgYn == 'Y' }">
							<img  alt="미리보기 이미지" src="<c:url value="${jnitcmsmgmtVO.mgmtFileUrl }" />" width="100" height="100"/><br />
						</c:if>
					</c:if>
					<input type="file" name="upfile" id="upfile" /><%-- onchange="readUrl(this);" --%> 
				</td>
			</tr>
			<c:if test="${registerFlag == '수정' }" >
			<tr>
				<th style="width: 15%">파일이름</th>
				<td style="width: 35%">
					<form:hidden path="mgmtNm" id="mgmtNm"/>					
					<c:out value="${jnitcmsmgmtVO.mgmtNm }"/>	
					<c:if test="${!empty isExistsNm }"><br/><font color="red">같은 파일이 존재합니다.<br />이름을 변경해서 저장해주시기 바랍니다.</font></c:if>				
				</td>
				<th style="width: 15%">크기</th>
				<td style="width: 35%">
					<c:if test="${!empty fileSize }">
						<c:out value="${fileSize } Kb"/>
					</c:if>
				</td>
			</tr>			
			<tr>
				<th>저장일시</th>
				<td>
					<fmt:formatDate value="${jnitcmsmgmtVO.created }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<th>수정자</th>
				<td>
					<input type="hidden" name="mgmtActId" id="mgmtActId" value="<c:out value="${jnitcmsmgmtVO.mgmtActId }" />" />
					<c:out value="${mbrNm }" />
				</td>
			</tr>
			<tr>
				<th>다운로드</th>				
				<td colspan="3">					
					<c:if test="${imgYn != 'Y'}">
					</c:if>
					<a href="javascript:Jnit_mgmtFileDown('<c:url value="/cms/getFile.do"/>')" class="btn btn-warning btn-small">파일 다운로드</a>
					
				</td>
			</tr>
			<tr>
				<th>파일 삽입경로 메모</th>
				<td colspan="3">
					<input type="text" name="mgmtInsertPath" id="mgmtInsertPath" value="<c:out value="${jnitcmsmgmtVO.mgmtInsertPath }"/>" style="width: 98%" />
				</td>
			</tr>			
			<tr>
				<td colspan="4">
					<font color="red">삽입소스(해당소스로 게시판등에 붙여 넣으시기 바랍니다.)</font>
					<a href="javascript:fn_egov_link('2');" class="btn btn-small">링크 경로 복사하기</a>
					<br />
					<textarea rows="5" name="mgmtContent" id="mgmtContent2" style="width: 98%">${jnitcmsmgmtVO.mgmtContent }</textarea>
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