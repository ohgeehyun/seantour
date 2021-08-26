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
							  		<button type="button">부산광역시 해수욕장 혼잡도 신호등</button>
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
					  		<div class="location_map map_bs">
					  			<img src="/seantour_map/travel/images/main_summer/img_map_bs.jpg" alt="부산광역시" />
				  				<div class="spot_info"><img src="/seantour_map/travel/images/main_summer/img_info_box.jpg" alt="혼잡:　거리두기(2m)불가, 혼잡우려: 거리두기(2m)불가, 적정:거리두기(2m)곤란" /></div>
							  	<div class="blinker spot1"><a href="#" class="icon green"><span class="name">임랑</span></a></div>
							  	<div class="blinker spot2"><a href="#" class="icon yellow"><span class="name">일광</span></a></div>
							  	<div class="blinker spot3"><a href="#" class="icon green"><span class="name">송정</span></a></div>
							  	<div class="blinker spot4"><a href="#" class="icon red"><span class="name">해운대</span></a></div>
							  	<div class="blinker spot5"><a href="#" class="icon red"><span class="name">광안리</span></a></div>
							  	<div class="blinker spot6"><a href="#" class="icon red"><span class="name">송도</span></a></div>
							  	<div class="blinker spot7"><a href="#" class="icon red"><span class="name">다대포</span></a></div>
					  		</div>
	            		</div>
	            		<div class="summer_right">
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
										<td>임랑해수욕장</td>
										<td><span class="tbl_icon icon green" id="beach139"></span></td>
										<td>7/1</td>
										<td>8/31</td>
										<td><a href="#none" class="btn_loc">위치보기</a></td>
									</tr>
									<tr>
										<td>일광해수욕장</td>
										<td><span class="tbl_icon icon green" id="beach138"></span></td>
										<td>7/1</td>
										<td>8/31</td>
										<td><a href="#none" class="btn_loc">위치보기</a></td>
									</tr>
									<tr>
										<td>송정해수욕장</td>
										<td><span class="tbl_icon icon green" id="beach143"></span></td>
										<td>6/1</td>
										<td>8/31</td>
										<td><a href="#none" class="btn_loc">위치보기</a></td>
									</tr>
									<tr>
										<td>해운대해수욕장</td>
										<td><span class="tbl_icon icon green" id="beach144"></span></td>
										<td>6/1</td>
										<td>8/31</td>
										<td><a href="#none" class="btn_loc">위치보기</a></td>
									</tr>
									<tr>
										<td>광안리해수욕장</td>
										<td><span class="tbl_icon icon green" id="beach141"></td>
										<td>7/1</td>
										<td>8/31</td>
										<td><a href="#none" class="btn_loc">위치보기</a></td>
									</tr>
									<tr>
										<td>송도해수욕장</td>
										<td><span class="tbl_icon icon green" id="beach140"></td>
										<td>7/1</td>
										<td>8/31</td>
										<td><a href="#none" class="btn_loc">위치보기</a></td>
									</tr>
									<tr>
										<td>다대포해수욕장</td>
										<td><span class="tbl_icon icon green" id="beach137"></td>
										<td>7/1</td>
										<td>8/31</td>
										<td><a href="#none" class="btn_loc disnone">위치보기</a></td>
									</tr>
								
								</tbody>
							</table>
	            		</div>
	            	</div>
				</div>
            </div><!-- cont_body 7개-->
        </div><!-- // cont_wrap -->
        </div>
        
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
					//송정해수욕장
					if(i==143){
						$('.blinker.spot3').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.spot3').find('a').addClass('icon green');$("#beach143").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot3').find('a').addClass('icon yellow');$("#beach143").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.spot3').find('a').addClass('icon red');$("#beach143").attr('class','tbl_icon icon red');}
					}
					//부산 해운대
					if(i==144){
						$('.blinker.spot4').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.spot4').find('a').addClass('icon green');$("#beach144").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot4').find('a').addClass('icon yellow');$("#beach144").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.spot4').find('a').addClass('icon red');$("#beach144").attr('class','tbl_icon icon red');}
					}
					//임랑 해수욕장
					/* if(i==139){
						$('.blinker.spot1').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.spot1').find('a').addClass('icon green');$("#beach139").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot1').find('a').addClass('icon yellow');$("#beach139").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.spot1').find('a').addClass('icon red');$("#beach139").attr('class','tbl_icon icon red');}
					} */
					//일광 해수욕장
					if(i==138){
						$('.blinker.spot2').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.spot2').find('a').addClass('icon green');$("#beach138").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot2').find('a').addClass('icon yellow');$("#beach138").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.spot2').find('a').addClass('icon red');$("#beach138").attr('class','tbl_icon icon red');}
					}
					//광안리 해수욕장
				/* 	if(i==141){
						$('.blinker.spot5').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.spot5').find('a').addClass('icon green');$("#beach141").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot5').find('a').addClass('icon yellow');$("#beach141").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.spot5').find('a').addClass('icon red');$("#beach141").attr('class','tbl_icon icon red');}
					} */
					//송도 해수욕장
				/* 	if(i==140){
						$('.blinker.spot6').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.spot6').find('a').addClass('icon green');$("#beach140").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot6').find('a').addClass('icon yellow');$("#beach140").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.spot6').find('a').addClass('icon red');$("#beach140").attr('class','tbl_icon icon red');}
					} */
					//다대포 해수욕장
					if(i==137){
						$('.blinker.spot7').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.spot7').find('a').addClass('icon green');$("#beach137").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot7').find('a').addClass('icon yellow');$("#beach137").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.spot7').find('a').addClass('icon red');$("#beach137").attr('class','tbl_icon icon red');}
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
        
        	