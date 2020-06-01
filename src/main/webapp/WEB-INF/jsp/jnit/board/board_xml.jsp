<%
/**
 *@version 3.2.0.1
 **/
%>
<%@page import="com.itextpdf.text.log.SysoCounter"%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 

%><%@ page contentType="application/xml; charset=utf-8" pageEncoding="utf-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %><%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ taglib prefix="jtag" uri="/jnittag"%>
<%@ page import = "org.springframework.web.context.*,
 org.springframework.web.context.support.*,
 egovframework.com.cmm.service.EgovProperties,
 jnit.board.info.JnitboardinfoVO,
 java.math.BigInteger,
 egovframework.rte.fdl.property.EgovPropertyService,
 egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo,
 egovframework.com.utl.fcc.service.*,
 egovframework.rte.psl.dataaccess.util.EgovMap,
 java.util.*, java.io.*, java.net.URLDecoder,java.net.URLEncoder" %>
<%@page import="org.apache.commons.lang.StringUtils"%> 
<%@ page import="jnit.board.*" %>
<% 
	String lang = JnitboardController.lang; //언어설정
	String boardServletPath = request.getServletPath();
	String[] boardSitePath = boardServletPath.split("/"); //사이트경로		
%>
<c:set var="getSitePath" value="<%= boardSitePath[1] %>" />
<%
	pageContext.setAttribute("lf", "\n");

	/** 첨부 최대 파일 크기 지정 */
	final long maxFileSize = (1024 * 1024 * 1000); //업로드 최대 사이즈 설정 (1000M)

	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletConfig().getServletContext());
	EgovPropertyService propertiesService = (EgovPropertyService) ctx.getBean("propertiesService");

	String ctxRoot = getServletContext().getContextPath();
%>
<c:set var="ctxRoot" value="<%=ctxRoot%>" />
<%
	String boardURL = request.getRequestURL().toString();	
	Boolean boardlocal = StringUtil.isExistString(boardURL,"local");	
	String boardURI = request.getRequestURI().toString().indexOf("board.jsp") > -1 ? "/board/board.do" : request.getRequestURI().toString().replace(ctxRoot,"");
%>
<c:set var="retUrl" value="<%= boardURI %>"/>
<board>
	<info>
		<boardTitle>${boardinfoVO.boardTitle}</boardTitle>
	</info>
	<list>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<row>
			<c:forEach var="row" items="${result}">
				<c:if test="${row.key == 'content' || row.key == 'title' || fn:contains(row.key, 'ext') == true}">
					<c:set var="cDataS" value="<![CDATA[" />
					<c:set var="cDataE" value="]]>" />
				</c:if>
				<c:if test="${row.key != 'content' && row.key != 'title' && fn:contains(row.key, 'ext') != true}">
					<c:set var="cDataS" value="" />
					<c:set var="cDataE" value="" />
				</c:if>
				<c:if test="${rows.key != 'ismain' && fn:contains(row.key, 'file') != true }">
					<${row.key}>${cDataS}<c:out value="${row.value}" escapeXml="false" />${cDataE}</${row.key}>
				</c:if>
			</c:forEach>
			<files>
			<c:forEach var="files" items="${boardFileMap[result.id]}">
				<file>
				<c:forEach var="file" items="${files}">
					<${file.key}><c:out value="${file.value}" escapeXml="false" /></${file.key}>
				</c:forEach>
				</file>
			</c:forEach>
			</files>
		</row>
		</c:forEach>
	</list>
</board>