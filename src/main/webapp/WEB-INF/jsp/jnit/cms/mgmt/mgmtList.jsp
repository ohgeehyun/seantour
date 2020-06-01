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
<% String mgmtType = request.getParameter("mgmtType"); %>
<c:set var="mgmtType" value="<%=mgmtType%>" />
<script type="text/javascript">
<!--
/* 글 수정 화면 function */
function fn_egov_select(mgmtId) {	
   	$("#mgmtId").val(mgmtId);   	
   	$("#screenMode").val("up");   	
   	$.ajax({
   		type:"post",
   		url:"<c:url value='/cms/mgmt/edit.do'/>?mgmtType=${mgmtType}",
   		data:$("#listForm").serialize()   		
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

function Jnit_itemList(){	
	location.href = "<c:url value='/cms/mgmt/item/list.do'/>";
}

function Jnit_sortList(mgmtType){
	location.href = "<c:url value='/cms/config/mgmt/file/list.do'/>?mgmtType="+mgmtType;
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
						<a href="javascript:fn_egov_addView();" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
						<!--
						'사이트생성시'에 적용 되는 순서입니다. 필요하실 경우 주석을 풀고 사용해 주세요. 
						<c:if test="${loginVO.typeVO.typeLv == 'A' }">
							<a href="javascript:Jnit_itemList();" class="btn btn-warning btn-small" style="float: right; margin-right: 10px;"><i class="icon-exclamation-sign"></i> 표시설정</a>
							<a href="javascript:Jnit_sortList('${mgmtType }');" class="btn btn-info btn-small" style="float: right; margin-right: 10px;"><i class="icon-exclamation-sign"></i> 순서설정</a>
						</c:if>
						 -->
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">			  
							<tr>								
								<th style="width: 72%">파일이름</th>
								<th>순서</th>								
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
										<c:out value="${result.mgmtNm}.${mgmtType }"/>
									</a>
								</td>
								<td style="text-align: center;"><c:out value="${result.mgmtSort }"/></td>
								<td style="text-align: center;">
									<c:out value="${result.mgmtHearderYn == 0 ? '비활성' : '활성'  }" />
								</td>
				   			</tr>
							</c:forEach>	
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
		<div class="row-fluid">
			<div class="widget-box">
				<div class="widget-content nopadding cmstipbox">
					<table class="table table-bordered table-striped th_left">
					<caption>cms TIP</caption>
					<tbody>
					<tr>
						<th colspan="2">
							<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
						</th>
						<td>
							<c:if test="${mgmtType == 'css'}">
								<b>서브템플릿의 {-CONFIG_CSS-}에 적용되어 나타납니다.</b>
							</c:if>
							<c:if test="${mgmtType == 'js'}">
								<b>서브템플릿의 {-CONFIG_JS-}에 적용되어 나타납니다.</b>
							</c:if>
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
