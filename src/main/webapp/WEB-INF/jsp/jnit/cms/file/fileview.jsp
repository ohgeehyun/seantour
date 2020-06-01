<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<style>

span.linkpath {
	display:block;
}

</style>

<ul class="view_content_btn">
	<li class="reload"><a href="javascript:location.reload();">새로고침</a></li>
</ul>
   
<div class="view">
    <table border="0" cellspacing="0" cellpadding="0" class="table content2_table" summary="<c:out value="${file.name}"/>">
        <caption><c:out value="${file.name}"/></caption>
        <tbody>
            <tr>
                <th width="30%"><font color="red"></font> 파일</th>
                <td>
                	<span class="filename"><c:out value="${file.name}"/></span>
                </td>
                <th width="30%"><font color="red"></font> 크기</th>
                <td>
                	<span class="filesize"><fmt:formatNumber maxFractionDigits="1" minFractionDigits="1" value="${file.size}" />k</span>
                </td>
            </tr>
            <tr>
                <th width="30%"><font color="red"></font> 형식</th>
                <td>
                	<span class="mimetype"><c:out value="${file.mime}"/></span>
                </td>
                <th width="30%"><font color="red"></font> 수정일시</th>
                <td>
                	<span class="filedate"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${file.date}" /></span>
                </td>
            </tr>
            <tr>
                <th width="30%"><font color="red"></font> 링크경로</th>
                <td colspan="3">
                	<span class="linkpath">
                		<a href="<c:url value="${file.linkpath}"/>" target="_blank"><c:url value="${file.linkpath}"/></a>
                	</span>                	
                </td>
            </tr>            
        </tbody>
     </table>
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>