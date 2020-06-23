<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000138_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div class="inr">
	<div class="leafletBox1">
		<div class="map"><img src="/seantour_map/images/travel/content/img_leaflet01_02.jpg" alt="리플렛1" usemap="#Map1" /></div>
		<map name="Map1">
	        <area shape="rect" coords="1141,2766,1312,2814" href="/seantour_map/travel/destination/detail.do?destId=FCID110815" alt="북분 해수욕장">
	        <area shape="rect" coords="1142,2304,1318,2352" href="/seantour_map/travel/destination/detail.do?destId=DEST000442" alt="노봉 해수욕장">
	        <area shape="rect" coords="1357,2144,1530,2192" href="/seantour_map/travel/destination/detail.do?destId=FCID110861" alt="사천 해수옥장">
	        <area shape="rect" coords="1356,2610,1548,2655" href="/seantour_map/travel/destination/detail.do?destId=DEST000444" alt="문암 해수욕장">
	        <area shape="rect" coords="1357,2558,1562,2605" href="/seantour_map/travel/destination/detail.do?destId=FCID111402" alt="원평 해수욕장">
	        <area shape="rect" coords="1142,2613,1324,2660" href="/seantour_map/travel/destination/detail.do?destId=FCID005317" alt="기지포 해수욕장">
	        <area shape="rect" coords="1141,2508,1326,2556" href="/seantour_map/travel/destination/detail.do?destId=FCID110062" alt="갈음이 해수욕장">
	        <area shape="rect" coords="1139,2404,1326,2452" href="/seantour_map/travel/destination/detail.do?destId=FCID000249" alt="난지섬 해수욕장">
	        <area shape="rect" coords="1141,2559,1323,2609" href="/seantour_map/travel/destination/detail.do?destId=FCID111418" alt="위도 해수욕장">
	        <area shape="rect" coords="1357,2506,1563,2554" href="/seantour_map/travel/destination/detail.do?destId=FCID110612" alt="모항 해수욕장">
	        <area shape="rect" coords="1357,2456,1528,2500" href="/seantour_map/travel/destination/detail.do?destId=FCID110257" alt="구시포 해수욕장">
	        <area shape="rect" coords="1356,2404,1542,2449" href="/seantour_map/travel/destination/detail.do?destId=FCID110361" alt="남열해돋이 해수욕장">
	        <area shape="rect" coords="1141,2354,1316,2400" href="/seantour_map/travel/destination/detail.do?destId=FCID111066" alt="송호 해수욕장">
	        <area shape="rect" coords="1359,2254,1569,2299" href="/seantour_map/travel/destination/detail.do?destId=FCID111284" alt="예송 해수욕장">
	        <area shape="rect" coords="1357,2199,1533,2247" href="/seantour_map/travel/destination/detail.do?destId=DEST000455" alt="짱뚱어 해수욕장">
	        <area shape="rect" coords="1356,2349,1536,2396" href="/seantour_map/travel/destination/detail.do?destId=FCID111071" alt="수문 해수욕장">
	        <area shape="rect" coords="1140,2201,1317,2251" href="/seantour_map/travel/destination/detail.do?destId=FCID003422" alt="홀통 해수욕장">
	        <area shape="rect" coords="1142,2663,1325,2710" href="/seantour_map/travel/destination/detail.do?destId=FCID000260" alt="기성망양 해수욕장">
	        <area shape="rect" coords="1142,2256,1318,2303" href="/seantour_map/travel/destination/detail.do?destId=FCID111510" alt="장사 해수욕장">
	        <area shape="rect" coords="1140,2821,1313,2865" href="/seantour_map/travel/destination/detail.do?destId=FCID110160" alt="경정 해수욕장">
	        <area shape="rect" coords="1140,2456,1326,2506" href="/seantour_map/travel/destination/detail.do?destId=FCID111319" alt="와현모래숲해변">
	        <area shape="rect" coords="1141,2871,1333,2920" href="/seantour_map/travel/destination/detail.do?destId=DEST000462" alt="옥계 해수욕장">
	        <area shape="rect" coords="1140,2716,1361,2764" href="/seantour_map/travel/destination/detail.do?destId=FCID111243" alt="여차해변 해수욕장">
	        <area shape="rect" coords="1140,2144,1317,2194" href="/seantour_map/travel/destination/detail.do?destId=DEST000464" alt="사량대항 해수욕장">
	        <area shape="rect" coords="1357,2301,1533,2344" href="/seantour_map/travel/destination/detail.do?destId=FCID110364" alt="남일대 해수욕장">
	        <area shape="rect" coords="1105,2990,1591,3157" href="${pageContext.request.contextPath}/images/travel/main/pull25.pdf" alt="한적한헤수욕장25선">
	      </map>               
	</div>
              <script src="/seantour_map/js/travel/jquery.rwdImageMaps.min.js"></script>
	<script>
		$(document).ready(function(e) {
			$('img[usemap]').rwdImageMaps();
		});
	</script>
              </div>
              </div><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000138_E.jsp' %>
