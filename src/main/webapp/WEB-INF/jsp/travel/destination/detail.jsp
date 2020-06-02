<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>

<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
<!-- tmap api -->
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=<spring:message code='Travel.Api.Tmap.Appkey' />"></script>
<script src="<c:url value="/js/travel/kakao.js"/>"></script>
<script type="text/javascript">Kakao.init("<spring:message code='Travel.Api.Kakao.Appkey' />");</script>

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
	            <div class="cont_head">
	                <%-- <h2 class="title">속리산 국립공원(문장대)</h2> --%>
	                <h2 class="title"><c:out value="${travelDestination.destTitle}" /></h2>
	            </div><!-- cont_head -->
	            <div class="cont_body">
		            <div class="inr">
		            	<div class="local_map_area">
			              	<div class="localzone">
								<ul class="lst">
									<%-- <c:set var="destImgPath" value="${empty travelDestination.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(travelDestination.destImgPath)}" /> --%>
								<c:if test="${fn:length(travelDestination.travelFileList) eq 0}">
									<c:set var="destImgPath" value="${empty travelDestination.destImgPath ? '/images/travel/content/noimg.jpg' : travelDestination.destImgPath}" />
									<li><img src='<c:url value="${destImgPath}" />' alt="<c:out value="${travelDestination.destTitle}" />" /></li>
								</c:if>	
								<c:forEach var="images" items="${travelDestination.travelFileList}" varStatus="status">	
									<li><img src='<c:url value="${images.imgFilePath}" />' alt="<c:out value="${travelDestination.destTitle}" />" /></li>
								</c:forEach>
									<%-- <li><img src="<c:url value="/images/content/img_local_detail01.jpg"/>" alt="" /></li>
									<li><img src="<c:url value="/images/content/img_local_detail01.jpg"/>" alt="" /></li> --%>
								</ul>
								<div class="btn">
									<a href="#" class="prev">팝업존 이전으로</a>
									<a href="#" class="next">팝업존 다음으로</a>
								</div>
							</div>
							<div class="local_map" id="map_wrap"></div>
						</div>
						<div class="local_info_area">
							<div class="info_lst">
								<div class="clr">
									<div class="icon_box">
								        <%-- <p id="kakaolink">공유하기</p> --%>
										<a id="kakaolink" href="javascript:;" onclick="shareTravelDestToKakao(this);" class="kakao" data-target-id='<c:out value="${travelDestination.destId}"/>' data-user-id='<c:out value="${loginVO.mbrId}"/>'>공유</a>
										<a href="javascript:;" data-mbr-id='<c:out value="${loginVO.mbrId}"/>' data-dest-id='<c:out value="${travelDestination.destId}"/>' onclick="registerTravelDestFeedback(this, 'clip');return false;" class="clip <c:if test="${travelDestination.myClipCount gt 0}">on</c:if>">클립</a>
										<a href="javascript:;" data-mbr-id='<c:out value="${loginVO.mbrId}"/>' data-dest-id='<c:out value="${travelDestination.destId}"/>' onclick="registerTravelDestFeedback(this);return false;" class="heart <c:if test="${travelDestination.myRecommCount gt 0}">on</c:if>">공감</a>
									</div>
								</div>
								<ul class="list">
									<li><span class="tit">지역</span><p><c:out value="${travelDestination.destRegion}" /></p></li>
									<li><span class="tit">연락처</span><p><c:out value="${travelDestination.destPhone}" escapeXml="false" /></p></li>
									<li><span class="tit">주소</span><p><c:out value="${travelDestination.destAddress}" escapeXml="false" /></p></li>
									<li><span class="tit">홈페이지</span><p><c:out value="${travelDestination.destWebsiteUrl}" escapeXml="false" /></p></li>
									<%-- <li><span class="tit">관리기관</span><p>밀양시</p></li>
									<li><span class="tit">편의시설</span><p>주차장, 수유실</p></li> --%>
								</ul>
							</div>
							<div class="info_txt">
								<p class="tit">관광지정보</p>
								<p class="txt" id="destInformation"><c:out value="${travelDestination.destInformation}" escapeXml="false" /></p>
							</div>

						<c:if test="${fn:length(nearStayPoints) gt 0}">
							<div class="info_txt">
								<p class="tit">가까운 놀거리</p>
								<div class="near_points_area">
									<c:forEach var="nearPlay" items="${nearPlayPoints}" varStatus="play">	
										<div class="near_points_box"><div class="near_points" data-lon="<c:out value="${nearPlay.destAxisX}"/>" data-lat="<c:out value="${nearPlay.destAxisY}"/>" data-dest-id="<c:out value="${nearPlay.destId}"/>"><span class="near_tit"><c:out value="${nearPlay.destTitle}" escapeXml="false" /></span></div></div>
									</c:forEach>	
								</div>
							</div>
						</c:if>	

						<c:if test="${fn:length(nearStayPoints) gt 0}">
							<div class="info_txt">
								<p class="tit">가까운 잠자리</p>
								<div class="near_points_area">
								<c:forEach var="nearStay" items="${nearStayPoints}" varStatus="stay">	
									<div class="near_points_box"><div class="near_points" data-lon="<c:out value="${nearStay.destAxisX}"/>" data-lat="<c:out value="${nearStay.destAxisY}"/>" data-dest-id="<c:out value="${nearStay.destId}"/>"><span class="near_tit"><c:out value="${nearStay.destTitle}" escapeXml="false" /></span></div></div>
								</c:forEach>	
								</div>
							</div>
						</c:if>	

						</div>
						<div class="btnArea tar">
						<form name="travelDestination" method="post">
							<input type="hidden" name="destId" value="<c:out value="${travelDestination.destId}"/>">
							<%-- <a href="/travel/destination/list.do" class="button border">목록</a> --%>
						<c:if test="${(loginVO.mbrId eq travelDestination.destWriter)&& loginVO.mbrId ne null}">
							<a href="<c:url value="/travel/destination/modify.do?destId=${travelDestination.destId}"/>" class="button border">수정</a>
							<a href="javascript:;" onclick="deleteDestination();return false;" class="button border">삭제</a>
						</c:if>
							<%-- <a href="<c:out value="${pageContext.request.getHeader('REFERER')}"/>" class="button border">목록</a> --%>
							 <a href="javascript:history.back();" class="button border">목록</a>
						</form>
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
	<script>
