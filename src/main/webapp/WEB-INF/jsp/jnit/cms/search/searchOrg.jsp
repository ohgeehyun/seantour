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
<script type="text/javascript">
<!--
var ctxRoot = "${pageContext.request.contextPath }";

function fn_org(org){
	var contentMove = "${contentPath}";	
	document.getElementById("org").value = org;
	
	if(contentMove == '' || contentMove == null){
		document.getElementById("searchVO2").action = "<c:url value='/total/search.do'/>?org="+org;
	}else{
		document.getElementById("searchVO2").action = ctxRoot+contentMove;
	}
	document.getElementById("searchVO2").submit();
}

function fn_egov_link_page(pageNo){	
	var contentPath = "${contentPath}";	
	var org = "${org}";		
	$('#pageIndex').val(pageNo);
	$("#mode").val("searchOrg");
	
	if(contentPath == '' || contentPath == null){
		document.getElementById("searchVO2").action = "<c:url value='/total/search.do' />";
	}else{
		document.getElementById("searchVO2").action = ctxRoot+contentPath+"?org="+org;
	}
	document.getElementById("searchVO2").submit();
}

function fn_egov_search(){			
	var mode = "${mode}";
	var searchCondition = $("#searchCondition option:selected").val();
	if(searchCondition != ''){
		if(searchCondition == '통합검색'){
			mode = "search";
			$("#mode").val("search");
		}else if(searchCondition == '게시판검색'){
			mode = "searchBoard";
			$("#mode").val("search");
		}else if(searchCondition == '콘텐츠검색'){
			mode = "searchContent";
			$("#mode").val("search");
		}
	}	
	var contentPath = "${contentPath}";	
	var org = $("#org").val();	
	$("#pageIndex").val("1");

	if(contentPath == '' || contentPath == null){
		document.getElementById("searchVO2").action = "<c:url value='/total/search.do'/>";
	}else{
		document.getElementById("searchVO2").action = ctxRoot+contentPath+"?org="+org;
	}
	document.getElementById("searchVO2").submit();
}

$(document).ready(function(){	
	var searchCondition = "${searchCondition}";
	if(searchCondition == '' || searchCondition == null ){
		searchCondition = 0;
	}	
	$('#searchCondition').val(searchCondition);
	
	$("#searchBoxBtn").click(function(e){
		e.preventDefault();		
		var mode = "${mode}";
		var searchCondition = $("#searchCondition option:selected").val();
		if(searchCondition != ''){
			if(searchCondition == '통합검색'){
				mode = "search";
				$("#mode").val("search");
			}else if(searchCondition == '게시판검색'){
				mode = "searchBoard";
				$("#mode").val("search");
			}else if(searchCondition == '콘텐츠검색'){
				mode = "searchContent";
				$("#mode").val("search");
			}
		}	
		var contentPath = "${contentPath}";	
		var org = $("#org").val();	
		$("#pageIndex").val("1");

		if(contentPath == '' || contentPath == null){
			document.getElementById("searchVO2").action = "<c:url value='/total/search.do'/>";
		}else{
			document.getElementById("searchVO2").action = ctxRoot+contentPath+"?org="+org;
		}
		document.getElementById("searchVO2").submit();
	});
});
	
//-->
</script>

<form:form commandName="searchVO2">
<input type="hidden" name="connectType" id="connectType" value="${connectType }" />
<input type="hidden" name="orgDeth" id="orgDeth" value="${orgDeth }" />
<input type="hidden" name="org" id="org" value="${org }"/>
<input type="hidden" name="typeUse" id="typeUse" value="${typeUse }"/>
<input type="hidden" name="listUse" id="listUse" value="${listUse }" />
<input type="hidden" name="mode" id="mode" value="${mode }" />


<c:if test="${listUse != 'false'}">

<div id="orgsearch" class="Jnit_search_box">
	<select id="searchCondition" name="searchCondition">
		<c:if test="${limitmbrYn == 'Y' }">		 
			<option value="8" selected="selected">직원검색</option>		
			<option value="5">성명</option>
			<option value="12">부서명</option>		
			<option value="6">담당업무</option>
			<option value="7">전화번호</option>
		</c:if>
		<option value="통합검색">통합검색</option> 
        <c:if test="${limitCntYn == 'Y' }"><option value="콘텐츠검색" selected="selected">콘텐츠검색</option></c:if>
    	<c:if test="${limitBoardYn == 'Y' }"><option value="게시판검색">게시판검색</option></c:if>
    </select>
    <label for="searchKeyword" class="search_box_label">검색어 입력</label>
    <input type="text" class="search_box_input" id="searchKeyword" name="searchKeyword" value="${searchKeyword }" onkeydown="if(event.keyCode == 13)  " />
    <button class="search_box_btn" id="searchBoxBtn">검색</button>
</div>

<%-- <p class="Jnit_search_result_txt"><strong>"${searchKeyword }"</strong>에 대한 검색결과입니다.<span>[검색결과 <strong><c:out value="${totCnt2 }" /></strong>건]</span></p> --%>
<h4 class="MAT30">직원검색<span class="search_h4_in">[검색결과 <strong><c:out value="${totCnt2 == '' || totCnt2 == null ? 0 : totCnt2 }" /></strong>건]</span></h4> <%-- <c:out value="${orgSize == '' || orgSize == null ? 0 : orgSize }" /> --%>
<table cellpadding="0" cellspacing="0" border="0" summary="직원 검색 테이블로 부서명, 직급, 성명, 전화번호 등의 정보를 제공합니다." class="Jnit_search_table MAB0" width="100%">
	<caption>직원 검색 테이블</caption>
    <thead>
    	<tr>
        	<th width="25%">부서명</th>        	
        	<th width="25%">성명</th>
        	<th width="25%">담당업무</th>
        	<th width="25%">전화번호</th>    	
        </tr>
    </thead>
    <tbody>
    	<c:if test="${!empty orgList }">
	    	<c:forEach var="result" items="${orgList }" varStatus="status">
	    	<tr>        	
	        	<td><c:out value="${result.orgNm }"/></td>			
				<td><c:out value="${result.mbrNm }"/></td>
				<td><c:out value="${result.workContents }" /></td>	       
				<td><c:out value="${result.tel }"/></td>
	        </tr>
	    	</c:forEach>
    	</c:if>   	
    </tbody>
</table>

<div id="page_navi" class="Jnit_search_pagenabi">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="jnitDefault"
				   jsFunction="fn_egov_link_page"
				   />				   
		<form:hidden path="pageIndex" id="pageIndex" />		
</div>
</c:if>
</form:form>