<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1">
<title>해양레저</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/base.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/font.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/layout.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/common.css"/>">
<%-- for 여행지 페이징 --%>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/travel.destination.register.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/map_mob.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/slick.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/aos.css"/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <script src="/js/travel/jquery.min.js"/>"></script>
<script src="/js/travel/jquery-ui.min.js"/>"></script> -->
<script type="text/javascript" src="<c:url value="/js/travel/jquery-1.12.2.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/modernizr-2.6.2.min.js"/>"></script>
<!-- <script type="text/javascript" src="<c:url value="/js/travel/jquery-1.9.1.min.js"/>"></script> -->
<script type="text/javascript" src="<c:url value="/js/travel/jquery.cookie-1.3.1.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/jquery.steps.js"/>"></script>

<script type="text/javascript" src="<c:url value="/js/travel/jquery.bxslider.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/TweenMax.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/slick.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/aos.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/modal.js"/>"></script> 

<script type="text/javascript" src="<c:url value="/js/travel/common.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/content.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/main.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/travel/mob_map.js"/>"></script>
<!-- tmap api -->
<%-- <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=<spring:message code='Travel.Api.Tmap.Appkey' />"></script> --%>
<script src="https://apis.openapi.sk.com/tmap/js?version=1&format=javascript&appKey=<spring:message code='Travel.Api.Tmap.Appkey' />"></script>
<%-- <script src="<c:url value="/js/travel/travel.route.js"/>"></script> --%>
<script src="<c:url value="/js/travel/travel.route.mobile.js"/>"></script>
<%-- <script src="<c:url value="/js/travel/travel.route.api.tmap.js"/>"></script> --%>
<script src="<c:url value="/js/travel/travel.route.api.tmap.mobile.js"/>"></script>
<script type="text/javascript">
var appKey = "<spring:message code='Travel.Api.Tmap.Appkey' />";
var contextPath = '<c:url value="/"/>';
</script>
</head>
<body onload="initTmap()">
<%-- <body> --%>
<div id="wrap" style="position:static;">
	<div id="accessibility"><a href="#content">본문 바로가기</a></div>
	<!-- header -->
	<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
	<!-- // header -->

	<div id="wizard">
		<h2>First Step</h2>
		<section id="wizard-p-0">
			<div id="myModal" class="modal mob_memo_box">
			<form name="travelRoute" action="" method="post">
				<%-- <input type="hidden" name="startAxis" id="startAxis">
				<input type="hidden" name="destAxis" id="destAxis"> --%>
				<input type="hidden" name="routId" id="routId" value='<c:out value="${travelRoute.routId}" />'>
				<input type="hidden" name="routRegMember" id="routRegMember" value="${loginVO.mbrId}">
				<input type="hidden" name="pageIndex" id="pageIndex" value="${paginationInfo.currentPageNo}">
				<div class="modal-content">
					<p class="tit">나의 메모</p>
					<div class="txt_memo">
						<textarea id="routMemo" name="routMemo" cols="30" rows="5" placeholder="메모입력란입니다"><c:out value="${travelRoute.routMemo}" escapeXml="false" /></textarea>
					</div>
					<div class="memo_btn">
						<a href="#none" class="close">취소</a>
						<a href="#none" class="add">등록</a>
					</div>
				</div>
			</form>
			</div>
			<div class="schedule_tbox">
				<div>
					<input type="text" name="routTitle" id="routTitle" class="sc_tit" placeholder="나만의 여행일정 제목을 입력하세요." value='<c:out value="${travelRoute.routTitle}"/>' />
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
				<a href="javascript:;" class="button w33 border" onclick="saveTravelRoute();"><span>저장</span></a>
				<!-- <a href="#none" class="button w33 border"><span>수정</span></a> -->
				<a href="javascript:;" class="button w33 lightblue" onclick="launchMap();"><span>지도보기</span></a>
			</div>
		</section><!-- // mob_content -->
		<!-- // cotent -->
		<h2>Second Step</h2>
		<section id="wizard-p-1">
			<div class="form_content">
				<select class="sc_local" name="dest_region" id="dest_region" onchange="changeDestinationRegion(1);">
					<%-- <option value="">지역</option> --%>
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
						<li class="cat-box" data-category="관광지"><a href="javascript:;" onclick="getDestinationList(1,'관광지');" class="cate-btn">관광</a>
							<div class="cssSelect">
								<button type="button">태그선택</button>
								<ul class="lst">
									<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
								<c:forEach var="tour" items="${catList['관광지']}" varStatus="status">
									<li><label><input type="checkbox" name="destTag" value="<c:out value="${tour}"/>" class="check" /><c:out value="${tour}"/></label></li>
								</c:forEach>
								</ul>
							</div>
						</li>
						<li class="cat-box" data-category="숙박"><a href="javascript:;" onclick="getDestinationList(1,'숙박');" class="cate-btn">숙박</a>
							<div class="cssSelect">
								<button type="button">태그선택</button>
								<ul class="lst">
									<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
								<c:forEach var="lodging" items="${catList['숙박']}" varStatus="status">
									<li><label><input type="checkbox" name="destTag" value="<c:out value="${lodging}"/>" class="check" /><c:out value="${lodging}"/></label></li>
								</c:forEach>
								</ul>
							</div>
						</li>
						<li class="cat-box" data-category="체험"><a href="javascript:;" onclick="getDestinationList(1,'체험');" class="cate-btn">레져</a>
							<div class="cssSelect">
								<button type="button">태그선택</button>
								<ul class="lst">
									<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
								<c:forEach var="leisure" items="${catList['체험']}" varStatus="status">
									<li><label><input type="checkbox" name="destTag" value="<c:out value="${leisure}"/>" class="check" /><c:out value="${leisure}"/></label></li>
								</c:forEach>
								</ul>
							</div>
						</li>
						<li class="cat-box" data-category="음식점"><a href="javascript:;" onclick="getDestinationList(1,'음식점');" class="cate-btn">식당</a>
							<div class="cssSelect">
								<button type="button">태그선택</button>
								<ul class="lst">
									<li><label><input type="checkbox" name="checkAll" class="check check-all" />전체 선택</label></li>
								<c:forEach var="food" items="${catList['음식점']}" varStatus="status">
									<li><label><input type="checkbox" name="destTag" value="<c:out value="${food}"/>" class="check" /><c:out value="${food}"/></label></li>
								</c:forEach>
								</ul>
							</div>
						</li>
						<li class="cat-box" data-category="쇼핑"><a href="javascript:;" onclick="getDestinationList(1,'쇼핑');" class="cate-btn">쇼핑</a>
							<div class="cssSelect">
								<button type="button">태그선택</button>
								<ul class="lst">
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
											<li>주소 : <c:out value="${dest.destAddress}" escapeXml="false" /></li>
											<li>명칭 : <c:out value="${dest.destTitle}" escapeXml="false" /></li>
										</ul>
									</div>
									<div class="detail_txt">
										<c:out value="${dest.destInformation}" escapeXml="false" />
									</div>
								</div><!-- // detail_info_area -->
								<a href="javascript:;" class="ico_add mob_plus" onclick="addPoint(this);">선택</a>
							</div>
						</li>
					</c:forEach>
					</ul>	
					<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="getDestinationList" />
				</div>
			</div>
		</section>
		<h2>Third Step</h2>
		<section id="wizard-p-2">
			<div class="mob_map" id="map_wrap"></div>				
		</section>
	</div><!--  // wizard -->
</div>
<!-- // wrap -->
</body>
</html>
