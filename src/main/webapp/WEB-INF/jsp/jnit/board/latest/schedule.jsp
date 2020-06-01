<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>      
			 <table class="table table-bordered box main-schedule" cellspacing="0" cellpadding="0" summary="한주간의 요일별 날짜들입니다.">
				<caption>이번주달력</caption>
				<thead>
					<tr>
						<th class="sun" scope="col" <c:out value="${dow['1']}" escapeXml="false" />>일</th>
						<th scope="col" <c:out value="${dow['2']}" escapeXml="false" />>월</th>
						<th scope="col" <c:out value="${dow['3']}" escapeXml="false" />>화</th>
						<th scope="col" <c:out value="${dow['4']}" escapeXml="false" />>수</th>
						<th scope="col" <c:out value="${dow['5']}" escapeXml="false" />>목</th>
						<th scope="col" <c:out value="${dow['6']}" escapeXml="false" />>금</th>
						<th class="sat" scope="col" <c:out value="${dow['7']}" escapeXml="false" />>토</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td <c:out value="${dow['1']}" escapeXml="false" />><a href="${basePath}?boardId=${boardId}&amp;searchDate=${fmtdate['1']}" ><c:out value="${day['1']}" /></a></td>
						<td <c:out value="${dow['2']}" escapeXml="false" />><a href="${basePath}?boardId=${boardId}&amp;searchDate=${fmtdate['2']}" ><c:out value="${day['2']}" /></a></td>
						<td <c:out value="${dow['3']}" escapeXml="false" />><a href="${basePath}?boardId=${boardId}&amp;searchDate=${fmtdate['3']}" ><c:out value="${day['3']}" /></a></td>
						<td <c:out value="${dow['4']}" escapeXml="false" />><a href="${basePath}?boardId=${boardId}&amp;searchDate=${fmtdate['4']}" ><c:out value="${day['4']}" /></a></td>
						<td <c:out value="${dow['5']}" escapeXml="false" />><a href="${basePath}?boardId=${boardId}&amp;searchDate=${fmtdate['5']}" ><c:out value="${day['5']}" /></a></td>
						<td <c:out value="${dow['6']}" escapeXml="false" />><a href="${basePath}?boardId=${boardId}&amp;searchDate=${fmtdate['6']}" ><c:out value="${day['6']}" /></a></td>
						<td <c:out value="${dow['7']}" escapeXml="false" />><a href="${basePath}?boardId=${boardId}&amp;searchDate=${fmtdate['7']}" ><c:out value="${day['7']}" /></a></td>
					</tr>
				</tbody>
			</table>
		<ul class="main_schedule_board"><%-- <c:out value="${fn:substring(fn:trim(result.title),0,15)}"/> --%>
	<c:forEach var="result" items="${resultList}">
		<li><i class="icon-li icon-caret-right"></i>[<c:out value="${fn:substring(result.date01,14,19)}" />] <a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${result.title}"/></a></li>
	</c:forEach>
	<c:if test="${empty resultList}">
			<li>조회된 게시물이 없습니다.</li>
	</c:if>
		</ul>