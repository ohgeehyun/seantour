<%
/**
 *@version 3.2.0.1
 **/
%>
<%
/**************************************************************************************************************************
* Program Name  : 가상식별실명확인 요청 Sample JSP (Real)  
* File Name     : vname_sample_seed.jsp
* Comment       : 
* History       : 
*
**************************************************************************************************************************/
%>
<%
	request.setCharacterEncoding("utf-8");
    response.setHeader("Pragma", "no-cache" );
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-store");
    response.setHeader("Cache-Control", "no-cache" );
%>
<%@ page  contentType = "text/html;charset=utf-8" %>
<%@ page import = "java.util.*,  jnit.cms.property.CmsPropertyController" %>
<% final String deDug = CmsPropertyController.getCmsProperty("Globals.Debug"); %>
<%

	java.util.Date today = new java.util.Date();
    String id       = "CSF001"; //request.getParameter("id");                              // 가상식별실명확인 회원사 아이디
    String srvNo    = "001022"; //request.getParameter("srvNo");                            // 가상식별실명확인 서비스번호    
	//srvNo = "058001";
    String reqNum   = String.valueOf( today.getTime() ); //request.getParameter("reqNum");                           // 가상식별실명확인 요청번호
	String exVar    = "0000000000000000";                                       // 복호화용 임시필드
    String retUrl   = "22http://www.suncheon.go.kr/total_login/si_res.jsp?param="+request.getParameter("retParam")+"&returnUrl="+(request.getParameter("returnUrl") == null ? "/" : request.getParameter("returnUrl")); // 가상식별실명확인 결과수신 URL
    //retUrl   = "22http://bwmt.jnit.kr/kr/si_res.jsp?param="+request.getParameter("retParam"); // 가상식별실명확인 결과수신 URL

	/**
		*
		* reqNum 값은 최종 결과값 복호화를 위한 SecuKey로 활용 되므로 중요합니다.
		* reqNum 은 실명 확인 요청시 항상 새로운 값으로 중복 되지 않게 생성 해야 합니다.
		* 쿠키 또는 Session및 기타 방법을 사용해서 reqNum 값을 
		* vname_result_seed.jsp에서 가져 올 수 있도록 해야 함.
		* 샘플을 위해서 쿠키를 사용한 것이므로 참고 하시길 바랍니다.
		*
		*/
        Cookie c = new Cookie("reqNum", reqNum);
        //c.setMaxAge(120);  // <== 필요시 설정(초단위로 설정됩니다)
        response.addCookie(c);

    //01. 암호화 모듈 선언
	com.sci.v2.comm.secu.SciSecuManager seed  = new com.sci.v2.comm.secu.SciSecuManager();

	//02. 1차 암호화
	String encStr = "";
	String reqInfo      = id+"/"+srvNo+"/"+reqNum+"/"+exVar;  // 데이터 암호화
	encStr              = seed.getEnc(reqInfo, "");

	//03. 위변조 검증 값 생성
	com.sci.v2.comm.secu.hmac.SciHmac hmac = new com.sci.v2.comm.secu.hmac.SciHmac();
	String hmacMsg = hmac.HMacEncript(encStr);

	//03. 2차 암호화
	reqInfo  = seed.getEnc(encStr + "/" + hmacMsg + "/" + "0000000000000000", "");  //2차암호화


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>가상식별실명확인 서비스 화면</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
    var CBA_window; 

    function openCBAWindow(){ 
       // CBA_window = window.open('', 'CbaV2Window_test', 'width=410, height=450, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=100, top=50' );

        /*if(CBA_window == null){ 
			 alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
        }*/

        document.reqCBAForm.action = 'https://name.siren24.com/vname/jsp/vname_j10.jsp';
		document.reqCBAForm.submit();
        //document.reqCBAForm.target = 'CbaV2Window_test';
    }

//-->
</script>

</head>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0 onLoad="openCBAWindow();">

<div style="text-align:center; margin-top:50%;">

<span class="style1">가상식별실명확인서비스 요청중 입니다.</span>

</div>
<!--
<table cellpadding=1 cellspacing=1>    
    <tr>
        <td align=center>회원사아이디</td>
        <td align=left><%=id%></td>
    </tr>
    <tr>
        <td align=center>서비스번호</td>
        <td align=left><%=srvNo%></td>
    </tr>
    <tr>
        <td align=center>요청번호</td>
        <td align=left><%=reqNum%></td>
    </tr>    
    <tr>
        <td align=center>&nbsp</td>
        <td align=left>&nbsp</td>
    </tr>
    <tr width=100>
        <td align=center>요청정보(암호화)</td>
        <td align=left>
            <%=reqInfo.substring(0,50)%>...
        </td>
    </tr>
    <tr>
        <td align=center>결과수신URL</td>
        <td align=left><%=retUrl%></td>
    </tr>
</table>
-->
<!-- 가상식별실명확인서비스 요청 form --------------------------->
<form name="reqCBAForm" method="post" action="#">  
    <input type="hidden" name="reqInfo"     value = "<%=reqInfo%>">
    <input type="hidden" name="retUrl"      value = "<%=retUrl%>">
</form>
<!--End 가상식별실명확인서비스 요청 form ----------------------->
<!--
<br>
<br>
	<table width="450" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="130"><a href=http://www.siren24.com/v2alimi/comm/jsp/v2alimiAuth.jsp?id=SIR005&svc_seq=01 target=blank><img src="/name/images/logo01.gif" width="122" height="41" border=0></a></td>
        <td width="320"><span class="style2">본 사이트는 서울신용평가정보(주)의 <span class="style3">명의도용방지서비스</span> 협약사이트 입니다. 타인의 명의를 도용하실 경우 관련법령에 따라 처벌 받으실 수 있습니다.</span></td>
      </tr>
    </table>
      <br>
      <br>
    <br>
  이 Sample화면은 가상식별실명확인서비스 요청화면 개발시 참고가 되도록 제공하고 있는 화면입니다.<br>
  <br>
</center>
-->
</BODY>
</HTML>
