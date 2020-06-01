<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
$(document).ready(function(){
	$('#searchReset').click(function(){
		$('#pageIndex').val(1);
	});
});
/* 글 수정 화면 function */
function fn_egov_select(tplId) {
    document.getElementById("listForm").tplId.value = tplId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub4/010201upview.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub4/010201addview.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub4/0102.do'/>";
   	document.getElementById("listForm").submit();
}

/* 미리보기 링크 function */
function fn_egov_preview(tplId){
	var msg = window.open('<c:url value="/cms/sub4/preview.do?tplId="/>'+tplId);
}

 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		    <input type="hidden" name="screenMode" />
		    <input type="hidden" name="tplId" />
		    <input type="hidden" name="searchCondition" value="3" />
		    <div class="row-fluid">
				<div class="widget-box">
					<div class="widget-title">
		    	   		<h3>서브템플릿</h3>
		    	   		<a href="<c:url value="/cms" />/sub4/010201.do" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
		    	   		<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
       					<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>
		       	    </div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped table-hover">
		                	<thead>
		                    	<tr>
		                    		<th style="width: 8%;">고유번호</th>
		                    		<th style="width: 19%;">템플릿명</th>
		                    		<th style="width: 30%;">설명</th>
		                    		<th style="width: 15%;">등록일</th>
		                			<th style="width: 14%;">수정일</th>
		                			<%--<th style="width: 14%;">미리보기</th> --%>
		                		</tr>
		                	</thead>    
		                    <tbody role="alert" aria-live="polite" aria-relevant="all">
		                    	<c:forEach var="result" items="${resultList}" varStatus="status">
							        <tr>
							            <td align="center"><c:out value="${result.tplId}"/></td>
							            <td><a href="javascript:fn_egov_select('<c:out value="${result.tplId}"/>')"><c:out value="${result.tplNm}"/></a></td>
							            <td><c:out value="${result.tplDesc}"/></td>
							            <td><c:out value="${result.created}"/></td>
							            <td><c:out value="${result.modified}"/></td>
							           <%-- <td><a href="javascript:fn_egov_preview('<c:out value="${result.tplId}"/>')">보기</a></td> --%>
							        </tr>
							    </c:forEach>
		                    </tbody>
		                 </table>
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

