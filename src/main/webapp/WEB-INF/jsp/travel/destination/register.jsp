<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp" %>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>

<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp" %>
<!-- tmap api -->
<%-- <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=<spring:message code='Travel.Api.Tmap.Appkey' />"></script> --%>
<%-- <script src="/js/travel/kakao.js"></script> --%>
<%-- <script type="text/javascript">Kakao.init("<spring:message code='Travel.Api.Kakao.Appkey' />");</script> --%>
</head>

<c:set var="registerFlag" value="${empty travelDestination.destId ? '등록' : '수정'}"/>

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
	            <div class="cont_head">
	                <h2 class="title">여행지 등록</h2>
	            </div><!-- cont_head -->
	            <div class="cont_body">
				<form:form commandName="travelDestination" enctype="multipart/form-data">
					<form:hidden path="destId" />
					<%-- <form:hidden path="destImgPath" /> --%>
					<form:hidden path="destAxisX" />
					<form:hidden path="destAxisY" />
					<c:if test="${not empty travelDestination.destId}">
						<input type="hidden" id="registerFlag" value="update">
					</c:if>
					<c:if test="${empty travelDestination.destId}">
						<input type="hidden" id="registerFlag" value="insert">
					</c:if>
		            <div class="inr">
						<div class="reviews_write">
							<dl>
								<dt><form:label path="destTitle">명칭(제목)</form:label></dt>
								<dd>
									<%-- <input name="writer" id="writer" class="w100 input-xxlarge boxstyle" required type="text" value=''/> --%>
									<form:input path="destTitle" cssClass="xl" />
									&nbsp;<form:errors path="destTitle" />
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destAdSlogan">부제목</form:label></dt>
								<dd>
									<form:input path="destAdSlogan" cssClass="xxl" />
									&nbsp;<form:errors path="destAdSlogan" />
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destRegion">지역</form:label></dt>
								<dd>
									<form:select path="destRegion" cssClass="xs">
										<option value="">지역</option>
				                    	<form:options items="${regionList}" itemLabel="destRegion" itemValue="destRegion"/>
				                    </form:select>
									&nbsp;<form:errors path="destRegion" />
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destCategory">분류</form:label></dt>
								<dd>
									<select class="xs" name="destCategory" id="destCategory">
										<option value="">분류</option>
										<option value="관광지" <c:if test="${travelDestination.destCategory eq '관광지'}">selected</c:if>>관광</option>
										<option value="숙박" <c:if test="${travelDestination.destCategory eq '숙박'}">selected</c:if>>숙박</option>
										<option value="체험" <c:if test="${travelDestination.destCategory eq '체험'}">selected</c:if>>레져</option>
										<option value="음식점" <c:if test="${travelDestination.destCategory eq '음식점'}">selected</c:if>>식당</option>
										<option value="쇼핑" <c:if test="${travelDestination.destCategory eq '쇼핑'}">selected</c:if>>쇼핑</option>
									</select>
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destTag">사진</form:label></dt>
								<dd>
									<c:if test="${not empty travelDestination.destId}"><span style="color:red;"><i class="icon-info-sign"></i> 첨부파일을 수정하려면 새로운 파일을 선택해 주세요</span></c:if>
									<div>
										<c:if test="${fn:length(travelDestination.travelFileList) > 0}">
											<div style="margin:10px 3px;" class="file-list">
												<img src="${travelDestination.travelFileList[0].imgFilePath}" style="width:300px;height:200px;">
											</div>
										</c:if>	
										<input type="file" name="upfile_0" />
									</div>
									<div>
										<c:if test="${fn:length(travelDestination.travelFileList) > 1}">
											<div style="margin:10px 3px;" class="file-list">
												<img src="${travelDestination.travelFileList[1].imgFilePath}" style="width:300px;height:200px;">
											</div>
										</c:if>	
										<input type="file" name="upfile_1" />
									</div>
									<div>
										<c:if test="${fn:length(travelDestination.travelFileList) > 2}">
											<div style="margin:10px 3px;" class="file-list">
												<img src="${travelDestination.travelFileList[2].imgFilePath}" style="width:300px;height:200px;">
											</div>
										</c:if>	
										<input type="file" name="upfile_2" />
									</div>
									<div>
										<c:if test="${fn:length(travelDestination.travelFileList) > 3}">
											<div style="margin:10px 3px;" class="file-list">
												<img src="${travelDestination.travelFileList[3].imgFilePath}" style="width:300px;height:200px;">
											</div>
										</c:if>	
										<input type="file" name="upfile_3" />
									</div>
									<div>
										<c:if test="${fn:length(travelDestination.travelFileList) > 4}">
											<div style="margin:10px 3px;" class="file-list">
												<img src="${travelDestination.travelFileList[4].imgFilePath}" style="width:300px;height:200px;">
											</div>
										</c:if>	
										<input type="file" name="upfile_4" />
									</div>
									
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destTag">태그</form:label></dt>
								<dd>
									<form:input path="destTag" cssClass="sm" />
									&nbsp;<form:errors path="destTag" />
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destWebsiteUrl">홈페이지</form:label></dt>
								<dd>
									<form:input path="destWebsiteUrl" cssClass="xxl" />
									&nbsp;<form:errors path="destWebsiteUrl" />
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destPhone">연락처</form:label></dt>
								<dd>
									<form:input path="destPhone" cssClass="xl" />
									&nbsp;<form:errors path="destPhone" />
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destAddress">주소</form:label></dt>
								<dd>
									<form:input path="destAddress" cssClass="xl" />
									&nbsp;<form:errors path="destAddress" />
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destSeason">계절</form:label></dt>
								<dd>
									<form:input path="destSeason" cssClass="sm" />
									&nbsp;<form:errors path="destSeason" />
								</dd>
							</dl>
							<dl>
								<dt><form:label path="destInformation">여행지 설명</form:label></dt>
								<dd>
									<%-- <textarea id="" class="content input-xxlarge boxstyle w100" rows="10" cols="30" name="" required style="overflow-x:hidden;"></textarea> --%>
									<form:textarea path="destInformation" cols="50" rows="5" class="w100" />
								</dd>
							</dl>
						</div>
					</div>
	
					<div class="btnArea tac">
		           		<button id="btnSubmit" class="button border" onclick="registerRoute();return false;">여행지 <c:out value="${registerFlag}"/></button>
						<a href="<c:out value="${pageContext.request.getHeader('REFERER')}"/>" class="button border">취소</a>
					</div>

					<input type="hidden" name="searchCondition" value="<c:out value='${param.searchCondition}'/>"/>
					<input type="hidden" name="searchKeyword" value="<c:out value='${param.searchKeyword}'/>"/>
					<input type="hidden" name="pageIndex" value="<c:out value='${param.pageIndex ? param.pageIndex : 1}'/>"/>
				</form:form>

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
<%-- TODO: 폼 태그 스타일(width) 재정의 -- css 파일 적당한 곳에 반영해 주세요 --%>


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

