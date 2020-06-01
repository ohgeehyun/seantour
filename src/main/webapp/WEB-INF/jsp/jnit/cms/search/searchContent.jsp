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
<%@ taglib prefix="jtag" uri="/jnittag"%>
<script type="text/javascript">
<!--
var ctxRoot = "${pageContext.request.contextPath }";

function fn_egov_link_page(pageNo){	
	var cntPath = "${contentPath}";	
	$("#mode").val("searchContent");
	$("#pageIndex").val(pageNo);
	
	if(cntPath == '' || cntPath == null){
		document.getElementById("listForm").action = "<c:url value='/total/search.do'/>";
	}else{
		document.getElementById("listForm").action = ctxRoot+cntPath;
	}	
	document.getElementById("listForm").submit();
}

function fn_egov_search(){	
	
	var searchOpt = $("#searchOpt option:selected").val();
	var contentPath = "${contentPath}";
	var mode = "";		
	if(searchOpt == '직원검색'){
		$("#mode").val("searchOrg");
		mode = "searchOrg";		
	}else if(searchOpt == '콘텐츠검색'){
		$("#mode").val("searchContent");
		mode = "searchContent";
	}else if(searchOpt == '게시판검색'){
		$("#mode").val("searchBoard");
		mode = "searchBoard";
	}else if(searchOpt == '통합검색'){
		$("#mode").val("search");
		mode = "search";
	}
	$("#pageIndex").val("1");
	if(contentPath == '' || contentPath == null){
		document.getElementById("listForm").action = "<c:url value='/total/search.do'/>";
	}else{
		document.getElementById("listForm").action = ctxRoot+contentPath;
	}
	document.getElementById("listForm").submit();
}

$(document).ready(function(){
	$("#searchBoxBtn").click(function(e){
		e.preventDefault();
		var searchOpt = $("#searchOpt option:selected").val();
		var contentPath = "${contentPath}";
		var mode = "";		
		if(searchOpt == '직원검색'){
			$("#mode").val("searchOrg");
			mode = "searchOrg";		
		}else if(searchOpt == '콘텐츠검색'){
			$("#mode").val("searchContent");
			mode = "searchContent";
		}else if(searchOpt == '게시판검색'){
			$("#mode").val("searchBoard");
			mode = "searchBoard";
		}else if(searchOpt == '통합검색'){
			$("#mode").val("search");
			mode = "search";
		}
		$("#pageIndex").val("1");
		if(contentPath == '' || contentPath == null){
			document.getElementById("listForm").action = "<c:url value='/total/search.do'/>";
		}else{
			document.getElementById("listForm").action = ctxRoot+contentPath;
		}
		document.getElementById("listForm").submit();		
	});
});

//-->
</script>
<form:form commandName="searchVO3" id="listForm" name="listForm" method="post">
<input type="hidden" id="mode" name="mode" value="${mode }" />

<div class="Jnit_search_box">
	<select name="searchOpt" id="searchOpt">
    	<option value="통합검색">통합검색</option>
        <c:if test="${limitmbrYn == 'Y' }"><option value="직원검색">직원검색</option></c:if>
        <c:if test="${limitCntYn == 'Y' }"><option value="콘텐츠검색" selected="selected">콘텐츠검색</option></c:if>
    	<c:if test="${limitBoardYn == 'Y' }"><option value="게시판검색">게시판검색</option></c:if>
    </select>
    <label for="searchKeyword" class="search_box_label">검색어 입력</label>
    <input type="text" class="search_box_input" id="searchKeyword" name="searchKeyword" onkeydown="if(event.keyCode == 13) fn_egov_search();" value="${searchKeyword }" />
    <button class="search_box_btn" id="searchBoxBtn">검색</button>
</div>
<%-- <p class="Jnit_search_result_txt"><strong>"${searchKeyword }"</strong>에 대한 검색결과입니다.<span>[검색결과 <strong><c:out value="${totCnt3 == '' || totCnt3 == null ? '0' : totCnt3 }" /></strong>건]</span></p> --%>

<h4 class="MAT30">콘텐츠검색<span class="Jnit_search_h4_in">[검색결과 <strong><c:out value="${totCnt3 == '' || totCnt3 == null ? '0' : totCnt3 }" /></strong>건]</span></h4><%-- <c:out value="${cntSize == '' || cntSize == null ? '0' : cntSize }" /> --%>
<c:if test="${empty cntList }">
	<p class="Jnit_no_search">검색 결과가 없습니다</p>
</c:if>
<c:if test="${!empty cntList }">
<ul class="Jnit_search_board">
	<c:forEach var="result" items="${cntList }" varStatus="status">							
	<li>
		<a href="<c:url value="${menuPathMap[result.cntId] }"/>" target="_blnk" title="새창" >
			<c:out value="${menuMap[result.cntId] }"/>
		</a>
		<span>				
			<c:if test="${DBType != 'ORACLE' && DBType != 'TIBERO'}">
				<c:out value="${fn:substring(jtag:removeHtmlTag(result.cntSrc),0,120) }" />
				<c:out value="${fn:length(jtag:removeHtmlTag(result.cntSrc)) >= 121 ? '...' : '' }" />				
			</c:if>
			<c:if test="${DBType == 'ORACLE' || DBType == 'TIBERO'}">
				<c:out value="${fn:substring(jtag:removeHtmlTag(cntMap[result.cntId]),0,120) }" />
				<c:out value="${fn:length(jtag:removeHtmlTag(cntMap[result.cntId])) >= 121 ? '...' : '' }" />				
			</c:if>
		</span>		
	</li>
	</c:forEach>
</ul>
</c:if>

<div id="page_navi" class="Jnit_search_pagenabi">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="jnitDefault"
				   jsFunction="fn_egov_link_page"
				   />
		<form:hidden path="pageIndex" id="pageIndex" />
</div>
</form:form>