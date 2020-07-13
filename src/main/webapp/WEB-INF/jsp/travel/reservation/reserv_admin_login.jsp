<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>해수욕장 예약시스템 관리자 로그인</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/travel/ad_base.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/travel/ad_common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/travel/ad_login.css'/>">
<script src="<c:url value='/js/travel/jquery-1.12.2.min.js'/>"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-172483742-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-172483742-1');
</script>
</head>
<script>
$(document).ready(function(){
	$('#reseAdminId').focus();
});

function fn_login(){
	if($('#reseAdminId').val() == ""){
		alert('ID를 입력해 주세요.');
		return false;
	}
	if($('#reseAdminPw').val() == ""){
		alert('패스워드를 입력해 주세요.');
		return false;
	}
	
	document.getElementById("reservAdminLogin").action = "<c:url value='/travel/reservation/reserv_login.do'/>";
   	document.getElementById("reservAdminLogin").submit();
}

function enterkey() {
    if (window.event.keyCode == 13) {
         // 엔터키가 눌렸을 때 실행할 내용
         fn_login();
    }
}
</script>
<body>
	<div class="login_wrap">
		<div class="section_login">
			<p class="logo"><img src="<c:url value="/images/travel/admin/login_logo.png"/>" alt="관리자 로그인" /></p>
			<form:form commandName="reservAdminLogin" method="post">
				<div class="bx_login">
					<div class="inp_area">
						<label for="id">ID</label>
						<input type="text" name="reseAdminId" id="reseAdminId" value="" class="inp_login" />
					</div>
					<div class="inp_area">
						<label for="password">PW</label>
						<input type="password" name="reseAdminPw" id="reseAdminPw" value="" class="inp_pw"  maxlength="20" onkeyup="enterkey();"/>
					</div>
					<a href="javascript:fn_login();" class="btn_login">로그인</a>
				</div>
			</form:form>
		</div>
		<div id="footer">
			<p>Copyright 08588 서울특별시 금천구 가산디지털2로 53 한라시그마밸리 12층   대표전화:080-500-8579</p>
		</div>
	</div>
</body>
</html>