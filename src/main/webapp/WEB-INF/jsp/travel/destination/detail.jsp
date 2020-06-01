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
	            <div class="cont_head">
	                <%-- <h2 class="title">속리산 국립공원(문장대)</h2> --%>
	                <h2 class="title"><c:out value="${travelDestination.destTitle}" /></h2>
	            </div><!-- cont_head -->
	            <div class="cont_body">
		            <div class="inr">
		            	<div class="local_map_area">
			              	<div class="localzone">
								<ul class="lst">
									<li><img src='http://seantour.com<c:out value="${travelDestination.destImgPath}" />' alt="<c:out value="${travelDestination.destTitle}" />" /></li>
									<%-- <li><img src="./images/content/img_local_detail01.jpg" alt="" /></li>
									<li><img src="./images/content/img_local_detail01.jpg" alt="" /></li> --%>
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
										<a href="#none" class="clip">클립</a>
										<a href="#none" class="heart">좋아요</a>
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
								<p class="txt"><c:out value="${travelDestination.destDescription}" escapeXml="false" /></p>
							</div>
						</div>
						<div class="btnArea tar">
							<a href="/travel/destination/list.do" class="button border">목록</a>
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
</style>
<script type="text/javascript">
var map
function initTmap(){
	var lat = '<c:out value="${travelDestination.destAxisY}" />';
	var lon = '<c:out value="${travelDestination.destAxisX}" />';
	if(lat && lon) {
		var imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
		var size = new Tmapv2.Size(24, 38);
		map = new Tmapv2.Map("map_wrap", {
			center: new Tmapv2.LatLng(lat, lon),
			width : "calc(100% - 661px - 15px)",
			height : "440px",
			zoom : 12,
			// zoomControl : true,
			// scrollwheel : true,
			// scaleBar : true,
		});
		marker_p = new Tmapv2.Marker({
			position : new Tmapv2.LatLng(lat, lon),
			icon : imgURL,
			iconSize : size,
			map : map
		});
	}
}
function fn_egov_link_page(pageNo){
	document.getElementById("travelDestination").pageIndex.value = pageNo;
	document.getElementById("travelDestination").action = "<c:url value='/travel/destination/list.do'/>";
   	document.getElementById("travelDestination").submit();
}
</script>
</html>
