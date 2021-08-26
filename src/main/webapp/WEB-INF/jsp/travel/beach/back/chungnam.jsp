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
							  	<div class="blinker cn_spot17"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon red"><span class="name">바람아래</span></a></div>
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
										<tr>
											<td>왜목마을해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>난지섬해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>대천해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>무창포해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>춘장대해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach240"></td>
											<td>7/10</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>갈음이해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>곰섬해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>구례포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>구름포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>기지포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>꽃지해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach247"></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>꾸지나무골해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>달산포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>마검포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>만리포해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach255"></td>
											<td>7/3</td>
											<td>8/29</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>몽산포해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach252"></td>
											<td>7/3</td>
											<td>8/15</td>>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>바람아래해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>밧개해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>방주골(백리포)해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>방포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>백사장해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>삼봉해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach258"></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>샛별해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>신두리해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach260"></td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>안면해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>어은돌해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>연포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>의항해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>장삼포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>천리포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>청포대해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>파도리해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/15</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>학암포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
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
	   <!--// container 6개-->
	   
<script>
	$.ajax({
  			type:'post',
  			url:"/seantour_map/travel/mainBeachCongestion.do",
  		    success: function(data) {  		
                
				for(var i=0; i < data.length; i++){
					//만리포 해수욕장
					if(i==251){
						$('.blinker.cn_spot15').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.cn_spot15').find('a').addClass('icon green');$("#beach251").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.cn_spot15').find('a').addClass('icon yellow');$("#beach251").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.cn_spot15').find('a').addClass('icon red');$("#beach251").attr('class','tbl_icon icon red');}
					}
					//춘장대 해수욕장
					if(i==240){
						$('.blinker.cn_spot5').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.cn_spot5').find('a').addClass('icon green');$("#beach240").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.cn_spot5').find('a').addClass('icon yellow');$("#beach240").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.cn_spot5').find('a').addClass('icon red');$("#beach240").attr('class','tbl_icon icon red');}
					}
					//꽂지 해수욕장
					if(i==247){
						$('.blinker.cn_spot11').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.cn_spot11').find('a').addClass('icon green');$("#beach247").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.cn_spot11').find('a').addClass('icon yellow');$("#beach247").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.cn_spot11').find('a').addClass('icon red');$("#beach247").attr('class','tbl_icon icon red');}
					}
					//몽산포 해수욕장
					if(i==252){
						$('.blinker.cn_spot16').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.cn_spot16').find('a').addClass('icon green');$("#beach252").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.cn_spot16').find('a').addClass('icon yellow');$("#beach252").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.cn_spot16').find('a').addClass('icon red');$("#beach252").attr('class','tbl_icon icon red');}
					}
					//삼봉 해수욕장
					if(i==258){
						$('.blinker.cn_spot22').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.cn_spot22').find('a').addClass('icon green');$("#beach258").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.cn_spot22').find('a').addClass('icon yellow');$("#beach258").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.cn_spot22').find('a').addClass('icon red');$("#beach258").attr('class','tbl_icon icon red');}
					}
					//신두리 해수욕장
					if(i==260){
						$('.blinker.cn_spot24').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.cn_spot24').find('a').addClass('icon green');$("#beach260").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.cn_spot24').find('a').addClass('icon yellow');$("#beach260").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.cn_spot24').find('a').addClass('icon red');$("#beach260").attr('class','tbl_icon icon red');}
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
        
        	