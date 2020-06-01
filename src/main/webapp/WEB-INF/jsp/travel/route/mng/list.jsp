<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<% String type = request.getParameter("type"); %>
<c:set var="type" value="<%= type %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<div class="list_content2">
			<%-- Contents Start --%>
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
					<form:form commandName="travelRoute" method="post">
					    <input type="hidden" name="screenMode" />
					    <%-- <input type="hidden" id="groupId" name="groupId" /> --%>
					    <%-- <input type="hidden" name="grpId" value="${grpId}" /> --%>
					    <%-- <input type="hidden" id="type" name="type" value="${type}" /> --%>
					    <input type="hidden" name="searchCondition" id="searchCondition" value="">
						<%-- <input type="hidden" name="searchKeyword" id="searchKeyword" value=""> --%>
	                   	<%-- <div class="widget-title">
							<h3>그룹 리스트</h3>
							<a href="<c:url value="/cms/travel/route/register.do"/>" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>
	                    </div> --%>
						<div class="widget-title">
							<a href="<c:url value="/cms/travel/route/register.do"/>" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>

							<form:select path="routRegion" onchange="fn_egov_link_page(1);">
								<option value="">지역</option>
		                    	<form:options items="${regionList}" itemLabel="destRegion" itemValue="destRegion"/>
		                    </form:select>
							<%-- <select class="sc_local" name="destCategory" id="destCategory" onchange="fn_egov_link_page(1);">
								<option value="">분류</option>
								<option value="관광지" <c:if test="${travelRoute.destCategory eq '관광지'}">selected</c:if>>관광</option>
								<option value="숙박" <c:if test="${travelRoute.destCategory eq '숙박'}">selected</c:if>>숙박</option>
								<option value="체험" <c:if test="${travelRoute.destCategory eq '체험'}">selected</c:if>>레져</option>
								<option value="음식점" <c:if test="${travelRoute.destCategory eq '음식점'}">selected</c:if>>식당</option>
								<option value="쇼핑" <c:if test="${travelRoute.destCategory eq '쇼핑'}">selected</c:if>>쇼핑</option>
							</select> --%>
							<form:input path="searchKeyword" cssClass="txt" maxlength="50" />
						</div>

	                    <div class="widget-content nopadding" style="overflow: auto; height: 582px;">
							<table class="table table-bordered table-striped table-hover" summary="그룹 테이블">
								<thead>
									<tr>
										<th>일정그룹</th>
										<th>일정제목</th>
										<th>일차</th>
										<th>지역</th>
										<th>출발지</th>
										<th>경유지</th>
										<th>도착지</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody>		
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="conts"><c:out value="${result.routGroup}"/></td>
										<td class="conts"><c:out value="${result.routTitle}"/></td>
										<td class="conts"><c:out value="${result.routDays}"/> 일차</td>
										<td class="conts"><c:out value="${result.routRegion}"/></td>
										<td class="conts"><c:out value="${result.routStartPoint}"/></td>
										<td class="conts">
											<c:forEach var="points" items="${result.routePointList}" varStatus="stat">
												<span class="badge badge-small">
													<c:out value="${stat.count}" />-<c:out value="${points.destTitle}" />
												</span>
													<c:if test="${not stat.last}"><i class="icon-arrow-right"></c:if> 
											</c:forEach>
										</td>
										<td class="conts"><c:out value="${result.routDestPoint}"/></td>
										<td class="conts">
											<a href="<c:url value="/cms/travel/route/modify.do?routId=${result.routId}&screenMode=up"/>" class="btn btn-small"><i class="icon-edit-sign"></i> 수정</a>
											<%-- <a href="<c:url value="/cms/travel/route/delete.do?routId=${result.routId}"/>" class="btn btn-small"><i class="icon-trash"></i> 삭제</a> --%>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<div id="page_navi">
								<ui:pagination paginationInfo="${paginationInfo}" type="jnitDefault" jsFunction="fn_egov_link_page" />
								<form:hidden path="pageIndex" />
							</div>
						</div>
					</form:form>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<link rel="stylesheet" type="text/css" href="/css/travel/cms.admin.css">
<script type="text/javascript">
function fn_egov_link_page(pageNo){
	document.getElementById("travelRoute").pageIndex.value = pageNo;
	document.getElementById("travelRoute").action = "<c:url value='/cms/travel/route/list.do'/>";
   	document.getElementById("travelRoute").submit();
}
</script>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>