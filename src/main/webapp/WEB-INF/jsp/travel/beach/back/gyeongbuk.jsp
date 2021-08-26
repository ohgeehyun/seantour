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
							  	<div class="blinker kb_spot1"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491232?placePath=%3Fentry=pll%26from=nx%26fromNxList=true&c=14410134.7698740,4254251.5867986,15,0,0,0,dh" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">관성</span></a></div>
							  	<div class="blinker kb_spot2"><a href="#" class="icon yellow"><span class="name">나정</span></a></div>
							  	<div class="blinker kb_spot3"><a href="#" class="icon green"><span class="name">봉길대왕암</span></a></div>
							  	<div class="blinker kb_spot4"><a href="#" class="icon red"><span class="name">오류</span></a></div>
							  	<div class="blinker kb_spot5"><a href="#" class="icon red"><span class="name">전촌</span></a></div>
							  	<div class="blinker kb_spot6"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon red"><span class="name">경정</span></a></div>
							  	<div class="blinker kb_spot7"><a href="#" class="icon red"><span class="name">고래불</span></a></div>
							  	<div class="blinker kb_spot8"><a href="#" class="icon red"><span class="name">남호</span></a></div>
							  	<div class="blinker kb_spot9"><a href="#" class="icon red"><span class="name">대진</span></a></div>
							  	<div class="blinker kb_spot10"><a href="#" class="icon red"><span class="name">오보</span></a></div>
							  	<div class="blinker kb_spot11"><a href="#" class="icon red"><span class="name">장사</span></a></div>
							  	<div class="blinker kb_spot12"><a href="#" class="icon red"><span class="name">하저</span></a></div>
							  	<div class="blinker kb_spot13"><a href="#" class="icon red"><span class="name">구산</span></a></div>
							  	<div class="blinker kb_spot14"><a href="#" class="icon red"><span class="name">기성망양</span></a></div>
							  	<div class="blinker kb_spot15"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon red"><span class="name">나곡</span></a></div>
							  	<div class="blinker kb_spot16"><a href="#" class="icon red"><span class="name">망양정</span></a></div>
							  	<div class="blinker kb_spot17"><a href="#" class="icon red"><span class="name">봉평</span></a></div>
							  	<div class="blinker kb_spot18"><a href="#" class="icon red"><span class="name">후정</span></a></div>
							  	<div class="blinker kb_spot19"><a href="#" class="icon red"><span class="name">후포</span></a></div>
							  	<div class="blinker kb_spot20"><a href="#" class="icon red"><span class="name">구룡포</span></a></div>
							  	<div class="blinker kb_spot21"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon red"><span class="name">도구</span></a></div>
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
										<tr>
											<td>관성해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach113"></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" >위치보기</a></td>
										</tr>
										<tr>
											<td>나정해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>봉길대왕암해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>오류해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>전촌해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>경정해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>고래불해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach119"></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>남호해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>대진해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>오보해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>장사해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>하저해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>구산해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>기성망양해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>나곡해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>망양정해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>봉평해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>후정해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>후포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>구룡포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>도구해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>영일대해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>월포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>칠포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>화진해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
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
                
				for(var i=0; i < data.length; i++){
					//관성해수욕장
					if(i==113){
						$('.blinker.kb_spot1').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.kb_spot1').find('a').addClass('icon green');$("#beach113").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.kb_spot1').find('a').addClass('icon yellow');$("#beach113").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.kb_spot1').find('a').addClass('icon red');$("#beach113").attr('class','tbl_icon icon red');}
					}
					//고래불 해수욕장
					if(i==119){
						$('.blinker.kb_spot7').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.kb_spot7').find('a').addClass('icon green');$("#beach119").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.kb_spot7').find('a').addClass('icon yellow');$("#beach119").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.kb_spot7').find('a').addClass('icon red');$("#beach119").attr('class','tbl_icon icon red');}
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
        
        	