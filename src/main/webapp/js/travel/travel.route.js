var map
var marker_s, marekr_e, waypoint;
var resultMarkerArr = [];
var drawInfoArr = []; //경로그림정보
var resultInfoArr = [];
var thumb_img_path = "https://www.seantour.com";

String.prototype.replaceHtmlEntites = function() {
	var s = this;
	var translate_re = /&(nbsp|amp|quot|lt|gt);/g;
	var translate = {"nbsp": " ","amp" : "&","quot": "\"","lt"  : "<","gt"  : ">"};
	return ( s.replace(translate_re, function(match, entity) {
	  return translate[entity];
	}) );
};

function initTmap(){
	map = new Tmapv2.Map("map_wrap", {
		// center: new Tmapv2.LatLng(37.405278291509404, 127.12074279785197), // 최초 표시 좌표
		width : "100%",
		height : "100%",
		zoom : 14,
		zoomControl : true,
		scrollwheel : true,
		// scaleBar : true,
	});
}

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

function setPointAndDrawing(lat, lon, status, idx) {
	console.log("setPointAndDrawing.....");
	addMarkers({
		lng : lon,
		lat : lat,
		pointType : status
	});

	// var startAxis = document.getElementById("startAxis").value;
	// var destAxis = document.getElementById("destAxis").value;

	var startAddr = $("input.start_word").eq(idx-1).val();
	var endAddr = $("input.arrival_word").eq(idx-1).val();

	var axisObj = {};
	axisObj['startX'] = $("input.start_word").eq(idx-1).data('lon');
	axisObj['startY'] = $("input.start_word").eq(idx-1).data('lat');
	axisObj['endX'] = $("input.arrival_word").eq(idx-1).data('lon');
	axisObj['endY'] = $("input.arrival_word").eq(idx-1).data('lat');

	// TODO: 경유지 좌표인 경우 추가 분기할 필요가 있다
	// if (status != "S" && startAxis && destAxis) {
	if (status == "E" && startAddr && endAddr) {

		// 경유지(P) 관련 Marker는 경로 드로잉 이후 자동 생성되기에 생략
		/*addMarkers({
			lng : "126.91486146583102",
			lat : "37.520081165736414",
			pointType : "P"
		});*/
		var viaPoints = [];		
		var tab_con = $("#day_lst li div.tab_con").eq(idx-1);
		// tab_con.css("border", "1px solid red");
		var item = tab_con.find('ul.tab_list li:not(.list-group-item)');
	    item.each(function(index) {
	    	var viaObj = {};
			var lat = $(this).data('lat');
			// console.log("lat", lat);
			var lon = $(this).data('lon');
			// console.log("lon", lon);
			var pointId = $(this).data('destid');
			// var pointName = $(this).data('destname');
			viaObj['viaX'] = String(lon);
			viaObj['viaY'] = String(lat);
			viaObj['viaPointId'] = pointId;
			viaObj['viaPointName'] = pointId;

			viaPoints.push(viaObj);
	    });

		// getRP(startAxis, destAxis); // 출발-도착 단일 경로 드로잉 전용
		// getRouteSequential(startAxis, destAxis);
		if(item.length > 0) {
			getRouteSequential(axisObj, viaPoints);
		}

	} else {
		map.setCenter(new Tmapv2.LatLng(lat,lon));
		// map.setZoom(13);
	}
}


