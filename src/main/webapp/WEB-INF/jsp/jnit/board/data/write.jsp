<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<c:set var="registerFlag" value="${empty result.dataId ? '등록' : '수정'}"/>
<script type="text/javascript">
function chkSubmit(){
	if($('#dataNm').val() == ''){
		alert('데이터 명을 입력해 주세요.');
		$('#dataNm').focus();
		return false;
	}
	if($('#dataBoardIds').val() == '' || $('#dataBoardIds').val() == null){
		alert('게시판 대상을 선택해 주세요.');
		return false;
	}

}
function goList(){
	$("#saMode").val('list');
	$("#dataId").val('');
	location.href="/jnit/boardData/index.do";
}
function goDelete(){
	if(confirm('정말로 삭제하시겠습니까?')){
		$.ajax({
			type:"post",
			url:"<c:url value='/jnit/boardData/index.do'/>",
			data:{saMode:"deleteAction",dataId:$("#dataId").val()},
			dataType : "json"
		}).done(function(data){
			if(data.isSuccess == true){
				alert("정상처리되었습니다");
				location.href= "<c:url value='?'/>";
			}else{
				alert("삭제에 실패하였습니다.");
			}
		});
	}
}
$(document).ready(function(){

});

function selectPopActive(){
	$("#boardTarget").select2();
}

function open_boardSearch() {
	$('#myModalLabel').empty();
	$('#boardlist').empty();
	$('#boardSearch').empty();
	$('#myModalLabel').append('관리자 검색');
	$('.modal-footer').empty();
	$('.modal-footer').append("<button class='btn' data-dismiss='modal' aria-hidden='true'>닫기</button>");
	$.ajax({
		type : "POST",
		url : "<c:url value='/cms/board/searchAjax.do'/>?ajaxList=Y",
		data : ""
	}).done(function(data){
		$("#boardSearch").append(data);
		$('#myModal').modal('toggle');
	});
}
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                       	<h3>최근게시물 데이터 등록</h3>
						    <a href="#" class="btn" onclick="$('#writeForm').submit();return false;">저장</a>
				          	<a href="#" class="btn" onclick="goList();return false;">목록</a>
				          	<c:if test="${registerFlag == '수정'}" >
				          		<a href="#" class="btn" onclick="goDelete();return false;">삭제</a>
				          	</c:if>
                       </div>
                       <div class="widget-content nopadding">
				        <form id="writeForm" action="<c:url value="/jnit/boardData/index.do" />" method="post" onsubmit="return chkSubmit();">
				        <c:if test="${registerFlag == '등록'}" >
				        	 <input type="hidden" name="retUrl" id="retUrl" value="<c:url value="/jnit/boardData/index.do" />?saMode=list" />
				        </c:if>
				        <c:if test="${registerFlag == '수정'}" >
				        	 <input type="hidden" name="retUrl" id="retUrl" value="<c:url value="/jnit/boardData/index.do" />?saMode=write&dataId=${result.dataId }" />
				        </c:if>
				        <input type="hidden" name="saMode" id="saMode" value="writeAction" />
				        <input type="hidden" name="dataId" id="dataId" value="${result.dataId }" />
				          <div class="table-responsive">
				            <table class="table table-bordered table-striped th_left">
				              <caption>추가수정폼</caption>
				              <colgroup>
				                <col class="tablewidth12"/>
				                <col class="tablewidth38"/>
				                <col class="tablewidth12"/>
				                <col class="tablewidth38"/>
				              </colgroup>
				              <tbody
				                <tr>
				                  <th>데이터 명</th>
				                  <td colspan="3"><input type="text" class="form-input input-xxlarge" id="dataNm" name="dataNm" value="<c:out value="${result.dataNm }" />" /></td>
				                </tr>
				                <tr>
									<th>게시판 대상</th>
										<td>
											<select multiple="multiple" id="dataBoardIds" name="dataBoardIds" class="input-xxlarge">
						                		<c:forEach items="${infoList}" var="target">
						                			<option value="${target.boardId}" selected="selected">${target.boardTitle}</option>
						                		</c:forEach>
						                	</select>
						                	<a href="#none;" id="boardSelect" class="btn" onclick="javascript:open_boardSearch();"><i class="icon-ok-sign"></i>설정</a>

										</td>
									</tr>
								 <tr>
				                  <th>카테고리</th>
				                  <td colspan="3">
									<input type="text" class="form-input input-xxlarge" name="dataCategory" class="dataCategory" title="카테고리" value="${result.dataCategory}" />

				                  </td>
				                 </tr>
				                <tr>
				                  <th>정렬기준</th>
				                  <td colspan="3">
									<select name="dataOrder" class="dataOrder" title="분류">
										<option value="0" <c:out value="${result.dataOrder == '0' ? 'selected' : ''}"/>>기본형</option>
										<option value="1" <c:out value="${result.dataOrder == '1' ? 'selected' : ''}"/>>최근게시물형</option>
										<option value="2" <c:out value="${result.dataOrder == '2' ? 'selected' : ''}"/>>날짜형(내림차순)</option>

									</select>
				                  </td>
				                 </tr>
				                 <tr>
				                  <th>데이터 최대 갯수</th>
				                  <td colspan="3">
									<select name="dataLimit" class="dataLimit" title="분류">
										<option value="1" <c:out value="${result.dataLimit == '1' ? 'selected' : ''}"/>>1</option>
										<option value="2" <c:out value="${result.dataLimit == '2' ? 'selected' : ''}"/>>2</option>
										<option value="3" <c:out value="${result.dataLimit == '3' ? 'selected' : ''}"/>>3</option>
										<option value="4" <c:out value="${result.dataLimit == '4' ? 'selected' : ''}"/>>4</option>
										<option value="5" <c:out value="${result.dataLimit == '5' || result.dataLimit == null ? 'selected' : ''}"/>>5</option>
										<option value="6" <c:out value="${result.dataLimit == '6' ? 'selected' : ''}"/>>6</option>
										<option value="7" <c:out value="${result.dataLimit == '7' ? 'selected' : ''}"/>>7</option>
										<option value="8" <c:out value="${result.dataLimit == '8' ? 'selected' : ''}"/>>8</option>
										<option value="9" <c:out value="${result.dataLimit == '9' ? 'selected' : ''}"/>>9</option>
										<option value="10" <c:out value="${result.dataLimit == '10' ? 'selected' : ''}"/>>10</option>
									</select>
				                  </td>
				                 </tr>

				            </table>
				          </div>
				        </form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel"></h3>
	</div>
	<div class="modal-body">
		<div id="boardSearch"></div>
		<div id="boardlist">

		</div>

		<div id="boardmessage"></div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
		<button class="btn btn-primary">Save changes</button>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>