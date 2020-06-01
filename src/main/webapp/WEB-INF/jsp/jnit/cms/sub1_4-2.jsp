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
   	document.getElementById("jnitcmsrankVO").action = "<c:url value='/cms/sub1/0401.do'/>";
   	document.getElementById("jnitcmsrankVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitcmsrankVO").action = "<c:url value='/cms/sub1/0402delProc.do'/>";
   	document.getElementById("jnitcmsrankVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {
	var orgId = $('#orgId option:selected').val();	
	var rankName = $('#rankName').val();
	
	if(rankName == '' || rankName == null){
		alert('팀이름을 입려해주시기 바랍니다.');
		$('#rankName').focus();
		return false;
	}
	if(orgId == ' ' || orgId == null){
		alert('부서코드를 선택해주세요');
		$('#orgId').focus();
		return false;
	}
	
	frm = document.getElementById("jnitcmsrankVO");

        /* ClientSite Validator */
	//if(!validateJnitcmsrankVO(frm)){
	//		return;
	//}
	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/cms/sub1/0402EditProc.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/cms/sub1/0402addProc.do'/>";
	</c:if>
    frm.submit();
}
$(document).ready(function(){	
	$('#orgId').val("${jnitcmsrankVO.orgId}");
});
// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>직급분류 ${registerFlag }</h3>
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> <c:out value='${registerFlag}'/></a>
						<c:if test="${registerFlag == '수정'}">
						<a href="javascript:fn_egov_delete();" class="btn btn-small btn-del" style="float:right;">삭제</a>
						</c:if>						
					</div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitcmsrankVO">
							<table class="table table-bordered" >						
							<c:if test="${registerFlag == '수정'}">
								<input type="hidden" name="screenMode" value="up" />
							</c:if>
							<c:if test="${registerFlag == '등록'}">
								<input type="hidden" name="screenMode" value="" />
							</c:if>		
							<tr>
								<th style="width: 10%;">직급분류코드</th>
								<td>
									<%-- <form:input path="rankId" cssClass="txt"/>
									&nbsp;<form:errors path="rankId" /> --%>
									<c:if test="${registerFlag == '등록' }" >
									<input type="text" name="rankId" id="rankId" value="<c:out value="${nid }"/>" readonly="readonly" />
									</c:if>
									<c:if test="${registerFlag == '수정' }" >
									<input type="text" name="rankId" id="rankId" value="<c:out value="${jnitcmsrankVO.rankId }"/>" readonly="readonly" />
									</c:if>									
								</td>
							</tr>
							<tr>
								<th>부서명</th>
								<td>
									<select name="orgId" id="orgId">
									<option value=" ">선택하세요</option>
									<c:forEach var="orgList" items="${orgList }">
									<option value="${orgList.orgId }">${orgList.orgNm }</option>
									</c:forEach>
									</select>
								</td>
							</tr>	
							<tr>
								<th>직급분류명</th>
								<td>
									<form:input path="rankName" cssClass="txt"/>
									&nbsp;<form:errors path="rankName" />
								</td>
							</tr>
							<!-- 	
							<tr>
								<th>CREATED</th>
								<td>
									<form:input path="created" cssClass="txt"/>
									&nbsp;<form:errors path="created" />
								</td>
							</tr>	
							<tr>
								<th>MODIFIED</th>
								<td>
									<form:input path="modified" cssClass="txt"/>
									&nbsp;<form:errors path="modified" />
								</td>
							</tr>	
							<tr>
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