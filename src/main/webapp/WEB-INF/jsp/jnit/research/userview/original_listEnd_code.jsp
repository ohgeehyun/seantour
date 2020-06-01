<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
<!--
function fn_egov_stats(researchId) {
    document.getElementById("listForm").researchId.value = researchId;
   	document.getElementById("listForm").action = "?";
   	document.getElementById("listForm").submit();
}

function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "?";
   	document.getElementById("listForm").submit();
}
// -->
</script>

<c:set var ="today" value = "<%=new Date()%>" />
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="researchId" />

<div id="content">
	<div class="contentStyle">
    	<table width="665" class="table_research tdCenter research_table" summary="진행중 설문조사">
        	<caption>진행중 설문조사</caption>
            <thead>
            	<tr>
                	<th>번호</th>
                	<th>설문제목</th>
                	<th>설문시작~종료일</th>
                	<!-- <th>대상</th> -->
                	<th>참여</th>
					<th>통계</th>
				</tr>
			</thead>
			<c:set var="cnt" value="${empty cnt ? paginationInfo.totalRecordCount : cnt}"/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
					<td>${cnt}</td>
				<td class="title"><font color="orange"><b>[설문]</b></font>
					<a href="javascript:fn_egov_stats('<c:out value="${result.researchId}"/>')"><c:out value="${result.researchNm}"/></a>&nbsp;
				</td>
				<td>
					<c:out value="${result.starttime}"/>~<c:out value="${result.endtime}"/>&nbsp;<br>
					<c:if test = "${(result.state == 0) && (today < result.starttime)}">설문접수이전</c:if>
					<c:if test = "${(result.state == 0) && (today > result.starttime) && (result.endtime > today)}">설문가능</c:if>
					<c:if test = "${(result.state == 0) && (result.endtime < today)}">설문기간만료</c:if>
					<c:if test = "${result.state == 1}">설문종료</c:if>
				</td>
				<%-- <td>
					<c:if test = "${result.block == 0}">전체</c:if>
					<c:if test = "${result.block == 1}">회원</c:if>
				</td> --%>
				<td>
					<c:out value="${result.entry}"/>&nbsp;
				</td>
				<td>
					<a href="javascript:fn_egov_stats('<c:out value="${result.researchId}"/>')">보기</a>
				</td>
			</tr>
			<c:set var ="cnt" value = "${cnt -1}" />
			</c:forEach>
		</table>

	 <div class="bbsPagination">
		<div class="span6 offset3"> <ui:pagination paginationInfo = "${paginationInfo}"   type="jnitDefault"   jsFunction="fn_egov_link_page"   /> </div>
		<form:hidden path="pageIndex" />
	</div>
	</div>
</div>
</form:form>