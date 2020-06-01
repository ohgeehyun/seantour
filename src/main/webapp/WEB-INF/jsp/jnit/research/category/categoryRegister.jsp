<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitresearchcategoryVO").action = "<c:url value='/cms/category/categoryList.do'/>";
   	document.getElementById("jnitresearchcategoryVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
	if(confirm("삭제하시겠습니까?")){
	   	document.getElementById("jnitresearchcategoryVO").action = "<c:url value='/cms/category/deletcategoryProc.do'/>";
	   	document.getElementById("jnitresearchcategoryVO").submit();
	}
}


function fn_egov_save_check(){	
	var categoryName =$("#categoryName").val();
	if(categoryName == null || categoryName == ''){
		alert("카테고리 이름을 입력해 주시기 바랍니다.");
		$("#categoryName").focus();
		return false;		
	}
	return true;
}
/* 글 등록 function */
function fn_egov_save() {
	
	if(fn_egov_save_check()){		
		frm = document.getElementById("jnitresearchcategoryVO");        
		
		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/category/editcategoryProc.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/category/addcategoryProc.do'/>";
		</c:if>
	    frm.submit();
	}
}

// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<div class="row-fulid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>카테고리등록</h3>
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> <c:out value='${registerFlag}'/></a>
						<c:if test="${registerFlag == '수정'}">
						<a href="javascript:fn_egov_delete();" class="btn btn-small"><i class="icon-minus-sign"></i> 삭제</a>
						</c:if>
					</div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitresearchcategoryVO">
							<table class="table table-bordered" >
								<c:if test="${registerFlag == '수정'}">
									<input type="hidden" name="screenMode" value="up" />
								</c:if>
								<c:if test="${registerFlag == '등록'}">
									<input type="hidden" name="screenMode" value="" />
								</c:if>		
								<!-- <tr>
									<th>CATEGORY_ID</th>
									<td>
										<form:input path="categoryId" cssClass="txt"/>
										&nbsp;<form:errors path="categoryId" />
									</td>
								</tr>	
								<tr>
									<th>RESEARCH_ID</th>
									<td>
										<form:input path="researchId" cssClass="txt"/>
										&nbsp;<form:errors path="researchId" />
									</td>
								</tr>
								-->	
								<tr>
									<th>이름</th>
									<td style="vertical-align:middle;">
										<form:input id="categoryName" path="categoryName" cssClass="txt" cssStyle="width:27%" maxlength="25"/>&nbsp;
										&nbsp;<form:errors path="categoryName" />
									</td>
								</tr>	
								<!-- <tr>
									<th>ISDEL</th>
									<td>
										<form:input path="isdel" cssClass="txt"/>
										&nbsp;<form:errors path="isdel" />
									</td>
								</tr>
								 -->	
							</table>
						<!-- 검색조건 유지 -->
						<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
						<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>		
		</div>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
