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
function fn_egov_boardmore(){	
	var boardPath = "${contentPath}";	
	$("#mode").val("searchBoard");
	
	if(boardPath == '' || boardPath == null){
		document.getElementById("listForm").action = "<c:url value='/total/search.do'/>";
	}else{
		document.getElementById("listForm").action = ctxRoot+boardPath;
	}
	document.getElementById("listForm").submit();
}

function fn_egov_orgmore(){	
	var orgPath = "${contentPath}";	
	$("#mode").val("searchOrg");
	
	if(orgPath == '' || orgPath == null){
		document.getElementById("listForm").action = "<c:url value='/total/search.do'/>?listUse=true";
	}else{
		document.getElementById("listForm").action = ctxRoot+orgPath+"?listUse=true";
	}
	document.getElementById("listForm").submit();
}

function fn_egov_contentmore(){
	var cntPath = "${contentPath}";	
	$("#mode").val("searchContent");
	
	if(cntPath == '' || cntPath == null){
		document.getElementById("listForm").action = "<c:url value='/total/search.do' />";	
	}else{
		document.getElementById("listForm").action = ctxRoot+cntPath;
	}
	document.getElementById("listForm").submit();
}

function fn_egov_search(){	
	
	var searchOpt = $("#searchOpt option:selected").val();
	var contentPath = "${contentPath}";	
	
	if(searchOpt == '직원검색'){
		$("#mode").val("searchOrg");
	}else if(searchOpt == '콘텐츠검색'){
		$("#mode").val("searchContent");
	}else if(searchOpt == '게시판검색'){
		$("#mode").val("searchBoard");	
	}else if(searchOpt == '통합검색'){
		$("#mode").val("search");
	}
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
		
		if(searchOpt == '직원검색'){
			$("#mode").val("searchOrg");				
		}else if(searchOpt == '콘텐츠검색'){
			$("#mode").val("searchContent");	
		}else if(searchOpt == '게시판검색'){
			$("#mode").val("searchBoard");
		}else if(searchOpt == '통합검색'){
			$("#mode").val("search");
		}	
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
<form id="listForm" name="listForm" action="?" method="post">
	<input type="hidden" id="mode" name="mode" value="${mode }" />
	
	<c:set var="totCnt" value="${totCnt == '' || totCnt == null ? 0 : totCnt }" />
	<c:set var="totCnt2" value="${totCnt2 == '' || totCnt2 == null ? 0 : totCnt2 }" />
	<c:set var="totCnt3" value="${totCnt3 == '' || totCnt3 == null ? 0 : totCnt3 }" />
	
	<div class="Jnit_search_box">
		<select name="searchOpt" id="searchOpt">
	    	<option value="통합검색" selected="selected">통합검색</option>
	        <c:if test="${limitmbrYn == 'Y' }"><option value="직원검색">직원검색</option></c:if>
	        <c:if test="${limitCntYn == 'Y' }"><option value="콘텐츠검색">콘텐츠검색</option></c:if>
	    	<c:if test="${limitBoardYn == 'Y' }"><option value="게시판검색">게시판검색</option></c:if>
	    </select>
	    <label for="searchKeyword" class="search_box_label">검색어 입력</label>
	    <input type="text" class="search_box_input" id="searchKeyword" name="searchKeyword" onkeydown="if(event.keyCode == 13) fn_egov_search();" value="${searchKeyword }" />
	    <button class="search_box_btn" id="searchBoxBtn">검색</button>
	</div>
	<p class="Jnit_search_result_txt"><strong>"${searchKeyword }"</strong>에 대한 검색결과입니다.<span>[검색결과 <strong><c:out value="${totCnt + totCnt2 + totCnt3  }" /></strong>건]</span></p>
	
	<c:if test="${limitmbrYn == 'Y' }">
		<!-- 직원검색 -->
		<h4 class="MAT30">직원검색<span class="Jnit_search_h4_in">[검색결과 <strong><c:out value="${totCnt2}" /></strong>건]</span></h4>
		<c:if test="${empty mbrList }">	
			<p class="Jnit_no_search">검색 결과가 없습니다</p>
		</c:if>
		<c:if test="${!empty mbrList }">
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
		    	<c:forEach var="result" items="${mbrList }" varStatus="status">							
				<tr>
					<td><c:out value="${result.orgNm }"/></td>			
					<td><c:out value="${result.mbrNm }"/></td>
					<td><c:out value="${result.workContents }" /></td>	       
					<td><c:out value="${result.tel }"/></td>
				</tr>
				</c:forEach>    	
		    </tbody>
		</table>
		</c:if>
		<p class="Jnit_search_more"><a href="javascript:fn_egov_orgmore();">직원검색 더보기</a></p>
	</c:if>
	
	<c:if test="${limitCntYn == 'Y' }">
		<!-- 콘텐츠검색 -->
		<h4 class="MAT30">콘텐츠검색<span class="search_h4_in">[검색결과 <strong><c:out value="${totCnt3 }" /></strong>건]</span></h4>
		<c:if test="${empty cntList }">
			<p class="Jnit_no_search">검색 결과가 없습니다</p>
		</c:if>
		<c:if test="${!empty cntList }">
		<ul class="Jnit_search_content">
			<c:forEach var="result" items="${cntList }" varStatus="status">							
			<li>		
				<a href="<c:url value="${menuPathMap[result.cntId] }"/>" target="_blnk" title="새창" ><c:out value="${menuMap[result.cntId] }"/></a>
				<span>
					<c:if test="${DBType != 'ORACLE' && DBType != 'TIBERO' }">
						${fn:substring(jtag:removeHtmlTag(result.cntSrc),0,120) }
						${fn:length(jtag:removeHtmlTag(result.cntSrc)) >= 121 ? '...' : '' }						
					</c:if>
					<c:if test="${DBType == 'ORACLE' || DBType == 'TIBERO' }">
						${fn:substring(jtag:removeHtmlTag(cntMap[result.cntId]),0,120) }
						${fn:length(jtag:removeHtmlTag(cntMap[result.cntId])) >= 121 ? '...' : '' }						
					</c:if>			
				</span>
			</li>
			</c:forEach>
		</ul>
		</c:if>
		<p class="Jnit_search_more"><a href="javascript:fn_egov_contentmore();">콘텐츠검색 더보기</a></p>
	</c:if>
	
	<c:if test="${limitBoardYn == 'Y' }">
		<!-- 게시판검색 -->
		<h4 class="MAT30">게시판검색<span class="search_h4_in">[검색결과 <strong><c:out value="${totCnt }" /></strong>건]</span></h4>
		<c:if test="${empty boardList }">
			<p class="Jnit_no_search">검색 결과가 없습니다</p>
		</c:if>
		<c:if test="${!empty boardList }">
		<ul class="Jnit_search_board">
			<c:forEach var="result" items="${boardList}" varStatus="status">	
			<li>
				<%-- <a href="<c:url value="${result.writer }"/>" target="_blank" title="새창" ><c:out value="${result.title }" /></a> --%>				
				<c:if test="${empty boardWriterMap[result.tmp1]}" >
					<c:set var="boardWriter" value="${result.writer }"/>
				</c:if>
				<c:if test="${!empty boardWriterMap[result.tmp1]}" >
					<c:set var="boardWriter" value="${boardWriterMap[result.tmp1] }?${fn:split(result.writer,'?')[1] }"/>
				</c:if>
				<%--
					<c:set var="boardWriter" value="${ !empty boardWriterMap[result.tmp1] ?  boardWriterMap[result.tmp1] : result.writer }"/>
				 --%>
				<a href="<c:url value="${boardWriter }"/>" target="_blank" title="새창" >[${boardTitleMap[result.tmp1] }]<c:out value="${result.title }" /></a>
				<span>
					<c:if test="${DBType != 'ORACLE' && DBType != 'TIBERO' }">
						${fn:substring(jtag:removeHtmlTag(result.content),0,120) }
						${fn:length(jtag:removeHtmlTag(result.content)) >= 121 ? '...' : '' }
					</c:if>
					<c:if test="${DBType == 'ORACLE' || DBType == 'TIBERO'}">
						${fn:substring(jtag:removeHtmlTag(contentMap[result.id]),0,120) }
						${fn:length(jtag:removeHtmlTag(contentMap[result.id])) >= 121 ? '...' : '' }
					</c:if>
				</span>
			</li>
			</c:forEach>
		</ul>
		</c:if>
		<p class="Jnit_search_more"><a href="javascript:fn_egov_boardmore();">게시판검색 더보기</a></p>
	</c:if>
</form>