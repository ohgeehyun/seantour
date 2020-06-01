<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<c:set var="registerFlag" value="${empty travelDestination.destId ? '등록' : '수정'}"/>
<%-- validator:javascript formName="travelDestination" staticJavascript="false" xhtml="true" cdata="false"/  --%>

<div id="content" data-screen-mode="${searchVO.screenMode}">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>여행지 <c:out value='${registerFlag}'/></h3>
                   		<a href="<c:url value="/cms/travel/destination/list.do"/>?grpId=${grpId}&type=${type}" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
                   		<a href="javascript:;" onclick="registerRoute();" class="btn btn-small"><i class="icon-ok-sign"></i> <c:out value='${registerFlag}'/></a>
						<c:if test="${not empty travelDestination.destId}">
							<a href="javascript:deleteDestination()" class="btn btn-small btn-del" style="float:right;"><i class="icon-minus-sign"></i> 삭제</a>
						</c:if> 
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="travelDestination" enctype="multipart/form-data">
							<form:hidden path="destId" />
							<form:hidden path="destImgPath" />
							<%-- <form:hidden path="routWayPoint" />
							<form:hidden path="routStartAxis" />
							<form:hidden path="routDestAxis" /> --%>
							<table class="table table-bordered table-striped th_left" summary="여행지 <c:out value='${registerFlag}'/> 테이블">
								<c:if test="${not empty travelDestination.destId}">
									<input type="hidden" name="screenMode" value="up" />
									<input type="hidden" id="registerFlag" value="update">
								</c:if>
								<c:if test="${empty travelDestination.destId}">
									<input type="hidden" name="screenMode" value="" />
									<input type="hidden" id="registerFlag" value="insert">
								</c:if>
								<tr>
									<th class="span2">명칭</th>
									<td>
										<form:input path="destTitle" cssClass="span9" />
										&nbsp;<form:errors path="destTitle" />
									</td>
								</tr>
								<tr>
									<th>홍보 슬로건</th>
									<td>
										<form:input path="destAdSlogan" cssClass="span11" />
										&nbsp;<form:errors path="destAdSlogan" />
									</td>
								</tr>
								<tr>
									<th>지역 분류</th>
									<td>
										<form:select path="destRegion">
											<option value="">지역</option>
					                    	<form:options items="${regionList}" itemLabel="destRegion" itemValue="destRegion"/>
					                    </form:select>
									</td>
								</tr>
								<tr>
									<th>분류</th>
									<td>
										<select class="sc_local" name="destCategory" id="destCategory">
											<option value="">분류</option>
											<option value="관광지" <c:if test="${travelDestination.destCategory eq '관광지'}">selected</c:if>>관광</option>
											<option value="숙박" <c:if test="${travelDestination.destCategory eq '숙박'}">selected</c:if>>숙박</option>
											<option value="체험" <c:if test="${travelDestination.destCategory eq '체험'}">selected</c:if>>레져</option>
											<option value="음식점" <c:if test="${travelDestination.destCategory eq '음식점'}">selected</c:if>>식당</option>
											<option value="쇼핑" <c:if test="${travelDestination.destCategory eq '쇼핑'}">selected</c:if>>쇼핑</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>홈페이지</th>
									<td>
										<form:input path="destWebsiteUrl" cssClass="span10" />
										&nbsp;<form:errors path="destWebsiteUrl" />
									</td>
								</tr>
								<tr>
									<th>
										첨부이미지
										<%-- 
										<a href="javascript:;" onClick="addUploadField(this);" class="btn btn-small"><i class="icon-plus"></i></a>
										<a href="javascript:;" onClick="delUploadField(this);" class="btn btn-small"><i class="icon-remove"></i></a> 
										--%>
									</th>
									<td>
										<%-- <form:input path="destImgPath" cssClass="txt" />
										&nbsp;<form:errors path="destImgPath" /> --%>
										<c:if test="${not empty travelDestination.destImgPath}"><span style="color:yellow;"><i class="icon-info-sign"></i> 기존 시스템에서 이전된 파일입니다.</span></c:if>
										<c:if test="${not empty travelDestination.destImgPath}">
											<div style="margin:10px 3px;">
												<%-- <p><i class="icon-info-sign"></i> 첨부파일을 수정하려면 새로운 파일을 선택해 주세요</p> --%>
												<img src="${travelDestination.destImgPath}" style="width:300px;height:200px;">
											</div>
										</c:if>	
										<c:if test="${not empty travelDestination.destId}"><span style="color:red;"><i class="icon-info-sign"></i> 첨부파일을 수정하려면 새로운 파일을 선택해 주세요</span></c:if>
										<div>
											<c:if test="${fn:length(travelDestination.travelFileList) > 0}">
												<div style="margin:10px 3px;">
													<%-- <p><i class="icon-info-sign"></i> 첨부파일을 수정하려면 새로운 파일을 선택해 주세요</p> --%>
													<img src="${travelDestination.travelFileList[0].imgFilePath}" style="width:300px;height:200px;">
												</div>
											</c:if>	
											<input type="file" name="upfile_0" />
										</div>
										<div>
											<c:if test="${fn:length(travelDestination.travelFileList) > 1}">
												<div style="margin:10px 3px;">
													<%-- <p><i class="icon-info-sign"></i> 첨부파일을 수정하려면 새로운 파일을 선택해 주세요</p> --%>
													<img src="${travelDestination.travelFileList[1].imgFilePath}" style="width:300px;height:200px;">
												</div>
											</c:if>	
											<input type="file" name="upfile_1" />
										</div>
										<div>
											<c:if test="${fn:length(travelDestination.travelFileList) > 2}">
												<div style="margin:10px 3px;">
													<%-- <p><i class="icon-info-sign"></i> 첨부파일을 수정하려면 새로운 파일을 선택해 주세요</p> --%>
													<img src="${travelDestination.travelFileList[2].imgFilePath}" style="width:300px;height:200px;">
												</div>
											</c:if>	
											<input type="file" name="upfile_2" />
										</div>
										<div>
											<c:if test="${fn:length(travelDestination.travelFileList) > 3}">
												<div style="margin:10px 3px;">
													<%-- <p><i class="icon-info-sign"></i> 첨부파일을 수정하려면 새로운 파일을 선택해 주세요</p> --%>
													<img src="${travelDestination.travelFileList[3].imgFilePath}" style="width:300px;height:200px;">
												</div>
											</c:if>	
											<input type="file" name="upfile_3" />
										</div>
										<div>
											<c:if test="${fn:length(travelDestination.travelFileList) > 4}">
												<div style="margin:10px 3px;">
													<%-- <p><i class="icon-info-sign"></i> 첨부파일을 수정하려면 새로운 파일을 선택해 주세요</p> --%>
													<img src="${travelDestination.travelFileList[4].imgFilePath}" style="width:300px;height:200px;">
												</div>
											</c:if>	
											<input type="file" name="upfile_4" />
										</div>
									</td>
								</tr>
								<tr>
									<th>연락처</th>
									<td>
										<form:input path="destPhone" cssClass="span9" />
										&nbsp;<form:errors path="destPhone" />
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>
										<form:input path="destAddress" cssClass="span11" />
										&nbsp;<form:errors path="destAddress" />
									</td>
								</tr>
								<tr>
									<th>좌표</th>
									<td>
										<form:input path="destAxisY" cssClass="uneditable-input" readonly="true" />
										<form:input path="destAxisX" cssClass="uneditable-input" readonly="true" />
										&nbsp;<form:errors path="destAxisY" /> <form:errors path="destAxisX" />
									</td>
								</tr>
								<%-- <tr>
									<th>특징</th>
									<td>
										<form:textarea path="destFeature" cols="20" rows="5" cssClass="span11"/>
										&nbsp;<form:errors path="destFeature" />
									</td>
								</tr> --%>
								<%-- <tr>
									<th>정보</th>
									<td>
										<form:textarea path="destInformation" cols="20" rows="5" cssClass="span11"/>
										&nbsp;<form:errors path="destInformation" />
									</td>
								</tr> --%>
								<tr>
									<th>계절</th>
									<td>
										<form:input path="destSeason" cssClass="span9" placeholder="여러 계절인 경우 쉼표로 구분해서 입력 예) 봄,여름,가을,겨울" />
										&nbsp;<form:errors path="destSeason" />
									</td>
								</tr>
								<tr>
									<th>설명</th>
									<td>
										<form:textarea path="destInformation" cols="20" rows="10" cssClass="span11"/>
										&nbsp;<form:errors path="destInformation" />
									</td>
								</tr>
							</table>
							<input type="hidden" name="searchCondition" value="<c:out value='${travelDestination.searchCondition}'/>"/>
							<input type="hidden" name="searchKeyword" value="<c:out value='${travelDestination.searchKeyword}'/>"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${travelDestination.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/cms.admin.css"/>">
<script type="text/javascript">
function addUploadField(obj) {
	var fld = $(obj).closest("div.upfiles");
	var clone = fld.clone();
	clone.find('input[name=upfile]').val('');
	clone.find('a.btn').remove();
	fld.after(clone);
}
function delUploadField(obj) {
	var fld = $("div.upfiles").last().remove();
}

function deleteDestination(){
	// var registerFlag = document.getElementById("registerFlag").value;
	var frm = document.getElementById("travelDestination");
	frm.action = "<c:url value="/cms/travel/destination/delete.do"/>";
	frm.submit();
}
function registerRoute(){
	var registerFlag = document.getElementById("registerFlag").value;
	var frm = document.getElementById("travelDestination");
	// frm.action = "/cms/travel/destination/"+registerFlag+".do?type="+type+"&grpId="+grpId;
	frm.action = "<c:url value="/cms/travel/destination/"/>"+registerFlag+".do";
	frm.submit();
}

function addPoint() {
	var point = $("#routDestination option:selected").text();
	var item = "<span class=\"btn btn-small\"><i class=\"icon-picture\">"+point+"</span>";
	$("#destPoints").append(item);
}
function delPoint(obj) {
	$(obj).closest('div.detailzone').remove();
	setWayPointValue();
}

function getDestinationList() {
   	var reqUrl = "<c:url value="/travel/destination/retrieveDestinationList.do"/>";
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
        , data:encodeURI(formData)
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , error: function(data, status, err) { 
            alert('서버와의 통신이 실패했습니다.');
        }
    });
}
function setDestinationList(data) {
	// console.log(data);
	try {
		var obj = JSON.parse(data);
		// console.log(obj.constructor); return;
	    if(obj.constructor !== Array){
	    	console.log("데이터를 가져오지 못했습니다.");
	    	throw new SyntaxError("데이터를 가져오지 못함");
	    }else{
	        var lists = "";
	    	for(var i=0; i<obj.length; i++) {
				lists += "<option value=\""+obj[i]["destId"]+"\">"+obj[i]["destTitle"]+"</option>";
			}
	       	$("#routDestination").empty();
	       	$("#routDestination").append(lists);
	    }
	} catch (e) {
		// console.log(e.name);
		// console.log(e.message);
		alert("일시적인 에러가 발생했습니다. 잠시 후 다시 시도해 주세요."); return false;
	}
}
function getDestinationDetail(idx) {
	// var thumb_img_path = "https://www.seantour.com";
	var destId = idx ? idx : $("#routDestination option:selected").val();
	$.get('<c:url value="/travel/destination/retrieveDestinationDetail.do"/>?destId='+destId, function(data) {
		try {
			var obj = JSON.parse(data);
			if(obj && obj.hasOwnProperty("destTitle")) {
				setWayPointList(obj);
				setWayPointValue();
			} else {
	    		throw new SyntaxError("요청내용을 조회하지 못함");
			}
		} catch (e) {
			// console.log(e.name);
			// console.log(e.message);
			alert("일시적인 에러가 발생했습니다. 잠시 후 다시 시도해 주세요."); return false;
		}
	});
}
function setWayPointValue() {
	var routWayPoint = "";
	$(".detailzone").each(function(index){
		if (index > 0) {
			routWayPoint += "|" + $(this).data('destid');
		} else {
			routWayPoint += $(this).data('destid');
		}
	});
	$("#routWayPoint").val(routWayPoint);
}

