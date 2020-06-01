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

			<form:form commandName="travelClipboard" method="post">            
	            <div class="cont_body">
		            <div class="inr">
		            	<h3 class="fame_tit">클립보드</h3>
						<%-- <div class="page_num">
							<p>총 게시물 <span><c:out value="${allCnt}" /></span>건</p>
						</div> --%>
						 <div class="local_lst">
							<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">	
								<li>
									<div class="img">
										<img src='http://seantour.com<c:out value="${result.clipThumbPath}"/>' alt='<c:out value="${fn:split(result.clipTitle,'|')[1]}"/>' />
									</div>
									<div class="tbox">
										<p class="tit"><a href='/travel/destination/detail.do?destId=<c:out value="${result.clipPageId}"/>'><span class="flag01"><c:out value="${fn:split(result.clipTitle,'|')[0]}"/></span><c:out value="${fn:split(result.clipTitle,'|')[1]}"/></a></p>
										<p class="location"><c:out value="${result.clipPageUrl}"/></p>
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
	document.getElementById("travelClipboard").pageIndex.value = pageNo;
	document.getElementById("travelClipboard").action = "<c:url value='/travel/member/clipboard.do'/>";
   	document.getElementById("travelClipboard").submit();
}
</script>
</html>
