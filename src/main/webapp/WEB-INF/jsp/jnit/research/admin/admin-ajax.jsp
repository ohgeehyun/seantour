<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/header_ajax.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */

function fn_submit_form() {

	frm = document.getElementById("ajaxForm");
	
	var contentEdit = $('#contentEdit').val();
	
	$.ajax({
		  type: "POST",
		  url: frm.action,
		  data: $("form#ajaxForm").serialize(),
		  success:function(data) {
			  $('div#mbrSearch').html(data);
		  },
		  error:function(result) {
			//alert(result);
		  }
	});
	
	return false;
}

function fn_egov_select_check(mbrId){
	$.ajax({
		type:"POST",
		data:"mbrId="+mbrId,
		url:"<c:url value='/cms/admin/ajax.do'/>"
		}).done(function(data){
			var json = $.parseJSON(data);
			if(json.adminId != ''){
				alert("이미 등록된 회원입니다.");
				return false;
			}else{
				document.getElementById("ajaxForm").mbrId.value = mbrId;    
				document.getElementById("ajaxForm").screenMode.value = "up";
				document.getElementById("ajaxForm").action = "<c:url value='/cms/admin/addadminProc.do'/>";
				document.getElementById("ajaxForm").submit();
			}
		});
}


function fn_egov_select(mbrId) {
	if(confirm("등록하시겠습니까?")){
		fn_egov_select_check(mbrId);
		/*
		if(fn_egov_select_check(mbrId)){
			document.getElementById("ajaxForm").mbrId.value = mbrId;    
			document.getElementById("ajaxForm").screenMode.value = "up";
			document.getElementById("ajaxForm").action = "<c:url value='/cms/admin/addadminProc.do'/>";
			document.getElementById("ajaxForm").submit();
		}
		*/
	}
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("ajaxForm").screenMode.value = "";
	document.getElementById("ajaxForm").pageIndex.value = pageNo;
	document.getElementById("ajaxForm").action = "<c:url value='/cms/admin/addView.do'/>";
	fn_submit_form();
}



 // -->
</script>

<form:form commandName="searchVO" name="ajaxForm" id="ajaxForm" method="post" onsubmit="return fn_submit_form();">
    <input type="hidden" name="mbrId" />
 	<input type="hidden" name="screenMode" />
 	<input type="hidden" name="ajax" value="Y" />
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
                            </select>
                        </td>
                        <td width="65%" align="center" style="border:0;"><input name="searchKeyword" value="" type="text" style=" width:95%;"/></td>
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
                                    <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.mbrId }"/>');" class="btn btn-small">선택</a></td>                                        
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
    </tbody>
</table>
       

</form:form>

<%@ include file="/WEB-INF/jsp/jnit/include/cms/footer.jsp" %>