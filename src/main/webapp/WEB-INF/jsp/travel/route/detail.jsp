<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
	<!-- tmap api -->
	<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxdc2398be8423441f817695db47fd1e32"></script>
</head>
<body onload="initTmap()">
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
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
		            	<div class="map_route_wrap">
		            		<div class="map_route">
			            		<div class="map" id="map_wrap"></div>
			            	<c:forEach var="route" items="${resultList}" varStatus="status">
			            		<dl class="map_day_route">
			            			<dt class="on"><a href="javascript:;" onclick="initTmap(this);">DAY <c:out value="${route.routDays}" /></a></dt>
			            			<dd class="route_lst">
			            				<ul>
			            				<c:forEach var="dest" items="${route.routePointList}" varStatus="status">
			            					<li style="width:100%;"><span class="num"><c:out value="${status.count}"/></span><c:out value="${dest.destTitle}"/></li>
			            				</c:forEach>
			            				</ul>
			            			</dd>
			            		</dl>
			            	</c:forEach>
		            		</div>
			            	<div class="recommend_days_lst">
			            		<div class="tit_box">
			            			<p class="name"><c:out value="${resultList[0].routRegMemberNm}"/></p>
			            			<p class="tit"><c:out value="${resultList[0].routTitle}"/></p>
			            			<div class="info">
			            				<ul class="list">
			            					<li><c:out value="${resultList[0].routRegion}"/></li>
			            					<li><c:out value="${fn:length(resultList)-1}"/>박<c:out value="${fn:length(resultList)}"/>일</li>
			            				</ul>
			            				<%-- <p class="date">2020.03.02</p> --%>
			            				<p class="date">
			            					<fmt:parseDate value="${resultList[0].routRegDate}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss.S"/>
			            					<fmt:formatDate value="${parsedDate}" pattern="yyyy.MM.dd"/>
		            					</p>
			            			</div>
			            		</div>
			            	<c:forEach var="route" items="${resultList}" varStatus="status">
			            		<div class="re_days_area">
			            			<p class="day_num">DAY <c:out value="${route.routDays}" /></p>
			            			<ul class="list route-box" data-start-lat='<c:out value="${fn:split(route.routStartAxis,',')[0]}"/>' data-start-lon='<c:out value="${fn:split(route.routStartAxis,',')[1]}"/>' data-dest-lat='<c:out value="${fn:split(route.routDestAxis,',')[0]}"/>' data-dest-lon='<c:out value="${fn:split(route.routDestAxis,',')[1]}"/>'>
			            			<c:forEach var="dest" items="${route.routePointList}" varStatus="status">
										<li class="route-list" data-lat='<c:out value="${dest.destAxisY}"/>' data-lon='<c:out value="${dest.destAxisX}"/>' data-destid='<c:out value="${dest.destId}"/>'>
											<div class="img"><img src='http://seantour.com<c:out value="${dest.destImgPath}"/>' alt='<c:out value="${dest.destTitle}"/>' /></div>
											<div class="txt_box">
												<p class="tit"><c:out value="${dest.destTitle}"/></p>
												<div class="txt_area">
													<span class="local"><c:out value="${dest.destRegion}"/></span>
													<p class="txt"><c:out value="${fn:substring(dest.destDescription,0,60)}" escapeXml="false" /><c:if test="${fn:length(dest.destDescription) gt 60}">..</c:if></p>
												</div>
												<a href="#none" class="more">더보기</a>
											</div>
										</li>
									</c:forEach>
									</ul>
			            		</div>
			            	</c:forEach>
			            	</div>
		            	</div>
						<div class="btnArea tar">
							<%-- <a href="/travel/route/list.do" class="button border">목록</a> --%>
							<a href="<c:out value="${pageContext.request.getHeader('REFERER')}"/>" class="button border">목록</a>
						</div>
		             </div>  
	            </div><!-- cont_body -->
	        </div><!-- // cont_wrap -->
        </div>
        <!--// container -->
		
		<!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	<!-- // wrap -->
</body>
<style type="text/css">
.local_lst li .tbox .tit span {
	width: 60px;
}
#map_wrap {
	background: initial;
}
</style>
<script type="text/javascript">
var map
var marker_s, marekr_e, waypoint;
var resultMarkerArr = [];
var drawInfoArr = []; //경로그림정보
var resultInfoArr = [];
var thumb_img_path = "https://www.seantour.com";

function addMarkers(infoObj) {
	var size = new Tmapv2.Size(24, 38);
	// if (infoObj.pointType == "P") size = new Tmapv2.Size(8, 8);

	var imgURL;
	switch (infoObj.pointType) {
		case "S":
			// imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png';
			imgURL = 'http://topopen.tmap.co.kr/imgs/start.png';
			break;
		case "E":
			// imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png';
			imgURL = 'http://topopen.tmap.co.kr/imgs/arrival.png';
			break;
		case "P":
			imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
			break;
		default:
			break;
	};

	if(infoObj.pointType == "P" && infoObj.pointNum) {
		imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_'+infoObj.pointNum+'.png';
	}


	var marker_p = new Tmapv2.Marker({
		position : new Tmapv2.LatLng(infoObj.lat, infoObj.lng),
		icon : imgURL,
		iconSize : size,
		map : map
	});

	resultMarkerArr.push(marker_p);
}

