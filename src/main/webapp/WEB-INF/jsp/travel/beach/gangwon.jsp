<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>
<% String errCode = request.getParameter("errCode"); %>
<c:set var="errCode" value="<%= errCode %>" />
<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
</head>

<body>
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<%-- <div id="pop">
			<div><img src="${pageContext.request.contextPath}/travel/common/images/content/img_popup_faq.jpg" alt="" /></div>
			<div id="close">close</div>
		</div>
		<div id="pop2">
			<div><img src="${pageContext.request.contextPath}/travel/common/images/content/img_popup_qna2.jpg" alt=""/>
			<a href="http://songhobeach.kr" target="_blank">예약사이트바로가기</a>
			</div>
			<div id="close2">close</div>
		</div> --%>
		<!-- header -->
			<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
		<!-- // header -->

		<!-- contaniner -->
		<div id="container" >

			<%@ include file="/WEB-INF/jsp/travel/tpl/navigation.jsp" %>

        	<div id="content" class="cont_wrap">
            <!--<div class="cont_head">
                <h2 class="title">센터현황</h2>
            </div><!-- cont_head -->
            <div class="cont_body">
	            <div class="inr">
	            	<div class="summer_area">
	            		<div class="summer_left">
	            			<div class="summer_location">
		            			<div class="cssSelect">
							  		<button type="button">강원도 해수욕장 혼잡도 신호등</button>
							  		<ul class="lst">
								  	 <li><a href="/seantour_map/travel/beach/incheon.do">인천광역시 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/gangwon.do">강원도 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/chungnam.do">충청남도 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/gyeongbuk.do">경상북도 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/jeonbuk.do">전라북도 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/jeonnam.do">전라남도 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/gyeongnam.do">경상남도 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/ulsan.do">울산광역시 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/busan.do">부산광역시 해수욕장 혼잡도 신호등</a></li>
								  	 <li><a href="/seantour_map/travel/beach/jeju.do">제주특별시 해수욕장 혼잡도 신호등</a></li>
							  		</ul>
						  		</div>
					  		</div>
					  		<div class="location_map map_ko">
					  			<img src="/seantour_map/travel/images/main_summer/img_map_ko.jpg" alt="강원도" />
				  				<div class="spot_info"><img src="/seantour_map/travel/images/main_summer/img_info_box.jpg" alt="거리두기(2m)불가 방문자제, 방문주의, 거리두기(2m)가능" /></div>
							  	<div class="blinker ko_spot1"><a href="#" class="icon green"><span class="name">강문</span></a></div>
							  	<div class="blinker ko_spot2"><a href="#" class="icon yellow"><span class="name">경포대</span></a></div>
							  	<div class="blinker ko_spot3"><a href="#" class="icon green"><span class="name">금진</span></a></div>
							  	<div class="blinker ko_spot4"><a href="#" class="icon red"><span class="name">도직</span></a></div>
							  	<div class="blinker ko_spot5"><a href="#" class="icon red"><span class="name">등명</span></a></div>
							  	<div class="blinker ko_spot6"><a href="#" class="icon red"><span class="name">사근진</span></a></div>
							  	<div class="blinker ko_spot7"><a href="#" class="icon red"><span class="name">사천</span></a></div>
							  	<div class="blinker ko_spot8"><a href="#" class="icon red"><span class="name">사천진</span></a></div>
							  	<div class="blinker ko_spot9"><a href="#" class="icon red"><span class="name">송정</span></a></div>
							  	<div class="blinker ko_spot10"><a href="#" class="icon red"><span class="name">순긋</span></a></div>
							  	<div class="blinker ko_spot11"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491906?c=14350671.3042687,4547347.8752589,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">안목</span></a></div>
							  	<div class="blinker ko_spot12"><a href="#" class="icon red"><span class="name">안인</span></a></div>
							  	<div class="blinker ko_spot13"><a href="#" class="icon red"><span class="name">연곡</span></a></div>
							  	<div class="blinker ko_spot14"><a href="#" class="icon red"><span class="name">영진</span></a></div>
							  	<div class="blinker ko_spot15"><a href="#" class="icon red"><span class="name">옥계</span></a></div>
							  	<div class="blinker ko_spot16"><a href="#" class="icon red"><span class="name">정동진</span></a></div>
							  	<div class="blinker ko_spot17"><a href="#" class="icon red"><span class="name">주문진해변</span></a></div>
							  	<div class="blinker ko_spot18"><a href="#" class="icon red"><span class="name">하평</span></a></div>
							  	<div class="blinker ko_spot19"><a href="#" class="icon red"><span class="name">가진</span></a></div>
							  	<div class="blinker ko_spot20"><a href="#" class="icon red"><span class="name">거진11리</span></a></div>
							  	<div class="blinker ko_spot21"><a href="#" class="icon red"><span class="name">거진1리</span></a></div>
							  	<div class="blinker ko_spot22"><a href="#" class="icon red"><span class="name">공현진1리 </span></a></div>
							  	<div class="blinker ko_spot23"><a href="#" class="icon red"><span class="name">공현진2리</span></a></div>
							  	<div class="blinker ko_spot24"><a href="#" class="icon green"><span class="name">교암리</span></a></div>
							  	<div class="blinker ko_spot25"><a href="#" class="icon green"><span class="name">대진1리</span></a></div>
							  	<div class="blinker ko_spot26"><a href="#" class="icon green"><span class="name">대진5리</span></a></div>
							  	<div class="blinker ko_spot27"><a href="#" class="icon green"><span class="name">마차진</span></a></div>
							  	<div class="blinker ko_spot28"><a href="#" class="icon green"><span class="name">명파리</span></a></div>
							  	<!-- <div class="blinker ko_spot29"><a href="#" class="icon green"><span class="name">문암진2리</span></a></div> -->
							  	<div class="blinker ko_spot30"><a href="#" class="icon green"><span class="name">문암캠핑장</span></a></div>
							  	<div class="blinker ko_spot31"><a href="#" class="icon green"><span class="name">반암리</span></a></div>
							  	<div class="blinker ko_spot32"><a href="#" class="icon green"><span class="name">백도</span></a></div>
							  	<div class="blinker ko_spot33"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491251?c=14303872.3788321,4625352.7124200,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">봉수대</span></a></div>
							  	<div class="blinker ko_spot34"><a href="#" class="icon green"><span class="name">봉포리</span></a></div>
							  	<div class="blinker ko_spot35"><a href="#" class="icon green"><span class="name">삼포</span></a></div>
							  	<div class="blinker ko_spot36"><a href="#" class="icon green"><span class="name">삼포2리</span></a></div>
							  	<div class="blinker ko_spot37"><a href="#" class="icon green"><span class="name">송지호</span></a></div>
							  	<div class="blinker ko_spot38"><a href="#" class="icon green"><span class="name">송지호오토캠핑장</span></a></div>
							  	<div class="blinker ko_spot39"><a href="#" class="icon green"><span class="name">아야진리</span></a></div>
							  	<div class="blinker ko_spot40"><a href="#" class="icon green"><span class="name">자작도</span></a></div>
							  	<div class="blinker ko_spot41"><a href="#" class="icon green"><span class="name">천진리</span></a></div>
							  	<div class="blinker ko_spot42"><a href="#" class="icon green"><span class="name">청간리</span></a></div>
							  	<div class="blinker ko_spot43"><a href="#" class="icon green"><span class="name">초도리</span></a></div>
							  	<div class="blinker ko_spot44"><a href="#" class="icon green"><span class="name">켄싱턴리조트</span></a></div>
							  	<div class="blinker ko_spot45"><a href="#" class="icon green"><span class="name">화진포</span></a></div>
							  	<div class="blinker ko_spot46"><a href="#" class="icon green"><span class="name">화진포 콘도</span></a></div>
							  	<div class="blinker ko_spot47"><a href="#" class="icon green"><span class="name">노봉</span></a></div>
							  	<div class="blinker ko_spot48"><a href="#" class="icon green"><span class="name">망상</span></a></div>
							  	<div class="blinker ko_spot49"><a href="#" class="icon green"><span class="name">어달</span></a></div>
							  	<div class="blinker ko_spot50"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491792?c=14374244.7537851,4505880.5710189,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">추암</span></a></div>
							  	<div class="blinker ko_spot51"><a href="#" class="icon green"><span class="name">궁촌</span></a></div>
							  	<div class="blinker ko_spot52"><a href="#" class="icon green"><span class="name">덕산</span></a></div>
							  	<div class="blinker ko_spot53"><a href="#" class="icon green"><span class="name">맹방</span></a></div>
							  	<div class="blinker ko_spot54"><a href="#" class="icon green"><span class="name">문암</span></a></div>
							  	<div class="blinker ko_spot55"><a href="#" class="icon green"><span class="name">부남</span></a></div>
							  	<div class="blinker ko_spot56"><a href="#" class="icon green"><span class="name">삼척</span></a></div>
							  	<div class="blinker ko_spot57"><a href="#" class="icon green"><span class="name">오분(간이)</span></a></div>
							  	<div class="blinker ko_spot58"><a href="#" class="icon green"><span class="name">용화</span></a></div>
							  	<div class="blinker ko_spot59"><a href="#" class="icon green"><span class="name">원평</span></a></div>
							  	<div class="blinker ko_spot60"><a href="#" class="icon green"><span class="name">작은후진</span></a></div>
							  	<div class="blinker ko_spot61"><a href="#" class="icon green"><span class="name">장호</span></a></div>
							  	<div class="blinker ko_spot62"><a href="#" class="icon green"><span class="name">증산</span></a></div>
							  	<div class="blinker ko_spot63"><a href="#" class="icon green"><span class="name">하맹방</span></a></div>
							  	<div class="blinker ko_spot64"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491890?c=14311411.4134225,4610202.4791827,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">등대</span></a></div>
							  	<div class="blinker ko_spot65"><a href="#" class="icon green"><span class="name">속초</span></a></div>
							  	<div class="blinker ko_spot66"><a href="#" class="icon green"><span class="name">외옹치</span></a></div>
							  	<div class="blinker ko_spot67"><a href="#" class="icon green"><span class="name">갯마을</span></a></div>
							  	<div class="blinker ko_spot68"><a href="#" class="icon green"><span class="name">광진</span></a></div>
							  	<div class="blinker ko_spot69"><a href="#" class="icon green"><span class="name">기사문</span></a></div>
							  	<div class="blinker ko_spot70"><a href="#" class="icon green"><span class="name">낙산</span></a></div>
							  	<div class="blinker ko_spot71"><a href="#" class="icon green"><span class="name">남애1</span></a></div>
							  	<div class="blinker ko_spot72"><a href="#" class="icon green"><span class="name">남애3</span></a></div>
							  	<div class="blinker ko_spot73"><a href="#" class="icon green"><span class="name">동산</span></a></div>
							  	<div class="blinker ko_spot74"><a href="#" class="icon green"><span class="name">동산포</span></a></div>
							  	<div class="blinker ko_spot75"><a href="#" class="icon green"><span class="name">동호</span></a></div>
							  	<div class="blinker ko_spot76"><a href="#" class="icon green"><span class="name">물치</span></a></div>
							  	<div class="blinker ko_spot77"><a href="#" class="icon green"><span class="name">북분</span></a></div>
							  	<div class="blinker ko_spot78"><a href="#" class="icon green"><span class="name">설악</span></a></div>
							  	<div class="blinker ko_spot79"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491668?c=14318674.5426549,4592639.8171162,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">송전</span></a></div>
							  	<div class="blinker ko_spot80"><a href="#" class="icon green"><span class="name">원포</span></a></div>
							  	<div class="blinker ko_spot81"><a href="#" class="icon green"><span class="name">인구</span></a></div>
							  	<div class="blinker ko_spot82"><a href="#" class="icon green"><span class="name">잔교</span></a></div>
							  	<div class="blinker ko_spot83"><a href="#" class="icon green"><span class="name">정암</span></a></div>
							  	<div class="blinker ko_spot84"><a href="#" class="icon green"><span class="name">죽도</span></a></div>
							  	<div class="blinker ko_spot85"><a href="#" class="icon green"><span class="name">중광정</span></a></div>
							  	<div class="blinker ko_spot86"><a href="#" class="icon green"><span class="name">지  경</span></a></div>
							  	<div class="blinker ko_spot87"><a href="#" class="icon green"><span class="name">하조대</span></a></div>
					  		</div>                 
	            		</div>
	            		<div class="summer_right">
	            			<div class="brd_scroll">
								<table class="brd_list tac">
									<caption>게시판으로 해수욕장명, 신호등, 개장일, 폐장일, 위치보기대한 정보를 표시합니다.</caption>
									<colgroup>
										<col style="width:30%;">
										<col>
										<col>
										<col>
										<col>
										<col>
									</colgroup>
									<thead>
										<tr>
											<th scope="col">해수욕장명</th>
											<th scope="col">신호등</th>
											<th scope="col">개장일</th>
											<th scope="col">폐장일</th>
											<th scope="col">위치보기</th>
										</tr>
									</thead>
									<tbody class="tbodyc">
										<tr id='seq1'>
											<td>강문</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq2'>
											<td>경포대</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq3'>
											<td>금진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq4'>
											<td>도직</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq5'>
											<td>등명</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq6'>
											<td>사근진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq7'>
											<td>사천</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq8'>
											<td>사천진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq9'>
											<td>송정</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq10'>
											<td>순긋</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq11'>
										    <td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491906?c=14350671.3042687,4547347.8752589,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>안목</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq12'>
											<td>안인</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq13'>
											<td>연곡</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq14'>
											<td>영진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq15'>
											<td>옥계</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq16'>
											<td>정동진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq17'>
											<td>주문진해변</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq18'>
											<td>하평</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq19'>
											<td>가진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq20'>
											<td>거진11리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq21'>
											<td>거진1리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq22'>
											<td>공현진1리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq23'>
											<td>공현진2리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq24'>
											<td>교암리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq25'>
											<td>대진1리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq26'>
											<td>대진5리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq27'>
											<td>마차진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq28'>
											<td>명파리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<!-- <tr id='seq29'>
											<td>문암2리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr> -->
										<tr id='seq30'>
											<td>문암캠핑장</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq31'>
											<td>반암리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq32'>
											<td>백도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq33'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491251?c=14303872.3788321,4625352.7124200,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>봉수대</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq34'>
											<td>봉포리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq35'>
											<td>삼포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq36'>
											<td>삼포2리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq37'>
											<td>송지호</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq38'>
											<td>송지호오토캠핑장</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq39'>
											<td>아야진리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq40'>
											<td>자작도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq41'>
											<td>천진리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq42'>
											<td>청간리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq43'>
											<td>초도리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq44'>
											<td>켄싱턴리조트</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq45'>
											<td>화진포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq46'>
											<td>화진포콘도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq47'>
											<td>노봉</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/14</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq48'>
											<td>망상</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/14</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq49'>
											<td>어달</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/14</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq50'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491792?c=14374244.7537851,4505880.5710189,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>추암</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/14</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq51'>
											<td>궁촌</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq52'>
											<td>덕산</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq53'>
											<td>맹방</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq54'>
											<td>문암</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq55'>
											<td>부남</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq56'>
											<td>삼척</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq57'>
											<td>오분(간이)</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq58'>
											<td>용화</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq59'>
											<td>원평</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq60'>
											<td>작은후진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq61'>
											<td>장호</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq62'>
											<td>증산</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq63'>
											<td>하맹방</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/15</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq64'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491890?c=14311411.4134225,4610202.4791827,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>등대</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq65'>
											<td>속초</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq66'>
											<td>외옹치</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq67'>
											<td>갯마을</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq68'>
											<td>광진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq69'>
											<td>기사문</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq70'>
											<td>낙산</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq71'>
											<td>남애1</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq72'>
											<td>남애3</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq73'>
											<td>동산</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq74'>
											<td>동산포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq75'>
											<td>동호</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq76'>
											<td>물치</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq77'>
											<td>북분</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq78'>
											<td>설악</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq79'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491668?c=14318674.5426549,4592639.8171162,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>송전</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq80'>
											<td>원포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq81'>
											<td>인구</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq82'>
											<td>잔교</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq83'>
											<td>정암</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq84'>
											<td>죽도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq85'>
											<td>중광정</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq86'>
											<td>지경</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq87'>
											<td>하조대</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
									</tbody>
								</table>
							</div>
	            		</div>
	            	</div>
				</div>
            </div><!-- cont_body -->
        </div><!-- // cont_wrap -->
        </div>
        <!--// container -->
        
        <!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	   <!--// container -->
	   
<script>
     
     $.ajax({
  			type:'post',
  			url:"/seantour_map/travel/mainBeachCongestion.do",
  		    success: function(data) {
  		    	/* console.log("check");
                console.log(data); */
                var tr = $('.tbodyc tr');
                tr.each(function(index, el) {
                /* 	console.log(el.id); */
                	data.forEach(function(e) {                		
                		if(e.seqId == el.id.split('seq')[1]) {
                			$('.blinker.blinker:eq('+index+')').find('a').removeClass();
    						if(e.congestion==1){
    							$('.blinker.blinker:eq('+index+')').find('a').addClass('icon green');
    							$(el).find('.beach').attr('class','icon green');
    						} else if (e.congestion==2){
    							$('.blinker.blinker:eq('+index+')').find('a').addClass('icon yellow');
    							$(el).find('.beach').attr('class','icon yellow');
    						} else{
    							$('.blinker.blinker:eq('+index+')').find('a').addClass('icon red');
    							$(el).find('.beach').attr('class','icon red');
    						}
                		} 
                	})
                })
  		    }
  			,error : function(err) {
  				console.log('error!!!!!');
			}
		})
	</script>
</body>
</html>
        
        	