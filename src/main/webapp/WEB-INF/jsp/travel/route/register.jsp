<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1">
<title>해양레저</title>
<link rel="stylesheet" type="text/css" href="/css/travel/base.css">
<link rel="stylesheet" type="text/css" href="/css/travel/font.css">
<link rel="stylesheet" type="text/css" href="/css/travel/layout.css">
<link rel="stylesheet" type="text/css" href="/css/travel/common.css">
<link rel="stylesheet" type="text/css" href="/css/travel/map.css">
<link rel="stylesheet" type="text/css" href="/css/travel/slick.css">
<link rel="stylesheet" type="text/css" href="/css/travel/aos.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="/js/travel/jquery.min.js"></script>
 <script src="/js/travel/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/travel/jquery-1.12.2.min.js"></script>
<script type="text/javascript" src="/js/travel/jquery.bxslider.js"></script>
<script type="text/javascript" src="/js/travel/TweenMax.min.js"></script>
<script type="text/javascript" src="/js/travel/slick.min.js"></script>
<script type="text/javascript" src="/js/travel/aos.js"></script>
<script src="/js/travel/Sortable.js"></script>
<script type="text/javascript" src="/js/travel/common.js"></script>
<script type="text/javascript" src="/js/travel/content.js"></script>
<script type="text/javascript" src="/js/travel/main.js"></script>
<script type="text/javascript" src="/js/travel/root.js"></script>
<!-- tmap api -->
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxdc2398be8423441f817695db47fd1e32"></script>
<script src="/js/travel/travel.route.js"></script>
</head>
<body onload="initTmap()">
	<div id="wrap" style="position:static;">
		<div id="accessibility"><a href="#content">본문 바로가기</a></div>
		<!-- header -->
			<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp" %>
		<!-- // header -->

			<div class="map_wrap_area">
				<div id="map_wrap"></div>
			<form name="travelRoute" action="" method="post">
				<input type="hidden" name="startAxis" id="startAxis">
				<input type="hidden" name="destAxis" id="destAxis">
				<input type="hidden" name="routGroup" id="routGroup" value='<c:out value="${fn:length(routeList) > 0 ? routeList[0].routGroup : groupId}" />'>

				<div id="content">
					<div class="day_info">
						<div class="day_tit"><span>1</span>DAY</div>
						<ul class="day_util">
							<li><a href="#none" class="day_memo">메모</a>
								<div class="memo_box">
									<p class="tit">나의 메모</p>
									<div class="txt_memo">
										<textarea cols="30" rows="5">메모입력란입니다.</textarea>
										
									</div>
									<div class="memo_btn">
										<a href="#none" class="close">취소</a>
										<a href="#none" class="add">등록</a>
									</div>
								</div>
							</li>
							<li><a href="#none" class="day_delect">삭제</a></li>
							<li><a href="#none" class="day_reset">초기화</a></li>
						</ul>
					</div>
					<div  id="day_lst" class="day_lst">
						<ul>

						<c:forEach var="route" items="${routeList}" varStatus="status">
							<li>
								<a href="#none" class="tabh">D-${status.count}</a>
								<div class="tab_con">
									<div class="start">
										<input type="text" class="start_word" placeholder="출발지를 입력하세요" onclick="searchAddress('S', '<c:out value="${status.count}"/>');" value='<c:out value="${route.routStartPoint}" />' 
										<c:if test="${not empty route.routStartAxis}">data-lat='<c:out value="${fn:split(route.routStartAxis,',')[0]}"/>'</c:if> 
										<c:if test="${not empty route.routStartAxis}">data-lon='<c:out value="${fn:split(route.routStartAxis,',')[1]}"/>'</c:if> />
									</div>
									<ul class="tab_list" id="example3Left<c:if test='${status.count gt 1}'>${status.count}</c:if>"  class="list-group col" data-routid="${route.routId}">
									<%-- <c:forTokens items="${route.routePointList}" delims="|" var="routePoint"> --%>
									<c:forEach var="routePoint" items="${route.routePointList}" varStatus="routStat">
										<li data-lat='<c:out value="${routePoint.destAxisY}" />' data-lon='<c:out value="${routePoint.destAxisX}" />' data-destid='<c:out value="${routePoint.destId}" escapeXml="false" />'>
											<div class="img"><img src="${thumbPath}${routePoint.destImgPath}" alt='<c:out value="${routePoint.destTitle}" escapeXml="false" />' /></div>
											<div class="txt_box">
												<p class="txt"><c:out value="${routePoint.destTitle}" escapeXml="false" /></p>
												<p class="sub"><c:out value="${routePoint.destCategory}" /></p>
												<a href="javascript:;" class="more" onclick="getDestinationDetail('<c:out value="${routePoint.destId}" />');">더보기</a>
											</div>
											<div class="icon_box">
												<a href="#none" class="ico_heart">종아요</a>
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

						<c:set var="begin" value="${fn:length(routeList) + 1}" />
						<c:forEach begin="${begin}" end="7" step="1" varStatus="stat">
							<li>
								<%-- <a href="#none" class="tabh">D-<c:out value="${begin + stat.index}"/></a> --%>
								<a href="#none" class="tabh">D-<c:out value="${stat.current}"/></a>
								<div class="tab_con">
									<div class="start">
										<input type="text" class="start_word" placeholder="출발지를 입력하세요" onclick="searchAddress('S', '<c:out value="${stat.current}"/>');" />
									</div>
									<ul class="tab_list" id="example3Left<c:if test='${stat.current gt 1}'><c:out value="${stat.current}"/></c:if>"  class="list-group col"></ul>
									<div class="arrival">
										<input type="text" class="arrival_word" placeholder="도착지를 입력하세요" onclick="searchAddress('E', '<c:out value="${stat.current}"/>');" />
									</div>
								</div>
							</li>
						</c:forEach>

							<%-- 
							<li>
								<a href="#none" class="tabh">D-1</a>
								<div class="tab_con">
									<div class="start">
										<input type="text" class="start_word" id="start_address" placeholder="출발지를 입력하세요" onclick="searchAddress('S', '2');" />
									</div>
									<ul class="tab_list" id="example3Left2"  class="list-group col">
									</ul>
									<div class="arrival">
										<input type="text" class="arrival_word" id="arrival_address" placeholder="도착지를 입력하세요" onclick="searchAddress('E', '2');" />
									</div>
								</div>
							</li>
							--%>
						</ul>
						<a href="#none" class="plus">DAY</a>
						<a href="#none" class="heart">MY</a>
						<a href="javascript:;" class="save" onclick="saveTravelRoute();">SAVE</a>
					</div><!-- //day_lst -->
					<div class="tour_schedule_detail open">
						<div class="schedule_tbox">
							<div><input type="text" name="routTitle" id="routTitle" class="sc_tit" placeholder="나만의 여행일정 제목을 입력하세요." value='<c:out value="${fn:length(routeList) > 0 ? routeList[0].routTitle : ''}"/>' /></div>
							<div>
								<select class="sc_local" name="dest_region" id="dest_region" onchange="getDestinationList();">
									<%-- <option value="">지역</option> --%>
	                            <c:forEach var="region" items="${regionList}" varStatus="status">
	                        		<option value='<c:out value="${region.destRegion}"/>' <c:if test="${fn:length(routeList) > 0 and routeList[0].routRegion eq region.destRegion}">selected="selected"</c:if>><c:out value="${region.destRegion}"/></option>
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
									<li><a href="javascript:;" onclick="getDestinationList('관광지');" class="cate-btn">관광</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst">
												<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />공원</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />낚시터</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />등대</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />문화유적</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />섬</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />어시장</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />어촌체험마을</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />영화/드라마 촬영지</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />유람선</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />일출/낙조경관도로</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />전망대/조망시설</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />전시관</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />캠핑장</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />항구</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />해수욕장</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />해안 자전거길</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />해양레포츠</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />해양산책로</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />기타관광지</a></li>
											</ul>
										</div>
									</li>
									<li><a href="javascript:;" onclick="getDestinationList('숙박');" class="cate-btn">숙박</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst">
												<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />게스트하우스</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />리조트/콘도</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />민박</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />여관/모텔</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />캠핑장</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />펜션</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />호텔</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />기타</a></li>
											</ul>
										</div>
									</li>
									<li><a href="javascript:;" onclick="getDestinationList('체험');" class="cate-btn">레져</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst">
												<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />체험프로그램</a></li>
											</ul>
										</div>
									</li>
									<li><a href="javascript:;" onclick="getDestinationList('음식점');" class="cate-btn">식당</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst">
												<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />양식</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />일식</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />중식</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />한식</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />횟집</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />기타</a></li>
											</ul>
										</div>
									</li>
									<li><a href="javascript:;" onclick="getDestinationList('쇼핑');" class="cate-btn">쇼핑</a>
										<div class="cssSelect">
											<button type="button">태그선택</button>
											<ul class="lst">
												<li><a href="#none"><input type="checkbox" class="check" />전체 선택</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />가공</a></li>
												<li><a href="#none"><input type="checkbox" class="check" />신선제품</a></li>
											</ul>
										</div>
									</li>
								</ul>
							</div>
							
							<ul class="result_list" id="example3Right" class="list-group col">
							<c:forEach var="dest" items="${destList}" varStatus="status">
								<%-- <li data-lat='<c:out value="${fn:split(dest.destLocationAxis,',')[0]}" />' data-lon='<c:out value="${fn:split(dest.destLocationAxis,',')[1]}" />' data-destid='<c:out value="${dest.destId}" escapeXml="false" />'> --%>
								<li data-lat='<c:out value="${dest.destAxisY}" />' data-lon='<c:out value="${dest.destAxisX}" />' data-destid='<c:out value="${dest.destId}" escapeXml="false" />'>
									<div class="img"><img src="${thumbPath}${dest.destImgPath}" alt='<c:out value="${dest.destTitle}" escapeXml="false" />' /></div>
									<div class="txt_box">
										<p class="txt"><c:out value="${dest.destTitle}" escapeXml="false" /></p>
										<p class="sub"><c:out value="${dest.destCategory}" /></p>
										<a href="javascript:;" class="more" onclick="getDestinationDetail('<c:out value="${dest.destId}" />');">더보기</a>
									</div>
									<div class="icon_box">
										<a href="#none" class="ico_heart">종아요</a>
										<a href="javascript:;" class="ico_add" onclick="addPoint(this);">추가</a>
										<a href="javascript:;" class="ico_close" onclick="delPoint(this);">닫기</a>
									</div>
								</li>
							</c:forEach>
							</ul>
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
									<li><img src="/images/travel/map/img_detail01.jpg" alt="" /></li>
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
			<!-- // cotent -->
			
			<div id="mob_content">
				<div class="line_arrow"><img src="/images/travel/map/icon_line_arr.gif" alt="" /></div>
				<dl class="day_sc">
					<dt class="day_title"><a href="#none">1DAY</a></dt>
					<dd class="day_area first">
						<ul class="day_list">
							<li>
								<span class="num">1</span>
								<div class="day_box">
									<a href="#none" class="tbox">
										<span class="sub">공원</span>
										<span class="txt">[공수마을]오링대공원</span>
									</a>
									<a href="#none" class="delect">삭제</a>
								</div>
							</li>
							<li>
								<span class="num">2</span>
								<div class="day_box">
									<a href="#none" class="tbox">
										<span class="sub">레져</span>
										<span class="txt">죽성성당(드라마촬영지)</span>
									</a>
									<a href="#none" class="delect">삭제</a>
								</div>
							</li>
						</ul>	
						<div class="add_btn_area">
							<a href="./map_detail.html" class="local"><span>장소추가</span></a>
							<a href="#none" class="mob_day_memo"><span>메모추가</span></a>
							<div class="mob_memo_box">
								<p class="tit">나의 메모</p>
								<div class="txt_memo">
									<textarea cols="30" rows="5">메모입력란입니다.</textarea>
									
								</div>
								<div class="memo_btn">
									<a href="#none" class="close">취소</a>
									<a href="#none" class="add">등록</a>
								</div>
							</div>
						</div>					
					</dd>
				</dl>
				<dl class="day_sc">
					<dt class="day_title"><a href="#none">2DAY</a></dt>
					<dd class="day_area">
						<ul class="day_list">
							<li>
								<span class="num">1</span>
								<div class="day_box">
									<a href="#none" class="tbox">
										<span class="sub">공원</span>
										<span class="txt">[공수마을]오링대공원</span>
									</a>
									<a href="#none" class="delect">삭제</a>
								</div>
							</li>
							<li>
								<span class="num">2</span>
								<div class="day_box">
									<a href="#none" class="tbox">
										<span class="sub">레져</span>
										<span class="txt">죽성성당(드라마촬영지)</span>
									</a>
									<a href="#none" class="delect">삭제</a>
								</div>
							</li>
						</ul>	
						<div class="add_btn_area">
							<a href="./map_detail.html" class="local"><span>장소추가</span></a>
							<a href="#none" class="mob_day_memo" data-modal="#modal"><span>메모추가</span></a>
							<div class="mob_memo_box" id="modal" class="modal modal__bg" role="dialog" aria-hidden="true">
								<p class="tit">나의 메모</p>
								<div class="txt_memo">
									<textarea cols="30" rows="5">메모입력란입니다.</textarea>
									
								</div>
								<div class="memo_btn">
									<a href="#none" class="close">취소</a>
									<a href="#none" class="add">등록</a>
								</div>
							</div>
						</div>					
					</dd>
				</dl>
				<div class="day_add"><a href="#none" class="btn_add"><span>DAY 추가</span></a></div>
				<div class="day_save"><a href="#none" class="btn_save"><span>저장</span></a></div>
			</div><!-- // mob_content -->
			<div id="mob_content2">
				<ul class="day_list">
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">공원</span>
								<span class="txt">[공수마을]오링대공원</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
					<li>
						<div class="day_box">
							<a href="#none" class="tbox">
								<span class="sub">레져</span>
								<span class="txt">죽성성당(드라마촬영지)</span>
							</a>
							<a href="#none" class="mob_plus">선택</a>
						</div>
					</li>
				</ul>	
				<div style="margin:20px 0;" class="day_save tac"><a href="#none" class="button"><span>등록</span></a></div>
			</div>

		</div>
	</div>
	<!-- // wrap -->
</body>
</html>
