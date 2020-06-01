<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<%--<div class="<c:out value="${wrapClass}" />"> --%>
	<div class="span4">
		<div class="box">
			<div class="tab-header">
				<c:out value="${infoVO.boardTitle}" />
				<span class="pull-right">
                	<span class="options">
                   		<a href="${basePath}"><i class="icon-plus"></i></a>
                    </span>
                </span>
           </div>                      
			 <ul class="main_normal_board">
			<c:forEach var="result" items="${resultList}">
			<c:set var="created" value="${result.created}" />
			<fmt:parseDate value="${result.created}" var="created" pattern="yyyy-MM-dd HH:mm:ss"/>
				<li><i class="icon-li icon-caret-right"></i><a href="${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}"><c:out value="${result.title}"/></a><fmt:formatDate value="${created}" pattern="yyyy.MM.dd" /></li>
			</c:forEach>
			</ul>
		</div>
	</div>
