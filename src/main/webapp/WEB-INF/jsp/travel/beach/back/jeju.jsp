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
							  		<button type="button">제주도 해수욕장 혼잡도 신호등</button>
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
					  		<div class="location_map map_jj">
					  			<img src="/seantour_map/travel/images/main_summer/img_map_jj.jpg" alt="제주도" />
				  				<div class="spot_info"><img src="/seantour_map/travel/images/main_summer/img_info_box.jpg" alt="혼잡:　거리두기(2m)불가, 혼잡우려: 거리두기(2m)불가, 적정:거리두기(2m)곤란" /></div>
							  	<div class="blinker jj_spot1"><a href="#" class="icon green"><span class="name">곽지</span></a></div>
							  	<div class="blinker jj_spot2"><a href="#" class="icon yellow"><span class="name">금능</span></a></div>
							  	<div class="blinker jj_spot3"><a href="#" class="icon green"><span class="name">김녕</span></a></div>
							  	<div class="blinker jj_spot4"><a href="#" class="icon red"><span class="name">삼양</span></a></div>
							  	<div class="blinker jj_spot5"><a href="#" class="icon red"><span class="name">월정</span></a></div>
							  	<div class="blinker jj_spot6"><a href="#" class="icon green"><span class="name">이호</span></a></div>
							  	<div class="blinker jj_spot7"><a href="#" class="icon red"><span class="name">함덕</span></a></div>
							  	<div class="blinker jj_spot8"><a href="#" class="icon red"><span class="name">협재</span></a></div>
							  	<div class="blinker jj_spot9"><a href="#" class="icon red"><span class="name">신양섭지</span></a></div>
							  	<div class="blinker jj_spot10"><a href="#" class="icon red"><span class="name">중문색달</span></a></div>
							  	<div class="blinker jj_spot11"><a href="#" class="icon red"><span class="name">표선</span></a></div>
							  	<div class="blinker jj_spot12"><a href="#" class="icon red"><span class="name">화순금모래</span></a></div>
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
											<td>곽지해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach228"></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>금능해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach229"></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>김녕해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach227"></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>삼양해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>월정해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>이호해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach230"></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>함덕해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach231"></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>협재해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach235"></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>신양섭지해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>중문색달해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach237"></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>표선해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>화순금모래해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/31</td>
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
        <!--// container 7개-->
        
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
					//함덕 해수욕장
					if(i==231){
						$('.blinker.jj_spot7').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.jj_spot7').find('a').addClass('icon green');$("#beach231").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.jj_spot7').find('a').addClass('icon yellow');$("#beach231").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.jj_spot7').find('a').addClass('icon red');$("#beach231").attr('class','tbl_icon icon red');}
					}
					//협재 해수욕장
					if(i==235){
						$('.blinker.jj_spot8').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.jj_spot8').find('a').addClass('icon green');$("#beach235").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.jj_spot8').find('a').addClass('icon yellow');$("#beach235").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.jj_spot8').find('a').addClass('icon red');$("#beach235").attr('class','tbl_icon icon red');}
					}
					//이호 해수욕장
					if(i==230){
						$('.blinker.jj_spot').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.jj_spot6').find('a').addClass('icon green');$("#beach230").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.jj_spot6').find('a').addClass('icon yellow');$("#beach230").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.jj_spot6').find('a').addClass('icon red');$("#beach230").attr('class','tbl_icon icon red');}
					}
					//곽지 해수욕장
					if(i==228){
						$('.blinker.jj_spot1').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.jj_spot1').find('a').addClass('icon green');$("#beach228").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.jj_spot1').find('a').addClass('icon yellow');$("#beach228").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.jj_spot1').find('a').addClass('icon red');$("#beach228").attr('class','tbl_icon icon red');}
					}
					//금능 해운대
					if(i==229){
						$('.blinker.jj_spot2').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.jj_spot2').find('a').addClass('icon green');$("#beach229").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.jj_spot2').find('a').addClass('icon yellow');$("#beach229").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.jj_spot2').find('a').addClass('icon red');$("#beach229").attr('class','tbl_icon icon red');}
					}
					//중문 해운대
					if(i==237){
						$('.blinker.jj_spot10').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.jj_spot10').find('a').addClass('icon green');$("#beach237").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.jj_spot10').find('a').addClass('icon yellow');$("#beach237").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.jj_spot10').find('a').addClass('icon red');$("#beach237").attr('class','tbl_icon icon red');}
					}
					//김녕 해운대
					if(i==227){
						$('.blinker.jj_spot3').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.jj_spot3').find('a').addClass('icon green');$("#beach227").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.jj_spot3').find('a').addClass('icon yellow');$("#beach227").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.jj_spot3').find('a').addClass('icon red');$("#beach227").attr('class','tbl_icon icon red');}
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
        
        	