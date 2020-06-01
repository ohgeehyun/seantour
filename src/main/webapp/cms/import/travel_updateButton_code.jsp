<!--
/**
 *@version 3.2.0.1
 **/ 
-->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/_common/header.jsp" %>
		<%
			String servletPath = request.getServletPath();
		%>
		
		<%
			String cntId = CmsServletPathProperty.getProp(servletPath,"cntId");
			String siteId = CmsServletPathProperty.getProp(servletPath,"siteId");
			String thisMenuId = CmsServletPathProperty.getProp(servletPath,"menuId");
			String language1MenuId = CmsServletPathProperty.getProp(servletPath,"language1");
			String language2MenuId = CmsServletPathProperty.getProp(servletPath,"language2");
			String language3MenuId = CmsServletPathProperty.getProp(servletPath,"language3");
			String language4MenuId = CmsServletPathProperty.getProp(servletPath,"language4");
			String language5MenuId = CmsServletPathProperty.getProp(servletPath,"language5");
		%>
		<c:if test="${login.typeVO.typeLv == 'A' || (admId == login.mbrId) || (admId2 == login.mbrId) && login.mbrId != null && !empty admId && !empty admId2 }">
		
		<c:set var="cntCntId" value="<%= cntId %>"/>
		<c:set var="cntSiteId" value="<%= siteId %>"/>
		<c:set var="thisMenuId" value="<%= thisMenuId %>"/>
		<c:set var="language1MenuId" value="<%= language1MenuId %>"/>
		<c:set var="language2MenuId" value="<%= language2MenuId %>"/>
		<c:set var="language3MenuId" value="<%= language3MenuId %>"/>
		<c:set var="language4MenuId" value="<%= language4MenuId %>"/>
		<c:set var="language5MenuId" value="<%= language5MenuId %>"/>
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
			
			$("#compareOpen").on("click", function(e){
				
				var x = screen.availWidth-10;
				var y = screen.availHeight-70;
				var popupUrl = "<c:url value='/cms/language/compareView.do' />?thisMenuId=${thisMenuId}&language1=${language1MenuId}&language2=${language2MenuId}&language3=${language3MenuId}&language4=${language4MenuId}&language5=${language5MenuId}";
				window.open(popupUrl, "TITLE", "width="+x+",height="+y+",scrollbars=yes");
			});
			
		});
		//-->
		</script>
		<% if(!CmsServletPathProperty.isTpl(servletPath)){ %>
		<button id="PageContentEdit" name="PageContentEdit" class="btn_info" >콘텐츠수정</button>
			<% if(language1MenuId != ""){ %>
				<!-- <button id="compareOpen" name="compareOpen" class="btn_info">수정요청</button> -->
			<% } %>
		<% } %>
		</c:if>
