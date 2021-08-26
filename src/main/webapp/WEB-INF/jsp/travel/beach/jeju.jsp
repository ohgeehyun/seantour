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
									<tr id ="seq229">
											<td>곽지</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq230">
											<td>금능</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq231">
											<td>김녕</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq232">
											<td>삼양</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq233">
											<td>월정</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq234">
											<td>이호</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq235">
											<td>함덕</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq236">
											<td>협재</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq237">
											<td>신양섭지</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq238">
											<td>중문색달</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq239">
											<td>표선</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id ="seq240">
											<td>화순금모래</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/1</td>
											<td>8/31</td>
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
        
        	