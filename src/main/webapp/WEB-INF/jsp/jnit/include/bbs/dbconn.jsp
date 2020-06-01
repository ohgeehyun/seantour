<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.sql.*, egovframework.com.cmm.service.EgovProperties" %>
<%

Connection conn = null;
Class.forName(
		EgovProperties.getProperty("Globals.DriverClassName")
);
conn = DriverManager.getConnection(
		EgovProperties.getProperty("Globals.Url"),
		EgovProperties.getProperty("Globals.UserName"),
		EgovProperties.getProperty("Globals.Password")
);

%>