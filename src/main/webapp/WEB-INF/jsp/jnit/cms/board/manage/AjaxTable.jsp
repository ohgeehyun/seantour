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
		<c:if test="${empty resultList }">
			<tr>
				<td>관리 하시는 게시판이 없습니다.</td>
				<td>-</td>
			</tr>
		</c:if>							
		<c:if test="${!empty resultList }">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td id="${result.boardId}">
						<a href="javascript:changeSelectBoard('<c:out value="${result.boardId}"/>', '<c:out value="${result.boardTitle}"/>')">
							<c:out value="${result.boardTitle}"/>
						</a>
					</td>
					<td><c:out value="${siteResult[result.boardGroup]}" /></td>
	   			</tr>
			</c:forEach>	
		</c:if>