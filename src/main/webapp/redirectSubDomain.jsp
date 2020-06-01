<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="egovframework.com.utl.fcc.service.UrlUtil"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%--

String currentAllUrl = UrlUtil.currentAllUrl(request);
//if(!newUrl.equals(allUrl))out.print(newUrl);

Pattern domainP = Pattern.compile("(.*)suncheon.go.kr");
Matcher domainM = domainP.matcher(currentAllUrl);
String newAllUrl = domainM.replaceFirst("http://www.suncheon.go.kr");
//out.println(currentAllUrl + "::" + newUrl);
if(!currentAllUrl.equals(newAllUrl)){
	//response.sendRedirect(newAllUrl);

}
--%>

<script type="text/javascript">
function goTransfer(tr1,tr2,tr3){
	document.getElementById("ifrmTrans").src = "http://"+tr1 + "?transferUrl="+tr1+"&transferSort="+tr2;
//	window.open("http://"+tr1 + "?transferUrl="+tr1+"&transferSort="+tr2);
}
<%if(request.getParameter("transferUrl") != null && request.getParameter("transferSort") != null){%>
	CSLI_ETGI_TRANS("<%=request.getParameter("transferUrl")%>", "<%=request.getParameter("transferSort")%>", "nourl");
setTimeout(function(){window.close();},5000);
<%}%>
</script>
<iframe id="ifrmTrans" src="about:blank" width="0" height="0" style="display:none;" ></iframe>
