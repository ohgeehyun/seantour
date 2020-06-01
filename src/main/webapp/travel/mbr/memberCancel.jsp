<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><c:set var="Jnit_sitePath" value="travel" /><%@ include file='/travel/_tpls/B/TPL_000111_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><%
/**
 *@version 3.2.0.1
 **/
%>
<div class="member_content">
	<p class="exit_member">정상적으로 회원이 탈퇴되었습니다.</p>
</div><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000111_E.jsp' %>