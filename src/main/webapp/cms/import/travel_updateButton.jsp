<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/_common/header.jsp" %>
		<%			
			String servletPath = request.getServletPath();
		%>
		<c:if test="${login.typeVO.typeLv == 'A' || (admId == login.mbrId) || (admId2 == login.mbrId) && login.mbrId != null && !empty admId && !empty admId2 }">
		
		<% 
			String cntId = CmsServletPathProperty.getProp(servletPath,"cntId");
			String siteId = CmsServletPathProperty.getProp(servletPath,"siteId");
		%>
		
		<c:set var="cntCntId" value="<%= cntId %>"/><%--cmsClientProperty.cntId--%>
		<c:set var="cntSiteId" value="<%= siteId %>"/><%--cmsClientProperty.siteId--%>
		<script type="text/javascript">
		<!--
			var ufn_edit = function() {
				var msgUfn = window.open('<c:url value="/cms/sub11/0101upview.do?cntId=${cntCntId}&siteId=${cntSiteId}"/>', 'uFn', 'width=900,height=950,scrollbars=yes,resizable=yes');	
			}
		
		$(document).ready(function(){
			
			$("#PageContentEdit").on("click", function(e){
				e.preventDefault();
				
				ufn_edit();
			});
		});
		//-->
		</script>
		<% if(!CmsServletPathProperty.isTpl(servletPath)){ %>
		<button id="PageContentEdit" name="PageContentEdit" class="btn_info" >콘텐츠수정</button>
		<% } %>
		</c:if>
