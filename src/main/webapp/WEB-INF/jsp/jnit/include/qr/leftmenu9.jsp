<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
            <%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu_top.jsp" %>
          </tr>
    <tr>
    	<td class="lefttitle">스킨관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/qr" />/sub9/0101.do">스킨관리</a></td>
                </tr>
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/qr" />/sub9/0101.do">- 리스트</a></td>
                </tr>
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/qr" />/sub9/0101.do?skinMode=WRITE">- 등록</a></td>
                </tr>
            </table>
        
        </td>
    </tr>
    <tr>
    	<td class="lefttitle">데이터관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/qr" />/sub9/0201.do">리스트</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/qr" />/sub9/0201.do?codeMode=WRITE">등록</a></td>
                </tr>
            </table>
        
        </td>
    </tr>
</table>