<%
/**
 *@version 3.2.0.1
 **/
%>
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
<%--
<c:out value="${infoVO.boardTitle}"/> : 게시판제목
반복시작 : <c:forEach var="result" items="${resultList}" varStatus="status"><c:set var="created" value="${result.created}" /><fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
                    <c:out value="${result.title}"/> : 제목
                    <a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}" class="title"><c:out value="${result.title}" /></a> : 제목링크
                    <fmt:formatDate value="${created}" pattern="yyyy.MM.dd" /> 작성일
                    <c:set var="boardLatestContent" value="${jtag:removeHtmlTag(fn:replace(fn:replace(fn:replace(result.content,'&nbsp;',''),'&lt;','<'),'&gt;','>'))}"/><c:out value="${fn:substring(boardLatestContent,0,15)}" escapeXml="false" /><c:out value="${fn:length(boardLatestContent) > 15 ? '...' : ''}"/> : 내용
                    <c:out value="${result.writer}"/> : 작성자
                    <c:out value="${result.hit}" /> : 조회수
반복끝 :</c:forEach>
--%>
<c:out value="${infoVO.boardTitle}"/>
<c:forEach var="result" items="${resultList}" varStatus="status"><c:set var="created" value="${result.created}" /><fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
<c:out value="${result.title}"/>
<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}" class="title"><c:out value="${result.title}" /></a>
<fmt:formatDate value="${created}" pattern="yyyy.MM.dd" />
<c:set var="boardLatestContent" value="${jtag:removeHtmlTag(fn:replace(fn:replace(fn:replace(result.content,'&nbsp;',''),'&lt;','<'),'&gt;','>'))}"/><c:out value="${fn:substring(boardLatestContent,0,15)}" escapeXml="false" /><c:out value="${fn:length(boardLatestContent) > 15 ? '...' : ''}"/>
<c:out value="${result.writer}"/>
<c:out value="${result.hit}" />
</c:forEach>