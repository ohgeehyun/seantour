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
<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>
<script>
function fn_egov_confirmPass(disseminateId,cntId,Num){
	if(confirm("정말 결제를 승인 하시겠습니까?")){
		$('#memo').val('');
		$('.modal-footer').empty();
		$('#myModalLabel').empty();		
		$('#myModalLabel').append("<font color='red'>필요한 내역이 있으시면 써주시기 바랍니다.</font>");
		$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>Close</button>"+
									"<button id='modalConfirm' class='btn btn-primary' onclick='javascript:fn_egov_confirm();'>확인</button>");
		$('#myModal').modal('toggle');
		$('#anDisseminateId').val(disseminateId);
		$('#anCntId').val(cntId);
		$('#anNum').val(Num);
		$('#anConfirm').val(1);
	};
}

function fn_egov_cancel(disseminateId,cntId,Num){
	if(confirm("정말 결제를 취소 하시겠습니까?")){
		$('#memo').val('');
		$('.modal-footer').empty();		
		$('#myModalLabel').empty();		
		$('#myModalLabel').append("<font color='red'>결제취소시엔 결제 사유를 써주시기 바랍니다.</font>");
		$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>Close</button>"+
									"<button id='modalConfirm' class='btn btn-primary' onclick='javascript:fn_egov_confirm();'>확인</button>");
		$('#myModal').modal('toggle');
		$('#anDisseminateId').val(disseminateId);
		$('#anCntId').val(cntId);
		$('#anNum').val(Num);
		$('#anConfirm').val(2);
	};
}

function fn_egov_confirm(){			
	$('#anMemo').val($('#memo').val());	
	frm = document.getElementById("myWorkspace");
	frm.action = "<c:url value='/cms/disseminate/confirm.do' />";
	frm.submit();
}
/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){	
	$('#ancategory').val($('#category option:selected').val());
	document.getElementById("myWorkspace").pageIndex.value = pageNo;
	document.getElementById("myWorkspace").action = "<c:url value='/cms/disseminate/workspace.do'/>";
   	document.getElementById("myWorkspace").submit();
}
function fn_egov_edit(cntId,siteId) {
	var msg = window.open('<c:url value="/cms/sub11/0101upview.do?cntId="/>'+cntId+"&siteId="+siteId,'editWindow','width=1000,height=850,scrollbars=yes,resizable=yes');	
}
$(document).ready(function(){
	$('#category').val("${category}");
	
	$('#category').change(function(){
		$('#pageIndex').val(1);		
		$('#ancategory').val($('#category option:selected').val());
		frm = document.getElementById("myWorkspace");
		frm.action = "<c:url value='/cms/disseminate/workspace.do'/>";
		frm.submit();		
	});
	
	$("button[id*='btnContent']").click(function(e){		
		e.preventDefault();
		$('#myModalLabel').empty();		
		$('.modal-body').empty();
		$('.modal-footer').empty();
		$('#myModalLabel').append("콘텐츠 상태");
		$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>");
		var cntId = $(this).val();
		$.ajax({
			type:"post",
			url:"<c:url value='/cms/disseminate/ajaxHistory.do'/>",
			data:"cntId="+cntId		
		}).done(function(data){			
			$('.modal-body').append("<div id='mbrSearch'></div>");
			$('#mbrSearch').append(data);
		});		
		$('#myModal').modal('toggle');
	});
});
</script>


