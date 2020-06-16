<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
	<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
</head>
<body>
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

					 	<h3 class="fame_tit">인기 키워드</h3>
						<div class="popular_srch">
							<ul>
							<c:forEach var="hashtag" items="${tagMap}" varStatus="status">
								<%-- <li><a href="#none" style='font-size:<c:out value="${hashtag.value + 13}"/>px'>#<c:out value="${hashtag.key}"/></a></li> --%>
								<li><span style='font-size:<c:out value="${hashtag.value + 13}"/>px'>#<c:out value="${hashtag.key}"/></span></li>
							</c:forEach>
							</ul>
						</div>
						<h3 class="fame_tit">추천 여행지</h3> 	
						<div class="recommend_tour_box">
							<div class="tab_menu">
								<ul>
									<li><a href="#none">계절별</a></li>
									<li><a href="#none">지역별</a></li>
									<li><a href="#none">베스트추천</a></li>
								</ul>
							</div>
							<div class="recommend_box">
								<div class="season_area">
									<h4 class="recommend_tit">봄</h4>
									<ul>
									<c:forEach var="spring" items="${springList}" varStatus="springStat">	
										<li>
										<a href='<c:url value="/travel/destination/detail.do?destId=${spring.destId}"/>'>
											<span class="num">${springStat.count}</span>
											<span class="tit"><c:out value="${fn:substring(spring.destTitle, 0, 12)}"/><c:if test="${fn:length(spring.destTitle) > 12}">...</c:if></span>
											<span class="img">
												<%-- <c:set var="destImgPath" value="${empty spring.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(spring.destImgPath)}" /> --%>
											<c:if test="${fn:length(spring.travelFileList) eq 0}">	
												<c:set var="destImgPath" value="${empty spring.destImgPath ? '/images/travel/content/noimg.jpg' : spring.destImgPath}" />
												<img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${spring.destTitle}"/>' style="width:52px;height:52px;" />
											</c:if>
											<c:if test="${fn:length(spring.travelFileList) gt 0}">
												<img src='<c:url value="${spring.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${spring.destTitle}"/>' style="width:52px;height:52px;" />
											</c:if>
											</span>
										</a>
										</li>
									</c:forEach>
									</ul>
								</div>
								<div class="season_area">
									<h4 class="recommend_tit">여름</h4>
									<ul>
									<c:forEach var="summer" items="${summerList}" varStatus="summerStat">	
										<li>
										<a href='<c:url value="/travel/destination/detail.do?destId=${summer.destId}"/>'>
											<span class="num">${summerStat.count}</span>
											<span class="tit"><c:out value="${fn:substring(summer.destTitle, 0, 12)}"/><c:if test="${fn:length(summer.destTitle) > 12}">...</c:if></span>
											<span class="img">
												<%-- <c:set var="destImgPath" value="${empty summer.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(summer.destImgPath)}" /> --%>
											<c:if test="${fn:length(summer.travelFileList) eq 0}">	
												<c:set var="destImgPath" value="${empty summer.destImgPath ? '/images/travel/content/noimg.jpg' : summer.destImgPath}" />
												<img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${summer.destTitle}"/>' style="width:52px;height:52px;" />
											</c:if>
											<c:if test="${fn:length(summer.travelFileList) gt 0}">
												<img src='<c:url value="${summer.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${summer.destTitle}"/>' style="width:52px;height:52px;" />
											</c:if>
											</span>
											</a>
										</li>
									</c:forEach>
									</ul>
								</div>
								<div class="season_area">
									<h4 class="recommend_tit">가을</h4>
									<ul>
									<c:forEach var="autumn" items="${autumnList}" varStatus="autumnStat">	
										<li>
										<a href='<c:url value="/travel/destination/detail.do?destId=${autumn.destId}"/>'>
											<span class="num">${autumnStat.count}</span>
											<span class="tit"><c:out value="${fn:substring(autumn.destTitle, 0, 12)}"/><c:if test="${fn:length(autumn.destTitle) > 12}">...</c:if></span>
											<span class="img">
												<%-- <c:set var="destImgPath" value="${empty autumn.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(autumn.destImgPath)}" /> --%>
											<c:if test="${fn:length(autumn.travelFileList) eq 0}">	
												<c:set var="destImgPath" value="${empty autumn.destImgPath ? '/images/travel/content/noimg.jpg' : autumn.destImgPath}" />
												<img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${autumn.destTitle}"/>' style="width:52px;height:52px;" />
											</c:if>
											<c:if test="${fn:length(autumn.travelFileList) gt 0}">
												<img src='<c:url value="${autumn.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${autumn.destTitle}"/>' style="width:52px;height:52px;" />
											</c:if>
											</span>
											</a>
										</li>
									</c:forEach>
									</ul>
								</div>
								<div class="season_area">
									<h4 class="recommend_tit">겨울</h4>
									<ul>
									<c:forEach var="winter" items="${winterList}" varStatus="winterStat">	
										<li>
										<a href='<c:url value="/travel/destination/detail.do?destId=${winter.destId}"/>'>
											<span class="num">${winterStat.count}</span>
											<span class="tit"><c:out value="${fn:substring(winter.destTitle, 0, 12)}"/><c:if test="${fn:length(winter.destTitle) > 12}">...</c:if></span>
											<span class="img">
												<%-- <c:set var="destImgPath" value="${empty winter.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(winter.destImgPath)}" /> --%>
											<c:if test="${fn:length(winter.travelFileList) eq 0}">	
												<c:set var="destImgPath" value="${empty winter.destImgPath ? '/images/travel/content/noimg.jpg' : winter.destImgPath}" />
												<img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${winter.destTitle}"/>' style="width:52px;height:52px;" />
											</c:if>
											<c:if test="${fn:length(winter.travelFileList) gt 0}">
												<img src='<c:url value="${winter.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${winter.destTitle}"/>' style="width:52px;height:52px;" />
											</c:if>
											</span>
											</a>
										</li>
									</c:forEach>
									</ul>
								</div>
							</div><!-- //recommend_box1 -->
							<div class="recommend_box type3">
								<h3 class="local_tit">
									<span class="sub">지역별</span>
									<span class="tit">인기 여행지</span>
									<span class="txt">BEST SPOT</span>
								</h3>
								<div class="selection_map_area map01">
									<div class="selection_map"> 
										<img src="<c:url value="/images/travel/content/map_map01.png"/>" alt="" usemap="#Map" border="0" id="map-image" />
								        <map name="Map" id="Map">
								          <area shape="poly" coords="119,21,93,33,76,32,69,38,69,47,63,56,51,74,63,113,78,117,103,90,115,104,134,112,116,134,90,137,71,146,70,162,129,188,174,153,172,104,148,94,146,41,118,21" href="#" id="map01" class="map01" data-region="경기" alt="경기"><!--경기도-->
								          <area shape="poly" coords="132,14,121,20,148,38,150,92,177,104,174,151,191,154,201,143,254,164,318,152,318,135,295,115,295,96,261,62,263,36,238,8,218,8,207,17" href="#" id="map02" class="map02" data-region="강원" alt="강원"><!--강원도-->
								          <area shape="poly" coords="50,80,46,93,44,127,69,145,85,138,78,118,63,117" href="#" id="map17" class="map17" data-region="인천" alt="인천"><!--인천광역-->
								          <area shape="poly" coords="67,170,43,173,28,183,22,190,12,191,8,199,6,211,26,228,41,229,44,233,41,257,53,265,51,287,59,298,81,297,88,277,96,277,109,290,122,283,151,299,159,288,150,265,135,272,122,253,122,244,106,213,126,213,138,203,129,189,101,179" href="#" id="map03" class="map03" data-region="충남" alt="츙남"><!-- 충청남도 -->
								          <area shape="poly" coords="174,155,131,191,143,203,131,215,137,235,151,245,151,264,162,289,184,296,200,273,178,225,216,186,237,193,251,165,203,147,191,155" href="#" id="map04" class="map04" data-region="충북" alt="충북"><!-- 충청북도 -->
								          <area shape="poly" coords="137,236,126,252,136,271,149,261,149,245" href="#" id="map05" class="map05" data-region="대전" alt="대전"><!--대전광역시-->
								          <area shape="poly" coords="316,158,255,166,239,197,220,192,181,225,201,271,186,298,188,314,215,327,218,343,228,344,230,309,258,295,274,315,253,343,270,351,290,346,302,332,344,344,346,315,356,309,356,300,343,284,344,257,352,244,353,214,334,189,334,175" href="#" id="map06" class="map06" data-region="경북" alt="경북"><!--경상북도-->
								          <area shape="poly" coords="293,346,275,356,250,346,220,346,212,329,188,319,162,342,148,383,177,426,230,413,267,412,272,391,301,374,295,361" href="#" id="map07" class="map07" data-region="경남" alt="경남"><!-- 경상남도 -->
								          <area shape="poly" coords="256,297,234,310,232,340,248,341,269,315" href="#" id="map08" class="map08" data-region="대구" alt="대구"><!-- 대구광역시 -->
								          <area shape="poly" coords="181,317,184,300,165,292,153,305,122,288,111,293,97,281,90,280,83,300,63,301,64,330,41,346,46,365,40,368,63,381,82,365,102,373,113,383,145,384,157,339" href="#" id="map09" class="map09" data-region="전북" alt="전북"><!--전라북도-->
								          <area shape="poly" coords="38,374,27,388,28,403,16,411,12,425,20,452,22,468,37,479,43,504,60,503,68,491,88,488,96,471,108,471,112,482,120,488,137,489,156,462,173,451,173,429,146,386,111,387,104,378,85,372,66,384,67,394,63,407,82,426,105,406,95,395,71,395,65,384" href="#" id="map10" class="map10" data-region="전남" alt="전남"><!-- 전라남도-->
								          <area shape="poly" coords="92,398,69,397,67,406,80,424,101,405" href="#" id="map11" class="map11" data-region="광주" alt="광주"><!-- 광주 광역시-->
								          <area shape="poly" coords="127,216,112,215,126,244,135,234" href="#" id="map12" class="map12" data-region="세종" alt="세종"><!-- 세종특별시 -->
								          <area shape="poly" coords="104,95,84,115,88,132,112,131,128,113,116,107" href="#" id="map13" class="map13" data-region=" 서울" alt="서울"><!-- 서울특별시 -->
								          <area shape="poly" coords="304,335,295,346,298,361,306,373,322,387,329,385,329,372,344,356,342,348" href="#" id="map14" class="map14" data-region="울산" alt="울산"><!--울산광역시-->
								          <area shape="poly" coords="314,385,305,374,274,393,271,415,284,416" href="#" id="map15" class="map15" data-region="부산" alt="부산"><!-- 부산광역시 -->
								          <area shape="poly" coords="101,529,79,528,65,536,54,534,40,550,40,565,49,569,58,572,70,566,102,565,118,553,118,544" href="#" id="map16" class="map16" data-region="제주" alt="제주"><!-- 제주특별시-->
								      </map>
									</div>
								<c:set var="regionBan" value="<%= new java.util.HashMap() %>" />
                        		<c:set target="${regionBan}" property="강원" value="local_tit_gw.png"/>
                        		<c:set target="${regionBan}" property="경기" value="local_tit_gg.png"/>
                        		<c:set target="${regionBan}" property="경남" value="local_tit_gn.png"/>
                        		<c:set target="${regionBan}" property="경북" value="local_tit_gb.png"/>
                        		<c:set target="${regionBan}" property="광주" value="local_tit_gj.png"/>
                        		<c:set target="${regionBan}" property="대구" value="local_tit_dg.png"/>
                        		<c:set target="${regionBan}" property="대전" value="local_tit_dj.png"/>
                        		<c:set target="${regionBan}" property="부산" value="local_tit_bs.png"/>
                        		<c:set target="${regionBan}" property="서울" value="local_tit_su.png"/>
                        		<c:set target="${regionBan}" property="세종" value="local_tit_sj.png"/>
                        		<c:set target="${regionBan}" property="울산" value="local_tit_us.png"/>
                        		<c:set target="${regionBan}" property="인천" value="local_tit_ic.png"/>
                        		<c:set target="${regionBan}" property="전남" value="local_tit_jn.png"/>
                        		<c:set target="${regionBan}" property="전북" value="local_tit_jb.png"/>
                        		<c:set target="${regionBan}" property="제주" value="local_tit_jj.png"/>
                        		<c:set target="${regionBan}" property="충남" value="local_tit_cn.png"/>
                        		<c:set target="${regionBan}" property="충북" value="local_tit_cb.png"/>
                            	<%-- <c:if test="${not empty initRegion.destId}"> --%>
                            	<c:if test="${not empty initRegion}">
									<div class="map_status map01">
										<h4 class="tit"><img src='<c:url value="/images/travel/content/${regionBan[initRegion.destRegion]}"/>' alt="<c:out value="${initRegion.destRegion}"/> 추천 여행지" /></h4>
										<div class="img">
											<%-- <c:set var="regionImgPath" value="${empty initRegion.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(initRegion.destImgPath)}" /> --%>
										<c:if test="${fn:length(initRegion.travelFileList) eq 0}">	
											<c:set var="regionImgPath" value="${empty initRegion.destImgPath ? '/images/travel/content/noimg.jpg' : initRegion.destImgPath}" />
											<img src='<c:url value="${regionImgPath}"/>' alt='<c:out value="${initRegion.destTitle}"/>' style='width:505px;height:322px' />
										</c:if>
										<c:if test="${fn:length(initRegion.travelFileList) gt 0}">
											<img src='<c:url value="${initRegion.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${initRegion.destTitle}"/>' style='width:505px;height:322px' />
										</c:if>
											<a href='<c:url value="/travel/destination/detail.do?destId=${initRegion.destId}"/>' class="btn" target="_blank">자세히보기</a>
										</div>
										<div class="t_box">
											<p class="tit"><c:out value="${initRegion.destTitle}"/></p>
											<p class="txt"><%-- 여수해상케이블카는 바다위를 지나 섬과 육지를 연결하는 , 국내 최최의 해상 케이블카입니다. --%>
									        	<c:if test="${not empty initRegion.destInformation}">
										        	<c:set var="description" value='${initRegion.destInformation.replaceAll("\\\<.*?\\\>","")}' />
										        	<c:out value='${fn:substring(description,0,190)}' /><c:if test="${fn:length(description) gt 190}">...</c:if>
									        	</c:if>
											</p>
										</div>
									</div>		
                            	</c:if>	
								</div>
							</div><!-- //recommend_box2 -->						
							<% java.util.ArrayList mosaicArr = new java.util.ArrayList(); %>
                    		<c:set var="mosaicArr" value="${fn:split('width-2|width-5|width-3|width-2|width-2|width-6','|')}" />
							<div class="recommend_box type2">
								<div id="mosaic-grid" class="mosaic-grid">
								<c:forEach var="route" items="${routeList}" varStatus="routeStat">
									<div class="mosaic-tile <c:if test="${routeStat.count eq '1'}">sizer</c:if> <c:out value="${mosaicArr[routeStat.index]}"/> height-2 test mob<c:out value="${routeStat.count}"/> a" <c:if test="${routeStat.count eq '4'}">style="margin-left:1%;"</c:if>>
										<%-- <c:set var="destImgPath" value="${empty route.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(route.destImgPath)}" /> --%>
									<c:if test="${fn:length(route.travelFileList) eq 0}">	
										<c:set var="destImgPath" value="${empty route.destImgPath ? '/images/travel/content/noimg.jpg' : route.destImgPath}" />
										<img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${route.destTitle}"/>' />
									</c:if>
									<c:if test="${fn:length(route.travelFileList) gt 0}">
										<img src='<c:url value="${route.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${route.destTitle}"/>' />
									</c:if>
										<div class="over">
											<a href='<c:url value="/travel/destination/detail.do?destId=${route.destId}"/>'>
												<span class="tit">#<c:out value="${route.destRegion}"/></span>
												<span class="txt">#<c:out value="${route.destTitle}"/></span>
												<c:set var="destAddress" value='${route.destAddress.replaceAll("\\\<.*?\\\>","")}' />
												<span class="location"><c:out value="${destAddress}"/></span>
											</a>
										</div>
									</div>
								</c:forEach>
					            </div>
							</div><!-- //recommend_box3 -->	
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

