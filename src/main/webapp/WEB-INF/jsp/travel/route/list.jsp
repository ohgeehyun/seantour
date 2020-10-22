<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/jsp/travel/tpl/include.jsp"%>

<!DOCTYPE HTML>
<html lang="ko" class="skrollr skrollr-desktop">
<head>
<%@ include file="/WEB-INF/jsp/travel/tpl/head.jsp"%>
</head>
<body>
	<div id="wrap">
		<div id="accessibility">
			<a href="#content">본문 바로가기</a>
		</div>
		<!-- header -->
		<%@ include file="/WEB-INF/jsp/travel/tpl/gnb.jsp"%>
		<!-- // header -->

		<!-- contaniner -->
		<div id="container">

			<%@ include file="/WEB-INF/jsp/travel/tpl/navigation.jsp"%>

			<div id="content" class="cont_wrap">

				<form:form commandName="travelRoute" method="post">
					<div class="cont_body">
						<div class="inr">
							<div class="tabmenu colum2">
								<c:choose>
									<c:when test="${fn:contains(param.open, 'Y')}">
										<a href="#none" id="mobile_menu">내가올리는 추천일정<span
											class="unfd sprh_com"></span></a>
									</c:when>
									<c:otherwise>
										<a href="#none" id="mobile_menu">작가 추천일정<span
											class="unfd sprh_com"></span></a>
									</c:otherwise>
								</c:choose>
								<ul>
									<li><a href="<c:url value='/travel/route/list.do'/>"
										<c:if test="${open ne 'Y'}">class="on"</c:if>><span>작가
												추천일정</span></a></li>
									<li><a
										href="<c:url value='/travel/route/list.do?open=Y'/>"
										<c:if test="${open eq 'Y'}">class="on"</c:if>><span>내가
												올리는 추천일정</span></a></li>
								</ul>
							</div>
							<div class="bbsSrch">
								<fieldset>
									<legend>검색</legend>
									<select class="select" name="searchCondition"
										id="searchCondition" onchange="fn_egov_link_page(1);">
										<%-- <option value="">선택</option> --%>
										<option value="1"
											<c:if test="${travelRoute.searchCondition eq '1'}">selected</c:if>>제목</option>
										<option value="2"
											<c:if test="${travelRoute.searchCondition eq '2'}">selected</c:if>>글쓴이</option>
									</select>
									<form:input path="searchKeyword" cssClass="word" />
									<input type="button" value='검색' class="bbs_btn"
										onclick="fn_egov_link_page(1);" />
								</fieldset>
							</div>

							<div class="page_num">
								<p>
									총 게시물 <span><c:out value="${allCnt}" /></span>건
								</p>
								<c:if test="${fn:length(resultList) eq 0}">
									<p style="margin: 0 auto; text-align: center;">
										<span>등록된 일정이 없습니다</span>
									</p>
								</c:if>
							</div>

							<div>
								<!-- 백준현 엑셀파일다운로드 -->
								<input type="hidden" value="${iexcelPageno}" name="iexcelPageno" id = "iexcelPageno">
								<input type="hidden" value="${allCnt}" name="allCnt">
							
								 <input type="button"
									onclick="fn_egov_down_excel(${iexcelPageno})" value="엑셀파일 다운로드">
								<!-- fn_egov_down_excel(${iexcelPageno}) -->
							</div>
							<div>
								<!-- 백준현 모든엑셀파일다운로드  -->
								<input type="button"
									onclick="fn_egov_down_allexcel(${iexcelPageno})"
									value="모든엑셀파일 다운로드">

								<!-- fn_egov_down_excel(${iexcelPageno}) -->
							</div>
							<div class="recommend_lst">
								<ul>
									<c:forEach var="result" items="${resultList}"
										varStatus="status">
										<%-- <c:set var="routThumbPath" value="${empty result.routThumbPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(result.routThumbPath)}" /> --%>
										<c:set var="routThumbPath"
											value="${empty result.routThumbPath ? '/images/travel/content/noimg.jpg' : result.routThumbPath}" />
										<li>
											<div class="img">
												<a
													href='<c:url value="/travel/route/detail.do?routId=${result.routId}"/>'>
													<%-- <span class="title">부산여행 전문작가 추천</span> --%> <c:choose>
														<c:when test="${open ne 'Y'}">
															<span class="title"> <c:out
																	value="${result.routRegion}" />여행
															</span>
															<img src='<c:url value="${routThumbPath}"/>'
																alt='<c:out value="${result.routTitle}"/>' />
												</a>
											</div> </c:when> <c:otherwise>
												<img src='<c:url value="${routThumbPath}"/>'
													alt='<c:out value="${result.routTitle}"/>' />
												</a>
							</div>
							</c:otherwise>
							</c:choose>
							<div class="txt">
								<%-- <a href='/travel/route/detail.do?routId=<c:out value="${result.routId}"/>'><c:out value="${result.routTitle}"/></a> --%>
								<a
									href='<c:url value="/travel/route/detail.do?routId=${result.routId}"/>'><c:out
										value="${result.routTitle}" /></a>
							</div>
							<div class="info">
								<span class="name"><c:out
										value="${result.routRegMemberNm}" /></span>
								<ul class="lst">
									<li><span class="reco_num">조회수</span> <span class="num"><c:out
												value="${result.routHit}" /></span></li>
									<li><span class="reco_num">추천수</span> <span class="num"><c:out
												value="${result.routRecomm}" /></span></li>
								</ul>
							</div>
							</li>
							<%-- <c:if test="${(status.count % 4) eq '0'}"></li><li></c:if> --%>
							</c:forEach>
							</ul>
						</div>
						<%-- <div id="page_navi" class="pagination"> --%>

						<ui:pagination paginationInfo="${paginationInfo}"
							type="travelFront" jsFunction="fn_egov_link_page" />

						<form:hidden path="pageIndex" />
						<%-- </div> --%>

					</div>
			</div>
			<!-- cont_body -->
			</form:form>

		</div>
		<!-- // cont_wrap -->
	</div>
	<!--// container -->

	<!-- footer -->
	<%@ include file="/WEB-INF/jsp/travel/tpl/foot.jsp"%>
	<!--//footer -->
	</div>
	<!-- // wrap -->
	<!-- <style type="text/css">
	.local_lst li .tbox .tit span {
		width: 60px;
	}
	</style> -->
	<script>

	function fn_egov_link_page(pageNo){
		document.getElementById("travelRoute").pageIndex.value = pageNo;
		document.getElementById('iexcelPageno').value=pageNo;
		if(location.href.split('?')[1] =='open=Y')
			{
			document.getElementById("travelRoute").action = "<c:url value='/travel/route/list.do?open=Y'/>";
			}
		else
			{
			document.getElementById("travelRoute").action = "<c:url value='/travel/route/list.do'/>";
			}
	   	document.getElementById("travelRoute").submit();
	}
	
	function fn_egov_down_excel(pageNo){
		document.getElementById("travelRoute").pageIndex.value = pageNo;
		if(location.href.split('?')[1] =='open=Y')
			{
			document.getElementById("travelRoute").action = "<c:url value='/travel/route/dowexcel.do?open=Y'/>";
			}
		else
			{
			document.getElementById("travelRoute").action = "<c:url value='/travel/route/dowexcel.do'/>";
			}
	   	document.getElementById("travelRoute").submit();
	}
	
	function fn_egov_down_allexcel(pageNo){
		if(location.href.split('?')[1] =='open=Y')
		{
			document.getElementById("travelRoute").action = "<c:url value='/travel/route/alldowexcel.do?open=Y'/>";		
		}
	else
		{
		document.getElementById("travelRoute").action = "<c:url value='/travel/route/alldowexcel.do'/>";		
		}
	   	document.getElementById("travelRoute").submit();
	}
	</script>
</body>


</html>
