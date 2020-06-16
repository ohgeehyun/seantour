<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><c:set var="Jnit_sitePath" value="travel" /><%@ page import="jnit.cms.mbr.MbrUtil" %><%@ page import='jnit.cms.config.ConfigUtil' %><% String message = ""; if(request.getParameter("message") != null){ String error =	request.getParameter("message"); message = error; } %><% Boolean siauth = MbrUtil.siauth(); Boolean gpinauth = MbrUtil.gpinauth(); Boolean pkiauth = MbrUtil.pkiauth(); %><c:set var="Jnit_sitePath" value="travel" /><c:set var="siteId" value="SITE_00007" /><% /*<!-- [-CONTENT-] -->*/ %><!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1">
<title>해양레저</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/base.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/font.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/layout.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/common.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/board.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/content.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/slick.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/aos.css"/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- Login Template -->
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
<script type="text/javascript" src="<c:url value="/js/travel/jquery-1.12.2.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/jquery.bxslider.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/TweenMax.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/slick.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/aos.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/common.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/content.js"/>"></script>
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
<!--/Login Template -->

</head>
<body>
<div id="wrap" style="position:static;">   	
    
   <%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
   <!-- End of header -->
	<!-- middle -->
	<!-- contaniner -->
  	<div id="container" >
          
         
        <div id="content" class="cont_wrap ">
      
            <div class="cont_body content">
 
   
		<div id="container" >
  
         <div id="content" class="cont_wrap">
            <!--<div class="cont_head">
                <h2 class="title">센터현황</h2>
            </div>
            <!-- cont_head -->
            <div class="cont_body">
	            <div class="inr">
	            	<div class="loginForm_area">
						<div class="login_img"><img src="${pageContext.request.contextPath}/images/travel/content/bg_login.png" alt="" /></div>
				<c:if test="${loginVO == null}">
					<%-- <form name="mbrLoginForm" id="mbrLoginForm" class="form-vertical" action="${pageContext.request.contextPath }/exeLogin.do" method="post" onsubmit="$('#passwd').val($('#passwd').val().replace(/&/g, '*')); $('#passwdConfirm').val($('#passwdConfirm').val().replace(/&/g, '*')); return fn_login(this)">
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
                              <div class="idpwFind_area">
								<ul class="idpwFind">
									<li>
										<a title="새창" href="${pageContext.request.contextPath }/${Jnit_sitePath }/mbr/${siauth == true || gpinauth == true ? 'idFind.jsp' : 'noSetpIdFind.jsp' }">아이디찾기</a></li>
										<li><a title="새창" href="${pageContext.request.contextPath }/${Jnit_sitePath }/mbr/${siauth == true || gpinauth == true ?  'idFind.jsp' : 'noSetpPwFind.jsp' }">비밀번호찾기</a></li>
							
								</ul>
							</div>
                          </div>
							<!-- 로그인 에러 메시지가 출력되는 블록. css 조정이 필요함 -->
							<c:if test="${error != null }">
								<!-- <div class="alert" style="display:block;">
									<button type="button" class="close" data-dismiss="alert">&times;</button>
									<strong>Warning!</strong> <c:out value="${param.message }" />
								</div> -->
								<!-- <c:out value="<script type='text/javascript'>alert("Warning! 로그인정보가 올바르지 않습니다");</script>" escapeXml="false"/> -->
							</c:if>
							<!--/로그인 에러 메시지가 출력되는 블록. css 조정이 필요함 -->
						</fieldset>
					</form> --%>

	            	<%-- <c:if test="${siauth == true || gpinauth == true || facebook == 1 || twitter == 1 ||  google == 1}">
                      <ul class="socialLogin">
							<!-- <li><a href="#none" class="faceBook">페이스북으로 로그인</a></li> -->
                        	<!-- <li><a href="#none" class="google">구글로 로그인</a></li> -->
                        	<li><a href="javascript:;" onclick="login_naver();return false;" class="naver_lg">NAVER 아이디로 로그인</a></li>
                       		 <!--<c:if test="${google == 1}">-->
							
                        	<!--</c:if>-->
						</ul>
					</c:if> --%>
	            	<div class="login_area">
						<strong class="txt">서비스 이용을 위해 로그인 해주세요.</strong>
						<ul>
							<li><a href="javascript:;" class="naver_lg" onclick="login_social('naver');return false;">NAVER 아이디로 로그인</a></li>
							<li><a href="javascript:;" class="kakao_lg" onclick="login_social('kakao');return false;">kakao 아이디로 로그인</a></li>
							<li><a href="javascript:;" class="google_lg" onclick="login_social('google');return false;">Google 아이디로 로그인</a></li>
						</ul>
					</div>


				</c:if>
				<c:if test="${loginVO != null}">
					<form id="exeLogout" class="exeLogout" name="exeLogout" action="${pageContext.request.contextPath }/uat/uia/actionLogout.do" method="post">
						<p class="loginBtn">

							<input type="submit" value="로그아웃" class="button darkgray" />

							<a href="${pageContext.request.contextPath}/travel/member/mypage.do" class="button gray">마이페이지</a>
						</p>
					</form>
				</c:if>
						<%-- <div class="memberJoin">
							<div class="tbox">
								<p class="txt1"><span>바다여행 회원</span>이 아니신가요?</p>
								<p class="txt2">-아직 회원이 아니시라면 지금 가입하세요!</p>
							</div>
							<a href="#none" class="btn_join">회원가입</a>
						</div> --%>

					</div>
				</div>
            </div><!-- cont_body -->
        </div><!-- // cont_wrap -->

        </div>
  </div>
<script type="text/javascript">
function login_social(vendor) {
	window.open("http://localhost:8080/seantour_map/cms/oauth/snslogin.do?vender="+vendor,"pop","width=600,height=650, scrollbars=yes, resizable=yes");	
}	
</script>
</body>
</html><% /*<!-- /[-CONTENT-] -->*/ %>