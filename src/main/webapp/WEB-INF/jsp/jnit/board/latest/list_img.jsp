<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
	
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:if test="${status.count == 1}">
			<c:if test="${fn:contains(result.fileUrl, '.jpg') || fn:contains(result.fileUrl, '.gif')}">
				<p class="img">
					<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
						<img src="/images/no-img.jpg" alt="${result.title}과 관련된 이미지 입니다" />
					</a>
				</p>
				<dl>
					<dt><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${result.title}" /></a></dt>
					<dd>
					<c:if test="${result.isHtml == 1}">
						<c:out value="${fn:substring(jtag:removeHtmlTag(result.content),0,90)}${fn:length(result.content)>90?'...':''}" escapeXml="false"/>
					</c:if>
					<c:if test="${result.isHtml == 0}">
						<c:out value="${fn:substring(jtag:removeHtmlTag(result.content),0,90)}${fn:length(result.content)>90?'...':''}" escapeXml="false"/>
					</c:if>
					
					</dd>
				</dl>
			</c:if>
			<c:if test="${!(fn:contains(result.fileUrl, '.jpg') || fn:contains(result.fileUrl, '.gif'))}">
			<dl class="full">
					<dt><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${result.title}" /></a></dt>
					<dd>
					<c:if test="${result.isHtml == 1}">
						<c:out value="${fn:substring(jtag:removeHtmlTag(result.content),0,120)}${fn:length(jtag:removeHtmlTag(result.content))>120?'...':''}" escapeXml="false"/>
					</c:if>
					<c:if test="${result.isHtml == 0}">
						<c:out value="${fn:substring(jtag:removeHtmlTag(result.content),0,120)}${fn:length(jtag:removeHtmlTag(result.content))>120?'...':''}" escapeXml="false"/>
					</c:if>
					</dd>
					
			</dl>
			</c:if>
		</c:if>
	</c:forEach>
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:if test="${status.count != 1}">	
			<c:set var="created" value="${result.created}" />
			<fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
			<li><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${result.title}"/></a><span class="date"><fmt:formatDate value="${created}" pattern="yyyy.MM.dd" /></span></li>
		</c:if>
		</c:forEach>
		<c:if test="${empty resultList}">
			<li>조회된 게시물이 없습니다.</li>
		</c:if>
	</ul>
