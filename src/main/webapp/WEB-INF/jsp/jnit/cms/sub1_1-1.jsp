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
	$('#searchReset').click(function(){
		$('#pageIndex').val(1);
	});
});

function fn_egov_select(posId) {
    document.getElementById("listForm").posId.value = posId;
    document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub1/0102up.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub1/0102.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub1/0101.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		   	<input type="hidden" name="posId" />
		   	<input type="hidden" name="screenMode" />
		   	<input type="hidden" name="searchCondition" value="1" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>직급리스트</h3>
	                       	<a href="<c:url value="/cms" />/sub1/0102.do" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
                       		<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
        					<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>
	                    </div>
	                    <div class="widget-content nopadding">
						   <table class="table table-bordered table-striped table-hover" summary="직급 리스트">
						       <thead>
						       	<tr>
					               <th width="12%">직급코드</th>
					               <th width="51%">직급명</th>
					               <th width="7%">등급</th>
					               <th width="15%">등록일</th>
					               <th width="15%">수정일</th>
						       	</tr>
						       </thead>
						       <tbody>
						       <c:forEach var="result" items="${resultList}" varStatus="status">
						       		<tr>
						               <td align="center"><c:out value="${result.posId}"/></td>
						               <td><a href="javascript:fn_egov_select('<c:out value="${result.posId}"/>')"><c:out value="${result.posNm}"/></a></td>
						               <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.posId}"/>')"><c:out value="${result.posLv}"/></a></td>
						               <td><c:out value="${result.created}"/></td>
						               <td><c:out value="${result.modified}"/></td>
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
								<b>통합 관리 &gt; 회원관리 &gt; 회원관리 &gt; 직급에 코드를 추가할 수 있는 기능입니다.</b>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
