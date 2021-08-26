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
							  	<div class="blinker jn_spot10"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">익금</span></a></div>
							  	<div class="blinker jn_spot11"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">풍류</span></a></div>
							  	<div class="blinker jn_spot12"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">외달도</span></a></div>
							  	<div class="blinker jn_spot13"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">율포솔밭</span></a></div>
							  	<div class="blinker jn_spot14"><a href="#" class="icon green"><span class="name">대광</span></a></div>
							  	<div class="blinker jn_spot15"><a href="#" class="icon green"><span class="name">돈목</span></a></div>
							  	<div class="blinker jn_spot16"><a href="#" class="icon green"><span class="name">배낭기미</span></a></div>
							  	<div class="blinker jn_spot17"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">백길</span></a></div>
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
							  	<div class="blinker jn_spot29"><a href="#" class="icon green"><span class="name">만성리</span></a></div>
							  	<div class="blinker jn_spot30"><a href="#" class="icon green"><span class="name">모사금</span></a></div>
							  	<div class="blinker jn_spot31"><a href="#" class="icon green"><span class="name">무슬목</span></a></div>
							  	<div class="blinker jn_spot32"><a href="#" class="icon green"><span class="name">방죽포</span></a></div>
							  	<div class="blinker jn_spot33"><a href="#" class="icon green"><span class="name">안도</span></a></div>
							  	<div class="blinker jn_spot34"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">웅천</span></a></div><!---->
							  	<div class="blinker jn_spot35"><a href="#" class="icon green"><span class="name">유림(거문도)</span></a></div>
							  	<div class="blinker jn_spot36"><a href="#" class="icon green"><span class="name">장등</span></a></div>
							  	<div class="blinker jn_spot37"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">가마미</span></a></div>
							  	<div class="blinker jn_spot38"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">송이도</span></a></div><!---->
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
							  	<div class="blinker jn_spot49"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">수문</span></a></div>
							  	<div class="blinker jn_spot50"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">가계</span></a></div>
							  	<div class="blinker jn_spot51"><a href="#" class="icon green"><span class="name">관매도</span></a></div>
							  	<div class="blinker jn_spot52"><a href="#" class="icon green"><span class="name">금갑</span></a></div>
							  	<div class="blinker jn_spot53"><a href="#" class="icon green"><span class="name">신전</span></a></div>
							  	<div class="blinker jn_spot54"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">돌머리</span></a></div>
							  	<div class="blinker jn_spot55"><a href="#" class="icon green"><span class="name">사구미</span></a></div>
							  	<div class="blinker jn_spot56"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">송호</span></a></div>
							  	<div class="blinker jn_spot57"><a href="#" class="icon green"><span class="name">낭도</span></a></div>
							  	<div class="blinker jn_spot58"><a href="#" class="icon green"><span class="name">대풍</span></a></div>
							  	<div class="blinker jn_spot59"><a href="#" class="icon green"><span class="name">사도</span></a></div>
							  	<div class="blinker jn_spot60"><a href="#" class="icon green"><span class="name">서도</span></a></div>
							  	<div class="blinker jn_spot61"><a href="#" class="icon green"><span class="name">손죽</span></a></div>
							  	<div class="blinker jn_spot62"><a href="#" class="icon green"><span class="name">신덕</span></a></div>
							  	<div class="blinker jn_spot63"><a href="#" class="icon green"><span class="name">정강</span></a></div>
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
										<tr>
											<td>금장해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>나로우주해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>남열해돋이해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>대전해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>덕흥해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/17</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>발포해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>연소해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>염포해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>용동해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/20</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>익금해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>풍류해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>외달도해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>율포솔밭해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>대광해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>돈목해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>배낭기미해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>백길해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>분계해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>설레미해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>시목해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>신도해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>우전해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>원평해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>짱뚱어해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>추포해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>하트해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>홍도해수욕장</td>
											<td>준비중</td>
											<td>미개장</td>
											<td>미개장</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>황성금리해수욕장</td>
											<td>준비중</td>
											<td>7/12</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>				
										<tr>
											<td>만성리해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>모사금해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>무슬목해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>방죽포해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>안도해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>웅천해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>유림(거문도)해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>장등해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/23</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>가마미해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>송이도해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/8</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>금일 명사십리해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>보길 예송해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>보길 중리해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>보길 통리해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>생일 금곡해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>신지 동고해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>신지명사십리해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach209"></td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>약산 가사해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>청산 신흥해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>청산 지리해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>수문해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/8</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>가계해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>관매도해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>금갑해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>신전해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>돌머리해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<!-- <tr>
											<td>사구미해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr> -->
										<tr>
											<td>송호해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>낭도해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>대풍해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>사도해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>서도해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>손죽해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>신덕해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>정강해수욕장</td>
											<td>준비중</td>
											<td>7/17</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
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
                
				for(var i=0; i < data.length; i++){
					//신지명사십리 해수욕장
					if(i==209){
						$('.blinker.jn_spot45').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.jn_spot45').find('a').addClass('icon green');$("#beach209").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.jn_spot45').find('a').addClass('icon yellow');$("#beach209").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.jn_spot45').find('a').addClass('icon red');$("#beach209").attr('class','tbl_icon icon red');}
					}
				}
		    },
		    error: function(err) {		    	
			 	alert("신호등 데이터를 가져오는 도중 오류가 발생하였습니다."); 
		    }
     })
	</script>
</body>
</html>
        
        	