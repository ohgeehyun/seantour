<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
<!-- tmap api -->
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=<spring:message code='Travel.Api.Tmap.Appkey' />"></script>
<script src="<c:url value="/js/travel/travel.route.api.tmap.js"/>"></script>
<style>
#wrap_loading{
	position: fixed;
	left:0;
	right:0;
	top:0;
	bottom:0;
	background: rgba(0,0,0,0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
	z-index: 999;
}
#wrap_loading div{
	position: fixed;
	top:50%;
	left:50%;
	margin-left: -21px;
	margin-top: -21px;
}
.display-none { display:none; }
#map_wrap {
			background: initial;
		}
</style>
</head>
<body onload="initTmap()">
<div id="wrap_loading">
    <div><img src="<c:url value="/images/travel/content/loading.png"/>" alt="로딩중" /></div>

</div>
	<div id="wrap">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
			<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
		<!-- // header -->

		<!-- contaniner -->
		<div id="container" >

			<%@ include file="/WEB-INF/jsp/travel/tpl/navigation.jsp" %>

			<div id="content" class="cont_wrap">
	            <div class="cont_body">
		            <div class="inr">
		            	<div class="map_route_wrap">
		            		<div class="map_route">
			            		<div id="map_wrap"></div>
			            	<c:forEach var="route" items="${travelRoute.routeDailyList}" varStatus="status">
			            		<dl class="map_day_route">
			            			<dt class="on"><a href="javascript:;" onclick="showSpinner(this);">DAY <c:out value="${route.routDays}" /></a></dt>
			            			<dd class="route_lst">
			            				<ul>
			            				<c:forEach var="dest" items="${route.wayPointList}" varStatus="status">
			            					<li style="width:100%;"><span class="num"><c:out value="${status.count}"/></span><c:out value="${dest.destTitle}"/></li>
			            				</c:forEach>
			            				</ul>
			            			</dd>
			            		</dl>
			            	</c:forEach>
		            		</div>
			            	<div class="recommend_days_lst">
			            		<div class="tit_box">
			            			<p class="name"><c:out value="${travelRoute.routRegMemberNm}"/></p>
			            			<p class="tit"><c:out value="${travelRoute.routTitle}"/></p>
			            			<div class="info">
			            				<ul class="list">
			            					<li><c:out value="${travelRoute.routRegion}"/></li>
			            					<li><c:out value="${fn:length(travelRoute.routeDailyList)-1}"/>박<c:out value="${fn:length(travelRoute.routeDailyList)}"/>일</li>	
			            				</ul>
			            				<%-- <p class="date">2020.03.02</p> --%>
			            				<p class="date">
			            					<fmt:parseDate value="${travelRoute.routRegDate}" var="parsedDate" pattern="yyyy-MM-dd HH:mm:ss.S"/>
			            					<fmt:formatDate value="${parsedDate}" pattern="yyyy.MM.dd"/>
			            					
		            					</p>
			            			</div>
			            		</div>
			            			<form:form commandName="routid" method="get">
			            			<input type ="hidden" value="${travelRoute.routId}" name="routid" id="routid">
									<button type="button" class="btn_excel" onclick='fn_egov_down_excel("<c:out value="${travelRoute.routId}"/>")'>엑셀</button>
									</form:form>
			            		<div class="memo_result_area">
			            			<div class="memo_inner">
			            				<c:out value="${travelRoute.routMemo}" escapeXml="false" />
			            			</div>
			            		</div>
			            	<c:forEach var="route" items="${travelRoute.routeDailyList}" varStatus="status">
			            		<div class="re_days_area">
			            			<p class="day_num">DAY <c:out value="${route.routDays}" /></p>
			            			<!-- <p><c:out value="${route.routStartPoint}" /></p> -->
			            			<ul class="list route-box" data-start-lat='<c:out value="${fn:split(route.routStartAxis,',')[0]}"/>' data-start-lon='<c:out value="${fn:split(route.routStartAxis,',')[1]}"/>' data-dest-lat='<c:out value="${fn:split(route.routDestAxis,',')[0]}"/>' data-dest-lon='<c:out value="${fn:split(route.routDestAxis,',')[1]}"/>'>
			            			<c:forEach var="dest" items="${route.wayPointList}" varStatus="status">
										<li class="route-list" data-lat='<c:out value="${dest.destAxisY}"/>' data-lon='<c:out value="${dest.destAxisX}"/>' data-destid='<c:out value="${dest.destId}"/>'>
											<%-- <div class="img"><img src='http://seantour.com<c:out value="${dest.destImgPath}"/>' alt='<c:out value="${dest.destTitle}"/>' /></div> --%>
											<div class="img">
											<c:if test="${fn:length(dest.travelFileList) eq 0}">
												<c:set var="destImgPath" value="${empty dest.destImgPath ? '/images/travel/content/noimg.jpg' : dest.destImgPath}" />
												<img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${dest.destTitle}"/>' />
											</c:if>
											<c:if test="${fn:length(dest.travelFileList) gt 0}">
												<img src='<c:url value="${dest.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${dest.destTitle}"/>' />
											</c:if>
											<%-- 
											<c:forEach var="images" items="${dest.travelFileList}" varStatus="status">	
												<img src='<c:url value="${images.imgFilePath}"/>' alt='<c:out value="${dest.destTitle}"/>' />
											</c:forEach> 
											--%>
											</div>	
											<div class="txt_box">
												<p class="tit"><c:out value="${dest.destTitle}"/></p>
												<div class="txt_area">
													<span class="local"><c:out value="${dest.destRegion}"/></span>
													<p class="txt"><c:out value="${fn:substring(dest.destInformation,0,60)}" escapeXml="false" /><c:if test="${fn:length(dest.destInformation) gt 60}">..</c:if></p>
												</div>
												<a href="<c:url value="/travel/destination/detail.do?destId=${dest.destId}"/>" class="more">더보기</a>
											</div>
										</li>
									</c:forEach>
									</ul>
			            			<!-- <p><c:out value="${route.routDestPoint}" /></p> -->
			            		</div>
			            	</c:forEach>
			            	
			            	</div>
			            	
		            	</div>
		            	
						<div class="btnArea tar">
						<c:if test="${not empty loginVO.mbrId and (travelRoute.routRegMember ne loginVO.mbrId)}">
							<a href="javascript:;" data-mbr-id='<c:out value="${loginVO.mbrId}"/>' data-dest-id='<c:out value="${travelRoute.routId}"/>' onclick="registerTravelRouteReco(this);return false;" class="button border">추천</a>
						</c:if>	
						<c:if test="${not empty loginVO.mbrId and (travelRoute.routRegMember eq loginVO.mbrId)}">
							<a href='<c:url value="/travel/route/modify.do?routId=${travelRoute.routId}"/>' class="button border">수정</a>
							<c:if test="${travelRoute.routType eq 'U' and travelRoute.routOpen ne 'Y'}">
								<a href="javascript:;" onclick="updateTravelRouteOpenStatus('<c:out value="${travelRoute.routId}"/>');return false;" class="button border">올리기</a>
							</c:if>
						</c:if>
							<%-- <a href="<c:out value="${pageContext.request.getHeader('REFERER')}"/>" class="button border">목록</a> --%>
							<a href="javascript:history.back();" class="button border">목록</a>
						</div>
		             </div>  
	            </div><!-- cont_body -->
	        </div><!-- // cont_wrap -->
        </div>
        <!--// container -->
		<form name="travelRouteUpdate" method="post">
			<input type="hidden" name="routId">
		</form>
		<!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	<!-- // wrap -->
	<!-- <style>
		.local_lst li .tbox .tit span {
			width: 60px;
		}
		
	</style>-->
	<script>
