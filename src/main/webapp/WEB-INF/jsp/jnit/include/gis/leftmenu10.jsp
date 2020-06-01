<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
   	<%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu_top.jsp" %>
    <tr>
    	<td class="lefttitle">카테고리관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/gis" />/sub10/010101.do">대분류관리</a></td>
                </tr>
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/gis" />/sub10/010101.do">- 리스트</a></td>
                </tr>
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/gis" />/sub10/010101.do?ctgryMode=WRITE">- 등록</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/gis" />/sub10/010201.do">소분류관리</a></td>
                </tr>
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/gis" />/sub10/010201.do">- 리스트</a></td>
                </tr>
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/gis" />/sub10/010201.do?ctgryMode=WRITE">- 등록</a></td>
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
                	<td><a href="<c:url value="/gis" />/sub10/0201.do">리스트</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/gis" />/sub10/0201.do?goodsMode=WRITE">등록</a></td>
                </tr>
            </table>
        
        </td>
    </tr>
    <tr>
    	<td class="lefttitle">환경설정</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/gis" />/sub10/0301.do">환경설정</a></td>
                </tr>
            </table>
        
        </td>
    </tr>
</table>