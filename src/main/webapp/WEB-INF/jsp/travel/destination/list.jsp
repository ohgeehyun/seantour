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
									<option value="체험" <c:if test="${travelDestination.destCategory eq '체험'}">selected</c:if>>레져</option>
									<option value="음식점" <c:if test="${travelDestination.destCategory eq '음식점'}">selected</c:if>>식당</option>
									<option value="쇼핑" <c:if test="${travelDestination.destCategory eq '쇼핑'}">selected</c:if>>쇼핑</option>
								</select>
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
								<c:when test = "${travelDestination.destCategory eq '체험'}">
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
								<li><a href="<c:url value="/travel/destination/list.do?destRegion=${travelDestination.destRegion}"/>" <c:if test="${empty travelDestination.destCategory}">class="on"</c:if>><span>전체</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=관광지&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '관광지'}">class="on"</c:if>><span>관광</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=숙박&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '숙박'}">class="on"</c:if>><span>숙박</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=음식점&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '음식점'}">class="on"</c:if>><span>식당</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=쇼핑&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '쇼핑'}">class="on"</c:if>><span>쇼핑</span></a></li>
								<li><a href="<c:url value="/travel/destination/list.do?destCategory=체험&destRegion=${travelDestination.destRegion}"/>" <c:if test="${travelDestination.destCategory eq '체험'}">class="on"</c:if>><span>레져</span></a></li>
							</ul>
						</div>
		               
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
