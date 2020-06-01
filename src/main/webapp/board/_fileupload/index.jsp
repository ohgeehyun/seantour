<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/cms/fileupload/list.do" flush="false">
	<jsp:param name="fileId"					value="1,2" />
	<jsp:param name="allowedTypes"				value="jpg,png,gif,doc,pdf,zip" />
	<jsp:param name="multiple"					value="true" />
	<jsp:param name="dragDrop"					value="true" />
	<jsp:param name="maxFileCount"				value="1000" />
	<jsp:param name="maxFileSize"				value="500MB" />
</jsp:include>