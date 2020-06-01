<%/** *@version 3.2.0.1 **/%><%@ page language = "java" contentType = "text/html; charset=EUC-KR"%>

<%!
    String getSession(HttpSession session, String attrName)
    {
		return session.getAttribute(attrName) != null ? (String)session.getAttribute(attrName) : "";
    }
%>
<%
	String retParam = "";
	if(request.getParameter("param") != null) {
		retParam = request.getParameter("param");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="text/html; charset=utf-8" http-equiv="content-type" />
    <title>GPIN - 사용자 본인인증 결과 </title>
	<script type="text/javascript">
		function retPage() {
			var retParam = "<%=retParam%>";

			opener.location.href="/exeLoginAuth.do";
			self.close();
		}
	</script>
</head>
<body onload="retPage();">
<%
    /**
     * Sample-AuthRequest 를 통한 사용자인증 완료후 session에 저장된 사용자정보를 가져오는 페이지입니다.
     * Sample-AuthRequest에서 리턴페이지로 지정을 해주어야 연결되며 보여지는 항목의 상세한 내용은 가이드를참조하시기바랍니다.
     */
		java.util.HashMap<String, String> snAuth = new java.util.HashMap<String, String>();
		snAuth.put("param", "gpin");
		snAuth.put("dp", request.getParameter("dupInfo"));
		snAuth.put("sn", request.getParameter("virtualNo"));
		snAuth.put("nm", request.getParameter("realName"));
		session.setAttribute("snAuth", snAuth);

		//if( retParam != null ) {
			session.setAttribute("gpinAuthRetPage", request.getParameter("ret"));
		//}else {
		//	session.setAttribute("gpinAuthRetPage", "Sample-AuthResponse.jsp");
		//}
%>
</body>
</html>
