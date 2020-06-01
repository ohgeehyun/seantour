<%
/**
 *@version 3.2.0.2
 **/
%>
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
<c:forEach var="result" items="${resultList}" varStatus="status">
<c:set var="created" value="${result.created}" />
<fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
<c:out value="${result.title}"/>
<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}" class="title"><c:out value="${result.title}" /></a>
<fmt:formatDate value="${created}" pattern="yyyy.MM.dd" />
<c:set var="boardLatestContent" value="${jtag:removeHtmlTag(fn:replace(fn:replace(fn:replace(result.content,'&nbsp;',''),'&lt;','<'),'&gt;','>'))}"/><c:out value="${fn:substring(boardLatestContent,0,15)}" escapeXml="false" /><c:out value="${fn:length(boardLatestContent) > 15 ? '...' : ''}"/>
<c:out value="${result.writer}"/>
<c:out value="${result.hit}" />
</c:forEach>
