<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<%--<div class="<c:out value="${wrapClass}" />" --%>
	<div class="span4">
		<div class="box">
			<div class="tab-header">
				<c:out value="${infoVO.boardTitle}" />
				<span class="pull-right">
                	<span class="options">
                   		<a href="${basePath}?boardId=${boardId}&amp;mode=list"><i class="icon-plus"></i></a>
                    </span>
                </span>
           </div>
           <div class="padded">
           <ul>         
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<li>
					<p class="new_img">
						<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}">
							<img src="<c:out value="${result.fileUrl}" />" width="179" height="118" alt="<c:out value="${result.title}" />" />
						</a>
					</p>
					<dl class="main_gallery">
						<dt>
							<a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${fn:substring(fn:trim(result.title),0,15)}"/></a>
						</dt>
						<dd class="txt">
							<c:set var="created" value="${result.created}" />
							<fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
							<span class="latestdate"><fmt:formatDate value="${created}" pattern="yyyy.MM.dd" /></span>
						</dd>
					</dl>
				</li>
			</c:forEach>
			</ul>
			</div>
		</div>
	</div>
	