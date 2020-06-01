<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/jnit.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-responsive.css"/>" />
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.latest.custom.min.js"/> "></script>
<%
	String url= request.getParameter("url");
%>
<script>
function load(){
	var $pJquery = window.parent.$;	
	var dialog = '<div id="dialog" title="페이지 이동중" style="text-align:center;"><br /><br /><img src="<c:url value="/images/loading01.gif"/>" /></div>';
	if($pJquery('#dialog').length>0){
		$pJquery('#dialog').remove();
	}
	$pJquery('body').append(dialog);
	$pJquery('#dialog').dialog({
		modal: true,
		close: function( event, ui ) {
			$pJquery(this).dialog('destroy').remove();
		}
	});
	frm = document.getElementById("loadform");
	frm.action = 'https://accessibility.kr/nia/check.php';
	frm.submit();
}
</script>
<body onLoad="javascript:load();">
	<form action="https://accessibility.kr/nia/check.php" id='loadform' method="post"  class="well">
	<textarea name="url" rows="10" cols="80" style="display: none;"><%= url %></textarea>
	<input type="submit" value="chack" class="btn" style="display: none;"></form>
</body>
