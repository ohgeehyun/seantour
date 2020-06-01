<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<link href="<c:url value='/css/egovframework/com/com.css' />" rel="stylesheet"  type="text/css">
<link href="<c:url value='/css/egovframework/com/button.css' />" rel="stylesheet"  type="text/css">
<title>설문조사 답변리스트</title>
<script src="<c:url value="/js/research/jquery.min.js"/> "></script>
<script src="<c:url value="/js/research/jquery.ui.latest.custom.min.js"/> "></script>
<script src="<c:url value="/js/research/jquery.ui.datepicker-ko.js" /> "></script>
<script src="<c:url value="/js/research/jquery.ui.timepicker.addon.js" /> "></script>
<script type="text/javascript">
function fn_egov_link_page(pageNo){
	e.preventDefault();
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/targetList/popup.do'/>";
   	document.getElementById("listForm").submit();
}
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="get">
<div id="content_pop">
	<input type="hidden" id="researchId" name="researchId" value="${researchId}"/>
		<table class="bbsView table table-bordered" width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
				<col/>			
			</colgroup>		  
			<tr>
				<th align="center">대상 부서</th>
			</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>		
					<td align="center" class="listtd">
						<%--
						<c:out value="${result.orgnztNm}"/>
						&nbsp;|&nbsp;
						 --%> 
						<c:out value="${result.displayname}"/>
					</td>
				</tr>
			</c:forEach>
		</table>
</div>
</form:form>
</body>
</html>
