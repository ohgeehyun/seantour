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
			<th>1뎁스</th>
			<th>2뎁스</th>
			<th>3뎁스</th>
			<th>4뎁스</th>
			<th>5뎁스</th>
			<th>6뎁스</th>
			<th>7뎁스</th>
			
			<th>페이지제목</th>
			<th>URL</th>
			
			<th>매무불만족</th>
			<th>불만족</th>
			<th>보통</th>
			<th>만족</th>
			<th>매우만족</th>
			<th>작성자</th>
			<th>내용</th>
			<th>작성자평가</th>
			<th>등록일</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${empty resultList }">
		<tr>
			<td>-</td>
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
			
			<td nowrap><c:out value="${result.hit1 }"/></td>
			<td nowrap><c:out value="${result.hit2 }"/></td>
			<td nowrap><c:out value="${result.hit3 }"/></td>
			<td nowrap><c:out value="${result.hit4 }"/></td>
			<td nowrap><c:out value="${result.hit5 }"/></td>
			
			<c:if test="${empty pagedataMap[result.rscpId]}">
			<td nowrap><c:out value=""/></td>
			<td nowrap><c:out value=""/></td>
			<td nowrap><c:out value=""/></td>
			<td nowrap><c:out value=""/></td>
			</c:if>
			
			<c:if test="${!empty pagedataMap[result.rscpId]}">
				<c:forEach var="result2" items="${pagedataMap[result.rscpId]}" varStatus="status2">
					<c:if test="${status2.count == 1 }">		
						<td nowrap>
							<c:if test="${empty mbrNmMap[result2.pdataId] }"><c:out value="${result2.remoteAddr }"/></c:if>
							<c:if test="${!empty mbrNmMap[result2.pdataId] }"><c:out value="${mbrNmMap[result2.pdataId] }(${result2.remoteAddr })"/></c:if>
						</td>
						<td nowrap><c:out value="${result2.memo }"/></td>
						<td nowrap>
							<c:if test="${result2.hit1 == 1 }"><c:out value="매우 불만족"/></c:if>
							<c:if test="${result2.hit2 == 1 }"><c:out value="불만족"/></c:if>
							<c:if test="${result2.hit3 == 1 }"><c:out value="보통"/></c:if>
							<c:if test="${result2.hit4 == 1 }"><c:out value="만족"/></c:if>
							<c:if test="${result2.hit5 == 1 }"><c:out value="매우만족"/></c:if>
						</td>
						<td nowrap><fmt:formatDate value="${result2.created }" pattern="yyyy-MM-dd"/></td>
					</c:if>								
				</c:forEach>
			</c:if>
			
		</tr>
		
			<c:if test="${!empty pagedataMap[result.rscpId]}">	
				<c:forEach var="result2" items="${pagedataMap[result.rscpId]}" varStatus="status2">
					<c:if test="${status2.count != 1 }">
					<tr>
						<td></td>
						<td nowrap></td>	
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap></td>
						
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap></td>
						<td nowrap>
							<c:if test="${empty mbrNmMap[result2.pdataId] }"><c:out value="${result2.remoteAddr }"/></c:if>
							<c:if test="${!empty mbrNmMap[result2.pdataId] }"><c:out value="${mbrNmMap[result2.pdataId] }(${result2.remoteAddr })"/></c:if>
						</td>
						<td nowrap><c:out value="${result2.memo }"/></td>
						<td nowrap>
							<c:if test="${result2.hit1 == 1 }"><c:out value="매우 불만족"/></c:if>
							<c:if test="${result2.hit2 == 1 }"><c:out value="불만족"/></c:if>
							<c:if test="${result2.hit3 == 1 }"><c:out value="보통"/></c:if>
							<c:if test="${result2.hit4 == 1 }"><c:out value="만족"/></c:if>
							<c:if test="${result2.hit5 == 1 }"><c:out value="매우만족"/></c:if>
						</td>
						<td nowrap><fmt:formatDate value="${result2.created }" pattern="yyyy-MM-dd"/></td>
					</tr>	
					</c:if>
				</c:forEach>
			</c:if>
					
		</c:forEach>
		</c:if>		
		</tbody>
	</table>
</form:form>