<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */

$(document).ready(function(){
	siteReloadStopMsg = "사이트관리 이용중에는 선택할 수 없습니다.";
	siteReloadStop = true;
});

function fn_egov_select(siteId) {
    document.getElementById("listForm").siteId.value = siteId;
   	document.getElementById("listForm").action = "<c:url value='/cms/sub3/0102upview.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
   	document.getElementById("listForm").action = "<c:url value='/cms/sub3/0102addview.do'/>";
   	document.getElementById("listForm").submit();		
}

/* 사이트 백업 */
function fn_egov_backup(sitePath, siteIdx) {
	alert("사이트의 크기에 따라 다소 시간이 걸릴 수 있습니다.");
	$("#myModal").modal("show");
	$.ajax({
		url:"<c:url value='/cms/sub3/backup.do'/>",
		data:{
			sitePath: sitePath,
			siteIdx: siteIdx
		}
		
	}).done(function(data){
		alert("/WEB-INF/_backup 경로에"+sitePath+".zip 파일이 저장되었습니다.");
		$("#myModal").modal("hide");
		
	});
	
	
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub3/0101.do'/>";
   	document.getElementById("listForm").submit();
}

$(document).ready(function(){
	try {
		parent.loadSite();	
	}catch(e) {
		//	
	}	
});

 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		    <input type="hidden" name="siteId" />
		    <input type="hidden" name="searchCondition" value="1" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>사이트 리스트</h3>
	                       	<a href="<c:url value="/cms" />/sub3/0102.do" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
	                       	<%--
		                       	<input name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
	        					<button>검색</button>
					       	--%>
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover" summary="사이트 리스트">
						        <thead>
						            <tr>
						                <th width="30%">사이트명</td>
						                <th width="18%">경로</td>
						                <th width="10%">공개</td>
						                <th width="14%">등록일</td>
						                <th width="14%">수정일</td>
						                <th width="14%">백업</td>
						            </tr>
						        </thead>
						        <tbody>
						            <c:forEach var="result" items="${resultList}" varStatus="status">
						            <tr>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.siteId}"/>')"><c:out value="${result.siteNm}"/></a></td>
						                <td><c:out value="${result.sitePath}"/></td>
						                <td><c:out value="${result.active == 1 ? '공개' : '비공개'}"/></td>
						                <td><c:out value="${result.created}"/></td>
						                <td><c:out value="${result.modified}"/></td>
						                <td><a href="javascript:fn_egov_backup('<c:out value="${result.sitePath}"/>','<c:out value="${result.siteId}"/>')">[백업]</a></td>
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
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-body">
        <img alt="loading" src="<c:out value="/images/loading03.gif"/> " style="width: 200px; margin-left: 30%"/><br />
        <font style="text-align: center; margin-left:34%;">사이트를 백업하는 중입니다.</font>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
