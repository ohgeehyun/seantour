<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fn_egov_select(mbrId) {
	document.getElementById("listForm").mbrId.value = mbrId;    
	document.getElementById("listForm").screenMode.value = "up";
    document.getElementById("listForm").action = "<c:url value='/cms/admin/addadminProc.do'/>";
    document.getElementById("listForm").submit();
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;	
	document.getElementById("listForm").action = "<c:url value='/cms/admin/addadmin.do'/>";
   	document.getElementById("listForm").submit();
}
$(document).ready(function(){
	$('#searchReset').click(function(e){
		$('#pageIndex').val(1);
		document.getElementById("listForm").action = "<c:url value='/cms/admin/addadmin.do'/>";
		document.getElementById("listForm").submit();
	});
	
});
 // -->
</script>
<!--콘텐츠시작-->
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		    <input type="hidden" name="adminId" id="adminId" />
		 	<input type="hidden" name="screenMode" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>회원 리스트</h3>
	                    </div>
	                   	<div class="widget-title">
	                   		<select name="searchCondition">
					       		<option value="9" <c:out value="${searchVO.searchCondition == '9' ? 'selected' : ''}"/>>아이디</option>
					       		<option value="10" <c:out value="${searchVO.searchCondition == '10' ? 'selected' : ''}"/>>이름</option>
					       		<option value="7" <c:out value="${searchVO.searchCondition == '7' ? 'selected' : ''}"/>>전화번호</option>
					       		<option value="15" <c:out value="${searchVO.searchCondition == '15' ? 'selected' : ''}"/>>유형</option>				       		
					       	</select>
	                       	<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
	       					<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>	       					
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover"summary="회원 리스트">
								<thead>
									<tr>
										<th>아이디</th>
										<th>이름</th>
										<th>부서</th>
										<th>직급</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">									 	
									 		<tr>
												<td><c:out value="${result.mbrLogin}"/></a></td>
												<td align="center"><c:out value="${result.mbrNm}"/></a></td>
												<td><c:out value="${result.orgNm}"/></a></td>											
												<td><c:out value="${result.posNm}"/></a></td>
												<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId }"/>');" class="btn btn-small">선택</a></td>
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
