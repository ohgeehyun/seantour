<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/header_ajax.jsp" %>

<script type="text/javascript">
<!--
/* 글 수정 화면 function */

function fn_submit_form() {

	frm = document.getElementById("listForm");

	$.ajax({
		  type: "POST",
		  url: frm.action,
		  data: $("form#listForm").serialize(),
		  success:function(data) {
			  $('div#boardSearch').html(data);
		  },
		  error:function(result) {
			//alert(result);
		  }
	});

	return false;
}

$(document).ready(function(){
	$("[id*='choice']").click(function(e){
		e.preventDefault();
		var contentEdit = $('#contentEdit').val();
		var boardId = $(this).val();
		var boardIds = boardId.split(',');
		var appendList = "<option value="+boardIds[0]+" selected='selected'>"+boardIds[1]+"</option>";
		var appendConfirm = $("#dataBoardIds option[value='"+boardIds[0]+"']").length;
		if(appendConfirm > 0){
			//$('#mbrmessage').append("<button type='button' class='btn btn-danger btn-mini'>이미 등록 되어있습니다.</button>");
			alert("이미 등록 되어있습니다.");
			return false;
		}
		$('#dataBoardIds').append(appendList);
		$('#dataBoardIds').select2();
		$('#myModal').modal('toggle');
	});
});

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/board/searchAjax.do'/>";
	fn_submit_form();
}
function fn_egov_search(){
	 fn_egov_link_page("1");
}
 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post" onsubmit="return fn_submit_form();">
 	<input type="hidden" name="ajaxList" value="Y" />
	<input type="hidden" name="searchCondition" value="1" />
<table border="0" cellspacing="0" width="100%" cellpadding="0" class="table content2_table" summary="관리자 선택" style="color: #000;">
	<caption>관리자 선택</caption>
    <tbody>
        <tr>
            <td valign="top" style="border:0;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
                    <tr>
                        <td width="65%" align="center" style="border:0;"><input name="searchKeyword" value="" type="text" style=" width:95%;" onkeydown="if(event.keyCode == 13) fn_egov_search();"/></td>
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
                                <th align="center">선택</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="result" items="${resultList}" varStatus="status">
                                <tr>
                                    <td align="center"><c:out value="${result.boardId}"/></td>
                                    <td align="center"><c:out value="${result.boardTitle}"/></td>
                                    <td align="center">
                                        <button class="btn btn-mini" value="${result.boardId},${result.boardTitle}" id="choice">선택</button>
                                    </td>
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

<%@ include file="/WEB-INF/jsp/jnit/include/cms/footer.jsp" %>