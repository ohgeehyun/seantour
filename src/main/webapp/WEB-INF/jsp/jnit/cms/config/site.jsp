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
function Jnit_choice(sitePath){
	$("#redirectPath").val("/" + sitePath);
	$('#myModal').modal('toggle');
}

function fn_egov_link_page(pageNo){	
   	$.ajax({
   		type:"post",
   		url:"<c:url value='/cms/config/ajax/site.do'/>",
   		data : "pageIndex="+pageNo
   	}).done(function(data){
   		$("#modelHtml").empty();
   		$("#modelHtml").append(data);
   	});
}
//-->
</script>
<form:form commandName="searchVO">
<div class="row-fluid">
	<div class="span12">
		<div class="widget-box">
			<div class="widget-title">
				<h3>사이트 테이블</h3>
			</div>
			<div class="widget-content nopadding">
				<table class="table table-bordered">
					<tr>	
						<th>사이트이름</th>
						<th>사이트경로</th>
						<th>선택</th>
					</tr>
					<c:forEach var="result" items="${resultList }" varStatus="status">
						<tr>
							<td><c:out value="${result.siteNm }"/></td>
							<td><c:out value="${result.sitePath }"/></td>
							<td><a href="javascript:Jnit_choice('${result.sitePath }');" class="btn btn-small">선택</a></td>
						</tr>
					</c:forEach>
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