// var map
var near_map = {};
var near_marker = {};

function initTmap(){
	var lat = '<c:out value="${travelDestination.destAxisY}" />';
	var lon = '<c:out value="${travelDestination.destAxisX}" />';
	if(lat && lon) {
		drawMultipleMap("map_wrap", "calc(100% - 661px - 15px)", "440px", lat, lon);
	}
	setNearPointsMap();
}
function setNearPointsMap() {
	$(".near_points").each(function() {
		var id = $(this).data('dest-id');
		$(this).attr('id', 'near'+id);
		var lon = $(this).data('lon');
		var lat = $(this).data('lat');
		if(lat && lon) {
			drawMultipleMap("near"+id, "100%", "250px", lat, lon);
		}
	});
}
function drawMultipleMap(map_id, width, height, lat, lon) {
	var imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
	var size = new Tmapv2.Size(24, 38);
	// map = new Tmapv2.Map("map_wrap", {
	near_map[map_id] = new Tmapv2.Map(map_id, {
		center: new Tmapv2.LatLng(lat, lon),
		width : width,
		height : height,
		zoom : 12,
		zoomControl : false,
		scrollwheel : false,
		scaleBar : false,
	});
	// marker_p = new Tmapv2.Marker({
	near_marker[map_id] = new Tmapv2.Marker({
		position : new Tmapv2.LatLng(lat, lon),
		icon : imgURL,
		iconSize : size,
		map : near_map[map_id]
	});
}

// function registerTravelDestFeedback(userId, targetId, type) {
function registerTravelDestFeedback(obj, type) {
	var param, url;
	var userId = $(obj).data("mbr-id");
	var targetId = $(obj).data("dest-id");
	if(type == "clip") {
		if(!userId) {
			alert("로그인 후에 클립보드에 추가하실 수 있습니다"); return false;
		}
		param = "clipUserId="+userId+"&clipPageId="+targetId;
		url = "<c:url value='/travel/member/clipboard/insertAsync.do'/>";
	} else {
		param = "rxnUserId="+userId+"&rxnTargetId="+targetId+"&rxnType=LIKE";
		url = "<c:url value='/travel/reco/insertAsync.do'/>";
	}
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
					if($(obj).hasClass("on")===true)
					{
						$(obj).removeClass('on');
					}else{
						$(obj).addClass('on');
					}
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

function shareTravelDestToKakao(obj) {
	var userId = $(obj).data("user-id");
	var targetId = $(obj).data("target-id");
	var title = $(".title").text();
	var desc = $("#destInformation").text();
	var description = desc.substr(0, 100);
	if(desc.length > 100) description += "...";
	var imageUrl = $(".lst").find('img').attr('src');
	var pageUrl = location.href;
	var callBackArg = {
		"rxnUserId": userId, 
		"rxnTargetId": targetId
	};
	// console.log("callBackArg...\n", callBackArg);
	// Kakao.init('c703c213f7ea3ea751fbe5e2dbf72197');
	// Kakao.init('2f72000e6b1800eed13de4fab1f9e080');
	Kakao.Link.sendDefault({
		objectType: 'feed',
		content: {
			title: title,
			description: description,
			imageUrl: imageUrl,
			link: {
				webUrl: pageUrl,
				mobileWebUrl: pageUrl,
				// androidExecParams: 'test',
			},
		},
		serverCallbackArgs: JSON.stringify(callBackArg),
		/*buttons: [
			{
				title: '자세히 보기',
				link: {
					webUrl: location.href,
					mobileWebUrl: location.href,
				},
			},
			{
				title: '자세히 보기',
				link: {
					webUrl: location.href,
					mobileWebUrl: location.href,
				},
			},
		],*/
		success: function(response) {
			// console.log(response);
		},
		fail: function(error) {
			// console.log(error);
		}
	});
}

function deleteDestination(){
	// var registerFlag = document.getElementById("registerFlag").value;
	if(confirm("삭제된 데이터는 복구할 수 없습니다.\n삭제하시겠습니까?")) {
		var frm = document.forms["travelDestination"];
		frm.action = "<c:url value="/travel/destination/delete.do"/>";
		frm.submit();
	}
}
<%-- function fn_egov_link_page(pageNo){
	document.getElementById("travelDestination").pageIndex.value = pageNo;
	document.getElementById("travelDestination").action = "<c:url value='/travel/destination/list.do'/>";
   	document.getElementById("travelDestination").submit();
} --%>

</script>
</body>

</html>