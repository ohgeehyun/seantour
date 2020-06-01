<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	    <div id="gnb">
        <h2 class="comment">Global menu</h2>
            <ul id="topmenu">
            <c:forEach var="menu" items="${menuTree}" varStatus="status">
				<li class="gnb<fmt:formatNumber pattern="00" value="${status.index+1}"/> <c:out value="${menu.over}"/>"><a href="<c:url value="${menu.link}"/>">${menu.title}</a>
					<c:if test="${menu.childCount > 0}">
                	<div id="submenu<fmt:formatNumber pattern="00" value="${status.index+1}" />" style="display: block;">
                        <ul>
						<c:forEach var="child" items="${menu.childTree}" varStatus="status2">
                        	<li class="<c:out value="${child.over}"/>"><a href="<c:url value="${child.link}"/>">${child.title}</a></li>
						</c:forEach>
                        </ul>
                    </div>
                    </c:if>
                </li>
			</c:forEach>
            </ul>
        </div>