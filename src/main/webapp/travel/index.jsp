<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><% /* cset_s */ %><% String servletPath = request.getServletPath(); %><% String[] Jnit_ServletPath = servletPath.split("/"); String Jnit_sitePath = Jnit_ServletPath[1]; %><c:set var="Jnit_sitePath" value="<%= Jnit_sitePath %>" scope="request"/><%@ page import="egovframework.com.utl.fcc.service.StringUtil"%><% String localYn = ""; if(StringUtil.isExistString(request.getRequestURL().toString(),"local")) localYn="Y"; %><c:set var="localYn" value="<%= localYn %>" scope="request" /><% /* cset_e */ %><% /*<!-- [-CONTENT-] -->*/ %><%@ include file="/_common/stateCount.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>


<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/travel/main.css'/>" /> --%>


<%@ include file="/travel/common/config/handing/cssHanding.jsp" %>

<%@ include file="/travel/common/config/handing/jsHanding.jsp" %>


<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
  <!--  <script>
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
  			 url:"http://localhost:8082/seantour_map/travel/mainBeachCongestion.do",
  			/* url:"/seantour_map/travel/mainBeachCongestion.do", */
  		    success: function(data) {  		
               /*  $('.time').find('span').text(currentTime); */
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
  		if(beachId == 2){	if(population < 	18000	){ returnStr = "yellow";} else if(population < 	35999	){ returnStr = "yellow";} else { returnStr = "red";}}
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
  		if(beachId == 19){	if(population < 	4500	){ returnStr = "yellow";} else if(population < 	8999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 20){	if(population < 	5000	){ returnStr = "green";} else if(population < 	9999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 21){	if(population < 	58940	){ returnStr = "green";} else if(population < 	117879	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 22){	if(population < 	16548	){ returnStr = "green";} else if(population < 	33096	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 23){	if(population < 	23438	){ returnStr = "green";} else if(population < 	46874	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 24){	if(population < 	6250	){ returnStr = "green";} else if(population < 	12499	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 25){	if(population < 	8000	){ returnStr = "green";} else if(population < 	15999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 26){	if(population < 	8343	){ returnStr = "green";} else if(population < 	16684	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 27){	if(population < 	7000	){ returnStr = "green";} else if(population < 	13999	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 28){	if(population < 	15403	){ returnStr = "green";} else if(population < 	30805	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 29){	if(population < 	250		){ returnStr = "yellow";} else if(population < 	499		){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 30){	if(population < 	2500	){ returnStr = "yellow";} else if(population < 	4999	){ returnStr = "yellow";} else { returnStr = "red";}}
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
  		if(beachId == 46){	if(population < 	4496	){ returnStr = "yellow";} else if(population < 	8991	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 47){	if(population < 	8859	){ returnStr = "green";} else if(population < 	17718	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 48){	if(population < 	4499	){ returnStr = "green";} else if(population < 	8998	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 49){	if(population < 	4439	){ returnStr = "green";} else if(population < 	8878	){ returnStr = "yellow";} else { returnStr = "red";}}
  		if(beachId == 50){	if(population < 	5813	){ returnStr = "green";} else if(population < 	11624	){ returnStr = "yellow";} else { returnStr = "red";}}

  		return returnStr;
  	}
   </script> -->
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
<%--<script>
// Log events flag
var logEvents = false;

// Global vars to cache event state
var evCache = new Array();
var prevDiff = -1;

// Logging/debugging functions
function enableLog(ev) {
  logEvents = logEvents ? false : true;
}

function log(prefix, ev) {
  if (!logEvents) return;
  var o = document.getElementsByTagName('output')[0];
  var s = prefix + ": pointerID = " + ev.pointerId +
                " ; pointerType = " + ev.pointerType +
                " ; isPrimary = " + ev.isPrimary;
  o.innerHTML += s + " <br>";
} 

function clearLog(event) {
 var o = document.getElementsByTagName('output')[0];
 o.innerHTML = "";
}

function pointerdown_handler(ev) {
 // The pointerdown event signals the start of a touch interaction.
 // This event is cached to support 2-finger gestures
 evCache.push(ev);
 log("pointerDown", ev);
}

function pointermove_handler(ev) {
 // This function implements a 2-pointer horizontal pinch/zoom gesture. 
 //
 // If the distance between the two pointers has increased (zoom in), 
 // the taget element's background is changed to "pink" and if the 
 // distance is decreasing (zoom out), the color is changed to "lightblue".
 //
 // This function sets the target element's border to "dashed" to visually
 // indicate the pointer's target received a move event.
 log("pointerMove", ev);
 //ev.target.style.border = "dashed";

 // Find this event in the cache and update its record with this event
 for (var i = 0; i < evCache.length; i++) {
   if (ev.pointerId == evCache[i].pointerId) {
      evCache[i] = ev;
   break;
   }
 }

 // If two pointers are down, check for pinch gestures
 if (evCache.length == 2) {
   // Calculate the distance between the two pointers
   var curDiff = Math.abs(evCache[0].clientX - evCache[1].clientX);

   if (prevDiff > 0) {
     if (curDiff > prevDiff) {
       // The distance between the two pointers has increased
       log("Pinch moving OUT -> Zoom in", ev);
      // ev.target.style.background = "pink";
      ev.target.find(".name").css("dispaly", "block");
     }
     if (curDiff < prevDiff) {
       // The distance between the two pointers has decreased
       log("Pinch moving IN -> Zoom out",ev);
     //  ev.target.style.background = "lightblue";
     }
   }

   // Cache the distance for the next move event 
   prevDiff = curDiff;
 }
}

function pointerup_handler(ev) {
  log(ev.type, ev);
  // Remove this pointer from the cache and reset the target's
  // background and border
  remove_event(ev);
  //ev.target.style.background = "white";
  //ev.target.style.border = "1px solid black";
 
  // If the number of pointers down is less than two then reset diff tracker
  if (evCache.length < 2) prevDiff = -1;
}

function remove_event(ev) {
 // Remove this event from the target's cache
 for (var i = 0; i < evCache.length; i++) {
   if (evCache[i].pointerId == ev.pointerId) {
     evCache.splice(i, 1);
     break;
   }
 }
}

function init() {
 // Install event handlers for the pointer target
 var el=document.getElementById("target");
 el.onpointerdown = pointerdown_handler;
 el.onpointermove = pointermove_handler;

 // Use same handler for pointer{up,cancel,out,leave} events since
 // the semantics for these events - in this app - are the same.
 el.onpointerup = pointerup_handler;
 el.onpointercancel = pointerup_handler;
 el.onpointerout = pointerup_handler;
 el.onpointerleave = pointerup_handler;
}

</script> --%>

  </head>
<!-- <body onload="init();"> -->
<body>
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
    <%--    <div id="pop">
          <div><img src="${pageContext.request.contextPath}/travel/common/images/main/main_pop2.jpg" alt="" /></div>
         <div id="close">close</div>
      </div>
      <div id="pop_main2">
         <div><img src="${pageContext.request.contextPath}/travel/common/images/main/main_pop_reserv.jpg" alt="" /></div>
         <div id="close2">close</div>
      </div> --%>
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
						<li class="n01">
							<div class="main_visual_wrap">
								<div class="main_visual_content">
									<div class="main_visual_content_cell">
									  <div class="main_visual_content_cell_left">
									 	<p class="tit">내가 만드는 <strong>바다여행</strong></p> 	 
									 	<p class="sub_tit">
									 		언제든 누구와든 함께 떠나기 좋은<br />
											공기좋고 깨끗한 국내 바다여행 일정만들기
									 	</p> 
									  	<ul class="img_lst">
									  		<li><img src="${pageContext.request.contextPath}/travel/common/images/main/img_visual2_s1.png" alt="해파랑공원" /></li>
									  		<li><img src="${pageContext.request.contextPath}/travel/common/images/main/img_visual2_s2.png" alt="호미곶" /></li>
									  		<li><img src="${pageContext.request.contextPath}/travel/common/images/main/img_visual2_s3.png" alt="주상절리" /></li>
									  	</ul>
									  </div>
									 
									  <div class="main_visual_content_cell_right">
									  	 <div class="main_visual_content_cell_right_inr">
										  	 <div class="visual_arrow">
											  	 <img src="${pageContext.request.contextPath}/travel/common/images/main/img_visual2_arrow.png" alt="" />
											  </div>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=인천" class="point point1">인천광역시</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경기" class="point point2">경기도</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=강원" class="point point3">강원도</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=충남" class="point point4">충청남도</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=충북" class="point point5">충청북도</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경북" class="point point6">경상북도</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=대구" class="point point7">대구광역시</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=울산" class="point point8">울산광역시</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=전북" class="point point9">전라북도</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경남" class="point point10">경상남도</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=부산" class="point point11">부산광역시</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=전남" class="point point12">전라남도</a>
										  	 <a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=제주" class="point point13">제주특별시</a>
										  </div>
									  </div>
									  <div class="spot_search">
									  	<div class="cssSelect">
									  		<button type="button">부산광역시</button>
									  		<ul class="lst">
									  		 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=인천">인천광역시</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경기">경기도</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=강원">강원도</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=충남">충청남도</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=충북">충청북도</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경북">경상북도</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=대구">대구광역시</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=울산">울산광역시</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=전북">전라북도</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=경남">경상남도</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=부산">부산광역시</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=전남">전라남도</a></li>
										  	 <li><a href="${pageContext.request.contextPath}/travel/destination/list.do?destRegion=제주">제주특별시</a></li>
									  		</ul>
								  		</div>
									  </div>
									  <div class="visual_go">
									  		<a href="${pageContext.request.contextPath}/travel/route/register.do" class="button mv_btn01">여행일정 만들기</a>
									  		<a href="${pageContext.request.contextPath}/travel/route/list.do" class="button mv_btn02">여행일정 검색</a>
									  </div>
									</div>
								</div>
							</div>
						</li>
						<li class="n02">
							<div class="main_visual_wrap">
								<div class="main_visual_content">
									<div class="main_visual_content_cell">
									  <div class="main_visual_content_cell_left">
									 	<p class="tit">내가 만드는 <strong>바다여행</strong></p> 	 
									 	<p class="sub_tit">
									 		언제든 누구와든 함께 떠나기 좋은<br />
											공기좋고 깨끗한 국내 바다여행 일정만들기
									 	</p> 	 
									  	<ul class="img_lst">
									  		<li><img src="${pageContext.request.contextPath}/travel/common/images/main/img_visual2_s1.png" alt="해파랑공원" /></li>
									  		<li><img src="${pageContext.request.contextPath}/travel/common/images/main/img_visual2_s2.png" alt="호미곶" /></li>
									  		<li><img src="${pageContext.request.contextPath}/travel/common/images/main/img_visual2_s3.png" alt="주상절리" /></li>
									  	</ul>
									  </div>
									 
									  <div class="main_visual_content_cell_right">
									  	 <div class="main_visual_content_cell_right_inr">
										  	 <div class="visual_arrow">
											  	 <img src="${pageContext.request.contextPath}/travel/common/images/main/img_visual2_arrow.png" alt="" />
											  </div>
										  	 <a href="#none" class="point point1">인천</a>
										  	 <a href="#none" class="point point2">경기</a>
										  	 <a href="#none" class="point point3">강원</a>
										  	 <a href="#none" class="point point4">충남</a>
										  	 <a href="#none" class="point point5">충북</a>
										  	 <a href="#none" class="point point6">경북</a>
										  	 <a href="#none" class="point point7">대구</a>
										  	 <a href="#none" class="point point8">울산</a>
										  	 <a href="#none" class="point point9">전북</a>
										  	 <a href="#none" class="point point10">경남</a>
										  	 <a href="#none" class="point point11">부산</a>
										  	 <a href="#none" class="point point12">전남</a>
										  	 <a href="#none" class="point point13">제주</a>
										  </div>
									  </div>
									  <div class="spot_search">
									  	<div class="cssSelect">
									  		<button type="button">부산광역시</button>
									  		<ul class="lst">
									  			<li><a href="#none">부산광역시</a></li>
									  			<li><a href="#none">대구광역시</a></li>
									  			<li><a href="#none">인천광역시</a></li>
									  			<li><a href="#none">대전광역시</a></li>
									  			<li><a href="#none">울산광역시</a></li>
									  			<li><a href="#none">경기도</a></li>
									  			<li><a href="#none">충청북도</a></li>
									  			<li><a href="#none">충청남도</a></li>
									  			<li><a href="#none">전라북도</a></li>
									  			<li><a href="#none">전라남도</a></li>
									  			<li><a href="#none">경상북도</a></li>
									  			<li><a href="#none">경상남도</a></li>
									  			<li><a href="#none">제주특별자치도</a></li>
									  		</ul>
								  		</div>
									  </div>
									  <div class="visual_go">
									  		<a href="#none" class="button mv_btn01">여행일정 만들기</a>
									  		<a href="#none" class="button mv_btn02">여행일정 검색</a>
									  </div>
									</div>
								</div>
							</div>
						</li>
					</ul>
				</div><!-- //spotzone -->
            
		<%-- 		<div class="section01 aos-init aos-animate" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200">
					<div class="minr">
						<div class="event_box">
					    	<a href="/seantour_map/travel/info_square/recommendation/index.jsp" class="btn-example"><img src="${pageContext.request.contextPath}/images/travel/main/img_main_banner_10pull.jpg" alt="" /></a>
					    </div>
					    <div class="leaflet_box">
					    	<a href="/seantour_map/travel/info_square/leaflet/index.jsp"><img src="${pageContext.request.contextPath}/images/travel/main/img_main_leaflet.png" alt="건강지키는 바다여행! 해양관광 리플렛 보러가기" /></a>
					    </div>
				    </div>
			    </div> <!-- // section01 -->--%>  
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
			
						<c:import url="/travel/route/bestlatest.do" charEncoding="utf-8">
						    <c:param name="pageUnit" value="5" />
						</c:import>
					
					
					<%-- <%-- 
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
					 --%>
						<c:import url="/travel/route/latest.do" charEncoding="utf-8">
						    <c:param name="pageUnit" value="5" />
						    <c:param name="titleLen" value="350" />
						</c:import>

			    	</div>
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
			   <div class="section04 aos-init aos-animate" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
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
				</div><!-- // section04 --> 
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