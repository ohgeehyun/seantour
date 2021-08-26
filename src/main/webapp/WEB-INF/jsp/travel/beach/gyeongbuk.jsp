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
							  		<button type="button">경상북도 해수욕장 혼잡도 신호등</button>
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
					  		<div class="location_map map_kb">
					  			<img src="/seantour_map/travel/images/main_summer/img_map_kb.jpg" alt="경상북도" />
				  				<div class="spot_info"><img src="/seantour_map/travel/images/main_summer/img_info_box.jpg" alt="혼잡:　거리두기(2m)불가, 혼잡우려: 거리두기(2m)불가, 적정:거리두기(2m)곤란" /></div>
							  	<div class="blinker kb_spot1"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491232?c=14406869.4686464,4254251.5867986,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">관성</span></a></div>
							  	<div class="blinker kb_spot2"><a href="#" class="icon yellow"><span class="name">나정</span></a></div>
							  	<div class="blinker kb_spot3"><a href="#" class="icon green"><span class="name">봉길대왕암</span></a></div>
							  	<div class="blinker kb_spot4"><a href="#" class="icon red"><span class="name">오류</span></a></div>
							  	<div class="blinker kb_spot5"><a href="#" class="icon red"><span class="name">전촌</span></a></div>
							  	<div class="blinker kb_spot6"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/21656453?c=14404710.1933516,4367169.6165003,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">경정</span></a></div>
							  	<div class="blinker kb_spot7"><a href="#" class="icon red"><span class="name">고래불</span></a></div>
							  	<div class="blinker kb_spot8"><a href="#" class="icon red"><span class="name">남호</span></a></div>
							  	<div class="blinker kb_spot9"><a href="#" class="icon red"><span class="name">대진</span></a></div>
							  	<div class="blinker kb_spot10"><a href="#" class="icon red"><span class="name">오보</span></a></div>
							  	<div class="blinker kb_spot11"><a href="#" class="icon red"><span class="name">장사</span></a></div>
							  	<div class="blinker kb_spot12"><a href="#" class="icon red"><span class="name">하저</span></a></div>
							  	<div class="blinker kb_spot13"><a href="#" class="icon red"><span class="name">구산</span></a></div>
							  	<div class="blinker kb_spot14"><a href="#" class="icon red"><span class="name">기성망양</span></a></div>
							  	<div class="blinker kb_spot15"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491753?c=14397831.4725848,4456819.7294104,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">나곡</span></a></div>
							  	<div class="blinker kb_spot16"><a href="#" class="icon red"><span class="name">망양정</span></a></div>
							  	<div class="blinker kb_spot17"><a href="#" class="icon red"><span class="name">봉평</span></a></div>
							  	<div class="blinker kb_spot18"><a href="#" class="icon red"><span class="name">후정</span></a></div>
							  	<div class="blinker kb_spot19"><a href="#" class="icon red"><span class="name">후포</span></a></div>
							  	<div class="blinker kb_spot20"><a href="#" class="icon red"><span class="name">구룡포</span></a></div>
							  	<div class="blinker kb_spot21"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13444973?c=14407640.1000853,4299548.1571439,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">도구</span></a></div>
							  	<div class="blinker kb_spot22"><a href="#" class="icon red"><span class="name">영일대</span></a></div>
							  	<div class="blinker kb_spot23"><a href="#" class="icon red"><span class="name">월포</span></a></div>
							  	<div class="blinker kb_spot24"><a href="#" class="icon red"><span class="name">칠포</span></a></div>
							  	<div class="blinker kb_spot25"><a href="#" class="icon red"><span class="name">화진</span></a></div>
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
										<tr id='seq114'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491232?c=14406869.4686464,4254251.5867986,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>관성</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq115'>
											<td>나정</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq116'>
											<td>봉길대왕암</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq117'>
											<td>오류</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq118'>
											<td>전촌</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq119'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/21656453?c=14404710.1933516,4367169.6165003,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>경정</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq120'>
											<td>고래불</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq121'>
											<td>남호</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq122'>
											<td>대진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq123'>
											<td>오보</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq124'>
											<td>장사</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq125'>
											<td>하저</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq126'>
											<td>구산</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq127'>
											<td>기성망양</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq128'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491753?c=14397831.4725848,4456819.7294104,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>나곡</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq129'>
											<td>망양정</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq130'>
											<td>봉평</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq131'>
											<td>후정</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq132'>
											<td>후포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq133'>
											<td>구룡포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq134'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13444973?c=14407640.1000853,4299548.1571439,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><div class="visual"><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>도구</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq135'>
											<td>영일대</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq136'>
											<td>월포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq137'>
											<td>칠포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq138'>
											<td>화진</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										
									</tbody>
								</table>
							</div>
	            		</div>
	            	</div>
				</div>
            </div><!-- cont_body 2개  -->
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
        
        	