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
					<c:if test="${siauth == true}" >
						<a href="javascript:authSiIdfind();" class="findid_btn" style="margin: 0 auto;">실명인증</a>
					</c:if>
					<c:if test="${gpinauth == true}" >
						<a href="javascript:authGpinIdfind();" class="findid_btn" style="margin: 0 auto;">I-PIN인증</a>
					</c:if>
				</p>
				<!--결과-->
				<% if( session.getAttribute("snAuth") != null ){ %>
				<div class="IdResult AlignCenter MAT30">
					<p class="useId AlignCenter" style="font-size:15px;">아이디 : <strong><c:import url="/searchId.do" /></strong></p>
					<p class="Id_find">
						<a href="${pageContext.request.contextPath }/${Jnit_sitePath }/mbr/pwFind.jsp">비밀번호찾기</a>
						<a href="${pageContext.request.contextPath }/${Jnit_sitePath }/login.jsp">로그인하기</a>
					</p>
				</div>
				<% } session.setAttribute("snAuth", null); %>
			</div>
		</div>
	</form>
</div>