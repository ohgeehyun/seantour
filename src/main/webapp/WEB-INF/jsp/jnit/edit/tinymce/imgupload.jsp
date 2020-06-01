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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="robots" content="noindex"/>
<title>이미지 업로드</title>
<link href="<c:url value="/edit/tinymce/_common/css/edit.css" />" media="all" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--
function Jnit_check(){	
	
	if($('#imgFile').val() == null || $('#imgFile').val() == ''){
		alert("파일을 선택해 주시기 바랍니다.");
		$("#imgFile").focus();
		return false;
	}
	var ext = $('#imgFile').val().split('.').pop().toLowerCase();
	if($.inArray(ext, ['gif','png','jpg','jpeg','bmp']) == -1) {
		alert("gif,png,jpg,jpeg,bmp 확장자만 가능합니다.");
		$("#imgFile").focus();
		return false;
	}
	
	var imgWidth = $("#imgWidth").val();
	var imgHeight = $("#imgHeight").val();
	
	if(imgWidth != '' || imgHeight != '' ){
		if(imgWidth.match("^[0-9]+$") == null){
			alert("숫자만 입력해주시기 바랍니다.");
			$("#imgWidth").focus();
			return false;
		}else if(imgHeight.match("^[0-9]+$") == null){
			alert("숫자만 입력해주시기 바랍니다.");
			$("#imgHeight").focus();
			return false;
		}	
	}
	return true;
}
function Jnit_imgupload(){
	if(confirm("정말 이미지를 첨부 하시겠습니까?")){			
		if(Jnit_check()){
			var options = {
	            iframe: true,
	            type: "POST",
	            dataType: 'text/javascript',
	            url : "<c:url value='/edit/img/upload.do'/>",
	            //beforeSubmit: showPopup,
	            success: editImage
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
    //alert('status:' + statusText + ', response:' + responseText);
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

function closeWindow(){
	self.close();
}
//-->
</script>
</head>
<body>
<form:form id="imageloadForm" name="imageloadForm" method="post" enctype="multipart/form-data">

<div class="wrapper">
	<div class="header">
		<h1>사진첨부</h1>
	</div>	
	<div class="body">
		<dl class="alert">
		    <dt>사진 첨부 확인</dt>
		    <dd>
		    	<label for="imgFile"></label><input type="file" id="imgFile" name="imgFile" />
			</dd>
			<dt><label for="imgWidth">가로 : </label></dt>
			<dd>
				<input type="text" id="imgWidth" name="imgWidth" />
			</dd>
			<dt><label for="imgHeight">세로 : </label></dt>
			<dd>
				<input type="text" id="imgHeight" name="imgHeight" />
			</dd>
			<dt><label for="imgalt">이미지 설명 : </label></dt>
			<dd>
				<textarea id="imgalt" name="imgalt"></textarea>
			</dd>
		</dl>
	</div>
	<div class="footer">		
		<ul>
			<li class="submit">				
				<a href="javascript:Jnit_imgupload();" class="btnlink">등록</a> 
			</li>
			<li class="cancel"><a href="javascript:closeWindow();" title="취소" class="btnlink">취소</a></li>
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
//-->
</script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.form.js"/>"></script>
</html>