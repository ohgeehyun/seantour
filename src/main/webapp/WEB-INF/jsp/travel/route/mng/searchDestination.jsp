<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행지 검색</title>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/search.css"/>">
<style type="text/css">
select.select {
	width:15%;
	border: 2px solid #ff7a00;
	height:30px;
	font-size: 15px;
}
</style>
</head>
<body>
<div class="mainDiv">
	<input type="hidden" id="inpPage" type="text" value="1">
	<input type="hidden" id="inpTotLimit" type="text" value="7">
    <div id="divtop">
        <h3>
            <span class="ico_sch"></span>
            <span class="top_tit">여행지 검색</span>
        </h3>
    </div>
	<form:form commandName="travelDestination" method="post" data-loginId="${loginVO.mbrId}">
    <div id="divcont">
        <div id="divSearch">
            <fieldset class="search_box">
                <legend class="blind">검색어 입력창</legend>
                <div class="inputGrp">
                    <button class="btn_sch" name="btn_sch" id="inpSearch" onclick="fn_egov_link_page(1);return false;">
                        <span class="ico_sch"></span>
                    </button>
                    <div class="input_sch">
						<%-- <form:select path="destRegion" cssClass="select" onchange="fn_egov_link_page(1);" style="width:15%;"> --%>
						<form:select path="destRegion" cssClass="select" style="width:15%;">
							<option value="">지역</option>
	                    	<form:options items="${regionList}" itemLabel="destRegion" itemValue="destRegion"/>
	                    </form:select>
						<%-- <select class="select" name="destCategory" id="destCategory" onchange="fn_egov_link_page(1);"> --%>
						<select class="select" name="destCategory" id="destCategory">
							<option value="">분류</option>
							<option value="관광지" <c:if test="${travelDestination.destCategory eq '관광지'}">selected</c:if>>관광</option>
							<option value="숙박" <c:if test="${travelDestination.destCategory eq '숙박'}">selected</c:if>>숙박</option>
							<option value="체험" <c:if test="${travelDestination.destCategory eq '체험'}">selected</c:if>>레져</option>
							<option value="음식점" <c:if test="${travelDestination.destCategory eq '음식점'}">selected</c:if>>식당</option>
							<option value="쇼핑" <c:if test="${travelDestination.destCategory eq '쇼핑'}">selected</c:if>>쇼핑</option>
						</select>
                        <input type="text" id="searchKeyword" name="searchKeyword" title="검색" placeholder="예) 경포대, 바다식당" style="width:65%;margin:0 5px;" value="<c:out value='${travelDestination.searchKeyword}'/>">
                    </div>
                </div>
            </fieldset>
        </div>
        <div id="divSearchlist">
           <div class="result">
               <p>검색결과 : 총 <strong id="spanTotCnt"><c:out value="${allCnt}" /></strong>건</p>
           </div>
            <div class="tb_wrap">
                <table class="result-tbl">
                    <caption class="blind">검색결과 리스트</caption>
                    <thead>
                        <tr>
                            <th>썸네일</th>
                            <th>명칭</th>
                            <th>주소</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyResult">
					<c:forEach var="result" items="${resultList}" varStatus="status">	
						<%-- <c:set var="destImgPath" value="${empty result.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(result.destImgPath)}" /> --%>
                        <tr style="cursor:pointer;" onclick="setRouteWayPoint('<c:out value="${result.destId}"/>', '<c:out value="${result.destTitle}"/>');">
                        	<td>
                            <c:if test="${fn:length(result.travelFileList) eq 0}">  
                                <c:set var="destImgPath" value="${empty result.destImgPath ? '/images/travel/content/noimg.jpg' : result.destImgPath}" />
                                <img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${result.destTitle}"/>' style="width:100px;height:80px;" />
                            </c:if>
                            <c:if test="${fn:length(result.travelFileList) gt 0}">
                                <img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${result.destTitle}"/>' style="width:100px;height:80px;" />
                            </c:if>
                            </td>
                        	<td><c:out value="${result.destTitle}"/></td>
                        	<td><c:out value="${result.destAddress}"/></td>
                        </tr>
					</c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
		<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="fn_egov_link_page" />
		<form:hidden path="pageIndex" />
		<input type="hidden" name="idx" value="<c:out value='${idx}'/>"/>
	</form:form>
	
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
function fn_egov_link_page(pageNo){
	document.getElementById("travelDestination").pageIndex.value = pageNo;
	document.getElementById("travelDestination").action = "<c:url value='/cms/travel/route/searchDestination.do'/>";
   	document.getElementById("travelDestination").submit();
}

// 검색어 입력 창
$('#searchKeyword').keydown(function(e){
	if(e.keyCode == 13) {
		// $('.btn_sch').trigger('click');
		fn_egov_link_page(1);
	}
});

function setRouteWayPoint(destId, destTitle) {
	var idx = $("input[name='idx']").val();
	if(typeof(window.opener) != "undefined") {
		window.opener.pointCallBack(idx, destId, destTitle);
		window.self.close();
	}			
}

$(function(){
	// init();
	
});
</script>

</div>	
</body>
</html>