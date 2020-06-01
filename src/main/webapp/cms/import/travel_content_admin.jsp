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

			String amdNm2 = CmsServletPathProperty.getProp(servletPath,"admNm2"); 
			String amdTel2 = CmsServletPathProperty.getProp(servletPath,"admTel2");
			String amdNm = CmsServletPathProperty.getProp(servletPath,"admNm"); 
			String amdTel = CmsServletPathProperty.getProp(servletPath,"admTel");
			String cntModified = CmsServletPathProperty.getProp(servletPath,"cntModified");
		%>
		
		<c:set var="admNm2" value="<%=amdNm2 %>" /><%--cmsClientProperty.admNm2  --%>
		<c:set var="admTel2" value="<%=amdTel2 %>" /><%--cmsClientProperty.admTel2  --%>
		<c:set var="admNm" value="<%=amdNm %>" /><%--cmsClientProperty.admNm  --%>
		<c:set var="admTel" value="<%=amdTel %>" /><%--cmsClientProperty.admTel  --%>
		<c:set var="cntModified" value="<%=cntModified%>" />
		<% if(!CmsServletPathProperty.isTpl(servletPath)){ %>
		<div class="adminArea">
			<c:if test="${!empty admNm2}">
			<dl class="left">			
				<dt class="content_master">콘텐츠 담당자 :</dt>
				<dd class="content_master_dd"><c:if test="${empty admNm2}">미지정</c:if>${admNm2}</dd> 
				<dt class="content_master_tel">전화 :</dt>
				<dd class="content_master_tel_dd"><c:if test="${empty admTel2}">미지정</c:if>${admTel2}</dd> 
			</dl>
			</c:if>		
			<dl class="left">
				<dt class="content_master">콘텐츠 담당자 :</dt>
				<dd class="content_master_dd"><c:if test="${empty admNm}">미지정</c:if>${admNm}</dd> 
				<dt class="content_master_tel">전화 :</dt>
				<dd class="content_master_tel_dd"><c:if test="${empty admTel}">미지정</c:if>${admTel}</dd>
				<c:if test="${!empty cntModified }" >
					<dt id="boardInfoDT">콘텐츠 최종 수정일 : </dt>
					<dd id="boardInfoDD">${cntModified }</dd> 
				</c:if>
			</dl>						
		</div>
		<% } %>
