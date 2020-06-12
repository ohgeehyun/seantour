<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1">
<title>바다여행 일정만들기</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/base.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/font.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/layout.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/common.css"/>">
<%-- for 여행지 페이징 --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/travel.destination.register.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/map.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/slick.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/aos.css"/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/js/travel/jquery.min.js"/>"></script>
<script src="<c:url value="/js/travel/jquery-ui.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/jquery-1.12.2.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/jquery.cookie-1.3.1.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/jquery.steps.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/jquery.bxslider.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/TweenMax.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/slick.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/aos.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/modal.js"/>"></script> 
<script src="<c:url value="/js/travel/Sortable.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/common.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/content.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/main.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/root.js"/>"></script>
<!-- tmap api -->
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=<spring:message code='Travel.Api.Tmap.Appkey' />"></script>
<script src="<c:url value="/js/travel/travel.route.js"/>"></script>
<script src="<c:url value="/js/travel/travel.route.api.tmap.js"/>"></script>
<script type="text/javascript">
var appKey = "<spring:message code='Travel.Api.Tmap.Appkey' />";
var contextPath = '<c:out value="${pageContext.request.contextPath}"/>';
</script>
<style type="text/css">
div#media1023 {display:none;}
@media all and (max-width: 1023px) {
	div#media1023 {display:block;}
}
</style>
</head>
<body onload="initTmap()">
<div id="wrap" style="position:static;">
	<div id="accessibility"><a href="#content">본문 바로가기</a></div>
	<!-- header -->
	<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
	<!-- // header -->

	<div class="map_wrap_area">
		<div id="web_content">
			<div id="map_wrap"></div>
			<form name="travelRoute" id="travelRoute" method="post">
				<input type="hidden" name="startAxis">
				<input type="hidden" name="destAxis">
				<input type="hidden" name="routId" value='<c:out value="${travelRoute.routId}" />'>
				<input type="hidden" name="routRegMember" value="${loginVO.mbrId}">
				<input type="hidden" name="pageIndex" value="${paginationInfo.currentPageNo}">
	
				<div id="content">
					<div class="day_info">
						<div class="day_tit"><span>1</span>DAY</div>
						<ul class="day_util">
							<li><a href="#none" class="day_memo">메모</a>
								<div class="memo_box">
									<p class="tit">나의 메모</p>
									<div class="txt_memo">
										<textarea name="routMemo" cols="30" rows="5" placeholder="메모입력란입니다"><c:out value="${travelRoute.routMemo}" escapeXml="false" /></textarea>
									</div>
									<div class="memo_btn">
										<a href="#none" class="close">취소</a>
										<a href="#none" class="add">저장</a>
									</div>
								</div>
							</li>
							<li><a href="javascript:;" onclick="delDailyLayer();" class="day_delect">삭제</a></li>
							<li><a href="javascript:;" onclick="initRegisterLayer();" class="day_reset">초기화</a></li>
						</ul>
					</div>
					<div id="day_lst" class="day_lst <c:if test='${fn:length(travelRoute.routeDailyList) gt 0}'>col<c:out value='${fn:length(travelRoute.routeDailyList)}'/></c:if>">
						<ul>
	
						<c:forEach var="route" items="${travelRoute.routeDailyList}" varStatus="status">
							<li style="display: list-item;">
								<a href="#none" class="tabh">D-${status.count}</a>
								<div class="tab_con">
									<div class="start">
										<input type="text" class="start_word" placeholder="출발지를 입력하세요" onclick="searchAddress('S', '<c:out value="${status.count}"/>');" value='<c:out value="${route.routStartPoint}" />' 
										<c:if test="${not empty route.routStartAxis}">data-lat='<c:out value="${fn:split(route.routStartAxis,',')[0]}"/>'</c:if> 
										<c:if test="${not empty route.routStartAxis}">data-lon='<c:out value="${fn:split(route.routStartAxis,',')[1]}"/>'</c:if> />
									</div>
									<ul id="example3Left<c:if test='${status.count gt 1}'>${status.count}</c:if>"  class="tab_list list-group col" data-routid="${route.routId}">
									<%-- <c:forTokens items="${route.wayPointList}" delims="|" var="routePoint"> --%>
									<c:forEach var="routePoint" items="${route.wayPointList}" varStatus="routStat">
										<li data-lat='<c:out value="${routePoint.destAxisY}"/>' data-lon='<c:out value="${routePoint.destAxisX}"/>' data-destid='<c:out value="${routePoint.destId}"/>'>
											<%-- <c:set var="destImgPath" value="${empty routePoint.destImgPath ? '/images/travel/content/noimg.jpg' : routePoint.destImgPath}" /> --%>
											<c:set var="destImgPath" value="${empty routePoint.destImgPath ? '/images/travel/content/noimg.jpg' : routePoint.destImgPath}" />
											<div class="img"><img src="<c:url value="${destImgPath}"/>" alt="<c:out value="${routePoint.destTitle}" escapeXml="false" />" /></div>
											<div class="txt_box">
												<p class="txt"><c:out value="${routePoint.destTitle}" escapeXml="false" /></p>
												<p class="sub"><c:out value="${routePoint.destCategory}" /></p>
												<a href="javascript:;" class="more" onclick="getDestinationDetail('<c:out value="${routePoint.destId}" />');">더보기</a>
											</div>
											<div class="icon_box">
												<!-- <a href="#none" class="ico_heart">종아요</a> -->
												<a href="javascript:;" class="ico_add" onclick="addPoint(this);">추가</a>
												<a href="javascript:;" class="ico_close" onclick="delPoint(this);">닫기</a>
											</div>
										</li>
									</c:forEach>
									</ul>
									<div class="arrival">
										<input type="text" class="arrival_word" placeholder="도착지를 입력하세요" onclick="searchAddress('E', '<c:out value="${status.count}"/>');" value='<c:out value="${route.routDestPoint}" />' 
										<c:if test="${not empty route.routDestAxis}">data-lat='<c:out value="${fn:split(route.routDestAxis,',')[0]}"/>'</c:if> 
										<c:if test="${not empty route.routDestAxis}">data-lon='<c:out value="${fn:split(route.routDestAxis,',')[1]}"/>'</c:if> />
									</div>
								</div>
							</li>
						</c:forEach>
	
						<c:set var="begin" value="${fn:length(travelRoute.routeDailyList) + 1}" />
						<c:forEach begin="${begin}" end="7" step="1" varStatus="stat">
							<li <c:if test="${stat.current gt 1}">style="display: none;"</c:if>>
								<%-- <a href="#none" class="tabh">D-<c:out value="${begin + stat.index}"/></a> --%>
								<a href="#none" class="tabh">D-<c:out value="${stat.current}"/></a>
								<div class="tab_con">
									<div class="start">
										<input type="text" class="start_word" placeholder="출발지를 입력하세요" onclick="searchAddress('S', '<c:out value="${stat.current}"/>');" />
									</div>
									<ul id="example3Left<c:if test='${stat.current gt 1}'><c:out value="${stat.current}"/></c:if>"  class="tab_list list-group col"></ul>
									<div class="arrival">
										<input type="text" class="arrival_word" placeholder="도착지를 입력하세요" onclick="searchAddress('E', '<c:out value="${stat.current}"/>');" />
									</div>
								</div>
							</li>
						</c:forEach>
	
						</ul>
						<a href="#none" class="plus">DAY</a>
						<%-- <a href="<c:url value='/travel/member/myroute.do'/>" class="heart">MY</a> --%>
						<a href="javascript:;" onclick="getClipDestinationList();" class="heart">MY</a>
						<a href="javascript:;" class="save" onclick="saveTravelRoute('travelRoute');">SAVE</a>
					</div><!-- //day_lst -->
	
					<div class="tour_schedule_detail open">
						<div class="schedule_tbox">
							<div>
								<input type="text" name="routTitle" class="sc_tit" placeholder="나만의 여행일정 제목을 입력하세요." value='<c:out value="${travelRoute.routTitle}"/>' />
							</div>
							<div>
								<select class="sc_local" name="dest_region" onchange="changeDestinationRegion(this);">
									<option value="">지역</option>
	                            <c:forEach var="region" items="${regionList}" varStatus="status">
	                        		<option value='<c:out value="${region.destRegion}"/>' <c:if test="${travelRoute.routRegion eq region.destRegion}">selected="selected"</c:if>><c:out value="${region.destRegion}"/></option>
			                    </c:forEach>
			                    <c:if test="${empty regionList}">
			                    	<li>등록된 지역이 없습니다</li>
			                    </c:if>
								</select>
							</div>
							<div class="btn_area"><a href="#none">일정상세보기</a></div>
						</div>
						<div class="schedule_content">
							<div class="tab_mn">
								<ul>
									<li class="cat-box normal-cat" data-category="관광지"><a href="javascript:;" onclick="changeCategory(1,'관광지');" class="cate-btn">관광</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst normal-cat-list">
												<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
											<c:forEach var="tour" items="${catList['관광지']}" varStatus="status">
												<li><label><input type="checkbox" name="destTag" value="<c:out value="${tour}"/>" class="check" /><c:out value="${tour}"/></label></li>
											</c:forEach>
											</ul>
										</div>
									</li>
									<li class="cat-box normal-cat" data-category="숙박"><a href="javascript:;" onclick="changeCategory(1,'숙박');" class="cate-btn">숙박</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst normal-cat-list">
												<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
											<c:forEach var="lodging" items="${catList['숙박']}" varStatus="status">
												<li><label><input type="checkbox" name="destTag" value="<c:out value="${lodging}"/>" class="check" /><c:out value="${lodging}"/></label></li>
											</c:forEach>
											</ul>
										</div>
									</li>
									<li class="cat-box normal-cat" data-category="체험"><a href="javascript:;" onclick="changeCategory(1,'체험');" class="cate-btn">레져</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst normal-cat-list">
												<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
											<c:forEach var="leisure" items="${catList['체험']}" varStatus="status">
												<li><label><input type="checkbox" name="destTag" value="<c:out value="${leisure}"/>" class="check" /><c:out value="${leisure}"/></label></li>
											</c:forEach>
											</ul>
										</div>
									</li>
									<li class="cat-box normal-cat" data-category="음식점"><a href="javascript:;" onclick="changeCategory(1,'음식점');" class="cate-btn">식당</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst normal-cat-list">
												<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
											<c:forEach var="food" items="${catList['음식점']}" varStatus="status">
												<li><label><input type="checkbox" name="destTag" value="<c:out value="${food}"/>" class="check" /><c:out value="${food}"/></label></li>
											</c:forEach>
											</ul>
										</div>
									</li>
									<li class="cat-box normal-cat" data-category="쇼핑"><a href="javascript:;" onclick="changeCategory(1,'쇼핑');" class="cate-btn">쇼핑</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst normal-cat-list">
												<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
											<c:forEach var="shopping" items="${catList['쇼핑']}" varStatus="status">
												<li><label><input type="checkbox" name="destTag" value="<c:out value="${shopping}"/>" class="check" /><c:out value="${shopping}"/></label></li>
											</c:forEach>
											</ul>
										</div>
									</li>
								</ul>
							</div>
							
							<ul class="result_list list-group col" id="example3Right">
							<c:forEach var="dest" items="${resultList}" varStatus="status">
								<li data-lat='<c:out value="${dest.destAxisY}" />' data-lon='<c:out value="${dest.destAxisX}" />' data-destid='<c:out value="${dest.destId}" escapeXml="false" />'>
									<div class="img">
									<c:if test="${fn:length(dest.travelFileList) eq 0}">	
										<%-- <c:set var="destImgPath" value="${empty dest.destImgPath ? '/images/travel/content/noimg.jpg' : dest.destImgPath}" /> --%>
										<c:set var="destImgPath" value="${empty dest.destImgPath ? '/images/travel/content/noimg.jpg' : dest.destImgPath}" />
										<img src="<c:url value="${destImgPath}"/>" alt="<c:out value="${dest.destTitle}" escapeXml="false" />" />
									</c:if>
									<c:if test="${fn:length(dest.travelFileList) gt 0}">
										<img src='<c:url value="${dest.travelFileList[0].imgFilePath}"/>' alt="<c:out value="${dest.destTitle}"/>" />
									</c:if>
									</div>
									<div class="txt_box">
										<p class="txt"><a href="javascript:;" onclick='setDestinationSticky("<c:out value="${dest.destAxisY}" />", "<c:out value="${dest.destAxisX}" />", "<c:out value="${dest.destTitle}"/>");'><c:out value="${dest.destTitle}" escapeXml="false" /></a></p>
										<p class="sub"><c:out value="${dest.destCategory}" /></p>
										<a href="javascript:;" class="more" onclick="getDestinationDetail('<c:out value="${dest.destId}" />');">더보기</a>
									</div>
									<div class="icon_box">
										<!-- <a href="#none" class="ico_heart">종아요</a> -->
										<a href="javascript:;" class="ico_add" onclick="addPoint(this);">추가</a>
										<a href="javascript:;" class="ico_close" onclick="delPoint(this);">닫기</a>
									</div>
								</li>
							</c:forEach>
							</ul>
							<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="getDestinationList" />
						</div>
					</div><!-- // tour_list_wrap -->
	
					<!--클릭시 DB에서 실시간으로 가져와서 아래 내용을 업그레이드 할것-->
					<div class="detail_info_area" id="detail_info_area">
						<div class="tit_box">
							<p>상세정보</p>
							<a href="#none" class="close">닫기</a>
						</div>
						<div class="bx_box">
							<p class="bx_tit">거제 맹중족 테마 공원</p>
							<div class="detailzone">
								<ul class="lst">
									<li><img src="<c:url value="/images/travel/map/img_detail01.jpg"/>" alt="" /></li>
								</ul>
							</div>
						</div>
						<div class="info_lst">
							<ul>
								<li>전화번호 : 051-607-6361</li>
								<li>주소 : 부산광역시 남구 용호동 5 - 4 이기대 </li>
								<li>명칭 : [공수마을]이기대전망대</li>
							</ul>
						</div>
						<div class="detail_txt">
							광안리와 광안대교, 해운대, 달맞이 고개
							까지 한눈에 보이고 일출시간에는 해안절경과
							마린시티에 비친 햇빛이 그림 같은 풍경을
							그려낸다는 설
						</div>
					</div><!-- // detail_info_area -->
				</div>
			</form>
		</div>
		<!-- // cotent -->
	<%-- ****************************************************************************************************** --%>
	<%-- ******************************************** 모바일 마크업 ******************************************** --%>
	<%-- ****************************************************************************************************** --%>
		<div id="mob_content">
			<div id="mob_map">
				<div class="mob_map" id="map_mob_wrap"></div>
				<div class="mapBg"><a href="javascript:;" class="button w33 lightblue" onclick="closeMobileMap();">닫기</a></div>
			</div>
			<div id="wizard">
				<h2>First Step</h2>
				<section id="wizard-p-0">
				<form name="travelRouteMobile" id="travelRouteMobile" method="post">
					<%-- <input type="hidden" name="startAxis" id="startAxis">
					<input type="hidden" name="destAxis" id="destAxis"> --%>
					<input type="hidden" name="routId" value='<c:out value="${travelRoute.routId}" />'>
					<input type="hidden" name="routRegMember" value="${loginVO.mbrId}">
					<input type="hidden" name="pageIndex" value="${paginationInfo.currentPageNo}">
					<div id="myModal" class="modal mob_memo_box">
						<div class="modal-content">
							<p class="tit">나의 메모</p>
							<div class="txt_memo">
								<textarea name="routMemo" cols="30" rows="5" placeholder="메모입력란입니다. 나만의 여행일정 등록 후 마이페이지 나의 여행일정에서 확인하실 수 있습니다. "><c:out value="${travelRoute.routMemo}" escapeXml="false" /></textarea>
							</div>
							<div class="memo_btn">
								<a href="#none" class="close">취소</a>
								<a href="#none" class="add">등록</a>
							</div>
						</div>
					</div>
					<div class="schedule_tbox">
						<div>
							<input type="text" name="routTitle" class="sc_tit" placeholder="나만의 여행일정 제목을 입력하세요." value='<c:out value="${travelRoute.routTitle}"/>' />
						</div>
					</div>
				<c:forEach var="route" items="${travelRoute.routeDailyList}" varStatus="status">	
					<dl class="day_sc" style="display:block;">
						<dt class="day_title"><a href="#none">${status.count}DAY</a></dt>
						<%-- <dd class="day_area <c:if test="${status.count eq '1'}">first</c:if>"> --%>
						<dd class="day_area first">
							<div class="start_tbox">
								<div>
									<input type="text" class="start_word sc_tit" placeholder="출발지를 입력하세요" onclick="searchAddress('S', '<c:out value="${status.count}"/>');" value='<c:out value="${route.routStartPoint}" />' 
									<c:if test="${not empty route.routStartAxis}">data-lat='<c:out value="${fn:split(route.routStartAxis,',')[0]}"/>'</c:if> 
									<c:if test="${not empty route.routStartAxis}">data-lon='<c:out value="${fn:split(route.routStartAxis,',')[1]}"/>'</c:if> />
								</div>
							</div>
							<ul class="day_list">
							<c:forEach var="routePoint" items="${route.wayPointList}" varStatus="routStat">	
								<li data-lat='<c:out value="${routePoint.destAxisY}"/>' data-lon='<c:out value="${routePoint.destAxisX}"/>' data-destid='<c:out value="${routePoint.destId}"/>'>
									<span class="num"><c:out value="${routStat.count}"/></span>
									<div class="day_box">
										<a href="#none" class="tbox">
											<span class="sub"><c:out value="${routePoint.destCategory}" /></span>
											<c:set var="titleLen" value="10" />
											<span class="txt"><c:out value="${fn:substring(routePoint.destTitle, 0, titleLen)}"/><c:if test="${fn:length(routePoint.destTitle) > titleLen}">..</c:if></span>
										</a>
										<a href="javascript:;" class="delect" onclick="delPoint(this);">삭제</a>
									</div>
								</li>
							</c:forEach>	
							</ul>
							<div class="add_btn_area">
								<a href="javascript:;" class="local" onclick="searchPoint(<c:out value="${status.count}"/>);"><span>장소추가</span></a>
								<a href="javascript:;" class="mapView" onclick="launchMap('<c:out value="${status.count}"/>');"><span>지도보기</span></a>
							</div>
							<div class="arrive_tbox">
								<div>
									<input type="text" class="arrival_word sc_tit" placeholder="도착지를 입력하세요" onclick="searchAddress('E', '<c:out value="${status.count}"/>');" value='<c:out value="${route.routDestPoint}" />' 
									<c:if test="${not empty route.routDestAxis}">data-lat='<c:out value="${fn:split(route.routDestAxis,',')[0]}"/>'</c:if> 
									<c:if test="${not empty route.routDestAxis}">data-lon='<c:out value="${fn:split(route.routDestAxis,',')[1]}"/>'</c:if> />
								</div>
							</div>
						</dd>
					</dl>
				</c:forEach>
				<c:set var="begin" value="${fn:length(travelRoute.routeDailyList) + 1}" />
				<c:forEach begin="${begin}" end="7" step="1" varStatus="stat">
					<dl class="day_sc" <c:if test="${stat.current eq '1'}">style="display:block;"</c:if>>
						<dt class="day_title"><a href="#none"><c:out value="${stat.current}"/>DAY</a></dt>
						<dd class="day_area <c:if test="${stat.current eq '1'}">first</c:if>">
							<div class="start_tbox">
								<div>
									<input type="text" class="start_word sc_tit" placeholder="출발지를 입력하세요" onclick="searchAddress('S', '<c:out value="${stat.current}"/>');" />
								</div>
							</div>
							<ul class="day_list">
							</ul>	
							<div class="add_btn_area">
								<%-- <a href="./map_detail.html" class="local"><span>장소추가</span></a> --%>
								<a href="javascript:;" class="local" onclick="searchPoint(<c:out value="${stat.current}"/>);"><span>장소추가</span></a>
								<a href="javascript:;" class="mapView" onclick="launchMap('<c:out value="${stat.current}"/>');"><span>지도보기</span></a>
							</div>	
							<div class="arrive_tbox">
								<div>
									<input type="text" class="arrival_word sc_tit" placeholder="도착지를 입력하세요" onclick="searchAddress('E', '<c:out value="${stat.current}"/>');" />
								</div>
							</div>				
						</dd>
					</dl> 
				</c:forEach>
		
					<div class="add_btn_area add_btn_area2">
						<a href="javascript:;" onclick="addDayInput();" class="btn_add"><span>DAY 추가</span></a>
						<a href="#none" id="myBtn" class="mob_day_memo" data-modal="#modal"><span>메모추가</span></a>
					</div>		
					<div class="tac">
						<%-- <a href="#none" class="button w33"><span>삭제</span></a> --%>
						<a href="javascript:;" class="button w33 border" onclick="saveTravelRoute('travelRouteMobile');"><span>저장</span></a>
						<!-- <a href="#none" class="button w33 border"><span>수정</span></a> -->
					</div>
					</form>
				</section><!-- // mob_content -->
				<!-- // cotent -->
				<h2>Second Step</h2>
				<section id="wizard-p-1">
					<div class="form_content">
						<select class="sc_local" name="dest_region" id="dest_region" onchange="changeDestinationRegion(this);">
							<option value="">지역</option>
		                <c:forEach var="region" items="${regionList}" varStatus="status">
		            		<option value='<c:out value="${region.destRegion}"/>' <c:if test="${travelRoute.routRegion eq region.destRegion}">selected="selected"</c:if>><c:out value="${region.destRegion}"/></option>
		                </c:forEach>
		                <c:if test="${empty regionList}">
		                	<li>등록된 지역이 없습니다</li>
		                </c:if>
						</select>
					</div>
					<div class="schedule_content">
						<div class="tab_mn">
							<ul>
								<li class="cat-box mobile-cat" data-category="관광지"><a href="javascript:;" onclick="changeCategory(1,'관광지');" class="cate-btn">관광</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst mobile-cat-list">
											<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
										<c:forEach var="tour" items="${catList['관광지']}" varStatus="status">
											<li><label><input type="checkbox" name="destTag" value="<c:out value="${tour}"/>" class="check" /><c:out value="${tour}"/></label></li>
										</c:forEach>
										</ul>
									</div>
								</li>
								<li class="cat-box mobile-cat" data-category="숙박"><a href="javascript:;" onclick="changeCategory(1,'숙박');" class="cate-btn">숙박</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst mobile-cat-list">
											<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
										<c:forEach var="lodging" items="${catList['숙박']}" varStatus="status">
											<li><label><input type="checkbox" name="destTag" value="<c:out value="${lodging}"/>" class="check" /><c:out value="${lodging}"/></label></li>
										</c:forEach>
										</ul>
									</div>
								</li>
								<li class="cat-box mobile-cat" data-category="체험"><a href="javascript:;" onclick="changeCategory(1,'체험');" class="cate-btn">레져</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst mobile-cat-list">
											<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
										<c:forEach var="leisure" items="${catList['체험']}" varStatus="status">
											<li><label><input type="checkbox" name="destTag" value="<c:out value="${leisure}"/>" class="check" /><c:out value="${leisure}"/></label></li>
										</c:forEach>
										</ul>
									</div>
								</li>
								<li class="cat-box mobile-cat" data-category="음식점"><a href="javascript:;" onclick="changeCategory(1,'음식점');" class="cate-btn">식당</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst mobile-cat-list">
											<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
										<c:forEach var="food" items="${catList['음식점']}" varStatus="status">
											<li><label><input type="checkbox" name="destTag" value="<c:out value="${food}"/>" class="check" /><c:out value="${food}"/></label></li>
										</c:forEach>
										</ul>
									</div>
								</li>
								<li class="cat-box mobile-cat" data-category="쇼핑"><a href="javascript:;" onclick="changeCategory(1,'쇼핑');" class="cate-btn">쇼핑</a>
									<div class="cssSelect">
										<button type="button">태그선택</button>
										<ul class="lst mobile-cat-list">
											<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
										<c:forEach var="shopping" items="${catList['쇼핑']}" varStatus="status">
											<li><label><input type="checkbox" name="destTag" value="<c:out value="${shopping}"/>" class="check" /><c:out value="${shopping}"/></label></li>
										</c:forEach>
										</ul>
									</div>
								</li>
							</ul>
						</div>
						<div class="day_list_wrap">
							<ul class="day_list" id="result_list">
							<c:forEach var="dest" items="${resultList}" varStatus="status">
								<li data-lat='<c:out value="${dest.destAxisY}" />' data-lon='<c:out value="${dest.destAxisX}" />' data-destid='<c:out value="${dest.destId}"/>'>
									<div class="day_box">
										<a href="#none" class="tbox">
											<%-- <span class="sub"><c:out value="${dest.destTag}" /></span> --%>
											<span class="sub"><c:out value="${dest.destCategory}" /></span>
											<c:set var="titleLen" value="10" />
											<span class="txt">
												<c:out value="${fn:substring(dest.destTitle, 0, titleLen)}"/><c:if test="${fn:length(dest.destTitle) > titleLen}">..</c:if>
											</span>
										</a>
										<div class="mob_detail_info_area">
											<div class="tit_box">
												<p>상세정보</p>
											</div>
											<div class="info_lst">
												<ul>
													<li>전화번호 : <c:out value="${dest.destPhone}" escapeXml="false" /></li>
													<li>주소: : <c:out value="${dest.destAddress}" escapeXml="false" /></li>
													<li>명칭 : <c:out value="${dest.destTitle}" escapeXml="false" /></li>
												</ul>
											</div>
											<div class="detail_txt">
												<c:out value="${dest.destInformation}" escapeXml="false" />
											</div>
										</div><!-- // detail_info_area -->
										<a href="javascript:;" class="ico_add mob_plus" onclick="addPointMobile(this);">선택</a>
									</div>
								</li>
							</c:forEach>
							</ul>	
							<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="getDestinationList" />
						</div>
					</div>
				</section>
				<%-- 
				<h2>Third Step</h2>
				<section id="wizard-p-2">
					<div class="mob_map" id="map_wrap"></div>				
				</section> 
				--%>
			</div><!--  // wizard -->
		</div>	<!-- // mob_content -->
	</div><!--  // map_area -->
</div>
<div id="media1023"></div>
<!-- // wrap -->
</body>
</html>
