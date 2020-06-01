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
<%

  response.setHeader("Content-Type", "application/vnd.ms-xls");

  response.setHeader("Content-Disposition", "inline; filename=page.xls");

%>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<table border="1">			
		<thead>	  
		<tr>
			<th><c:out value="1뎁스"/></th>
			<th><c:out value="2뎁스"/></th>
			<th><c:out value="3뎁스"/></th>
			<th><c:out value="4뎁스"/></th>
			<th><c:out value="5뎁스"/></th>
			<th><c:out value="6뎁스"/></th>
			<th><c:out value="7뎁스"/></th>
			
			<th><c:out value="페이지제목"/></th>
			<th><c:out value="URL"/></th>
			<th><c:out value="등록날자"/></th>	
			<th><c:out value="매무불만족"/></th>
			<th><c:out value="불만족"/></th>
			<th><c:out value="보통"/></th>
			<th><c:out value="만족"/></th>
			<th><c:out value="매우만족"/></th>
			<th><c:out value="작성자"/></th>
			<th><c:out value="내용"/></th>
			<th><c:out value="작성자평가"/></th>
		</tr>
		</thead>
		<tbody>
	
		<c:if test="${empty resultList }">
		<tr>
			<td nowrap>-</td>
			<td nowrap>-</td>	
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>
			
			<td nowrap>-</td>
			<td nowrap>-</td>
			<td nowrap>-</td>			
		</tr>
		</c:if>
		
		<c:if test="${!empty resultList }" >
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><c:out value="${dethMap1[result.rscpId] }"/></td>
			<td nowrap><c:out value="${dethMap2[result.rscpId] }"/></td>	
			<td nowrap><c:out value="${dethMap3[result.rscpId] }"/></td>
			<td nowrap><c:out value="${dethMap4[result.rscpId] }"/></td>
			<td nowrap><c:out value="${dethMap5[result.rscpId] }"/></td>
			<td nowrap><c:out value="${dethMap6[result.rscpId] }"/></td>
			<td nowrap><c:out value="${dethMap7[result.rscpId] }"/></td>
			
			<td nowrap><c:out value="${result.menuNm }"/></td>
			<td nowrap><c:out value="${result.pageUrl }"/></td>
			<td nowrap><fmt:formatDate value="${result.created }" pattern="yyyy-MM-dd"/></td>
			<td nowrap><c:out value="${result.hit1 }"/></td>
			<td nowrap><c:out value="${result.hit2 }"/></td>
			<td nowrap><c:out value="${result.hit3 }"/></td>
			<td nowrap><c:out value="${result.hit4 }"/></td>
			<td nowrap><c:out value="${result.hit5 }"/></td>
			
			<td nowrap>
				<c:if test="${result.remoteAddr == '비회원' }"><c:out value="${result.remoteAddr }"/></c:if>
				<c:if test="${result.remoteAddr != '비회원' }"><c:out value="${result.mbrNm }(${result.remoteAddr })"/></c:if>
			</td>
			<td nowrap><c:out value="${result.memo }"/></td>
			<td nowrap>
				<c:if test="${result.datahit1 == 1 }"><c:out value="매우 불만족"/></c:if>
				<c:if test="${result.datahit2 == 1 }"><c:out value="불만족"/></c:if>
				<c:if test="${result.datahit3 == 1 }"><c:out value="보통"/></c:if>
				<c:if test="${result.datahit4 == 1 }"><c:out value="만족"/></c:if>
				<c:if test="${result.datahit5 == 1 }"><c:out value="매우만족"/></c:if>
			</td>			
		</tr>				
		</c:forEach>
		</c:if>
		</tbody>
	</table>
</form:form>