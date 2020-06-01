<%
/**
 *@version 3.2.0.1
 **/
%>
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
   	location.href="?pageIndex="+pageNo;
}

$(document).ready(function(){
	/* $('.banlist_img').find('img').click(function(){
		var clickSrc = $(this).attr('src');
		$('#modelbanner').attr('src',clickSrc);
		$("#myModal").css("display","block");
	});
	$("#Jnit_MoreClose").click(function(e){
		e.preventDefault();
		$("#myModal").css("display","none");
	}); */
});
 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
	<!-- <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">	  
		<div class="modal-body">
			<p>
				<img src="" id="modelbanner" />
			</p>
		</div>
		<div class="modal-footer">
			<button class="btn" id="Jnit_MoreClose">닫기</button>
		</div>
	</div> -->
	<div class="db_listGroup MAT20">
		<ul>
			<c:forEach var="moreList" items="${moreList }" varStatus="status">
				<li>
					<p class="banlist_img">
						<a href="#myModal" role="button" data-toggle="modal">
							<img src="<c:url value="${moreList.itemUrl }" />" alt="<c:out value="${DBType == 'ORACLE' || DBType == 'TIBERO' ? itemAltMap[moreList.itemId] : moreList.itemAlt }" />" id="modelImg" />
						</a>
					</p>					
					<h4><c:out value="${DBType == 'ORACLE' || DBType == 'TIBERO' ? itemAltMap[moreList.itemId] : moreList.itemAlt }"/></h4>
					<p class="ban_link">
						<strong>홈페이지 주소 : </strong>
						<a href="<c:out value="${moreList.itemLink }" />" title="새창으로 열립니다." target="_blank">
							<c:out value="${fn:substring(moreList.itemLink,0,40) }" escapeXml="false" />
							<c:out value="${fn:length(moreList.itemLink) > 41 ? '...' : '' }" />
						</a>
					</p>
				</li>	
			</c:forEach>
		</ul>
		<!-- /List -->		
		<div class="row-fluid board-nav">
			<ui:pagination paginationInfo = "${paginationInfo}" type="jnitDefault" jsFunction="fn_egov_link_page" /> <form:hidden path="pageIndex" />		
		</div>
	</div>   
</form:form>