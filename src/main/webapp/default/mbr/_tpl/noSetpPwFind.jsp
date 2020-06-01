<%
/**
 *@version 3.2.0.1
 **/
%>
<div class="member_content">
	<c:set var="siauth" value="<%=siauth %>" />
	<c:set var="gpinauth" value="<%=gpinauth %>" />
	<c:set var="pkiauth" value="<%=pkiauth %>" />
	
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.min.js "></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery.plugins/jquery.cookie.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/total_login/common/js/auth_login.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/total_login/common/js/search_idpw.js"></script>
	
	<form id="pwFindForm">
		<input type="hidden" id="localYn" name="localYn" value="${localYn }" />
		<input type="hidden" id="site" name="site" value="${Jnit_sitePath }" />
		<div class="findGroup">
			<div class="findForm">
				<input type="hidden" name="returnUrl" id="returnUrl" value="kr" />
				<ul class="loginList">
					<li>
						<label for="mbrLogin" style="width:110px;display:inline-block;"><strong>아이디</strong></label>
						<input name="mbrLogin" id="mbrLogin" type="text" title="로그인아이디" /><br />
						<label for="mbrNm">이름 : </label><input type="text" id="mbrNm" name="mbrNm" /><br />
						<label for="email">이메일 : </label><input type="text" id="email" name="email" /><br />
						<label for="mobile">핸드폰 : </label><input type="text" id="mobile" name="mobile" />
					</li>
				</ul>
				<p class="btn MAT20 AlignCenter">
					<a href="javascript:Jnit_authDefaultPwfind();"class="btn_ipn">비밀번호 초기화</a>
				</p>
			</div>
		</div>
	</form>
</div>