function registerRoute(){
	var registerFlag = document.getElementById("registerFlag").value;
	var frm = document.getElementById("travelDestination");
	// frm.action = "/travel/destination/"+registerFlag+".do?type="+type+"&grpId="+grpId;
	if(validateFrm(frm)) {
		frm.action = "<c:url value="/travel/destination/"/>"+registerFlag+".do";
		frm.submit();
	} else {
		return false;
	}
}

function validateFrm(frm) {
	/*console.dir(validateSentence($("#destInformation").val())); return;
	if(!validateSentence($("#destInformation").val())) {
		alert("입력하신 문장 중에 허용되지 않는 단어가 포함되어 있습니다.");
		$("#destInformation").focus();
		return false;
	}
	return;*/

	if(!$("#destTitle").val()) {
		alert("여행지 명칭을 입력해 주세요");
		$("#destTitle").focus();
		return false;
	}
	if(!$("#destRegion").val()) {
		alert("지역을 선택해 주세요");
		$("#destRegion").focus();
		return false;
	}
	if(!$("#destCategory").val()) {
		alert("분류를 선택해 주세요");
		$("#destCategory").focus();
		return false;
	}
	var fileCnt = 0;
	$("input[type=file]").each(function() {
		if($(this).val()) {
			fileCnt++;
		}
	});
	if($("div.file-list").length > 0) {
		fileCnt++;
	}
	if(fileCnt == 0) {
		alert("여행지에 사진을 한 개 이상 선택하셔야 합니다.");
		$("input[type=file]").eq(0).click();
		return false;
	}
	if(!$("#destAddress").val()) {
		alert("여행지 주소를 입력해 주세요");
		$("#destAddress").click();
		return false;
	}
	if(!$("#destInformation").val()) {
		alert("여행지에 대한 설명을 입력해 주세요");
		$("#destInformation").focus();
		return false;
	} else {
		// console.dir(validateSentence($("#destInformation").val()));
		if(!validateSentence($("#destInformation").val())) {
			alert("입력하신 문장 중에 허용되지 않는 단어가 포함되어 있습니다.");
			$("#destInformation").focus();
			return false;
		}
	}
	
	return true;	
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
	    	// console.log("데이터를 가져오지 못했습니다.");
    		throw new SyntaxError("요청내용을 조회하지 못함");
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

	/*$("#routRegion, #destCategory").bind("change",function(){
	   	var reqUrl = "<c:url value="/travel/destination/retrieveDestinationList.do"/>";
	    var promise = getAsyncDataList(reqUrl);
	    promise.success(function (data) {
	    	setDestinationList(data);
	    });
	});*/

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
</html>
