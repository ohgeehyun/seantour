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
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<%@ page import = "com.ibm.icu.text.SimpleDateFormat, com.ibm.icu.util.Calendar" %>
<%
	SimpleDateFormat yearFormat = new SimpleDateFormat("YYYY");
	String thisYear = yearFormat.format(Calendar.getInstance().getTime());
%>
<c:set var="thisYear" value="<%=thisYear%>"></c:set>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

$(document).ready(function(){
	
	var sYear = "${resultDate['sYear']}";
	var sDate = "${resultDate['sDate']}";
	
	$("#sYear").val(sYear);
	$("#sDate").val(sDate);
	
	$("[name='smsSearch']").on("click", function(){
		
		var sYear = $.trim($("#sYear").val());
		var sDate = $.trim($("#sDate").val());
		
		if(sYear == ''){
			alert("년도를 선택해주세요.");
			$("#sYear").focus();
			return false;
		}else if(sDate == ''){
			alert("월을 선택해주세요.");
			$("#sDate").focus();
			return false;
		}
		
	});
});

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/lms/list.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		    <input type="hidden" name="screenMode" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>LMS 테이블 ( <strong>${resultDate['sYear']}년 ${resultDate['sDate']}월 내역</strong> )</h3>
	                    </div>
	                    <div class="widget-title">
	                       	<select id="sYear" name="sYear">
	                       		<option value=" " selected="selected">년도 선택</option>
	                       		<c:forEach var="year" begin="2014" end="${thisYear}" varStatus="status">
	                       			<option value="${year}">${year}년</option>
	                       		</c:forEach>
	                       	</select>
	                       	<select id="sDate" name="sDate">
	                       		<option value=" " selected="selected">월 선택</option>
	                       		<c:forEach var="date" begin="01" end="12" varStatus="status">
	                       			<option value="${date < 10 ? 0 : ''}${date}">${date}월</option>
	                       		</c:forEach>
	                       	</select>
	                       	<button class="btn btn-small" id="smsSearch" name="smsSearch">검색하기</button>
                       		<h3 style="float: right;">
                       			총갯수 : ${resultState['total']} / 
                       			성공 : ${resultState['success']} / 
                       			실패 : ${resultState['failed']}
                       		</h3>
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover" summary="LMS 리스트">
								<thead>
									<tr>
										<th>순번</th>
										<th>보낸 번호(From)</th>
										<th>받는 번호(To)</th>
										<th>메세지 내용</th>
										<th>보낸시각</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(resultList) < 1}">
										<td colspan="5" style="text-align: center;"><strong style="color: black;">해당 데이터가 존재하지 않습니다.</strong></td>
									</c:if>
									<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td><c:out value="${result.msgSeq}"/></td>
										<td><c:out value="${result.callFrom}"/></td>
										<td><c:out value="${result.callTo}"/></td>
										<td><c:out value="${fn:substring(result.smsTxt, 0, 30)} ..."/></td>
										<td><fmt:formatDate value="${result.reqDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<c:if test="${result.rsltCode2 != '0'}">
											<td><strong style="color: red;">전송실패</strong></td>
										</c:if>
										<c:if test="${result.rsltCode2 == '0'}">
											<td><strong style="color: blue;">전송성공</strong></td>
										</c:if>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div id="page_navi" class="pagination">
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="fn_egov_link_page"
							   />
					<form:hidden path="pageIndex" />
			</div>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>