function setWayPointList(obj) {
	//var thumb_img_path = "https://www.seantour.com";
	var thumb_img = "obj.destImgPath";
	if(obj.travelFileList && obj.travelFileList.length > 0) {
		thumb_img = obj.travelFileList[0].imgFilePath;
	}
	var contents = 
		"<div class=\"detailzone\" data-destid=\""+obj.destId+"\">"+
			"<ul class=\"lst\">"+
				// "<li><img src=\""+thumb_img_path + obj.destImgPath+"\" alt=\""+obj.destTitle+"\" style=\"width:450px;height:300px;\" /></li>"+
				"<li><img src=\""+thumb_img+"\" alt=\""+obj.destTitle+"\" style=\"width:450px;height:300px;\" /></li>"+
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
	$("#destAxisY").val(latitude);
	$("#destAxisX").val(longitude);
}

$(function(){

	$("#routRegion, #destCategory").bind("change",function(){
	   	var reqUrl = "<c:url value="/travel/destination/retrieveDestinationList.do"/>";
	    var promise = getAsyncDataList(reqUrl);
	    promise.success(function (data) {
	    	setDestinationList(data);
	    });
	});

	$("#destAddress").bind("click",function(){
		var status = $(this).attr('id');
		window.open("<c:url value="/travel/route/address.do"/>?status="+status+"&idx=","pop","width=600,height=650, scrollbars=yes, resizable=yes");
	});

	// console.log("screen-mode", $("#content").data('screen-mode'));

	var routWayPoint = $("#routWayPoint").val();
	var destId = $("#destId").val();
	// if($("#content").data('screen-mode') == "up" && routWayPoint) {
	if(destId && routWayPoint) {
		var descArr = routWayPoint.split("|");
		for (i=0; i < descArr.length; i++){
			getDestinationDetail(descArr[i]);
		}
	}

	// $("input[type=file]").uniform({useID: false});
});

</script>
<!-- 검색조건 유지 -->
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
