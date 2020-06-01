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
			<p style="text-align:center;margin-top:30px;font-size:15px;">비밀번호를 찾기 원하시면 하단에 <strong>I-PIN인증</strong>버튼을 누르시면 됩니다.</p>
			<div class="findForm">
				<input type="hidden" name="returnUrl" id="returnUrl" value="kr" />
				<ul class="loginList">
					<li>
						<label for="mbrLogin" style="width:110px;display:inline-block;"><strong>아이디</strong></label><input name="mbrLogin" id="mbrLogin" type="text" style="border:1px solid #c0c0c0;padding:5px;" title="로그인아이디" />
					</li>
				</ul>
				<p class="btn MAT20 AlignCenter">
					<c:if test="${siauth == true}" >
						<a href="javascript:authSiPwfind();" class="btn_name">실명인증</a>
					</c:if>
					<c:if test="${gpinauth == true}" >
						<a href="javascript:authGpinPwfind();"class="btn_ipn">I-PIN인증</a>
					</c:if>
				</p>
				<div id="snAuthDiv" style="display:none;">
					<div class="newPwInput MAT10">
						<ul class="loginList02">
							<li>
								<label for="passwd">새비밀번호</label><input name="passwd" id="passwd" type="password" />
							</li>
							<li class="MAT5">
								<label for="passwdConfirm"><strong>새비밀번호 확인</strong></label><input name="passwdConfirm" id="passwdConfirm" type="password" />
							</li>
						</ul>
						<p class="btn_confirm AlignCenter MAT20"><a href="javascript:checkPwChange();">확인</a></p>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>