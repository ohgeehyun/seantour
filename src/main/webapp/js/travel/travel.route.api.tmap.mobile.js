/********일반 경로안내 - 경유지, 교통정보 포함 *********/
function getRouteUsingViaPoints(axisObj, viaPoints, trafficInfo) {

	// var apiUrl = "https://apis.openapi.sk.com/tmap/routes?version=1&format=json&callback=result";
	// var apiUrl = "https://apis.openapi.sk.com/tmap/routes?version=1&format=xml";
	var apiUrl = "https://apis.openapi.sk.com/tmap/routes/routeOptimization10?version=1&format=xml";
	
	map.setCenter(new Tmap.LonLat(String(axisObj.startX), String(axisObj.startY)).transform("EPSG:4326", "EPSG:3857"), 10);
	routeLayer = new Tmap.Layer.Vector("route");
	// map.addLayer(routeLayer);

	// var markerStartLayer = new Tmap.Layer.Markers("start");
	// var markerEndLayer = new Tmap.Layer.Markers("end");
	// var markerWaypointLayer = new Tmap.Layer.Markers("waypoint");
	markerStartLayer = new Tmap.Layer.Markers("start");
	markerEndLayer = new Tmap.Layer.Markers("end");
	markerWaypointLayer = new Tmap.Layer.Markers("waypoint");
	pointLayer = new Tmap.Layer.Vector("point");
	
	var startX = axisObj.startX;
	var startY = axisObj.startY;
	var endX = axisObj.endX;
	var endY = axisObj.endY;

	/*// 2. 시작, 도착 심볼찍기
	// 시작
	map.addLayer(markerStartLayer);

	var size = new Tmap.Size(24, 38);
	var offset = new Tmap.Pixel(-(size.w / 2), -size.h);
	var icon = new Tmap.IconHtml("<img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png' />", size, offset);
	var marker_s = new Tmap.Marker(new Tmap.LonLat(String(startX), String(startY)).transform("EPSG:4326", "EPSG:3857"), icon);
	markerStartLayer.addMarker(marker_s);

	// 도착
	map.addLayer(markerEndLayer);

	var size = new Tmap.Size(24, 38);
	var offset = new Tmap.Pixel(-(size.w / 2), -size.h); 
	var icon = new Tmap.IconHtml("<img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png' />", size, offset);
	var marker_e = new Tmap.Marker(new Tmap.LonLat(String(endX), String(endY)).transform("EPSG:4326", "EPSG:3857"), icon);
	markerEndLayer.addMarker(marker_e);*/

	// 3. 경유지 심볼 찍기
	map.addLayer(markerWaypointLayer);

	var size = new Tmap.Size(24, 38);
	var offset = new Tmap.Pixel(-(size.w / 2), -size.h);
	var icon;
	var marker;
	
	for (var i=0; i < viaPoints.length; i++) {
		icon = new Tmap.IconHtml("<img src='http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_"+(i+1)+".png' />", size, offset);
		marker = new Tmap.Marker(new Tmap.LonLat(String(viaPoints[i].viaX), String(viaPoints[i].viaY)).transform("EPSG:4326", "EPSG:3857"), icon);
		markerWaypointLayer.addMarker(marker);
	}

	// 4. 경유지 최적화 API 사용요청
	var prtcl;
	var headers = {}; 
	headers["appKey"] = appKey;
	headers["Content-Type"] = "application/json";

	var searchOption = "0";	//교통최적+추천
	// var searchOption = "1";	//교통최적+무료우선
	// var searchOption = "2";	//교통최적+최소시간
	// var searchOption = "3";	//교통최적+초보
	// var searchOption = "4";	//교통최적+고속도로우선
	// var searchOption = "10";	//최단거리+유/무료
	// var searchOption = "12";	//이륜차도로우선
	
	var paramObj = {
		"reqCoordType" : "WGS84GEO",
		"resCoordType" : "EPSG3857",
		"startName": "출발",
		"startX" : String(startX),
		"startY" : String(startY),
		"startTime": "201711121314",
		"endName": "도착",
		"endX" : String(endX),
		"endY" : String(endY),
		"searchOption" : "0"
		// "angle" : "172",
		// "trafficInfo" : trafficInfo //교통정보 표출 옵션입니다.
	};
	paramObj.viaPoints = viaPoints;
	var param = JSON.stringify(paramObj);
	// console.dir(param);

	$.ajax({
		method:"POST",
		headers : headers,
		url : apiUrl,
		async:false,
		data:param,
		beforeSend: function() {
			console.log("beforeSend....");
			/*if($('#wrap_loading').length > 0) {
				$('#wrap_loading').removeClass('display-none');
			}*/
		},
		success:function(response){
			// console.log(response);
			prtcl = response;

			// 5. 경유지 최적화 결과 Line 그리기 
			//경유지 최적화 결과 POINT 찍기
			/* -------------- Geometry.Point -------------- */
			// var pointLayer = new Tmap.Layer.Vector("point");
			// pointLayer = new Tmap.Layer.Vector("point");
			var prtclString = new XMLSerializer().serializeToString(prtcl);//xml to String	
		    xmlDoc = $.parseXML( prtclString ),
		    $xml = $( xmlDoc ),
		    $intRate = $xml.find("Placemark");
		    var style_red = {
				fillColor:"#FF0000",
				fillOpacity:1,
				strokeColor: "#FF0000",
				strokeWidth: 3,
				strokeDashstyle: "solid",
				pointRadius: 2,
				title: "this is a red line"
			};
		    $intRate.each(function(index, element) {
		    	var nodeType = element.getElementsByTagName("tmap:nodeType")[0].childNodes[0].nodeValue;
				if(nodeType == "POINT"){
					var point = element.getElementsByTagName("coordinates")[0].childNodes[0].nodeValue.split(',');
					var geoPoint =new Tmap.Geometry.Point(point[0],point[1]);
					var pointFeature = new Tmap.Feature.Vector(geoPoint, null, style_red); 
					pointLayer.addFeatures([pointFeature]);
				}
		    });
		    map.addLayer(pointLayer);

			var trafficColors = {
				extractStyles:true,

				/* 실제 교통정보가 표출되면 아래와 같은 Color로 Line이 생성됩니다. */
				trafficDefaultColor:"#000000", //Default
				trafficType1Color:"#009900", //원할
				trafficType2Color:"#8E8111", //지체
				trafficType3Color:"#FF0000"  //정체
			};    

			var kmlForm = new Tmap.Format.KML(trafficColors).readTraffic(prtcl);
			// routeLayer = new Tmap.Layer.Vector("vectorLayerID"); //백터 레이어 생성
			routeLayer.addFeatures(kmlForm); //교통정보를 백터 레이어에 추가   
			
			map.addLayer(routeLayer); // 지도에 백터 레이어 추가

		    /* -------------- Geometry.Point -------------- */
		    //경유지 최적화 결과 Line 그리기
			routeLayer.style ={
				fillColor:"#FF0000",
				fillOpacity:1,
				strokeColor: "#FF0000",
				strokeWidth: 3,
				strokeDashstyle: "solid",
				pointRadius: 2,
				title: "this is a red line"	
			}
			// var kmlForm = new Tmap.Format.KML().read(prtcl);
		 	//    routeLayer.addFeatures(kmlForm);
		
			// 6. 경유지 최적화 결과 반경만큼 지도 레벨 조정
			map.zoomToExtent(routeLayer.getDataExtent());

		},
		complete: function(){
			console.log("complete....");
			/*if($('#wrap_loading').length > 0) {
				$('#wrap_loading').addClass('display-none');
			}*/
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

}

/******* 마커 표시하기 *******/
function addMarkers(infoObj) {
	var size = new Tmapv2.Size(24, 38);
	if (infoObj.pointType == "P") size = new Tmapv2.Size(8, 8);

	var imgURL;
	if(infoObj.markerImage) {
		imgURL = infoObj.markerImage;
	} else {
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
				// imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
				imgURL = 'http://topopen.tmap.co.kr/imgs/point.png';
				break;
			default:
				break;
		};
		// if(infoObj.pointType == "P" && infoObj.pointNum) {
		if(infoObj.pointNum) {
			if(infoObj.pointNum > 0) {
				imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_'+infoObj.pointNum+'.png';
			} else {
				imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
			}
			size = new Tmapv2.Size(24, 38);
		}
	}

	var marker_p = new Tmapv2.Marker({
		position : new Tmapv2.LatLng(infoObj.lat, infoObj.lng),
		icon : imgURL,
		iconSize : size,
		map : map
	});

	resultMarkerArr.push(marker_p);
}

/** 기존에 생성된 마커, 팝업, 경로 삭제 **/
function clearMap() {
	if(resultDrawArr.length>0){
		for(var i in resultDrawArr){
			resultDrawArr[i].setMap(null);
		}
		resultDrawArr=[];
	}
	if(resultMarkerArr.length>0){
		for(var i in resultMarkerArr){
			resultMarkerArr[i].setMap(null);
		}
		resultMarkerArr=[];
	}
	if(infoWindowArr.length>0){
		for(var i in infoWindowArr){
			infoWindowArr[i].setMap(null);
		}
		infoWindowArr=[];
	}
}
