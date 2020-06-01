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
<%@ page import="java.util.Date" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<style>

span.accReady {
	color:orange;
}
span.accActive {
	color:green;
}
span.accEnd {
	color:red;
}

</style>


<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */
<%--
function fn_egov_detail(researchId) {
    document.getElementById("listForm").researchId.value = researchId;
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitresearch/detailJnitresearchView.do'/>";
   	document.getElementById("listForm").submit();
}
--%>
function fn_egov_select(researchId) {
    document.getElementById("listForm").researchId.value = researchId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/research/Edit.do'/>";
   	document.getElementById("listForm").submit();
}
$(document).ready(function(){
	$("[id*='stats']").click(function(e){
		
		e.preventDefault();
		var researchId = $(this).val();
		
	    document.getElementById("listForm").researchId.value = researchId;
		document.getElementById("listForm").screenMode.value = "";
	   	document.getElementById("listForm").action = "<c:url value='/cms/research/stats.do'/>";
	   	document.getElementById("listForm").submit();
	});
});
$(document).ready(function(){
	$("[id*='select']").click(function(e){
		
		e.preventDefault();
		var researchId = $(this).val();
		document.getElementById("listForm").researchId.value = researchId;
		document.getElementById("listForm").screenMode.value = "up";
	   	document.getElementById("listForm").action = "<c:url value='/cms/research/Edit.do'/>";
	   	document.getElementById("listForm").submit();
	});
});
$(document).ready(function(){
	$("[id*='view']").click(function(e){
		e.preventDefault();
		var researchId = $(this).val();
		var winUrl = "<c:url value='/research/PreResearch.do?researchId="+researchId+"'/>";
		var winZip = window.open(winUrl,"windowZip","width=800,height=600,top=0,left=0,scrollbars = yes");
		winZip.focus();
	});
});
$(document).ready(function(){ 
    $('#searchReset').click(function(){ 
            $('#pageIndex').val(1); 
    }); 
}); 
/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/research/add.do'/>";
   	document.getElementById("listForm").submit();		
}

/* 글 자동 등록 템플릿*/
function fn_egov_addtpl() {
	var winUrl = "<c:url value='/cms/research/addtpl.do'/>";
	var winZip = window.open(winUrl,"설문조사템플릿","width=1500,height=1000,top=0,left=0,scrollbars=yes");
	winZip.focus();
}

/* pagination 페이지 링크 function */
function fnLinkPage(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/research/List.do'/>";
   	document.getElementById("listForm").submit();
}
/* function target_list(researchId){
	var winUrl = "<c:url value='/targetList/popup.do?researchId="+researchId+"'/>";
	var winZip = window.open(winUrl,"targetList","width=500,height=400,top=0,left=0,scrollbars = yes");
	winZip.focus();
} */
 // -->
</script>

	<div id="content">
		<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
		<div class="content_view container-fluid">		
			<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
			    <input type="hidden" name="screenMode" />
			    <input type="hidden" name="researchId" />
			    <input type="hidden" name="searchCondition" value="1" />
			    <div class="row-fluid">
					<div class="span12">
						<div class="widget-box">
							<div class="widget-title">					
								<h3>설문조사</h3>
								<c:if test="${isAdmin == ture}">
									<a href="javascript:fn_egov_addView();" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
									<a href="javascript:fn_egov_addtpl();" class="btn btn-small"><i class="icon-plus-sign"></i> 템플릿 등록</a>
								</c:if>
								<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
								<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>	
							</div>
							<div class="widget-content nopadding">
								<c:set var ="today" value = "<%=new Date()%>" />
								<table class="table table-bordered table-striped table-hover">
									<thead>							  
									<tr>
										<th align="center">설문조사ID</th>
										<th align="center">설문명</th>
										<th align="center">설문시작~설문종료</th>
										<!-- <th align="center">대상</th> -->
										<th align="center">참여인원</th>
										<th align="center">결과공개</th>
										<th align="center">등록일</th>
										<th align="center">수정일</th>
										<th align="center">미리보기</th>
										<th align="center">통계</th>
										<c:if test="${isAdmin == ture}">
											<th align="center">관리</th>
										</c:if>
									</tr>
									</thead>
									<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td align="center" class="listtd"><c:out value="${result.researchId}"/></td>
											<td align="center" class="listtd">
												<a href="javascript:fn_egov_select('<c:out value="${result.researchId}"/>')"><c:out value="${result.researchNm}"/></a><br />
												<c:if test="${result.state == 1}"><span class="accEnd">임시저장</span></c:if>
											</td>
											<td align="center" class="listtd">
												<fmt:formatDate value="${result.starttime}" pattern="yyyy년MM월dd일 HH시"/>~<fmt:formatDate value="${result.endtime}" pattern="yyyy년MM월dd일 HH시"/><br />											
												<c:if test = "${today < result.starttime}"><span class="accReady">설문접수이전</span></c:if>
												<c:if test = "${(today > result.starttime) && (result.endtime > today)}"><span class="accActive">설문가능</span></c:if>
												<c:if test = "${result.endtime < today}"><span class="accEnd">설문기간만료</span></c:if>
											</td>
											<%-- <td align="center" class="listtd">
											<c:if test="${result.researchTarget == '' || result.researchTarget == null || fn:contains(result.researchTarget, '1750000')}">전체</c:if>
											<c:if test="${result.researchTarget != '' && result.researchTarget != null &&!fn:contains(result.researchTarget, '1750000')}">
												<a href="javascript:target_list('${result.researchId}');" class="btn">대상 보기</a>
											</c:if>
											</td> --%>
											<td align="center" class="listtd"><c:out value="${result.entry}"/>&nbsp;</td>
											<td align="center" class="listtd">
												<c:if test = "${result.resultOpen == 0}">공개</c:if>
												<c:if test = "${result.resultOpen == 1}"><span class="accEnd">비공개</span></c:if>
											</td>
											<td align="center" class="listtd"><fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd HH:mm"/></td>
											<td align="center" class="listtd"><fmt:formatDate value="${result.modified}" pattern="yyyy-MM-dd HH:mm"/></td>
											<td align="center" class="listtd">
												<button class="btn btn-small" id="view" value="<c:out value="${result.researchId}"/>">미리보기</button>
											</td>
											<td align="center" class="listtd">
												<button class="btn btn-small" id="stats" value="<c:out value="${result.researchId}"/>">보기</button>
											</td>
											<c:if test="${isAdmin == ture}">
												<td align="center" class="listtd">
													<button class="btn btn-small" id="select" value="<c:out value="${result.researchId}"/>">수정</button>
												</td>
											</c:if>
										</tr>
									</c:forEach>
									</tbody>
								</table>						
							</div>
						</div>
					</div>
				</div>
				 <!--  page start -->
                <div id="page_navi" class="pagination">
                	<c:if test="${paginationInfo.totalPageCount <= 9}"><li class="first">&nbsp;</li><li class="pre">&nbsp;</li></c:if>
		                <ui:pagination paginationInfo = "${paginationInfo}"
		                    type="jnitDefault"
		                    jsFunction="fnLinkPage"
		                    />
					<c:if test="${paginationInfo.totalPageCount <= 9}"><li class="next">&nbsp;</li><li class="last">&nbsp;</li></c:if>
                	<form:hidden path="pageIndex" />
                </div>
        <!--  page end -->
			</form:form>
		</div>
	</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
