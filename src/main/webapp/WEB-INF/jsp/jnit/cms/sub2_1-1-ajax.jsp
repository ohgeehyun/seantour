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
	
	frm = document.getElementById("listForm");
	
	var contentEdit = $('#contentEdit').val();
	
	$.ajax({
		  type: "POST",
		  url: frm.action,
		  data: $("form#listForm").serialize(),
		  success:function(data) {
			  $('div#mbrSearch').html(data);
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
		var mbr = $(this).val();
		var mbrs = mbr.split(',');
		
		if(contentEdit == 'Y'){
			$('#mbrmessage').empty();					
			var appendList = "<option value="+mbrs[0]+" selected='selected'>"+mbrs[1]+"</option>";		
			var appendConfirm = $("#mbrList option[value='"+mbrs[0]+"']").length;
			
			if(appendConfirm > 0){			
				$('#mbrmessage').append("<button type='button' class='btn btn-danger btn-mini'>이미 등록 되어있습니다.</button>");/* <font color='red'>이미 등록되어 있습니다.</font> */			
				return false;
			}		
			$('#mbrList').append(appendList);
			$('#mbrList').select2();
			$('#myModal').modal('toggle');
		}else if(contentEdit == "minwon1"){
			var ext02 = $("#ext02").val();			
			if(ext02 == mbrs[0]){
				alert("이미 등록 되어있습니다.");
				return false;
			}
			$('#mbrmessage').empty();
			$('#ext01Nm').val(mbrs[1]);
			$('#ext01').val(mbrs[0]);			
			$('#myModal').modal('toggle');			
		}else if(contentEdit == "minwon2"){
			var ext01 = $("#ext01").val();		
			if(ext01 == mbrs[0]){
				alert("이미 등록 되어있습니다.");
				return false;
			}
			$('#mbrmessage').empty();
			$('#ext02Nm').val(mbrs[1]);
			$('#ext02').val(mbrs[0]);			
			$('#myModal').modal('toggle');									
		}else if(contentEdit == "adm1") {			
			var admMbrId2 = $("#admMbrId2").val();
			if(admMbrId2 == mbrs[0]){
				alert("이미 등록 되어있습니다.");				
			}else{				
				$("#admMbrId1").val(mbrs[0]);
				$("#adm01").val(mbrs[2]);				
				$('#myModal').modal('toggle');
			}			
			
		}else if(contentEdit == "adm2") {			
			var admMbrId1 = $("#admMbrId1").val();
			if(admMbrId1 == mbrs[0]){
				alert("이미 등록 되어있습니다.");				
			}else{				
				$("#admMbrId2").val(mbrs[0]);
				$("#adm02").val(mbrs[2]);				
				$('#myModal').modal('toggle');
			}			
			
		}else if(contentEdit == "site") {			
			$("#admMbrId").val(mbrs[0]);
			$("#admMbrText").val(mbrs[2]);				
			$('#myModal').modal('toggle');
		}		
	});
});

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub2/0101.do'/>";
	fn_submit_form();
}

 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post" onsubmit="return fn_submit_form();">
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
                                <option value="13" <c:out value="${searchVO.searchCondition == '13' ? 'selected' : ''}"/>>직급분류명</option>                                
                                <option value="15" <c:out value="${searchVO.searchCondition == '15' ? 'selected' : ''}"/>>유형</option>
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
                                <th align="center">직급분류명</th>
                                <th align="center">유형</th>                                 
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
                                    <td align="center"><c:out value="${result.typeNm}"/></td>
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

<%@ include file="/WEB-INF/jsp/jnit/include/cms/footer.jsp" %>