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
<div class="view">
		<table border="0" cellspacing="0" cellpadding="0" class="table content2_table" summary="통계 리스트">
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
