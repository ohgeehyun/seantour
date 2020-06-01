<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="header.jsp" %>

<jsp:include page="/board/skin/${boardinfoVO.boardSkin}/_${boardinfoVO.boardType}${mobileMode?'_mobile':''}/cmt.jsp" flush="false"/>

