<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jnit.com.util.ApiKeyUtil" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0,user-scalable=no">
<style type="text/css">
html { height: 100% }
body { height: 100%; margin: 0; padding: 0 }
#map { width: 100%; height: 100% }
</style>
<title>Daum 로드뷰</title> 
<%
	String daumKey = ApiKeyUtil.getApiKey("daum");
	String naverKey = ApiKeyUtil.getApiKey("naver");
	String googleKey = ApiKeyUtil.getApiKey("google");
%>
<script type="text/javascript" src="<%=daumKey %>&libraries=services"></script>

<script type="text/javascript">


var mapLat = 0;
var mapLng = 0;
var exception = "${param.addr}";

function viewInit(){
	
	var position = new daum.maps.LatLng(mapLat,mapLng);
	
	var map = new daum.maps.Map(document.getElementById("map"), {
		center: position,
		level: 3,
		mapTypeId: daum.maps.MapTypeId.ROADMAP,
		scrollwheel: false
	});
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	var mapTypeControl = new daum.maps.MapTypeControl();
	map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
	
	var marker = new daum.maps.Marker({
		position: position
	});
	marker.setMap(map);
};

	function roadViewInit() {
		var p = new daum.maps.LatLng(mapLat, mapLng);
		var rc = new daum.maps.RoadviewClient();
		var rv = new daum.maps.Roadview(document.getElementById("roadview"));

		rc.getNearestPanoId(p, 50, function(panoid) {
			rv.setPanoId(panoid, p);
			rv.setViewpoint({ pan: 193.89769224010072, tilt: -3.1995186923686294, zoom: -3});
		});
	}
		


	/* $(document).ready(function(){
		$.ajax({
		url: "addr2latlng.jsp?q=${param.addr}",
		success:function(data){
			var addrJson = json_parse($.trim(data));

			if(parseInt(addrJson.channel.totalCount) > 0) {
				mapLat = addrJson.channel.item[0].lat;
				mapLng = addrJson.channel.item[0].lng;

				roadViewInit();
			}
		}
		});
	});
	*/
	
	var roadView = '${param.roadView}';
	var address = "${param.addr}";
	
	var geocoder = new daum.maps.services.Geocoder();
	geocoder.addressSearch(address, function(results, status) {
		if (status == daum.maps.services.Status.OK)  {
			mapLat = results[0].y;				
			mapLng = results[0].x;
			
			if(roadView == 'true'){				
				roadViewInit();
			}			
			viewInit();
		}else{/*지도생성 실패시*/}
	});
	
	
	
</script>
</head>

<%-- 
2013.05.24 수정
checkIn = 로드뷰 여부 (0 : 로드뷰 보이기 / 숨김 )  처리
ex) <c:url value="/roadview/?addr=${oldAddr0} ${oldAddr1}&checkIn=0"/> 
--%>

<body>
	<div id="map" style="width:100%;height:400px;"></div>
	<c:if test="${param.checkIn != '0' }">	
											
		<div id="roadview" style="width:100%;height:400px;"></div>
		<p class="warning">
			※ 해당 로드뷰는 “DAUM"에서 제공하고 있는 로드뷰로써, “DAUM"에서 제공하고 있지 않은 지역,주소에<br />
			경우 정상적으로 노출되지 않을수 있으며,일부 장소에 경우 아무런 데이터로딩을 하지 않을수 있습니다.<br />
			또한 로드뷰에 각도 및 방향 제어가 되지 않으며, 본 서비스는 “DAUM"에서 제공하고 있는 범위 내에서만 제공.
		</p>
		
	</c:if>	
</body>
</html>