function initTmap(obj){

	// var imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
	// var size = new Tmapv2.Size(24, 38);
	var idx = 0;
	if(obj) {
		idx = $(obj).closest('dl.map_day_route').index() - 1;
	}

	var axisObj = {};
	var route_box = $("ul.route-box");
	axisObj['startX'] = route_box.eq(idx).data("start-lon");
	axisObj['startY'] = route_box.eq(idx).data("start-lat");
	axisObj['endX'] = route_box.eq(idx).data("dest-lon");
	axisObj['endY'] = route_box.eq(idx).data("dest-lat");

	if(!obj) {
		map = new Tmapv2.Map("map_wrap", {
			center: new Tmapv2.LatLng(axisObj['startY'], axisObj['startX']),
			width : "446px",
			height : "437px",
			zoom : 10,
			// zoomControl : true,
			// scrollwheel : true,
			// scaleBar : true,
		});
	} else {

		console.log('lat', axisObj['startY']);
		console.log('lon', axisObj['startX']);
		map.setCenter(new Tmapv2.LatLng(axisObj['startY'], axisObj['startX']));
	}

	var viaPoints = [];		

	var item = route_box.find('li.route-list');
    item.each(function(index) {
    	var viaObj = {};
		var lat = $(this).data('lat');
		var lon = $(this).data('lon');

		var pointId = $(this).data('destid');

		viaObj['viaX'] = String(lon);
		viaObj['viaY'] = String(lat);
		viaObj['viaPointId'] = pointId;
		viaObj['viaPointName'] = pointId;

		viaPoints.push(viaObj);
    });

	if(item.length > 0) {
		getRouteSequential(axisObj, viaPoints);
	}

}

function getRouteSequential(axisObj, viaPoints) {
	var routeLayer; 

	var startX = axisObj.startX;
	var startY = axisObj.startY;
	var endX = axisObj.endX;
	var endY = axisObj.endY;

	var headers = {}; 
	headers["appKey"]="l7xxdc2398be8423441f817695db47fd1e32";
	headers["Content-Type"]="application/json";
	
	var paramObj = {
		"startName" : "출발지",
		"startX" : String(startX),
		"startY" : String(startY),
		"startTime" : "201708081103",
		"endName" : "도착지",
		"endX" : String(endX),
		"endY" : String(endY),
		"reqCoordType" : "WGS84GEO",
		"resCoordType" : "EPSG3857",
		"searchOption": "0"
	};
	paramObj.viaPoints = viaPoints;
	var param = JSON.stringify(paramObj);
	// console.dir(param);

	$.ajax({
		method:"POST",
		url:"https://apis.openapi.sk.com/tmap/routes/routeSequential30?version=1&format=json",//
		headers : headers,
		async:false,
		data:param,
		success:function(response){

			var resultData = response.properties;
			var resultFeatures = response.features;
			
			// 결과 출력
			/*var tDistance = "총 거리 : " + resultData.totalDistance + "km,  ";
			var tTime = "총 시간 : " + resultData.totalTime + "분,  ";
			var tFare = "총 요금 : " + resultData.totalFare + "원";
			
			$("#result").text(tDistance+tTime+tFare);*/
			
			//기존  라인 초기화
			if(resultInfoArr.length>0){
				for(var i in resultInfoArr){
					resultInfoArr[i].setMap(null);
				}
				resultInfoArr=[];
			}
			if(resultMarkerArr.length>0){
				for(var i in resultMarkerArr){
					resultMarkerArr[i].setMap(null);
				}
				resultMarkerArr=[];
			}
			
			for(var i in resultFeatures) {
				var geometry = resultFeatures[i].geometry;
				var properties = resultFeatures[i].properties;
				var polyline_;
				
				drawInfoArr = [];
				
				if(geometry.type == "LineString") {
					for(var j in geometry.coordinates){
						// 경로들의 결과값(구간)들을 포인트 객체로 변환 
						var latlng = new Tmapv2.Point(geometry.coordinates[j][0], geometry.coordinates[j][1]);
						// 포인트 객체를 받아 좌표값으로 변환
						var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlng);
						// 포인트객체의 정보로 좌표값 변환 객체로 저장
						var convertChange = new Tmapv2.LatLng(convertPoint._lat, convertPoint._lng);
						
						drawInfoArr.push(convertChange);
					}

					polyline_ = new Tmapv2.Polyline({
						path : drawInfoArr,
						strokeColor : "#FF0000",
						strokeWeight: 6,
						map : map
					});
					resultInfoArr.push(polyline_);
					
				}else{
					// console.log("geometry.type", geometry.type);
					
					// 경로들의 결과값들을 포인트 객체로 변환 
					var latlon = new Tmapv2.Point(geometry.coordinates[0], geometry.coordinates[1]);
					// 포인트 객체를 받아 좌표값으로 다시 변환
					var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlon);
				  	
					addMarkers({
						lng : convertPoint._lng,
						lat : convertPoint._lat,
						pointType : properties.pointType
					});
				}
			}
			map.setZoom(12);

		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function fn_egov_link_page(pageNo){
	document.getElementById("travelDestination").pageIndex.value = pageNo;
	document.getElementById("travelDestination").action = "<c:url value='/travel/destination/list.do'/>";
   	document.getElementById("travelDestination").submit();
}
</script>
</html>
