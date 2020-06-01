<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><c:out value="${htmlTitle}"/></title>
<script type="text/javascript" src="<c:url value="/js" />/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="<c:url value="/images/jnit/cms/common.js" />"></script>
<script language="javascript">

	function popGallery(num){

		var url = "tour_galley_main_0" + num + ".html";



		var popup = window.open(url, "tour", "width=585, height=600, scrollbars=no;");



		popup.focus();

	}

</script>
</head>

<body>