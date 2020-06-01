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
<%@ include file="/WEB-INF/jsp/jnit/include/cms/codeMirror.jsp" %>

<c:set var="registerFlag" value="${empty jnitebookVO.ebookId ? '등록' : '수정'}"/>
<%-- <script src="<c:url value="/js/tableDnD.js"/> "></script> --%>
<script src="<c:url value="/resources/js/jquery.form.js"/>"></script>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitebookVO").action = "<c:url value='/cms/ebook/list.do'/>";
   	document.getElementById("jnitebookVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitebookVO").action = "<c:url value='/ebook/delete.do'/>";
   	document.getElementById("jnitebookVO").submit();		
}

function fn_egov_save_bln(){
	var ebookTitle = $("#ebookTitle").val();
	var pageWidth = $("#pageWidth").val();
	var pageHeight = $("#pageHeight").val();
	var thumbAotoHide = $("#thumbAotoHide").val();
	var thumbWidth = $("#thumbWidth").val();
	var thumbHeight = $("#thumbHeight").val();	
	var shareLink = $("#shareLink").val();
	
	if(ebookTitle == '' || ebookTitle == null){
		alert("제목을 입력해 주시기 바랍니다.");
		$("#ebookTitle").focus();
		return false;
	}else if(pageWidth.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#pageWidth").focus();
		return false;
	}else if(pageHeight.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#pageHeight").focus();
		return false;
	}else if(thumbAotoHide.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#thumbAotoHide").focus();
		return false;
	}else if(thumbWidth.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#thumbWidth").focus();
		return false;
	}else if(thumbHeight.match("^[0-9]+$") == null){
		alert("숫자만 입력해주시기 바랍니다.");
		$("#thumbHeight").focus();
		return false;
	}else if(shareLink.match("^http://") == null){
		alert("링크 주소에는 http://로 시작하는 문구를 입력 하셔야 됩니다.");
		$("#shareLink").focus();
		return false;
	}
	var save = true;
	$("#fileTable").find("img").each(function(){
		if($(this).attr('src') == '${pageContext.request.contextPath}/resources/img/roding.gif'){
			if($(this).css("display") != 'none' ){
				alert("아직 업로드에 처리되지않는 파일이 있습니다. 잠시만 기달려 주시기 바랍니다.");
				save = false;
			}
		}
	});
	if(!save){
		return false;
	}
	
	return true;
}

/* 글 등록 function */
function fn_egov_save() {
	if(fn_egov_save_bln()){
		frm = document.getElementById("jnitebookVO");
		var $pJquery = window.parent.$;	
		var dialog = '<div id="dialog" title="서버적용중" style="text-align:center;"><br />- 이미지 10장당 2~3분 소요 -<br /><img src="<c:url value="/images/loading01.gif" />" /><br /><font color="red">잠시 하던 일을 중단해 주시기 바랍니다.</font></div>';
		if($pJquery('#dialog').length>0){
			$pJquery('#dialog').remove();
		}
		$pJquery('body').append(dialog);
		$pJquery('#dialog').dialog({
			modal: true,
			close: function( event, ui ) {
				$pJquery(this).dialog('destroy').remove();
			}
		});
		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/ebook/editProc.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/ebook/addProc.do'/>";
		</c:if>
	   frm.submit();
	}
}

