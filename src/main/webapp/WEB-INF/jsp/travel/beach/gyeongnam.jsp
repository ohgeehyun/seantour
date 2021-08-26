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
							  		<button type="button">경상남도 해수욕장 혼잡도 신호등</button>
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
					  		<div class="location_map map_kn">
					  			<img src="/seantour_map/travel/images/main_summer/img_map_kn.jpg" alt="제주도" />
				  				<div class="spot_info"><img src="/seantour_map/travel/images/main_summer/img_info_box.jpg" alt="혼잡:　거리두기(2m)불가, 혼잡우려: 거리두기(2m)불가, 적정:거리두기(2m)곤란" /></div>
							  	<div class="blinker kn_spot1"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491026?c=14322110.3408146,4168112.6093566,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">구영</span></a></div>
							  	<div class="blinker kn_spot2"><a href="#" class="icon yellow"><span class="name">구조라</span></a></div>
							  	<div class="blinker kn_spot3"><a href="#" class="icon green"><span class="name">농소</span></a></div>
							  	<div class="blinker kn_spot4"><a href="#" class="icon red"><span class="name">덕원</span></a></div>
							  	<div class="blinker kn_spot5"><a href="#" class="icon red"><span class="name">덕포</span></a></div>
							  	<div class="blinker kn_spot6"><a href="#" class="icon red"><span class="name">망치</span></a></div>
							  	<div class="blinker kn_spot7"><a href="#" class="icon red"><span class="name">명사</span></a></div>
							  	<div class="blinker kn_spot8"><a href="#" class="icon red"><span class="name">물안</span></a></div>
							  	<div class="blinker kn_spot9"><a href="#" class="icon red"><span class="name">사곡</span></a></div>
							  	<div class="blinker kn_spot10"><a href="#" class="icon red"><span class="name">여차</span></a></div>
							  	<div class="blinker kn_spot11"><a href="#" class="icon red"><span class="name">옥계</span></a></div>
							  	<div class="blinker kn_spot12"><a href="#" class="icon red"><span class="name">와현모래숲</span></a></div>
							  	<div class="blinker kn_spot13"><a href="#" class="icon red"><span class="name">학동흑진주몽돌</span></a></div>
							  	<div class="blinker kn_spot14"><a href="#" class="icon red"><span class="name">함목</span></a></div>
							  	<div class="blinker kn_spot15"><a href="#" class="icon red"><span class="name">황포</span></a></div>
							  	<div class="blinker kn_spot16"><a href="#" class="icon red"><span class="name">흥남</span></a></div>
							  	<div class="blinker kn_spot17"><a href="#" class="icon red"><span class="name">두곡월포</span></a></div>
							  	<div class="blinker kn_spot18"><a href="https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13490951?c=14229143.1927805,4128944.6329807,13,0,0,0,dh&placePath=%3Fentry%253Dpll" class="icon green cursor"><span class="summer_reserv">예약</span><span class="name">사촌</span></a></div>
							  	<div class="blinker kn_spot19"><a href="#" class="icon red"><span class="name">상주은모래비치</span></a></div>
							  	<div class="blinker kn_spot20"><a href="#" class="icon red"><span class="name">설리</span></a></div>
							  	<div class="blinker kn_spot21"><a href="#" class="icon red"><span class="name">송정솔바람해변</span></a></div>
							  	<div class="blinker kn_spot22"><a href="#" class="icon red"><span class="name">남일대</span></a></div>
							  	<div class="blinker kn_spot23"><a href="#" class="icon red"><span class="name">광암</span></a></div>
							  	<div class="blinker kn_spot24"><a href="#" class="icon red"><span class="name">비진도</span></a></div>
							  	<div class="blinker kn_spot25"><a href="#" class="icon red"><span class="name">사량도 대항</span></a></div>
							  	<div class="blinker kn_spot26"><a href="#" class="icon red"><span class="name">수륙</span></a></div>
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
										<tr id='seq88'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13491026?c=14322110.3408146,4168112.6093566,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>구영</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq89'>
											<td>구조라</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq90'>
											<td>농소</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq91'>
											<td>덕원</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq92'>
											<td>덕포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq93'>
											<td>망치</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq94'>
											<td>명사</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq95'>
											<td>물안</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq96'>
											<td>사곡</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq97'>
											<td>여차</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq98'>
											<td>옥계</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq99'>
											<td>와현모래숲</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq100'>
											<td>학동흑진주몽돌</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq101'>
											<td>함목</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq102'>
											<td>황포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq103'>
											<td>흥남</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq104'>
											<td>두곡월포</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq105'>
											<td><a href='https://map.naver.com/v5/search/%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%98%88%EC%95%BD/place/13490951?c=14229143.1927805,4128944.6329807,13,0,0,0,dh&placePath=%3Fentry%253Dpll'><img src="/seantour_map/travel/images/main_summer/img_summer_reserv2.png"></a>사촌</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq106'>
											<td>상주은모래비치</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq107'>
											<td>설리</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq108'>
											<td>송정솔바람해변</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq109'>
											<td>남일대</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq110'>
											<td>광암</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq111'>
											<td>비진도</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq112'>
											<td>사량도 대항</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr id='seq113'>
											<td>수륙</td>
											<td><span class="tbl_icon icon beach"></span></td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
									</tbody>
								</table>
							</div>
	            		</div>
	            	</div>
				</div>
            </div><!-- cont_body 1개 -->
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
        
        	