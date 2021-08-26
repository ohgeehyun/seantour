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
							  		<button type="button">충청남도 해수욕장 혼잡도 신호등</button>
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
					  		<div class="location_map map_cn">
					  			<img src="/seantour_map/travel/images/main_summer/img_map_cn.jpg" alt="충청남도" />
				  				<div class="spot_info"><img src="/seantour_map/travel/images/main_summer/img_info_box.jpg" alt="혼잡:　거리두기(2m)불가, 혼잡우려: 거리두기(2m)불가, 적정:거리두기(2m)곤란" /></div>
							  	<div class="blinker cn_spot1"><a href="#" class="icon green"><span class="name">왜목마을</span></a></div>
							  	<div class="blinker cn_spot2"><a href="#" class="icon yellow"><span class="name">난지섬</span></a></div>
							  	<div class="blinker cn_spot3"><a href="#" class="icon green"><span class="name">대천</span></a></div>
							  	<div class="blinker cn_spot4"><a href="#" class="icon red"><span class="name">무창포</span></a></div>
							  	<div class="blinker cn_spot5"><a href="#" class="icon red"><span class="name">춘장대</span></a></div>
							  	<div class="blinker cn_spot6"><a href="#" class="icon red"><span class="name">갈음이</span></a></div>
							  	<div class="blinker cn_spot7"><a href="#" class="icon red"><span class="name">곰섬</span></a></div>
							  	<div class="blinker cn_spot8"><a href="#" class="icon red"><span class="name">구례포</span></a></div>
							  	<div class="blinker cn_spot9"><a href="#" class="icon red"><span class="name">구름포</span></a></div>
							  	<div class="blinker cn_spot10"><a href="#" class="icon red"><span class="name">기지포</span></a></div>
							  	<div class="blinker cn_spot11"><a href="#" class="icon red"><span class="name">꽃지</span></a></div>
							  	<div class="blinker cn_spot12"><a href="#" class="icon red"><span class="name">꾸지나무골</span></a></div>
							  	<div class="blinker cn_spot13"><a href="#" class="icon red"><span class="name">달산포</span></a></div>
							  	<div class="blinker cn_spot14"><a href="#" class="icon red"><span class="name">마검포</span></a></div>
							  	<div class="blinker cn_spot15"><a href="#" class="icon red"><span class="name">만리포</span></a></div>
							  	<div class="blinker cn_spot16"><a href="#" class="icon red"><span class="name">몽산포</span></a></div>
							  	<div class="blinker cn_spot17"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13490884?c=14064793.8461647,4357375.7562335,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">바람아래</span></a></div>
							  	<div class="blinker cn_spot18"><a href="#" class="icon red"><span class="name">밧개</span></a></div>
							  	<div class="blinker cn_spot19"><a href="#" class="icon red"><span class="name">방주골(백리포)</span></a></div>
							  	<div class="blinker cn_spot20"><a href="#" class="icon red"><span class="name">방포</span></a></div>
							  	<div class="blinker cn_spot21"><a href="#" class="icon red"><span class="name">백사장</span></a></div>
							  	<div class="blinker cn_spot22"><a href="#" class="icon red"><span class="name">삼봉</span></a></div>
							  	<div class="blinker cn_spot23"><a href="#" class="icon red"><span class="name">샛별</span></a></div>
							  	<div class="blinker cn_spot24"><a href="#" class="icon red"><span class="name">신두리</span></a></div>
							  	<div class="blinker cn_spot25"><a href="#" class="icon red"><span class="name">안면</span></a></div>
							  	<div class="blinker cn_spot26"><a href="#" class="icon red"><span class="name">어은돌</span></a></div>
							  	<div class="blinker cn_spot27"><a href="#" class="icon red"><span class="name">연포</span></a></div>
							  	<div class="blinker cn_spot28"><a href="#" class="icon red"><span class="name">의항</span></a></div>
							  	<div class="blinker cn_spot29"><a href="#" class="icon red"><span class="name">장삼포</span></a></div>
							  	<div class="blinker cn_spot30"><a href="#" class="icon red"><span class="name">천리포</span></a></div>
							  	<div class="blinker cn_spot31"><a href="#" class="icon red"><span class="name">청포대</span></a></div>
							  	<div class="blinker cn_spot32"><a href="#" class="icon red"><span class="name">파도리</span></a></div>
							  	<div class="blinker cn_spot33"><a href="#" class="icon red"><span class="name">학암포</span></a></div>
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
										<tr id="seq241">
											<td>왜목마을</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq242">
											<td>난지섬</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq243">
											<td>대천</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq244">
											<td>무창포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq245">
											<td>춘장대</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq246">
											<td>갈음이</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq247">
											<td>곰섬</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq248">
											<td>구례포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq249">
											<td>구름포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq250">
											<td>기지포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq251">
											<td>꽃지</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq252">
											<td>꾸지나무골</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq253">
											<td>달산포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq254">
											<td>마검포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq255">
											<td>만리포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq256">
											<td>몽산포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq257">
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13490884?c=14064793.8461647,4357375.7562335,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>바람아래</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq258">
											<td>밧개</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq259">
											<td>방주골(백리포)</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq260">
											<td>방포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq261">
											<td>백사장</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq262">
											<td>삼봉</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq263">
											<td>샛별</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq264">
											<td>신두리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq265">
											<td>안면</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq266">
											<td>어은돌</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq267">
											<td>연포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq268">
											<td>의항</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq269">
											<td>장삼포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq270">
											<td>천리포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq271">
											<td>청포대</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq272">
											<td>파도리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id="seq273">
											<td>학암포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
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
	   <!--// container 6개-->
	   
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
        
        	