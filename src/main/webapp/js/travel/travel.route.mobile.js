var map
var infoWindowArr = []; //팝업
var resultMarkerArr = []; //마커
var resultDrawArr = []; //폴리라인
var drawInfoArr = []; //경로그림정보
var checkTraffic = []; //트래픽설정정보

var routeLayer;
var pointLayer;
var markerStartLayer;
var markerEndLayer;
var markerWaypointLayer;

//var thumb_img_path = "https://www.seantour.com";
var thumb_img_path = "";

String.prototype.replaceHtmlEntites = function() {
	var s = this;
	var translate_re = /&(nbsp|amp|quot|lt|gt);/g;
	var translate = {"nbsp": " ","amp" : "&","quot": "\"","lt"  : "<","gt"  : ">"};
	return ( s.replace(translate_re, function(match, entity) {
	  return translate[entity];
	}) );
};

function initTmap(){
	map = new Tmap.Map({
		div:'map_wrap',
		width : "100%",
		height : "730px",
	});
	map.setCenter(new Tmap.LonLat("127.73019333", "37.88459763").transform("EPSG:4326", "EPSG:3857"), 15);
}

function setMapCenter(regionMap) {
	var lon, lat;
	if(regionMap) {
		var region = regionMap.split(',');
		if(region.length > 0) {
			lon = String(region[1]);
			lat = String(region[0]);
		}
	}
	if(map && lon && lat) {
		// map.setCenter(new Tmapv2.LatLng(lat,lon));
		map.setCenter(new Tmap.LonLat(lon, lat).transform("EPSG:4326", "EPSG:3857"), 12);
	}
}

function setPointAndDrawRoutes(lat, lon, status, idx) {
	// console.log("setPointAndDrawRoutes.....");
	addMarkers({
		lng : lon,
		lat : lat,
		pointType : status
	});

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

		var viaPoints = [];		
		var tab_con = $("#day_lst li div.tab_con").eq(idx-1);
		// tab_con.css("border", "1px solid red");
		var item = tab_con.find('ul.tab_list li:not(.list-group-item)');
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
			getRouteUsingViaPoints(axisObj, viaPoints, "Y"); //일반 경로안내 - 경유지, 교통정보 포함
			// getRouteSequential(axisObj, viaPoints); //다중 경유지 30 - 무료서비스에서 일일트래픽 100건 제한
		}

	} else {
		map.setCenter(new Tmapv2.LatLng(lat,lon));
		// map.setZoom(13);
	}
}

function searchAddress(status, idx){
	// var pop = window.open(contextPath+"/travel/route/address.do?status="+status+"&idx="+idx,"pop","width=600,height=670, scrollbars=yes, resizable=yes");
	var pop = window.open(contextPath+"/travel/route/searchpoint.do?status="+status+"&idx="+idx,"pop","width=600,height=670, scrollbars=yes, resizable=yes");
}

function addrCallBack(roadFullAddr, latitude, longitude, status, idx){
	var addrObj;
	if (status == "E") {
		addrObj = $("input.arrival_word").eq(idx-1);
	} else {
		addrObj = $("input.start_word").eq(idx-1);
	}
	addrObj.val(roadFullAddr);
	addrObj.attr('data-lat', latitude);
	addrObj.attr('data-lon', longitude);
	
	// setPointAndDrawRoutes(latitude, longitude, status, idx);
}

function setDestinationSticky(destAxisY, destAxisX, destTitle) {
	var infoObj = {};
	infoObj.lon = destAxisX;
	infoObj.lat = destAxisY;
	// infoObj.pointType = "P";
	infoObj.pointNum = "0";
	infoObj.infoWinTitle = destTitle;
	setPointSticky(infoObj);
}

