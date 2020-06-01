<%
/**
 *@version 3.2.0.2
 **/
%>
<%--
<c:out value="${infoVO.boardTitle}"/> : 게시판제목
반복시작 : <c:forEach var="result" items="${resultList}" varStatus="status"><%String mgmtId = (String)request.getAttribute("mgmtId");Map rst = (Map)pageContext.getAttribute("result");if(rst.get("fileUrl") != null && !"".equals(rst.get("fileUrl")) ){String fileUrl = (String)rst.get("fileUrl");String[] fileUrlArr = fileUrl.split("/");fileUrlArr[fileUrlArr.length-1] = mgmtId+"_"+ fileUrlArr[fileUrlArr.length-1];fileUrl = StringUtils.join(fileUrlArr,"/");request.setAttribute("fileUrl",fileUrl);}else{request.setAttribute("fileUrl","/images/noimg.gif");}%>
                    <a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><img src="<c:url value="${result.thumbUrl}" />" alt="<c:out value="${empty result.fileExt01 ? result.title : result.fileExt01}" /><c:out value="${empty result.fileExt01 ? ' 관련된 이미지 입니다' : ''}" />" /></a> : 대표이미지
                    <c:out value="${result.title}"/> : 제목
                    <a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}" class="title"><c:out value="${result.title}" /></a> : 제목링크
                    <c:out value="${fn:substring(result.created,0,10)}" /> 작성일
                    <c:set var="boardLatestContent" value="${jtag:removeHtmlTag(fn:replace(fn:replace(fn:replace(result.content,'&nbsp;',''),'&lt;','<'),'&gt;','>'))}"/><c:out value="${fn:substring(boardLatestContent,0,15)}" escapeXml="false" /><c:out value="${fn:length(boardLatestContent) > 15 ? '...' : ''}"/> : 내용
                    <c:out value="${result.writer}"/> : 작성자
                    <c:out value="${result.hit}" /> : 조회수
반복끝 :</c:forEach>
--%>

<c:out value="${infoVO.boardTitle}" />
<c:forEach var="result" items="${resultList}" varStatus="status">
<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
	<img src="<c:url value="${result.thumbUrl}" />" alt="<c:out value="${empty result.fileExt01 ? result.title : result.fileExt01}" /><c:out value="${empty result.fileExt01 ? ' 관련된 이미지 입니다' : ''}" />" />
</a>
<c:out value="${result.title}"/>
<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}" class="title">
	<c:out value="${result.title}" />
</a>
<c:out value="${fn:substring(result.created,0,10)}" />
<c:set var="boardLatestContent" value="${jtag:removeHtmlTag(fn:replace(fn:replace(fn:replace(result.content,'&nbsp;',''),'&lt;','<'),'&gt;','>'))}"/>
<c:out value="${fn:substring(boardLatestContent,0,15)}" escapeXml="false" /><c:out value="${fn:length(boardLatestContent) > 15 ? '...' : ''}"/>
<c:out value="${result.writer}"/>
<c:out value="${result.hit}" />
</c:forEach>