var appKey = "<spring:message code='Travel.Api.Tmap.Appkey' />";
var map
var infoWindowArr = [];
var resultMarkerArr = [];
var resultDrawArr = [];
var drawInfoArr = [];
var checkTraffic = [];

//var thumb_img_path = "https://www.seantour.com";

function showSpinner(obj) {
	$('#wrap_loading').removeClass('display-none');
	(function(obj){
		setTimeout(function() {
			initTmap(obj);
		}, 100);
	}(obj));
}
function initTmap(obj){

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
			width : "100%",
			height : "437px",
			zoom : 10,
			// zoomControl : true,
			// scrollwheel : true,
			// scaleBar : true,
		});
	} 
	/*else {
		map.setCenter(new Tmapv2.LatLng(axisObj['startY'], axisObj['startX']));
	}*/

	var viaPoints = [];		

	var item = route_box.eq(idx).find('li.route-list');
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
		getRouteUsingViaPoints(axisObj, viaPoints, "Y"); //일반 경로안내 - 경유지(O), 교통정보(X)
	}

}

function registerTravelRouteReco(obj) {
	var userId = $(obj).data("mbr-id");
	var targetId = $(obj).data("dest-id");
	var param = "rxnUserId="+userId+"&rxnTargetId="+targetId+"&rxnType=RECO";
	var url = "<c:url value='/travel/reco/insertAsync.do'/>";
	$.ajax({
		method:"POST",
		url:url,//
		data:param,
		success:function(response){
			// console.log(response);
			try {
				var data = JSON.parse(response);
				if(data.status == "success") {
					alert(data.result);
					$(obj).addClass('on');
				} else {
		    		throw new SyntaxError("요청을 수행하지 못함");
				}
			} catch (e) {
				// console.log(e.name);
				// console.log(e.message);
				alert("일시적인 에러가 발생했습니다. 잠시 후 다시 시도해 주세요."); return false;
			}
		},
		error:function(request,status,error){
			// console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function updateTravelRouteOpenStatus(routId){
	frm = document.forms["travelRouteUpdate"];
	frm.routId.value = routId;
	frm.action = "<c:url value='/travel/member/updatemyroute.do'/>";
   	frm.submit();
}

function fn_egov_down_excel(routid)
{
		document.getElementById("routid").value = routid;	
		document.getElementById("routid").action = "<c:url value='/travel/route/excelDetail.do'/>";
  		document.getElementById("routid").submit(); 
  	
  	return false;
}


</script>
</body>


</html>