function fn_egov_add(){
	var addType = $("#addType").val();
	var addCount = $("#addCount").val() == '' || addType == '' ? 1 : parseInt($("#addCount").val());
	
	for(var i=0; i<addCount; i++){
		var num = parseInt($("#countAddFields").val());
		<c:if test="${registerFlag == '수정'}">
			num = parseInt($("#countAddFields").val())+1;
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			num = parseInt($("#countAddFields").val());		
		</c:if>
		var html = ""
			+ "<tr class='tr_img_"+num+"'>"
				+ "<td>"
					+ "<table class='table table-bordered'>"
						+ "<tr>"
							+ "<th class='step1_row_"+num+"' rowspan='5' style='width: 10%;'><font color='red'>파일추가"+num+"</font></th>"
							+ "<td bgcolor='#555555' style='width:13%'>"
								+"<font color='#ffffff'>파일설정</font>"
								+ "<input type='hidden' id='fileId"+num+"' name='fileId"+num+"'>"
							+"</td>"
							+ "<td colspan='4' bgcolor='#555555'>"
								+ "<select id='step1_"+num+"' name='step1_"+num+"' onchange='javascript:Jnit_step1(this);'>"
									+ "<option value=' ' >-- 유형선택 --</option>"
									+ "<option value='img' "+(addType == 'img' ? 'selected' : '')+" >이미지형</option>"
									+ "<option value='html' "+(addType == 'html' ? 'selected' : '')+" >Html형</option>"
									+ "<option value='user' "+(addType == 'user' ? 'selected' : '')+" >사용자 정의형</option>"
								+ "</select>"
							+"</td>"
							+ "<td id='deleteTable"+num+"' class='step1_row_"+num+"' rowspan='5' style='width: 10%; text-align: center; vertical-align: middle;'>"
								+ "<a href=javascript:fn_egov_delfile('tr_img_"+num+"','N','file'); class='btn btn-small'>삭제</a>"
							+ "</td>"
						+ "</tr>"
						
						+ "<tr class='step2_"+num+"' style='display:none;'>"
							+ "<td rowspan='2'>설정옵션</td>"
							+ "<td>투명도 설정</td>"
							+ "<td>"
								+ "<select id='transparentPage"+num+"' name='transparentPage"+num+"'>"
									+ "<option value='false'>사용안함</option>"
									+ "<option value='true'>사용함</option>"
								+ "</select>"
							+ "</td>"
							+ "<td>광택효과</td>"
							+ "<td>"
								+ "<select id='disableEmbossing"+num+"' name='disableEmbossing"+num+"'>"
									+ "<option value='false'>사용안함</option>"
									+ "<option value='true'>사용함</option>"
								+ "</select>"
							+ "</td>"
						+ "</tr>"
						+ "<tr class='step2_"+num+"' style='display:none;'>"
							+ "<td>페이지 숨김 설정</td>"
							+ "<td colspan='3'>"
								+ "<select id='dataUnload"+num+"' name='dataUnload"+num+"'>"
									+ "<option value='false'>사용안함</option>"
									+ "<option value='true'>사용함</option>"																				
								+ "</select>"
							+ "</td>"
						+ "</tr>"
						/*
						+ "<tr class='step2_"+num+"' style='display:none;'>"
							+ "<td>페이지 번호 설정</td>"
							+ "<td>"
								+ "<input type='text' id='pageNumber"+num+"' name='pageNumber"+num+"' value='' />"
							+ "</td>"
							+ "<td>페이지 이름 설정</td>"
							+ "<td>"
								+ "<input type='text' id='pageName"+num+"' name='pageName"+num+"' value='' />"
							+ "</td>"
						+ "</tr>"
						*/
						
						+ "<tr class='step3_1_"+num+"' style='display:none;'>"						
							+ "<td>책자이미지</td>"
							+ "<td colspan='4'>"
								+ "<span id='name_upbackgroundFile"+num+"'style='display:none;'></span>"
								+ "<img id='img_upbackgroundFile"+num+"' width='100' height='100' style='display:none;' />"
								+ "<img src='${pageContext.request.contextPath }/resources/img/roding.gif' id='roding_upbackgroundFile"+num+"' width='100' height='100' style='display:none;' />"
								+ "<input type='file' id='upbackgroundFile"+num+"' name='upbackgroundFile"+num+"' onchange=javascript:uploadFileAjax('"+num+"','upbackgroundFile"+num+"',''); > <font color='red'>(최대 5Mb)</font>"
							+ "</td>"
						+ "</tr>"
						+ "<tr class='step3_2_"+num+"' style='display:none;'>"
							+ "<td>미리보기 이미지</td>"
							+ "<td colspan='4'>"
								+ "<span id='name_upthumbnailFile"+num+"'style='display:none;'></span>"
								+ "<img id='img_upthumbnailFile"+num+"' width='100' height='100' style='display:none;' />"
								+ "<img src='${pageContext.request.contextPath }/resources/img/roding.gif' id='roding_upthumbnailFile"+num+"' width='100' height='100' style='display:none;' />"
								+ "<input type='file' id='upthumbnailFile"+num+"' name='upthumbnailFile"+num+"' onchange=javascript:uploadFileAjax('"+num+"','upthumbnailFile"+num+"',''); > <font color='red'>(최대 5Mb)</font>"
							+ "</td>"
						+ "</tr>"
						+ "<tr class='step3_3_"+num+"' style='display:none;'>"
							+ "<td>Html 파일 경로</td>"
							+ "<td colspan='4'>"
								+ "<span id='name_upHtmlFile"+num+"'style='display:none;'></span>"
								+ "<img id='img_upHtmlFile"+num+"' width='100' height='100' style='display:none;' />"
								+ "<img src='${pageContext.request.contextPath }/resources/img/roding.gif' id='roding_upHtmlFile"+num+"' width='100' height='100' style='display:none;' />"
								+ "<input type='file' id='upHtmlFile"+num+"' name='upHtmlFile"+num+"' onchange=javascript:uploadFileAjax('"+num+"','upHtmlFile"+num+"',''); /> <font color='red'>(최대 5Mb)</font>"
							+ "</td>"
						+ "</tr>"
						+ "<tr class='step3_4_"+num+"' style='display:none;'>"
							+ "<td>세부소스 <a href='javascript:Jnit_import_code();' class='btn btn-small'>소스정보</a></td>"
							+ "<td class='step3_4_1_"+num+"' colspan='4'>"
								+ "<textarea id='content"+num+"' name='content"+num+"' rows='10' style='width: 60%;'></textarea>"
							+ "</td>"
						+ "</tr>"
					+ "</table>"
				+ "</td>"
			+ "</tr>";
		<c:if test="${registerFlag == '수정'}">
			$("#countAddFields").val(num);
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			$("#countAddFields").val(num+1);
		</c:if>
		$("#fileTable").append(html);
		$("#fileClass"+num).select2();
		$("#disableEmbossing"+num).select2();
		$("#transparentPage"+num).select2();
		$("#dataUnload"+num).select2();
		$("#step1_"+num).select2();
		$("#upbackgroundFile"+num).uniform();
		$("#upthumbnailFile"+num).uniform();
		$("#upHtmlFile"+num).uniform();		
		if(addType != '') Jnit_step1("#step1_"+num);
	}
}

