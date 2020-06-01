<%
/**
 *@version 3.2.0.1
 **/
%>
<%
/**************************************************************************************************************************
* Program Name  : ����ĺ��Ǹ�Ȯ�� ��� ���� Sample JSP 
* File Name     : vname_result_seed.jsp
* Comment       : 
* History       :  ������ ���� �׽�Ʈ..........
* 
*     
**************************************************************************************************************************/
%>
<%@ page  contentType = "text/html;charset=ksc5601"%>
<%
	//System.setProperty("file.encoding", "ksc5601");
	String retParam = "";
	if(request.getParameter("param") != null) {
		retParam = request.getParameter("param");
	}
%>
<%@ page import = "java.util.*, java.net.URLDecoder, jnit.cms.property.CmsPropertyController" %>
<% final String deDug = CmsPropertyController.getCmsProperty("Globals.Debug"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta content="text/html; charset=ksc5601" http-equiv="content-type" />
    <title>����ĺ��Ǹ�Ȯ�� ��� ����</title>
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
			var next = "/mbr/signupAdd.jsp";
			
			if( retParam == "signup" ) {
				//opener.location.href="/kr/siteinfo/0009/";
				location.href="/mbr/isMbrSn.do?returnUrl="+returnUrl+"&next="+next;
				
				self.close();
			}

			if( retParam == "fail1" ) {
				opener.fn_login();
				wait(500);
				self.close();
			}

			if( retParam == "fail2" ) {
				opener.fn_login();
				wait(500);
				self.close();
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

	</script>
</head>
<body onload="retPage();">
<%

    // ���� -------------------------------------------------------------------------------------------------------------
    String retInfo  = "";                                                                   // �������    

    String reqNum           = "";                                                           // ��û��ȣ
    String vDiscrNo         = "";                                                           // ����ĺ���ȣ
    String name             = "";                                                           // ����
    String result           = "";                                                           // �Ǹ�Ȯ�� �����
    String discrHash        = "";                                                           // �ߺ�����Ȯ������
	String ciscrHash		= "";                                                           // CI���谪
	String ciVersion        = "";                                                           // CI����	
	String mmdd             = "";                                                           // mmdd	
	String jumin			= "";															//�ֹε�Ϲ�ȣ(��,��,��,���� ����) (���� �ȳ��� 9������ ����)
	String jumin8			= "";
	
	String param1 = "";
	String param2 = "";
	String param3 = "";

	String encPara	= "";
	String encMsg	= "";
	String msgChk       = "N";  
	String addVar	="";
    //-----------------------------------------------------------------------------------------------------------------
    
    //��Ű�� ���� ����
    Cookie[] cookies = request.getCookies();
    String cookiename = "";
    String cookiereqNum = "";
	if(cookies!=null){
		for (int i = 0; i < cookies.length; i++){
			Cookie c = cookies[i];
			cookiename = c.getName();
			cookiereqNum = c.getValue();
			if(cookiename.compareTo("reqNum")==0) break;
			
			cookiereqNum = null;
		}
	}

	if("true".equals(deDug)) System.out.println(cookiereqNum);

	java.util.HashMap<String, String> snAuth = new java.util.HashMap<String, String>();
    try{

        // Parameter ���� --------------------------------------------------------------------
        retInfo  = request.getParameter("retInfo").trim();

        // 1. ��ȣȭ ��� (jar) Loading
        com.sci.v2.comm.secu.SciSecuManager sciSecuMg = new com.sci.v2.comm.secu.SciSecuManager();
        //��Ű���� ������ ���� Key�� ���� �Ѵ�.
        retInfo  = sciSecuMg.getDec(retInfo, cookiereqNum);

        // 2.1�� �Ľ�---------------------------------------------------------------
        int inf1 = retInfo.indexOf("/",0);
        int inf2 = retInfo.indexOf("/",inf1+1);

		encPara  = retInfo.substring(0,inf1);         //��ȣȭ�� ���� �Ķ����
        encMsg   = retInfo.substring(inf1+1,inf2);    //��ȣȭ�� ���� �Ķ������ Hash��

		String  encMsg2   = sciSecuMg.getMsg(encPara);
			// 3.��/���� ���� ---------------------------------------------------------------
        if(encMsg2.equals(encMsg)){
            msgChk="Y";
        }

		if(msgChk.equals("N")){
        %>
		    <script language=javascript>
            alert("���������� �����Դϴ�.!!<%=msgChk%>");
		    </script>
		<%
			return;
		}


        // ��ȣȭ �� ��/���� ���� ---------------------------------------------------------------
		retInfo  = sciSecuMg.getDec(encPara, cookiereqNum);

        String[] aRetInfo = retInfo.split("/");		
		reqNum		= aRetInfo[0];
		vDiscrNo    = aRetInfo[1];
		name		= URLDecoder.decode(aRetInfo[2], "utf-8");
		//name		= aRetInfo[2];
		result		= aRetInfo[3];
		discrHash	= aRetInfo[4];		
		ciscrHash	= aRetInfo[5];		
		ciVersion	= aRetInfo[6];
		mmdd		= aRetInfo[7];
		if(aRetInfo.length == 9){
			jumin		= aRetInfo[8];
			jumin8	= aRetInfo[8].substring(0,8);
		}

		discrHash  = sciSecuMg.getDec(discrHash, cookiereqNum);   //��ȣȭ�� �ߺ�����Ȯ������ �ѹ��� ��ȣȭ
		ciscrHash  = sciSecuMg.getDec(ciscrHash, cookiereqNum);	  //��ȣȭ�� CI���谪 �ѹ��� ��ȣȭ

		
		snAuth.put("param", (retParam.equals("login") ? "si" : retParam));
		snAuth.put("dp", discrHash);
		snAuth.put("sn", vDiscrNo);
		snAuth.put("nm",name);
		snAuth.put("bd", jumin8);
		snAuth.put("authType","si");
		snAuth.put("snRetUrl", request.getParameter("returnUrl") == null ? "/":request.getParameter("returnUrl"));
		session.setAttribute("snAuth", snAuth);
		
		if("true".equals(deDug)) System.out.println(snAuth);

    }catch(Exception ex){
    	if("true".equals(deDug)) System.out.println("[vname] Receive Error -"+ex.getMessage());
    }
%>
</body>
</html>