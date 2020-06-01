<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table width="100%" height="46" border="0" cellspacing="0" cellpadding="0" style="background-image:url(<c:url value="/images/egovframework/com/cmm/main" />/bg_header.jpg);">
	<tr>
        <td align="center"><img src="<c:url value="/images/egovframework/com/cmm/main" />/h1_logo.jpg" border="0"></td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td height="25">&nbsp;</td>
        <td height="25" align="right">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td style=" padding-right:20;"><font color="#ffffff"><strong> - <c:out value="${loginVO.mbrNm}"/> 님</strong></font></td>
                    <td style=" padding-right:20;"><a href="<c:url value='/uat/uia/actionLogout.do'/>"><img src="<c:url value="/images/jnit/cms" />/logout.gif" width="50" height="14"></a></td>
                </tr>
            </table>
		</td>
	</tr>
	<tr>
        <td width="176"><a href="<c:url value="/cms/mgrCtl.do" />"><img src="<c:url value="/images/jnit/cms" />/logo.gif"></a></td>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td><a href='<c:url value="/cms" />/sub1/0101.do' onfocus=blur()><img src="<c:url value="/images/jnit/cms" />/menu2_off.gif" border="0" name="image2" OnMouseOut="image2.src='<c:url value="/images/jnit/cms" />/menu2_off.gif';" OnMouseOver="image2.src='<c:url value="/images/jnit/cms" />/menu2_on.gif';"></a></td>
                    <td><img src="<c:url value="/images/jnit/cms" />/topmenu_bar.gif" width="2" height="50"></td>
                    <td><a href='<c:url value="/cms" />/sub2/0101.do' onfocus=blur()><img src="<c:url value="/images/jnit/cms" />/menu1_off.gif" border="0" name="image1" OnMouseOut="image1.src='<c:url value="/images/jnit/cms" />/menu1_off.gif';" OnMouseOver="image1.src='<c:url value="/images/jnit/cms" />/menu1_on.gif';"></a></td>
                    <td><img src="<c:url value="/images/jnit/cms" />/topmenu_bar.gif" width="2" height="50"></td>
                    <td><a href='<c:url value="/cms" />/sub3/0101.do' onfocus=blur()><img src="<c:url value="/images/jnit/cms" />/menu3_off.gif" border="0" name="image3" OnMouseOut="image3.src='<c:url value="/images/jnit/cms" />/menu3_off.gif';" OnMouseOver="image3.src='<c:url value="/images/jnit/cms" />/menu3_on.gif';"></a></td>
                    <td><img src="<c:url value="/images/jnit/cms" />/topmenu_bar.gif" width="2" height="50"></td>
                    <td><a href='<c:url value="/cms" />/sub5/0101.do' onfocus=blur()><img src="<c:url value="/images/jnit/cms" />/menu6_off.gif" border="0" name="image6" OnMouseOut="image6.src='<c:url value="/images/jnit/cms" />/menu6_off.gif';" OnMouseOver="image6.src='<c:url value="/images/jnit/cms" />/menu6_on.gif';"></a></td>
                    <!--td><a href='<c:url value="/cms" />/sub4/0101.do' onfocus=blur()><img src="<c:url value="/images/jnit/cms" />/menu4_off.gif" border="0" name="image4" OnMouseOut="image4.src='<c:url value="/images/jnit/cms" />/menu4_off.gif';" OnMouseOver="image4.src='<c:url value="/images/jnit/cms" />/menu4_on.gif';"></a></td>
                    <!-- td><img src="<c:url value="/images/jnit/cms" />/topmenu_bar.gif" width="2" height="50"></td>
                    <td><a href='<c:url value="/cms" />/sub4/0101.do' onfocus=blur()><img src="<c:url value="/images/jnit/cms" />/menu5_off.gif" border="0" name="image5" OnMouseOut="image5.src='<c:url value="/images/jnit/cms" />/menu5_off.gif';" OnMouseOver="image5.src='<c:url value="/images/jnit/cms" />/menu5_on.gif';"></a></td-->
                </tr>
			</table>
		</td>
	</tr>
    <tr>
    	<td height="4"></td>
    </tr>
</table>