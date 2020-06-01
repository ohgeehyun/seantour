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
<%

  response.setHeader("Content-Type", "application/vnd.ms-xls; charset=euc-kr");

  response.setHeader("Content-Disposition", "inline; filename=statsfile.xls");

%>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post" action="?">
						<table class="table table-boerded table-striped table-hover" summary="통계리스트" style="margin-top:20px;">
							<thead>	  
							<tr>
												<th align="center">브라우저</th>
												<!-- <th align="center">순 방문자</th> -->
												<th align="center">방문수</th>
											
							</tr>
							</thead>
							<c:forEach var="result" items="${list}" varStatus="status">
							<tr>
									
										<td align="center" class="listtd"><c:out value="${result[0]}"/></td>
										
										<%-- <td align="center" class="listtd"><c:out value="${result[1]}"/></td> --%>
										<td align="center" class="listtd"><c:out value="${result[2]}"/></td>
							</tr>
							</c:forEach>
						</table>
</form:form>