<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<% String type = request.getParameter("type"); %>
<c:set var="type" value="<%= type %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javaScript" language="javascript" defer="defer">

/* 글 수정 화면 function */
$(document).ready(function(e){
	$("[id*='grpEdit']").click(function(e){
		e.preventDefault();
		var grpId = $(this).val();
		document.getElementById("listForm").groupId.value = grpId;
		document.getElementById("listForm").screenMode.value = "up";
	   	document.getElementById("listForm").action = "<c:url value='/cms/allim/groupEdit.do'/>?grpId="+grpId;
	   	document.getElementById("listForm").submit();
	});
});

/* 글 등록 화면 function */
function fn_egov_addView() {
	var grpId = $('#grpId').val();
	var type = "${type}";
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/allim/groupAdd.do'/>?grpId="+grpId+"&type="+type;
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/allim/groupList.do'/>";
   	document.getElementById("listForm").submit();
}

/* 아이템리스트 function */
function fn_egov_listView(groupId) {
	var type = $('#type').val();
	$.ajax({
		type: "POST",
		url: "<c:url value="/cms/allim/itemList.do"/>",
		data: "grpId="+groupId+"&type="+type
	}).done(function(data){
		$('.view_content2').empty();
		$('.view_content2').append(data);
	});
}

/* 코드발급 */
function codeOpen(groupId,groupCategory){
	var type = $('#type').val();
	
	$.ajax({
		type:"POST",
		url:"<c:url value="/cms/allim/controllerCode.do"/>",
		data:"groupId="+groupId+"&type="+type+"&groupCategory="+groupCategory
	}).done(function(data){
		$('.modal-body').empty();
		$('.modal-body').append(data);
		$('.modal-footer').empty();
		$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>");
	});		
	$('#myModal').modal();
}

$(document).ready(function(){
	$("[id*='codeCopy']").click(function(e){
		e.preventDefault();		
		$('#groupId').val($(this).val());
		$('.modal-body').empty();
		$('.modal-body').append("<table class='table table-bordered'>"+
									"<tr>"+
										"<th>디자인유형</th>"+
										"<td>"+
											"<select id='groupCategory' name='groupCategory'>"+
												"<option value='기본'>기본</option>"+
												"<option value='allimNosize'>기본(allimNosize)</option>"+
												"<option value='allimIcon'>allimIcon</option>"+
												"<option value='allimIconbanner'>allimIconbanner</option>"+
												"<option value='allimPopupVisual'>allimPopupVisual</option>"+
												"<option value='allimAnimateVisual'>allimAnimateVisual</option>"+
											"</select>"+
										"</td>"+
									"</tr>"+
									"<tr>"+
										"<th>그룹명</th>"+
										"<td><input type='text' id='groupTitleCopy' name='groupTitleCopy'></td>"+
									"</tr>"+
								"</table>");		
		$('.modal-footer').empty();
		$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>"+
			    				  "<button class='btn btn-primary' onClick='javascript:goCopy();'>복사</button>");
		$('#myModal').modal();	
	});
	
	var grpId = "${grpId}";
	if(grpId != ''){
		var type = $('#type').val();
		$.ajax({
			type: "POST",
			url: "<c:url value="/cms/allim/itemList.do"/>",
			data: "grpId="+grpId+"&type="+type
		}).done(function(data){
			$('.view_content2').empty();
			$('.view_content2').append(data);
		});
	}
	
});

