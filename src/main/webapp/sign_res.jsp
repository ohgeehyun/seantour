<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page language = "java" contentType = "text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="gov.mogaha.gpin.sp.proxy.*" %>
<%@page import="egovframework.com.cmm.service.EgovProperties" %>
<% final String deDug = EgovProperties.getProperty("Globals.Debug"); %>
<%
		
	/* System.out.println(request); */

    /**
     * 이 서비스는 사용자의 주민등록번호와 이용기관에 부여된 이용기관코드(Site Code)를 입력받아 중복가입확인코드를 생성해줍니다.
     * 입력에 사용되는 주민등록번호에 대한 보안에 주의해야합니다.
     */
    
    GPinProxy proxy = GPinProxy.getInstance(this.getServletConfig().getServletContext());
    String rtnDupValue = "";
	String retParam = request.getParameter("retParam");	
	String name = request.getParameter("signname") == null ? "":request.getParameter("signname");
	String retUrl = request.getParameter("retUrl");
	String returnUrl = request.getParameter("returnUrl");
	String cpnum01 = request.getParameter("cpnum01");
	String cpnum02 = request.getParameter("cpnum02");
	String cpnum03 = request.getParameter("cpnum03");
	
	String establishment = "";
	if(cpnum01 != null && cpnum02 != null && cpnum03 != null){
		establishment = cpnum01 + "-" + cpnum02 + "-" + cpnum03;
	}
	if(retUrl != null){
		returnUrl = retUrl;
	}	
    //주민등록번호
    String regNo = "";
	regNo = request.getParameter("regNo") == null ? "":request.getParameter("regNo");
	//사업자번호
	if (regNo.equals("")) regNo = request.getParameter("comNo") == null ? "":"000"+request.getParameter("comNo");
    //사이트
    String siteId = "HFPME35U6XCV";
    if (!regNo.equals("") && !siteId.equals("")) {
        rtnDupValue = proxy.getUserDupValue(regNo, siteId);
    }
	if("true".equals(deDug)) System.out.println("returnUrl : " + request.getParameter("returnUrl"));
	java.util.HashMap<String, String> snAuth = new java.util.HashMap<String, String>();
	snAuth.put("param", (retParam.equals("login") ? "sign" : retParam));
	snAuth.put("dp", rtnDupValue);
	snAuth.put("nm", name);
	snAuth.put("snRetUrl", returnUrl == null ? "/" : returnUrl);
	snAuth.put("signParam","3");
	snAuth.put("authType", "sign");
	snAuth.put("establishment" , establishment == null ? "" : establishment);
	session.setAttribute("snAuth", snAuth);
	
	if("true".equals(deDug)) System.out.println(snAuth);	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="text/html; charset=utf-8" http-equiv="content-type" />
    <title>공인인증서로그인</title>
	<script type="text/javascript">
		function retPage() {			
			var returnUrl = "<%=returnUrl%>";
			var retParam = "<%=retParam%>";			
			var next = "/mbr/signupAdd.jsp";
			if( retParam == "signup" ) {
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
				//var msg=window.open('/kr/siteinfo/0013/','pwbox','width=326,height=250,left=100,top=50');
				//location.href="/kr/siteinfo/0007/";
				location.href="/total_login/sc_login/pw_find/";
			}

			if( retParam == "login" ) {				
				location.replace("/exeLoginAuth.do");
			}
		}

	</script>
</head>
<body onload="retPage();">
</head>
<body>
</body>
</html>