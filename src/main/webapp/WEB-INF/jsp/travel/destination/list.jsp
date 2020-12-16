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

			<form:form commandName="travelDestination" method="get" data-loginId="${loginVO.mbrId}">
	            <div class="cont_head" data-loginId='<c:out value="${loginVO.mbrId}"/>'>
	                <%-- <h2 class="title">부산광역시(BUSAN)</h2> --%>
	                <h2 class="title"><c:out value="${empty travelDestination.destRegion ? '바다여행' : travelDestination.destRegion}" /></h2>
	            </div><!--// cont_head -->
	            <div class="cont_body">
		            <div class="inr">
		            	<div class="bbsSrch bbsSrch2">
							<fieldset>
								<legend>검색</legend>
								<form:select path="destRegion" cssClass="select" onchange="fn_egov_link_page(1);">
									<option value="">지역</option>
			                    	<form:options items="${regionList}" itemLabel="destRegion" itemValue="destRegion"/>
			                    </form:select>
								<select class="select" name="destCategory" id="destCategory" onchange="fn_egov_link_page(1);">
									<option value="">전체</option>
									<option value="관광지" <c:if test="${travelDestination.destCategory eq '관광지'}">selected</c:if>>관광</option>
									<option value="숙박" <c:if test="${travelDestination.destCategory eq '숙박'}">selected</c:if>>숙박</option>
									<option value="레져" <c:if test="${travelDestination.destCategory eq '레져'}">selected</c:if>>레져</option>
									<option value="음식점" <c:if test="${travelDestination.destCategory eq '음식점'}">selected</c:if>>식당</option>
									<option value="쇼핑" <c:if test="${travelDestination.destCategory eq '쇼핑'}">selected</c:if>>쇼핑</option>
								</select>
								<%-- <c:if test ="${param.destCategory eq '관광지'}">
									<select class="select2" name="destTag" id="destTag" onchange="fn_egov_link_page(1);">
										<option value="">전체</option>
										<option value="공원" <c:if test="${travelDestination.destTag eq '공원'}">selected</c:if>>공원</option>
										<option value="기타관광지" <c:if test="${travelDestination.destTag eq '기타관광지'}">selected</c:if>>기타관광지</option>
										<option value="등대" <c:if test="${travelDestination.destTag eq '등대'}">selected</c:if>>등대</option>
										<option value="문화유적" <c:if test="${travelDestination.destTag eq '문화유적'}">selected</c:if>>문화유적</option>
										<option value="섬" <c:if test="${travelDestination.destTag eq '섬'}">selected</c:if>>섬</option>
										<option value="어촌체험마을" <c:if test="${travelDestination.destTag eq '어촌체험마을'}">selected</c:if>>어촌체험마을</option>
										<option value="영화" <c:if test="${travelDestination.destTag eq '영화'}">selected</c:if>>영화</option>
										<option value="일출" <c:if test="${travelDestination.destTag eq '일출'}">selected</c:if>>일출</option>
										<option value="전망대" <c:if test="${travelDestination.destTag eq '전망대'}">selected</c:if>>전망대</option>
										<option value="전시관" <c:if test="${travelDestination.destTag eq '전시관'}">selected</c:if>>전시관</option>
										<option value="체험프로그램" <c:if test="${travelDestination.destTag eq '체험프로그램'}">selected</c:if>>체험프로그램</option>
										<option value="축제" <c:if test="${travelDestination.destTag eq '축제'}">selected</c:if>>축제</option>
										<option value="항구" <c:if test="${travelDestination.destTag eq '항구'}">selected</c:if>>항구</option>
									</select>
								</c:if>
								<c:if test ="${param.destCategory eq '숙박'}">
									<select class="select2" name="destTag" id="destTag" onchange="fn_egov_link_page(1);">
										<option value="">전체</option>
										<option value="게스트하우스" <c:if test="${travelDestination.destTag eq '게스트하우스'}">selected</c:if>>게스트하우스</option>
										<option value="리조트" <c:if test="${travelDestination.destTag eq '리조트'}">selected</c:if>>리조트</option>
										<option value="민박" <c:if test="${travelDestination.destTag eq '민박'}">selected</c:if>>민박</option>
										<option value="여관" <c:if test="${travelDestination.destTag eq '여관'}">selected</c:if>>여관</option>
										<option value="캠핑장" <c:if test="${travelDestination.destTag eq '캠핑장'}">selected</c:if>>캠핑장</option>
										<option value="펜션" <c:if test="${travelDestination.destTag eq '펜션'}">selected</c:if>>펜션</option>
										<option value="호텔" <c:if test="${travelDestination.destTag eq '호텔'}">selected</c:if>>호텔</option>
									</select>
								</c:if>
								<c:if test ="${param.destCategory eq '체험'}">
									<select class="select2" name="destTag" id="destTag" onchange="fn_egov_link_page(1);">
										<option value="">전체</option>
										<option value="낚시터" <c:if test="${travelDestination.destTag eq '낚시터'}">selected</c:if>>낚시터</option>
										<option value="마리나" <c:if test="${travelDestination.destTag eq '마리나'}">selected</c:if>>마리나</option>
										<option value="수상여가" <c:if test="${travelDestination.destTag eq '수상여가'}">selected</c:if>>수상여가</option>
										<option value="유람선" <c:if test="${travelDestination.destTag eq '유람선'}">selected</c:if>>유람선</option>
										<option value="해수욕장" <c:if test="${travelDestination.destTag eq '해수욕장'}">selected</c:if>>해수욕장</option>
										<option value="해안 자전거길" <c:if test="${travelDestination.destTag eq '해안 자전거길'}">selected</c:if>>해안 자전거길</option>
										<option value="해안누리길" <c:if test="${travelDestination.destTag eq '해안누리길'}">selected</c:if>>해안누리길</option>
										<option value="해안산책로" <c:if test="${travelDestination.destTag eq '해안산책로'}">selected</c:if>>해안산책로</option>
										<option value="해안레포츠" <c:if test="${travelDestination.destTag eq '해안레포츠'}">selected</c:if>>해안레포츠</option>
										<option value="기타 "<c:if test="${travelDestination.destTag eq '기타'}">selected</c:if>>기타</option>
									</select>
								</c:if>
									<c:if test ="${param.destCategory eq '음식점'}">
									<select class="select2" name="destTag" id="destTag" onchange="fn_egov_link_page(1);">
										<option value="">전체</option>
										<option value="식도락" <c:if test="${travelDestination.destTag eq '식도락'}">selected</c:if>>식도락</option>
										<option value="양식" <c:if test="${travelDestination.destTag eq '양식'}">selected</c:if>>양식</option>
										<option value="일식" <c:if test="${travelDestination.destTag eq '일식'}">selected</c:if>>일식</option>
										<option value="중식" <c:if test="${travelDestination.destTag eq '중식'}">selected</c:if>>중식</option>
										<option value="한식" <c:if test="${travelDestination.destTag eq '한식'}">selected</c:if>>한식</option>
										<option value="횟집" <c:if test="${travelDestination.destTag eq '횟집'}">selected</c:if>>횟집</option>
									</select>
								</c:if>
								<c:if test ="${param.destCategory eq '쇼핑'}">
									<select class="select2" name="destTag" id="destTag" onchange="fn_egov_link_page(1);">
										<option value="">전체</option>
										<option value="가공" <c:if test="${travelDestination.destTag eq '낚시터'}">selected</c:if>>가공</option>
										<option value="신선제품" <c:if test="${travelDestination.destTag eq '마리나'}">selected</c:if>>신선제품</option>
										<option value="어시장" <c:if test="${travelDestination.destTag eq '수상여가'}">selected</c:if>>어시장</option>
									</select>
								</c:if> --%>
								
								
								<form:input path="searchKeyword" cssClass="word" />
								<%-- <input name="searchWrd" type="text" size="30" class="word" value='' maxlength="35" onkeypress="doKeyPress(event);" title="검색어 입력" /> --%> 
								<input type="button" value='검색' class="bbs_btn" onclick="fn_egov_link_page(1);" />
							</fieldset>
						</div>

						<%-- <div class="tabmenu colum6" name="destCatogory" id="destCategory" onchange="fn_egoc_link_page(1);"> --%>
						<div class="tabmenu colum6">

							<a href="#none">
							<c:choose>
								<c:when test = "${travelDestination.destCategory eq '관광지'}">
								<c:out value="관광"/>
								</c:when>
								<c:when test = "${travelDestination.destCategory eq '숙박'}">
								<c:out value="숙박"/>
								</c:when>
								<c:when test = "${travelDestination.destCategory eq '레져'}">
								<c:out value="레져"/>
								</c:when>
								<c:when test = "${travelDestination.destCategory eq '음식점'}">
								<c:out value="식당"/>
								</c:when>
								<c:when test = "${travelDestination.destCategory eq '쇼핑'}">
								<c:out value="쇼핑"/>
								</c:when>
								<c:otherwise>
       								<c:out value="전체"/>
    							</c:otherwise>	
							</c:choose>
							<span class="unfd sprh_com"></span>
							</a>
							<ul>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=&destRegion=${travelDestination.destRegion}"/>" <c:if test="${empty travelDestination.destCategory}">class="on"</c:if>><span>전체</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=관광지&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '관광지'}">class="on"</c:if>><span>관광</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=숙박&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '숙박'}">class="on"</c:if>><span>숙박</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=음식점&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '음식점'}">class="on"</c:if>><span>식당</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=쇼핑&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '쇼핑'}">class="on"</c:if>><span>쇼핑</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=레져&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '레져'}">class="on"</c:if>><span>레져</span></a></li>
							</ul>
						</div>
						
						<c:import url="/travel/destination/checkbox.do" charEncoding="utf-8"></c:import>
						
						<div class="page_num">
							<p>총 게시물 <span><c:out value="${allCnt}" /></span>건</p>
						</div>
						<div>
							<!-- 백준현 엑셀파일다운로드 -->							
							<input type ="hidden" value="${excelPageno}" name="excelPageno" id="excelPageno">
							<input type ="hidden" value="${allCnt}" name="allCnt">
							<%-- <input type ="button" onclick="fn_egov_down_excel(${excelPageno})" value = "엑셀파일 다운로드">	 --%>					
							<button type="button" class="btn_excel" onclick='fn_egov_down_excel(${excelPageno})'>엑셀</button>		
						</div>
						<div>
							<!-- 백준현 모든엑셀파일다운로드  -->							
							<!-- <input type ="button" onclick="fn_egov_down_allexcel()" value = "모든엑셀파일 다운로드"> -->																	
						</div>
						<div class="local_lst">
							<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">	
								<li>
									<div class="img">
									<a href='<c:url value="/travel/destination/detail.do"/>?destId=<c:out value="${result.destId}"/>'>
										<%-- <c:set var="destImgPath" value="${empty result.destImgPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(result.destImgPath)}" /> --%>
										<c:if test="${fn:length(result.travelFileList) eq 0}">
											<c:set var="destImgPath" value="${empty result.destImgPath ? '/images/travel/content/noimg.jpg' : result.destImgPath}" />
											<img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${result.destTitle}"/>' />
										</c:if>	
										<c:if test="${fn:length(result.travelFileList) gt 0}">
											<img src='<c:url value="${result.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${result.destTitle}"/>' />
										</c:if>	
									</a>
									</div>
									<div class="tbox">
										<p class="tit"><a href='<c:url value="/travel/destination/detail.do"/>?destId=<c:out value="${result.destId}"/>'><span class="flag01"><c:out value="${result.destCategory}"/></span><c:out value="${result.destTitle}"/></a></p>
										<p class="location"><c:out value="${result.destAddress}"/></p>
										<div class="icon_box">
										 		<a href="javascript:;" data-mbr-id='<c:out value="${loginVO.mbrId}"/>' data-dest-id='<c:out value="${result.destId}"/>' onclick="registerTravelDestFeedback(this, 'clip');return false;" class="clip <c:if test="${result.myClipCount gt 0}">on</c:if>">클립</a> 	
												<a href="javascript:;" data-mbr-id='<c:out value="${loginVO.mbrId}"/>' data-dest-id='<c:out value="${result.destId}"/>' onclick="registerTravelDestFeedback(this);return false;" class="heart <c:if test="${result.myRecommCount gt 0}">on</c:if>">좋아요</a>
										</div>
									</div>
								</li>
								<%-- <c:if test="${(status.count % 4) eq '0'}"></li><li></c:if> --%>
							</c:forEach>
							</ul>
						</div>

						<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="fn_egov_link_page" />
						<form:hidden path="pageIndex" />

						<div class="btnArea tar">
						<c:if test="${not empty loginVO.mbrId}">
							<a href="<c:url value="/travel/destination/register.do"/>" class="button border">등록</a>
						</c:if>
						</div>

					</div>
	            </div><!-- cont_body -->
			</form:form>

        	</div><!-- // cont_wrap -->
        </div>
        <!--// container -->

		<!-- footer -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp" %>
		<!--//footer -->
	</div>
	<!-- // wrap -->
	<!-- <style type="text/css">
	.local_lst li .tbox .tit span {
		width: 60px;
	}
	</style> -->
