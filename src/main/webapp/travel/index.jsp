<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><% /*<!-- [-CONTENT-] -->*/ %><%@ include file="/_common/stateCount.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>



<%@ include file="/travel/common/config/handing/cssHanding.jsp" %>

<%@ include file="/travel/common/config/handing/jsHanding.jsp" %>


<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
   <script>
   	$(document).ready(function(){
  		$('#close').click(function(){
  			$('#pop').hide();
  		});
  		var d = new Date(); 
		var currentDate = d.getFullYear() + "년 " + ( d.getMonth() + 1 ) + "월 " + d.getDate() + "일 "; 
		var currentTime = "";
		if(d.getMinutes() < 30){
			currentTime = (d.getHours() -1) + "시 30분 기준;
		}else{
			currentTime = d.getHours() + "시 00분 기준;
		}
		$('.time_area ').text(currentDate + currentTime );
  		$.ajax({
  			type:'post',
  			url:"/seantour_map/travel/mainBeachCongestion.do",
  		    success: function(data) {  		    	
				for(var i=0; i < data.length; i++){
					if(i < 10){
						$('.spot' + (i + 1)).find('span').removeClass();						
						$('.spot' + (i + 1)).find('span').addClass('icon');
						var classNm = checkBeachCongestion(data[i].seqId, data[i].uniqPop);
						$('.spot' + (i + 1)).find('span').addClass(classNm);
					}else{
						$('.spot' + (i + 1)).find('a').removeClass();
						$('.spot' + (i + 1)).find('a').addClass('icon');
						var classNm = checkBeachCongestion(data[i].seqId, data[i].uniqPop);
						$('.spot' + (i + 1)).find('a').addClass(classNm);						
					}
				}
		    },
		    error: function(err) {		    	
				alert("신호등 데이터를 가져오는 도중 오류가 발생하였습니다.");
		    }
  		});
	});

	function checkBeachCongestion(beachId, population){
  		var returnStr = '';
  		if(beachId == 1){	if(population < 	32813	){ returnStr = "green";} else if(population < 	65625	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 2){	if(population < 	22297	){ returnStr = "green";} else if(population < 	44593	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 3){	if(population < 	12500	){ returnStr = "green";} else if(population < 	25000	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 4){	if(population < 	109375	){ returnStr = "green";} else if(population < 	218750	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 5){	if(population < 	17266	){ returnStr = "green";} else if(population < 	34531	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 6){	if(population < 	39375	){ returnStr = "green";} else if(population < 	78750	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 7){	if(population < 	11250	){ returnStr = "green";} else if(population < 	22500	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 8){	if(population < 	33938	){ returnStr = "green";} else if(population < 	67875	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 9){	if(population < 	3750	){ returnStr = "green";} else if(population < 	7500	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 10){	if(population < 	33750	){ returnStr = "green";} else if(population < 	67500	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 11){	if(population < 	46313	){ returnStr = "green_hover";} else if(population < 	92625	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 12){	if(population < 	18500	){ returnStr = "green_hover";} else if(population < 	37000	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 13){	if(population < 	2813	){ returnStr = "green_hover";} else if(population < 	5625	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 14){	if(population < 	178125	){ returnStr = "green_hover";} else if(population < 	356250	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 15){	if(population < 	28125	){ returnStr = "green_hover";} else if(population < 	56250	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 16){	if(population < 	9169	){ returnStr = "green_hover";} else if(population < 	18338	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 17){	if(population < 	2726	){ returnStr = "green_hover";} else if(population < 	5453	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 18){	if(population < 	68750	){ returnStr = "green_hover";} else if(population < 	137500	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 19){	if(population < 	5625	){ returnStr = "green_hover";} else if(population < 	11250	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 20){	if(population < 	4103	){ returnStr = "green_hover";} else if(population < 	8206	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 21){	if(population < 	50000	){ returnStr = "green_hover";} else if(population < 	100000	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 22){	if(population < 	27188	){ returnStr = "green_hover";} else if(population < 	54375	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 23){	if(population < 	117188	){ returnStr = "green_hover";} else if(population < 	234375	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 24){	if(population < 	10236	){ returnStr = "green_hover";} else if(population < 	20471	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 25){	if(population < 	40000	){ returnStr = "green_hover";} else if(population < 	80000	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 26){	if(population < 	13855	){ returnStr = "green_hover";} else if(population < 	27710	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 27){	if(population < 	4520	){ returnStr = "green_hover";} else if(population < 	9039	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 28){	if(population < 	20184	){ returnStr = "green_hover";} else if(population < 	40368	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 29){	if(population < 	1406	){ returnStr = "green_hover";} else if(population < 	2813	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 30){	if(population < 	1034	){ returnStr = "green_hover";} else if(population < 	2068	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 31){	if(population < 	14095	){ returnStr = "green_hover";} else if(population < 	28191	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 32){	if(population < 	4219	){ returnStr = "green_hover";} else if(population < 	8438	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 33){	if(population < 	15938	){ returnStr = "green_hover";} else if(population < 	31875	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 34){	if(population < 	2219	){ returnStr = "green_hover";} else if(population < 	4438	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 35){	if(population < 	8750	){ returnStr = "green_hover";} else if(population < 	17500	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 36){	if(population < 	23438	){ returnStr = "green_hover";} else if(population < 	46875	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 37){	if(population < 	3750	){ returnStr = "green_hover";} else if(population < 	7500	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 38){	if(population < 	4500	){ returnStr = "green_hover";} else if(population < 	9000	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 39){	if(population < 	170625	){ returnStr = "green_hover";} else if(population < 	341250	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 40){	if(population < 	3656	){ returnStr = "green_hover";} else if(population < 	7313	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 41){	if(population < 	10000	){ returnStr = "green_hover";} else if(population < 	20000	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 42){	if(population < 	25938	){ returnStr = "green_hover";} else if(population < 	51875	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 43){	if(population < 	7813	){ returnStr = "green_hover";} else if(population < 	15625	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 44){	if(population < 	2000	){ returnStr = "green_hover";} else if(population < 	4000	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 45){	if(population < 	2844	){ returnStr = "green_hover";} else if(population < 	5688	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 46){	if(population < 	4744	){ returnStr = "green_hover";} else if(population < 	9488	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 47){	if(population < 	9903	){ returnStr = "green_hover";} else if(population < 	19805	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 48){	if(population < 	5625	){ returnStr = "green_hover";} else if(population < 	11250	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 49){	if(population < 	10568	){ returnStr = "green_hover";} else if(population < 	21136	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}
  		if(beachId == 50){	if(population < 	29063	){ returnStr = "green_hover";} else if(population < 	58125	){ returnStr = "yellow_hover";} else { returnStr = "red_hover";}}

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
                         	
								  <div class="main_visual_content_cell_right">
									 <div class="main_visual_content_cell_right_inr">
										<div class="spot_title"><img src="/seantour_map/images/travel/main/img_map_tit.png" alt="해수욕장 혼잡도 신호등" /></div>
										<div class="spot_info"><img src="/seantour_map/images/travel/main/img_info_box.png" alt="혼잡: 빨간색, 혼잡우려: 노란색, 적정: 녹색" /></div>
										 <div class="spot spot11"><a href="/seantour_map/travel/destination/detail.do?destId=DEST000442" class="icon red_hover">노봉<br /><em>200명</em></a></div>
										  	 <div class="spot spot12"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110592" class="icon red_hover">맹방<br /><em>200명</em></a></div>
										  	 <div class="spot spot13"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111738" class="icon red_hover">추암<br /><em>200명</em></a></div>
										  	 <div class="spot spot14"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111124" class="icon green_hover">명사십리<br /><em>200명</em></a></div>
									  	   	 <div class="spot spot15"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110572" class="icon red_hover">만리포<br /><em>200명</em></a></div>
										  	 <div class="spot spot16"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111470" class="icon green_hover">일산<br /><em>200명</em></a></div>
										  	 <div class="spot spot17"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111899" class="icon green_hover">함덕서우봉<br /><em>200명</em></a></div>
										  	 <div class="spot spot18"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111658" class="icon green_hover">진하<br /><em>200명</em></a></div>
										  	 <div class="spot spot19"><a href="/seantour_map/travel/destination/detail.do?destId=FCID000293" class="icon green_hover">하조대<br /><em>200명</em></a></div> 
										  	 <div class="spot spot20"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111959" class="icon green_hover">협재<br /><em>200명</em></a></div>
										  	 <div class="spot spot21"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110180" class="icon green_hover">고래불<br /><em>200명</em></a></div>
										  	 <div class="spot spot22"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111605" class="icon green_hover">주문진<br /><em>200명</em></a></div>
										  	 <div class="spot spot23"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111741" class="icon yellow_hover">춘장대<br /><em>200명</em></a></div>
										  	 <div class="spot spot24"><a href="/seantour_map/travel/destination/detail.do?destId=DEST000481" class="icon red_hover">이호테우<br /><em>200명</em></a></div>
										  	 <div class="spot spot25"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110338" class="icon red_hover">꽃지<br /><em>200명</em></a></div>
										  	 <div class="spot spot26"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111063" class="icon green_hover">송지호<br /><em>200명</em></a></div>
										  	 <div class="spot spot27"><a href="/seantour_map/travel/destination/detail.do?destId=DEST000482" class="icon green_hover">곽지과물<br /><em>200명</em></a></div>
										  	 <div class="spot spot28"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111998" class="icon red_hover">화진포<br /><em>200명</em></a></div>
										  	 <div class="spot spot29"><a href="/seantour_map/travel/destination/detail.do?destId=DEST000483" class="icon yellow_hover">외옹치<br /><em>200명</em></a></div>
										  	 <div class="spot spot30"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110313" class="icon yellow_hover">금능으뜸원<br /><em>200명</em></a></div>
										  	 <div class="spot spot31"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110902" class="icon yellow_hover">삼포<br /><em>200명</em></a></div>
										  	 <div class="spot spot32"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111467" class="icon yellow_hover">일광<br /><em>200명</em></a></div>
										  	 <div class="spot spot33"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110626" class="icon yellow_hover">몽산포<br /><em>200명</em></a></div>
										  	 <div class="spot spot34"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111476" class="icon yellow_hover">임랑<br /><em>200명</em></a></div>
										  	 <div class="spot spot35"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111628" class="icon green_hover">중문<br /><em>200명</em></a></div>
										  	 <div class="spot spot36"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111527" class="icon red_hover">장호<br /><em>200명</em></a></div>
										  	 <div class="spot spot37"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110641" class="icon green_hover">무창포<br /><em>200명</em></a></div>
										  	 <div class="spot spot38"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111168" class="icon red_hover">안목<br /><em>200명</em></a></div>
										  	 <div class="spot spot39"><a href="/seantour_map/travel/destination/detail.do?destId=FCID007759" class="icon green_hover">상주은모래비치<br /><em>200명</em></a></div>
										  	 <div class="spot spot40"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111438" class="icon green_hover">을왕리<br /><em>200명</em></a></div>
										  	 <div class="spot spot41"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110873" class="icon red_hover">삼봉<br /><em>200명</em></a></div>
										  	 <div class="spot spot42"><a href="/seantour_map/travel/destination/detail.do?destId=FCID003274" class="icon red_hover">정동진<br /><em>200명</em></a></div>
										  	 <div class="spot spot43"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111358" class="icon green_hover">용화<br /><em>200명</em></a></div>
										  	 <div class="spot spot44"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110533" class="icon red_hover">등대<br /><em>200명</em></a></div>
										  	 <div class="spot spot45"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111854" class="icon red_hover">하나개<br /><em>200명</em></a></div>
										  	 <div class="spot spot46"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111062" class="icon red_hover">송지호오토캠핑<br /><em>200명</em></a></div>
										  	 <div class="spot spot47"><a href="/seantour_map/travel/destination/detail.do?destId=DEST000484" class="icon red_hover">관성<br /><em>200명</em></a></div>
										  	 <div class="spot spot48"><a href="/seantour_map/travel/destination/detail.do?destId=FCID102542" class="icon red_hover">중광정<br /><em>200명</em></a></div>
										  	 <div class="spot spot49"><a href="/seantour_map/travel/destination/detail.do?destId=DEST000485" class="icon red_hover">천진<br /><em>200명</em></a></div>
										  	 <div class="spot spot50"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111108" class="icon red_hover">신두리<br /><em>200명</em></a></div>
                                          
										<div class="blinker spot1"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111941" class="name">해운대<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot2"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110239" class="name">광안리<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot3"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110780" class="name">송도<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot4"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110458" class="name">대천<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot5"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110405" class="name">다대포<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot6"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110072" class="name">경포<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot7"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111059" class="name">송정<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot8"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110349" class="name">낙산<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot9"><a href="/seantour_map/travel/destination/detail.do?destId=FCID111039" class="name">속초<br /><em>200명</em><span class="icon green"></span></a></div>
                                           <div class="blinker spot10"><a href="/seantour_map/travel/destination/detail.do?destId=FCID110894" class="name">삼척<br /><em>200명</em><span class="icon green"></span></a></div>
                                       <div class="time">기준시각<br/><span class="time_area">13:00</span></div>
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
              <div class="section00">
					<div class="inr">
						<p>해수욕장 혼잡도 신호등은 <span>네이버</span>와 함께 합니다.</p>
					</div> 
				</div>
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

			    	</div>
			    </div><!-- // section02 -->--%>
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