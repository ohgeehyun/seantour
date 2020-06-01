<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="wsol" uri="/WEB-INF/tlds/wsCustomTag.tld" %> --%>

<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<%-- <% String type = request.getParameter("type"); %>
<c:set var="type" value="<%= type %>" /> --%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<div class="list_content2">
			<%-- Contents Start --%>
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">

					<%-- <form:form commandName="travelDestination" name="listForm" id="listForm" method="post"> --%>
					<form:form commandName="travelDestination" method="post">
					    <input type="hidden" name="screenMode" />
					    <%-- <input type="hidden" id="type" name="type" value="${type}" /> --%>
					    <input type="hidden" name="searchCondition" id="searchCondition" value="">
						<%-- <input type="hidden" name="searchKeyword" id="searchKeyword" value=""> --%>

	                   	<%-- <div class="widget-title">
							<h3>그룹 리스트 <c:out value="${travelDestination.destRegion}" escapeXml="false" /></h3>
							<a href="<c:url value="/cms/travel/destination/register.do"/>" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>
	                    </div> --%>

						<div class="widget-title">
							<a href="<c:url value="/cms/travel/destination/register.do"/>" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>

							<form:select path="destRegion" onchange="fn_egov_link_page(1);">
								<option value="">지역</option>
		                    	<form:options items="${regionList}" itemLabel="destRegion" itemValue="destRegion"/>
		                    </form:select>
							<select class="sc_local" name="destCategory" id="destCategory" onchange="fn_egov_link_page(1);">
								<option value="">분류</option>
								<option value="관광지" <c:if test="${travelDestination.destCategory eq '관광지'}">selected</c:if>>관광</option>
								<option value="숙박" <c:if test="${travelDestination.destCategory eq '숙박'}">selected</c:if>>숙박</option>
								<option value="체험" <c:if test="${travelDestination.destCategory eq '체험'}">selected</c:if>>레져</option>
								<option value="음식점" <c:if test="${travelDestination.destCategory eq '음식점'}">selected</c:if>>식당</option>
								<option value="쇼핑" <c:if test="${travelDestination.destCategory eq '쇼핑'}">selected</c:if>>쇼핑</option>
							</select>
							<form:input path="searchKeyword" cssClass="txt" maxlength="50" />
							<p style="color:red;margin:5px"><i class="icon-info-sign"></i> 데이터베이스 이전 및 첨부파일 이전작업 마무리 이전까지는 신규업로드 이미지가 목록에서 표시되지 않습니다. 수정화면에서 이미지가 보이면 정상적으로 업로드된 것입니다.</p>
						</div>

	                    <div class="widget-content nopadding" style="overflow: auto; height: 650px;">
							<table class="table table-bordered table-striped table-hover" summary="그룹 테이블">
								<thead>
									<tr>
										<th>대표이미지</th>
										<th>명칭</th>
										<th>부제</th>
										<th>지역</th>
										<th>분류</th>
										<%-- <th>홈페이지</th> --%>
										<%-- <th>사진</th> --%>
										<%-- <th>연락처</th> --%>
										<%-- <th>주소</th> --%>
										<%-- <th>좌표</th> --%>
										<%-- <th>특징</th> --%>
										<%-- <th>정보</th> --%>
										<%-- <th>설명</th> --%>
										<th>등록일</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody>		
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="conts">
										<c:if test="${fn:length(result.travelFileList) eq 0}">
											<c:set var="destImgPath" value="${empty result.destImgPath ? '/images/travel/content/noimg.jpg' : result.destImgPath}" />
											<img src='<c:url value="${destImgPath}"/>' alt='<c:out value="${result.destTitle}"/>' style="width:50px;height:40px;" />
										</c:if>	
										<c:if test="${fn:length(result.travelFileList) gt 0}">
											<img src='<c:out value="${result.travelFileList[0].imgFilePath}"/>' alt='<c:out value="${result.destTitle}"/>' style="width:50px;height:40px;" />
										</c:if>	
										</td>
										<td class="conts"><c:out value="${result.destTitle}"/></td>
										<td class="conts"><c:out value="${result.destAdSlogan}"/></td>
										<td class="conts"><c:out value="${result.destRegion}"/></td>
										<td class="conts"><c:out value="${result.destCategory}"/></td>
										<%-- <td class="conts"><c:out value="${result.destWebsiteUrl}"/></td> --%>
										<%-- <td class="conts"><c:out value="${result.destImgPath}"/></td> --%>
										<%-- <td class="conts"><c:out value="${result.destPhone}"/></td> --%>
										<%-- <td class="conts"><c:out value="${result.destAddress}"/></td> --%>
										<%-- <td class="conts"><c:out value="${result.destFeature}"/></td> --%>
										<%-- <td class="conts"><c:out value="${result.destInformation}"/></td> --%>
										<%-- <td class="conts"><c:out value="${result.destDescription}"/></td> --%>
										<td class="conts"><c:out value='${fn:substring(result.destRegDatetime,0,10)}'/></td>
										<td class="conts">
											<a href="<c:url value="/cms/travel/destination/modify.do?destId=${result.destId}&screenMode=up"/>" class="btn btn-small"><i class="icon-edit-sign"></i> 수정</a>
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
	document.getElementById("travelDestination").pageIndex.value = pageNo;
	document.getElementById("travelDestination").action = "<c:url value='/cms/travel/destination/list.do'/>";
   	document.getElementById("travelDestination").submit();
}
</script>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>