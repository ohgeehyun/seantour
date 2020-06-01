<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="../header.jsp" %>
	
	<ul>		
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<%
								Map rst = (Map)pageContext.getAttribute("result");
								if(rst.get("fileUrl") != null){
									String fileUrl = (String)rst.get("fileUrl");
									String[] fileUrlArr = fileUrl.split("/");
									fileUrlArr[fileUrlArr.length-1] = "list_" + fileUrlArr[fileUrlArr.length-1];
									fileUrl = StringUtils.join(fileUrlArr,"/");
									request.setAttribute("fileUrl",fileUrl);
									
								}else{
									request.setAttribute("fileUrl","/images/noimg.gif");
								}
		%>
			<li>
				<p class="img">
					<%-- <a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"> --%>
					<a href="${basePath}?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
						<img src="<c:url value="${fileUrl}" />" alt="<c:out value="${empty result.fileExt01 ? result.title : result.fileExt01}" /><c:out value="${empty result.fileExt01 ? ' 관련된 이미지 입니다' : ''}" />" />
					</a>
				</p>
				<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
					<c:out value="${result.title}"/>
				</a>
				<span><c:out value="${fn:substring(result.created,0,10)}" /></span>
			</li>
			<c:if test="${empty resultList}">
			<li>조회된 게시물이 없습니다.</li>
			</c:if>
		</c:forEach>
	</ul>
