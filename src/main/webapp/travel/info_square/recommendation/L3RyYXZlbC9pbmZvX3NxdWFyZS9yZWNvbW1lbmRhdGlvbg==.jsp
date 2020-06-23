
<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000138_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div class="inr">

	            	<div class="leafletBox2">
	            		<div class="map"><img src="/seantour_map/images/travel/content/img_leaflet02_02.jpg" alt="리플렛2" usemap="#Map2" /></div>
	            		<map name="Map2">
  <area shape="rect" coords="524,1889,899,2212" href="/seantour_map/travel/destination/detail.do?destId=DEST000455" alt="짱뚱어해수욕장">
  <area shape="rect" coords="1404,1956,1615,1995" href="/seantour_map/travel/destination/detail.do?destId=FCID112459" alt="흑산도 진리해안길">
  <area shape="rect" coords="1405,1998,1614,2034" href="/seantour_map/travel/destination/detail.do?destId=FCID112445" alt="완도 신지명사길">
  <area shape="rect" coords="1405,2037,1580,2071" href="/seantour_map/travel/destination/detail.do?destId=FCID112460" alt="청산도슬로길">
  <area shape="rect" coords="535,2355,726,2392" href="/seantour_map/travel/destination/detail.do?destId=FCID112464" alt="보성해수욕장길">
  <area shape="rect" coords="535,2395,704,2430" href="/seantour_map/travel/destination/detail.do?destId=FCID112428" alt="남해다랭이길">
  <area shape="rect" coords="535,2434,749,2471" href="/seantour_map/travel/destination/detail.do?destId=FCID112437" alt="남해 물미해안도로">
  <area shape="rect" coords="534,2475,788,2513" href="/seantour_map/travel/destination/detail.do?destId=FCID001253" alt="고성 공룡화석지해변길">
  <area shape="rect" coords="535,2514,765,2551" href="/seantour_map/travel/destination/detail.do?destId=FCID112443" alt="통영 수륙해안산책로">
  <area shape="rect" coords="535,2553,702,2590" href="/seantour_map/travel/destination/detail.do?destId=FCID112436" alt="부산 몰운대길">
  <area shape="rect" coords="1403,2353,1636,2392" href="/seantour_map/travel/destination/detail.do?destId=FCID112443" alt="통영 수륙해안산책로">
  <area shape="rect" coords="1404,2396,1635,2432" href="/seantour_map/travel/destination/detail.do?destId=FCID112456" alt="부산 절영해안산책로">
  <area shape="rect" coords="1404,2434,1596,2470" href="/seantour_map/travel/destination/detail.do?destId=FCID112465" alt="부산 해안산책로">
  <area shape="rect" coords="1404,2471,1574,2512" href="/seantour_map/travel/destination/detail.do?destId=FCID112441" alt="울산 새천년로">
  <area shape="rect" coords="1405,2513,1574,2549" href="/seantour_map/travel/destination/detail.do?destId=FCID112431" alt="울산 대왕암길">
  <area shape="rect" coords="1405,2551,1638,2592" href="/seantour_map/travel/destination/detail.do?destId=FCID112470" alt="포항 호미곶새천년길">
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