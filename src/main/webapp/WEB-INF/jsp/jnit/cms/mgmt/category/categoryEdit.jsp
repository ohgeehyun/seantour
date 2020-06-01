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

<c:set var="registerFlag" value="${empty jnitcmsmgmtcategoryVO.mgmtCategoryId ? '등록' : '수정'}"/>

<script type="text/javascript">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsmgmtcategoryVO").action = "<c:url value='/cms/mgmt/category/list.do'/>";
   	document.getElementById("jnitcmsmgmtcategoryVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitcmsmgmtcategoryVO").action = "<c:url value='/mgmt/category/deleteProc.do'/>";
   	document.getElementById("jnitcmsmgmtcategoryVO").submit();		
}S

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsmgmtcategoryVO");

        /* ClientSite Validator */
	//if(!validateJnitcmsmgmtcategoryVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/cms/mgmt/category/addProc.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/cms/mgmt/category/addProc.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="jnitcmsmgmtcategoryVO">
		<form:input path="mgmtCategoryId" />
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:fn_egov_selectList();" class="btn btn-small">목록</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><c:out value='${registerFlag}'/></a>
						<c:if test="${registerFlag == '수정'}">
							<a href="javascript:fn_egov_delete();" class="btn btn-small">삭제</a>
						</c:if>						
					</div>
					<div class="widget-content nopadding">
						<table class="table table-borderd">							
							<tr>
								<th>MGMT_CATEGORY_ID</th>
								<td></td>
							</tr>		
							<tr>
								<th>SITE_ID</th>
								<td>
									<form:input path="siteId" cssClass="txt"/>
									&nbsp;<form:errors path="siteId" />
								</td>
							</tr>	
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 검색조건 유지 -->
		<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
		<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>