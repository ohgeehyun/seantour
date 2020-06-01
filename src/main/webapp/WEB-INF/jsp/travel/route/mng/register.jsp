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
                   		<h3>일정 <c:out value='${registerFlag}'/></h3>
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
							<table class="table table-bordered table-striped th_left" summary="일정 요약">
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
									<th>제목</th>
									<td>
										<form:input path="routTitle" cssClass="span10" maxlength="100"/>
										&nbsp;<form:errors path="routTitle" />
									</td>
									<th>지역</th>
									<td>
										<form:select path="routRegion">
											<option value="">지역</option>
					                    	<form:options items="${regionList}" itemLabel="destRegion" itemValue="destRegion"/>
					                    </form:select>
										<a href="javascript:;" onClick="addRouteDailyTable(this);" class="btn btn-small"><i class="icon-check"></i>하루일정 추가</a>
										<a href="javascript:;" onClick="delRouteDailyTable(this);" class="btn btn-small"><i class="icon-cut"></i>마지막일정 삭제</a>
									</td>
								</tr>
							</table>
						<c:forEach var="result" items="${travelRoute.routeDailyList}" varStatus="status">
							<table class="tpl-table table table-bordered table-striped th_left" summary="일정 상세" style="margin-top:10px;">
								<input type="hidden" id="routeDailyList<c:out value='${status.index}'/>.routWayPoint" name="routeDailyList[<c:out value='${status.index}'/>].routWayPoint" class="routWayPoint" value="<c:out value='${result.routWayPoint}'/>" />
								<input type="hidden" id="routeDailyList<c:out value='${status.index}'/>.routStartAxis" name="routeDailyList[<c:out value='${status.index}'/>].routStartAxis" class="routStartAxis" value="<c:out value='${result.routStartAxis}'/>" />
								<input type="hidden" id="routeDailyList<c:out value='${status.index}'/>.routDestAxis" name="routeDailyList[<c:out value='${status.index}'/>].routDestAxis" class="routDestAxis" value="<c:out value='${result.routDestAxis}'/>" />
								<tr>
									<th>일차</th>
									<td>
										<input type="text" id="routeDailyList<c:out value='${status.index}'/>.routDays" name="routeDailyList[<c:out value='${status.index}'/>].routDays" class="routDays span1" maxlength="2" value='<c:out value="${result.routDays}"/>'>일차 
										<a href="javascript:;" onClick="searchDestination(this);" class="btn btn-small"><i class="icon-check"></i>경유 포인트 추가</a>
									</td>
								</tr>
								<tr>
									<th>출발지</th>
									<td>
										<input type="text" id="routeDailyList<c:out value='${status.index}'/>.routStartPoint" name="routeDailyList[<c:out value='${status.index}'/>].routStartPoint" class="routStartPoint span4" maxlength="100" value='<c:out value="${result.routStartPoint}"/>'>
									</td>
								</tr>
								<tr>
									<th>경유일정</th>
									<td>
										<div class="destPoints">
											<c:forEach var="dest" items="${result.wayPointList}" varStatus="stat">
											<%-- <c:forTokens items="${result.wayPointList}" delims="|" var="stats" varStatus="stat"> --%>
												<c:if test="${stat.index > 0}">
													<i class="icon-arrow-right">
												</c:if>
													<span class="badge badge-small route-way-point" data-destid='<c:out value="${dest.destId}"/>'><c:out value="${stat.index + 1}"/> - <c:out value="${dest.destTitle}"/></span>
												<c:if test="${stat.index > 0}">
													</i>
												</c:if>
											</c:forEach>
										</div>
									</td>
								</tr>
								<tr>
									<th>도착지</th>
									<td>
										<input type="text" id="routeDailyList<c:out value='${status.index}'/>.routDestPoint" name="routeDailyList[<c:out value='${status.index}'/>].routDestPoint" class="routDestPoint span4" maxlength="100" value='<c:out value="${result.routDestPoint}"/>'>
									</td>
								</tr>
							</table>
						</c:forEach>
						<c:if test="${fn:length(travelRoute.routeDailyList) eq 0}">
							<table class="tpl-table table table-bordered table-striped th_left" summary="일정 상세" style="margin-top:10px;">
								<form:hidden path="routeDailyList[0].routWayPoint" cssClass="routWayPoint" />
								<form:hidden path="routeDailyList[0].routStartAxis" cssClass="routStartAxis" />
								<form:hidden path="routeDailyList[0].routDestAxis" cssClass="routDestAxis" />
								<tr>
									<th>일차</th>
									<td>
										<form:input path="routeDailyList[0].routDays" cssClass="routDays span1" maxlength="2"/>
										&nbsp;<form:errors path="routeDailyList[0].routDays" />일차 
										<a href="javascript:;" onClick="searchDestination(this);" class="btn btn-small"><i class="icon-check"></i>경유 포인트 추가</a>
									</td>
								</tr>
								<tr>
									<th>출발지</th>
									<td>
										<form:input path="routeDailyList[0].routStartPoint" cssClass="routStartPoint span4" maxlength="100" />
										&nbsp;<form:errors path="routeDailyList[0].routStartPoint" />
									</td>
								</tr>
								<tr>
									<th>경유일정</th>
									<td>
										<div class="destPoints"></div>
									</td>
								</tr>
								<tr>
									<th>도착지</th>
									<td>
										<form:input path="routeDailyList[0].routDestPoint" cssClass="routDestPoint span4" maxlength="100" />
										&nbsp;<form:errors path="routeDailyList[0].routDestPoint" />
									</td>
								</tr>
							</table> 
						</c:if>
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
	frm.action = "<c:url value="/cms/travel/route/delete.do"/>";
	frm.submit();
}
function registerRoute(){
	var registerFlag = document.getElementById("registerFlag").value;
	var frm = document.getElementById("travelRoute");
	// frm.action = "<c:url value="/cms/travel/route/"/>"+registerFlag+".do?type="+type+"&grpId="+grpId;
	frm.action = "<c:url value="/cms/travel/route/"/>"+registerFlag+".do";
	frm.submit();
}

