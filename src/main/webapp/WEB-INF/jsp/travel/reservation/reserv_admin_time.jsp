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
function fn_logout(){
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/reserv_logout.do'/>";
   	document.getElementById("travelReservation").submit();
}

function fn_excelDown(){
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/reserv_admin_time_excelDown.do'/>";
   	document.getElementById("travelReservation").submit();
}

function day_search(){;
	document.getElementById("travelReservation").action = "<c:url value='/travel/reservation/reserv_admin_time.do'/>";
   	document.getElementById("travelReservation").submit();
}

function fn_display_none(){
	document.getElementById("scroll").style.display = 'none';
	document.getElementById("excelButton").style.display = 'none';
}
</script>
<body>
	<div id="wrap">
		<div id="header">
			<div class="header_top">
				<div class="logo"><a href="<c:url value="/travel/reservation/reserv_admin.do"/>"><img src="<c:url value="/images/travel/admin/login_logo.png"/>" alt="바다여행일정 만들기 관리자" /></a></div>
				<div class="member_area">
					<a href="<c:url value="/travel/reservation/area.do"/>" target="_blank" class="home">사용자 바로가기</a>
					<a href="javascript:fn_logout();" class="login">관리자 로그아웃</a>
				</div>
			</div>
			<div class="loc_area">
				<ol class="location">
					<li class="home">홈</li>
					<li class="current">시간대별현황</li>
				</ol>
			</div>
	
		</div>
		<!-- // Header -->
		
		<div id="container">
			<div id="side">
				<h2 class="title">관리자페이지</h2>
				<ul id="snb">
					<li><a href="<c:url value="/travel/reservation/reserv_admin.do"/>">회원관리</a></li>
					<c:if test="${travelReservation.reseBeachId eq 'R0000'}">
						<li><a href="<c:url value="/travel/reservation/reserv_admin_cond.do"/>">피크타임현황</a></li>
						<li><a href="<c:url value="/travel/reservation/reserv_admin_time.do"/>" class="on">시간대별현황</a></li>
					</c:if>
				</ul>
			</div>
			<div id="content" class="cont_wrap">
				<form:form commandName="travelReservation" method="post">
				<input type="hidden" id="reseBeachId" name="reseBeachId" value="${travelReservation.reseBeachId}"/>
				<div class="cont_head">
					<h1 class="tit">시간대별 해수욕장현황관리</h1>
				</div>
				<div class="cont_body">
					<div class="bbsSrch">
					<fieldset>
					<legend>날짜검색</legend>
						<span class="tit">날짜선택</span>
						<select id="ssyear" name="ssyear" title="연도" onchange="fn_display_none();">
							<option value="2020" <c:if test="${travelReservation.ssyear eq '2020'}">selected="selected"</c:if>>2020</option>
							<option value="2021" <c:if test="${travelReservation.ssyear eq '2021'}">selected="selected"</c:if>>2021</option>
						</select>	
						년
						<select id="ssmonth" name="ssmonth" title="월" onchange="fn_display_none();">
							<option value="01" <c:if test="${travelReservation.ssmonth eq '01'}">selected="selected"</c:if>>1</option>
							<option value="02" <c:if test="${travelReservation.ssmonth eq '02'}">selected="selected"</c:if>>2</option>
							<option value="03" <c:if test="${travelReservation.ssmonth eq '03'}">selected="selected"</c:if>>3</option>
							<option value="04" <c:if test="${travelReservation.ssmonth eq '04'}">selected="selected"</c:if>>4</option>
							<option value="05" <c:if test="${travelReservation.ssmonth eq '05'}">selected="selected"</c:if>>5</option>
							<option value="06" <c:if test="${travelReservation.ssmonth eq '06'}">selected="selected"</c:if>>6</option>
							<option value="07" <c:if test="${travelReservation.ssmonth eq '07'}">selected="selected"</c:if>>7</option>
							<option value="08" <c:if test="${travelReservation.ssmonth eq '08'}">selected="selected"</c:if>>8</option>
							<option value="09" <c:if test="${travelReservation.ssmonth eq '09'}">selected="selected"</c:if>>9</option>
							<option value="10" <c:if test="${travelReservation.ssmonth eq '10'}">selected="selected"</c:if>>10</option>
							<option value="11" <c:if test="${travelReservation.ssmonth eq '11'}">selected="selected"</c:if>>11</option>
							<option value="12" <c:if test="${travelReservation.ssmonth eq '12'}">selected="selected"</c:if>>12</option>
						</select>
						월
						<select id="ssdate" name="ssdate" title="일" onchange="fn_display_none();">
							<option value="01" <c:if test="${travelReservation.ssdate eq '01'}">selected="selected"</c:if>>1</option>
							<option value="02" <c:if test="${travelReservation.ssdate eq '02'}">selected="selected"</c:if>>2</option>
							<option value="03" <c:if test="${travelReservation.ssdate eq '03'}">selected="selected"</c:if>>3</option>
							<option value="04" <c:if test="${travelReservation.ssdate eq '04'}">selected="selected"</c:if>>4</option>
							<option value="05" <c:if test="${travelReservation.ssdate eq '05'}">selected="selected"</c:if>>5</option>
							<option value="06" <c:if test="${travelReservation.ssdate eq '06'}">selected="selected"</c:if>>6</option>
							<option value="07" <c:if test="${travelReservation.ssdate eq '07'}">selected="selected"</c:if>>7</option>
							<option value="08" <c:if test="${travelReservation.ssdate eq '08'}">selected="selected"</c:if>>8</option>
							<option value="09" <c:if test="${travelReservation.ssdate eq '09'}">selected="selected"</c:if>>9</option>
							<option value="10" <c:if test="${travelReservation.ssdate eq '10'}">selected="selected"</c:if>>10</option>
							<option value="11" <c:if test="${travelReservation.ssdate eq '11'}">selected="selected"</c:if>>11</option>
							<option value="12" <c:if test="${travelReservation.ssdate eq '12'}">selected="selected"</c:if>>12</option>
							<option value="13" <c:if test="${travelReservation.ssdate eq '13'}">selected="selected"</c:if>>13</option>
							<option value="14" <c:if test="${travelReservation.ssdate eq '14'}">selected="selected"</c:if>>14</option>
							<option value="15" <c:if test="${travelReservation.ssdate eq '15'}">selected="selected"</c:if>>15</option>
							<option value="16" <c:if test="${travelReservation.ssdate eq '16'}">selected="selected"</c:if>>16</option>
							<option value="17" <c:if test="${travelReservation.ssdate eq '17'}">selected="selected"</c:if>>17</option>
							<option value="18" <c:if test="${travelReservation.ssdate eq '18'}">selected="selected"</c:if>>18</option>
							<option value="19" <c:if test="${travelReservation.ssdate eq '19'}">selected="selected"</c:if>>19</option>
							<option value="20" <c:if test="${travelReservation.ssdate eq '20'}">selected="selected"</c:if>>20</option>
							<option value="21" <c:if test="${travelReservation.ssdate eq '21'}">selected="selected"</c:if>>21</option>
							<option value="22" <c:if test="${travelReservation.ssdate eq '22'}">selected="selected"</c:if>>22</option>
							<option value="23" <c:if test="${travelReservation.ssdate eq '23'}">selected="selected"</c:if>>23</option>
							<option value="24" <c:if test="${travelReservation.ssdate eq '24'}">selected="selected"</c:if>>24</option>
							<option value="25" <c:if test="${travelReservation.ssdate eq '25'}">selected="selected"</c:if>>25</option>
							<option value="26" <c:if test="${travelReservation.ssdate eq '26'}">selected="selected"</c:if>>26</option>
							<option value="27" <c:if test="${travelReservation.ssdate eq '27'}">selected="selected"</c:if>>27</option>
							<option value="28" <c:if test="${travelReservation.ssdate eq '28'}">selected="selected"</c:if>>28</option>
							<option value="29" <c:if test="${travelReservation.ssdate eq '29'}">selected="selected"</c:if>>29</option>
							<option value="30" <c:if test="${travelReservation.ssdate eq '30'}">selected="selected"</c:if>>30</option>
							<option value="31" <c:if test="${travelReservation.ssdate eq '31'}">selected="selected"</c:if>>31</option>
						</select>
						일	
						<input type="button" id="date" name="" class="bbs_btn" value="검색" title="검색" onclick="day_search()"/>
						</fieldset>
					</div>
						
					
					<a href="javascript:fn_excelDown();" id="excelButton" class="button" style="float:right;font-size:14px;">엑셀다운로드</a>
					<div class="scroll" id="scroll">
					<table border="0" cellpadding="0" class="tbl01 tac fixed">
						<caption>해수욕장시간별현황관리 - 번호,해수욕장,시간</caption>
						<thead>
							<colgroup>
									<c:forEach begin="1" end="50" step="1">
	            						<col style="width:70px;" />
	            					</c:forEach>
							</colgroup>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">해수욕장명</th>
								<c:forEach var="i" begin="0" end="23" step="1">
	            						<c:forEach var="j" begin="0" end="3" step="3">
	            							<th scope="col"><c:out value="${i}"/>시<c:out value="${j}"/>0분</th>
	            						</c:forEach>
	            				</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="tlist" items="${timelist}" varStatus="status">
							<tr>
								<td><c:out value="${tlist.seq_id}"/></td>
								<td><c:out value="${tlist.poi_nm}"/></td>
								<td><c:out value="${tlist.time0000}"/></td>
								<td><c:out value="${tlist.time0030}"/></td>
								<td><c:out value="${tlist.time0100}"/></td>
								<td><c:out value="${tlist.time0130}"/></td>
								<td><c:out value="${tlist.time0200}"/></td>
								<td><c:out value="${tlist.time0230}"/></td>
								<td><c:out value="${tlist.time0300}"/></td>
								<td><c:out value="${tlist.time0330}"/></td>
								<td><c:out value="${tlist.time0400}"/></td>
								<td><c:out value="${tlist.time0430}"/></td>
								<td><c:out value="${tlist.time0500}"/></td>
								<td><c:out value="${tlist.time0530}"/></td>
								<td><c:out value="${tlist.time0600}"/></td>
								<td><c:out value="${tlist.time0630}"/></td>
								<td><c:out value="${tlist.time0700}"/></td>
								<td><c:out value="${tlist.time0730}"/></td>
								<td><c:out value="${tlist.time0800}"/></td>
								<td><c:out value="${tlist.time0830}"/></td>
								<td><c:out value="${tlist.time0900}"/></td>
								<td><c:out value="${tlist.time0930}"/></td>
								<td><c:out value="${tlist.time1000}"/></td>
								<td><c:out value="${tlist.time1030}"/></td>
								<td><c:out value="${tlist.time1100}"/></td>
								<td><c:out value="${tlist.time1130}"/></td>
								<td><c:out value="${tlist.time1200}"/></td>
								<td><c:out value="${tlist.time1230}"/></td>
								<td><c:out value="${tlist.time1300}"/></td>
								<td><c:out value="${tlist.time1330}"/></td>
								<td><c:out value="${tlist.time1400}"/></td>
								<td><c:out value="${tlist.time1430}"/></td>
								<td><c:out value="${tlist.time1500}"/></td>
								<td><c:out value="${tlist.time1530}"/></td>
								<td><c:out value="${tlist.time1600}"/></td>
								<td><c:out value="${tlist.time1630}"/></td>
								<td><c:out value="${tlist.time1700}"/></td>
								<td><c:out value="${tlist.time1730}"/></td>
								<td><c:out value="${tlist.time1800}"/></td>
								<td><c:out value="${tlist.time1830}"/></td>
								<td><c:out value="${tlist.time1900}"/></td>
								<td><c:out value="${tlist.time1930}"/></td>
								<td><c:out value="${tlist.time2000}"/></td>
								<td><c:out value="${tlist.time2030}"/></td>
								<td><c:out value="${tlist.time2100}"/></td>
								<td><c:out value="${tlist.time2130}"/></td>
								<td><c:out value="${tlist.time2200}"/></td>
								<td><c:out value="${tlist.time2230}"/></td>
								<td><c:out value="${tlist.time2300}"/></td>
								<td><c:out value="${tlist.time2330}"/></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
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