function getDestinationDetail(idx) {
	// console.log("run discount");
	$.get(contextPath+'/travel/destination/retrieveDestinationDetail.do?destId='+idx, function(data) {
		// console.log(JSON.parse(data));
		var obj = JSON.parse(data);
		if(obj && obj.hasOwnProperty("destTitle")) {
			var bx_tit = obj.destTitle;
			var detail_txt = obj.destInformation;
			var info_slogan = '<li>'+obj.destAdSlogan+ ' ' +obj.destTitle+'</li>';
			var info_phone = '<li>전화번호 : '+obj.destPhone+'</li>';
			var info_addr = '<li>주소 : '+obj.destAddress+'</li>';
			// var thumb_img = thumb_img_path + obj.destImgPath;
			var thumb_img = obj.destImgPath;
			if(obj.travelFileList && obj.travelFileList.length > 0) {
				thumb_img = obj.travelFileList[0].imgFilePath;
			}

			$('#detail_info_area p.bx_tit').text(bx_tit);
			$('#detail_info_area div.info_lst > ul').empty();
			$('#detail_info_area div.info_lst > ul').append(info_slogan);
			$('#detail_info_area div.info_lst > ul').append(info_phone);
			$('#detail_info_area div.info_lst > ul').append(info_addr);
			if(detail_txt == null || !detail_txt) {
				$('#detail_info_area div.detail_txt').text('');
			} else {
				$('#detail_info_area div.detail_txt').text(detail_txt.replace(/(<([^>]+)>)/ig,"").replaceHtmlEntites());
			}
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

function getClipDestinationList(page) {
	var pageNo = 1;
	if(page) pageNo = page;

	var clipUserId = $("#routRegMember").val();
	if(!clipUserId) {
		alert("회원전용 서비스 입니다.\n서비스 후에 이용해 주세요");
		location.replace(contextPath+"/travel/login.jsp");
	} else {
	   	var reqUrl = contextPath+"/travel/member/retrieveClipDestinationList.do";
		var formData = "clipUserId=" + clipUserId + "&pageIndex=" + pageNo;
	    var promise = getAsyncDataList(reqUrl, formData);
	    promise.success(function (data) {
	    	setDestinationList(data, "getClipDestinationList");
	    });
	}
}

function changeDestinationRegion() {
	
	var region = $("select[name='dest_region']").val();
	var regionMap = {};
	regionMap["전국"] = "37.57478653,126.97629877";
	regionMap["서울"] = "37.56689860,126.97871544";
	regionMap["부산"] = "35.18040366,129.07442867";
	regionMap["대구"] = "35.87115048,128.60183986";
	regionMap["인천"] = "37.45512894,126.70524350";
	regionMap["대전"] = "36.35085161,127.38340705";
	regionMap["광주"] = "35.15900570,126.85309637";
	regionMap["울산"] = "35.53872897,129.31087034";
	regionMap["세종"] = "36.47961296,127.28882869";
	regionMap["경기"] = "37.27368317,127.00969309";
	regionMap["강원"] = "37.88459763,127.73019333";
	regionMap["충북"] = "36.63473768,127.49158403";
	regionMap["충남"] = "36.66044249,126.67207373";
	regionMap["전북"] = "35.82090728,127.11047329";
	regionMap["전남"] = "34.81659334,126.46055615";
	regionMap["경북"] = "36.57509648,128.50877263";
	regionMap["경남"] = "35.23641812,128.69107168";
	regionMap["제주"] = "33.48854781,126.49866722";

	setMapCenter(regionMap[region]);
	
	getDestinationList('1');
}

function getDestinationList(page, cate, tag_list) {
	var pageNo = 1;
	if(page) pageNo = page;

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

	if(!tag_list) {
		$("ul.lst li label input[type=checkbox]").each(function() {
			$(this).prop('checked', false);
		});
	}

   	var reqUrl = contextPath+"/travel/destination/retrieveDestinationList.do";
	var region = $("select[name='dest_region']").val();
	var formData = "destRegion=" + region + "&destCategory=" + cate + "&pageIndex=" + pageNo + "&pageUnit=5&pageSize=5";
	if(tag_list) {
		formData += "&destTag=" + tag_list;
	}
    var promise = getAsyncDataList(reqUrl, formData);
    promise.success(function (data) {
    	setDestinationList(data);
    });
}

function getAsyncDataList(reqUrl, formData) {
	// console.log("formData", formData);
    return $.ajax({
        type: "GET"
        , url: reqUrl
        , data:encodeURI(formData)
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , error: function(data, status, err) { 
            alert('서버와의 통신이 실패했습니다.');
        }
    });
}

function setDestinationList(data, paginationType) {
	// console.log(data); return;
	var obj = JSON.parse(data);
	// console.log(obj.constructor); return;
    // if(obj.constructor !== Array){
    if(obj.constructor !== Object){
    	console.log("데이터를 가져오지 못했습니다."); return;
    }else{
        var lists = "";
        var dest = obj.resultList;
    	for(var i=0; i<dest.length; i++) {
			lists += "<li data-lat=\""+dest[i]["destAxisY"]+"\" data-lon=\""+dest[i]["destAxisX"]+"\" data-destid=\""+dest[i]["destId"]+"\">";
			lists += "<div class=\"day_box\">";
			lists += "<a href=\"#none\" class=\"tbox\">";
			lists += "<span class=\"sub\">"+dest[i]["destCategory"]+"</span>";
			lists += "<span class=\"txt\">"+dest[i]["destTitle"]+"</span>";
			lists += "</a>";
			lists += "<div class=\"mob_detail_info_area\" style=\"display:none;\">";
			lists += "<div class=\"tit_box\">";
			lists += "<p>상세정보</p>";
			lists += "</div>";
			lists += "<div class=\"info_lst\">";
			lists += "<ul>";
			lists += "<li>전화번호 : "+dest[i]["destPhone"]+"</li>";
			lists += "<li>주소 : "+dest[i]["destAddress"]+"</li>";
			lists += "<li>명칭 : "+dest[i]["destTitle"]+"</li>";
			lists += "</ul>";
			lists += "</div>";
			lists += "<div class=\"detail_txt\">"+(dest[i]["destInformation"] == null ? '' : dest[i]["destInformation"])+"</div>";
			lists += "</div>";
			lists += "<a href=\"javascript:;\" class=\"ico_add mob_plus\" onclick=\"addPoint(this);\">선택</a>";
			lists += "</div>";
			lists += "</li>";
		}
       	$("#result_list").empty();
       	$("#result_list").append(lists);
		//pagination
       	setPaginationInfo(obj.paginationInfo, paginationType);
    }
}

function setPaginationInfo(pageInfo, paginationType) {
	var pageSize = pageInfo.pageSize;
   	var totalPageCount = pageInfo.totalPageCount;
   	var currentPageNo = pageInfo.currentPageNo;
   	var firstPageNo = pageInfo.firstPageNo;
   	var startPageNoOnList = pageInfo.firstPageNoOnPageList;
   	var lastPageNoOnList = pageInfo.lastPageNoOnPageList;
   	var lastPageNo = pageInfo.lastPageNo;

   	var pageNavFuntion = "getDestinationList";
   	if(paginationType) {
   		pageNavFuntion = paginationType;
   	}

   	var pageEl = "";
	pageEl += "<div class=\"pagination\">";
	// if(startPageNoOnList > firstPageNo) { //원래 이게 맞는데 기존 전자정부 pagination 논리오류에 따른 표기오류결과와 UI를 맞추기 위해 아래와 같이 수정함
	if(totalPageCount > pageSize) {
		pageEl += "<a href=\"?pageIdx="+firstPageNo+"\" onclick=\""+pageNavFuntion+"("+firstPageNo+"); return false;\" title=\"처음페이지\" class=\"page_prevend\"><span>처음</span></a>&nbsp;";
		pageEl += "<a href=\"?pageIdx="+(currentPageNo-1)+"\" onclick=\""+pageNavFuntion+"("+(currentPageNo-1)+"); return false;\" title=\"이전페이지\" class=\"page_prev\"><span>이전</span></a>&nbsp;";
	}
   	for(var no=startPageNoOnList; no<=lastPageNoOnList; no++) {
   		if(currentPageNo == no) {
			pageEl += "<strong title=\"현재페이지\">"+currentPageNo+"</strong>&nbsp;";
   		} else {
			pageEl += "<a href=\"?pageIdx="+no+"\" onclick=\""+pageNavFuntion+"("+no+"); return false;\" title=\""+no+"페이지\">"+no+"</a>&nbsp;";
   		}
	}
	// if(lastPageNoOnList < lastPageNo) { //원래 이게 맞는데 기존 전자정부 pagination 논리오류에 따른 표기오류결과와 UI를 맞추기 위해 아래와 같이 수정함
	if(totalPageCount > pageSize) {
		pageEl += "<a href=\"?pageIdx="+(currentPageNo+1)+"\" onclick=\""+pageNavFuntion+"("+(currentPageNo+1)+"); return false;\" title=\"다음페이지\" class=\"page_next\"><span>다음</span></a>&nbsp;";
		pageEl += "<a href=\"?pageIdx="+lastPageNo+"\" onclick=\""+pageNavFuntion+"("+lastPageNo+"); return false;\" title=\"마지막페이지\" class=\"page_nextend\"><span>마지막</span></a>";
	}
	pageEl += "</div>";
	$("div.pagination").empty().append(pageEl);
}

function launchMap() {
	$("#wizard").steps('next');
	$("#wizard").steps('next');


	// if (status == "E" && startAddr && endAddr) {
		var axisObj = {};
		var viaPoints = [];		
		var item = $("dl.day_sc:visible");
		var len = item.length;
	    item.each(function(index) {
			
	    	if(index == 0) {
				var start_lat = $(this).find("input.start_word").data('lat');
				var start_lon = $(this).find("input.start_word").data('lon');
				/*viaPoints.push({
					"viaX" : String(start_lon),
					"viaY" : String(start_lat)
				});*/
				axisObj['startX'] = start_lon;
				axisObj['startY'] = start_lat;
	    	}

			item.find("ul.day_list li").each(function() {
				var lat = $(this).data('lat');
				var lon = $(this).data('lon');
				var pointId = $(this).data('destid');
				viaPoints.push({
					"viaX" : String(lon),
					"viaY" : String(lat),
					"viaPointId" : pointId,
					"viaPointName" : pointId,
					// "viaTime": 600
				});
			});

			if(index == (len-1)) {
				var arrival_lat = $(this).find("input.arrival_word").data('lat');
				var arrival_lon = $(this).find("input.arrival_word").data('lon');
				/*viaPoints.push({
					"viaX" : String(arrival_lon),
					"viaY" : String(arrival_lat)
				});*/
				axisObj['endX'] = arrival_lon;
				axisObj['endY'] = arrival_lat;
			}

	    });

		if(item.length > 0) {
			getRouteUsingViaPoints(axisObj, viaPoints, "Y"); //일반 경로안내 - 경유지, 교통정보 포함
			// getRouteSequential(axisObj, viaPoints); //다중 경유지 30 - 무료서비스에서 일일트래픽 100건 제한
		}

	// }

}

function addDayInput() {
	var idx = $('.day_sc').index($('.day_sc:visible').last());
	// console.log(idx);
	var obj = $('.day_sc').eq(idx+1);
	if(idx < 6) {
		$(obj).show();
		$(obj).find('dd.day_area').show();
		animateScroll(obj);
	} else {
		// console.log('last');
		return;
	}
}

function searchPoint(idx) {
	$("#wizard").steps('next');

	$('.day_sc').each(function(index) {
		if(index == (idx-1)) {
			$(this).addClass("on");
		} else {
			$(this).removeClass("on");
		}
	});
}

function addPoint(obj) {
	// console.log(obj);	
	var destObj;
	var len;
	$('.day_sc').each(function(index) {
		if($(this).hasClass("on")) {
			len = $(this).find("ul.day_list li").length + 1;
			destObj = $(this).find("ul.day_list");
			// $(this).css('border', '1px solid red');
		}
	});

	if(destObj) {
		var day_box = $(obj).closest("div.day_box")
		var cate = day_box.find("span.sub").text();
		var title = day_box.find("span.txt").text();
		var liObj = $(day_box).closest("li");
		var lat = $(liObj).data("lat");
		var lon = $(liObj).data("lon");
		var destid = $(liObj).data("destid");


		var lists = "";
		lists += "<li data-lat=\""+lat+"\" data-lon=\""+lon+"\" data-destid=\""+destid+"\">";
		lists += "<span class=\"num\">"+len+"</span>";
		lists += "<div class=\"day_box\">";
		lists += "<a href=\"#none\" class=\"tbox\">";
		lists += "<span class=\"sub\">"+cate+"</span>";
		lists += "<span class=\"txt\">"+title+"</span>";
		lists += "</a>";
		lists += "<a href=\"javascript:;\" onclick=\"delPoint(this);\" class=\"delect\">삭제</a>";
		lists += "</div>";
		lists += "</li>";
		// console.log(lists);
		destObj.append(lists);

		$("#wizard").steps('previous');

		animateScroll(destObj);
	}

}

function delPoint(obj) {
	$(obj).closest("li").remove();
}

function animateScroll(obj) {
	var offset = $(obj).offset();
	$('html, body').animate({scrollTop : offset.top}, 400);
	// $(document).scrollTop($(document).height()+500);
}

function saveTravelRoute() {
	if(!$("#routRegMember").val()) {
		alert('회원 전용 서비스 입니다.\n로그인 후 이용해 주세요');
		location.replace(contextPath+'/travel/login.jsp');
		return false;
	}

	if(!$("#routTitle").val()) {
		alert("여행일정 제목을 입력해 주세요");
		$("#routTitle").focus();
		return false;
	}

	if(confirm("작성된 여행일정을 저장하시겠습니까?\n출발지,도착지와 한 개 이상의 경로를 입력한 일정만 저장됩니다.")) {

		var travelRouteObj = {};
		var routId = $("#routId").val();
		var routTitle = $("#routTitle").val();
		// var routRegMember;
		var routRegion = $("select[name='dest_region']").val();
		var routMemo = $("#routMemo").val();
		var routeDailyList = [];

		travelRouteObj["routTitle"] = routTitle;
		travelRouteObj["routRegion"] = routRegion;
		travelRouteObj["routMemo"] = routMemo;

		$("dl.day_sc").each(function(index) {
			var routDays;
			var routStartPoint;
			var routStartAxis;
			var routDestPoint;
			var routDestAxis;
			var routWayPoint;

			var startAddr = $(this).find("input.start_word").val();
			var endAddr   = $(this).find("input.arrival_word").val();
			
			var startX 	= $(this).find("input.start_word").data('lon');
			var startY 	= $(this).find("input.start_word").data('lat');
			var endX 	= $(this).find("input.arrival_word").data('lon');
			var endY 	= $(this).find("input.arrival_word").data('lat');

			var item = $(this).find('ul.day_list li');
			var wayPoint = "";
			routDays = index + 1;

		    item.each(function(idx) {
		    	if(idx > 0) wayPoint += "|";
				wayPoint += $(this).data('destid');
		    });

		    // 출발지 도착지 정보가 있고, 경유일정이 한 개 이상인 경우만 전송
		    if(startAddr && endAddr && item.length > 0) {
				/*js 와 java 간 json object 인식방식 차이로 아래와 같이 작성함*/
				travelRouteObj["routeDailyList["+ index +"].routDays"] = routDays;
				travelRouteObj["routeDailyList["+ index +"].routStartPoint"] = startAddr;
				travelRouteObj["routeDailyList["+ index +"].routStartAxis"] = startY + "," + startX;
				travelRouteObj["routeDailyList["+ index +"].routDestPoint"] = endAddr;
				travelRouteObj["routeDailyList["+ index +"].routDestAxis"] = endY + "," + endX;
				travelRouteObj["routeDailyList["+ index +"].routWayPoint"] = wayPoint;
		    }
		});

	   	var reqUrl = contextPath+"/travel/route/insertAsync.do";
		if(routId) {
			travelRouteObj["routId"] = routId;
			reqUrl = contextPath+"/travel/route/updateAsync.do";
		}
	    	// console.dir(travelRouteObj);
	    // var params = JSON.stringify(travelRouteObj);
	    var promise = sendAsyncData(reqUrl, travelRouteObj);
	    promise.success(function (data) {
	    	// console.log(data);
	    	var obj = JSON.parse(data);
	    	var actionName = "저장";
	    	if(routId) {
	    		actionName = "수정";
	    	}
			alert(obj.title + " " + "일정을 "+ actionName +"하였습니다.");
			location.replace(contextPath+'/travel/member/myroute.do');
	    });
	    promise.error(function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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

function initRegisterLayer() {
	location.reload();
}

function delDailyLayer() {
	// $("#day_lst ul li:visible").last().css('border', '1px solid red');
	var dayObj = $("#day_lst>ul>li:visible").last();
	dayObj.find("div.tab_con ul.tab_list").empty();
	dayObj.find("div.tab_con input[type=text]").each(function(){
		// $(this).css('background-color', 'yellow');
		$(this).val('');
	});
	dayObj.css('display', 'none');
	// $("#day_lst>ul>li:visible").last().css('display', 'list-item').find('a.tabh').click();
	$("#day_lst>ul>li:visible").last().find('a.tabh').click();
	// $("#day_lst>ul>li:visible").last().click();

	clearMap();
}

function setPointSticky(infoObj) {
	var lon = infoObj.lon;
	var lat = infoObj.lat;
	var pointType = infoObj.pointType;
	var pointNum = infoObj.pointNum;
	var infoWinTitle = infoObj.infoWinTitle;

	var markerParam = {
		lng : lon,
		lat : lat
	};
	if(pointNum) {
		markerParam.pointNum = pointNum;
	} else {
		markerParam.pointType = pointType;
	}
	addMarkers(markerParam);

	var tit = infoWinTitle;
	var content = "<div style='position: relative; border-bottom: 1px solid #dcdcdc; "+
				  "line-height: 18px; padding: 3px; width: 150px; height: auto; text-align:center;'>"+
				  "<span style='font-size: 12px; line-height: 15px;'>"+tit+"</span>"+
				  "</div>";
	//Popup 객체 생성.
	var infoWindow = new Tmapv2.InfoWindow({
		position: new Tmapv2.LatLng(lat,lon), //Popup 이 표출될 맵 좌표
		content: content, //Popup 표시될 text
		type: 2, //Popup의 type 설정.
		map: map //Popup이 표시될 맵 객체
	});
	infoWindowArr.push(infoWindow);

	map.setCenter(new Tmapv2.LatLng(lat,lon));
	/* map.setZoom(10); //TMap.prototype.setZoom - setScaleOffset 
	- Uncaught TypeError: n.screenPoint.equals is not a function */
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
			
			var infoObj = {};
			infoObj.lon = lon;
			infoObj.lat = lat;
			// infoObj.pointType = "P";
			infoObj.pointNum = index + 1;
			infoObj.infoWinTitle = $(this).find('p.txt').text();
			setPointSticky(infoObj);

	    });
	});

	$("ul.lst li label input[type=checkbox]:not(.check-all)").bind("click", function() {
		var cat_box = $(this).closest("li.cat-box");
		var category = cat_box.data('category');
		var tag_list = [];
		cat_box.find("input[type=checkbox]:not(.check-all)").each(function(idx) {
			if($(this).is(":checked")) {
				tag_list.push($(this).val());
			}
		});
		// console.log(tag_list.toString());
		getDestinationList(1, category, tag_list);
		cat_box.find("div.cssSelect").removeClass("on");
	});

	$("ul.lst li label input.check-all").bind("click", function() {
		var cat_box = $(this).closest("li.cat-box");
		var category = cat_box.data('category');
		var tag_list = [];
		if($(this).is(":checked")) {
			cat_box.find("input[type=checkbox]:not(.check-all)").each(function(idx) {
				$(this).prop('checked', true);
				tag_list.push($(this).val());
			});
			getDestinationList(1, category, tag_list);
			cat_box.find("div.cssSelect").removeClass("on");

		} else {
			cat_box.find("input[type=checkbox]:not(.check-all)").each(function(idx) {
				$(this).prop('checked', false);
			});
		}
		// console.log(tag_list.toString());
	});

});