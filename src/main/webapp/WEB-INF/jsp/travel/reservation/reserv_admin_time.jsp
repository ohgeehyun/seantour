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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/travel/ad_layout.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/travel/ad_common.css'/>">
<script src="<c:url value='/js/travel/jquery-1.12.2.min.js'/>"></script>
</head>
<script>
function fn_logout(){
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/reserv_logout.do'/>";
   	document.getElementById("travelReservation").submit();
}

function fn_excelDown(){
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/reserv_admin_cond_excelDown.do'/>";
   	document.getElementById("travelReservation").submit();
}
</script>
<body>
	<div id="wrap">
		<div id="header">
			<div class="header_top">
				<div class="logo"><a href=""><img src="<c:url value="/images/travel/admin/login_logo.png"/>" alt="바다여행일정 만들기 관리자" /></a></div>
				<div class="member_area">
					<a href="<c:url value="/travel/reservation/area.do"/>" target="_blank" class="home">사용자 바로가기</a>
					<a href="javascript:fn_logout();" class="login">관리자 로그아웃</a>
				</div>
			</div>
			<div class="loc_area">
				<ol class="location">
					<li class="home">홈</li>
					<li class="current">회원관리</li>
				</ol>
			</div>
	
		</div>
		<!-- // Header -->
		
		<div id="container">
			<div id="side">
				<h2 class="title">관리자페이지</h2>
				<ul id="snb">
					<li><a href="<c:url value="/travel/reservation/reserv_admin.do"/>" class="on">회원관리</a></li>
					<li><a href="<c:url value="/travel/reservation/reserv_admin_cond.do"/>" class="on">피크타임현황</a></li>
					<li><a href="<c:url value="/travel/reservation/reserv_admin_time.do"/>" class="on">시간대별현황</a></li>
				</ul>
			</div>
			<div id="content" class="cont_wrap">
				<form:form commandName="travelReservation" method="post">
				<input type="hidden" id="reseBeachId" name="reseBeachId" value="${travelReservation.reseBeachId}"/>
				<div class="cont_head">
					<h1 class="tit">시간대별 해수욕장현황관리</h1>
				</div>
				<div class="cont_body">	
					<a href="javascript:fn_excelDown();" class="button" style="float:right;">엑셀다운로드</a>
					<table border="0" cellpadding="0" class="tbl01 tac">
						<caption>해수욕장현황관리 - 번호,해수욕장,시간,인원</caption>
						<thead>
							<colgroup>
								<col />
								<col />
								<col />
								<col />
							</colgroup>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">해수욕장명</th>
								<th scope="col">시간대 최대인원</th>
								<th scope="col">피크시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="bList" items="${bList}" varStatus="status">
							<tr>
								<td><c:out value="${bList.seq_id}"/></td>
								<td><c:out value="${bList.poi_nm}"/></td>
								<td><c:out value="${bList.max_uniq_pop}"/> 명</td>
								<td><c:out value="${fn:substring(bList.max_time, 0, 4)}"/>년 <c:out value="${fn:substring(bList.max_time, 5, 7)}"/>월 <c:out value="${fn:substring(bList.max_time, 8, 10)}"/>일   <c:out value="${fn:substring(bList.max_time, 11, 13)}"/>시 <c:out value="${fn:substring(bList.max_time, 14, 16)}"/>분</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				</form:form>
			</div>
		</div>
		<!-- // Container -->
		<div id="footer">
			<p class="address">08588 서울특별시 금천구 가산디지털2로 53 한라시그마밸리 12층  대표전화 : 080-500-8579</p>
			<p class="address">(사) 전국어촌체험마을연합회 | 대표 권영환</p>
		</div>
		<!-- // Footer -->
	</div>
</body>
</html>