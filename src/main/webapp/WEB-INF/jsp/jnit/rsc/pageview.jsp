<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">
var searchStats = function(){
	$('#listForm').attr('method','post');
	document.getElementById("listForm").pageIndex.value = "1";
	$('#listForm').submit();
};
$(document).ready(function(){
	$('#listForm select[name=sitepath]').val("${param.sitepath}");
});
/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "";
   	document.getElementById("listForm").submit();
}
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
			<input type="hidden" name="screenMode" />
			<input type="hidden" name="searchCondition" id="searchCondition" value="${searchVO.searchCondition}" />
			<input type="hidden" name="searchKeyword" id="searchKeyword" value="${searchVO.searchKeyword}" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>페이지 인기도 통계</h3>
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover" summary="페이지 인기도 통계">
								<thead>
									<tr>
										<th width="55%">페이지URL</td>
										<th>페이지제목</td>
										<th>페이지뷰</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList}" var="result">
									<tr>
										<td><a href="<c:url value="${result.pageUrl}"/>" target="_blank"><c:out value="${result.pageUrl}" escapeXml="true" /></a></td>
										<td align="center"><c:out value="${result.menuNm}" escapeXml="true" /></td>
										<td align="center"><c:out value="${result.pageView}" escapeXml="true" /></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div id="page_navi" class="pagination">
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="fn_egov_link_page"
							   />
					<form:hidden path="pageIndex" />
			</div>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
