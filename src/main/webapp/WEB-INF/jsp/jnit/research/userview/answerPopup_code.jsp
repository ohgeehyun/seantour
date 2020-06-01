<!-- 
/**
 *@version 3.2.0.1
 **/
-->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link type="text/css" href="/resources/research/Jnit_content.css" media='all' rel='stylesheet' />
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script type="text/javascript">
function fn_egov_link_page(pageNo){
	e.preventDefault();
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/answer/popup.do'/>";
   	document.getElementById("listForm").submit();
}
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="get">
<div id="content_pop">
	<input type="hidden" id="answerId" name="answerId" value="${ThisAnswerId}"/>
		<table class="bbsView table table-bordered" width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
				<col/>			
			</colgroup>		  
			<tr>
				<th align="center">답변</th>
			</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${mode != 'order' }">
				<c:if test="${result.answer != '' && result.answer != null}">
				<tr>		
					<td align="center" class="listtd">
						<c:out value="${result.answer}"/>
					</td>
				</tr>
				</c:if>
			</c:if>
			<c:if test="${mode == 'order' }">
				<c:if test="${result.orderAnswer != '' && result.orderAnswer != null}">
				<tr>		
					<td align="center" class="listtd">
						<c:out value="${result.orderAnswer}"/>
					</td>
				</tr>
				</c:if>
			</c:if>
			</c:forEach>
		</table>
</div>
</form:form>

