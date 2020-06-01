<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitsmsaddressbookVO").action = "<c:url value='/cms/sms/addressbookList.do'/>";
   	document.getElementById("jnitsmsaddressbookVO").submit();		
}

/* 글 삭제 function
function fn_egov_delete() {
   	document.getElementById("jnitsmsaddressbookVO").action = "<c:url value='/jnitsmsaddressbook/deleteJnitsmsaddressbook.do'/>";
   	document.getElementById("jnitsmsaddressbookVO").submit();		
}
*/

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitsmsaddressbookVO");
	frm.action = "<c:url value='/cms/sms/addressbookAddProc.do'/>";
    frm.submit();
}

// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span6" id="sendList">
               	<div class="widget-box">
					<div class="widget-content nopadding">
						<form:form commandName="jnitsmsaddressbookVO">
						    <div id="table">
						        <table class="table table-bordered table-striped th_left" summary="sms addressbook 테이블" align="center">
						        	<tbody>
							            <c:if test="${registerFlag == '수정'}">
							                <input type="hidden" name="screenMode" value="up" />
							            </c:if>
							            <c:if test="${registerFlag == '등록'}">
							                <input type="hidden" name="screenMode" value="" />
							            </c:if>
							            <tr>
							                <th>ADDR_MBR_ID</th>
							                <td>
							                    <form:input path="addrMbrId" cssClass="txt" />&nbsp;
							                    <form:errors path="addrMbrId" />
							                </td>
							            </tr>
							            <tr>
							                <th>ADDR_NAME</th>
							                <td>
							                    <form:input path="addrName" cssClass="txt" />&nbsp;
							                    <form:errors path="addrName" />
							                </td>
							            </tr>
							            <tr>
							                <th>ADDR_PHONE</th>
							                <td>
							                    <form:input path="addrPhone" cssClass="txt" />&nbsp;
							                    <form:errors path="addrPhone" />
							                </td>
							            </tr>
						            </tbody>
						        </table>
						    </div>
						</div>
						<!-- 검색조건 유지 -->
						<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
						<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>