<link rel="stylesheet" type="text/css" href='<c:url value="/css/travel/landing.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/travel/landing.mosaic.css"/>'>
<script src="<c:url value="/js/travel/mosaic.js"/>"></script>
<script src="<c:url value="/js/travel/jquery.rwdImageMaps.min.js"/>"></script>
<script>
//var thumb_img_path = "https://www.seantour.com";
var thumb_img_path = "";

var regionBan ={};
regionBan["강원"] = "local_tit_gw.png";
regionBan["경기"] = "local_tit_gg.png";
regionBan["경남"] = "local_tit_gn.png";
regionBan["경북"] = "local_tit_gb.png";
regionBan["광주"] = "local_tit_gj.png";
regionBan["대구"] = "local_tit_dg.png";
regionBan["대전"] = "local_tit_dj.png";
regionBan["부산"] = "local_tit_bs.png";
regionBan["서울"] = "local_tit_su.png";
regionBan["세종"] = "local_tit_sj.png";
regionBan["울산"] = "local_tit_us.png";
regionBan["인천"] = "local_tit_ic.png";
regionBan["전남"] = "local_tit_jn.png";
regionBan["전북"] = "local_tit_jb.png";
regionBan["제주"] = "local_tit_jj.png";
regionBan["충남"] = "local_tit_cn.png";
regionBan["충북"] = "local_tit_cb.png";


