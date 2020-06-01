<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>

<!--For Commons Validator Client Side-->
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="jnitcmsorgVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsorgVO").action = "<c:url value='/cms/sub1/0201.do'/>";
   	document.getElementById("jnitcmsorgVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitcmsorgVO").action = "<c:url value='/cms/sub1/0202del.do'/>";
   	document.getElementById("jnitcmsorgVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsorgVO");

	/* TODO Validation기능 보완 */
	//if(!validateJnitcmsorgVO(frm)){
	//		return;
	//}
	
	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/cms/sub1/0202up.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/cms/sub1/0202add.do'/>";
	</c:if>
    frm.submit();

}

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
                   		<h3>부서 등록</h3>
                   		<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitcmsorgVO" >
						<table class="table table-bordered table-striped th_left" summary="부서 등록">
						<tbody>
						    <tr>
						        <th style="width: 80px;"><font color="red">*</font> 부서코드</th>
						        <td>
						        
						        <c:if test="${registerFlag == '수정'}">
								<c:out value='${jnitcmsorgVO.orgId}'/>
								<input type="hidden" id="orgId" name="orgId" value="<c:out value='${jnitcmsorgVO.orgId}'/>" />
								<input type="hidden" name="screenMode" value="up" />
								</c:if>
								<c:if test="${registerFlag == '등록'}">
								<c:if test="${empty jnitcmsorgVO.orgId}">
								<input readonly type="text" id="orgId" name="orgId" value="<c:out value='${nid}'/>" />
								</c:if>
								<c:if test="${not empty jnitcmsorgVO.orgId}">
								<input readonly type="text" id="orgId" name="orgId" value="<c:out value='${jnitcmsorgVO.orgId}'/>" />
								</c:if>
								<input type="hidden" name="screenMode" value="" />
								</c:if>
								&nbsp;<form:errors path="orgId" />
						    
						    </td>
							</tr>
							<tr>
							    <th><font color="red">*</font> 부서명</th>
							    <td>
						    	<form:input path="orgNm" cssClass="txt"/>
								&nbsp;<form:errors path="orgNm" /></td>
							</tr>
							<tr>
							    <th>정렬순서</th>
							    <td>
							    	<form:input path="orgRankOdr" cssClass="txt"/>
									&nbsp;<form:errors path="orgRankOdr" />
								</td>
							</tr>
							<tr>
							    <th>부서전화번호</th>
							    <td>
							    	<form:input path="orgTel" cssClass="txt"/>
									&nbsp;<form:errors path="orgTel" />
								</td>
							</tr>							
						    </tbody>
						</table>
					</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</
<!--콘텐츠끝-->
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
