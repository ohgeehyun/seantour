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

function fn_egov_entry(researchId) {
    document.getElementById("listForm").researchId.value = researchId;
   	document.getElementById("listForm").action = "?";
   	document.getElementById("listForm").submit();
}

function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "?";
   	document.getElementById("listForm").submit();
}
function target_list(researchId){
	var winUrl = "<c:url value='/targetList/popup.do?researchId="+researchId+"'/>";
	var winZip = window.open(winUrl,"targetList","width=500,height=400,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
function research_entry(researchId){
	var winUrl = "<c:url value='/research/ImportResearch.do?mode=entry&researchId="+researchId+"&popupMode=true'/>";
	var winZip = window.open(winUrl,"windowZip","width=800,height=600,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
function research_stats(researchId){
	var winUrl = "<c:url value='/research/ImportResearch.do?mode=stats&researchId="+researchId+"&popupMode=true'/>";
	var winZip = window.open(winUrl,"windowZip","width=800,height=600,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
// -->
</script>

<div class="row-fluid boardWrap normal">
<c:set var ="today" value = "<%=new Date()%>" />
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" id="researchId" name="researchId"/>
    	<table class="bbsList table table-bordered table-hover research_table" summary="설문조사 리스트">
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
			<c:if test="${empty resultList }" >
			<tbody>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<!-- <td></td> -->
				<td></td>
				<td></td>
			</tr>
			</tbody>
			</c:if>
			<c:if test="${!empty resultList }" >
			<c:set var="cnt" value="${empty cnt ? paginationInfo.totalRecordCount : cnt}"/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
					<td>${cnt}</td>
				<td class="title">
					<c:if test = "${today < result.starttime}">
						<font color="orange"><b>[이전]</b></font>
						<c:out value="${result.researchNm}"/>
					</c:if>
					<c:if test = "${(today > result.starttime) && (result.endtime > today)}">
						<font color="orange"><b>[진행]</b></font>

						<a href="?mode=entry&amp;researchId=<c:out value="${result.researchId}"/>"><c:out value="${result.researchNm}"/></a>
					<%-- 
						<a href="javascript:research_entry('${result.researchId}')"> <c:out value="${result.researchNm}"/></a>
					 --%>
					</c:if>
					<c:if test = "${(result.endtime < today)}">
						<font color="orange"><b>[종료]</b></font>
						 <c:out value="${result.researchNm}"/>
						<%--
						<a href="?mode=stats&amp;researchId=<c:out value="${result.researchId}"/>"><c:out value="${result.researchNm}"/></a>
						 --%>
					</c:if>
					<%-- <c:if test = "${result.state == 1}">
						<c:out type='hidden' value="${result.researchNm}" />
						<font color="orange"><b>[종료]</b></font>
						<c:out value="${result.researchNm}"/>
						
						<a href="?mode=stats&amp;researchId=<c:out value="${result.researchId}"/>"><c:out value="${result.researchNm}"/></a>
						
					</c:if> --%>
				</td>
				<td>
					<fmt:formatDate value="${result.starttime}" pattern="yyyy년 MM월 dd일 HH시"/>
					~
					<fmt:formatDate value="${result.endtime}" pattern="yyyy년MM월dd일 HH시"/>
					
				</td>
				<%-- <td>
					<c:if test="${result.researchTarget == '' || result.researchTarget == null || fn:contains(result.researchTarget, '1750000')}">전체</c:if>
					<c:if test="${result.researchTarget != '' && result.researchTarget != null &&!fn:contains(result.researchTarget, '1750000')}">
						<a href="javascript:target_list('${result.researchId}');" class="btn">대상 보기</a>
					</c:if>
				</td> --%>
				<td>
					<c:out value="${result.entry}"/>
				</td>
				<td>
				
					
				 
					<c:if test="${result.resultOpen == 0}">
						<a class="btn btn-mini" href="?mode=stats&amp;researchId=<c:out value="${result.researchId}"/>">보기</a>
				 		<%-- <a class="btn btn-mini" href="javascript:research_stats('${result.researchId}')">보기</a> --%>
					</c:if>
					<c:if test="${result.resultOpen == 1}">
				 		비공개
				 	</c:if>
				</td>
			</tr>
			<c:set var ="cnt" value = "${cnt -1}" />
			</c:forEach>
			</c:if>
		</table>
	<div class="row-fluid">
		<div class="span6 offset3"> <ui:pagination paginationInfo = "${paginationInfo}"   type="jnitDefault"   jsFunction="fn_egov_link_page"   /> </div>
		<form:hidden path="pageIndex" />
	</div>
     <c:if test = "${admin == 'true'}">
    </c:if>
</form:form>
</div>