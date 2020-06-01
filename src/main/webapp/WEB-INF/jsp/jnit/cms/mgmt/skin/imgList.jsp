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
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>



<script type="text/javascript">
<!--
/* 글 수정 화면 function */
function fn_egov_select(mgmtId) {   	
   	$("#mgmtId").val(mgmtId);
   	$("#screenMode").val("up");
   	$.ajax({
   		type:"get",
   		url:"<c:url value='/cms/mgmt/edit.do'/>?mgmtType=${mgmtType}",
   		data:$("#listForm").serialize(),   		
   	}).done(function(data){
   		$("#editView").empty();
   		$("#editView").append(data);
   	});
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	$("#mgmtId").val('');
   	$("#screenMode").val("");
   	$.ajax({
   		type:"post",
   		url:"<c:url value='/cms/mgmt/add.do'/>?mgmtType=${mgmtType}",
   		data:$("#listForm").serialize(),   		
   	}).done(function(data){   		
   		$("#editView").empty();
   		$("#editView").append(data);
   	});
}


$(document).ready(function(){
	//수정셋팅
	var mgmtId = "${mgmtId}";
	if(mgmtId != ''){
		$("#mgmtId").val(mgmtId);
	   	$("#screenMode").val("up");
	   	$.ajax({
	   		type:"get",
	   		url:"<c:url value='/cms/mgmt/edit.do'/>?mgmtType=${mgmtType}",
	   		data:$("#listForm").serialize(),   		
	   	}).done(function(data){	   		
	   		$("#editView").empty();
	   		$("#editView").append(data);	   		
	   	});	
	}	
});

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/mgmt/list.do'/>?mgmtType=${mgmtType}";
   	document.getElementById("listForm").submit();
}


 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	    <input type="hidden" name="screenMode" id="screenMode" />
		<input type="hidden" name="mgmtId" id="mgmtId" />
		
		<div class="row-fluid">
			<div class="span4">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:fn_egov_addView();" class="btn btn-small">추가</a>
					</div>
					<div class="widget-content nopadding">
					
						<%-- <table class="table table-bordered">			  
							<tr>
								<th style="width: 83%">파일이름</th>
								<th>사용여부</th>		
							</tr>
							<c:if test="${empty resultList }">
							<tr>
								<td colspan="2">파일이 없습니다.</td>
							</tr>
							</c:if>							
							<c:if test="${!empty resultList }">
							<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td>
									<a href="javascript:fn_egov_select('<c:out value="${result.mgmtId}"/>')">
										<c:out value="${result.mgmtNm}"/>
									</a>
								</td>
								<td>
									<c:out value="${result.mgmtHearderYn == 0 ? '비활성' : '활성'  }" />
								</td>
				   			</tr>
							</c:forEach>	
							</c:if>
						</table> --%>
						
						<%-- 이미지보기 --%>						
						<table class="table table-bordered"> 			  
							<tr>
								<th>파일이름</th>										
							</tr>
							<c:if test="${empty resultList }">
							<tr>
								<td colspan="2">파일이 없습니다.</td>
							</tr>
							</c:if>							
							<c:if test="${!empty resultList }">
							<tr>
								<td>
									<c:forEach var="result" items="${resultList}" varStatus="status">										
										<a href="javascript:fn_egov_select('<c:out value="${result.mgmtId}"/>')">											
											<img alt="이미지${status.count }" src="<c:url value="${result.mgmtFileUrl }"/>" style="width: 30%;height: 100px;">																						
										</a>
										<c:if test="${status.count%3 == 0}"><br/></c:if>
									</c:forEach>
								</td>								
							<tr>		
							</c:if>
						</table>
					</div>	
				</div>
				<div id="page_navi" class="pagination">
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="fn_egov_link_page"
							   />
					<form:hidden path="pageIndex" />
				</div>
			</div>
			<div class="span8">
				<div id="editView">
					
				</div>
				
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
