<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><c:set var="Jnit_sitePath" value="travel" /><%@ include file='/travel/_tpls/B/TPL_000111_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><%
/**
 *@version 3.2.0.1
 **/
%>
<div class="member_content">
	<div class="member_box">
		<a href='signup.jsp' class="member_btn">개인 회원가입</a>
		<a href='signupAdd.jsp?type=group' class="member_btn">단체 회원가입</a>
		<a href='signup.jsp?retType=kid' class="member_btn">만 14세 미만 회원가입</a>
	</div>
</div><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000111_E.jsp' %>