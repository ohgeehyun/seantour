<%
/**
 *@version 3.2.0.1
 **/
%>
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
function fn_egov_select(typeId) {
    document.getElementById("listForm").typeId.value = typeId;
    document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub2/0202upview.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub2/0202.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub2/0201.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
			<input type="hidden" name="typeId" />
			<input type="hidden" name="screenMode" />
			<input type="hidden" name="searchCondition" value="1" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>유형 리스트</h3>
	                       	<a href="<c:url value="/cms" />/sub2/0202.do" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
	                       	<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
	       					<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>
	                    </div>
	                    <div class="widget-content nopadding">	
							<table class="table table-bordered table-striped table-hover" summary="유형 리스트">
						        <thead>
						        	<tr>
						                <th width="13%">유형코드</td>
						                <th width="50%">유형명</td>
						                <th width="7%">레벨</td>
						                <th width="15%">등록일</td>
						                <th width="15%">수정일</td>
						        	</tr>
						        
						        <tbody>
						            <c:forEach var="result" items="${resultList}" varStatus="status">
						            <tr>
						                <td align="center"><c:out value="${result.typeId}"/></td>
						                <td><a href="javascript:fn_egov_select('<c:out value="${result.typeId}"/>')"><c:out value="${result.typeNm}"/></a></td>
						                <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.typeId}"/>')"><c:out value="${result.typeLv}"/></a></td>
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
								<b>각각의 사용자별 권한을 제어하기 위한 그룹 기능입니다.</b><br />
								<b>cms 관리자 접근 권한은 (환경설정 &lt; 관리자 메뉴 관리)에서 설정할 수 있습니다.</b>
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
