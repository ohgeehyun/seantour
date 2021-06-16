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
<script>
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
      $(".name").css("display", "block");
     }
     if (curDiff < prevDiff) {
       // The distance between the two pointers has decreased
       log("Pinch moving IN -> Zoom out",ev);
       $(".name").css("display", "none");
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

</script>

  </head>
<body onload="init();">
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
			<div id="container" class="main" >
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
								  <div class="main_visual_content_cell_right">
								  	<!--  <div id="target" class="main_visual_content_cell_right_inr"> -->
								  	 	<script src="./common/js/jquery.rwdImageMaps.min.js"></script>
										<script>
										$(document).ready(function(e) {
											$('img[usemap]').rwdImageMaps();
											
											
										});
										</script>
										<script>
											$(function(){
											 var status = 'status';
										
										//지도 온표시
											$("#Map area").click(
												function(){
													console.log($(this).attr("class"));
													$("#map-image").attr("src", "./images/main_summer/map_"+$(this).attr("class")+".png");
												}
											);
										});	
										</script>
										<div class="select_map">
											<img src="./images/main_summer/img_map_main.png" alt="" id="map-image" usemap="#Map" />
									         <map name="Map" id="Map">
										      <!--<area shape="poly" id="map01" class="map01" coords="147,70,143,78,140,86,133,94,120,103,107,110,98,117,95,129,100,140,104,152,108,159,117,164,119,169,119,171,108,171,103,166,98,156,93,150,84,149,82,158,85,163,88,171,95,179,105,175,111,175,116,177,119,178,125,164,135,163,145,158,151,159,163,165,164,171,168,178,173,187,171,193,165,195,154,198,145,201,139,200,130,194,124,181,124,195,120,201,114,200,118,206,112,210,111,218,118,220,125,221,127,225,127,229,123,229,117,233,109,233,103,233,102,241,99,249,98,255,103,256,108,248,116,248,125,248,125,251,116,251,112,257,112,263,115,265,122,263,129,263,132,267,129,269,123,270,120,270,119,276,122,281,128,282,134,280,139,276,142,276,141,279,148,279,156,276,168,273,175,274,184,276,188,278,193,272,202,267,212,263,216,267,221,259,225,252,231,245,242,234,241,224,239,213,243,207,242,196,240,186,245,184,246,179,238,176,226,177,211,169,212,158,217,145,223,135,219,126,214,117,211,108,201,106,198,101,196,91,190,87,179,85,169,87,167,79,162,71,148,70" href="#" onclick="alert('준비중입니다.');" alt="경기" />-->
										      <area shape="poly" id="map02" class="map02" coords="119,182,110,175,100,176,101,187,101,193,93,198,95,202,101,206,105,201,109,199,115,199,119,198,125,187,118,182" href="#" alt="인천"  onclick="alert('준비중입니다.');" />
										      <area shape="poly" id="map03" class="map03" coords="148,70,168,57,182,56,197,52,221,53,242,51,250,52,256,53,267,54,279,56,295,52,307,46,315,34,321,22,322,14,328,11,333,18,338,25,341,30,339,38,343,46,347,61,353,72,359,82,369,96,371,101,374,115,385,128,395,140,409,150,419,157,422,166,425,176,434,189,437,197,443,206,446,219,453,229,455,238,448,242,440,247,436,255,427,256,421,249,418,248,414,250,401,251,396,254,388,254,382,256,374,259,367,258,356,256,340,248,332,246,327,243,329,238,324,236,314,235,302,234,297,235,288,235,282,230,277,223,273,223,268,230,268,238,265,240,252,242,245,238,243,231,244,220,245,212,245,203,243,186,248,181,248,177,240,172,224,173,217,166,215,166,215,154,219,146,223,139,223,128,219,122,213,113,215,106,209,103,201,103,200,99,198,88,191,84,176,84,169,79,164,70,151,70" href="#" alt="강원"  onclick="alert('준비중입니다.');" />
										      <area shape="poly" id="map04" class="map04" coords="142,281,137,286,134,285,128,289,129,297,123,295,121,289,113,275,104,274,98,279,94,283,93,279,91,270,83,260,83,267,85,272,85,276,85,281,79,280,79,285,77,288,74,285,71,277,65,270,62,276,63,283,70,290,63,297,58,299,53,295,55,290,55,285,53,283,48,287,47,292,43,297,41,300,35,307,37,313,41,315,42,320,41,324,45,327,55,323,55,333,56,336,61,326,62,322,67,324,70,327,74,325,84,325,85,333,80,336,76,342,76,349,78,357,81,366,82,372,80,377,83,384,86,389,81,398,86,402,87,406,95,406,91,409,82,412,79,416,83,419,91,421,101,422,100,425,105,428,113,432,125,425,137,416,150,416,157,421,164,427,171,422,177,420,186,418,195,419,199,428,205,434,215,428,221,425,221,416,221,404,213,394,212,399,204,389,198,387,194,396,187,390,188,384,182,377,188,366,187,361,196,357,197,351,191,332,190,327,196,314,199,304,191,293,187,279,169,276,153,280,143,279" href="#" alt="충남" onclick="alert('준비중입니다.');" />
										      <area shape="poly" id="map05" class="map05" coords="356,259,346,267,337,282,331,295,328,303,317,309,312,305,302,305,291,308,287,315,286,321,277,322,270,321,270,339,263,341,264,351,270,356,268,366,265,381,265,388,275,395,280,400,285,414,278,418,267,421,259,429,252,430,257,438,258,445,258,452,269,463,278,466,289,470,300,479,299,491,305,494,319,493,325,492,323,485,334,485,329,478,330,471,336,469,338,462,330,459,331,455,333,451,338,450,347,445,357,440,369,443,374,451,374,460,369,465,368,471,367,479,360,484,354,482,349,484,346,489,363,500,379,500,388,495,395,491,408,496,409,489,416,487,416,477,429,474,441,473,448,479,455,485,464,475,470,481,472,470,480,447,484,429,480,419,476,423,469,427,465,426,465,416,462,408,462,396,464,374,467,358,467,339,468,319,468,305,467,281,463,264,463,253,463,242,456,240,447,243,438,253,430,257,423,252,417,252,406,252,396,255,382,258,373,261,356,259" href="#" alt="경북" onclick="alert('준비중입니다.');" />
										      <area shape="poly" id="map06" class="map06" coords="201,435,196,429,193,425,188,422,172,426,162,428,157,428,152,423,147,421,139,420,133,427,131,434,119,439,106,443,91,447,95,457,107,457,117,451,126,453,121,456,115,458,110,466,118,467,126,467,127,471,121,479,114,478,108,474,103,472,99,475,97,481,88,485,78,488,78,498,89,500,101,500,105,501,101,507,89,506,83,509,78,516,74,520,68,525,69,530,73,533,77,528,82,535,85,541,87,546,92,542,100,542,108,531,109,524,122,518,130,516,138,520,144,527,149,525,158,521,159,528,160,535,163,538,175,541,189,542,197,542,208,535,213,533,222,534,229,531,233,518,227,502,227,483,231,472,240,464,250,458,255,453,256,441,254,430,249,425,228,424,214,430,204,436" href="#" alt="전북" onclick="alert('준비중입니다.');" />
										      <area shape="poly" id="map07" class="map07" coords="126,559,124,520,111,524,109,534,105,541,95,545,85,546,81,540,77,533,72,541,64,544,64,552,55,559,55,565,62,567,70,565,67,568,64,574,71,582,73,589,68,593,62,594,58,583,56,574,50,579,48,585,56,589,64,601,64,606,66,618,66,626,60,619,56,612,55,609,51,614,48,623,57,632,72,633,79,632,82,625,84,613,93,615,94,627,102,635,95,637,84,635,84,643,81,645,74,643,66,642,63,643,69,648,79,649,89,654,93,659,85,660,78,657,71,652,66,654,71,661,75,663,73,669,66,664,62,657,57,646,52,644,50,653,51,661,51,666,54,668,63,671,70,671,71,675,77,674,82,671,86,675,81,678,78,681,75,691,73,697,75,702,75,705,84,715,91,715,94,710,101,698,107,697,113,697,116,683,120,677,125,681,125,690,128,696,134,696,142,696,144,693,144,685,141,681,150,675,145,669,143,664,156,659,159,655,163,649,167,645,175,646,177,635,183,631,190,635,194,642,193,648,189,651,184,646,182,649,183,654,183,658,176,660,171,659,169,663,172,673,178,666,182,672,191,679,198,679,205,674,209,669,206,663,204,658,209,659,218,663,220,656,224,644,218,641,207,639,204,633,204,628,207,626,213,626,215,614,222,631,224,638,227,646,231,652,237,647,235,635,237,632,241,631,247,631,250,633,251,624,252,618,247,615,242,620,233,627,227,620,223,610,224,605,231,602,236,604,242,605,247,599,251,598,249,588,239,576,225,562,222,536,214,535,204,535,200,540,184,541,166,539,158,533,158,525,153,524,146,530,140,521,125,520,125,521,126,555,119,559,115,556,107,563,103,572,109,577,118,582,130,579,144,577,148,572,144,562,136,557,132,554,126,556,123,519" href="#" alt="전남" onclick="alert('준비중입니다.');" />
										      <area shape="poly" id="map08" class="map08" coords="257,456,242,467,235,474,230,493,228,500,233,512,234,523,229,535,226,541,227,554,229,564,242,570,242,580,248,586,250,594,254,599,263,599,268,594,272,597,278,603,275,597,276,588,284,584,286,598,286,608,295,612,307,617,314,617,318,614,317,604,321,601,324,610,329,619,336,624,343,621,340,615,344,607,343,603,343,598,347,592,348,588,350,581,354,586,361,589,359,580,360,570,366,569,368,576,371,571,375,572,375,585,382,572,386,571,385,562,392,561,405,561,408,550,418,546,423,546,431,541,440,526,436,525,430,524,424,523,425,514,417,513,409,512,402,502,407,498,398,492,385,500,366,501,351,499,345,494,339,496,331,498,328,496,312,497,297,499,299,487,299,479,283,473,271,463,257,457" href="#" alt="경남" onclick="alert('준비중입니다.');" />
										      <area shape="poly" id="map09" class="map09" coords="471,482,459,480,458,486,451,486,445,477,435,476,425,476,417,478,416,486,409,494,409,498,404,504,407,506,415,508,418,514,426,514,427,519,432,525,439,527,443,528,448,528,453,534,456,540,461,525,461,509,461,501,464,501,470,501,471,488,471,482" href="#" alt="울산" onclick="alert('준비중입니다.');" />
										      <area shape="poly" id="map10" class="map10" coords="447,530,434,538,427,548,419,549,411,552,407,559,392,562,388,565,388,571,378,575,373,579,377,584,389,586,394,581,399,581,403,583,412,574,413,580,415,587,419,580,423,576,428,576,429,573,431,570,438,571,446,566,451,557,449,551,449,546,458,540,448,530" href="#" alt="부산" />
										      <area shape="poly" id="map11" class="map11" coords="155,749,143,753,130,751,121,753,111,759,101,760,95,764,93,772,95,775,96,782,96,785,102,787,108,792,116,789,125,791,137,791,147,789,159,785,172,784,176,776,179,770,179,766,173,754,166,750,155,749" href="#" alt="제주" onclick="alert('준비중입니다.');" />
										    </map>
										</div>
								  	 	<div class="spot_title"><img src="./images/main_summer/img_map_tit.png" alt="해수욕장 혼잡도 신호등" /></div>
									 </div>	
								  </div>
                                <div class="main_visual_content_cell_left">
                                  <p class="tit"><strong>슬기로운</strong> 해수욕장 이용</p> 
                                  <div class="reserv_lookup_box">
                                  	<div class="reserv_main_top">
                                    <img src="./images/main_summer/img_summer_text.png" alt="" />
                                    </div>
                                    <div class="reserv_main_bottom">
                                        <a href="/seantour_map/travel/reservation/area.do"><img src="./images/main_summer/img_main_reserv_pull.png" alt="" /></a>
                                    </div>
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
					    				<a href="/seantour_map/travel/destination/detail.do?destId=DEST000451">
						    				<span class="img"><img src="${pageContext.request.contextPath}/upload/travel/destination/2020061510462671170.jpg" alt="" /></span>
						    				<span class="text"><span class="local">[전북]</span>동호 해수욕장</span>
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