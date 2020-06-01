<%/** *@version 3.2.0.1 **/%><%
    response.setHeader("Pragma", "no-cache" );
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-store");
    response.setHeader("Cache-Control", "no-cache" );

	session.setAttribute("snRetUrl", request.getParameter("returnUrl"));		String retUrl = "";		String returnUrl = "";	if(request.getParameter("returnUrl") != null){		returnUrl = request.getParameter("returnUrl");	}		String retParam = "";	if(request.getParameter("retParam") != null){		retParam = request.getParameter("retParam");	}		String retType = "";	if(request.getParameter("retType") != null){		retType = request.getParameter("retType");	}		retUrl   = "/total_login/gpin_res.jsp?param="+retParam+"&returnUrl="+returnUrl+"&retType="+retType;			//String retUrl   = "/total_login/gpin_auth.jsp";
%>
<%@ page  contentType = "text/html;charset=utf-8"%>
<%@ page import = "java.util.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>공공I-PIN서비스 서비스 화면</title>
<style>
//<!--
   body,p,ol,ul,td
   {
	 font-family: 굴림;
	 font-size: 12px;   
   } 
   
   a:link { size:9px;color:#000000;text-decoration: none; line-height: 12px}
   a:visited { size:9px;color:#555555;text-decoration: none; line-height: 12px}
   a:hover { color:#ff9900;text-decoration: none; line-height: 12px}

   .style1 {
		color: #6b902a;
		font-weight: bold;
	}
	.style2 {
	    color: #666666
	}
	.style3 {
		color: #3b5d00;
		font-weight: bold;
	}
//-->
</style>

<script language=javascript>  
//<!--
	function Auth() {
		document.AuthForm.action="/G-PIN/Sample-AuthRequest.jsp";
		document.AuthForm.submit();
	}

//-->
</script>

</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0 onLoad="Auth();">

<div style="text-align:center; margin-top:50px;">

<span class="style1">공공I-PIN서비스 요청중 입니다.</span>

</div>
<form name="AuthForm" method="get" action="#">
	<input type="hidden" name="ret" value="<%=retUrl%>">
</form>

</BODY>
</HTML>
