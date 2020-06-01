<%
/**
 *@version 3.2.0.1
 **/
%>
<div class="member_content">
	<c:set var="siauth" value="<%=siauth %>" />
	<c:set var="gpinauth" value="<%=gpinauth %>" />
	<c:set var="pkiauth" value="<%=pkiauth %>" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/total_login/common/js/auth_login.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/total_login/common/js/search_idpw.js"></script>
	
	<form id="idFindForm" action="?" method="post" >
		<input type="hidden" id="localYn" name="localYn" value="${localYn}" />
		<div class="findGroup">
			<div class="findForm">
				<p class="findid01">
					<label for="mbrNm">이름 : </label><input type="text" id="mbrNm" name="mbrNm" /><br />
					<label for="email">이메일 : </label><input type="text" id="email" name="email" /><br />
					<label for="mobile">핸드폰 : </label><input type="text" id="mobile" name="mobile" />
					<a href="javascript:Jnit_authDefaultIdfind();" class="findid_btn">아이디 찾기</a>
				</p>
				<div id="Jnit_defaultResult" class="Jnit_defaultResult" style="display:none;">
					<p id="defaultId" class="useId"></p>
				</div>
			</div>
		</div>
	</form>
</div>