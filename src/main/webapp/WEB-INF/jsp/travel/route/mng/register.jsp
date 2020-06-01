<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<%-- <c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/> --%>
<c:set var="registerFlag" value="${empty travelRoute.routId ? '등록' : '수정'}"/>
<%-- validator:javascript formName="travelRoute" staticJavascript="false" xhtml="true" cdata="false"/  --%>

<div id="content" data-screen-mode="${searchVO.screenMode}">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>그룹 <c:out value='${registerFlag}'/></h3>
                   		<a href="<c:url value="/cms/travel/route/list.do"/>?grpId=${grpId}&type=${type}" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
                   		<a href="javascript:;" onclick="registerRoute();" class="btn btn-small"><i class="icon-ok-sign"></i> <c:out value='${registerFlag}'/></a>
						<%-- <c:if test="${registerFlag == '수정'}"> --%>
						<c:if test="${not empty travelRoute.routId}">
							<a href="javascript:deleteRoute()" class="btn btn-small btn-del" style="float:right;"><i class="icon-minus-sign"></i> 삭제</a>
						</c:if> 
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="travelRoute">
							<form:hidden path="routId" />
							<form:hidden path="routDescription" />
							<form:hidden path="routStartAxis" />
							<form:hidden path="routDestAxis" />
							<table class="table table-bordered table-striped th_left" summary="그룹 테이블">
								<%-- <c:if test="${registerFlag == '수정'}"> --%>
								<c:if test="${not empty travelRoute.routId}">
									<input type="hidden" name="screenMode" value="up" />
									<input type="hidden" id="registerFlag" value="update">
								</c:if>
								<%-- <c:if test="${registerFlag == '등록'}"> --%>
								<c:if test="${empty travelRoute.routId}">
									<input type="hidden" name="screenMode" value="" />
									<input type="hidden" id="registerFlag" value="insert">
								</c:if>
								<tr>
									<th>그룹</th>
									<td>
										<%-- <form:select path="routGroup">
											<option value="">-- 등록된 여행일정 선택 --</option>
											<form:option value="RTGRP00000" label="김작가의강원도여행" />
											<form:option value="RTGRP00001" label="이작가의경기도여행" />
										</form:select> --%>
										<form:select path="routGroup">
											<option value="">-- 등록된 여행일정 선택 --</option>
										<c:forEach var="group" items="${groupList}" varStatus="status">
											<form:option value="${group.routGroup}" label="${group.routTitle}" />
										</c:forEach>
										</form:select>
										<form:input path="routTitle" cssClass="txt" size="200" maxlength="100"/>
										&nbsp;<form:errors path="routTitle" />
										<span><strong>신규 여행일정일 때만 입력합니다</strong></span>
									</td>
								</tr>
								<tr>
									<th>일차</th>
									<td>
										<select id="routDays" name="routDays">
										<c:forEach begin="1" end="10" step="1" var="day">
											<option value='<c:out value="${day}" />'><c:out value="${day}" />일차</option>
										</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>출발지</th>
									<td>
										<form:input path="routStartPoint" cssClass="txt" size="200" maxlength="100" />
										&nbsp;<form:errors path="routStartPoint" />
									</td>
								</tr>
								<tr>
									<th>도착지</th>
									<td>
										<form:input path="routDestPoint" cssClass="txt" size="200" maxlength="100" />
										&nbsp;<form:errors path="routDestPoint" />
									</td>
								</tr>
								<tr>
									<th>지역</th>
									<td>
										<select class="sc_local" name="routRegion" id="routRegion">
			                            <c:forEach var="region" items="${regionList}" varStatus="status">
			                        		<option value='<c:out value="${region.destRegion}"/>'><c:out value="${region.destRegion}"/></option>
					                    </c:forEach>
										</select>

										<select class="sc_local" name="destCategory" id="destCategory">
											<option value="관광지">관광</option>
											<option value="숙박">숙박</option>
											<option value="체험">레져</option>
											<option value="음식점">식당</option>
											<option value="쇼핑">쇼핑</option>
										</select>

										<select class="sc_local" name="routDestination" id="routDestination">
			                            <c:forEach var="dest" items="${destList}" varStatus="status">
			                        		<option value='<c:out value="${dest.destId}"/>'><c:out value="${dest.destTitle}"/></option>
					                    </c:forEach>
										</select>
										<%-- <a href="javascript:;" onClick="addPoint();" class="btn btn-small"><i class="icon-check"></i>포인트 추가</a> --%>
										<a href="javascript:;" onClick="getDestinationDetail();" class="btn btn-small"><i class="icon-check"></i>포인트 추가</a>
									</td>
								</tr>
								<tr>
									<th>경유일정</th>
									<td>
										<dir id="destPoints"></dir>
									</td>
								</tr>
							</table>
							<input type="hidden" name="searchCondition" value="<c:out value='${travelRoute.searchCondition}'/>"/>
							<input type="hidden" name="searchKeyword" value="<c:out value='${travelRoute.searchKeyword}'/>"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${travelRoute.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function deleteRoute(){
	// var registerFlag = document.getElementById("registerFlag").value;
	var frm = document.getElementById("travelRoute");
	frm.action = "/cms/travel/route/delete.do";
	frm.submit();
}
function registerRoute(){
	var registerFlag = document.getElementById("registerFlag").value;
	var frm = document.getElementById("travelRoute");
	// frm.action = "/cms/travel/route/"+registerFlag+".do?type="+type+"&grpId="+grpId;
	frm.action = "/cms/travel/route/"+registerFlag+".do";
	frm.submit();
}

function addPoint() {
	var point = $("#routDestination option:selected").text();
	var item = "<span class=\"btn btn-small\"><i class=\"icon-picture\">"+point+"</span>";
	$("#destPoints").append(item);
}
function delPoint(obj) {
	$(obj).closest('div.detailzone').remove();
	setDescriptionValue();
}

function getDestinationList() {
   	var reqUrl = "/travel/destination/retrieveDestinationList.do";
    var promise = getAsyncDataList(reqUrl);
    promise.success(function (data) {
    	setDestinationList(data);
    });
}
function getAsyncDataList(reqUrl) {
	var region = $("select[name='routRegion']").val();
	var cate = $("select[name='destCategory']").val();
	var formData = "destRegion=" + region + "&destCategory=" + cate;
    return $.ajax({
        type: "GET"
        , url: reqUrl
        , data:formData
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , error: function(data, status, err) { 
            alert('서버와의 통신이 실패했습니다.');
        }
    });
}
function setDestinationList(data) {
	// console.log(data);
	var obj = JSON.parse(data);
	// console.log(obj.constructor); return;
    if(obj.constructor !== Array){
    	console.log("데이터를 가져오지 못했습니다."); return;
    }else{
        var lists = "";
    	for(var i=0; i<obj.length; i++) {
			lists += "<option value=\""+obj[i]["destId"]+"\">"+obj[i]["destTitle"]+"</option>";
		}
       	$("#routDestination").empty();
       	$("#routDestination").append(lists);
    }
}
function getDestinationDetail(idx) {
	// var thumb_img_path = "https://www.seantour.com";
	var destId = idx ? idx : $("#routDestination option:selected").val();
	$.get('/travel/destination/retrieveDestinationDetail.do?destId='+destId, function(data) {
		var obj = JSON.parse(data);
		if(obj && obj.hasOwnProperty("destTitle")) {

			setDescriptionList(obj);

			setDescriptionValue();
		}
	});
}
function setDescriptionValue() {
	var routDescription = "";
	$(".detailzone").each(function(index){
		if (index > 0) {
			routDescription += "|" + $(this).data('destid');
		} else {
			routDescription += $(this).data('destid');
		}
	});
	$("#routDescription").val(routDescription);
}

function setDescriptionList(obj) {
	var thumb_img_path = "https://www.seantour.com";
	var contents = 
		"<div class=\"detailzone\" data-destid=\""+obj.destId+"\">"+
			"<ul class=\"lst\">"+
				"<li><img src=\""+thumb_img_path + obj.destImgPath+"\" alt=\""+obj.destTitle+"\" style=\"width:450px;height:300px;\" /></li>"+
			"</ul>"+
			"<ul>"+
				"<li>명칭 : "+obj.destTitle+"</li>"+
				"<li>전화번호 : "+obj.destPhone+"</li>"+
				"<li>주소 : "+obj.destAddress+" </li>"+
				"<li><a href=\"javascript:;\" onClick=\"delPoint(this);\" class=\"btn btn-small\"><i class=\"icon-cut\"></i>취소</a></li>"+
			"</ul>"+
		"</div>";
	$("#destPoints").append(contents);
}

function addrCallBack(roadFullAddr, latitude, longitude, objId){
	var addrObj = $("#" + objId);
	addrObj.val(roadFullAddr);
	addrObj.attr('data-lat', latitude);
	addrObj.attr('data-lon', longitude);

		console.log("objId", objId);
	var axis = objId.replace('Point', 'Axis');
		console.log("objId", axis);
	var axisObj = $("#" + axis);
		console.log("axisObj", axisObj);
	axisObj.val(latitude +","+ longitude);
}

$(function(){

	$("#routRegion, #destCategory").bind("change",function(){
	   	var reqUrl = "/travel/destination/retrieveDestinationList.do";
	    var promise = getAsyncDataList(reqUrl);
	    promise.success(function (data) {
	    	setDestinationList(data);
	    });
	});

	$("#routStartPoint, #routDestPoint").bind("click",function(){
		var status = $(this).attr('id');
		window.open("/cms/travel/route/searchPoi.do?status="+status,"pop","width=600,height=650, scrollbars=yes, resizable=yes");
	});

	console.log("screen-mode", $("#content").data('screen-mode'));

	var routDescription = $("#routDescription").val();
	var routId = $("#routId").val();
	// if($("#content").data('screen-mode') == "up" && routDescription) {
	if(routId && routDescription) {
		var descArr = routDescription.split("|");
		for (i=0; i < descArr.length; i++){
			getDestinationDetail(descArr[i]);
		}
	}

});

</script>
<!-- 검색조건 유지 -->
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
