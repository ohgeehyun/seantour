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

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(ebookId) {	
	document.getElementById("listForm").ebookId.value = ebookId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/ebook/edit.do'/>";   	
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/ebook/add.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/ebook/list.do'/>";
   	document.getElementById("listForm").submit();
}
function fn_egov_copy(url){
	var IE=(document.all)?true:false;
	if (IE) {
		window.clipboardData.setData("Text", url);
	}else {
		temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", url);
	}
}
 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">	
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	    <input type="hidden" name="screenMode" />
		<input type="hidden" name="ebookId" />
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:fn_egov_addView();" class="btn btn-small">등록</a>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">
							<tr>
								<th style="width: 10%;">번호</th>
								<th>제목</th>
								<th style="width: 10%;">미리보기</th>
								<th style="width: 30%;">링크주소</th>
							</tr>
							<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.ebookId}"/>')"><c:out value="${result.ebookId}"/></a>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ebookTitle}"/>&nbsp;</td>
								<td>									
									<a href="<c:url value="/upload/ebook/${result.ebookId }/ebook/index.html"/>" target="_blank" title="새창으로 열립니다." class="btn btn-small">미리보기</a>
								</td>								
								<td>
									<%-- <a href="javascript:fn_egov_copy('/upload/ebook/${result.ebookId }/ebook/index.htm');" target="_blank" class="btn btn-small">복사하기</a> --%>
									<c:out value="/upload/ebook/${result.ebookId }/ebook/index.html"/>
								</td>
							</tr>
							</c:forEach>
						</table>					
					</div>
				</div>
				<div id="page_navi" class="pagination">
						<ui:pagination paginationInfo = "${paginationInfo}"
								   type="jnitDefault"
								   jsFunction="fn_egov_link_page"
								   />
						<form:hidden path="pageIndex" />
				</div>
			</div>		
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>