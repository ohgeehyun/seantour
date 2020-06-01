<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

$(document).ready(function(){
	$('#searchReset').click(function(){
		$('#pageIndex').val(1);
	});
});

/* 글 수정 화면 function */
function fn_egov_select(clippingSiteId) {
    document.getElementById("listForm").clippingSiteId.value = clippingSiteId;
    document.getElementById("listForm").csMode.value = "write";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").clippingSiteId.value = "";
	document.getElementById("listForm").csMode.value = "write";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").clippingSiteId.value = "";
	document.getElementById("listForm").csMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
   	document.getElementById("listForm").submit();
}

 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form id="listForm" action="?">
			<input type="hidden" name="clippingSiteId" />
			<input type="hidden" name="csMode" />
			<input type="hidden" name="searchCondition" value="1" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value="${searchVO.pageIndex }" />" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>수집사이트 리스트</h3>
	                       	<a href="?csMode=write" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
	                       	<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
	       					<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>
	                    </div>
	                    <div class="widget-content nopadding">	
							<table class="table table-bordered table-striped table-hover" summary="수집사이트 리스트">
						        <thead>
						        	<tr>
						                <th width="13%">ID</td>
						                <th width="17%">사이트명</td>
						                <th width="40%">호출URL</td>
						                <th width="15%">등록일</td>
						                <th width="15%">수정일</td>
						        	</tr>
						        
						        <tbody>
						            <c:forEach var="result" items="${resultList}" varStatus="status">
						            <tr>
						                <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.clippingSiteId}"/>')"><c:out value="${result.clippingSiteId}"/></a></td>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.clippingSiteId}"/>')"><c:out value="${result.clippingSiteName}"/></a></td>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.clippingSiteId}"/>')"><c:out value="${result.realClippingUrl}"/></a></td>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.clippingSiteId}"/>')"><fmt:formatDate value="${result.created }" pattern="yyyy-MM-dd HH:mm:ss"/></a></td>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.clippingSiteId}"/>')"><fmt:formatDate value="${result.modified }" pattern="yyyy-MM-dd HH:mm:ss"/></a></td>
						            </tr>
						            </c:forEach>
						        </tbody>
						    </table>
						</div>
					</div>
				</div>
			</div>
			<div id="page_navi" class="pagination">
				<ul>
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="fn_egov_link_page"
							   />
				</ul>
			</div>
		</form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
