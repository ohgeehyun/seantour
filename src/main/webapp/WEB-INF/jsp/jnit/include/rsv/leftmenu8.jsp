<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
   	<%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu_top.jsp" %>
    <tr>
    	<td class="lefttitle">코드관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/010701.do">시설물 유형관리</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0108.do">감면율 코드관리</a></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
    	<td class="lefttitle">예약관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">

                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0101.do">시설관리</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/010201.do">예약현황조회</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0103.do">휴무일관리</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0104.do">휴관시설관리</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0105.do">취소요청관리</a></td>
                </tr>
            </table>
        
        </td>
    </tr>
     <tr>
    	<td class="lefttitle">업무관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0301.do">시설물사용대장 1</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0302.do">시설물사용대장 2</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0303.do">사용료 반환 현황</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0304.do">한줄공지 관리</a></td>
                </tr>
            </table>
        </td>
    </tr>
     <tr>
    	<td class="lefttitle">업무일지</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0201.do">업무일지 리스트</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0202.do">업무일지 등록</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0203.do">업무일지 통계</a></td>
                </tr>
            </table>
        
        </td>
    </tr>
     <tr>
    	<td class="lefttitle">감면예약 관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0401.do">감면 예약자조회</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub8/0402.do">감면 예약자등록</a></td>
                </tr>
            </table>
        
        </td>
    </tr>    
    
    <tr>
    	<td class="lefttitle">오류신고 관리</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/rsc" />/JnitrscList.do">오류신고 조회</a></td>
                </tr>
            </table>
        
        </td>
    </tr>
    
</table>