<script>
document.addEventListener("DOMContentLoaded", function(){
	// Handler when the DOM is fully loaded
	

	if($("input:checkbox[name='tourism']")!= null){
		var list = new Array();
		var temp = $("input:checkbox[name='tourism']").length-1;
		<c:forEach items="${travelDestination.tourism}" var="item2">
	   		 list.push("${item2}");
		</c:forEach>
		
		list.forEach(function(item,index){
			 for(var i=0; i <= temp; i++){
				if(list[index] == $("input:checkbox[name='tourism']")[i].value)
					{
						$("input:checkbox[name='tourism']")[i].checked = true;
					}
			 }
		})
	}

	
	if($("input:checkbox[name='lodgment']") != null){
		var list = new Array();
		var temp = $("input:checkbox[name='lodgment']").length-1;
		<c:forEach items="${travelDestination.lodgment}" var="item2">
	   		 list.push("${item2}");
		</c:forEach>
		
		list.forEach(function(item,index){
			 for(var i=0; i <= temp; i++){
				if(list[index] == $("input:checkbox[name='lodgment']")[i].value)
					{
						$("input:checkbox[name='lodgment']")[i].checked = true;
					}
			 }
		})
	}
	
	if($("input:checkbox[name='restaurant']") != null){
		var list = new Array();
		var temp = $("input:checkbox[name='restaurant']").length-1;
		<c:forEach items="${travelDestination.restaurant}" var="item2">
	   		 list.push("${item2}");
		</c:forEach>
		
		list.forEach(function(item,index){
			 for(var i=0; i <= temp; i++){
				if(list[index] == $("input:checkbox[name='restaurant']")[i].value)
					{
						$("input:checkbox[name='restaurant']")[i].checked = true;
					}
			 }
		})
	}
	
	if($("input:checkbox[name='shopping']") != null){
		var list = new Array();
		var temp = $("input:checkbox[name='shopping']").length-1;
		<c:forEach items="${travelDestination.shopping}" var="item2">
	   		 list.push("${item2}");
		</c:forEach>
		
		list.forEach(function(item,index){
			 for(var i=0; i <= temp; i++){
				if(list[index] == $("input:checkbox[name='shopping']")[i].value)
					{
						$("input:checkbox[name='shopping']")[i].checked = true;
					}
			 }
		})
	}
	
	if($("input:checkbox[name='leisure']") != null){
		var list = new Array();
		var temp = $("input:checkbox[name='leisure']").length-1;
		<c:forEach items="${travelDestination.leisure}" var="item2">
	   		 list.push("${item2}");
		</c:forEach>
		
		list.forEach(function(item,index){
			 for(var i=0; i <= temp; i++){
				if(list[index] == $("input:checkbox[name='leisure']")[i].value)
					{
						$("input:checkbox[name='leisure']")[i].checked = true;
					}
			 }
		})
	}
	
	});
	
	
