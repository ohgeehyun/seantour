<%
/**
 *@version 3.2.0.1
 **/
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader("Expires",0); 
if (request.getProtocol().equals("HTTP/1.1")) 
response.setHeader("Cache-Control", "no-cache"); 
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>엑셀파일 업로드</title>
<link rel="stylesheet" href="<c:url value="/images/jnit/cms" />/main.css" type="text/css">

<script type="text/javascript" src='<c:url value="/js/egovframework/com/cmm/jquery-1.4.2.min.js" />'></script>
<script type="text/javascript" src='<c:url value="/js/jquery.form.js" />'></script>
<script type="text/javascript">
var goInsert = function() {

	frm = document.getElementById("menuUp");
	frm.action = "<c:url value='/menu/sub14/upExcel.do'/>";
	
	$("form#menuUp").ajaxSubmit({
		success:function(data){
			if($.trim(data) == "OK") {
				opener.location.reload();
				self.close();
			}
	    }
	});	

}


</script>
</head>
<body style="background:none;">
<form id="menuUp" name="menuUp" method="post" enctype="multipart/form-data">

<table width="500" border="0" cellspacing="0" cellpadding="0" class="content2_table">
  <tr>
    <th>1. 업로드 하고자 하는 엑셀파일을 검색하세요.</th>
  </tr>
  <tr>
    <td>예) 'menuReport.xls'<br/>
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%" style="border:0"><input id="upfile" name="upfile" type="file" style=" width:98%;" escapeXml="true"/></td>
          </tr>
        </table>

    </td>
  </tr>
  <tr id="step3_3">
    <td>
    	<table width="95%" border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 20px 0;">
          <tr>
            <td width="25%" align="center" style="border:0"><a href="#" onclick="goInsert()"><img src="<c:url value="/images/jnit/cms" />/okbut.gif"></a>&nbsp;<a href="#" onclick="window.close();"><img src="<c:url value="/images/jnit/cms" />/cancelbut.gif"></a></td>
          </tr>
        </table>
    </td>
  </tr>


    
</table>
</form>

</body>
</html>