<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form id="myWorkspace" name="myWorkspace" height="100%" method="post" >
		<input type="hidden" name="anDisseminateId" id="anDisseminateId" /> 
		<input type="hidden" name="anCntId" id="anCntId" />
		<input type="hidden" name="anNum" id="anNum" />
		<input type="hidden" name="anConfirm" id="anConfirm" />		
		<input type="hidden" name="anMemo" id="anMemo" />
		<input type="hidden" name="ancategory" id="ancategory" />
		<!-- Contents Start -->
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
				 	<div class="widget-title">
				 		<h3>콘텐츠 배포 결제관리</h3>
				 		<select name="category" id="category">
				 			<option value=" ">--선택하세요--</option>
							<option value="0">승인대기건</option>
							<option value="1">승인완료건</option>
							<option value="2">반려건</option>							
						</select>
				 	</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">						
							<tr>
								<th>번호</th>
								<th>메뉴경로</th>
								<th>결제라인</th>
								<th>결제대기자</th>
								<th>콘텐츠상태</th>
								<th>미리보기</th>
								<th>관리</th>
							</tr>
							<c:set var="i" value="1"/>						
							<c:forEach var="resultlist" items="${resultlist }" varStatus="status">
							<c:set var="key" value="key${i}"/>
							<c:set var="confirm" value="confirm${i}"/>
							<c:set var="stand" value="stand${i}"/>																							
							<tr>
								<td>${fn:replace(resultlist.disseminateId,'DISSEMINATE_','') }</td>
								<td>${resultlist.contentPath }</td>
								<td>${dethPathmap[key]}</td>
								<td>${dethStandMap[stand]}</td>
								<td>
									<c:if test="${resultlist.contentConfirm == 0 }" >
										<button id="btnContent" class="btn btn-info btn-small" value="${resultlist.cntId }" >진행중</button>
									</c:if>
									<c:if test="${resultlist.contentConfirm == 1 }" >
										<button id="btnContent" class="btn btn-success btn-small" value="${resultlist.cntId }" >완료</button>
									</c:if>
									<c:if test="${resultlist.contentConfirm == 2 }" >
										<button id="btnContent" class="btn btn-danger btn-small" value="${resultlist.cntId }">반려</button>
									</c:if>
									<c:if test="${resultlist.contentConfirm == 4 }" >
										<button id="btnContent" class="btn btn-danger btn-small" value="${resultlist.cntId }">재설정</button>
									</c:if>
									<c:if test="${resultlist.contentConfirm == 5 }" >
										<button id="btnContent" class="btn btn-success btn-small" value="${resultlist.cntId }" >강제 승인</button>
									</c:if>
									<c:if test="${resultlist.contentConfirm == 6 }" >
										<button id="btnContent" class="btn btn-danger btn-small" value="${resultlist.cntId }">강제 반려</button>
									</c:if>																		
								</td>
								<td><a href="javascript:fn_egov_edit('${resultlist.cntId }','${resultlist.siteId }')" class="btn btn-default btn-small">콘텐츠 확인</a><%-- <button class="btn btn-default btn-small">콘텐츠확인</button>--%></td>
								<td>
									${dethConfirmMap[confirm]}	
																
									<%-- <c:if test="${resultlist.contentConfirm == 2 }" >
										<button id="btnContent" class="btn btn-warning btn-small" value="${resultlist.cntId }">대기중</button>
									</c:if>	 --%>														
								</td>
							</tr>
							<c:set var="i" value="${i+1 }"/>
							</c:forEach>							 						
						</table>
					</div>						
				</div>						
			</div>
		</div>
		<div id="page_navi" class="pagination">
				<ui:pagination paginationInfo = "${paginationInfo}"
						   type="jnitDefault"
						   jsFunction="fn_egov_link_page"
						   />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }" />		   
				<%-- <form:hidden path="pageIndex" /> --%>
		</div>
		<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    <h3 id="myModalLabel"><font color="red">결제취소시엔 결제 사유를 써주시기 바랍니다.</font></h3>
		  </div>
		  <div class="modal-body">		  	
		    <textarea id="memo"name="memo" rows="8" style="width: 300px;"></textarea> 
		  </div>
		  <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
		    <button id="modalConfirm" class="btn btn-primary" onclick="javascript:fn_egov_confirm();">확인</button>
		  </div>
		</div>
		</form:form>	
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>