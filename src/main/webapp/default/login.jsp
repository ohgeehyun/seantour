<%
/**
 *@version 3.2.0.1
 **/
%>
<div class="member_content">
	<c:set var="facebook" value="<%= ConfigUtil.getDefaultProp(\"facebook\") %>"/>
	<c:set var="twitter" value="<%= ConfigUtil.getDefaultProp(\"twitter\") %>"/>
	<c:set var="google" value="<%= ConfigUtil.getDefaultProp(\"google\") %>"/> 
	<c:set var="error" value="<%=message %>" />
	<c:set var="siauth" value="<%=siauth %>" />
	<c:set var="gpinauth" value="<%=gpinauth %>" />
	<c:set var="pkiauth" value="<%=pkiauth %>" />	
	<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/> "></script>
	<script type="text/javascript" src="<c:url value="/resources/js/jnit.member.js"/> "></script>	
	<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.js"/> "></script>
	<script type="text/javascript" src="<c:url value="/total_login/common/js/auth_login.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/total_login/common/js/search_idpw.js"/>"></script>
	<script type="text/javascript">
	<!--
	$(document).ready(function(){
		var siauth = "${siauth}";
		var gpinauth = "${gpinauth}";
		var pkiauth = "${pkiauth}";
		var facebook = "${facebook}";
		var twitter = "${twitter}";
		var google = "${google}";
		loginActive(siauth,gpinauth,pkiauth,facebook,twitter,google);
	});
	//-->
	</script>
	
	<c:if test="${loginVO == null}">
		<div class="box">
			<div class="login01 row-fluid">
				<div class="span8">
					<form name="mbrLoginForm" id="mbrLoginForm" class="form-vertical" action="${pageContext.request.contextPath }/exeLogin.do" method="post" onsubmit="$('#passwd').val($('#passwd').val().replace(/&/g, '*')); $('#passwdConfirm').val($('#passwdConfirm').val().replace(/&/g, '*')); return fn_login(this)">
						<input type="hidden" id="returnUrl" name="returnUrl" value="<c:out value="${!empty param.returnUrl ? param.returnUrl : (empty header.referer || fn:contains(header.referer,'/uat/uia/actionLogout.do') ? '/' : header.referer) }"/>" />
						<input type="hidden" id="retParam" name="retParam" value="login" />
						<input type="hidden" id="siteId" name="siteId" value="${siteId }" />
						<fieldset>
							<div class="loginForm">
								<ul class="loginList">
									<li>
										<label for="mbrLogin">아이디</label>
										<input name="mbrLogin" id="mbrLogin" type="text" />
									</li>
									<li>
										<label for="passwd">비밀번호</label>
										<input name="passwd" id="passwd" type="password" />
									</li>
								</ul>
								<p class="loginBtn">
									<input type="submit" value="로그인" class="button blue" />
								</p>
								<dl class="idpwFind">
									<dt>아이디/비밀번호를 잊으셨어요?</dt>
									<dd>
										<a title="새창" href="${pageContext.request.contextPath }/${Jnit_sitePath }/mbr/${siauth == true || gpinauth == true ? 'idFind.jsp' : 'noSetpIdFind.jsp' }" class="button gray">아이디찾기</a>
										<a title="새창" href="${pageContext.request.contextPath }/${Jnit_sitePath }/mbr/${siauth == true || gpinauth == true ?  'idFind.jsp' : 'noSetpPwFind.jsp' }" class="button gray">비밀번호찾기</a>
									</dd>
								</dl>
							</div>
							<c:if test="${error != null }">			
								<div class="alert" style="display:block;">
									<button type="button" class="close" data-dismiss="alert">&times;</button>
									<strong>Warning!</strong> <c:out value="${param.message }" />
								</div>
							</c:if>
						</fieldset>
					</form>
				</div>
			</div>	
			<c:if test="${siauth == true || gpinauth == true || facebook == 1 || twitter == 1 ||  google == 1}">
				<div class="login01 row-fluid">
					<div class="span8">
						<div class="tabbable black-box" style="margin-bottom: 18px;width:95%;">
							<ul class="nav nav-tabs">  	
								<c:if test="${siauth == true }">                
									<li id="tabs1" class="active"><a href="#tab1" data-toggle="tab">실명인증</a></li>
								</c:if>
								<c:if test="${gpinauth == true }">
									<li id="tabs2" class=""><a href="#tab2" data-toggle="tab">공공I-PIN로그인</a></li>
								</c:if>	
								<c:if test="${pkiauth == true }">				                    
									<li id="tabs3" class=""><a href="#tab3" data-toggle="tab">공인인증서로그인</a></li>
								</c:if>
								<c:if test="${facebook == 1}">
									<li id="tabs4" class=""><a href="#tab4" data-toggle="tab">facebook로그인</a></li>
								</c:if>
								<c:if test="${twitter == 1}">
									<li id="tabs5" class=""><a href="#tab5" data-toggle="tab">twitter 로그인</a></li>
								</c:if>
								<c:if test="${google == 1}">
									<li id="tabs6" class=""><a href="#tab6" data-toggle="tab">google 로그인</a></li>
								</c:if>
							</ul>						
							<div class="tab-content">	
								<%-- 실명인증 --%>							
								<div class="tab-pane" id="tab1">
									<div class="padded">         	
										<p class="tab-content-title">실명인증 로그인이란?</p>
										<div class="box">
											<ul>
												<li>- 국가에서 신뢰하는 서울신용평가정보를 통해 실명확인을 거쳐 따로 회원가입 없이 사이트를 이용할 수 있습니다.</li>
												<li>- 입력하신 주민등록번호(외국인등록번호)는 실명확인 목적으로만 사용되며 저희 순천시청 홈페이지에는 제공되지 않습니다.</li>
												<li>- 주민등록법 제 37조(벌칙) 타인의 정보 및 주민등록번호를 부정하게 사용하는 경우 3년 이하의 징역 또는 1천만원 이하의 벌금에 처해지게 됩니다.</li>
											</ul>
										</div>
										<p class="tab-btn"><a href="javascript:authSi();" class="member_btn">실명인증로그인하기</a></p>
									</div>
								</div>
							
								<%-- G-PIN인증 --%>
								<div class="tab-pane" id="tab2">
									<div class="padded">
										<p class="tab-content-title">공공I-PIN로그인이란?</p>
										<div class="box">
											<ul>
												<li>- 공공 I-PIN은 Internet Personal Identification Number의 약자로, 인터넷상 개인 식별번호를 의미하며, 홈페이지에서 회원가입, 글쓰기 시 주민등록번호를 사용하지 않고도 본인임을 확인할 수 있는 개인정보보호 서비스입니다.</li>
												<li>- 행정안전부 제공 주민번호 대체 서비스 공공 I-PIN 홈페이지(http://www.g-pin.go.kr)에서 해당양식에 따라 발급받으시면 됩니다.</li>
											</ul>
										</div>
										<p class="tab-btn"><a href="javascript:authGpin();" class="member_btn">공공I-PIN로그인하기</a></p>
									</div>
								</div>
							
								<%-- 공인인증 --%>
								<div class="tab-pane" id="tab3">
									<div class="padded">
										<p class="tab-content-title">공인인증서로그인이란?</p>
										<div class="box">
											<ul>
												<li>- 공인인증기관이 발행한 사이버 거래용 인감증명서를 말합니다.</li>
												<li>- 공인인증서를 통해 모든 은행의 인터넷뱅킹 및 전자상거래를 할 수 있으며 전자서명법에 따라 회원님의 개인정보를 보호받을 수 있으며 인증서를 사용한 거래에 대한 법적인 효력을 부여 받을 수 있습니다.</li>
												<li>- 공인인증기관으로 금융결제원, 코스콤, 한국무역정보통신, 한국전산원, 한국전자인증, 한국정보인증 등이 공인인증기관으로 지정되어 있습니다.</li>
											</ul>
										</div>
										<form id="signForm" name="signForm" method="post">								
											<input type="hidden" id="retParam" name="retParam" value="login" />
											<input type="hidden" id="signname" name="signname" value="" />
											<input type="hidden" id="regNo" name="regNo" value="" />
											<input type="hidden" id="comNo" name="comNo" value="" />
											<input type="hidden" id="retUrl" name="retUrl" value="/${Jnit_sitePath }" />
											
											<p class="tab3_title">개인</p>
											<div class="tab3_content" style="margin-bottom:30px;">
												<ul>
													<li><label for="">이름</label><input name="ppname" id="ppname" type="text" /></li>
													<li><label for="">주민등록번호</label><input name="ppnum01" id="ppnum01" type="text" class="span4" /> - <input name="ppnum02" id="ppnum02" type="password" class="span4" /></li>
												</ul>
												<p class="tab3_btn"><a href="javascript:authSignReg();" class="member_btn">공인인증서<br />로그인</a></p>
											</div>
											<p class="tab3_title">사업자</p>
											<div class="tab3_content" style="margin-bottom:30px;">
												<ul>
													<li><label for="cpname">사업자이름</label><input name="cpname" id="cpname" type="text" /></li>
													<li><label for="num02">사업자번호</label><input name="cpnum01" id="cpnum01" type="text" class="span2" /> - <input name="cpnum02" id="cpnum02" type="text" class="span2" /> - <input name="cpnum03" id="cpnum03" type="password" class="span3" /></li>
												</ul>
												<p class="tab3_btn"><a href="javascript:authSignCom();" class="member_btn">공인인증서<br />로그인</a></p>
											</div>
										</form>
									</div>
								</div>
								<%-- Facebook 인증 --%>
								<div class="tab-pane" id="tab4">
									<div class="padded">         	
										<p class="tab-content-title">Facebook 로그인</p>
										<div class="box">
											Facebook 로그인 이란?
										</div>
										<p class="tab-btn"><a href="javascript:facebook_login();" class="member_btn">facebook 로그인하기</a></p>
									</div>
								</div>
								
								<%-- Twitter 인증 --%>
								<div class="tab-pane" id="tab5">
									<div class="padded">         	
										<p class="tab-content-title">Twitter 로그인</p>
										<div class="box">
											Twitter 로그인 이란?
										</div>
										<p class="tab-btn"><a href="javascript:twitter_login();" class="member_btn">facebook 로그인하기</a></p>
									</div>
								</div>
								
								<%-- Google 인증 --%>
								<div class="tab-pane" id="tab6">
									<div class="padded">         	
										<p class="tab-content-title">Google+ 로그인</p>
										<div class="box">
											Google+ 로그인 이란?
										</div>
										<p class="tab-btn"><a href="javascript:google_login();" class="member_btn">facebook 로그인하기</a></p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</c:if>
	<c:if test="${loginVO != null}">
		<form id="exeLogout" class="exeLogout" name="exeLogout" action="${pageContext.request.contextPath }/uat/uia/actionLogout.do" method="post">
			<div class="exeLogoutForm">
				<input type="submit" value="로그아웃" />
				<a href="${pageContext.request.contextPath }/${Jnit_sitePath}/mbr/myPage.jsp">마이페이지</a>
			</div>
		</form>
	</c:if>
</div>