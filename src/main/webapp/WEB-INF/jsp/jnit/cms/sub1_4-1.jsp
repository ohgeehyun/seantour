<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(rankId) {
    document.getElementById("listForm").rankId.value = rankId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub1/0402Edit.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub1/0402add.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub1/0401.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">	
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>직급분류 리스트</h3>
						<a href="javascript:fn_egov_addView();" class="btn btn-small">등록</a>
					</div>
					<div class="widget-content nopadding">
						<input type="hidden" name="screenMode" />
						<input type="hidden" name="rankId" />
						<table class="table table-bordered">
						<tr>
							<th align="center" style="width:10%;">직급분류코드</th>
							<th align="center">부서명</th>
							<th align="center">직급분류명</th>
							<!-- <th align="center">생성일</th>
							<th align="center">수정일</th> -->
							<!-- <th align="center">Isdel</th> -->
						</tr>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<c:if test="${result.connectType == 'seo' }" >
								<tr>
									<td align="center"><c:out value="${result.rankId}"/></td>
									<td align="center"><c:out value="${result.orgNm == '' || result.orgNm == null ? ' ' : result.orgNm }"/></td>
									<td align="center"><c:out value="${result.rankName}"/>&nbsp;</td>									
								</tr>		
							</c:if>
							<c:if test="${result.connectType != 'seo' }" >
								<tr>
									<td align="center" class="listtd"><c:out value="${result.rankId}"/></td>
									<td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.rankId}"/>')"><c:out value="${result.orgNm == '' || result.orgNm == null ? ' ' : result.orgNm }"/></a></td>
									<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.rankId}"/>')"><c:out value="${result.rankName}"/></a>&nbsp;</td>									
								</tr>
							</c:if>
						</c:forEach>
						</table>
						<!-- /List -->									
					</div>
				</div>
				<div id="page_navi" class="pagination">
						<ui:pagination paginationInfo = "${paginationInfo}"
								   type="jnitDefault"
								   jsFunction="fn_egov_link_page"
								   />
						<form:hidden path="pageIndex" />
				</div>
				<div class="row-fluid">
					<div class="widget-box">
						<div class="widget-content nopadding cmstipbox">
							<table class="table table-bordered table-striped th_left">
							<caption>cms TIP</caption>
							<tbody>
							<tr>
								<th colspan="2">
									<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
								</th>
								<td>
									<b>부서 내 직급을 분류 수 있습니다.</b><br />
									<b>통합 관리 &gt; 회원관리 &gt; 회원관리 &gt; 직급 분류명에 코드를 추가할 수 있는 기능입니다.</b>
								</td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>
				</div>				
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
