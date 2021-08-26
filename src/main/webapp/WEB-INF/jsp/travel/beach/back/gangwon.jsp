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
							  		<button type="button">강원도광역시 해수욕장 혼잡도 신호등</button>
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
							  	<div class="blinker ko_spot11"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon red"><span class="name">안목</span></a></div>
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
							  	<div class="blinker ko_spot29"><a href="#" class="icon green"><span class="name">문암진2리</span></a></div>
							  	<div class="blinker ko_spot30"><a href="#" class="icon green"><span class="name">문암캠핑장</span></a></div>
							  	<div class="blinker ko_spot31"><a href="#" class="icon green"><span class="name">반암리</span></a></div>
							  	<div class="blinker ko_spot32"><a href="#" class="icon green"><span class="name">백도</span></a></div>
							  	<div class="blinker ko_spot33"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">봉수대</span></a></div>
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
							  	<div class="blinker ko_spot50"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/11491792?placePath=%3Fentry=pll%26from=nx%26fromNxList=true&c=14377740.5642822,4505215.3335518,14,0,0,0,dh" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">추암</span></a></div>
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
							  	<div class="blinker ko_spot64"><a href="#" class="icon green"><span class="name">등대</span></a></div>
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
							  	<div class="blinker ko_spot79"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">송전</span></a></div>
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
										<tr>
											<td>강문해수욕장</td>
											<td>준비중</span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>경포대해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach1"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>금진해수욕장</td>
											<td>준비중</span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>도직해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>동명해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>사근진해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>사천해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>사천진해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>송정해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>순긋해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>안목해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>안인해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>연곡해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>영진해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>옥계해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>정동진해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach15"></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>주문진해변해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach16"></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>하평해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>가진진해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>거진11리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>거진1리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>공현진1리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>공현진2리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>교암리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>대진1리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>대진5리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>마차진해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>명파리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>문암진2리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>문암캠핑장해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>반암리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>백도해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>봉수대해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>봉포리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>삼포해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach34"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>삼포2리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>송지호해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach36"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>송지호오토캠핑장해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach37"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" >위치보기</a></td>
										</tr>
										<tr>
											<td>아야진리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>자작도해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>천진리해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach40"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>청간리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>초도리해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>켄싱턴리조트해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>화진포해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach44"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>화진포 콘도해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>노봉해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>망상해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach47"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>어달해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>추암해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach49"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>궁촌해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>덕산해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>맹방해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach52"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>문암해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>부남해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>삼척해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach55"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" >위치보기</a></td>
										</tr>
										<tr>
											<td>오분(간이)해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>용화해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach57"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>원평해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>작은후진해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>장호해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>증산 해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>하맹방해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>등대해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach63"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>속초해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach64"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>외옹치해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach65"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>갯마을해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>광진해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>기사문해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>낙산해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach69"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" >위치보기</a></td>
										</tr>
										<tr>
											<td>남애1해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>남애3해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>동산해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>동산포해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>동호해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>물치해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>북분해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>설악해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>송전해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>원포해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>인구해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>잔교해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>정암해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>죽도해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>중광정해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach84"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>지경해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>하조대해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach86"></td>
											<td>7/1</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" >위치보기</a></td>
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
					//경포대 해수욕장
					if(i==1){
						$('.blinker.ko_spot2').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot2').find('a').addClass('icon green');$("#beach1").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot2').find('a').addClass('icon yellow');$("#beach1").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot2').find('a').addClass('icon red');$("#beach1").attr('class','tbl_icon icon red');}
					}
					//낙산 해수욕장
					if(i==69){
						$('.blinker.ko_spot70').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot70').find('a').addClass('icon green');$("#beach69").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot70').find('a').addClass('icon yellow');$("#beach69").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot70').find('a').addClass('icon red');$("#beach69").attr('class','tbl_icon icon red');}
					}
					//속초 해수욕장
					if(i==64){
						$('.blinker.ko_spot65').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot65').find('a').addClass('icon green');$("#beach64").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot65').find('a').addClass('icon yellow');$("#beach64").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot65').find('a').addClass('icon red');$("#beach64").attr('class','tbl_icon icon red');}
					}
					//삼척 해수욕장
					if(i==55){
						$('.blinker.ko_spot56').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot56').find('a').addClass('icon green');$("#beach55").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot56').find('a').addClass('icon yellow');$("#beach55").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot56').find('a').addClass('icon red');$("#beach55").attr('class','tbl_icon icon red');}
					}
					//망상 해수욕장
					if(i==47){
						$('.blinker.ko_spot48').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot48').find('a').addClass('icon green');$("#beach47").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot48').find('a').addClass('icon yellow');$("#beach47").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot48').find('a').addClass('icon red');$("#beach47").attr('class','tbl_icon icon red');}
					}
					//맹방 해수욕장
					if(i==52){
						$('.blinker.ko_spot53').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot53').find('a').addClass('icon green');$("#beach52").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot53').find('a').addClass('icon yellow');$("#beach52").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot53').find('a').addClass('icon red');$("#beach52").attr('class','tbl_icon icon red');}
					}
					//추암 해수욕장
					if(i==49){
						$('.blinker.ko_spot50').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot50').find('a').addClass('icon green');$("#beach49").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot50').find('a').addClass('icon yellow');$("#beach49").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot50').find('a').addClass('icon red');$("#beach49").attr('class','tbl_icon icon red');}
					}
					//하조대 해수욕장
					if(i==86){
						$('.blinker.ko_spot87').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot87').find('a').addClass('icon green');$("#beach86").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot87').find('a').addClass('icon yellow');$("#beach86").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot87').find('a').addClass('icon red');$("#beach86").attr('class','tbl_icon icon red');}
					}
					//주문진 해수욕장
					if(i==16){
						$('.blinker.ko_spot17').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot17').find('a').addClass('icon green');$("#beach16").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot17').find('a').addClass('icon yellow');$("#beach16").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot17').find('a').addClass('icon red');$("#beach16").attr('class','tbl_icon icon red');}
					}
					//송지호 해수욕장
					if(i==36){
						$('.blinker.ko_spot36').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot37').find('a').addClass('icon green');$("#beach36").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot37').find('a').addClass('icon yellow');$("#beach36").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot37').find('a').addClass('icon red');$("#beach36").attr('class','tbl_icon icon red');}
					}
					//화진포 해수욕장
					if(i==44){
						$('.blinker.ko_spot45').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot45').find('a').addClass('icon green');$("#beach44").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot45').find('a').addClass('icon yellow');$("#beach44").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot45').find('a').addClass('icon red');$("#beach44").attr('class','tbl_icon icon red');}
					}
					//외옹치 해수욕장
					if(i==65){
						$('.blinker.ko_spot66').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot66').find('a').addClass('icon green');$("#beach65").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot66').find('a').addClass('icon yellow');$("#beach65").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot66').find('a').addClass('icon red');$("#beach65").attr('class','tbl_icon icon red');}
					}
					//삼포 해수욕장
					if(i==35){
						$('.blinker.ko_spot34').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot35').find('a').addClass('icon green');$("#beach34").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot35').find('a').addClass('icon yellow');$("#beach34").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot35').find('a').addClass('icon red');$("#beach34").attr('class','tbl_icon icon red');}
					}
					//정동진 해수욕장
					if(i==15){
						$('.blinker.ko_spot16').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.ko_spot16').find('a').addClass('icon green');$("#beach15").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.ko_spot16').find('a').addClass('icon yellow');$("#beach15").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.ko_spot16').find('a').addClass('icon red');$("#beach15").attr('class','tbl_icon icon red');}
					}
					//용화 해수욕장
					if(i==57){
						$('.blinker.blinker ko_spot58').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.blinker ko_spot58').find('a').addClass('icon green');$("#beach57").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.blinker ko_spot58').find('a').addClass('icon yellow');$("#beach57").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.blinker ko_spot58').find('a').addClass('icon red');$("#beach57").attr('class','tbl_icon icon red');}
					}
					//등대 해수욕장
					if(i==63){
						$('.blinker.blinker ko_spot64').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.blinker ko_spot64').find('a').addClass('icon green');$("#beach63").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.blinker ko_spot64').find('a').addClass('icon yellow');$("#beach63").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.blinker ko_spot64').find('a').addClass('icon red');$("#beach63").attr('class','tbl_icon icon red');}
					}
					//송지호오토캠핑장 해수욕장
					if(i==37){
						$('.blinker.blinker ko_spot38').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.blinker ko_spot38').find('a').addClass('icon green');$("#beach37").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.blinker ko_spot38').find('a').addClass('icon yellow');$("#beach37").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.blinker ko_spot38').find('a').addClass('icon red');$("#beach37").attr('class','tbl_icon icon red');}
					}
					//중광정 해수욕장
					if(i==84){
						$('.blinker.blinker ko_spot85').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.blinker ko_spot85').find('a').addClass('icon green');$("#beach84").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.blinker ko_spot85').find('a').addClass('icon yellow');$("#beach84").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.blinker ko_spot85').find('a').addClass('icon red');$("#beach84").attr('class','tbl_icon icon red');}
					}
					//천진 해수욕장
					if(i==40){
						$('.blinker.blinker ko_spot41').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.blinker ko_spot41').find('a').addClass('icon green');$("#beach40").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.blinker ko_spot41').find('a').addClass('icon yellow');$("#beach40").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.blinker ko_spot41').find('a').addClass('icon red');$("#beach40").attr('class','tbl_icon icon red');}
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
        
        	