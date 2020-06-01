<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page language = "java" contentType = "text/html; charset=utf-8"%>

<%!
    String getSession(HttpSession session, String attrName)
    {
        return session.getAttribute(attrName) != null ? (String)session.getAttribute(attrName) : "";
    }
%>
<%
	String returnUrl = "";
	if(request.getParameter("returnUrl") != null){
		returnUrl = request.getParameter("returnUrl");
	}
	
	String retParam = "";
	if(request.getParameter("param") != null){
		retParam = request.getParameter("param");
	}
	
	String retType = "";
	if(request.getParameter("retType") != null){
		retType = request.getParameter("retType");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="text/html; charset=utf-8" http-equiv="content-type" />
    <title>GPIN</title>
	<script type="text/javascript" src="/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="/js/jquery.plugins/jquery.cookie.js"></script>
	<script type="text/javascript" src="/total_login/common/js/login.js"></script>
	<script type="text/javascript">
var wait = function(msecs) {
	var start = new Date().getTime();
	var cur = start;
	while(cur - start < msecs)
	{
	cur = new Date().getTime();
	}
}

		function retPage() {
			var returnUrl = "<%=returnUrl%>";
			var retParam = "<%=retParam%>";
			var retType = "<%=retType %>";
			var next = "/mbr/signupAdd.jsp";
			
			if( retParam == "signup" ) {
				//kid 기능개발
				location.href="/mbr/isMbrSn.do?returnUrl="+returnUrl+"&next="+next;
			}

			if( retParam == "fail1" ) {
				$('input#mbrLogin').val($.cookie("mbrLogin"));
				$('input#passwd').val($.cookie("passwd"));
				$('form#mbrLoginForm').submit();
				
			}

			if( retParam == "fail2" ) {
				$('input#mbrLogin').val($.cookie("mbrLogin"));
				$('input#passwd').val($.cookie("passwd"));
				$('form#mbrLoginForm').submit();
			}

                        if( retParam == "searchpw" ) {
                                opener.changePw();
                                wait(500);
                                self.close();
                        }

                        if( retParam == "searchid" ) {
                                opener.searchIdRes();
                                wait(500);
                                self.close();
                        }

                        if( retParam == "login" ) {
                                opener.location.href="/exeLoginAuth.do";
                                self.close();
                        }
		}
		var fn_login = function() {
			if(authRet == true) return true;
			authRedirect = $('input#returnUrl').val();
			authProcess();	
			return false;
		}
	</script>
</head>
<body onload="retPage();">
<%
    
	if (request.getRemoteAddr().equals(session.getAttribute("gpinUserIP")))
	{

		java.util.HashMap<String, String> snAuth = new java.util.HashMap<String, String>();
		snAuth.put("param", (retParam.equals("login")  ? "gpin" : retParam));
		snAuth.put("dp", getSession(session, "dupInfo"));
		snAuth.put("sn", getSession(session, "virtualNo"));
		snAuth.put("nm", getSession(session, "realName"));
		snAuth.put("bd", getSession(session, "birthDate"));
		snAuth.put("authType","gpin");
		snAuth.put("retType",request.getParameter("retType") == null ? null : request.getParameter("retType"));	
		snAuth.put("snRetUrl", request.getParameter("returnUrl") == null ? "/" : request.getParameter("returnUrl"));
		session.setAttribute("snAuth", snAuth);

		if( retParam != null ) {
			session.setAttribute("gpinAuthRetPage", request.getParameter("ret"));
		}else {
			session.setAttribute("gpinAuthRetPage", "Sample-AuthResponse.jsp");
		}
	}
%>

<form method="post" id="mbrLoginForm" action="/exeLogin.do" onsubmit="return fn_login();">
	<input type="hidden" name="returnUrl"  id="returnUrl"  value="/" />
	<input name="mbrLogin" id="mbrLogin" type="hidden" />
	<input name="passwd" id="passwd" type="hidden" />
</form>

</body>
</html>
