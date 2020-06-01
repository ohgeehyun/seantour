<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/header.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> File Upload 샘플 </title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fn_egov_save() {	
	frm = document.getElementById("upForm");
    frm.submit();
}

// -->
</script>
</head>
<body>

<form id="upForm" action="<c:url value="/cms/upFile.do" />" method="post" enctype="multipart/form-data">
	FILE1 : <input type="file" name="upfile1" />
	<br />
	FILE2 : <input type="file" name="upfile2" />
	<br />
	FILE3 : <input type="file" name="upfile3" />
	<br />
	FILE4 : <input type="file" name="upfile4" />
	<br />
	FILE5 : <input type="file" name="upfile5" />
	<br />
	<a href="javascript:fn_egov_save();">업로드</a>
</form>

</body>
</html>