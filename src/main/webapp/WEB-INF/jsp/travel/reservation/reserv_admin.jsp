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

function enterkey(){
    if (window.event.keyCode == 13) {
         // 엔터키가 눌렸을 때 실행할 내용
         document.getElementById("travelReservation").submit();
    }
}

function fn_egov_link_page(pageNo){
	document.getElementById("travelReservation").pageIndex.value = pageNo;
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/reserv_admin.do'/>";
   	document.getElementById("travelReservation").submit();
}

function fn_excelDown(){
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/reserv_admin_excelDown.do'/>";
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
				</ul>
			</div>
			<div id="content" class="cont_wrap">
				<form:form commandName="travelReservation" method="post">
				<input type="hidden" id="reseBeachId" name="reseBeachId" value="${travelReservation.reseBeachId}"/>
				<div class="cont_head">
					<h1 class="tit">회원정보관리</h1>
					<div class="search_area">
						<label for="sbscrbSttus"> 
							<select id="searchCondition" name="searchCondition" title="검색어 항목" class="slt">
								<option value="0" <c:if test="${travelReservation.searchCondition eq '0'}">selected="selected"</c:if>>이름</option>
								<option value="1" <c:if test="${travelReservation.searchCondition eq '1'}">selected="selected"</c:if>>전화번호</option>
								<option value="2" <c:if test="${travelReservation.searchCondition eq '2'}">selected="selected"</c:if>>예약번호</option>
							</select> 
							<span class="inp_area">
								<input id="searchKeyword" name="searchKeyword" title="검색어" class="word" type="text" value="${travelReservation.searchKeyword}" onkeyup="enterkey();"/>
							</span> 
							<input type="image" src="<c:url value="/images/travel/admin/btn_search.jpg"/>" alt="검색" class="btn_srch" onclick="fn_egov_link_page(1);" />
						</label>
					</div>
				</div>
				<div class="cont_body">	
					<a href="javascript:fn_excelDown();" class="button" style="float:right;">엑셀다운로드</a>
					<table border="0" cellpadding="0" class="tbl01 tac">
						<caption>예약회원 현황 - 번호,이름,소속기관,소속부서,전화번호</caption>
						<thead>
							<colgroup>
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col style="width: 15%;" />
							</colgroup>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">예약번호</th>
								<th scope="col">지역/해수욕장</th>
								<th scope="col">날짜</th>
								<th scope="col">시간</th>
								<th scope="col">인원</th>
								<th scope="col">이름</th>
								<th scope="col">전화번호</th>
								<th scope="col">비고</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="rese" items="${reseList}" varStatus="status">
							<tr>
								<td><c:out value="${((paginationInfo.currentPageNo - 1) * 50) + (status.index + 1)}"/></td>
								<td><c:out value="${rese.reseNo}"/></td>
								<td><c:out value="${rese.reseBeachName}"/></td>
								<td><c:out value="${fn:substring(rese.reseDate, 0, 4)}"/>년 <c:out value="${fn:substring(rese.reseDate, 5, 7)}"/>월 <c:out value="${fn:substring(rese.reseDate, 8, 10)}"/>일</td>
								<td>
	            					<c:choose>
	            						<c:when test="${fn:substring(rese.reseNo, 3, 5) eq '12' || fn:substring(rese.reseNo, 3, 5) eq '13' || fn:substring(rese.reseNo, 3, 5) eq '14'}">
			            					<c:if test="${rese.reseTime eq '01'}">10:00 ~ 13:00</c:if>
			            					<c:if test="${rese.reseTime eq '02'}">13:00 ~ 16:00</c:if>
			            					<c:if test="${rese.reseTime eq '03'}">16:00 ~ 19:00</c:if>
	            						</c:when>
	            						<c:otherwise>
			            					<c:if test="${rese.reseTime eq '01'}">9:00 ~ 12:00</c:if>
			            					<c:if test="${rese.reseTime eq '02'}">12:00 ~ 15:00</c:if>
			            					<c:if test="${rese.reseTime eq '03'}">15:00 ~ 18:00</c:if>
	            						</c:otherwise>
	            					</c:choose>
								</td>
								<td><c:out value="${rese.resePersonnel}"/>명</td>
								<td><c:out value="${rese.reseName}"/></td>
								<td><c:out value="${fn:substring(rese.reseTel, 0, 3)}"/>-<c:out value="${fn:substring(rese.reseTel, 3, 7)}"/>-<c:out value="${fn:substring(rese.reseTel, 7, 11)}"/></td>
								<td></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="fn_egov_link_page" />
					<form:hidden path="pageIndex" />
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