function addRouteDailyTable() {
	var len = $("table.tpl-table").length;
	var tpl = $("table.tpl-table").last();
	tpl.css('border', '1px solid red');
	console.log(tpl);
	var tbl = tpl.clone();

	tbl.find("input.routDays").val(len+1);
	tbl.find("input.routDays").attr("id", "routeDailyList"+len+".routDays");
	tbl.find("input.routDays").attr("name", "routeDailyList["+len+"].routDays");
	
	tbl.find("input.routStartPoint").val('');
	tbl.find("input.routStartPoint").attr("id", "routeDailyList"+len+".routStartPoint");
	tbl.find("input.routStartPoint").attr("name", "routeDailyList["+len+"].routStartPoint");
	
	tbl.find("input.routDestPoint").val('');
	tbl.find("input.routDestPoint").attr("id", "routeDailyList"+len+".routDestPoint");
	tbl.find("input.routDestPoint").attr("name", "routeDailyList["+len+"].routDestPoint");
	
	tbl.find("div.destPoints").empty();

	tbl.find("input.routWayPoint").val('');
	tbl.find("input.routWayPoint").attr("id", "routeDailyList"+len+".routWayPoint");
	tbl.find("input.routWayPoint").attr("name", "routeDailyList["+len+"].routWayPoint");

	tbl.find("input.routStartAxis").val('');
	tbl.find("input.routStartAxis").attr("id", "routeDailyList"+len+".routStartAxis");
	tbl.find("input.routStartAxis").attr("name", "routeDailyList["+len+"].routStartAxis");

	tbl.find("input.routDestAxis").val('');
	tbl.find("input.routDestAxis").attr("id", "routeDailyList"+len+".routDestAxis");
	tbl.find("input.routDestAxis").attr("name", "routeDailyList["+len+"].routDestAxis");

	console.log(len+1);
	tpl.after(tbl);

}

function delRouteDailyTable() {
	if($("table.tpl-table").length > 1) {
		$("table.tpl-table").last().remove();
	}
}

function pointCallBack(idx, destId, destTitle) {
	var len = $("table.tpl-table").eq(idx).find("span.route-way-point").length;
	var el = "";
	if(len > 0) {
		el += "<i class=\"icon-arrow-right\">";
	}
	el += "<span class=\"badge badge-small route-way-point\" data-destid=\""+ destId +"\">"+ (len + 1) + " - " + destTitle +"</span>";
	if(len > 0) {
		el += "</i>";
	}
	$("div.destPoints").eq(idx).append(el);
	//routeDailyList0.routWayPoint
	var wayPoint = $("input[id='routeDailyList"+idx+".routWayPoint']").val();
	if(wayPoint != "") {
		wayPoint += "|"+destId;
	} else {
		wayPoint += destId;
	}
	$("input[id='routeDailyList"+idx+".routWayPoint']").val(wayPoint);
}

function searchDestination(obj) {
	var tbl = $(obj).closest("table.tpl-table");
	var idx = $("table.tpl-table").index(tbl);
	var region = $("#routRegion").val();
	console.log(idx);
	window.open("<c:url value="/cms/travel/route/searchDestination.do"/>?destRegion="+encodeURIComponent(region)+"&idx="+idx,"pop","width=600,height=650, scrollbars=yes, resizable=yes");
}

function addrCallBack(roadFullAddr, latitude, longitude, objId){
	var addrObj = $("input[id='" + objId + "']");
	addrObj.val(roadFullAddr);

	addrObj.attr('data-lat', latitude);
	addrObj.attr('data-lon', longitude);

		// console.log("objId", objId);
	var axis = objId.replace('Point', 'Axis');
		// console.log("objId", axis);
	var axisObj = $("input[id='" + axis + "']");
		// console.log("axisObj", axisObj);
	axisObj.val(latitude +","+ longitude);
}

$(function(){

	/*$("#routRegion, #destCategory").bind("change",function(){
	   	var reqUrl = "<c:url value="/travel/destination/retrieveDestinationList.do"/>";
	    var promise = getAsyncDataList(reqUrl);
	    promise.success(function (data) {
	    	setDestinationList(data);
	    });
	});*/

	// $("span.route-way-point").live("click",function(){
	$(document).on("click", "span.route-way-point", function(){
		$(this).closest('i.icon-arrow-right').remove();
		$(this).remove();
	});

	// $("#routStartPoint, #routDestPoint").bind("click",function(){
	// $("input.routStartPoint, input.routDestPoint").live("click",function(){
	$(document).on("click", "input.routStartPoint, input.routDestPoint", function(){
		var status = $(this).attr('id');
		window.open("<c:url value="/cms/travel/route/searchPoi.do"/>?status="+status,"pop","width=600,height=650, scrollbars=yes, resizable=yes");
	});

	console.log("screen-mode", $("#content").data('screen-mode'));

	var routWayPoint = $("#routWayPoint").val();
	var routId = $("#routId").val();
	// if($("#content").data('screen-mode') == "up" && routWayPoint) {
	if(routId && routWayPoint) {
		var descArr = routWayPoint.split("|");
		for (i=0; i < descArr.length; i++){
			getDestinationDetail(descArr[i]);
		}
	}

});
</script>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