function getParam(sname) {

    var params = location.search.substr(location.search.indexOf("?") + 1);

    var sval = "";

    params = params.split("&");

    for (var i = 0; i < params.length; i++) {

        temp = params[i].split("=");

        if ([temp[0]] == sname) { sval = temp[1]; }

    }

    return sval;

}



	
	
// function registerTravelDestFeedback(userId, targetId, type) {
function registerTravelDestFeedback(obj, type) {
	var param, url;
	var userId = $(obj).data("mbr-id");
	var targetId = $(obj).data("dest-id");
	if(type == "clip") {
		if(!userId) {
			alert("로그인 후에 클립보드에 추가하실 수 있습니다"); return false;
		}
		param = "clipUserId="+userId+"&clipPageId="+targetId;
		url = "<c:url value='/travel/member/clipboard/insertAsync.do'/>";
	} else {
		param = "rxnUserId="+userId+"&rxnTargetId="+targetId+"&rxnType=LIKE";
		url = "<c:url value='/travel/reco/insertAsync.do'/>";
	}
	$.ajax({
		method:"POST",
		url:url,//
		data:param,
		success:function(response){
			// console.log(response);
			try {
				var data = JSON.parse(response);
				if(data.status == "success") {
					alert(data.result);
					if($(obj).hasClass("on")===true)
					{
						$(obj).removeClass('on');
					}else{
						$(obj).addClass('on');
					}
				}
			} catch (e) {
				// console.log(e.name);
				// console.log(e.message);
				alert("일시적인 에러가 발생했습니다. 잠시 후 다시 시도해 주세요."); return false;
			}
		},
		error:function(request,status,error){
			// console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function fn_egov_link_page(pageNo){	
	document.getElementById('excelPageno').value=pageNo;
	document.getElementById("travelDestination").pageIndex.value = pageNo;
	document.getElementById("travelDestination").action = "<c:url value='/travel/destination/list.do'/>";
   	document.getElementById("travelDestination").submit();
}

function fn_egov_link_check(pageNo){	
	document.getElementById('excelPageno').value=pageNo;
	document.getElementById("travelDestination").pageIndex.value = pageNo;
	document.getElementById("travelDestination").action = "<c:url value='/travel/destination/list.do'/>";
   	document.getElementById("travelDestination").submit();
}

function fn_egov_down_excel(pageNo){
	document.getElementById("travelDestination").pageIndex.value = pageNo;	
	document.getElementById("travelDestination").action = "<c:url value='/travel/destination/dowexcel.do'/>";
   	document.getElementById("travelDestination").submit();
}

function fn_egov_down_allexcel(){
	document.getElementById("travelDestination").action = "<c:url value='/travel/destination/alldowexcel.do'/>";
   	document.getElementById("travelDestination").submit();
}
</script>
</body>


</html>
