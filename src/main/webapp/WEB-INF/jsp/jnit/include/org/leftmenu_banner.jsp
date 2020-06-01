<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
          
<table width="95%" border="0" cellspacing="0" cellpadding="0">
   	<%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu_top.jsp" %>
   	
    <tr>
    	<td class="lefttitle">알리미 그룹 관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/banner/group/list.do" />">그룹 리스트</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/banner/group/add.do" />">그룹 등록</a></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
    	<td class="lefttitle">알리미 아이템 관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/banner/item/list.do" />">아이템 리스트</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/banner/item/add.do" />">아이템 등록</a></td>
                </tr>
            </table>
        </td>
    </tr>
</table>