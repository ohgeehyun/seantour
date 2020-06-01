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
<html>
<head>
<meta http-equiv="expires" content="-1" />
<style>
div.common-header {
	height:100px;
	background-color:#cccccc;
}
div.common-left {
	float:left;
	width:205px;
	height:600px;
	background-color:#dddddd;
}
div.common-body {
	float:left;
}
div.common-footer {
	clear:both;
	height:100px;
	background-color:#cccccc;
}
</style>
</head>
<body>

<div class="common-header">
header
</div>