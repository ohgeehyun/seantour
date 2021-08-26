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
							  		<button type="button">전라북도 해수욕장 혼잡도 신호등</button>
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
					  			<img src="/seantour_map/travel/images/main_summer/img_map_jb.jpg" alt="전라북도" />
				  				<div class="spot_info"><img src="/seantour_map/travel/images/main_summer/img_info_box.jpg" alt="혼잡:　거리두기(2m)불가, 혼잡우려: 거리두기(2m)불가, 적정:거리두기(2m)곤란" /></div>
							  	<div class="blinker jb_spot1"><a href="#" class="icon green"><span class="name">구시포</span></a></div>
							  	<div class="blinker jb_spot2"><a href="#" class="icon yellow"><span class="name">동호</span></a></div>
							  	<div class="blinker jb_spot3"><a href="#" class="icon green"><span class="name">선유도</span></a></div>
							  	<div class="blinker jb_spot4"><a href="#" class="icon red"><span class="name">격포</span></a></div>
							  	<div class="blinker jb_spot5"><a href="#" class="icon red"><span class="name">고사포</span></a></div>
							  	<div class="blinker jb_spot6"><a href="#" class="icon red"><span class="name">모항</span></a></div>
							  	<div class="blinker jb_spot7"><a href="#" class="icon red"><span class="name">변산</span></a></div>
							  	<div class="blinker jb_spot8"><a href="#" class="icon red"><span class="name">위도</span></a></div>
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
											<td>구시포해수욕장</td>
											<td>준비중</td>
											<td>7/8</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>동호해수욕장</td>
											<td>준비중</td>
											<td>7/8</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>선유도해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>격포해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>고사포해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>모항해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>변산해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>위도해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
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
                
				/* for(var i=0; i < data.length; i++){
					//송정해수욕장
					if(i==6){
						$('.blinker.spot3').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.spot3').find('a').addClass('icon green');$("#beach6").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot3').find('a').addClass('icon yellow');$("#beach6").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.spot3').find('a').addClass('icon red');$("#beach6").attr('class','tbl_icon icon red');}
					} */
					//부산 해운대			
				}
		    },
		    error: function(err) {		    	
			 	alert("신호등 데이터를 가져오는 도중 오류가 발생하였습니다."); 
		    }
     })
	</script>
</body>
</html>
        
        	