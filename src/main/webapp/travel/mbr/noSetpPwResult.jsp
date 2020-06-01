<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><c:set var="Jnit_sitePath" value="travel" /><% String result = "";if(request.getParameter("result") != null){ if("Y".equals(request.getParameter("localYn"))){result = new String( request.getParameter("result").getBytes("8859_1"),"UTF-8"); }else{ result = request.getParameter("result");} }%><c:set var="result" value="<%= result%>" /><%@ include file='/travel/_tpls/B/TPL_000111_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><%
/**
 *@version 3.2.0.1
 **/
%>
<!-- PW 찾기 결과 페이지 -->
<div class="member_content" id="Jnit_noStepPW_result">
	<p class="tblTitle">PW 찾기 결과</p>
	<p class="MAB20 MAT20 ment">
	  입력하신 아이디, 이름, 이메일 주소가 모두 일치하여 비밀번호를 <span class="fc4">'1234'</span>로 초기화합니다.<br />
		<br />
		로그인 후 비밀번호를 변경해 주시기 바랍니다.
	</p>

	<p class="btnCenter">
		<a class="btn1" href="${pageContext.request.contextPath }/travel/login.jsp" >로그인 페이지로</a>
	</p>
</div>
<!-- //PW 찾기 결과 팝업창 --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000111_E.jsp' %>