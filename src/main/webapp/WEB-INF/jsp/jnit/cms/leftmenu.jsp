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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var selectMenu = function(mcd) {
	if($('li[rel='+mcd+'] ul li').length>1){
		$('li[rel='+mcd+']').find('ul.left_sub').toggle();
	}else{
		$(location).attr('href',$('li[rel='+mcd+'] ul li a').attr('href'));
	}
}

$(document).ready(function(){
	$('ul#left_menu ul.left_sub').hide();
	
	$('ul#left_menu ul.left_sub li a.on').removeClass('on');
	$('ul.left_sub li.currentPage').parent().prev().addClass('on');
	
	$('ul.left_sub li a.on').removeClass('on');
	if($('ul.left_sub li.currentPage').parent().children().length>1){
		$('ul.left_sub li.currentPage').parent().show();
	}
	$('ul.left_sub li.currentPage a').addClass('on');
});
</script>

<ul id="left_menu">
<c:forEach var="menu" items="${menuList}" varStatus="status">
	<li rel="<c:out value="${menu.menuId}"/>">
	<c:if test="${menu.islink == true}"><a href="<c:out value="${menu.linkurl}" />" target="_blank"></c:if>
	<c:if test="${menu.islink == false}"><a href="javascript:selectMenu('<c:out value="${menu.menuId}"/>' )"></c:if>
	<c:out value="${menu.menuNm}" /></a>
	<c:if test="${!empty submenuList[menu.menuId]}">
	<ul rel="<c:out value="${menu.menuId}"/>" class="left_sub">
		<c:forEach var="submenu" items="${submenuList[menu.menuId]}" varStatus="subStatus">
 		<c:set var="currentMenuPath" value="${pageContext.request.contextPath}${pathmenu[submenu.menuId]}"/>
		<c:if test="${menu.cntId != submenu.cntId}">
		<li class="<c:out value="${hashmenu[submenu.cntId]}"/> <c:out value="${pageContext.request.requestURI == currentMenuPath ? 'currentPage' : ''}"/>"><a href="<c:url value="${pathmenu[submenu.menuId]}"/>"><c:out value="${submenu.menuNm}"/></a></li>
		</c:if>
		<c:if test="${menu.cntId == submenu.cntId}">
		<li class="<c:out value="${hashmenu[submenu.cntId]}"/> <c:out value="${pageContext.request.requestURI == currentMenuPath ? 'currentPage' : ''}"/>" style="display:none;"><a href="<c:url value="${pathmenu[submenu.menuId]}"/>"><c:out value="${submenu.menuNm}"/></a></li>
		</c:if>
		</c:forEach>
	</ul>
	</c:if>
	</li>
</c:forEach>
</ul>