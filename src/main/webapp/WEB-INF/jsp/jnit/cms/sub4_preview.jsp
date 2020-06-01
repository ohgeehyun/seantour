<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jnit.cms.handler.CmsProperty" %>
<%
CmsProperty.init(request);
%>
<jsp:include page="${tplFileS}" />
{-CONTENT-}
<jsp:include page="${tplFileE}" />
