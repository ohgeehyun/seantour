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
    <title>GPIN - ����� �������� ��� </title>
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
     * Sample-AuthRequest �� ���� ��������� �Ϸ��� session�� ����� ����������� �������� �������Դϴ�.
     * Sample-AuthRequest���� ������������ ������ ���־�� ����Ǹ� �������� �׸��� ���� ������ ���̵带�����Ͻñ�ٶ��ϴ�.
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
