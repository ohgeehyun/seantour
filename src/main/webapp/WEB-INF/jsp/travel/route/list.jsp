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

			<form:form commandName="travelRoute" method="post">            
	            <div class="cont_body">
		            <div class="inr">
		               <div class="tabmenu colum2">
							<a href="#none">추천일정<span class="unfd sprh_com"></span></a>
							<ul>
								<li><a href="#none" class="on"><span>작가 추천일정</span></a></li>
								<li><a href="#none" ><span>베스트 추천일정</span></a></li>
							</ul>
						</div>
		            	<div class="bbsSrch">
							<fieldset form="board">
								<legend>검색</legend>
								<select class="select" name="searchCondition" id="searchCondition" onchange="fn_egov_link_page(1);">
									<%-- <option value="">선택</option> --%>
									<option value="1" <c:if test="${travelRoute.searchCondition eq '1'}">selected</c:if>>제목</option>
								</select>
								<form:input path="searchKeyword" cssClass="word" />
								<input type="button" value='검색' class="bbs_btn" onclick="fn_egov_link_page(1);" />
							</fieldset>
						</div>
		               
						<div class="page_num">
							<p>총 게시물 <span><c:out value="${allCnt}" /></span>건</p>
						</div>
						 <div class="recommend_lst">
							<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<li>
									<div class="img">
										<%-- <span class="title">부산여행 전문작가 추천</span> --%>
										<span class="title"><c:out value="${result.routRegion}"/>여행 전문작가 추천</span>
										<%-- <img src="./images/content/img_recommend01.jpg" alt="" /> --%>
										<img src='http://seantour.com<c:out value="${result.routImgPath}"/>' alt='<c:out value="${result.routTitle}"/>' />
									</div>
									<div class="txt">
										<%-- <a href='/travel/route/detail.do?routId=<c:out value="${result.routId}"/>'><c:out value="${result.routTitle}"/> --%>
										<a href='/travel/route/detail.do?routGroup=<c:out value="${result.routGroup}"/>'><c:out value="${result.routTitle}"/></a>
									</div>
									<div class="info">
										<span class="name"><c:out value="${result.routRegMemberNm}"/></span>
										<ul class="lst">
											<li>
												<span class="reco_num">조회수</span>
												<span class="num"><c:out value="${result.routHit}"/></span>
											</li>
											<li>
												<span class="reco_num">추천수</span>
												<span class="num"><c:out value="${result.routRecomm}"/></span>
											</li>
										</ul>
									</div>
								</li>
								<%-- <c:if test="${(status.count % 4) eq '0'}"></li><li></c:if> --%>
							</c:forEach>
							</ul>
						</div>
						<%-- <div id="page_navi" class="pagination"> --%>
						<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="fn_egov_link_page" />
						<form:hidden path="pageIndex" />
						<%-- </div> --%>

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
	document.getElementById("travelRoute").pageIndex.value = pageNo;
	document.getElementById("travelRoute").action = "<c:url value='/travel/route/list.do'/>";
   	document.getElementById("travelRoute").submit();
}
</script>
</html>
