<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>

<script type="text/javascript">
var fn_restore = function(histId) {
	$.ajax({
		url:"<c:url value="/cms/sub7/getHistory.do"/>",
		data:{
			histId:histId
		},
		success:function(data){
			try {
				opener.CodeEditor.setValue($.trim(data));
				self.close();
			}catch(e) {
				//
			}
			
			try {
				$(opener.document.getElementById("cntSrc")).val($.trim(data));
				self.close();
			}catch(e){
				//
			}
			
			try {
				$(opener.document.getElementById("tplSrc")).val($.trim(data));
				self.close();
			}catch(e){
				//
			}
		}
	});
}
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="get">
    <input type="hidden" name="screenMode" />
    <form:hidden path="prefixSiteId"/>
    <form:hidden path="prefixMenuId"/>
    <form:hidden path="prefixCntId"/>
    <input type="hidden" name="searchCondition" value="2" />

<div class="content_view container-fluid">
<!--콘텐츠시작-->
	<br />
    <table class="table" cellpadding="0" cellspacing="0" border="0" summary="콘텐츠 리스트">
        <caption>콘텐츠 리스트</caption>
        <thead>
            <tr>
                <th width="29%">백업일시</td>
               <!--  <th width="15%">콘텐츠 설명</td> -->
                <th width="12%">복원</td>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${resultList}" varStatus="status">
            <tr>
                <td class="listtd" align="left">
                	<fmt:parseDate var="dateFmt" value="${result.created}" pattern="yyyy-MM-dd HH:mm:ss" />
					<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd HH:mm:ss" />
                	<%--<fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd HH:mm:ss" /> --%>
                </td>
               <%--  <td class="listtd"><c:out value="${result.cntDesc}"/></td> --%>
                <td class="listtd">
                <a href="javascript:fn_restore('<c:out value="${result.histId}"/>')">[복원]</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
<!--콘텐츠끝-->
</div>
</form:form>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>
