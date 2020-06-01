<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/header.jsp" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> File Upload View 샘플 </title>
</head>
<body>

<h3>input name check</h3>
<ul>
	<li>upfile1: <c:out value="${getcheck1}" /></li>
	<li>upfile2: <c:out value="${getcheck2}" /></li>
	<li>upfile3: <c:out value="${getcheck3}" /></li>
	<li>upfile4: <c:out value="${getcheck4}" /></li>
	<li>upfile5: <c:out value="${getcheck5}" /></li>
</ul>

<h3>1</h3>
<ul>
	<li>FILE INPUT NAME : <c:out value="${inputname1}" /></li>
	<li>FILE URL : <a href="<c:url value="${url1}" />" target="_blank"><c:url value="${url1}" /></a></li>
	<li>FILE REAL PATH : <c:out value="${realpath1}" /></li>
</ul>
<ul>
	<li>path: <c:out value="${path1}" /></li>
	<li>filenm: <c:out value="${filenm1}" /></li>
	<li>fileorgnm: <c:out value="${fileorgnm1}" /></li>
	<li>filesize: <c:out value="${filesize1}" /></li>
	<li>mimetype: <c:out value="${mimetype1}" /></li>
</ul>

<h3>2</h3>
<ul>
	<li>FILE INPUT NAME : <c:out value="${inputname2}" /></li>
	<li>FILE URL : <a href="<c:out value="${url2}" />" target="_blank"><c:out value="${url2}" /></a></li>
	<li>FILE REAL PATH : <c:out value="${realpath2}" /></li>
</ul>
<ul>
	<li>path: <c:out value="${path2}" /></li>
	<li>filenm: <c:out value="${filenm2}" /></li>
	<li>fileorgnm: <c:out value="${fileorgnm2}" /></li>
	<li>filesize: <c:out value="${filesize2}" /></li>
	<li>mimetype: <c:out value="${mimetype2}" /></li>
</ul>

<h3>3</h3>
<ul>
	<li>FILE INPUT NAME : <c:out value="${inputname3}" /></li>
	<li>FILE URL : <a href="<c:out value="${url3}" />" target="_blank"><c:out value="${url3}" /></a></li>
	<li>FILE REAL PATH : <c:out value="${realpath3}" /></li>
</ul>
<ul>
	<li>path: <c:out value="${path3}" /></li>
	<li>filenm: <c:out value="${filenm3}" /></li>
	<li>fileorgnm: <c:out value="${fileorgnm3}" /></li>
	<li>filesize: <c:out value="${filesize3}" /></li>
	<li>mimetype: <c:out value="${mimetype3}" /></li>
</ul>

<h3>4</h3>
<ul>
	<li>FILE INPUT NAME : <c:out value="${inputname4}" /></li>
	<li>FILE URL : <a href="<c:out value="${url4}" />" target="_blank"><c:out value="${url4}" /></a></li>
	<li>FILE REAL PATH : <c:out value="${realpath4}" /></li>
</ul>
<ul>
	<li>path: <c:out value="${path4}" /></li>
	<li>filenm: <c:out value="${filenm4}" /></li>
	<li>fileorgnm: <c:out value="${fileorgnm4}" /></li>
	<li>filesize: <c:out value="${filesize4}" /></li>
	<li>mimetype: <c:out value="${mimetype4}" /></li>
</ul>

<h3>5</h3>
<ul>
	<li>FILE INPUT NAME : <c:out value="${inputname5}" /></li>
	<li>FILE URL : <a href="<c:out value="${url5}" />" target="_blank"><c:out value="${url5}" /></a></li>
	<li>FILE REAL PATH : <c:out value="${realpath5}" /></li>
</ul>
<ul>
	<li>path: <c:out value="${path5}" /></li>
	<li>filenm: <c:out value="${filenm5}" /></li>
	<li>fileorgnm: <c:out value="${fileorgnm5}" /></li>
	<li>filesize: <c:out value="${filesize5}" /></li>
	<li>mimetype: <c:out value="${mimetype5}" /></li>
</ul>

</body>
</html>