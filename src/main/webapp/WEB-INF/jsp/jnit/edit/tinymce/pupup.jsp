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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>에디터</title>
<meta http-equiv="X-UA-Compatible" content="IE=9,10" />
<meta name="robots" content="noindex">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />	
<link rel="stylesheet" href="<c:url value="/edit/tinymce/_common/css/Jnit_cntEdit.css"/>" />
<script type="text/javascript" src="<c:url value='/resources/js/jquery.min.js'/>"></script>

<script type="text/javascript">
<!--
//저장
function Jnit_editProc(){
	$(opener.document).find(".cntSrc").css("display","");
	$(opener.document).find("#cntSrcTextArea").css("display","none");
	opener.Jnit_editAddProc();	
}
//닫기
function Jnit_editClose(){
	$(opener.document).find(".cntSrc").css("display","");
	$(opener.document).find("#cntSrcTextArea").css("display","none");
	self.close();
}
//x버튼
window.onbeforeunload = onbeforeunload_handler;
function onbeforeunload_handler(){
	$(opener.document).find(".cntSrc").css("display","");
	$(opener.document).find("#cntSrcTextArea").css("display","none");
    return;
}
$(document).ready(function() {	
	setTimeout("opener.insertCntSrc()",1000);
});
//-->
</script>
<jsp:include page="../../../../../edit/tinymce/edit.jsp" />
</head>
<body>
	<a href="javascript:Jnit_edit_img_upload();" class="upload">사진업로드</a>
	<textarea id="Jnit_edit" rows="10" style="width: 94%;"></textarea>
	<a href="javascript:Jnit_editProc();" class="addBtn">수정</a>
	<a href="javascript:Jnit_editClose();" class="closeBtn">닫기</a>
</body>
</html>