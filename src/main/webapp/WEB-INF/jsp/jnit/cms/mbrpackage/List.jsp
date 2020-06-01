<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

/* 글 수정 화면 function */
function fn_egov_select(packId) {
	document.getElementById("listForm").packId.value = packId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/mbrPackage/edit.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/mbrPackage/add.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/mbrPackage/list.do'/>";
   	document.getElementById("listForm").submit();
}

function fn_egov_help(){
	
	var url = "/resources/img/mbrpackage/MBRPackage.jpg";
	var options = "width=350,height=180";
	window.open(url,options);
	
}

// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		    <input type="hidden" name="screenMode" />
			<input type="hidden" name="packId" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                   		<h3>회원 패키지 리스트</h3>
	                   		<a href="javascript:fn_egov_addView();" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>
	                   		<a href="javascript:fn_egov_help();" class="btn btn-small"> 사용방법</a>
	                   	</div>
	                   	<div class="widget-content nopadding">
						    <table class="table table-bordered table-striped table-hover" summary="게시판 리스트">
						        <thead>
									<tr>
										<th align="center" style="width: 20%;">고유값</th>
										<th align="center" style="width: 20%;">패키지명</th>
										<th align="center" style="width: 60%;">설명</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.packId}"/>')"><c:out value="${result.packId}"/></a>&nbsp;</td>
											<td align="center"><c:out value="${result.packageNm}"/>&nbsp;</td>
											<td align="center"><c:out value="${result.comment}"/>&nbsp;</td>
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
								<img src="/resources/img/mbrpackage/MBRPackage.jpg" alt="회원패키지 사용방법 이미지" />
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