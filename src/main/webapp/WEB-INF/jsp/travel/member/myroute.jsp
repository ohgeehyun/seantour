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
				<form:hidden path="routGroup" />
	            <div class="cont_body">
		            <div class="inr">
						<h3 class="fame_tit">나의 여행일정</h3>
						<div class="recommend_lst">
							<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status">	
								<li>
									<div class="img">
										<img src='http://seantour.com<c:out value="${result.routImgPath}"/>' alt='<c:out value="${result.routTitle}"/>' />
									</div>
									<div class="txt"><a href='/travel/route/detail.do?routGroup=<c:out value="${result.routGroup}"/>'><c:out value="${result.routTitle}"/></a></div>
									<div class="info btnarea">
										<span class="name"><c:out value="${result.routRegMemberNm}"/></span>
										<ul class="lst">
											<li><a href='/travel/route/modify.do?routGroup=<c:out value="${result.routGroup}"/>'>수정</a></li>
											<li><a href="javascript:;" onclick="deleteItem('<c:out value="${result.routGroup}"/>');">삭제</a></li>
										</ul>
									</div>
								</li>
								<%-- <c:if test="${(status.count % 4) eq '0'}"></li><li></c:if> --%>
							</c:forEach>
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
function deleteItem(routGroup){
	if(confirm("삭제하시겠습니까?")) {
		document.getElementById("travelRoute").routGroup.value = routGroup;
		document.getElementById("travelRoute").action = "<c:url value='/travel/route/delete.do'/>";
	   	document.getElementById("travelRoute").submit();
	}
}
</script>
</html>
