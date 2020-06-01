<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>S
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<c:set var="registerFlag" value="${empty jnitcmsmgmtitemVO.categoryId ? '등록' : '수정'}"/>
<script type="text/javascript">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsmgmtitemVO").action = "<c:url value='/cms/mgmt/item/list.do'/>";
   	document.getElementById("jnitcmsmgmtitemVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
	if(confirm("삭제하시겠습니까?")){
	   	document.getElementById("jnitcmsmgmtitemVO").action = "<c:url value='/mgmt/item/deleteProc.do'/>";
	   	document.getElementById("jnitcmsmgmtitemVO").submit();
	}
}

function fn_egov_save_bln(){
	var categoryNm = $("#categoryNm").val();
	var categoryVal = $("#categoryVal").val();
	if(categoryNm == '' || categoryNm == null){
		alert("이름을 입력해주시기 바랍니다.");
		$("#categoryNm").focus();
		return false;
	}else if(categoryVal == '' || categoryVal == null){
		alert("값을 입력해주시기 바랍니다.");
		$("#categoryVal").focus();
		return false;
	}
	return true;
}
/* 글 등록 function */
function fn_egov_save() {
	if(fn_egov_save_bln()){
		frm = document.getElementById("jnitcmsmgmtitemVO");

		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/mgmt/item/editProc.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/mgmt/item/addProc.do'/>";
		</c:if>
	    frm.submit();		
	}
}

function Jnit_help(){
	window.open("<c:url value='/cms/help.do'/>","help","resizable=yes scrollbars=no width=1000 height=850");
}
// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="jnitcmsmgmtitemVO">
		<form:hidden path="mgmtCategoryId" />
		<form:hidden path="categoryId" />
		<c:if test="${registerFlag == '수정' && jnitcmsmgmtitemVO.modifiYn == 1}">
			<c:set var="readonly" value="true"/>
		</c:if>
		<input type="hidden" name="mgmtType" value="${mgmtType }" />
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 목록</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> <c:out value='${registerFlag}'/></a>
						<c:if test="${registerFlag == '수정'}">
							<a href="javascript:fn_egov_delete();" class="btn btn-small" style="float: right; margin-right: 10px;"><i class="icon-minus-sign"></i> <font color="red">삭제</font></a>
						</c:if>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">												
							<tr>
								<th>이름</th>
								<td>	
									<form:input path="categoryNm" id="categoryNm" cssClass="txt" readonly="${readonly }" />					
								</td>
							</tr>	
							<tr>
								<th>값</th>
								<td>
									<form:input path="categoryVal" id="categoryVal" readonly="${readonly }" />
								</td>
							</tr>	
							<tr>
								<th>정렬순서</th>
								<td>									
									<input type="text" id="categorySort" name="categorySort" value="${registerFlag == '등록' ? maxCategorySort : jnitcmsmgmtitemVO.categorySort }"/>
								</td>
							</tr>							
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 검색조건 유지 -->
		<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
		<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>