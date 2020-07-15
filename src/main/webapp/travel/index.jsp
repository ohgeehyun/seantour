<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><% /*<!-- [-CONTENT-] -->*/ %><%@ include file="/_common/stateCount.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>


<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/travel/main.css'/>" /> --%>


<%@ include file="/travel/common/config/handing/cssHanding.jsp" %>

<%@ include file="/travel/common/config/handing/jsHanding.jsp" %>


<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
   <script>
    	$(document).ready(function(){
  		$('#close').click(function(){
  			$('#pop').hide();
     
  		});
	});
  	   var d = new Date(); 
		var currentDate = d.getFullYear() + "년 " + ( d.getMonth() + 1 ) + "월 " + d.getDate() + "일 "; 
		var currentTime = "";
		if(d.getMinutes() < 30){
			currentTime = (d.getHours()) + "시00분";
		}else{
			currentTime = d.getHours() + "시30분";
		}
		$('.time').find('span').text(currentDate + currentTime);
  		
  		$.ajax({
  			type:'post',
  			url:"/seantour_map/travel/mainBeachCongestion.do",
  		    success: function(data) {  		
                $('.time').find('span').text(currentTime);
				for(var i=0; i < data.length; i++){
					$('.spot' + (i + 1)).find('a').removeClass();
					$('.spot' + (i + 1)).find('a').addClass('icon');
					var classNm = checkBeachCongestion(data[i].seqId, data[i].uniqPop);
					$('.spot' + (i + 1)).find('a').addClass(classNm);
					$('#blinkerpop' + (i + 1)).find('.box_icon').addClass('box_' + classNm);
				}
		    },
		    error: function(err) {		    	
			/* 	alert("신호등 데이터를 가져오는 도중 오류가 발생하였습니다."); */
		    }
     })


	function checkBeachCongestion(beachId, population){
  		var returnStr = '';
  		if(beachId == 1){	if(population < 	29250	){ returnStr = "green";} else if(population < 	58499	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 2){	if(population < 	18000	){ returnStr = "green";} else if(population < 	35999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 3){	if(population < 	10000	){ returnStr = "green";} else if(population < 	19999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 4){	if(population < 	48750	){ returnStr = "green";} else if(population < 	97499	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 5){	if(population < 	13813	){ returnStr = "green";} else if(population < 	27624	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 6){	if(population < 	26377	){ returnStr = "green";} else if(population < 	52752	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 7){	if(population < 	12900	){ returnStr = "green";} else if(population < 	25799	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 8){	if(population < 	26793	){ returnStr = "green";} else if(population < 	53585	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 9){	if(population < 	6000	){ returnStr = "green";} else if(population < 	11999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 10){	if(population < 	14825	){ returnStr = "green";} else if(population < 	29649	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 11){	if(population < 	19186	){ returnStr = "green";} else if(population < 	38371	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 12){	if(population < 	7175	){ returnStr = "green";} else if(population < 	14349	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 13){	if(population < 	1948	){ returnStr = "green";} else if(population < 	3894	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 14){	if(population < 	47500	){ returnStr = "green";} else if(population < 	94999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 15){	if(population < 	5625	){ returnStr = "green";} else if(population < 	11249	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 16){	if(population < 	9461	){ returnStr = "green";} else if(population < 	18922	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 17){	if(population < 	5500	){ returnStr = "green";} else if(population < 	10999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 18){	if(population < 	10191	){ returnStr = "green";} else if(population < 	20382	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 19){	if(population < 	4500	){ returnStr = "green";} else if(population < 	8999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 20){	if(population < 	5000	){ returnStr = "green";} else if(population < 	9999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 21){	if(population < 	58940	){ returnStr = "green";} else if(population < 	117879	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 22){	if(population < 	16548	){ returnStr = "green";} else if(population < 	33096	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 23){	if(population < 	23438	){ returnStr = "green";} else if(population < 	46874	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 24){	if(population < 	6250	){ returnStr = "green";} else if(population < 	12499	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 25){	if(population < 	8000	){ returnStr = "green";} else if(population < 	15999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 26){	if(population < 	8343	){ returnStr = "green";} else if(population < 	16684	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 27){	if(population < 	7000	){ returnStr = "green";} else if(population < 	13999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 28){	if(population < 	15403	){ returnStr = "green";} else if(population < 	30805	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 29){	if(population < 	250		){ returnStr = "green";} else if(population < 	499		){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 30){	if(population < 	2500	){ returnStr = "green";} else if(population < 	4999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 31){	if(population < 	8640	){ returnStr = "green";} else if(population < 	17279	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 32){	if(population < 	4661	){ returnStr = "green";} else if(population < 	9321	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 33){	if(population < 	3188	){ returnStr = "green";} else if(population < 	6374	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 34){	if(population < 	3658	){ returnStr = "green";} else if(population < 	7315	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 35){	if(population < 	7000	){ returnStr = "green";} else if(population < 	13999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 36){	if(population < 	19688	){ returnStr = "green";} else if(population < 	39374	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 37){	if(population < 	5500	){ returnStr = "green";} else if(population < 	10999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 38){	if(population < 	4171	){ returnStr = "green";} else if(population < 	8341	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 39){	if(population < 	104598	){ returnStr = "green";} else if(population < 	209195	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 40){	if(population < 	4725	){ returnStr = "green";} else if(population < 	9449	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 41){	if(population < 	2000	){ returnStr = "green";} else if(population < 	3999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 42){	if(population < 	28173	){ returnStr = "green";} else if(population < 	56345	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 43){	if(population < 	2293	){ returnStr = "green";} else if(population < 	4586	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 44){	if(population < 	243		){ returnStr = "green";} else if(population < 	484		){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 45){	if(population < 	4825	){ returnStr = "green";} else if(population < 	9649	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 46){	if(population < 	4496	){ returnStr = "green";} else if(population < 	8991	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 47){	if(population < 	8859	){ returnStr = "green";} else if(population < 	17718	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 48){	if(population < 	4499	){ returnStr = "green";} else if(population < 	8998	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 49){	if(population < 	4439	){ returnStr = "green";} else if(population < 	8878	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 50){	if(population < 	5813	){ returnStr = "green";} else if(population < 	11624	){ returnStr = "yellow";} else { returnStr = "red";}}

  		return returnStr;
  	}
   </script>
  <script type="text/javascript">
function fn_reservView(){
	var reseName = $('#reseName').val();
	var reseTel = $('#reseTel').val();
	
	if(reseName == ''){
		alert('이름을 입력하세요.');
		$('#reseName').focus();
		return;
	}
	if(reseTel == ''){
		alert('전화번호를 입력하세요.');
		$('#reseTel').focus();
		return;
	}
	
	location.href = "<c:url value='/travel/reservation/reserv_view.do'/>?reseName=" + encodeURI(reseName, "UTF-8") + "&reseTel=" + reseTel;
}
</script>
  </head>
<body>
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
       <div id="pop">
          <div><img src="${pageContext.request.contextPath}/travel/common/images/main/main_pop2.jpg" alt="" /></div>
         <div id="close">close</div>
      </div>
       <div class="dim-layer">
          <div class="dimBg"></div>
          <div id="layer2" class="pop-layer">
            <div class="pop-container">
              <div class="pop-conts">
                <!--content //-->
                <img src="/seantour_map/images/travel/main/event_popup.jpg" alt="SNS 친구초대 이벤트! SNS를 통해 친구를 초대하면 추첨을 통해 오누리 상품권을 드립니다. 바다여행을 좋아하는 친구들을 초대하고 온누리 상품권을 받으세요 이벤트기간:6월 한달간" />
                <div class="btn-r">
                  <a href="#" class="btn-layerClose">Close</a>
                </div>
                <!--// content-->
              </div>
            </div>
          </div>
        </div>
		<!-- header -->
			<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
		<!-- // header -->
	<!-- contaniner -->
		<div id="container" class="main">
			<!-- cont_main -->
			<div class="cont_main" id="content">
				<div class="spotzone trans400">
					<ul class="list">
						<li class="n01"></li>
						<li class="n02"></li>
					</ul>
					<div class="main_visual_wrap">
						<div class="main_visual_content">
							<div class="main_visual_content_cell">
								<!--<div class="main_visual_content_cell_weather">
									<div class="weather">

                                   
										<img src="${pageContext.request.contextPath}/travel/common/images/main/icon_weather_01.png" alt=''/>	

										<span>7℃</span>
									</div>
									<div class="dust">
										<dl>

                                            <dt>미세먼지</dt>
                                           <dd>좋음<img src="${pageContext.request.contextPath}/travel/common/images/main/icon_dust_good.png" alt='좋음'/></dd>
										</dl>
										<dl>
                                            <dt>초미세먼지</dt>
                                            <dd>나쁨<img src="${pageContext.request.contextPath}/travel/common/images/main/icon_dust_bad.png" alt='나쁨'/></dd>

										</dl>
									</div>
											 <div class="vis-weather">
     										   <p class="weather-date"></p>	
   										</div>
								</div>-->
                         	
								  <script>
								  	$(document).ready(function(){
								  		<c:forEach var="i" begin="1" end="50" step="1">
								  			$(".spot${i} a").click(function(){
								  				$("[id^='blinkerpop']").each(function(){
								  					$(this).closest(".blinkerpop").hide();
								  				});
								  				$("#blinkerpop${i}").show();
								  			});
								  		</c:forEach>
								  	  $(".pop_close").click(function(){
								  	    //$("[id^='blinkerpop']").each(function(){
								  	    	$(this).closest(".blinkerpop").hide();
								  	    });
								  	 
								  	});
							  	 </script>
								  <div class="main_visual_content_cell_right">
								  	 <div class="main_visual_content_cell_right_inr">
								  	 	<div class="spot_title"><img src="${pageContext.request.contextPath}/images/travel/main/img_map_tit.png" alt="해수욕장 혼잡도 신호등" /></div>
								  	 	<div class="spot_info"><img src="${pageContext.request.contextPath}/images/travel/main/img_info_box.png" alt="혼잡: 빨간색, 혼잡우려: 노란색, 적정: 녹색" /></div>
									  	 <div class="blinker spot1"><a href="#" class="icon"><span class="name">해운대</span></a></div>
									  	 <div class="blinker spot2"><a href="#" class="icon"><span class="name">광안리</span></a></div>
									  	 <div class="blinker spot3"><a href="#" class="icon"><span class="name">송도</span></a></div>
									  	 <div class="blinker spot4"><a href="#" class="icon"><span class="name">대천</span></a></div>
									  	 <div class="blinker spot5"><a href="#" class="icon"><span class="name">다대포</span></a></div>
									  	 <div class="blinker spot6"><a href="#" class="icon"><span class="name">경포</span></a></div>
									  	 <div class="blinker spot7"><a href="#" class="icon"><span class="name">송정</span></a></div>
									  	 <div class="blinker spot8"><a href="#" class="icon"><span class="name">낙산</span></a></div>
									  	 <div class="blinker spot9"><a href="#" class="icon"><span class="name">속초</span></a></div>
									  	 <div class="blinker spot10"><a href="#" class="icon"><span class="name">삼척</span></a></div>
									  	 <div class="blinker spot11"><a href="#" class="icon"><span class="name">망상</span></a></div>
									  	 <div class="blinker spot12"><a href="#" class="icon"><span class="name">맹방</span></a></div>
									  	 <div class="blinker spot13"><a href="#" class="icon"><span class="name">추암</span></a></div>
									  	 <div class="blinker spot14"><a href="#" class="icon"><span class="name">신지명사십리</span></a></div>
								  	   	 <div class="blinker spot15"><a href="#" class="icon"><span class="name">만리포</span></a></div>
									  	 <div class="blinker spot16"><a href="#" class="icon"><span class="name">일산</span></a></div>
									  	 <div class="blinker spot17"><a href="#" class="icon"><span class="name">함덕</span></a></div>
									  	 <div class="blinker spot18"><a href="#" class="icon"><span class="name">진하</span></a></div>
									  	 <div class="blinker spot19"><a href="#" class="icon"><span class="name">하조대</span></a></div> 
									  	 <div class="blinker spot20"><a href="#" class="icon"><span class="name">협재</span></a></div>
									  	 <div class="blinker spot21"><a href="#" class="icon"><span class="name">고래불</span></a></div>
									  	 <div class="blinker spot22"><a href="#" class="icon"><span class="name">주문진</span></a></div>
									  	 <div class="blinker spot23"><a href="#" class="icon"><span class="name">춘장대</span></a></div>
									  	 <div class="blinker spot24"><a href="#" class="icon"><span class="name">이호테우</span></a></div>
									  	 <div class="blinker spot25"><a href="#" class="icon"><span class="name">꽃지</span></a></div>
									  	 <div class="blinker spot26"><a href="#" class="icon"><span class="name">송지호</span></a></div>
									  	 <div class="blinker spot27"><a href="#" class="icon"><span class="name">곽지</span></a></div>
									  	 <div class="blinker spot28"><a href="#" class="icon"><span class="name">화진포</span></a></div>
									  	 <div class="blinker spot29"><a href="#" class="icon"><span class="name">외옹치</span></a></div>
									  	 <div class="blinker spot30"><a href="#" class="icon"><span class="name">금능</span></a></div>
									  	 <div class="blinker spot31"><a href="#" class="icon"><span class="name">삼포</span></a></div>
									  	 <div class="blinker spot32"><a href="#" class="icon"><span class="name">일광</span></a></div>
									  	 <div class="blinker spot33"><a href="#" class="icon"><span class="name">몽산포</span></a></div>
									  	 <div class="blinker spot34"><a href="#" class="icon"><span class="name">임랑</span></a></div>
									  	 <div class="blinker spot35"><a href="#" class="icon"><span class="name">중문색달</span></a></div>
									  	 <div class="blinker spot36"><a href="#" class="icon"><span class="name">무창포</span></a></div>
									  	 <div class="blinker spot37"><a href="#" class="icon"><span class="name">김녕</span></a></div>
									  	 <div class="blinker spot38"><a href="#" class="icon"><span class="name">안목</span></a></div>
									  	 <div class="blinker spot39"><a href="#" class="icon"><span class="name">상주은모래비치</span></a></div>
									  	 <div class="blinker spot40"><a href="#" class="icon"><span class="name">을왕리</span></a></div>
									  	 <div class="blinker spot41"><a href="#" class="icon"><span class="name">삼봉</span></a></div>
									  	 <div class="blinker spot42"><a href="#" class="icon"><span class="name">정동진</span></a></div>
									  	 <div class="blinker spot43"><a href="#" class="icon"><span class="name">용화</span></a></div>
									  	 <div class="blinker spot44"><a href="#" class="icon"><span class="name">등대</span></a></div>
									  	 <div class="blinker spot45"><a href="#" class="icon"><span class="name">하나개</span></a></div>
									  	 <div class="blinker spot46"><a href="#" class="icon"><span class="name">송지호오토캠핑장</span></a></div>
									  	 <div class="blinker spot47"><a href="#" class="icon"><span class="name">관성솔밭</span></a></div>
									  	 <div class="blinker spot48"><a href="#" class="icon"><span class="name">중광정</span></a></div>
									  	 <div class="blinker spot49"><a href="#" class="icon"><span class="name">천진</span></a></div>
									  	 <div class="blinker spot50"><a href="#" class="icon"><span class="name">신두리</span></a></div>
									  	 <div class="time">기준시각<br/><span>13:00</span></div>
									  	 <div id="blinkerpop1" class="blinkerpop">
								  	 		<div class="title">[부산]해운대 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>29,250명</li>
								  	 				<li><span>개장일</span>2020년 6월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111941">상세보기</a>
								  	 		</div>
								  	 	 </div>
								  	 	 <div id="blinkerpop2" class="blinkerpop">
								  	 		<div class="title">[부산]광안리 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>18,000명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110239">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop3" class="blinkerpop">
								  	 		<div class="title">[부산]송도 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>10,000명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110780">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop4" class="blinkerpop">
								  	 		<div class="title">[충청]대천 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>48,750명</li>
								  	 				<li><span>개장일</span>2020년 7월 4일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110458">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop5" class="blinkerpop">
								  	 		<div class="title">[부산]다대포 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>13,813명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110405">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop6" class="blinkerpop">
								  	 		<div class="title">[강원]경포 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>26,377명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110072">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop7" class="blinkerpop">
								  	 		<div class="title">[부산]송정 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>12,900명</li>
								  	 				<li><span>개장일</span>2020년 6월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111059">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop8" class="blinkerpop">
								  	 		<div class="title">[강원]낙산 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>26,793명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110349">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop9" class="blinkerpop">
								  	 		<div class="title">[강원]속초 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>6,000명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111039">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop10" class="blinkerpop">
								  	 		<div class="title">[강원]삼척 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>14,825명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110894">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop11" class="blinkerpop">
								  	 		<div class="title">[강원]망상 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>19,186명</li>
								  	 				<li><span>개장일</span>2020년 7월 15일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110580">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop12" class="blinkerpop">
								  	 		<div class="title">[강원]맹방 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>7,175명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110592">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop13" class="blinkerpop">
								  	 		<div class="title">[강원]추암 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>1,948명</li>
								  	 				<li><span>개장일</span>2020년 7월 15일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111738">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop14" class="blinkerpop">
								  	 		<div class="title">[전남]신지명사십리 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>47,500명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111124">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop15" class="blinkerpop">
								  	 		<div class="title">[충청]만리포 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>5,625명</li>
								  	 				<li><span>개장일</span>2020년 6월 6일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110572">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop16" class="blinkerpop">
								  	 		<div class="title">[울산]일산 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>9,461명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111470">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop17" class="blinkerpop">
								  	 		<div class="title">[제주]함덕 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>5,500명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111899">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop18" class="blinkerpop">
								  	 		<div class="title">[울산]진하 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>10,191명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111658">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop19" class="blinkerpop">
								  	 		<div class="title">[강원]하조대 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>4,500명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID000293">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop20" class="blinkerpop">
								  	 		<div class="title">[제주]협재 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>5,000명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111959">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop21" class="blinkerpop">
								  	 		<div class="title">[경북]고래불 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>58,940명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110180">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop22" class="blinkerpop">
								  	 		<div class="title">[강원]주문진 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>16,548명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111605">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop23" class="blinkerpop">
								  	 		<div class="title">[충청]춘장대 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>23,438명</li>
								  	 				<li><span>개장일</span>2020년 7월 11일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111741">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop24" class="blinkerpop">
								  	 		<div class="title">[제주]이호테우 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>6,250명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000481">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop25" class="blinkerpop">
								  	 		<div class="title">[충청]꽃지 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>8,000명</li>
								  	 				<li><span>개장일</span>2020년 7월 4일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110338">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop26" class="blinkerpop">
								  	 		<div class="title">[강원]송지호 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>8,343명</li>
								  	 				<li><span>개장일</span>2020년 7월 15일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111063">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop27" class="blinkerpop">
								  	 		<div class="title">[제주]곽지 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>7,000명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000482">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop28" class="blinkerpop">
								  	 		<div class="title">[강원]화진포 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>15,403명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111998">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop29" class="blinkerpop">
								  	 		<div class="title">[강원]외옹치 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>250명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000483">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop30" class="blinkerpop">
								  	 		<div class="title">[제주]금능 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>2,500명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110313">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop31" class="blinkerpop">
								  	 		<div class="title">[강원]삼포 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>8,640명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110902">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop32" class="blinkerpop">
								  	 		<div class="title">[부산]일광 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>4,661명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111467">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop33" class="blinkerpop">
								  	 		<div class="title">[충청]몽산포 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>3,188명</li>
								  	 				<li><span>개장일</span>2020년 7월 4일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110626">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop34" class="blinkerpop">
								  	 		<div class="title">[부산]임랑 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>3,658명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111476">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop35" class="blinkerpop">
								  	 		<div class="title">[제주]중문색달 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>7,000명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111628">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop36" class="blinkerpop">
								  	 		<div class="title">[충청]무창포 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>19,688명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110641">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop37" class="blinkerpop">
								  	 		<div class="title">[제주]김녕 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>5,500명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110331">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop38" class="blinkerpop">
								  	 		<div class="title">[강원]안목 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>4,171명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111168">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop39" class="blinkerpop">
								  	 		<div class="title">[경남]상주은모래비치 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>104,598명</li>
								  	 				<li><span>개장일</span>2020년 7월 5일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID007759">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop40" class="blinkerpop">
								  	 		<div class="title">[인천]을왕리 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>4,725명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111438">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop41" class="blinkerpop">
								  	 		<div class="title">[충청]삼봉 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>2,000명</li>
								  	 				<li><span>개장일</span>2020년 7월 4일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110873">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop42" class="blinkerpop">
								  	 		<div class="title">[강원]정동진 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>28,173명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID003274">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop43" class="blinkerpop">
								  	 		<div class="title">[강원]용화 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>2,293명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111358">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop44" class="blinkerpop">
								  	 		<div class="title">[강원]등대 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>243명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID110533">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop45" class="blinkerpop">
								  	 		<div class="title">[인천]하나개 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>4,825명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111854">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop46" class="blinkerpop">
								  	 		<div class="title">[강원]송지호오토캠핑장 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>4,496명</li>
								  	 				<li><span>개장일</span>2020년 7월 1일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111062">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop47" class="blinkerpop">
								  	 		<div class="title">[경북]관성솔밭 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>8,859명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000484">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop48" class="blinkerpop">
								  	 		<div class="title">[강원]중광정 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>4,499명</li>
								  	 				<li><span>개장일</span>2020년 7월 17일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID102542">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop49" class="blinkerpop">
								  	 		<div class="title">[강원]천진 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>4,439명</li>
								  	 				<li><span>개장일</span>2020년 7월 10일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000485">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  	 <div id="blinkerpop50" class="blinkerpop">
								  	 		<div class="title">[충청]신두리 해수욕장<button class="pop_close">닫기</button></div>
								  	 		<div class="reserv">
								  	 			<span class="box_icon"></span>
								  	 			<ul>
								  	 				<li><span>수용인원</span>5,813명</li>
								  	 				<li><span>개장일</span>2020년 7월 4일</li>
								  	 			</ul>
								  	 			<a href="/seantour_map/travel/destination/detail.do?destId=FCID111108">상세보기</a>
								  	 		</div>
								  	 	 </div>
									  </div>
								  </div>
                                <div class="main_visual_content_cell_left">
                                  <p class="tit"><strong>슬기로운</strong> 해수욕장 이용</p> 
                                  <div class="reserv_lookup_box">
                                    <div class="reserv_main_right">
                                        <a href="/seantour_map/travel/reservation/area.do"><img src="${pageContext.request.contextPath}/images/travel/main/img_main_reserv_pull.png" alt="" /></a>
                                    </div>
                                    <div class="reserv_main_left">
                                    <form id="reserv_view" action="/seantour_map/travel/reservation/reserv_view.do">
                                        <strong for="my_reserv">나의 예약 <br />조회</strong>
                                        <span><input type="text" id="reseName" name="reseName" placeholder="이름을 입력하세요." /></span>
                                        <span><input type="text" id="reseTel" name="reseTel" maxlength="11" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="전화번호를 입력하세요." /></span>
                                        <a href="javascript:fn_reservView();" class="btn">조회</a>
                                    </form>
                                    </div>
                                	</div>
								 </div>
								  <div class="spot_search">
								  	<div class="cssSelect">
								  		<button type="button">부산광역시</button>
								  		<ul class="lst">
								  		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=강원">강원도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경기">경기도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경남">경상남도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경북">경상북도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=광주">광주광역시</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=대구">경기도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=대전">대전광역시</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=부산">부산광역시</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=서울">서울특별시</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=세종">세종특별자치시</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=울산">울산광역시</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=인천">인천광역시</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=전남">전라남도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=전북">전라북도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=제주">제주도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=충남">충청남도</a></li>
                                		<li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=충북">충청북도</a></li>

								  		</ul>
							  		</div>
								  </div>
								</div>  
							</div>
					</div>
				</div><!-- //spotzone -->
              <!-- <div class="section00">
					<div class="inr">
						<p>해수욕장 혼잡도 신호등은 <span>네이버</span>와 함께 합니다.</p>
					</div> 
				</div> -->
				<div class="section01 aos-init aos-animate" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200">
					<div class="minr">
						<div class="event_box">
					    	<a href="/seantour_map/travel/info_square/recommendation/index.jsp" class="btn-example"><img src="${pageContext.request.contextPath}/images/travel/main/img_main_banner_10pull.jpg" alt="" /></a>
					    </div>
					    <div class="leaflet_box">
					    	<a href="/seantour_map/travel/info_square/leaflet/index.jsp"><img src="${pageContext.request.contextPath}/images/travel/main/img_main_leaflet.png" alt="건강지키는 바다여행! 해양관광 리플렛 보러가기" /></a>
					    </div>
				    </div>
			    </div> <!-- // section01 -->  
			    <div class="section02 aos-init aos-animate" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
			    	<div class="minr">

						<div class="tit_box">
				    		<p class="txt">국내 한적한 바다여행지를 추천해드립니다.</p>
					        <p class="tit">한적한<strong>해수욕장</strong></p>
					    </div>
						<div class="vest_recommend_box">
					    	<div class="col01 main_pull_slider">
					    		<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000442">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull01.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[강원]</strong>
							    			<span>노봉해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000465">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull02.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[경남]</strong>
							    			<span>남일대해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000460">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull03.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[경북]</strong>
							    			<span>경정해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000452">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull04.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전남]</strong>
							    			<span>남열해돋이해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000451">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull05.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전북]</strong>
							    			<span>구시포해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000446">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull06.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[충남]</strong>
							    			<span>기지포해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000444">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull07.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[강원]</strong>
							    			<span>문암해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000464">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull08.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[경남]</strong>
							    			<span>사량대항해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000458">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull09.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[경북]</strong>
							    			<span>기성망양해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000453">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull10.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전남]</strong>
							    			<span>송호해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000450">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull11.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전북]</strong>
							    			<span>모항해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000447">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull12.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[충남]</strong>
							    			<span>갈음이해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000441">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull13.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[강원]</strong>
							    			<span>복분해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000463">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull14.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[경남]</strong>
							    			<span>여차해변해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000459">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull15.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[경북]</strong>
							    			<span>장사해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000456">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull16.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전남]</strong>
							    			<span>수문해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000449">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull17.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전북]</strong>
							    			<span>위도해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000448">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull18.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[충남]</strong>
							    			<span>난지섬해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000443">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull19.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[강원]</strong>
							    			<span>사천해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000462">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull20.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[경남]</strong>
							    			<span>옥계해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000455">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull21.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전남]</strong>
							    			<span>짱뚱어해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000471">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull22.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[강원]</strong>
							    			<span>원평해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000461">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull23.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[경남]</strong>
							    			<span>와현모래숲해변</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000457">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull24.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전남]</strong>
							    			<span>홍통해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
								<div class="pull_item">
					    			<a href="/seantour_map/travel/destination/detail.do?destId=DEST000454">
							    		<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_slider_pull25.jpg" alt="" /></span>
							    		<span class="tbox">
							    			<strong>[전남]</strong>
							    			<span>예송해수욕장</span>
						    			</span>
						    		</a>
					    		</div>
					    	</div>
					    	<div class="col02">
					    		<ul>
					    			<li>
					    				<a href="/seantour_map/travel/destination/detail.do?destId=DEST000461">

						    				<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_m_pull01.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[경남]</span>와현모래숲해변</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="/seantour_map/travel/destination/detail.do?destId=DEST000448">
						    				<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_m_pull03.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[충남]</span>난지섬해수욕장</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="/seantour_map/travel/destination/detail.do?destId=DEST000452">
						    				<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_m_pull04.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[전남]</span>남일해돋이해수욕장</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="/seantour_map/travel/destination/detail.do?destId=DEST000465">
						    				<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_m_pull05.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[경남]</span>남일대해수욕장</span>
					    				</a>
					    			</li>
					    		</ul>
					    	</div>
					    </div> 
					<%-- 실제 데이터가 축적되면 이 부분부터 삭제 또는 주석 처리  --%>
				    	<%--<div class="tit_box">
				    		<p class="txt">국내 인기 바다여행지를 추천해드립니다.</p>
					        <p class="tit">베스트 <strong>여행 추천 일정</strong></p>
					    </div>
						<div class="vest_recommend_box">
					    	<div class="name_tit">BEST 여행일정</div>
					    	<div class="col01">

					    		<div class="img"><a href="/seantour_map/travel/route/detail.do?routId=ROUT001165"><img src="${pageContext.request.contextPath}/images/travel/main/img_vest2_photo01.jpg" alt="해양관광 추천 여행지 10선" /></a></div>

					    		<div class="tbox">
					    			<span>[제주]</span>
					    			<p>열린관광지로 향한<br />가벼운 발걸음</p>
					    		</div>
					    	</div>
					    	<div class="col02">
					    		<ul>
					    			<li>
					    				<a href="/seantour_map/travel/route/detail.do?routId=ROUT001112">

						    				<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_vest2_photo02.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[전북]</span>시인이 꿈꾸던 ‘그 먼 나라’를 찾아</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="/seantour_map/travel/route/detail.do?routId=ROUT001067">
						    				<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_vest2_photo03.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[전남]</span>자연 그대로의 아름다움을 느끼는 여수여</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="/seantour_map/travel/route/detail.do?routId=ROUT001003">
						    				<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_vest2_photo04.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[전남]</span>한적한 바닷길 따라 소등섬 한 바퀴</span>
					    				</a>
					    			</li>
					    			<li>
					    				<a href="/seantour_map/travel/route/detail.do?routId=ROUT000943">
						    				<span class="img"><img src="${pageContext.request.contextPath}/images/travel/main/img_vest2_photo05.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[부산]</span>부산 앞바다를 한눈에 아우르다</span>
					    				</a>
					    			</li>
					    		</ul>
					    	</div>
					    </div> --%>
					<%-- 실제 데이터가 축적되면 이 부분까지 삭제 또는 주석 처리  --%>
					<%-- 실제 데이터가 축적되면 아래 c:import 영역을 주석 해제 바람
						<c:import url="/travel/route/bestlatest.do" charEncoding="utf-8">
						    <c:param name="pageUnit" value="5" />
						</c:import>
					--%>
					
					<%-- 
					    <div class="writer_recommend_box">
					    	<div class="name_tit">여행작가<br />추천일정</div>
					    	<div class="tit_box">
					    		<p class="txt">국내 인기 바다여행지를 추천해드립니다.</p>
						        <p class="tit">여행작가 <strong>여행 추천 일정</strong></p>
						    </div>
							<div class="area_ctrl">
								<button type="button" class="play"> 재생</button>
								<button type="button" class="pause active"> 정지</button>
							</div>
					    	<div class="main_writer_slider">
								<div class="main_writer_item">
							        <div class="main_writer_img">

							            <img src="${pageContext.request.contextPath/travel/common/images/main/img_writer_photo01.jpg" alt="" />
							        </div>
							        <div class="main_writer_txt">
							        	<p class="tit">
							        		부산의 바다를 제대로 감상하고
											맛볼 수 있는 해운대 & 기장 여행
							        	</p>
							        	<p class="txt">
							        		대한팔경의 하나인 해운대 해수욕장은 백사장의 길이가 1.5Km,
											폭 30~50m 이며,  평균수심은 1m(해수욕장의 면적 58,400㎡) 
											정도이며, 여름철평균 수온은 22.6℃로  따뜻해 수온으로 해수욕...
							        	</p>
							        	<p class="more2">
							        		<a href="#none">자세히 보기</a>
							        	</p>
							        </div>
								</div>
								<div class="main_writer_item">
							        <div class="main_writer_img">
							            <img src="${pageContext.request.contextPath}/travel/common/images/main/img_writer_photo01.jpg" alt="" />
							        </div>
							        <div class="main_writer_txt">
							        	<p class="tit">
							        		부산의 바다를 제대로 감상하고
											맛볼 수 있는 해운대 & 기장 여행
							        	</p>
							        	<p class="txt">
							        		대한팔경의 하나인 해운대 해수욕장은 백사장의 길이가 1.5Km,
											폭 30~50m 이며,  평균수심은 1m(해수욕장의 면적 58,400㎡) 
											정도이며, 여름철평균 수온은 22.6℃로  따뜻해 수온으로 해수욕...
							        	</p>
							        	<p class="more2"><a href="#none">자세히 보기</a></p>
							        </div>
								</div> 
							</div>
					    </div>
					
						<c:import url="/travel/route/latest.do" charEncoding="utf-8">
						    <c:param name="pageUnit" value="5" />
						    <c:param name="titleLen" value="350" />
						</c:import>

			    	</div>--%>
			    </div><!-- // section02 -->
			     <c:import url="/travel/destination/recolist.do" charEncoding="utf-8"></c:import>
			   <%--  <div class="section03 aos-init aos-animate" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
					<div class="minr">
					    <div class="tit_box">
					    	<p class="txt">다양한 해양레저 컨텐츠를 추천해드립니다.</p>
					        <p class="tit"><strong>해양레저</strong> 추천컨텐츠</p>
					    </div>
	                    <div class="main_cont_wrap">
	                        <div class="slick-control">
	                            <button class="slick-arrows slick-prev main_cont_prev" type="button">PREV</button>
	                            <button class="slick-arrows slick-next main_cont_next" type="button">NEXT</button>
	                        </div><!-- .slick-control -->
	                        <div class="main_cont_slider">
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">
								            <img src="${pageContext.request.contextPath}/images/travel/main/img_cont3_photo01.jpg" alt="" />
								            <div class="tbox">
								            	<p class="sub">부산</p>
								            	<p class="tit">해운대삼포길</p>
							            	</div>
								           <div class="more"><a href="/seantour_map/travel/destination/detail.do?destId=FCID112467">자세히보기</a></div>
								            <div class="inner_box"></div>
							            </div>
							        </div>
							        <!--<div class="main_cont_txt">
							        	<p class="tit">
							        		<span>문탠로드</span>
							        		여행코스
							        	</p>
							        	<div class="course">
							        	<ul class="lst">
							        		<li>누리마루 APEC하우스</li>
							        		<li>해운대해수욕장</li>
							        		<li>송정해수욕장</li>
							        		<li>해동용궁사(부산)</li>
							        	</ul>	
							        	</div>
							        </div>-->
								</div>
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">
								            <img src="${pageContext.request.contextPath}/images/travel/main/img_cont3_photo02.jpg" alt="" />
								            <div class="tbox">
								            	<p class="sub">제주</p>
								            	<p class="tit">제주올레8코스</p>
							            	</div>
								             <div class="more"><a href="/seantour_map/travel/destination/detail.do?destId=FCID112458">자세히보기</a></div>
								            <div class="inner_box"></div>
							           </div>
							        </div>
							        <!--<div class="main_cont_txt">
							        	<p class="tit">
							        		<span>이순신 유적지</span>
							        		여행코스
							        	</p>
							        	<div class="course">
							        	<ul class="lst">
							        		<li>오동도</li>
							        		<li>여수 진남관</li>
							        		<li>향일암(여수)</li>
							        		<li>돌산도</li>
							        	</ul>	
							        	</div>
							        </div>-->
								</div>
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">
								            <img src="${pageContext.request.contextPath}/images/travel/main/img_cont3_photo03.jpg" alt="" />
								            <div class="tbox">
								            	<p class="sub">강원</p>
								            	<p class="tit">아들바위 가는 길</p>
							            	</div>
								            <div class="more"><a href="/seantour_map/travel/destination/detail.do?destId=FCID112447">자세히보기</a></div>
								            <div class="inner_box"></div>
							            </div>
							        </div>
							        <!--<div class="main_cont_txt">
							        	<p class="tit">
							        		<span>바다를만나는 체험</span>
							        		여행코스
							        	</p>
							        	<div class="course">
							        	<ul class="lst">
							        		<li>해양과학체험전시관(KORDIUM)</li>
							        		<li>누에섬 등대전망대</li>
							        		<li>안산어촌민속박물관</li>
							        		<li>종현어촌체험마을</li>
							        	</ul>	
							        	</div>
							        </div>-->
								</div>
								<div class="main_cont_item">
							        <div class="main_cont_img">
							        	<div class="inner">
								            <img src="${pageContext.request.contextPath}/images/travel/main/img_cont3_photo04.jpg" alt="" />
								            <div class="tbox">
								            	<p class="sub">전남</p>
								            	<p class="tit">신비의 바닷길</p>
							            	</div>
								            <div class="more"><a href="/seantour_map/travel/destination/detail.do?destId=FCID112444">자세히보기</a></div>
								            <div class="inner_box"></div>
							           </div>
							        </div>
							        <!--<div class="main_cont_txt">
							        	<p class="tit">
							        		<span>블루로드</span>
							        		여행코스
							        	</p>
							        	<div class="course">
							        	<ul class="lst">
							        		<li>고래불해수욕장</li>
							        		<li>괴시리 전통마을</li>
							        		<li>영덕해맞이공원</li>
							        		<li>영덕풍력발전단지</li>
							        		<li>강구항</li>
							        	</ul>	
							        	</div>
							        </div>-->
								</div>
							</div>
						</div>
					</div>
				</div> --%><!-- // section03 --> 
			   <%-- <div class="section04 aos-init aos-animate" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
					<div class="minr">
	                    <div class="main_event_wrap">
	                    	<div class="cont_tit">바다여행 축제일정</div>
	                    	<div class="area_ctrl">
								<button type="button" class="play"> 재생</button>
								<button type="button" class="pause active"> 정지</button>
							</div>
	                        <div class="main_event_slider">
								<div class="main_event_item">
							        <figure>
							            <img src="${pageContext.request.contextPath}/travel/common/images/main/img_ev_photo01.jpg" alt="" />
							        </figure>
							        <div class="main_event_txt">
							        	<p class="tit"><a href="http://www.ulsanwhale.com/" target="_blank">울산 고래축제 2020</a></p>
							        	<p class="date">2020. 06. 12 ~ 2020. 06. 14</p>
							        	<p class="txt">
							        		고래와 바다환경을 보호하며 자연과 인간이 공존
											하는 축제를 만들기 위해 준비한 다양한 볼거리와
											즐길거리로 관광객들에게 즐거움을 선사한다.
							        	</p>
							        </div>
								</div>
								<div class="main_event_item">
							        <figure>
							            <img src="${pageContext.request.contextPath}/travel/common/images/main/img_ev_photo02.jpg" alt="" />
							        </figure>
							        <div class="main_event_txt">
							        	<p class="tit"><a href="https://korean.visitkorea.or.kr/detail/fes_detail.do?cotid=b168f3c7-f528-4f49-9b37-9ead48400169" target="_blank">보령머드축제 2020</a></p>
							        	<p class="date">2020. 07. 17 ~ 2020. 07. 26</p>
							        	<p class="txt">
							        		보령머드의 우수성을 알리고  대천해수욕장을
											비롯한 지역 관광명소를 홍보코자 98년 7월에 
											축제를 개최하였으며 세계적인 축제로 육성...
							        	</p>
							        </div>
								</div>
								<div class="main_event_item">
							        <figure>
							            <img src="${pageContext.request.contextPath}/travel/common/images/main/img_ev_photo03.jpg" alt="" />
							        </figure>
							       <div class="main_event_txt">
							        	<p class="tit"><a href="https://blog.naver.com/greenplugged/221936033625" target="_blank">그린플러그드 동해</a></p>
							        	<p class="date">2020. 07. 25 ~ 2020. 07. 26</p>
							        	<p class="txt">
							        		동해에서만 만날 수 있는 ‘한여름의뮤토피아’에서
											여러분과 함께 좋은 추억을 만들어 나가려 합니다.
							        	</p>
							        </div>
								</div>
								<div class="main_event_item">
							        <figure>
							            <img src="${pageContext.request.contextPath}/travel/common/images/main/img_ev_photo04.jpg" alt="" />
							        </figure>
							       <div class="main_event_txt">
							        	<p class="tit"><a href="https://korean.visitkorea.or.kr/detail/fes_detail.do?cotid=b2bee245-ad29-45a7-a1cb-10c548ed062b" target="_blank">통영한산대첩축제 2020</a></p>
							        	<p class="date">2020. 08. 11 ~ 2020. 08. 15</p>
							        	<p class="txt">
							        		이순신 장군과 바다가 함께하는 축제답게 수군
											체험 노젓기대회나 카누 노젓기대회 등 해양과
											밀접한 다양하고 재미있는 프로그램을 제공한다.
							        	</p>
							        </div>
								</div>
								<div class="main_event_item">
							        <figure>
							            <img src="${pageContext.request.contextPath}/travel/common/images/main/img_ev_photo05.jpg" alt="" />
							        </figure>
							       <div class="main_event_txt">
										<p class="tit"><a href="https://korean.visitkorea.or.kr/detail/fes_detail.do?cotid=1cb85c13-045c-413a-83bf-97d615064abe" target="_blank">화성 뱃놀이축제</a></p>
										<p class="date">2020. 09. 11 ~ 2020. 09. 13</p>
										<p class="txt">
											화성시의 풍부한 문화관광 자원을 활용하여
											승선체험, 육상 해상 체험프로그램과 캠핑장 등
											다양한 부대 프로그램을 즐길 수 있는 국내 최고...
										</p>
									</div>
								</div>
							</div>
							<!--<div class="more"><a href="#none">축제일정 더보기</a></div>-->
						</div>
						<div class="fame_box">
							<div class="txt_area">
								<p class="tit">
									바다여행일정<br />
									<strong>명성이란?</strong>
								</p>
								<p class="txt">
									일정만들기,공유하기,추천하기등<br />
									홈페이 활동에 따라 올라가는 <br />
									내 점수를 확인해보세요.
								</p>
								<p class="more2"><a href="/seantour_map/travel/fame/ranking.do">자세히보기</a></p>
							</div>
							<ul class="fame_item">
								<li>
									<span class="icon01"></span>
									<div class="txt">
										<strong>추천하기</strong>
										<p>
											잘 만들어진 여행일정을 <br />
											추천해 보세요.
										</p>
									</div>
								</li>
								<li>
									<span class="icon02"></span>
									<div class="txt">
										<strong>공유하기</strong>
										<p>
											SNS친구들에게<br />
											여행일정을 공유하고<br />
											함께 소통해보세요.
										</p>
									</div>
								</li>
								<li>
									<span class="icon03"></span>
									<div class="txt">
										<strong>일정만들기</strong>
										<p>
											내가 만든 여행일정을<br />
											사람들에게 자랑해보세요.
										</p>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div><!-- // section04 --> --%>
				<script>// <![CDATA[
			       AOS.init({
			          offset: 0,
			          easing: 'ease-out-quad',
			        });
			// ]]></script>	
			</div>
			<!--// cont_main -->
		</div>
		<!--// container -->
		<!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	<!-- // wrap -->
</body>
</html><% /*<!-- /[-CONTENT-] -->*/ %>