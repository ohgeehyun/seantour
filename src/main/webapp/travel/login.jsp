<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><c:set var="Jnit_sitePath" value="travel" /><%@ page import="jnit.cms.mbr.MbrUtil" %><%@ page import='jnit.cms.config.ConfigUtil' %><% String message = ""; if(request.getParameter("message") != null){ String error =	request.getParameter("message"); message = error; } %><% Boolean siauth = MbrUtil.siauth(); Boolean gpinauth = MbrUtil.gpinauth(); Boolean pkiauth = MbrUtil.pkiauth(); %><c:set var="Jnit_sitePath" value="travel" /><c:set var="siteId" value="SITE_00007" /><% /*<!-- [-CONTENT-] -->*/ %><!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1">
<title>해양레저</title>
<link rel="stylesheet" type="text/css" href="/css/travel/base.css">
<link rel="stylesheet" type="text/css" href="/css/travel/font.css">
<link rel="stylesheet" type="text/css" href="/css/travel/layout.css">
<link rel="stylesheet" type="text/css" href="/css/travel/common.css">
<link rel="stylesheet" type="text/css" href="/css/travel/board.css">
<link rel="stylesheet" type="text/css" href="/css/travel/content.css">
<link rel="stylesheet" type="text/css" href="/css/travel/slick.css">
<link rel="stylesheet" type="text/css" href="/css/travel/aos.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="/js/travel/jquery-1.12.2.min.js"></script>
<script type="text/javascript" src="/js/travel/jquery.bxslider.js"></script>
<script type="text/javascript" src="/js/travel/TweenMax.min.js"></script>
<script type="text/javascript" src="/js/travel/slick.min.js"></script>
<script type="text/javascript" src="/js/travel/aos.js"></script>
<script type="text/javascript" src="/js/travel/common.js"></script>
<script type="text/javascript" src="/js/travel/content.js"></script>

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
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
		<div id="header" class="trans">
				<h1 class="logo trans"><a href="/" class="trans">바다여행 |바다여행 일정만들기</a></h1>
				<ul class="util_top trans">
					<li><a href="/travel/login.jsp">로그인</a></li>
					<li><a href="./마이페이지_명성.html">마이페이지</a></li>
				</ul>
                <!-- GNB -->
                <div class="gnb_wrap">
                    <ul id="gnb">
                        <li><a href="/travel/destination/list.do">바다여행</a>
                            <div>
                                <ul>
	                        		<li><a href="/travel/destination/list.do?destRegion=부산">부산광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=대구">대구광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=인천">인천광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=대전">대전광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=울산">울산광역시</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=경기">경기도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=충북">충청북도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=충남">충정남도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=전북">전라북도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=전남">전라남도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=경북">경상북도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=경남">경상남도</a></li>
	                        		<li><a href="/travel/destination/list.do?destRegion=제주">제주특별자치도</a></li>
	                        	</ul>
                            </div>
                        </li>
                        <li><a href="/travel/route/register.do">나만의 여행지 만들기</a></li>
                        <li><a href="/travel/route/list.do">추천일정</a></li>
                        <li><a href="/travel/honor/index.jsp">명성</a></li>
                        <li><a href="/travel/info_square/index.jsp">정보광장</a></li>
                            <div>
                               <ul>
	                                <li><a href="/board/board.do?boardId=bbs_0000000000000014">공지사항</a></li>
	                                <li><a href="/travel/info_square/faq/index.jsp">Q&A</a></li>
	                                <li><a href="/travel/info_square/statistics/index.jsp">통계</a></li>
	                                <li><a href="">개인정보처리방침</a></li>
	                                <li><a href="">이용약관</a></li>
	                            </ul>
                            </div>
                        </li>
                    </ul>
                 </div>
                <!-- // GNB -->
                <!-- 모바일 전체메뉴 -->
                <div class="mobile_wholeview">
                    <button type="button" class="btn_wv">전체메뉴</button>
                    <div id="wholeView" class="open">
                        <div class="wv_wrap">
                            <div class="wv_wrap_head">
                                <ul class="wv_util">
                                	<li><a href="/travel/login.jsp">로그인</a></li>
                                	<li><a href="#none">마이페이지</a></li>
								</ul>
                                <button type="button" class="btn_close">전체메뉴 닫기</button>
                            </div>
                            <div class="nav">
                                <ul id="gnb_mobile">
                                    <li><a href="#">바다여행</a>
                                    	<ul>
                                    		<li><a href="/travel/destination/list.do?destRegion=부산">부산광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=대구">대구광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=인천">인천광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=대전">대전광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=울산">울산광역시</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=경기">경기도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=충북">충청북도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=충남">충정남도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=전북">전라북도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=전남">전라남도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=경북">경상북도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=경남">경상남도</a></li>
                                    		<li><a href="/travel/destination/list.do?destRegion=제주">제주특별자치도</a></li>
                                    	</ul>
                                    </li>
                                    <li><a href="/travel/route/register.do">나만의 여행일정 만들기</a></li>
                                    <li><a href="/travel/route/list.do">추천여행일정</a></li>
                                    <li><a href="/travel/honor/index.jsp">명성</a></li>
                                    <li><a href="">정보광장</a>
                                       <ul>
                                            <li><a href="/travel/info_square/notice/index.jsp">공지사항</a></li>
			                                <li><a href="/travel/info_square/faq/index.jsp">Q&A</a></li>
			                                <li><a href="/travel/info_square/statistics/index.jsp">통계</a></li>
			                                <li><a href="">개인정보처리방침</a></li>
			                                <li><a href="">이용약관</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="wvBg"></div>
                    </div>
                </div>
                <!-- //모바일 전체메뉴 -->
		      </div>
		<!-- // header -->
		<!-- contaniner -->
		<div id="container" >
            <div class="section_visual sub01 trans400">
                <div class="section_tit_box">
		            <h2 class="tit trans300">추천여행일정</h2>
		            <p class="txt trans300">틀별하고 즐거움이 가득한 국내 바다여행 여행지 추천</p>
        		</div>
            </div><!-- // section_visual -->
             <div class="section_lnb">
             	<div class="inr">
			        <ul id="lnb">
			        	<li><a href="#none"><span class="sprh_com">HOME</span></a></li>
			        	<li id="firstmenu"><!--<a href="/www/main"><span class="unfd sprh_com">홈</span></a>-->
			                <a href="#none">추천여행일정<span class="unfd">같은 레벨 메뉴 보기</span></a>
			                <div>
			                    <ul>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
									<li><a href="#none">1차메뉴</a></li>
			                	</ul>
			                </div>  
			            </li>
			            <li id="secondmenu">
			                <a href="#none">작가 추전일정<span class="unfd sprh_com">같은 레벨 메뉴 보기</span></a>
			                <div class="snb_wrap">
			                   <ul class="snb">
									<li><a href="#none">작가 추전일정</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
									<li><a href="#none">2차메뉴</a></li>
			                	</ul> 
			                </div>
			            </li>                       
			         </ul>
		         </div>
    		</div><!-- // section_lnb -->


         <div id="content" class="cont_wrap">
            <!--<div class="cont_head">
                <h2 class="title">센터현황</h2>
            </div>
            <!-- cont_head -->
            <div class="cont_body">
	            <div class="inr">
	            	<div class="login_area">

				<c:if test="${loginVO == null}">
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
							<!-- 로그인 에러 메시지가 출력되는 블록. css 조정이 필요함 -->
							<c:if test="${error != null }">
								<div class="alert" style="display:block;">
									<button type="button" class="close" data-dismiss="alert">&times;</button>
									<strong>Warning!</strong> <c:out value="${param.message }" />
								</div>
							</c:if>
							<!--/로그인 에러 메시지가 출력되는 블록. css 조정이 필요함 -->
						</fieldset>
					</form>

	            	<c:if test="${siauth == true || gpinauth == true || facebook == 1 || twitter == 1 ||  google == 1}">
	            		
						<strong class="txt">서비스 이용을 위해 로그인 해주세요.</strong>
						<ul>
							<!-- <li><a href="#none" class="naver_lg">NAVER 아이디로 로그인</a></li> -->
							<!-- <li><a href="#none" class="kakao_lg">kakao 아이디로 로그인</a></li> -->
						<c:if test="${google == 1}">	
							<li><a href="#none" class="google_lg">Google 아이디로 로그인</a></li>
						</c:if>
						</ul>
					</c:if>
				</c:if>
				<c:if test="${loginVO != null}">
					<form id="exeLogout" class="exeLogout" name="exeLogout" action="${pageContext.request.contextPath }/uat/uia/actionLogout.do" method="post">
						<p class="loginBtn">
							<input type="submit" value="로그아웃" class="button blue" />
							<a href="${pageContext.request.contextPath }/${Jnit_sitePath}/mbr/myPage.jsp" class="button gray">마이페이지</a>
						</p>
					</form>
				</c:if>

					</div>
				</div>
            </div><!-- cont_body -->
        </div><!-- // cont_wrap -->

        </div>
        <!--// container -->
		 <!-- footer -->
		<div id="footer">
			<div class="inr">
				<div class="foot_wrap">
					<ul class="foot_util">
						<li><a href="#none">개인정보처리방침</a></li>
						<li><a href="#none">이메일무단수집거부</a></li>
						<li><a href="#none">이용약관</a></li>
						<li><a href="#none">고객의소리</a></li>
						<li><a href="#none">사이트맵</a></li>
					</ul>
					<ul class="foot_info">
						<li>08588 서울특별시 금천구 가산디지털2로 53 한라시그마밸리 12층</li>
						<li><strong class="color_light_red">080-500-8579</strong>(파도친구) 평일 09:00 ~ 18:00, 점심시간 12:00 ~ 13:00<br /> seantourfipa@gmail.com</li>
						<li>(사) 전국어촌체험마을연합회 | 대표 권영환</li>
					</ul>
				</div>
				<div class="footer_go">
					<a href="#none" class="modipy">
						수정정정요청
					</a>
					<a  href="#none" class="notice">
						공지사항
					</a>
				</div>
				<div class="skip_top">
					<a href="#wrap"><div class="skip_top_btn"><span>TOP</span></div></a>
				</div>
			</div>
		</div>
		<!-- // Footer -->
	</div>
	<!-- // wrap -->
</body>
</html><% /*<!-- /[-CONTENT-] -->*/ %>