<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><c:set var="Jnit_sitePath" value="travel" /><% String result = "";if(request.getParameter("result") != null){ if("Y".equals(request.getParameter("localYn"))){result = new String( request.getParameter("result").getBytes("8859_1"),"UTF-8"); }else{ result = request.getParameter("result");} }%><c:set var="result" value="<%= result%>" /><%@ include file='/travel/_tpls/B/TPL_000111_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><%
/**
 *@version 3.2.0.1
 **/
%>
<!-- ID 찾기 결과 페이지 -->
<div class="member_content">
	<p class="tblTitle">ID 찾기 결과</p>
  	<p id="defaultId" class="useId"><c:out value="${result }"/></p>
	<p class="MAB20 MAT20 ment">
		입력하신 이름, 이메일 주소와 일치하는 ID 정보를 해당 이메일로 발송하였습니다.<br />
		(일치하는 정보가 없을 경우 메일이 발송되지 않습니다.)<br /><br />
		등록한 이메일을 잊으신 경우에는 관리자에게 문의하시기 바랍니다.<br /><br />
	</p>
	<p class="btnCenter">
		<a class="btn1" href="${pageContext.request.contextPath }/travel/login.jsp" >로그인 페이지로</a>
	</p>
</div>
<!-- //ID 찾기 결과 페이지 --><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000111_E.jsp' %>