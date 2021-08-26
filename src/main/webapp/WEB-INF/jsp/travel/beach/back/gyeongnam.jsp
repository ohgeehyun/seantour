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
							  	<div class="blinker kn_spot1"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon green"><span class="name">구영</span></a></div>
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
							  	<div class="blinker kn_spot18"><a href="#" class="summer_reserv">예약</a><a href="#" class="icon red"><span class="name">사촌</span></a></div>
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
										<tr>
											<td>구영해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>구조라해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>농소해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>덕원농소해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>덕포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>망치해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>명사해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>물안해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>사곡해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>여차해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>옥계해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>와현모래숲해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>학동흑진주몽돌해수욕장</td>
											<td>준비중</td>
											<td>7/1</td>
											<td>8/31</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>함목해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>황포해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>흥남해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>두곡월포해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>사촌해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>상주은모래비치해수욕장</td>
											<td><span class="tbl_icon icon green" id="beach105"></td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc">위치보기</a></td>
										</tr>
										<tr>
											<td>설리해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>송정솔바람해변해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>남일대해수욕장</td>
											<td>준비중</td>
											<td>7/16</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>광암해수욕장</td>
											<td>준비중</td>
											<td>7/9</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>비진도해수욕장</td>
											<td>준비중</td>
											<td>7/3</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>사량도 대항해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
										</tr>
										<tr>
											<td>수륙해수욕장</td>
											<td>준비중</td>
											<td>7/10</td>
											<td>8/22</td>
											<td><a href="#none" class="btn_loc" style="display:none">위치보기</a></td>
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
                
				for(var i=0; i < data.length; i++){
					//상주은해수욕장
					if(i==105){
						$('.blinker.kn_spot19').find('a').removeClass();
						if(data[i].congestion==1){$('.blinker.kn_spot19').find('a').addClass('icon green');$("#beach105").attr('class','tbl_icon icon green');}
						else if (data[i].congestion==2){$('.blinker.spot19').find('a').addClass('icon yellow');$("#beach105").attr('class','tbl_icon icon yellow');}
						else{$('.blinker.kn_spot19').find('a').addClass('icon red');$("#beach105").attr('class','tbl_icon icon red');}
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
        
        	