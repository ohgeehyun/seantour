<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<div class="writer_recommend_box">
	<div class="name_tit">여행작가<br />추천일정</div>
	<div class="tit_box">
		<p class="txt">국내 인기 바다여행지를 추천해드립니다.</p>
        <p class="tit">여행작가 <strong>여행 추천 일정</strong></p>
    </div>
	<div class="area_ctrl">
		<button type="button" class="play"> 재생</button>
		<button type="button" class="pause active"> 정지</button>
	</div>
	<div class="main_writer_slider">
	<c:forEach var="result" items="${resultList}" varStatus="status">	
		<%-- <c:set var="routThumbPath" value="${empty result.routThumbPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(result.routThumbPath)}" /> --%>
		<c:set var="routThumbPath" value="${empty result.routThumbPath ? '/images/travel/content/noimg.jpg' : result.routThumbPath}" />
		<div class="main_writer_item">
	        <div class="main_writer_img">
	            <img src='<c:url value="${routThumbPath}"/>' alt='<c:out value="${result.routTitle}"/>' />
	        </div>
	        <div class="main_writer_txt">
	        	<p class="tit"><c:out value="${result.routTitle}"/></p>
	        	<%-- <p class="txt"><c:out value="${fn:substring(result.wayPointList[0].destInformation,0,450)}" escapeXml="false" /></p> --%>
	        	<c:if test="${fn:length(result.routeDailyList) gt 0 and fn:length(result.routeDailyList[0].wayPointList) gt 0 and not empty result.routeDailyList[0].wayPointList[0].destInformation}">
		        	<c:set var="description" value='${result.routeDailyList[0].wayPointList[0].destInformation.replaceAll("\\\<.*?\\\>","")}' />
	        	</c:if>
	        	<c:if test="${fn:length(result.routeDailyList) eq 0 or fn:length(result.routeDailyList[0].wayPointList) eq 0 or empty result.routeDailyList[0].wayPointList[0].destInformation}">
		        	<c:set var="description" value='' />
	        	</c:if>
	        	<p class="txt"><c:out value='${fn:substring(description,0,titleLen)}' /><c:if test="${fn:length(description) gt titleLen}">...</c:if></p>
	        	<p class="more2">
	        		<a href='<c:url value="/travel/route/detail.do?routId=${result.routId}"/>'>자세히 보기</a>
	        	</p>
	        </div>
		</div>
	</c:forEach>
	</div>
</div>