function Jnit_uploadAddFile(){
	var num; 
	<c:if test="${registerFlag == '수정'}">
		num = parseInt($("#uploadAddFields").val())+1;
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		num = parseInt($("#uploadAddFields").val());
	</c:if>
	var html= ""
			+ "<tr class='tr_upload"+num+"''>"
				+ "<td colspan='3'>"
					+ "<input type='file' id='uploadFile"+num+"' name='uploadFile"+num+"' />"
				+ "</td>"
				+ "<td>"
					+ "<a href=javascript:fn_egov_delfile('tr_upload"+num+"','N','upload'); class='btn btn-small'>삭제</a>"
				+"</td>"
			+ "</tr>";
			
	$("#uploadFileTable").append(html);
	$("#uploadFile"+num).uniform();
	<c:if test="${registerFlag == '수정'}">
		$("#uploadAddFields").val(num);
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		$("#uploadAddFields").val(num+1);
	</c:if>
}

function fn_egov_delfile(trId,Yn,type){
	if(Yn == 'N'){
		$("."+trId).remove();
	}else{
		var ebookId = $("#ebookId").val();
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				type : "post",
				url : "<c:url value='/cms/ebook/file/delete/ajax.do' />",
				data : "ebookId="+ebookId+"&fileId="+trId+"&type="+type
			}).done(function(data){				
				var json = $.parseJSON(data);
				alert(json.message);
				if(json.status == 'success'){					
					location.href = "<c:url value='/cms/ebook/edit.do'/>?ebookId="+ebookId+"&screenMode=up";
				}
			});
		}		
	}
}

function Jnit_fileOpen(fileId,type){
	window.open("<c:url value='/cms/ebook/popup.do?fileId="+fileId+"&type="+type+"'/>",'fileOpen','width=1000,height=750,scrollbars=yes,resizable=yes');
}

function Jnit_import_code(){
	window.open("<c:url value='/cms/ebook/importCode.do'/>",'importCode','width=1000,height=750,scrollbars=yes,resizable=yes');
}

