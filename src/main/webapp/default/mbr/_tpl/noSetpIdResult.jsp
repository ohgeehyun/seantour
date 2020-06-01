<%
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
		<a class="btn1" href="${pageContext.request.contextPath }/{-SITEPATH-}/login.jsp" >로그인 페이지로</a>
	</p>
</div>
<!-- //ID 찾기 결과 페이지 -->