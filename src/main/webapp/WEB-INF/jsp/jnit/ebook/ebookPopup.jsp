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
<title>ebook 파일</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="author" type="text/plain" href="<c:url value="/humans.txt" />" />
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/font-awesome.min.css"/>">
<!--[if IE 7]>
 	<link rel="stylesheet" href="<c:url value="/resources/css/font-awesome-ie7.min.css"/>" />
 	<![endif]-->
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/jnit.css"/>" />
<%-- <link rel="stylesheet" href="<c:url value="/resources/css/jnit.main.css"/>" /> --%>
<link rel="stylesheet" href="<c:url value="/resources/css/jnit.dashboard.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/select.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/calendar.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/color_picker.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/date_picker.css"/>" />

<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script src="<c:url value="/resources/js/jquery.form.js"/>"></script>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/codeMirror.jsp" %>

<script type="text/javascript">
<!--
function Jnit_fileOpen_save(){
	
	$("#mode").val("proc");
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/ebook/popup.do'/>",
		data:$("#jnitebookfileVO").serialize()
	}).done(function(data){
		var json = $.parseJSON(data);		
		if(json.status == 'success'){
			alert("저장하였습니다.");
			//self.close();
		}else{
			alert("저장하지 못했습니다.");
		}
	});
}
function Jnit_fileOpen_close(){
	self.close();
}
//-->
</script>
</head>
<body>
<form:form commandName="jnitebookfileVO" method="post">
<input type="hidden" id="fileId" name="fileId" value="${jnitebookfileVO.fileId }" />
<input type="hidden" id="type" name="type" value="${type }" />
<input type="hidden" id="mode" name="mode" value="${mode }" />
<textarea id="ebookContent" name="ebookContent" rows="37" style="width: 98%; height: 680px;">${content }</textarea>
<a href="javascript:Jnit_fileOpen_save();" class="btn btn-small">저장</a>
<a href="javascript:Jnit_fileOpen_close();" class="btn btn-small">닫기</a>
</form:form>
</body>
</html>