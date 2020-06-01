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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javaScript">
<!--

function fn_egov_view(historyId){	
	var cntId = $('#cntId').val();
	var pageNo = $('#pageIndex').val();
	
	$('#mbrSearch').empty();
	$.ajax({
		type:"POST",
		url:"<c:url value='/disseminate/ajaxHistory.do' />",
		data:"cntId="+cntId+"&pageIndex="+pageNo+"&historyId="+historyId
	}).done(function(data){
		$('#mbrSearch').append(data);
		$('.modal-body').css('max-height','550px');
	});
		
}

// pagination 페이지 링크 function 
function fn_egov_link_page(pageNo){	
   	var cntId = $('#cntId').val();
  	$('#pageIndex').val(pageNo);
   	$('#mbrSearch').empty();
   	$.ajax({
   		type:"POST",
   		url: "<c:url value='/disseminate/ajaxHistory.do' />",
   		data:"cntId="+cntId+"&pageIndex="+pageNo 
   	}).done(function(data){   		
   		$('#mbrSearch').append(data);
   	});
}
//End of pagination 페이지 링크 function

//콘텐츠 버튼 클릭 막기
$(document).ready(function(){
	$("button[id*='contentSatus']").click(function(e){
		e.preventDefault();		
	});	
});
//End 콘텐츠 버튼 클릭 막기

 // -->
</script>


