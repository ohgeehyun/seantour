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

	                    <div class="widget-content nopadding" style="overflow: auto; height: 650px;">
							<table class="table table-bordered table-striped table-hover" summary="그룹 테이블">
								<thead>
									<tr>
										<th>대표이미지</th>
										<th>일정제목</th>
										<th>지역</th>
										<th>작성자</th>
										<th>추천수</th>
										<th>조회수</th>
										<th>작성일</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody>		
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="conts">
											<%-- <c:set var="routThumbPath" value="${empty result.routThumbPath ? '/images/travel/content/noimg.jpg' : 'http://seantour.com'.concat(result.routThumbPath)}" /> --%>
											<c:set var="routThumbPath" value="${empty result.routThumbPath ? '/images/travel/content/noimg.jpg' : result.routThumbPath}" />
											<img src='<c:url value="${routThumbPath}"/>' alt='<c:out value="${result.routTitle}"/>' style="width:50px;height:40px;" />
										</td>
										<td class="conts"><c:out value="${result.routTitle}"/></td>
										<td class="conts"><c:out value="${result.routRegion}"/></td>
										<td class="conts"><c:out value="${result.routRegMemberNm}"/></td>
										<td class="conts"><c:out value="${result.routRecomm}"/></td>
										<td class="conts"><c:out value="${result.routHit}"/></td>
										<td class="conts"><c:out value="${fn:substring(result.routRegDate,0,10)}"/></td>
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

<link rel="stylesheet" type="text/css" href="<c:url value="/css/travel/cms.admin.css"/>">
<script type="text/javascript">
function fn_egov_link_page(pageNo){
	document.getElementById("travelRoute").pageIndex.value = pageNo;
	document.getElementById("travelRoute").action = "<c:url value='/cms/travel/route/list.do'/>";
   	document.getElementById("travelRoute").submit();
}
</script>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>