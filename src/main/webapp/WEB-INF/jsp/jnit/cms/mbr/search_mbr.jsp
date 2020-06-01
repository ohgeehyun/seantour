<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */

$(document).ready(function(){
	$("[id*='choice']").click(function(e){		
		e.preventDefault();	
		var mbr = $(this).val();
		var mbrs = mbr.split(',');
		$.ajax({
			type: "POST",
			url: '/ygpa/jnitresult/updateJnitresultAjax.do',
			data: "resultId=${resultId}&adminId="+mbrs[0]+"&adminNm="+mbrs[2]+"&mode=adminSelect"
			}).done(function(data){
			   	
			});
			//window.opener.location.reload();
			window.opener.location.href = "<c:url value='/kr/service/0004/0002/0001/'/>";
			window.close();
		
	});
});

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	frm = document.getElementById("listForm");
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub2/mbrSearch.do'/>";
	frm.submit();
}

 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post" >
    <input type="hidden" name="mbrId" />
 	<input type="hidden" name="screenMode" />
 	<input type="hidden" name="ajax" value="Y" />
 	<input type="hidden" name="pageYn" value="Y" /> 	
 	<input type="hidden" name="resultId" value="${resultId}" />
 	<input type="hidden" id="contentEdit" name="contentEdit" value="${contentEdit }" />
 	
<table border="0" cellspacing="0" width="100%" cellpadding="0" class="table content2_table" summary="관리자 선택" style="color: #000;">
	<caption>관리자 선택</caption>
    <tbody>
        <tr>
            <td valign="top" style="border:0;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
                    <tr>
                        <td width="22%" style="border:0;">
                            <select name="searchCondition">                                
                                <option value="10" <c:out value="${searchVO.searchCondition == '10' ? 'selected' : ''}"/>>이름</option>
                                <option value="9" <c:out value="${searchVO.searchCondition == '9' ? 'selected' : ''}"/>>아이디</option>
                                <option value="11" <c:out value="${searchVO.searchCondition == '11' ? 'selected' : ''}"/>>직급</option>
                                <option value="12" <c:out value="${searchVO.searchCondition == '12' ? 'selected' : ''}"/>>부서명</option>
                                <option value="13" <c:out value="${searchVO.searchCondition == '13' ? 'selected' : ''}"/>>팀명</option>                                
                            </select>
                        </td>
                        <td width="65%" align="center" style="border:0;"><input name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" type="text" style=" width:95%;"/></td>
                        <td width="13%" align="center" style="border:0;vertical-align:middle;"><button class="btn btn-small">검색</button><%--<input type=image src='<c:url value="/resources/img" />/btn_search.gif' align=absmiddle>--%></td>                        
                    </tr>
                </table>
                
                
                </td>
                </tr>
                <tr>
                <td style="border:0;">
                    <table cellspacing="0" cellpadding="0" class="content2_table" style="width:100%;">
                        <thead>
                            <tr>
                                <th align="center">아이디</th>
                                <th align="center">이름</th>
                                <th align="center">직급</th>
                                <th align="center">부서명</th>
                                <th align="center">팀명</th>
                                <th align="center">선택</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="result" items="${resultList}" varStatus="status">
                                <tr>
                                    <td align="center"><c:out value="${result.mbrLogin}"/></td>
                                    <td align="center"><c:out value="${result.mbrNm}"/></td>
                                    <td align="center"><c:out value="${result.posNm}"/></td><%-- <c:out value="${posId_result[result.posId]}"/> --%>
                                    <td align="center"><c:out value="${result.orgNm}"/></td><%-- <c:out value="${orgId_result[result.orgId]}"/> --%>
                                    <td align="center"><c:out value="${result.rankName}"/></td>
                                    <td align="center">
                                        <span class="<c:out value="${result.mbrId}"/>" style="display:none;">
                                        <%-- <c:out value="${orgId_result[result.orgId]}"/> : <c:out value="${result.mbrNm}"/> (<c:out value="${posId_result[result.posId]}"/>) --%>
                                        	<c:out value="${resultMap[result.mbrId] }" />
                                        </span>
                                        <button class="btn btn-mini" value="${result.mbrId},${result.mbrNm},${resultMap[result.mbrId]},${result.tel}" id="choice">선택</button></td>                                        
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>            	
                <div id="page_navi" class="pagination">
						<ui:pagination paginationInfo = "${paginationInfo}"
								   type="jnitDefault"
								   jsFunction="fn_egov_link_page"
								   />
						<form:hidden path="pageIndex" />
				</div>
            </td>
        </tr>
    </thead>
</table>
       

</form:form>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>