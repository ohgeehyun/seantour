<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="jtag" uri="/jnittag"%>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	
  response.setHeader("Content-Type", "application/vnd.ms-xls; charset=euc-kr");

  response.setHeader("Content-Disposition", "inline; filename=board.xls");

%>
<head>
<META HTTP-EQUIVE="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=KSC5601">
</head>
<body>
<table class="bbsList table table-bordered table-hover" summary="<c:out value="${boardinfoVO.boardTitle}" />의 게시글 목록입니다">
	<caption><c:out value="${boardinfoVO.boardTitle}" /></caption>
	<thead>
		<tr>
			<th class="title">제목</th>
			<c:if test="${not empty lbl.writer}">
			<th scope="row" class="writer"><c:out value="${lbl.writer}" /></th>
			</c:if>
			<c:if test="${not empty lbl.created}">
			<th scope="row" class="created"><c:out value="${lbl.created}" /></th>
			</c:if>
			<c:if test="${not empty lbl.hit}">
			<th scope="row" class="hit"><c:out value="${lbl.hit}" /></th>
			</c:if>
			<c:forEach var="k" items="${sIdx}" varStatus="s">
				<c:choose>
					<c:when test="${k == 'content'}">
					<th scope="row" class="content">컨텐츠</th>
					</c:when>
					<c:otherwise>
					<th scope="row" class="${k}"><c:out value="${f[k].lbl}" /></label></th>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
			<td class="title"><c:out value="${result.title}" /></td>
			<c:if test="${not empty lbl.writer}">
			<td class="writer"><c:out value="${result.writer}" /></td>
			</c:if>
			<c:if test="${not empty lbl.created}">
			<td class="created">
						<fmt:parseDate var="dateFmt" value="${result.created}" pattern="yyyy-MM-dd" />
						<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd" />
			</td>
			</c:if>
			<c:if test="${not empty lbl.hit}">
			<td class="hit"><c:out value="${result.hit}" /></td>
			</c:if>
			<c:forEach var="k" items="${sIdx}" varStatus="s">
			<c:choose>
				<c:when test="${k == 'content'}">
				<td class="content">
					<div class="content">
					<c:out value="${jtag:removeHtmlTag(fn:substring(fn:replace(contentMap[result.id],'&nbsp;',''),0,1000))}
					${fn:length(jtag:removeHtmlTag(contentMap[result.id]))>1000?'...':''}" />
					</div>
				</td>
				</c:when>
				<c:otherwise>
					<td >
							<c:choose>
							<%--input--%>
							<c:when test="${f[k].type == 'input'}">
							<c:out value="${result[k]}" />
							</c:when>
							<%--textarea--%>
							<c:when test="${f[k].type == 'textarea'}">
							<c:out value="${result[k]}" />
							</c:when>
							<%--date yyyy-MM-dd--%>
							<c:when test="${f[k].type == 'datetime'}">
							<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd hh:mm:ss" />
							</c:when>
							<%--date yyyy-MM-dd hh:mm:ss--%>
							<c:when test="${f[k].type == 'date'}">
							<fmt:formatDate value="${result[k]}" pattern="yyyy-MM-dd" />
							</c:when>
							<%--select--%>
							<c:when test="${f[k].type == 'select'}">
							<c:out value="${result[k]}" />
							</c:when>
							<c:otherwise>
							<c:out value="${result[k]}" />
							</c:otherwise>
							</c:choose>
					</td>
				</c:otherwise>
			</c:choose>
			</c:forEach>
			</tr>
		</c:forEach>
		<c:if test="${empty resultList}">
			<tr>
				<td colspan="<c:out value="${fn:length(sIdx)}" />" class="nodata">조회된 게시물이 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
</body>