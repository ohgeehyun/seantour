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

			<form:form commandName="travelDestination" method="post">            
	            <div class="cont_head">
	                <%-- <h2 class="title">부산광역시(BUSAN)</h2> --%>
	                <h2 class="title"><c:out value="${empty travelDestination.destRegion ? '바다여행' : travelDestination.destRegion}" /></h2>
	            </div><!--// cont_head -->
	            <div class="cont_body">
		            <div class="inr">
		            	<div class="bbsSrch bbsSrch2">
							<fieldset form="board">
								<legend>검색</legend>
								<form:select path="destRegion" cssClass="select" onchange="fn_egov_link_page(1);">
									<option value="">지역</option>
			                    	<form:options items="${regionList}" itemLabel="destRegion" itemValue="destRegion"/>
			                    </form:select>
								<select class="select" name="destCategory" id="destCategory" onchange="fn_egov_link_page(1);">
									<option value="">분류</option>
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
		               <div class="tabmenu colum6">
							<a href="#none">전체<span class="unfd sprh_com"></span></a>
							<ul>
								<li><a href="/travel/destination/list.do" <c:if test="${empty travelDestination.destCategory}">class="on"</c:if>><span>전체</span></a></li>
								<li><a href="/travel/destination/list.do?destCategory=관광지" <c:if test="${travelDestination.destCategory eq '관광지'}">class="on"</c:if>><span>관광</span></a></li>
								<li><a href="/travel/destination/list.do?destCategory=숙박" <c:if test="${travelDestination.destCategory eq '숙박'}">class="on"</c:if>><span>숙박</span></a></li>
								<li><a href="/travel/destination/list.do?destCategory=음식점" <c:if test="${travelDestination.destCategory eq '음식점'}">class="on"</c:if>><span>식당</span></a></li>
								<li><a href="/travel/destination/list.do?destCategory=쇼핑" <c:if test="${travelDestination.destCategory eq '쇼핑'}">class="on"</c:if>><span>쇼핑</span></a></li>
								<li><a href="/travel/destination/list.do?destCategory=체험" <c:if test="${travelDestination.destCategory eq '체험'}">class="on"</c:if>><span>레져</span></a></li>
							</ul>
						</div>
		               
						<div class="page_num">
							<p>총 게시물 <span><c:out value="${allCnt}" /></span>건</p>
						</div>
						 <div class="local_lst">
							<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">	
								<li>
									<div class="img">
										<%-- <img src='<c:out value="${empty result.destImgPath ? '/images/travel/content/img_local01.jpg' : 'http://seantour.com' + result.destImgPath }"/>' alt='<c:out value="${result.destTitle}"/>' /> --%>
										<img src='http://seantour.com<c:out value="${result.destImgPath}"/>' alt='<c:out value="${result.destTitle}"/>' />
									</div>
									<div class="tbox">
										<p class="tit"><a href='/travel/destination/detail.do?destId=<c:out value="${result.destId}"/>'><span class="flag01"><c:out value="${result.destCategory}"/></span><c:out value="${result.destTitle}"/></a></p>
										<p class="location"><c:out value="${result.destAddress}"/></p>
										<div class="icon_box">
											<a href="#none" class="clip">클립</a>
											<a href="#none" class="heart">좋아요</a>
										</div>
									</div>
								</li>
								<%-- <c:if test="${(status.count % 4) eq '0'}"></li><li></c:if> --%>
							</c:forEach>
							</ul>
						</div>

						<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="fn_egov_link_page" />
						<form:hidden path="pageIndex" />

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
</body>
<style type="text/css">
.local_lst li .tbox .tit span {
	width: 60px;
}
</style>
<script type="text/javascript">
function fn_egov_link_page(pageNo){
	document.getElementById("travelDestination").pageIndex.value = pageNo;
	document.getElementById("travelDestination").action = "<c:url value='/travel/destination/list.do'/>";
   	document.getElementById("travelDestination").submit();
}
</script>
</html>
