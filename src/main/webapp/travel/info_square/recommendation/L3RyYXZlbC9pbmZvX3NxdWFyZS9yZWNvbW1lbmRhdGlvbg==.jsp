<% response.setHeader("Cache-Control","no-store"); response.setHeader("Pragma","no-cache"); response.setDateHeader("Expires",0); if (request.getProtocol().equals("HTTP/1.1")) { response.setHeader("Cache-Control", "no-cache"); } %><%@ page contentType="text/html; charset=utf-8" %><%@ include file='/_common/header.jsp' %><%@ include file='/travel/_tpls/B/TPL_000138_S.jsp' %><% /*<!-- [-CONTENT-] -->*/ %><div class="inr">
	            	<div class="inr">

	            	<div class="leafletBox2">
	            		<div class="map"><img src="/seantour_map/images/travel/content/img_leaflet02.jpg" alt="리플렛2" usemap="#Map2" /></div>
	            		<map name="Map2">
						  <area shape="circle" coords="351,2391,52" href="/seantour_map/travel/destination/detail.do?destId=FCID112459" alt="흑산도 진리해안길">
						  <area shape="circle" coords="553,2390,51" href="/seantour_map/travel/destination/detail.do?destId=FCID112445" alt="완도 신지명사길">
						  <area shape="circle" coords="755,2390,49" href="/seantour_map/travel/destination/detail.do?destId=FCID112460" alt="청산도슬로길">
						  <area shape="circle" coords="350,2562,51" href="/seantour_map/travel/destination/detail.do?destId=FCID112464" alt="보성해수욕장길">
						  <area shape="circle" coords="552,2563,51" href="/seantour_map/travel/destination/detail.do?destId=FCID112428" alt="남해다랭이길">
						  <area shape="circle" coords="759,2564,53" href="/seantour_map/travel/destination/detail.do?destId=FCID112437" alt="남해 물미해안도로">
						  <area shape="circle" coords="958,2560,52" href="/seantour_map/travel/destination/detail.do?destId=FCID001253" alt="고성 공룡화석지해변길">
						  <area shape="circle" coords="1158,2557,53" href="/seantour_map/travel/destination/detail.do?destId=FCID112443" alt="통영 수륙해안산책로">
						  <area shape="circle" coords="1365,2556,51" href="/seantour_map/travel/destination/detail.do?destId=FCID112436" alt="부산 몰운대길">
						  <area shape="circle" coords="348,2749,52" href="/seantour_map/travel/destination/detail.do?destId=FCID112443" alt="통영 수륙해안산책로">
						  <area shape="circle" coords="553,2754,51" href="/seantour_map/travel/destination/detail.do?destId=FCID112456" alt="부산 절영해안산책로">
						  <area shape="circle" coords="752,2754,52" href="/seantour_map/travel/destination/detail.do?destId=FCID112465" alt="부산 해안산책로">
						  <area shape="circle" coords="958,2754,52" href="/seantour_map/travel/destination/detail.do?destId=FCID112441" alt="울산 새천년로">
						  <area shape="circle" coords="1162,2752,51" href="/seantour_map/travel/destination/detail.do?destId=FCID112431" alt="울산 대왕암길">
						  <area shape="circle" coords="1362,2753,52" href="/seantour_map/travel/destination/detail.do?destId=FCID112470" alt="포항 호미곶새천년길">
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