<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
/* 글 수정 화면 function */
function fn_egov_select(siteNm) {
    document.getElementById("listForm").siteNm.value = siteNm;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/jnitmenu/updateJnitmenuView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitmenu/addJnitmenuView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/menu/sub14/0101.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 삭제 화면 function */
$(document).ready(function(){
	$("[id*='delete']").click(function(){
		if(!confirm("삭제하시겠습니까?")){
			
			document.getElementById("listForm").action = "<c:url value='/menu/sub14/0101.do'/>";
		}else{
			
			fn_egov_delete(menuSeq);
		}
	});
});

function fn_egov_delete(menuSeq) {
    document.getElementById("listForm").menuSeq.value = menuSeq;
	document.getElementById("listForm").screenMode.value = "del";
   	document.getElementById("listForm").action = "<c:url value='/menu/sub14/01delete.do'/>";
   	document.getElementById("listForm").submit();
}


//엑셀팝업
function openExcel(){
	var winUrl = "<c:url value="/menu/sub14/01popUp.do" />";
	
	var winZip = window.open(winUrl,"windowZip","width=500,height=190,top=0,left=0");
	winZip.focus();
}
 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		    <input type="hidden" name="screenMode" />
		    <input type="hidden" name="menuSeq" />
		    <input type="hidden" name="searchCondition" value="1" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>콘텐츠담당자DB관리</h3>
							    <a href="<c:url value="/menu/sub14/01excel.do" />" class="btn btn-small"><i class="icon-download"></i> 엑셀로 내려받기</a>
	    						<a href="javascript:openExcel()" class="btn btn-small"><i class="icon-upload"></i> 엑셀로 올리기</a>
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover" cellpadding="0" cellspacing="0" border="0" summary="콘텐츠담당자DB관리">
						        <thead>
						            <tr>
						                <th width="6%">사이트명</th>
						                <th width="6%">메뉴경로1</th>
						                <th width="6%">메뉴경로2</th>
						                <th width="6%">메뉴경로3</th>
						                <th width="6%">메뉴경로4</th>
						                <th width="6%">메뉴경로5</th>
						                <th width="6%">메뉴경로6</th>
						                <th width="6%">메뉴경로7</th>
						                <th width="6%">메뉴URL</th>
						                <th width="6%">담당부서</th>
						                <th width="6%">담당업무</th>
						                <th width="6%">전화번호</th>
						                <th width="6%">담당자</th>
						                <th width="6%">관리</th>
						            </tr>
						        </thead>
						        <tbody>
						            <c:forEach var="result" items="${resultList}" varStatus="status">
						                <tr>
						                    <td align="left"><c:out value="${result.siteNm}"/></td>
						                    <td align="left"><c:out value="${result.menuDepth1}"/></td>
						                    <td align="left"><c:out value="${result.menuDepth2}"/></td>
						                    <td align="left"><c:out value="${result.menuDepth3}"/></td>
						                    <td align="left"><c:out value="${result.menuDepth4}"/></td>
						                    <td align="left"><c:out value="${result.menuDepth5}"/></td>
						                    <td align="left"><c:out value="${result.menuDepth6}"/></td>
						                    <td align="left"><c:out value="${result.menuDepth7}"/></td>
						                    <td align="left"><a href="<c:url value="${result.menuUrl}"/>" target="_blank"><c:out value="${result.menuUrl}"/></a></td>
						                    <td align="left"><c:out value="${result.menuDept}"/></td>
						                    <td align="left"><c:out value="${result.menuPart}"/></td>
						                    <td align="left"><c:out value="${result.menuTel}"/></td>
						                    <td align="left"><c:out value="${result.menuMemid}"/></td>
						                    <td align="center"><button class="btn btn-small" id="delete" value="<c:out value="${result.menuSeq}"/>">삭제</button></td>
						                    
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