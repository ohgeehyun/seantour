<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

$(document).ready(function(){
	$('#searchReset').click(function(){
		document.getElementById("listForm").cdMode.value = "";
		$('#pageIndex').val(1);
	});
});

/* 글 수정 화면 function */
function fn_egov_select(clippingSiteId, clippingConfId, clippingDataKeyparam) {
	document.getElementById("listForm").clippingSiteId.value = clippingSiteId;
	document.getElementById("listForm").clippingConfId.value = clippingConfId;
    document.getElementById("listForm").clippingDataKeyparam.value = clippingDataKeyparam;
    document.getElementById("listForm").cdMode.value = "view";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").clippingDataKeyparam.value = "";
	document.getElementById("listForm").cdMode.value = "write";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").clippingDataKeyparam.value = "";
	document.getElementById("listForm").cdMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
   	document.getElementById("listForm").submit();
}

 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form id="listForm" action="?">
			<input type="hidden" name="clippingDataKeyparam" />
			<input type="hidden" name="clippingSiteId" />
			<input type="hidden" name="clippingConfId" />
			<input type="hidden" name="cdMode" />
			<input type="hidden" name="searchCondition" value="1" />
			<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value="${searchVO.pageIndex }" />" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>수집된데이터 리스트</h3>
	                       	<select id="searchClippingSiteId" name="searchClippingSiteId" class="noSelect2">
			                	<option value="">수집사이트 선택</option>
			                <c:forEach items="${clippingSiteList }" var="site">
			                	<option value="${site.clippingSiteId }"${site.clippingSiteId == searchVO.clippingSiteId?' selected="selected"':''  }><c:out value="${site.clippingSiteName }" /></option>
			                </c:forEach>
			                </select>
	                       	<select id="searchClippingConfId" name="searchClippingConfId" class="noSelect2">
			                	<option value="">수집설정 선택</option>
			                <c:forEach items="${clippingConfList }" var="conf">
			                	<option value="${conf.clippingConfId }"${conf.clippingConfId == searchVO.clippingConfId?' selected="selected"':'' }><c:out value="${conf.clippingConfName }" /></option>
			                </c:forEach>
			                </select>
	                       	<!-- input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>" -->
	       					<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>
	                    </div>
	                    <div class="widget-content nopadding">	
							<table class="table table-bordered table-striped table-hover" summary="기초데이터 리스트">
						        <thead>
						        	<tr>
						                <th width="25%">사이트명</td>
						                <th width="25%">설정명</td>
						                <th width="25%">키</td>
						                <th width="15%">등록일</td>
						        	</tr>
						        
						        <tbody>
						            <c:forEach var="result" items="${resultList}" varStatus="status">
						            <tr>
						                <td>
						                <c:forEach items="${clippingSiteList }" var="site">
						                	<c:if test="${site.clippingSiteId == result.clippingSiteId }"><c:out value="${site.clippingSiteName }" /></c:if>
						                </c:forEach>						                
						                </td>
						                <td><a href='javascript:fn_egov_select("${result.clippingSiteId }","${result.clippingConfId }","<c:out value="${result.clippingDataKeyparam}"/>")'><c:out value="${result.clippingConfName}"/></a></td>
						                <td><a href='javascript:fn_egov_select("${result.clippingSiteId }","${result.clippingConfId }","<c:out value="${result.clippingDataKeyparam}"/>")'><c:out value="${result.clippingDataKeyparam}"/></a></td>
						                <td><a href='javascript:fn_egov_select("${result.clippingSiteId }","${result.clippingConfId }","<c:out value="${result.clippingDataKeyparam}"/>")'><fmt:formatDate value="${result.created }" pattern="yyyy-MM-dd HH:mm:ss"/></a></td>
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
