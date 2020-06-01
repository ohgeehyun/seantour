<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">

$(document).ready(function(){

	$('#rsvStartKeyword').datepicker();
	$('#rsvEndKeyword').datepicker();

	
});

function goExcel(pageNo){
	document.getElementById("listForm").excel.value = "excel";
	document.getElementById("listForm").action = "?";
   	document.getElementById("listForm").submit();
   	document.getElementById("listForm").excel.value = "";
}

</script>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post" action="?">
<input type="hidden" name="excel" />
<input type="hidden" name="mode" value="pageview"/>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-th"></i></span>
						<h3>기본테이블</h3>
						<input type ="button" value = "엑셀 다운로드" onclick="goExcel();" class="btn btn-small"/>
						<%--
						<select id="searchSite" name="searchSite">
								<option value=" ">  - 전체사이트 -  </option>
								<c:forEach var="site" items="${resultSiteList}" varStatus="status">
									<option value="${site.sitePath}">${site.siteNm}</option>
								</c:forEach>
						</select>
						 --%>
		 시작일:<input type="text" name="rsvStartKeyword" size="10" id="rsvStartKeyword" value="${rsvStartKeyword}"/>
		 ~<input type="text" name="rsvEndKeyword" size="10" id="rsvEndKeyword" value="${rsvEndKeyword}"/>
		 <button class="btn btn-small">검색</button>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-boerded table-striped table-hover" summary="통계리스트" style="margin-top:20px;">
							<thead>	  
							<tr>
												<th align="center">사이트 경로</th>
												<!-- <th align="center">순 방문자</th> -->
												<th align="center">방문수</th>
												<th align="center">페이지뷰</th>
											
							</tr>
							</thead>
							<c:forEach var="result" items="${list}" varStatus="status">
							<tr>
									
										<td align="center" class="listtd"><c:out value="${result[0]}"/>(${site[result[0]]})</td>
										<%-- <td align="center" class="listtd"><c:out value="${result[1]}"/></td> --%>
										<td align="center" class="listtd"><c:out value="${result[2]}"/></td>
										<td align="center" class="listtd"><c:out value="${result[3]}"/></td>
							</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
		<%-- Contents End --%>
	</div>
</div>
</form:form>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