function Jnit_codeMirror(num){
	try {
		CodeEditor = CodeMirror.fromTextArea(document.getElementById("content"+num), {
		  mode: "application/xml",
		  lineNumbers: true,
		  lineWrapping: true,
		  onCursorActivity: function() {
		    CodeEditor.setLineClass(CodeHl, null, null);
		    CodeHl = CodeEditor.setLineClass(CodeEditor.getCursor().line, null, "activeline");
		  },
		  /*
		  onKeyEvent: function (e, s) {
			    if (s.type == "keyup") {
			    	$("#content"+num).html(CodeEditor.getValue());
			    }
		  }
		  */
		});			
		CodeHl = CodeEditor.setLineClass(0, "activeline");			
		$('.CodeMirror').css('width', $("textarea[name=content"+num+"]").width() );
		$('.CodeMirror').css('height', $("textarea[name=content"+num+"]").height());
		$('.CodeMirror-scroll').css('height', $("textarea[name=content"+num+"]").height());
		$('.CodeMirror-scrollbar').css('height', $("textarea[name=content"+num+"]").height());
		$(window).bind('resize', resizeEditor);
	}catch(e) {
	
	}
}

function Jnit_step1(value){	
	 var step1 = $(value).val();
	 var step1_id = $(value).attr("id");
	 var num  = step1_id.replace('step1_','');
	 if(step1 != ' '){
		 /*
		 * .step1_row_ : 파일추가 삭제
		 * .step2_ : 설정옵션
		 * .step3_1_ : 책자 이미지
		 * .step3_2_ : 미리보기 이미지
		 * .step3_3_ : html 파일 경로
		 * .step3_4_ : 세부소스
		 */
		 if(step1 == 'img'){
			 $(".step1_row_"+num).attr("rowspan","4");
			 $(".step2_"+num).css("display","");
			 $(".step3_1_"+num).css("display","");
			 $(".step3_2_"+num).css("display","none");
			 $(".step3_3_"+num).css("display","none");
			 $(".step3_4_"+num).css("display","none");			 
		 }else if(step1 == 'html'){			 
			 $(".step1_row_"+num).attr("rowspan","5");
			 $(".step2_"+num).css("display","");
			 $(".step3_1_"+num).css("display","none");
			 $(".step3_2_"+num).css("display","");
			 $(".step3_3_"+num).css("display","");
			 $(".step3_4_"+num).css("display","none");		 
		 }else{
			 $(".step1_row_"+num).attr("rowspan","5");
			 $(".step2_"+num).css("display","");
			 $(".step3_1_"+num).css("display","none");
			 $(".step3_2_"+num).css("display","");
			 $(".step3_3_"+num).css("display","none");
			 $(".step3_4_"+num).css("display","");
			 $(".step3_4_1_"+num).find("div").remove();
			 Jnit_codeMirror(num);
		 }
	 }else{
		 $(".step1_row_"+num).attr("rowspan","1");
		 $(".step2_"+num).css("display","none");
		 $(".step3_"+num).css("display","none");
		 $(".step3_1_"+num).css("display","none");
		 $(".step3_2_"+num).css("display","none");
		 $(".step3_3_"+num).css("display","none");
		 $(".step3_4_"+num).css("display","none");
	 }
	 //input type file value reset
	 inputFileReset();
}
function thumb(){
	if($("#thumbYn0").is(":checked")){
		$(".thumb").css("display","");
	}else{
		$(".thumb").css("display","none");
	}
}

function inputFileReset(num){
	$("#upbackgroundFile"+num).val("");
	$("#upThumbnailFile"+num).val("");
	$("#upHtmlFile"+num).val("");
}
//파일 확장자 체크
function checkExt(name){	
	if( $("#"+name).val() != "" ){
		if(name.indexOf("background") > -1 || name.indexOf("thumb") > -1){
			var ext = $('#'+name).val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['bmp','jpg','gif','png','jpeg','tif', 'img','svg']) == -1) {
				alert('bmp, jpg, gif, png, jpeg, tif, img, svg 파일만 업로드 할수 있습니다.');
				$("#"+name).focus();
				return;
			}
		}else if(name.indexOf("Html") > -1){
			var ext = $('#'+name).val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['html']) == -1) {
				alert('html 파일만 업로드 할수 있습니다.');
				$("#"+name).focus();
				return;
			}
		}		
	}
	return true;
}