// function getRouteSequential(startAxis, destAxis) {
function getRouteSequential(axisObj, viaPoints) {
	var routeLayer; 

	// var start = startAxis.split(",");
	// var dest = destAxis.split(",");
	// var startX = start[1];
	// var startY = start[0];
	// var endX = dest[1];
	// var endY = dest[0];
	var startX = axisObj.startX;
	var startY = axisObj.startY;
	var endX = axisObj.endX;
	var endY = axisObj.endY;

	var headers = {}; 
	headers["appKey"]="l7xxdc2398be8423441f817695db47fd1e32";
	headers["Content-Type"]="application/json";
	
	/*var param = JSON.stringify({
		"startName" : "출발지",
		"startX" : String(startX),
		"startY" : String(startY),
		"startTime" : "201708081103",
		"endName" : "도착지",
		"endX" : String(endX),
		"endY" : String(endY),
		"viaPoints" : [
			{
				"viaPointId" : "test01",
				"viaPointName" : "name01",
				"viaX" : "126.91486146583102" ,
				"viaY" : "37.520081165736414" 
			},
		],
		"reqCoordType" : "WGS84GEO",
		"resCoordType" : "EPSG3857",
		"searchOption": "0"
	});*/
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


//경로안내 요청 함수
function getRP(startAxis, destAxis) {
	var start = startAxis.split(",");
	var dest = destAxis.split(",");
	var startX = start[1];
	var startY = start[0];
	var endX = dest[1];
	var endY = dest[0];

	var s_latlng = new Tmapv2.LatLng (startY, startX); // 37.553756, 126.925356
	var e_latlng = new Tmapv2.LatLng (endY, endX); // 37.554034, 126.975598
	

	// var passList = "127.04724656694417,37.524162226778515_127.10887300128256,37.5289781669373"; // temporary
	var passList = "126.91486146583102,37.520081165736414"; // temporary
	
	var optionObj = {
		startX : startX,
		startY : startY,
		endX : endX,
		endY : endY,
		reqCoordType:"WGS84GEO", // 요청 좌표계 옵셥 설정입니다.
		resCoordType:"WGS84GEO",  // 응답 좌표계 옵셥 설정입니다.
		// passList : passList, // passList를 사용한 다중경로안내 관련 API 버그가 있다
		angle : "172",
		searchOption : "0",
		trafficInfo:"Y"
	};

	var params = {
		onComplete: function() {
			console.log(this._responseData); //json으로 데이터를 받은 정보들을 콘솔창에서 확인할 수 있습니다.
		 
			var jsonObject = new Tmapv2.extension.GeoJSON();
			var jsonForm = jsonObject.rpTrafficRead(this._responseData);

			//교통정보 표출시 생성되는 LineColor 입니다.
		    var trafficColors = {

		        // 사용자가 임의로 색상을 설정할 수 있습니다.
		        // 교통정보 옵션 - 라인색상
		        trafficDefaultColor:"#000000", //교통 정보가 없을 때
		        trafficType1Color:"#009900", //원할
		        trafficType2Color:"#7A8E0A", //서행
		        trafficType3Color:"#8E8111",  //정체
		        trafficType4Color:"#FF0000"  //정체
		    };
		    jsonObject.drawRouteByTraffic(map, jsonForm, trafficColors);
			map.setCenter(new Tmapv2.LatLng(37.55676159947993,126.94734232774672));
			map.setZoom(13);
		},
		onProgress: function() {

		},
		onError: function() {
			alert("onError");
		}
	};
	
	// TData 객체 생성
	var tData = new Tmapv2.extension.TData();

	// TData 객체의 경로요청 함수
	tData.getRoutePlanJson(s_latlng, e_latlng, optionObj, params);
}

function searchAddress(status, idx){
	var pop = window.open("/travel/route/address.do?status="+status+"&idx="+idx,"pop","width=600,height=670, scrollbars=yes, resizable=yes");
}
function addrCallBack(roadFullAddr, latitude, longitude, status, idx){
	var addrObj;
	if (status == "E") {
		// document.getElementById("arrival_address").value = roadFullAddr;
		// document.getElementById("destAxis").value = latitude + ',' + longitude;
		addrObj = $("input.arrival_word").eq(idx-1);
	} else {
		// document.getElementById("start_address").value = roadFullAddr;
		// document.getElementById("startAxis").value = latitude + ',' + longitude;
		addrObj = $("input.start_word").eq(idx-1);
	}
	addrObj.val(roadFullAddr);
	addrObj.attr('data-lat', latitude);
	addrObj.attr('data-lon', longitude);
	
	setPointAndDrawing(latitude, longitude, status, idx);
}

function getDestinationDetail(idx) {
	// console.log("run discount");
	$.get('/travel/destination/retrieveDestinationDetail.do?destId='+idx, function(data) {
		// console.log(JSON.parse(data));
		var obj = JSON.parse(data);
		if(obj && obj.hasOwnProperty("destTitle")) {
			var bx_tit = obj.destTitle;
			var detail_txt = obj.destDescription;
			var info_slogan = '<li>'+obj.destAdSlogan+ ' ' +obj.destTitle+'</li>';
			var info_phone = '<li>전화번호 : '+obj.destPhone+'</li>';
			var info_addr = '<li>주소 : '+obj.destAddress+'</li>';
			var thumb_img = thumb_img_path + obj.destImgPath;

			$('#detail_info_area p.bx_tit').text(bx_tit);
			$('#detail_info_area div.info_lst > ul').empty();
			$('#detail_info_area div.info_lst > ul').append(info_slogan);
			$('#detail_info_area div.info_lst > ul').append(info_phone);
			$('#detail_info_area div.info_lst > ul').append(info_addr);
			$('#detail_info_area div.detail_txt').text(detail_txt.replace(/(<([^>]+)>)/ig,"").replaceHtmlEntites());
			$('#detail_info_area div.detail_txt').css('margin', '23px 25px');
			// $('#detail_info_area div.detailzone ul.lst li').empty();
			$('#detail_info_area div.detailzone ul.lst li img').attr("src", thumb_img);
			$('#detail_info_area div.detailzone ul.lst li img').attr("alt", bx_tit);
			$('#detail_info_area div.detailzone ul.lst li img').attr("width", 251);
			$('#detail_info_area div.detailzone ul.lst li img').attr("height", 210);

			$("#detail_info_area").show();
		}
	});
}

function getDestinationList(cate) {
   	if(!cate) {
   		var cate_name = {};
   		cate_name["관광"] = "관광지";
   		cate_name["숙박"] = "숙박";
   		cate_name["레져"] = "체험";
   		cate_name["식당"] = "음식점";
   		cate_name["쇼핑"] = "쇼핑";
   		$("a.cate-btn").each(function() {
   			if($(this).hasClass('on')) {
   				cate = $(this).text();
   			}
   		});
   		cate = cate_name[cate];
   	}

   	var reqUrl = "/travel/destination/retrieveDestinationList.do";
    var promise = getAsyncDataList(reqUrl, cate);
    promise.success(function (data) {
    	setDestinationList(data);
    });
}

function getAsyncDataList(reqUrl, cate) {
	var region = $("select[name='dest_region']").val();
	var formData = "destRegion=" + region + "&destCategory=" + cate;
		// console.log("formData", formData);
    return $.ajax({
        type: "GET"
        , url: reqUrl
        , data:formData
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , error: function(data, status, err) { 
            alert('서버와의 통신이 실패했습니다.');
        }
    });
}
function setDestinationList(data) {
	// console.log(data);
	var obj = JSON.parse(data);
	// console.log(obj.constructor); return;
    if(obj.constructor !== Array){
    	console.log("데이터를 가져오지 못했습니다."); return;
    }else{
        var lists = "";
    	for(var i=0; i<obj.length; i++) {
    		var destImgPath = obj[i]["destImgPath"] == null ? "https://seantour.com/seanfile/20170807/20170807185346259_0.jpg" : thumb_img_path + obj[i]["destImgPath"];
			// lists += "<li data-lat=\""+obj[i]["destLocationAxis"].split(',')[0]+"\"  data-lon=\""+obj[i]["destLocationAxis"].split(',')[1]+"\"  data-destid=\""+obj[i]["destId"]+"\">";
			lists += "<li data-lat=\""+obj[i]["destAxisY"]+"\"  data-lon=\""+obj[i]["destAxisX"]+"\"  data-destid=\""+obj[i]["destId"]+"\">";
			lists += "<div class=\"img\"><img src=\""+destImgPath+"\" alt='"+obj[i]["destTitle"]+"' /></div>";
			lists += "<div class=\"txt_box\">";
			lists += "<p class=\"txt\">"+obj[i]["destTitle"]+"</p>";
			lists += "<p class=\"sub\">"+obj[i]["destCategory"]+"</p>";
			lists += "<a href=\"javascript:;\" class=\"more\" onclick=\"getDestinationDetail('"+obj[i]["destId"]+"');\">더보기</a>";
			lists += "</div>";
			lists += "<div class=\"icon_box\">";
			lists += "<a href=\"#none\" class=\"ico_heart\">종아요</a>";
			lists += "<a href=\"javascript:;\" class=\"ico_add\" onclick=\"addPoint(this);\">추가</a>";
			lists += "<a href=\"javascript:;\" class=\"ico_close\" onclick=\"delPoint(this);\" class=\"ico_close\">닫기</a>";
			lists += "</div>";
			lists += "</li>";
		}
       	$("ul.result_list").empty();
       	$("ul.result_list").append(lists);
    }
}

function addPoint(obj) {
	var list_item = $(obj).parents("li");
	// console.log(list_item);
	// list_item.css("border", "2px solid red");
	/*var lat = list_item.data('lat');
	console.log("lat", lat);
	var lon = list_item.data('lon');
	console.log("lon", lon);*/

	list_item.clone().appendTo('#day_lst li div.tab_con:not([style*="display: none"]) ul.tab_list');
}

function delPoint(obj) {
	var list_item = $(obj).closest("li");
	// list_item.css("border", "2px solid red");
	list_item.remove();
}

function saveTravelRoute() {
	if(confirm("작성된 여행일정을 저장하시겠습니까?\n출발지,도착지와 한 개 이상의 경로를 입력한 일정만 저장됩니다.")) {

		var routTitle = $("#routTitle").val();
		var routRegMember;
		var routDays;
		var routRegion = $("select[name='dest_region']").val();
		var routStartPoint;
		var routDestPoint;
		var routDescription;
		var routStartAxis;
		var routDestAxis;
		var routGroup = $("#routGroup").val();

		$("#day_lst li div.tab_con").each(function(index) {
			var routObj = {};
			var startAddr = $(this).find("input.start_word").val();
			var endAddr   = $(this).find("input.arrival_word").val();
			
			var startX 	= $(this).find("input.start_word").data('lon');
			var startY 	= $(this).find("input.start_word").data('lat');
			var endX 	= $(this).find("input.arrival_word").data('lon');
			var endY 	= $(this).find("input.arrival_word").data('lat');

			var routId = $(this).find("ul.tab_list").data('routid');

			var item = $(this).find('ul.tab_list li:not(.list-group-item)');
			var description = "";
			routDays = index + 1;

		    item.each(function(idx) {
		    	if(idx > 0) description += "|";
				description += $(this).data('destid');
		    });

		    // 출발지 도착지 정보가 있고, 경유일정이 한 개 이상인 경우만 전송
		    if(startAddr && endAddr && item.length > 0) {
				routObj["routTitle"] = routTitle;
				// routObj["routRegMember"] = ;
				routObj["routDays"] = routDays;
				routObj["routRegion"] = routRegion;
				routObj["routStartPoint"] = startAddr;
				routObj["routDestPoint"] = endAddr;
				routObj["routDescription"] = description;
				routObj["routStartAxis"] = startY + "," + startX;
				routObj["routDestAxis"] = endY + "," + endX;

			   	var reqUrl = "/travel/route/insertAsync.do";
				if(routGroup) {
					routObj["routGroup"] = routGroup;
					if(routId) {
						reqUrl = "/travel/route/updateAsync.do";
						routObj["routId"] = routId;
					}
				}
			    	console.dir(routObj);
			    var promise = sendAsyncData(reqUrl, routObj);
			    promise.success(function (data) {
			    	console.log(data);
			    	var obj = JSON.parse(data);
			    	// $("#routGroup").val(obj.routGroup);
			    	alert(obj.title + " " + obj.days+"일차 일정을 저장하였습니다.");
			    });
			    promise.error(function(request,status,error){
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				});
		    }

		});
	
	}
}

function sendAsyncData(reqUrl, params) {
    return $.ajax({
        type: "POST"
        , url: reqUrl
        , data:params
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , error: function(data, status, err) { 
            alert('서버와의 통신이 실패했습니다.');
        }
    });
}

$(function(){

	// #day_lst li div.tab_con ul.tab_list li:not(.list-group-item)
	$('#day_lst li div.tab_con ul.tab_list').bind('DOMNodeInserted', function() {
	    // console.log($(this));
	    // $(this).find('li:not(.list-group-item)').css("border", "2px solid red");
	    var item = $(this).find('li:not(.list-group-item)');
	    var len = item.length - 1;
	    var show_lat, show_lon;
	    item.each(function(index) {
			var lat = $(this).data('lat');
			// console.log("lat", lat);
			var lon = $(this).data('lon');
			// console.log("lon", lon);
			
			addMarkers({
				lng : lon,
				lat : lat,
				pointType : "P",
				pointNum : index + 1
			});
			if(len == index) {
				show_lat = lat;
				show_lon = lon;
			}
			var tit = $(this).find('p.txt').text();
			var content = "<div style='position: relative; border-bottom: 1px solid #dcdcdc; line-height: 18px; padding: 3px; width: 150px; height: auto; text-align:center;'>"+
						  "<span style='font-size: 12px; line-height: 15px;'>"+tit+"</span>"+
						  "</div>";
			//Popup 객체 생성.
			infoWindow = new Tmapv2.InfoWindow({
				position: new Tmapv2.LatLng(lat,lon), //Popup 이 표출될 맵 좌표
				content: content, //Popup 표시될 text
				type: 2, //Popup의 type 설정.
				map: map //Popup이 표시될 맵 객체
			});


	    });
		map.setCenter(new Tmapv2.LatLng(show_lat,show_lon));
		map.setZoom(10);
	});

});