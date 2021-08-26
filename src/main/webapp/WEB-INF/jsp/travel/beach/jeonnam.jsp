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
							  		<button type="button">전라남도 해수욕장 혼잡도 신호등</button>
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
					  		<div class="location_map map_jb">
					  			<img src="/seantour_map/travel/images/main_summer/img_map_jn.jpg" alt="전라남도" />
				  				<div class="spot_info"><img src="/seantour_map/travel/images/main_summer/img_info_box.jpg" alt="혼잡:　거리두기(2m)불가, 혼잡우려: 거리두기(2m)불가, 적정:거리두기(2m)곤란" /></div>
							  	<div class="blinker jn_spot1"><a href="#" class="icon green"><span class="name">금장</span></a></div>
							  	<div class="blinker jn_spot2"><a href="#" class="icon yellow"><span class="name">나로우주</span></a></div>
							  	<div class="blinker jn_spot3"><a href="#" class="icon green"><span class="name">남열해돋이</span></a></div>
							  	<div class="blinker jn_spot4"><a href="#" class="icon red"><span class="name">대전</span></a></div>
							  	<div class="blinker jn_spot5"><a href="#" class="icon red"><span class="name">덕흥</span></a></div>
							  	<div class="blinker jn_spot6"><a href="#" class="icon red"><span class="name">발포</span></a></div>
							  	<div class="blinker jn_spot7"><a href="#" class="icon red"><span class="name">연소</span></a></div>
							  	<div class="blinker jn_spot8"><a href="#" class="icon green"><span class="name">염포</span></a></div>
							  	<div class="blinker jn_spot9"><a href="#" class="icon green"><span class="name">용동</span></a></div>
							  	<div class="blinker jn_spot10"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491690?c=14150202.6456768,4086738.4872215,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">익금</span></a></div>
							  	<div class="blinker jn_spot11"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/21656477?c=14159379.3458240,4118291.0806314,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">풍류</span></a></div>
							  	<div class="blinker jn_spot12"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491630?c=14055210.5627094,4134134.2028237,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">외달도</span></a></div>
							  	<div class="blinker jn_spot13"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491765?c=14143880.1438777,4119126.4445431,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">구영율포솔밭</span></a></div>
							  	<div class="blinker jn_spot14"><a href="#" class="icon green"><span class="name">대광</span></a></div>
							  	<div class="blinker jn_spot15"><a href="#" class="icon green"><span class="name">돈목</span></a></div>
							  	<div class="blinker jn_spot16"><a href="#" class="icon green"><span class="name">배낭기미</span></a></div>
							  	<div class="blinker jn_spot17"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13444331?c=14026883.0473594,4143419.7767450,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">백길</span></a></div>
							  	<div class="blinker jn_spot18"><a href="#" class="icon green"><span class="name">분계</span></a></div>
							  	<div class="blinker jn_spot19"><a href="#" class="icon green"><span class="name">설레미</span></a></div>
							  	<div class="blinker jn_spot20"><a href="#" class="icon green"><span class="name">시목</span></a></div>
							  	<div class="blinker jn_spot21"><a href="#" class="icon green"><span class="name">신도</span></a></div>
							  	<div class="blinker jn_spot22"><a href="#" class="icon green"><span class="name">우전</span></a></div>
							  	<div class="blinker jn_spot23"><a href="#" class="icon green"><span class="name">원평</span></a></div>
							  	<div class="blinker jn_spot24"><a href="#" class="icon green"><span class="name">짱뚱어</span></a></div>
							  	<div class="blinker jn_spot25"><a href="#" class="icon green"><span class="name">추포</span></a></div>
							  	<div class="blinker jn_spot26"><a href="#" class="icon green"><span class="name">하트</span></a></div>
							  	<div class="blinker jn_spot27"><a href="#" class="icon green"><span class="name">홍도</span></a></div><!---->
							  	<div class="blinker jn_spot28"><a href="#" class="icon green"><span class="name">황성금리</span></a></div>
							  	<div class="blinker jn_spot57"><a href="#" class="icon green"><span class="name">낭도</span></a></div>
							  	<div class="blinker jn_spot58"><a href="#" class="icon green"><span class="name">대풍</span></a></div>
							  	
							  	<div class="blinker jn_spot29"><a href="#" class="icon green"><span class="name">만성리</span></a></div>
							  	<div class="blinker jn_spot30"><a href="#" class="icon green"><span class="name">모사금</span></a></div>
							  	<div class="blinker jn_spot31"><a href="#" class="icon green"><span class="name">무슬목</span></a></div>
							  	<div class="blinker jn_spot32"><a href="#" class="icon green"><span class="name">방죽포</span></a></div>
							  	<div class="blinker jn_spot59"><a href="#" class="icon green"><span class="name">사도</span></a></div>
							  	<div class="blinker jn_spot60"><a href="#" class="icon green"><span class="name">서도</span></a></div>
							  	<div class="blinker jn_spot61"><a href="#" class="icon green"><span class="name">손죽</span></a></div>
							  	<div class="blinker jn_spot62"><a href="#" class="icon green"><span class="name">신덕</span></a></div>
							  	
							  	<div class="blinker jn_spot33"><a href="#" class="icon green"><span class="name">안도</span></a></div>
							  	<div class="blinker jn_spot34"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/19912822?c=14208179.7289133,4129603.3263299,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">웅천</span></a></div>
							  	<div class="blinker jn_spot35"><a href="#" class="icon green"><span class="name">유림(거문도)</span></a></div>
							  	<div class="blinker jn_spot36"><a href="#" class="icon green"><span class="name">장등</span></a></div>
							  	<div class="blinker jn_spot63"><a href="#" class="icon green"><span class="name">정강</span></a></div>
							  	
							  	<div class="blinker jn_spot37"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491644?c=14067894.4724696,4218221.0843953,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">가마미</span></a></div>
							  	<div class="blinker jn_spot38"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491435?c=14039352.8563430,4201179.5874332,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">송이도</span></a></div>
							  	<div class="blinker jn_spot39"><a href="#" class="icon green"><span class="name">금일 명사십리</span></a></div>
							  	<div class="blinker jn_spot40"><a href="#" class="icon green"><span class="name">보길 예송</span></a></div>
							  	<div class="blinker jn_spot41"><a href="#" class="icon green"><span class="name">보길 중리</span></a></div>
							  	<div class="blinker jn_spot42"><a href="#" class="icon green"><span class="name">보길 통리</span></a></div>
							  	<div class="blinker jn_spot43"><a href="#" class="icon green"><span class="name">생일 금곡</span></a></div>
							  	<div class="blinker jn_spot44"><a href="#" class="icon green"><span class="name">신지 동고</span></a></div>
								<div class="blinker jn_spot45"><a href="https://map.naver.com/v5/search/%EC%8B%A0%EC%A7%80%EB%AA%85%EC%82%AC%EC%8B%AD%EB%A6%AC/place/13491974?c=14115535.6634374,4072777.7323125,15,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">신지명사십리</span></a></div>
							  	<div class="blinker jn_spot46" ><a href="#" class="icon green"><span class="name">약산 가사</span></a></div>
							  	<div class="blinker jn_spot47"><a href="#" class="icon green"><span class="name">청산 신흥</span></a></div>
							  	<div class="blinker jn_spot48"><a href="#" class="icon green"><span class="name">청산 지리</span></a></div>
							  	<div class="blinker jn_spot49"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491694?c=14137716.0274501,4114403.4913664,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">수문</span></a></div>
							  	<div class="blinker jn_spot50"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491643?c=14062113.2171667,4087469.8358466,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">가계</span></a></div>
							  	<div class="blinker jn_spot51"><a href="#" class="icon green"><span class="name">관매도</span></a></div>
							  	<div class="blinker jn_spot52"><a href="#" class="icon green"><span class="name">금갑</span></a></div>
							  	<div class="blinker jn_spot53"><a href="#" class="icon green"><span class="name">신전</span></a></div>
							  	<div class="blinker jn_spot54"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11719812?c=14071641.6980367,4175695.4807004,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">돌머리</span></a></div>
							  	<!-- <div class="blinker jn_spot55"><a href="#" class="icon green"><span class="name">사구미</span></a></div> -->
							  	<div class="blinker jn_spot56"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491232?c=14406869.4686464,4254251.5867986,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">송호</span></a></div>
							  	
							  	
							  	
					  		</div>
	            		</div>
	            		<div class="summer_right">
	            			<div class="brd_scroll">
								<table class="brd_list tac">
									<caption>게시판으로 제목, 글쓴이, 날짜, 조회수에 대한 정보를 표시합니다.</caption>
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
										<tr id="seq159">
											<td>금장</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq160">
											<td>나로우주</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq161">
											<td>남열해돋이</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq162">
											<td>대전</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq163">
											<td>덕흥</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/17</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq164">
											<td>발포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq165">
											<td>연소</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq166">
											<td>염포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq167">
											<td>용동</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/20</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq168">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491690?c=14150202.6456768,4086738.4872215,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>익금</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq169">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/21656477?c=14159379.3458240,4118291.0806314,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>풍류</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq170">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491630?c=14055210.5627094,4134134.2028237,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>외달도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/8</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq171">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491765?c=14143880.1438777,4119126.4445431,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>구영율포솔밭</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq172">
											<td>대광</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq173">
											<td>돈목</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq174">
											<td>배낭기미</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq175">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13444331?c=14026883.0473594,4143419.7767450,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>백길</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq176">
											<td>분계</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq177">
											<td>설레미</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq178">
											<td>시목</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq179">
											<td>신도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq180">
											<td>우전</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq181">
											<td>원평</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq182">
											<td>짱뚱어</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq183">
											<td>추포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq184">
											<td>하트</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq185">
											<td>홍도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq186">
											<td>황성금리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq187">
											<td>낭도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq188">
											<td>대풍</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq189">
											<td>만성리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq190">
											<td>모사금</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq191">
											<td>무슬목</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq192">
											<td>방죽포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq193">
											<td>사도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq194">
											<td>서도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq195">
											<td>손죽</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq196">
											<td>신덕</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq197">
											<td>안도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq198">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/19912822?c=14208179.7289133,4129603.3263299,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>웅천</td>
					
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq199">
											<td>유림(거문도)</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq200">
											<td>장등</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq201">
											<td>정강</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq202">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491644?c=14067894.4724696,4218221.0843953,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>가마미</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq203">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491435?c=14039352.8563430,4201179.5874332,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>송이도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/17</td>
											<td>8/8</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq204">
											<td>금일 명사십리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq205">
											<td>보길 예송</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq206">
											<td>보길 중리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq207">
											<td>보길 통리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq208">
											<td>생일 금곡</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq209">
											<td>신지 동고</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq210">
											<td><a href='https://map.naver.com/v5/search/%EC%8B%A0%EC%A7%80%EB%AA%85%EC%82%AC%EC%8B%AD%EB%A6%AC/place/13491974?c=14115535.6634374,4072777.7323125,15,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>신지명사십리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq211">
											<td>약산 가사</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq212">
											<td>청산 신흥</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq213">
											<td>청산 지리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq214">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491694?c=14137716.0274501,4114403.4913664,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>수문</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/8</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq215">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491643?c=14062113.2171667,4087469.8358466,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>가계</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq216">
											<td>관매도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq217">
											<td>금갑</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq218">
											<td>신전</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq219">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11719812?c=14071641.6980367,4175695.4807004,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>돌머리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq220">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491232?c=14406869.4686464,4254251.5867986,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>송호</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/17</td>
											<td>8/15</td>
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
        
        	