<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000138_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div class="inr">
	<div class="leafletBox1">
		<div class="map"><img src="/seantour_map/images/travel/content/img_leaflet01_01.jpg" alt="리플렛1" usemap="#Map1" /></div>
		<div class="map"><img src="/seantour_map/images/travel/content/img_leaflet01_02.jpg" alt="리플렛2" usemap="#Map1" /></div>
		<div class="map"><img src="/seantour_map/images/travel/content/img_leaflet01_03.jpg" alt="리플렛3" usemap="#Map1" /></div>
		<%-- <map name="Map1">
	        <area shape="rect" coords="1140,2144,1317,2194" href="/seantour_map/travel/destination/detail.do?destId=DEST000441" alt="북분 해수욕장">
	        <area shape="rect" coords="1140,2201,1317,2251" href="/seantour_map/travel/destination/detail.do?destId=DEST000442" alt="노봉 해수욕장">
	        <area shape="rect" coords="1142,2256,1318,2303" href="/seantour_map/travel/destination/detail.do?destId=DEST000443" alt="사천 해수옥장">
	        <area shape="rect" coords="1142,2303,1318,2351" href="/seantour_map/travel/destination/detail.do?destId=DEST000444" alt="문암 해수욕장">
	        <area shape="rect" coords="1141,2353,1316,2399" href="/seantour_map/travel/destination/detail.do?destId=DEST000471" alt="원평 해수욕장">
	        <area shape="rect" coords="1139,2404,1326,2452" href="/seantour_map/travel/destination/detail.do?destId=DEST000446" alt="기지포 해수욕장">
	        <area shape="rect" coords="1140,2456,1326,2506" href="/seantour_map/travel/destination/detail.do?destId=DEST000447" alt="갈음이 해수욕장">
	        <area shape="rect" coords="1141,2508,1326,2556" href="/seantour_map/travel/destination/detail.do?destId=DEST000448" alt="난지섬 해수욕장">
	        <area shape="rect" coords="1141,2559,1323,2609" href="/seantour_map/travel/destination/detail.do?destId=DEST000449" alt="위도 해수욕장">
	        <area shape="rect" coords="1142,2614,1324,2661" href="/seantour_map/travel/destination/detail.do?destId=DEST000450" alt="모항 해수욕장">
	        <area shape="rect" coords="1142,2663,1325,2710" href="/seantour_map/travel/destination/detail.do?destId=DEST000451" alt="구시포 해수욕장">
	        <area shape="rect" coords="1140,2716,1361,2764" href="/seantour_map/travel/destination/detail.do?destId=DEST000452" alt="남열해돋이 해수욕장">
	        <area shape="rect" coords="1141,2766,1312,2814" href="/seantour_map/travel/destination/detail.do?destId=DEST000453" alt="송호 해수욕장">
	        <area shape="rect" coords="1140,2821,1313,2865" href="/seantour_map/travel/destination/detail.do?destId=DEST000454" alt="예송 해수욕장">
	        <area shape="rect" coords="1141,2866,1333,2915" href="/seantour_map/travel/destination/detail.do?destId=DEST000455" alt="짱뚱어 해수욕장">
	        <area shape="rect" coords="1357,2144,1530,2192" href="/seantour_map/travel/destination/detail.do?destId=DEST000456" alt="수문 해수욕장">
	        <area shape="rect" coords="1357,2198,1533,2246" href="/seantour_map/travel/destination/detail.do?destId=DEST000457" alt="홀통 해수욕장">
	        <area shape="rect" coords="1359,2254,1569,2299" href="/seantour_map/travel/destination/detail.do?destId=DEST000458" alt="기성망양 해수욕장">
	        <area shape="rect" coords="1357,2301,1533,2344" href="/seantour_map/travel/destination/detail.do?destId=DEST000459" alt="장사 해수욕장">
	        <area shape="rect" coords="1357,2349,1537,2396" href="/seantour_map/travel/destination/detail.do?destId=DEST000460" alt="경정 해수욕장">
	        <area shape="rect" coords="1356,2404,1542,2449" href="/seantour_map/travel/destination/detail.do?destId=DEST000461" alt="와현모래숲해변">
	        <area shape="rect" coords="1358,2456,1529,2500" href="/seantour_map/travel/destination/detail.do?destId=DEST000462" alt="옥계 해수욕장">
	        <area shape="rect" coords="1357,2506,1563,2554" href="/seantour_map/travel/destination/detail.do?destId=DEST000463" alt="여차해변 해수욕장">
	        <area shape="rect" coords="1357,2558,1562,2605" href="/seantour_map/travel/destination/detail.do?destId=DEST000464" alt="사량대항 해수욕장">
	        <area shape="rect" coords="1356,2610,1548,2655" href="/seantour_map/travel/destination/detail.do?destId=DEST000465" alt="남일대 해수욕장">
	        <area shape="rect" coords="1105,2989,1591,3156" href="${pageContext.request.contextPath}/images/travel/main/pull25.pdf" alt="한적한헤스역징25선">
	      </map>  --%>              
	</div>
              <script src="/seantour_map/js/travel/jquery.rwdImageMaps.min.js"></script>
	<script>
		$(document).ready(function(e) {
			$('img[usemap]').rwdImageMaps();
		});
	</script>
              </div><% /*<!-- /[-CONTENT-] -->*/ %><%@ include file='/travel/_tpls/B/TPL_000138_E.jsp' %>