function uploadFileAjax(num,name,fileId){
	if(checkExt(name)){
		$("#roding_"+name).css("display","");
		$("#img_"+name).css("display","none");
		$("#name_"+name).css("display","none");
		var index = $(".tr_img_"+num).index();
		
		var options = {
			iframe:true,
			type:"POST",
			dataType:"text/javascript",
			url:"<c:url value='/ebook/load/file.do'/>?num="+num+"&name="+name+"&fileId="+fileId+"&index="+index,
			success: successFile
		};
		$("#jnitebookVO").ajaxSubmit(options);
	}else{
		$("#"+name).val("");
	}
}

function successFile(text, statusText, $form){
	var json = $.parseJSON(text);
	if(json.status == 'success'){		
		if(json.fileType == 'img'){
			$("#img_"+json.name).css("display","");
			$("#name_"+json.name).css("display","none");
			$("#img_"+json.name).attr("src", "${pageContext.request.contextPath }"+json.path);
		}else{
			$("#name_"+json.name).css("display","");
			$("#img_"+json.name).css("display","none");
			$("#name_"+json.name).empty();
			$("#name_"+json.name).append(json.fileNm+"<a href=javascript:Jnit_fileOpen('"+json.fileId+"','"+json.subPath+"'); class='btn btn-small'>파일보기</a>");
		}		
		$("#fileId"+json.num).val(json.fileId);		
		$("#deleteTable"+json.num).empty();
		$("#deleteTable"+json.num).append("<a href=javascript:fn_egov_delfile('"+json.fileId+"','Y','file'); class='btn btn-small'>삭제</a>");
		//$("#uniform-"+json.name+" span.filename").empty();
		//$("#uniform-"+json.name+" span.filename").append("선택된 파일 없음");
	}else{
		if(json.code != ''){
			if("FAIL 1" == json.code){
				alert("파일은 최대 5Mb만 지원합니다. 다시등록 해주시기 바랍니다.");
			}else if("FAIL 2" == json.code){
				alert("RGB형식 타입의 이미지파일을 업로드 해주시기 바랍니다.");
			}
		}else{
			alert("파일을 다시 선택하시기 바랍니다.");
		}
	}
	$("#"+json.name).val("");
	$("#roding_"+json.name).css("display","none");
}

$(document).ready(function(){
	//썸네일 셋팅
	thumb();	
	$("#thumbYn0").click(function(){
		thumb();
	});
	$("#thumbYn1").click(function(){
		thumb();
	});
	//링크주소 셋팅
	var shareLink = $("#shareLink").val();
	$("#shareLink").val(shareLink != '' ? shareLink : "http://");
});

// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="jnitebookVO" method="post" enctype="multipart/form-data">
		<form:hidden path="ebookId" id="ebookId" cssClass="txt" readonly="false" />
		<input type="hidden" name="countAddFields" id="countAddFields" value="${countAddFields == '' || countAddFields == null ? 1 : countAddFields }" />
		<input type="hidden" name="uploadAddFields" id="uploadAddFields" value="${uploadAddFields == '' || uploadAddFields == null ? 1 : uploadAddFields }" />
		<c:if test="${registerFlag == '수정'}">
			<input type="hidden" name="screenMode" value="up" />	   
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			<input type="hidden" name="screenMode" value="" />	   	
		</c:if>	
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
						<c:if test="${registerFlag == '수정'}">
							<a href="javascript:fn_egov_delete();" class="btn btn-small"><i class="icon-minus-sign"></i> 삭제</a>&nbsp;&nbsp;&nbsp;
							<a href="<c:url value="/upload/ebook/${jnitebookVO.ebookId }/ebook/index.html"/>" target="_blank" title="새창으로 열립니다." class="btn btn-small"><i class="icon-eye-open"></i> 미리보기</a>
						</c:if>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">
							<tr>
								<th>제목</th>
								<td colspan="2">
									<form:input path="ebookTitle" id="ebookTitle" cssClass="txt" cssStyle="width:98%"/><form:errors path="ebookTitle" />
								</td>
							</tr>
							<tr>
								<th rowspan="5">환경설정</th>
								<th style="width: 23%;">VIEW 모드 선택</th>
								<td>
									<input type="radio" name="ext02" value="0" <c:out value="${jnitebookVO.ext02 == '0' ? 'checked' : '' }"/>>커버형
									<input type="radio" name="ext02" value="1" <c:out value="${jnitebookVO.ext02 == '1' ? 'checked' : '' }"/>>펼침형  
								</td>
							</tr>
							<tr>
								<th style="vertical-align: middle;">책자 이미지 크기</th>
								<td>								
									가로 : <input type="text" id="pageWidth" name="pageWidth" value="${jnitebookVO.pageWidth == 0 ? '450' : jnitebookVO.pageWidth}"/>&nbsp;&nbsp;
									세로 : <input type="text" id="pageHeight" name="pageHeight" value="${jnitebookVO.pageHeight == 0 ? '637' : jnitebookVO.pageHeight}"/>
								</td>
							</tr>							
							<tr>
								<th>미리보기(썸네일) 사용여부</th>
								<td>									
									<input type="radio" id="thumbYn0" name="thumbYn" value="true" <c:out value="${jnitebookVO.thumbYn == 'true' ? 'checked' : '' }"/>>사용함
									<input type="radio" id="thumbYn1" name="thumbYn" value="false" <c:out value="${jnitebookVO.thumbYn == 'false' ? 'checked' : '' }"/>>사용안함
								</td>
							</tr>
							<tr class="thumb" style="display: none;">
								<th>미리보기 설정</th>
								<td style="vertical-align: middle;">
									표시 시간 : <input type="text" id="thumbAotoHide" name="thumbAotoHide" value="${jnitebookVO.thumbAotoHide == 0 ? '10000' : jnitebookVO.thumbAotoHide}" />
									가로 크기 : <input type="text" id="thumbWidth" name="thumbWidth" value="${jnitebookVO.thumbWidth == 0 ? '80' : jnitebookVO.thumbWidth}" />
									세로 크기 : <input type="text" id="thumbHeight" name="thumbHeight" value="${jnitebookVO.thumbHeight == 0 ? '100' : jnitebookVO.thumbHeight}" />
								</td>
							</tr>
							<tr>
								<th>SNS 기본 멘트 설정</th>			
								<td style="vertical-align: middle;">
									홈페이지주소 : <form:input path="shareLink" id="shareLink" />&nbsp; 
									한줄 기업소개 : <form:input path="shareText"/>&nbsp;
									회사명 : <form:input path="shareVia"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="widget-box">
					<div class="widget-title">
						<h3>임의 파일 관리</h3>
						<a href="javascript:Jnit_uploadAddFile();" class="btn btn-small">파일 추가</a>
					</div>
					<div class="widget-content nopadding">
						<table id="uploadFileTable" class="table table-bordered">							
							<tr>
								<th>파일</th>
								<th>파일업로드</th>
								<th>경로</th>
								<th>삭제</th>
							</tr>
							<c:if test="${!empty uploadFileList }"> 
								<c:forEach var="upload" items="${uploadFileList }" varStatus="status">
								<tr class="tr_upload${status.count }">
									<td>
										<c:if test="${!empty upload.uploadFile }">
											<c:if test="${upFileNmMap[upload.fileId] == 'img' }">
												<img src="<c:url value="${upload.uploadFile }"/>" width="100" height="100" /><br />
											</c:if>
											<c:if test="${upFileNmMap[upload.fileId] == 'file' }">
												<c:out value="${upload.fileNm }"/> <a href="javascript:Jnit_fileOpen('${upload.fileId }','uploadFile');" class="btn btn-small">파일보기</a><br />
											</c:if>
										</c:if>
										<c:if test="${empty upload.uploadFile }">
											<img src="<c:url value="/cms/getFile.do?path=images&file=nofile.gif&orgname=nofile.gif"/>" width="100" height="100"/>
										</c:if>
									</td>
									<td>
										<input type="hidden" id="uploadFileId${status.count }" name="uploadFileId${status.count }" value="${upload.fileId }"/>
										<input type="file" id="uploadFile${status.count }" name="uploadFile${status.count }" />
									</td>
									<td><c:out value="uploadFile/${upload.fileNm }"/></td>
									<td>
										<a href="javascript:fn_egov_delfile('${upload.fileId }','Y','upload');" class="btn btn-small">삭제</a>
									</td>
								</tr>
								</c:forEach>
							</c:if>
						</table>
					</div>
				</div>				
				<div class="widget-box">
					<div class="widget-title">
						<h3>책자 파일 등록</h3>
						<select id="addType">
							<option value=" " >-- 유형선택 --</option>
							<option value="img" >이미지형</option>
							<option value="html" >Html형</option>
							<option value="user" >사용자 정의형</option>
						</select>
						<input type="text" id="addCount" value="1" />
						<a href="javascript:fn_egov_add();" class="btn btn-small">장수 추가</a>
																							
						<%-- <c:if test="${!empty fileList }">&nbsp;&nbsp;
							<font color="red"><c:out value="등록된 리스트를 클릭 하여 드래그하신후 원하는 위치에 놓으시면 바로 변경이 가능합니다." /></font>
						</c:if> --%>
					</div>
					<div class="widget-content nopadding">
						<table id="fileTable" class="table table-bordered">							
							<c:if test="${!empty fileList }">
								<c:forEach var="file" items="${fileList }" varStatus="status">
								<tr id="${file.fileId }" class="tr_img_${status.count }">
									<td>
										<table class="table table-bordered">
											<tr>
												<th class="step1_row_${status.count }" rowspan="5" style="width: 10%;">
													<font color="red">파일추가${status.count }</font>
													<input type="hidden" id="fileId${status.count }" name="fileId${status.count }" value="<c:out value="${file.fileId }"/>" />
												</th>
												<td bgcolor="#555555"><font color="#ffffff">파일설정</font></td>
												<td colspan="4" bgcolor="#555555">
													<select id="step1_${status.count }" name="step1_${status.count }" onchange="javascript:Jnit_step1(this);">
														<option value=" " >-- 유형선택 --</option>
														<option value="img" <c:out value="${file.fileType == 'img' ? 'selected' : '' }"/>>이미지형</option>
														<option value="html" <c:out value="${file.fileType == 'html' ? 'selected' : '' }"/>>Html형</option>
														<option value="user" <c:out value="${file.fileType == 'user' ? 'selected' : '' }"/>>사용자 정의형</option>
													</select>
													<script type="text/javascript">
													<!--
													$(document).ready(function(){
														var num = "${status.count }";
														Jnit_step1("#step1_"+num);
													});						
													//-->
													</script>
												</td>										
												<td class="step1_row_${status.count }" rowspan="5" style="text-align: center; vertical-align: middle;">
													<a href="javascript:fn_egov_delfile('${file.fileId }','Y','file');" class="btn btn-small">삭제</a>
												</td>
											</tr>
											<tr class="step2_${status.count }" style="display: none;">
												<td rowspan="2">설정옵션</td>
												<td>투명도 설정</td>
												<td>
													<select id="transparentPage${status.count }" name="transparentPage${status.count }">
														<option value="false" <c:out value="${file.transparentPage == 'false' ? 'selected' : '' }"/>>사용안함</option>
														<option value="true" <c:out value="${file.transparentPage == 'true' ? 'selected' : '' }"/>>사용함</option>
													</select>
												</td>
												<td>광택효과</td>
												<td>
													<select id="disableEmbossing${status.count }" name="disableEmbossing${status.count }">
														<option value="false" <c:out value="${file.disableEmbossing == 'false' ? 'selected' : '' }"/>>사용안함</option>
														<option value="true" <c:out value="${file.disableEmbossing == 'true' ? 'selected' : '' }"/>>사용함</option>
													</select>
												</td>
											</tr>
											<tr class="step2_${status.count }" style="display:none;">
												<td>페이지 숨김 설정</td>
												<td colspan="3">
													<select id="dataUnload${status.count }" name="dataUnload${status.count }">
														<option value="false" <c:out value="${file.dataUnload == 'false' ? 'selected' : '' }"/>>사용안함</option>
														<option value="true" <c:out value="${file.dataUnload == 'true' ? 'selected' : '' }"/>>사용함</option>
													</select>
												</td>
											</tr>
											<%-- <tr class="step2_${status.count }" style="display: none;">
												<td>페이지 번호 설정</td>
												<td>
													<input type="text" id="pageNumber${status.count }" name="pageNumber${status.count }" value="<c:out value="${file.pageNumber }"/>" />
												</td>
												<td>페이지 이름 설정</td>
												<td>
													<input type="text" id="pageName${status.count }" name="pageName${status.count }" value="<c:out value="${file.pageName }"/>" />
												</td>
											</tr> --%>
											<tr class="step3_1_${status.count }" style="display: none;">
												<td>책자이미지</td>
												<td colspan="4">
													<img src="<c:url value="${file.backgroundFile }"/>" id="img_upbackgroundFile${status.count }" width="100" height="100" ${fileNmMap[file.fileId] == 'img' ? "style=''" : "style='display:none;'"} >
													<span id="name_upbackgroundFile${status.count }" ${fileNmMap[file.fileId] == 'file' ? "style=''" : "style='display:none;'"} ><c:out value="${file.fileNm }"/> <a href="javascript:Jnit_fileOpen('${file.fileId }','backgroundFile');" class="btn btn-small">파일보기</a></span>
													
													<img id="roding_upbackgroundFile${status.count }" src="<c:url value="/resources/img/roding.gif"/>" width="100" height="100" style="display: none;">
													<input type="file" id="upbackgroundFile${status.count }" name="upbackgroundFile${status.count }" onchange="javascript:uploadFileAjax('${status.count }','upbackgroundFile${status.count }','${file.fileId }');"> <font color='red'>(최대 5Mb)</font>	 							
												</td>
											</tr>
											<tr class="step3_2_${status.count }" style="display: none;">
												<td>미리보기 이미지</td>
												<td colspan="4">
													<img src="<c:url value="${file.thumbnailImage }"/>" id="img_upthumbnailFile${status.count }" width="100" height="100" ${fileNm2Map[file.fileId] == 'img' ? "style=''" : "style='display:none;'"} >
													<span id="name_upthumbnailFile${status.count }" ${fileNm2Map[file.fileId] == 'file' ? "style=''" : "style='display:none;'" }><c:out value="${file.fileNm2 }"/> <a href="javascript:Jnit_fileOpen('${file.fileId }','thumbnailFile');" class="btn btn-small">파일보기</a></span>
													
													<img id="roding_upthumbnailFile${status.count }" src="<c:url value="/resources/img/roding.gif"/>" width="100" height="100" style="display: none;">
													<input type="file" id="upthumbnailFile${status.count }" name="upthumbnailFile${status.count }" onchange="javascript:uploadFileAjax('${status.count }','upthumbnailFile${status.count }','${file.fileId }');"> <font color='red'>(최대 5Mb)</font>
												</td>
											</tr>
											<tr class="step3_3_${status.count }" style="display: none;">
												<td>Html 파일</td>
												<td colspan="4">
													<img src="<c:url value="${file.htmlFile }"/>" id="img_upHtmlFile${status.count }" width="100" height="100" ${htmlFileNmMap[file.fileId] == 'img' ? "style=''" : "style='display:none;'"} >
													<span id="name_upHtmlFile${status.count }" ${htmlFileNmMap[file.fileId] == 'file' ? "style=''" : "style='display:none;'" } ><c:out value="${file.fileHtmlNm }"/> <a href="javascript:Jnit_fileOpen('${file.fileId }','htmlFile');" class="btn btn-small">파일보기</a></span>
													
													<img id="roding_upHtmlFile${status.count }" src="<c:url value="/resources/img/roding.gif"/>" width="100" height="100" style="display: none;">
													<input type="file" id="upHtmlFile${status.count }" name="upHtmlFile${status.count }" onchange="javascript:uploadFileAjax('${status.count }','upHtmlFile${status.count }','${file.fileId }');" /> <font color='red'>(최대 5Mb)</font>
												</td>
											</tr>
											<tr class="step3_4_${status.count }" style="display: none;">
												<td>세부소스 <a href="javascript:Jnit_import_code();" class="btn btn-small">소스정보</a></td>
												<td class="step3_4_1_${status.count }" colspan="4">
													<textarea id="content${status.count }" name="content${status.count }" rows="10" style="width: 60%;">${contentVOMap[file.fileId].content }</textarea>
												</td>
											</tr>
										</table>
									</td>
								</tr>								
								</c:forEach>
							</c:if>					
						</table>						
					</div>
				</div>				
			</div>
		</div>		
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel"></h3>
	</div>
	<div class="modal-body">
		
	</div>
	<div class="modal-footer">
		<span id="footerBtn"></span>
		<!-- <button class="btn btn-primary">닫기</button> -->
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