function goCopy(groupId){
	if(confirm('정말 복사하시겠습니까?')){
		var groupCategory = $('#groupCategory option:selected').val();
		var groupTitleCopy = $('#groupTitleCopy').val();
		frm = document.getElementById('listForm');
		frm.action = "<c:url value='/cms/allim/groupCopy.do'/>?groupCategory="+groupCategory+"&groupTitleCopy="+groupTitleCopy;
		frm.submit();
		
	}
}
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<div class="list_content2">
			<%-- Contents Start --%>
			<div class="row-fluid">
	           	<div class="span5">
	               	<div class="widget-box">
	                   	<div class="widget-title">
							<h3>그룹 리스트</h3>
							<a href="<c:url value="/cms/allim/groupAdd.do"/>?grpId=${grpId}&type=${type}" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>
	                    </div>
	                    <div class="widget-content nopadding" style="overflow: auto; height: 582px;">
							<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
							    <input type="hidden" name="screenMode" />
							    <input type="hidden" id="groupId" name="groupId" />
							    <input type="hidden" name="grpId" value="${grpId}" />
							    <input type="hidden" id="type" name="type" value="${type}" />
							    <input type="hidden" name="searchCondition" id="searchCondition" value="">
								<input type="hidden" name="searchKeyword" id="searchKeyword" value="">
								<table class="table table-bordered table-striped table-hover" summary="그룹 테이블">
									<thead>
										<tr>
											<th align="center">그룹 ID</th>
											<th align="center">그룹 명</th>
											<c:if test="${type == 'banner'}">
												<th align="center">배너방향</th>
											</c:if>
											<th>Import코드</th>
											<th>수정</th>
											<c:if test="${type == 'allim'}">
											<th>복사</th>
											</c:if>
											<th>디자인유형</th>
										</tr>
										</thead>
										<tbody>		
											<c:forEach var="result" items="${resultList}" varStatus="status">
											<c:set var="Direction1" value="${result.groupDirection == '1' ? 'left' : ''}" />
											<c:set var="Direction2" value="${result.groupDirection == '2' ? 'right' : ''}" />
											<c:set var="Direction3" value="${result.groupDirection == '3' ? 'top' : ''}" />
											<c:set var="Direction4" value="${result.groupDirection == '4' ? 'bottom' : ''}" />
											<tr>
												<td align="center" class="listtd"><a href="javascript:fn_egov_listView('<c:out value="${result.groupId}"/>');">${result.groupId}&nbsp;</a></td>
												<td align="center" class="listtd"><a href="javascript:fn_egov_listView('<c:out value="${result.groupId}"/>');"><c:out value="${result.groupNm}"/>&nbsp;</a></td>
												<c:if test="${type == 'banner'}">
													<td align="center" class="listtd"><a href="javascript:fn_egov_listView('<c:out value="${result.groupId}"/>');">${Direction1 }${Direction2 }${Direction3 }${Direction4 }&nbsp;</a></td>
												</c:if>
												<%-- <td align="center" class="listtd"><button id="codeOpen" class="btn btn-mini" value="<c:out value="${result.groupId}"/>">Code Open</button></a></td> popup으로 --%>
												<td align="center" class="listtd"><a href="javascript:codeOpen('${result.groupId}','${result.groupCategory }')" class="btn btn-mini" >Code Open</a></td> <%-- popup으로 --%>												
												<td  align="center" class="listtd"><button id="grpEdit" class="btn btn-mini" value="<c:out value="${result.groupId}"/>">수정</button></td>
												<c:if test="${type == 'allim'}">
												<td align="center" class="listtd"><button id="codeCopy" class="btn btn-mini" value="<c:out value="${result.groupId}"/>">복사</button></a></td> <%-- popup으로 --%>
												</c:if>
												<td align="center" class="listtd"><c:out value="${result.groupCategory}"/></td> <%-- popup으로 --%>
											</tr>
											</c:forEach>
									</tbody>
								</table>
							</form:form>
						</div>
					</div>
				</div>
				<div class="span7">
					<div class="view_content2">
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<div class="widget-box">
					<div class="widget-content nopadding cmstipbox">
						<table class="table table-bordered table-striped th_left">
						<caption>cms TIP</caption>
						<tbody>
						<tr>
							<th colspan="2">
								<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
							</th>
							<td>
								<c:if test="${ type == 'allim'}">
									<b>알리미 형태의 시스템을 추가/수정/삭제 할수 있는 페이지입니다.</b>
								</c:if>
								<c:if test="${ type == 'banner'}">
									<b>배너 형태의 시스템을 추가/수정/삭제 할수 있는 페이지입니다.</b>
								</c:if>
								<c:if test="${ type == 'popup'}">
									<b>팝업 형태의 시스템을 추가/수정/삭제 할수 있는 페이지입니다.</b>
								</c:if>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel" style="text-align: center;">알리미 코드</h3>
  </div>
  <div class="modal-body">
    
  </div>
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal">Close</button>
  </div>
</div>
<%--
<div id="page_navi">
	<ui:pagination paginationInfo = "${paginationInfo}"
			   type="image"
			   jsFunction="fn_egov_link_page"
			   />
	<form:hidden path="pageIndex" />
</div>
--%>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>