<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "jnit.cms.*, jnit.com.util.IpFilterUtil"%>
<%
	/* JNITCMS IP Filter */
	String remoteAddr = request.getRemoteAddr();
	String securityRetUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
	//cms ip Access Check
	if(!IpFilterUtil.isPass()){
		out.print("<script type=\"text/javascript\"> alert(\"접근권한이 없습니다.\\n("+remoteAddr+")\");\n/* " + remoteAddr + " */ location.href='"+securityRetUrl+"';  </script>");
		return;
	}
%>