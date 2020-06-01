<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="topOrder" value="${order < 10 ? '0' : ''}${order}" />
<c:forEach var="menu" items="${menuTree}" varStatus="st">
	<li class="Inb${topOrder} ${menu.over}"><a href="${menu.link}">${menu.title}</a>
	</li>
</c:forEach>