String.prototype.replaceHtmlEntites = function() {
	var s = this;
	var translate_re = /&(nbsp|amp|quot|lt|gt);/g;
	var translate = {"nbsp": " ","amp" : "&","quot": "\"","lt"  : "<","gt"  : ">"};
	return ( s.replace(translate_re, function(match, entity) {
	  return translate[entity];
	}) );
};

$(document).ready(function() {
	var status = 'status';
	//지도 온표시
	$("#Map area").click(function(){
		// console.log($(this).attr("class"));
		// console.log($(this).data('region'));
		getTravelDestination($(this).data('region'), $(this).attr("class"));

		$("#map-image").attr("src", "<c:url value="/images/travel/content"/>/map_"+$(this).attr("class")+".png");
	});

	// $('img[usemap]').rwdImageMaps(); // TODO: 오류 발생함. coords 가 0으로 설정되는 문제

    var test = {size: 1200, columns: 10};
    // var test2 = {size: 700, columns: 8};
    var grid = $("#mosaic-grid").mosaic({
        tileModel: '.sizer',
        columns: 1,
        gutter: 1,
        heightFromWidth: true,
        // breakpoints: [test, test2]
        breakpoints: [test]
    });

    $(".link").click(function() {
        $(".active").removeClass("active");
        $(this).addClass("active"); 
    });
});

