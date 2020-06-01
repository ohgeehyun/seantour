<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="header.jsp" %>
<%
if(loginVO.getMbrLogin()!=null){
%>
{
"isLogin":"true",
"name":"<%=loginVO.getMbrNm()%>"
}
<%
}else{
%>
{
"isLogin":"false",
"name":"<%=loginVO.getMbrNm()%>"
}
<%
}
%>