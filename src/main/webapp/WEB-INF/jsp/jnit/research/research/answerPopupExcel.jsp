<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
	<title>JNITCMS</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
</head>

<body class="skeleton">

<%

  response.setHeader("Content-Type", "application/vnd.ms-xls");

  response.setHeader("Content-Disposition", "inline; filename=researchAnswer.xls");

%>
		
		<table class="bbsView table table-bordered" width="100%" border="0" cellpadding="0" cellspacing="0">
			
			<tr>
				<th align="center">답변</th>
			</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${result.answer != '' && result.answer != null}">
				<tr>		
					<td align="center" class="listtd">
						<c:if test="${mode != 'order' }"><c:out value="${result.answer}"/></c:if>
						<c:if test="${mode == 'order' }"><c:out value="${result.orderAnswer}"/></c:if>
					</td>
				</tr>
			</c:if>
			</c:forEach>
		</table>
</body>
</html>