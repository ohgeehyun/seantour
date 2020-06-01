<%
/**
 *@version 3.2.0.1
 **/
%>
<%@page import="com.sun.mail.handlers.image_gif"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<head>
<script type="text/javascript">
$(document).ready(function(){
	$('.test').click(function(){
		alert('a');
	});
});
</script>
</head>
<body>

<table border="1" style="color: black;">
	<tr>
		<th class="test">1</th>
		<th>2</th>
		<th>3</th>
	</tr>
	<tr>
		<td>One</td>
		<td>Two</td>
		<td>three</td>
	</tr>
</table>
<table border="1" style="color: black;">
	<tr>
		<th>가</th>
		<th>나</th>
		<th>다</th>
	</tr>
	<tr>
		<td>Ga</td>
		<td>Na</td>
		<td>Da</td>
	</tr>
</table>
<c:import url="/jnitallim/JnitaliimiTestView.do">
	<c:param name="groupId" value="GRP0010">
	</c:param>
</c:import>
</body>