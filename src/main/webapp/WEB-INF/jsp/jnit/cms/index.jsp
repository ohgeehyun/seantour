<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/header.jsp" %>

<table cellspacing="0" border="0" height="100%" width="100%" cellpadding="0">
    <tr>
    	<td valign="top"  height="1%"><%@ include file="/WEB-INF/jsp/jnit/include/cms/top_menu.jsp" %><%@ include file="/WEB-INF/jsp/jnit/include/cms/top_line.jsp" %></td>
    </tr>
    <tr>
    	<td valign="top">
    		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    			<tr>
                    <td width="175" style="border-right:1px solid #7d7d7d; padding-top:19px;" bgcolor="#fafafa" align="right" valign="top">
                    <%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu0.jsp" %>
                    </td>
    				<td valign="top" style="padding:20px 0 0 0;" align="center">
    				<!--콘텐츠시작-->
    					<img src="<c:url value="/images/jnit/cms/index.jpg" />">
   					 <!--콘텐츠끝-->
    				</td>
                    <td width="5" bgcolor="#fafafa" style="border-left:1px solid #878a8c;">&nbsp;</td>
                    <td width="175" style="border-left:1px solid #a2a2a2;" valign="top"><%@ include file="/WEB-INF/jsp/jnit/include/cms/quick.jsp" %></td>
    			</tr>
    		</table>
    	</td>
    </tr>
    <tr>
    	<td valign="top" height="1%"><%@ include file="/WEB-INF/jsp/jnit/include/cms/bottom.jsp" %></td>
    </tr>
</table>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/footer.jsp" %>