<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
	<input type="hidden" name="historyId" />
	<input type="hidden" name="cntId" id="cntId" value="${cntId }" />
		<table class="table table-bordered">
			<tr>
				<!-- <th>히스토리ID</th> -->
				<th style="width: 30px;">타입</th>
				<th>내용</th>
				<th style="width: 40px;">행위자</th>
				<!-- <th style="width: 70px;">관리</th> -->
				<th style="width: 100px;">콘텐츠상태</th>
				<th style="width: 90px;">배포일</th>
			</tr>
			<c:set var="i" value="1"/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="key" value="Line${i }"/>
			<tr>
				<%-- <td><c:out value="${result.historyId}"/>&nbsp;</td> --%>
				<td>
					<a href="javascript:fn_egov_view('${result.historyId }');" >
						<c:if test="${result.disseminateType == 0 }">
							<c:out value="즉시" />
						</c:if>
						<c:if test="${result.disseminateType == 1 }">
							<c:out value="예약" />
						</c:if>
						<c:if test="${result.disseminateType == 2 }">
							<c:out value="결제" />
						</c:if>
					</a>					
				</td>
				<td>
					<a href="javascript:fn_egov_view('${result.historyId }');" >
						<c:if test="${result.disseminateType == 0 }" >
							<c:out value="없음" />
						</c:if>
						<c:if test="${result.disseminateType == 1 }" >
							<fmt:formatDate value="${result.disseminateDay }" pattern="yyyy-MM-dd" /> 예약 <c:out value="${result.disseminateConfirm == 2 ? '취소' : '' }" />
							<%-- <c:out vlaue="${result.disseminateDay }" /> --%>
						</c:if>
						<c:if test="${result.disseminateType == 2 }" >
							<c:out value="${mbrLineMap[result.historyId] }"/>&nbsp;
						</c:if>				
					</a>
				</td>
				<td>
					<a href="javascript:fn_egov_view('${result.historyId }');" >
					<c:out value="${result.mbrNm}"/>&nbsp;
					</a>
				</td>
				<%-- <td>
					<c:if test="${result.disseminateType == 0 }" >
						<c:if test="${result.disseminateUserconfirm == 3 }">
							<button class="btn btn-success btn-small" id="contentSatus" >완료</button>
						</c:if>
						<c:if test="${result.disseminateUserconfirm == 2 }">
							<button class="btn btn-danger btn-small" id="contentSatus" >취소</button>
						</c:if>
					</c:if>
					<c:if test="${result.disseminateType == 1 }" >
						<c:if test="${result.disseminateUserconfirm == 0 }">
						<button class="btn btn-info btn-small" id="contentSatus">예약신청</button>
						</c:if>
						<c:if test="${result.disseminateUserconfirm == 1 }">
						<button class="btn btn-success btn-small" id="contentSatus">완료</button> 
						</c:if>
						<c:if test="${result.disseminateUserconfirm == 2 }">
						<button class="btn btn-danger btn-small" id="contentSatus">예약취소</button>
						</c:if>
					</c:if>
					<c:if test="${result.disseminateType == 2 }" >
						<c:if test="${result.disseminateUserconfirm == 0 }">
						<button class="btn btn-info btn-small" id="contentSatus">등록</button>
						</c:if>
						<c:if test="${result.disseminateUserconfirm == 1 }">
							<button class="btn btn-success btn-small" id="contentSatus">승인</button>
						</c:if>
						<c:if test="${result.disseminateUserconfirm == 2 }">
							<button class="btn btn-danger btn-small" id="contentSatus">반려</button>
						</c:if>					
						<c:if test="${result.disseminateUserconfirm == 4 }">
							<button class="btn btn-warning btn-small" id="contentSatus">재설정</button>
						</c:if>
						<c:if test="${result.disseminateUserconfirm == 5 }">
							<button class="btn btn-success btn-small" id="contentSatus">강제승인</button>
						</c:if>
						<c:if test="${result.disseminateUserconfirm == 6 }">
							<button class="btn btn-danger btn-small" id="contentSatus">강제반려</button>
						</c:if>
					</c:if>					
				</td> --%>
				<td>
					<c:if test="${result.disseminateType == 0 }" >
						<c:if test="${result.disseminateConfirm == 3 }">
							<button class="btn btn-success btn-small" id="contentSatus" >Complete</button>			<%-- 승인 --%>
						</c:if>
						<c:if test="${result.disseminateConfirm == 2 }">
							<button class="btn btn-danger btn-small" id="contentSatus" >Cancel</button>				<%-- 취소 --%>
						</c:if>						
					</c:if>
					<c:if test="${result.disseminateType == 1 }" >
						<c:if test="${result.disseminateConfirm == 0 }">
						<button class="btn btn-info btn-small" id="contentSatus">Reservation application</button>	<%-- 예약 신청 --%>
						</c:if>
						<c:if test="${result.disseminateConfirm == 1 }">
						<button class="btn btn-success btn-small" id="contentSatus">Complete</button> 				<%-- 완료 --%>
						</c:if>
						<c:if test="${result.disseminateConfirm == 2 }">
						<button class="btn btn-danger btn-small" id="contentSatus">Reservation cancel</button>		<%-- 예약 취소 --%>
						</c:if>
					</c:if>
					<c:if test="${result.disseminateType == 2 }" >
						<c:if test="${result.disseminateConfirm == 0 }">
						<button class="btn btn-info btn-small" id="contentSatus">Progress</button>					<%-- 진행중 --%>
						</c:if>
						<c:if test="${result.disseminateConfirm == 1 }">
						<button class="btn btn-success btn-small" id="contentSatus">Complete</button> 				<%-- 완료 --%>
						</c:if>
						<c:if test="${result.disseminateConfirm == 2 }">
						<button class="btn btn-danger btn-small" id="contentSatus">Return</button>					<%-- 반려 --%>
						</c:if>
						<c:if test="${result.disseminateConfirm == 4 }">
						<button class="btn btn-warning btn-small" id="contentSatus">Reset</button>					<%-- 재설정 --%>
						</c:if>
						<c:if test="${result.disseminateConfirm == 5 }">
						<button class="btn btn-success btn-small" id="contentSatus">Compulsion approval</button> 	<%-- 강제 승인 --%>
						</c:if>
						<c:if test="${result.disseminateConfirm == 6 }">
						<button class="btn btn-danger btn-small" id="contentSatus">Compulsion return</button>		<%-- 강제 반려 --%>
						</c:if>
					</c:if>					
					<%-- <c:out value="${result.disseminateConfirm}"/>&nbsp; --%>
				</td>
				<td>
					<fmt:parseDate var="dateFmt" value="${result.disseminateCreated }" pattern="yyyy-MM-dd HH:mm:ss" />
					<fmt:formatDate value="${dateFmt }" pattern="yyyy-MM-dd HH:mm:ss" />
					<%--<fmt:formatDate value="${result.disseminateCreated }" pattern="yyyy-MM-dd HH:mm:ss"/>
					 <c:out value="${result.disseminateCreated}"/>&nbsp; --%>
				</td>
			</tr>
			<c:set var="i" value="${i+1 }" />
			</c:forEach>
		</table>
	<div id="page_navi" class="pagination">
			<ui:pagination paginationInfo = "${paginationInfo}"
					   type="jnitDefault"
					   jsFunction="fn_egov_link_page"
					   />
			<form:hidden path="pageIndex" id="pageIndex" />
	</div>
	<c:if test="${!empty memoList }">
	<div id="memoDiv">
		<table class="table table-bordered">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>메모내용</th>
			</tr>
			<c:forEach var="memoList" items="${memoList }">
			<tr>
				<td>${memoList.index }</td>
				<td>${memoList.mbrNm }</td>				
				<td>${memoList.memo == 'null' || memoList.memo == '' ? '없음' : memoList.memo  }</td>
			</tr>
			</c:forEach>		
		</table>
	</div>
	</c:if>
			
</form:form>