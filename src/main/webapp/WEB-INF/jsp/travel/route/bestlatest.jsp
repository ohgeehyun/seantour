<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<div class="tit_box">
	<p class="txt">국내 인기 바다여행지를 추천해드립니다.</p>
    <p class="tit">베스트 <strong>여행 추천 일정</strong></p>
</div>
<div class="vest_recommend_box">
	<div class="name_tit">BEST 여행일정</div>
	<div class="col01">
	<c:if test="${fn:length(resultList) gt 0}">
		<c:set var="firstThumbPath" value="${empty resultList[0].routThumbPath ? 'seantour_map/images/travel/content/noimg.jpg' : resultList[0].routThumbPath}" />
		<div class="img"><a href="#none"><img src='<c:url value="${firstThumbPath}"/>' alt='<c:out value="${resultList[0].routTitle}"/>' /></a></div>
		<div class="tbox">
			<span><c:if test="${not empty resultList[0].routRegion}">[<c:out value="${resultList[0].routRegion}"/>]</c:if></span>
			<p><c:out value="${resultList[0].routTitle}" escapeXml="false" /></p>
		</div>
	</c:if>	
	</div>
	<div class="col02">
		<ul>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:if test="${status.index gt 0}">
			<c:set var="routThumbPath" value="${empty result.routThumbPath ? 'seantour_map/images/travel/content/noimg.jpg' : result.routThumbPath}" />
			<li>
				<a href="#none">
    				<span class="img"><img src='<c:url value="${routThumbPath}"/>' alt='<c:out value="${result.routTitle}"/>' /></span>
    				<span class="text"><span class="local"><c:if test="${not empty result.routRegion}">[<c:out value="${result.routRegion}"/>]</c:if></span><c:out value="${result.routTitle}"/></span>
				</a>
			</li>
		</c:if>
	</c:forEach>
		</ul>
	</div>
</div> 
