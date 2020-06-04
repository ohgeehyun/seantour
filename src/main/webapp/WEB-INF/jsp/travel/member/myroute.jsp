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
				<form:hidden path="routId" />
	            <div class="cont_body">
		            <div class="inr">
						<h3 class="fame_tit">나의 여행일정</h3>
						<div class="recommend_lst">
							<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<%-- <c:set var="routThumbPath" value="${empty result.routThumbPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(result.routThumbPath)}" /> --%>
								<c:set var="routThumbPath" value="${empty result.routThumbPath ? '/images/travel/content/noimg.jpg' : result.routThumbPath}" />
								<li>
									<div class="img">
										<a href='<c:url value="/travel/route/detail.do?routId=${result.routId}"/>'>
											<img src='<c:url value="${routThumbPath}"/>' alt='<c:out value="${result.routTitle}"/>' />
										</a>
									</div>
									<div class="txt"><a href='<c:url value="/travel/member/detail.do?routId=${result.routId}"/>'><c:out value="${result.routTitle}"/></a></div>
									<div class="info btnarea">
										<span class="name"><c:out value="${result.routRegMemberNm}"/></span>
										<ul class="lst">
											<li><a href='<c:url value="/travel/route/modify.do?routId=${result.routId}"/>'>수정</a></li>
											<li><a href="javascript:;" onclick="deleteItem('<c:out value="${result.routId}"/>');">삭제</a></li>
										</ul>
									</div>
								</li>
								<%-- <c:if test="${(status.count % 4) eq '0'}"></li><li></c:if> --%>
							</c:forEach>
							<c:if test="${fn:length(resultList) eq 0}">
								<li class="none"><div>등록된 일정이 없습니다</div></li>
							</c:if>
							</ul>
						</div>
						<ui:pagination paginationInfo="${paginationInfo}" type="travelFront" jsFunction="getItemList" />
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
function getItemList(pageNo){
	document.getElementById("travelRoute").pageIndex.value = pageNo;
	document.getElementById("travelRoute").action = "<c:url value='/travel/member/clipboard.do'/>";
   	document.getElementById("travelRoute").submit();
}
function deleteItem(routId){
	if(confirm("삭제하시겠습니까?")) {
		document.getElementById("travelRoute").routId.value = routId;
		document.getElementById("travelRoute").action = "<c:url value='/travel/route/delete.do'/>";
	   	document.getElementById("travelRoute").submit();
	}
}
</script>
</html>
