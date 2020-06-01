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
<%@ page import="jnit.board.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta name="robots" content="noindex"/>
<title>이미지 업로드</title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<link href="<c:url value="/edit/tinymce/_common/css/edit.css" />" media="all" rel="stylesheet" type="text/css" />
<% String lang = JnitboardController.lang; %>
<script type="text/javascript">
<!--
function Jnit_check(){	
	
	if($('#imgFile').val() == null || $('#imgFile').val() == ''){
		alert("파일을 선택해 주시기 바랍니다.");
		$("#imgFile").focus();
		return false;
	}
	
	/*
	var ext = $('#imgFile').val().split('.').pop().toLowerCase();
	if($.inArray(ext, ['gif','png','jpg','jpeg','bmp']) == -1) {
		alert("gif,png,jpg,jpeg,bmp 확장자만 가능합니다.");
		$("#imgFile").focus();
		return false;
	}
	*/
	
	var imgWidth = $("#imgWidth").val();
	var imgHeight = $("#imgHeight").val();
	
	if(imgWidth != '' || imgHeight != '' ){
		if(imgWidth.match("^[0-9]+$") == null){
			alert("<%= JnitboardController.isLanguage("숫자만 입력해주시기 바랍니다.", lang) %>");
			$("#imgWidth").focus();
			return false;
		}else if(imgHeight.match("^[0-9]+$") == null){
			alert("<%= JnitboardController.isLanguage("숫자만 입력해주시기 바랍니다.", lang) %>");
			$("#imgHeight").focus();
			return false;
		}	
	}
	
	return true;
}
function Jnit_imgupload(){
	if(confirm("<%= JnitboardController.isLanguage("정말 이미지를 첨부 하시겠습니까?", lang) %>")){			
		if(Jnit_check()){
			var options = {
	            iframe: true,
	            type: "POST",
	            dataType: 'text/javascript',
	            url : "<c:url value='/board/img/upload.do'/>",
	            //beforeSubmit: showPopup,
	            success: editImage,
	            error:function(error){alert("error");}
	        }
			
			$('#imageloadForm').ajaxSubmit(options);
		}
	}	
}

function showPopup(formData, jqForm, options) {
    alert('preparing!');
    return true;
}
function editImage(responseText, statusText, xhr, $form) {
	if(responseText == 'isError'){
		alert('업로드 실패');
		return false;
	}else{
	    var json = $.parseJSON(responseText);
		if(json.src != ''){
			var src = json.src;
			var width = json.width;
			var height = json.height;
			var alt = json.alt;
			var html = "<img src='${pageContext.request.contextPath }/"+src+"' alt='"+alt+"' width='"+width+"' height='"+height+"' />";
			$("#Jnit_edit_ifr", opener.document).contents().find("#tinymce").append(html);
			self.close();
		}
	}
}
function closeWindow(){
	self.close();
}
//-->
</script>
</head>
<body>
<form:form id="imageloadForm" name="imageloadForm" method="post" enctype="multipart/form-data">
<input type="hidden" id="boardId" name="boardId" value="${jnitboardinfoVO.boardId }"/> 
<div class="wrapper">
	<div class="header">
		<h1><%= JnitboardController.isLanguage("사진첨부", lang) %></h1>
	</div>	
	<div class="body">
		<dl class="alert">
		    <dt><%= JnitboardController.isLanguage("사진 첨부 확인", lang) %></dt>
		    <dd>
		    	<label for="imgFile"></label><input type="file" id="imgFile" name="imgFile" />
			</dd>
			<dt><label for="imgWidth"><%= JnitboardController.isLanguage("가로", lang) %> : </label></dt>
			<dd>
				<input type="text" id="imgWidth" name="imgWidth" />
			</dd>
			<dt><label for="imgHeight"><%= JnitboardController.isLanguage("세로", lang) %> : </label></dt>
			<dd>
				<input type="text" id="imgHeight" name="imgHeight" />
			</dd>
			<dt><label for="imgalt">이미지 설명 : </label></dt>
			<dd>
				<textarea id="imgalt" name="imgalt" rows="3"></textarea>
			</dd>
		</dl>
	</div>
	<div class="footer">		
		<ul>
			<li class="submit">				
				<a href="javascript:Jnit_imgupload();" class="btnlink"><%= JnitboardController.isLanguage("등록", lang) %></a> 
			</li>
			<li class="cancel"><a href="javascript:closeWindow();" title="<%= JnitboardController.isLanguage("취소", lang) %>" class="btnlink"><%= JnitboardController.isLanguage("취소", lang) %></a></li>
		</ul>
	</div>
</div>
</form:form>
</body>

<script type="text/javascript">
<!--
try{	
	var a = window.opener.document.getElementById("Jnit_edit");	
}catch(e){	
	document.body.remove();
}
var boardId = document.getElementById("boardId");
if(boardId == ""){	
	document.body.remove();
}
//-->
</script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.form.js"/>"></script>
<script type="text/javascript">
<!--
$(document).ready(function(){
	//$("#boardId").val($("#boardId", opener.document).val());
	document.title = "<%= JnitboardController.isLanguage("이미지 업로드", lang) %>";
});
//-->
</script>
</html>