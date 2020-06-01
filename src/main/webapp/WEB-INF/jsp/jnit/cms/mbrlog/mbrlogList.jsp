<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">
<!--
/* 글 수정 화면 function */


function fn_egov_select(mbrlogId) {
	document.getElementById("listForm").mbrlogId.value = mbrlogId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/mbrlog/edit.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/mbrlog/add.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/mbrlog/mbrlogList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	    <input type="hidden" name="screenMode" />
		<input type="hidden" name="mbrlogId" />
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>이력 리스트</h3>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped table-hover">
							<thead>
								<tr>
									<th>경로</th>
									<th>수정자</th>
									<th>IP</th>
									<th>수정일</th>
									<th>아이디</th>
									<th>성명</th>
									<th>내용</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td style="text-align:center;"><c:out value="${result.mbrlogPath}"/>&nbsp;</td>
									<td style="text-align:center;"><c:out value="${result.actMbrLogin}"/>&nbsp;</td>
									<td style="text-align:center;"><c:out value="${result.mbrIp}"/>&nbsp;</td>
									<td style="text-align:center;">									
										<c:if test="${DBType == 'ORACLE'  || DBType == 'TIBERO'}">
											<c:out value="${result.created }" />
										</c:if>
										<c:if test="${DBType != 'ORACLE' && DBType != 'TIBERO'}">
											<fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd HH:mm:ss" />
										</c:if>
									</td>
									<td style="text-align:center;"><c:out value="${result.mbrLogin}"/>&nbsp;</td>
									<td style="text-align:center;"><c:out value="${result.mbrNm}"/>&nbsp;</td>
									<td style="text-align:center;"><c:out value="${result.mbrlogContent}"/>&nbsp;</td>
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
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>