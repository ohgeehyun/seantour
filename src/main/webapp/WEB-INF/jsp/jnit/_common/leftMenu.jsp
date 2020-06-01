<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            	<c:forEach var="dp1" items="${treeMap.child}">
            	<li class="<c:out value="${fn:substring(menuId,0,5) == fn:substring(dp1.key,0,5) ? 'active open' : ''}" />"><a href="<c:url value= "${dp1.value.link}" />" data-menu-id="${dp1.key}"><i class="icon icon-${dp1.value.icon}"></i><span> ${dp1.value.name}</span></a>
            		<c:if test="${not empty dp1.value.child}">
            		<ul class="depth2 off" data-menu-id="${dp1.key}">
            			<c:forEach var="dp2" items="${dp1.value.child}">
           				<li class="<c:out value="${fn:substring(menuId,0,7) == fn:substring(dp2.key,0,7) ? 'active open' : ''}" />"><a href="<c:url value= "${dp2.value.link}" />" data-menu-id="${dp2.key}"><i class="icon icon-${dp2.value.icon}"></i><span> ${dp2.value.name}</span></a>
           					<c:if test="${not empty dp2.value.child}">
	           						<ul class="depth3 off" data-menu-id="${dp2.key}">
		           						<c:forEach var="dp3" items="${dp2.value.child}">
			           						<li>
			           							<a href="<c:url value= "${dp3.value.link}" />" data-menu-id="${dp3.key}"> ${dp3.value.name}</a>
			           						</li>
		           						</c:forEach>
	           						</ul>           					
           					</c:if>
           				</li>
            			</c:forEach>
            		</ul>
            		</c:if>
            	</li>
            	</c:forEach>