function getTravelDestination(region, mapNo) {
	param = "destRegion="+region;
	url = "<c:url value='/travel/destination/retrieveDestinationRegion.do'/>";
	$.ajax({
		method:"POST",
		url:url,//
		data:param,
		success:function(response){
			// console.log(response); return;
			try {
				var dest = JSON.parse(response);
					// console.log(dest);
				if(dest.destId) {
					// var destImgPath = dest["destImgPath"] == null ? "${pageContext.request.contextPath}/images/travel/content/noimg.jpg" : thumb_img_path + dest["destImgPath"];
					var destImgPath = dest["destImgPath"] == null ? "${pageContext.request.contextPath}/images/travel/content/noimg.jpg" : dest["destImgPath"];
					if(dest["travelFileList"] && dest["travelFileList"].length > 0) {
						thumb_img = dest["travelFileList"][0].imgFilePath;
					}
					var destInformation = (dest["destInformation"] && dest["destInformation"].length > 0) ? dest["destInformation"].replace(/(<([^>]+)>)/ig,"").replaceHtmlEntites().substr(0,190) : "";
			        var lists = "";
					lists += "<div class=\"map_status "+mapNo+"\">";
					lists += "<h4 class=\"tit\"><img src=\"${pageContext.request.contextPath}/images/travel/content/"+regionBan[dest["destRegion"]]+"\" alt=\""+dest["destRegion"]+" 추천 여행지\" /></h4>";
					lists += "<div class=\"img\"><img src=\""+destImgPath+"\" alt=\""+dest["destTitle"]+"\" style=\"width:505px;height:322px\" />";
					lists += "<a href=\"<c:url value="/travel/destination/detail.do?destId="/>"+dest["destId"]+"\" class=\"btn\" target=\"_blank\">자세히보기</a>";
					lists += "</div>";
					lists += "<div class=\"t_box\">";
					lists += "<p class=\"tit\">"+dest["destTitle"]+"</p>";
					lists += "<p class=\"txt\">"+destInformation+"</p>";
					lists += "</div>";
					lists += "</div>";
					$(".map_status").remove();
					$(".selection_map").after(lists);
				} else {
					// console.log("집계된 통계가 없습니다");
					throw new SyntaxError("요청내용을 조회하지 못함");
				}

			} catch (e) {
				// console.log(e.name);
				// console.log(e.message);
				alert("집계된 자료가 아직 없습니다. 양해 부탁드립니다."); return false;
			}
		},
		error:function(request,status,error){
			// console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
</script>
</html>
