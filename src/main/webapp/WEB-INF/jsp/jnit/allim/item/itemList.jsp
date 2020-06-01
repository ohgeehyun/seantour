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
<title>목록</title>
<%-- <script src="<c:url value="/resources/js/tableDnD.js"/> "></script> --%>
<script type="text/javascript">
<!--
/* ITEM 글 수정 화면 function */
function fn_egov_itemSelect(itemId,groupId) {
    document.getElementById("itemlistForm").itemId.value = itemId;
	document.getElementById("itemlistForm").screenMode.value = "up";
   	document.getElementById("itemlistForm").action = "<c:url value='/cms/allim/itemEdit.do'/>?grpId="+groupId;
   	document.getElementById("itemlistForm").submit();
}

/* ITEM 등록 화면 function */
function fn_egov_itemAddView() {
	var grpId = $('#grpId').val();
	document.getElementById("itemlistForm").screenMode.value = "";
   	document.getElementById("itemlistForm").action = "<c:url value='/cms/allim/itemAdd.do'/>?grpId="+grpId;
   	document.getElementById("itemlistForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("itemlistForm").screenMode.value = "";
	document.getElementById("itemlistForm").pageIndex.value = pageNo;
	document.getElementById("itemlistForm").action = "<c:url value='/cms/allim/itemList.do'/>";
   	document.getElementById("itemlistForm").submit();
}

var grpId = "";
$(document).ready(function(){
	grpId = $('#grpId').val();
	if(grpId != ''){
		var type = $('#type').val();
		var grpId = $('#grpId').val();
		var dragId = "";
		var dropId = "";
		
		$("#itemList01").tableDnD({
			onDragStart:function(table, row){
				dragId=$.tableDnD.serialize();
			},
			onDrop:function(table, row){
				dropId = $.tableDnD.serialize();
					
				if(dragId != dropId){			
				$.ajax({
					type:"POST",
					url:"<c:url value="/cms/allim/sortChange.do"/>",
					data:"itemList01[]="+dropId+"&grpId="+grpId+"&type="+type
				});
				alert('변경 되었습니다.');
				location.href="<c:url value="/cms/allim/groupList.do"/>?type="+type+"&grpId="+grpId;
				
				}
			}
		});
		$('tr').mousedown(function(){
			$(this).attr('style','background-color: gray;');
		});
		$('tr').click(function(){
			$(this).attr('style','cursor: move;');
		});
	}
});

$(document).ready(function(){
	$('#sort').change(function(){
		
		var type = $('#type').val();
		var grpId = $('#grpId').val();
		var active = $(this).val();
		
		location.href="<c:url value="/cms/allim/sortActive.do"/>?type="+type+"&grpId="+grpId+"&active="+active;
	});
	
});

$(document).ready(function(){
	$("[id*='imgView']").click(function(e){
		e.preventDefault();
		
		var value = $(this).val().split(",");
		var itemUrl = value[0];
		var itemId = value[1];
		var grpId = value[2];
		
		$('#select').val(itemId+','+grpId);
		$('.modal-body').empty();
		$('.modal-body').append("<img src="<c:url value="+itemUrl+"/>" >");
		
		$('#myModal').modal('show');
		
	});
	
	$("[id*='ITEM']").click(function(){
		
		var grpId = "${grpId}";
		var style = "";
		
		style = $(this).attr('style');
		if(grpId != ''){
			if(style == null || style == ''){
				alert(grpId);
				$(this).attr("style", "background-color: rgb(143, 74, 74);");
			}else{
				$(this).attr("style", "");
			}
		}
	});
	
	$("[id*='select']").click(function(){
		
		var split = $('#select').val().split(",");
		var itemId= split[0];
		var grpId = split[1];
		$('#myModal').modal('hide');
		fn_egov_itemSelect(itemId,grpId);
		
	});
});

 // -->
</script>
<%-- <c:if test="${groupId != '' && type != 'popup'}">
	<div class="alert alert-info" style="text-align: center">
		<strong>해당 row를 드래그해서 원하는 위치에 이동하시면 정렬순서가 변경 됩니다.</strong>
		<a href="#" data-dismiss="alert" class="close">×</a>
	</div>
</c:if> --%>
<div class="widget-box" style="overflow: auto; height: 582px;">
	<div class="widget-title">
		<h3>아이탬 리스트</h3>
		<a href="<c:url value='/cms/allim/itemAdd.do'/>?grpId=${groupId}&type=${type}" class="btn btn-small"><i class="icon-plus-sign"></i> 추가하기</a>
		
	</div>
	<div class="widget-content nopadding">
		<form:form commandName="searchVO" name="itemlistForm" id="itemlistForm" method="post">
	    <input type="hidden" name="screenMode" />
	    <input type="hidden" name="itemId" />
	    <input type="hidden" id="type" name="type" value="${type}"/>
	    <input type="hidden" id="grpId" name="grpId" value="${groupId}"/>
		<table id="itemList01" class="table table-bordered table-striped table-hover" summary="아이탬 테이블">
			<thead>
				<tr>
					<th style="width: ">갯수</th>
					<th>아이탬 ID</th>
					<%-- <th>아이탬 이미지</th> --%>
					<th>유형</th>
					<c:if test="${groupId != ''}">
						<th>정렬 순서</th>
					</c:if>
					<th>활성화 여부</th>
					<c:if test="${type != 'banner' }">
						<th>시작일</th>
						<th>종료일</th>
					</c:if>	
					<c:if test="${type == 'popup' }">
						<th>팝업 유형</th>
						<th>팝업 넓이</th>
						<th>팝업 길이</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr id="${result.itemId}">
						<td style="text-align: center;">${status.count}</td>
	 					<td style="text-align: center;"><a href="javascript:fn_egov_itemSelect('${result.itemId}','${result.groupId}')"><c:out value="${result.itemId}"/>&nbsp;</a></td>
	 					<%-- <c:if test="${result.itemUrl == null }">
	 						<td><strong>이미지 없음</strong></td>
	 					</c:if>
	 					<c:if test="${result.itemUrl != null }">
	 						<td><button class="btn btn-small" id="imgView" value="<c:out value="${result.itemUrl}"/>,<c:out value="${result.itemId},${result.groupId}"/>">이미지 보기</button></td>
	 						
	 					</c:if> --%>
						<td style="text-align: center;"><c:out value="${result.itemType}"/>&nbsp;</td>
						<c:if test="${groupId != ''}">
							<td style="text-align: center;"><c:out value="${result.itemSort}"/>&nbsp;</td>
						</c:if>
					<c:if test="${result.itemActive == 0}">
						<c:if test="${expire[result.itemId] != true}">
							<td style="text-align: center;">활성화&nbsp;</td>
						</c:if>
						<c:if test="${expire[result.itemId] == true}">
							<td style="color: gray; text-align: center;">기간 만료&nbsp;</td>
						</c:if>
					</c:if>
					<c:if test="${result.itemActive == 1}">
						<td style="color: red; text-align: center;">비활성화&nbsp;</td>
					</c:if>
					<c:if test="${type != 'banner' }">
						<td style="text-align: center;"><c:out value="${result.itemStartdate}"/>&nbsp;</td>
						<td style="text-align: center;"><c:out value="${result.itemEnddate}"/>&nbsp;</td>
					</c:if>
					<c:if test="${type == 'popup' }">
						<td style="text-align: center;"><c:out value="${result.itemMode}"/>&nbsp;</td>
						<td style="text-align: center;"><c:out value="${result.itemWidth}"/>&nbsp;</td>
						<td style="text-align: center;"><c:out value="${result.itemHeight}"/>&nbsp;</td>
					</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<%-- <div id="page_navi">
			<ui:pagination paginationInfo = "${paginationInfo}"
					   type="image"
					   jsFunction="fn_egov_link_page"
					   />
			<form:hidden path="pageIndex" />
		</div> --%>
	</form:form>
	</div>
</div>
<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel" style="text-align: center;">이미지 원본</h3>
	</div>
	<div class="modal-body">
	  
	</div>
	<div class="modal-footer">
		<button class="btn" id="select">수정 하기</button>
		<button class="btn btn-danger" data-dismiss="modal">Close</button>
	</div>
</div>