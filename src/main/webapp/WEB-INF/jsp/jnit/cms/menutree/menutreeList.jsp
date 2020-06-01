<%--
/**
 *@version 3.2.0.1
 **/
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Date" %>

<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp" %>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */

$(document).ready(function(){
	$('#searchReset').click(function(e){
		e.preventDefault();
		$('#pageIndex').val(1);
		document.getElementById("listForm").action = "<c:url value='/jnitcmsmenutree/List.do'/>";
		document.getElementById("listForm").submit();
	});
});

function fn_egov_select(menuCodeId) {
    document.getElementById("listForm").menuCodeId.value = menuCodeId;
   	document.getElementById("listForm").action = "<c:url value='/jnitcmsmenutree/Edit.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.getElementById("listForm").action = "<c:url value='/jnitcmsmenutree/add.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jnitcmsmenutree/List.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
			<input type="hidden" id="searchCondition" name="searchCondition" value="1"/>
		    <input type="hidden" id="menuCodeId" name="menuCodeId" />
			<input type="hidden" id="menuId" name="menuId" />
			<!-- List -->
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>메뉴트리 리스트</h3>
	                       	<a href="javascript:fn_egov_addView();" class="btn">추가</a>
	                       	<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
							<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover">
								<thead>
									<tr>
										<th align="center">메뉴뎁스</th>
										<th align="center">메뉴아이콘</th>
										<th align="center">메뉴명</th>
										<th align="center">메뉴링크</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td class="listtd" style="text-align:center;width:5%;"><c:out value="${result.menuDepth}"/>&nbsp;</td>
											<td class="listtd" style="text-align:center;width:5%;"><i class="icon icon-<c:out value="${result.menuIcon}"/>" style="font-size: 20px;"></i>&nbsp;</td>
											<td class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.menuCodeId}"/>')"><c:out value="${result.menuName}"/></a>&nbsp;</td>
											<td class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.menuCodeId}"/>')"><c:out value="${result.menuLink}"/></a>&nbsp;</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- /List -->
			<div id="page_navi" class="pagination">
               	<c:if test="${paginationInfo.totalPageCount <= 9}"><li class="first">&nbsp;</li><li class="pre">&nbsp;</li></c:if>
	                <ui:pagination paginationInfo = "${paginationInfo}"
	                    type="jnitDefault"
	                    jsFunction="fn_egov_link_page"
	                    />
				<c:if test="${paginationInfo.totalPageCount <= 9}"><li class="next">&nbsp;</li><li class="last">&nbsp;</li></c:if>
               	<form:hidden path="pageIndex" />
               </div>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>