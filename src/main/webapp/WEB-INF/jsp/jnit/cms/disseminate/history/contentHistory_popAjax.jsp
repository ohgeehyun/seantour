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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>콘텐츠 상태</title>

<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<link rel="SHORTCUT ICON" href="/images/ygpashortcut.ico" />
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"/>"/> 
<!--[if IE]>
<link rel="stylesheet" type="text/css" href="/kr/common/css/ie_common.css" />
<![endif]-->
<c:catch var="e">
	<jsp:include page="/${sitePath }/common/config/handing/cssHanding.jsp"></jsp:include>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>
	<jsp:include page="/${sitePath }/common/config/handing/jsHanding.jsp"></jsp:include>
</c:catch>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.ui.latest.custom.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.ui.datepicker-ko.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.ui.timepicker.addon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.js"/>" ></script>
<script type="text/javaScript">
<!--
function fn_egov_view(historyId){
	$("#historyId").val(historyId);
	frm = document.getElementById("listForm");
	frm.action = "<c:url value='/disseminate/ajaxHistory.do'/>";
	frm.submit();		
}

// pagination 페이지 링크 function 
function fn_egov_link_page(pageNo){
  	$('#pageIndex').val(pageNo);	
   	document.getElementById("listForm").action = "<c:url value='/disseminate/ajaxHistory.do' />";
   	document.getElementById("listForm").submit();
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
</head>
<body>
<div id="mwrap">
 	<div id="middle">
    	<div class="m_middle">
    		<div id="contentgroup">            	
                <div class="content">
					<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
					    <input type="hidden" name="screenMode" />
						<input type="hidden" name="historyId" id="historyId" />
						<input type="hidden" name="cntId" id="cntId" value="${cntId }" />
						<input type="hidden" name="mode" id="mode" value="${mode }" />
						<input type="hidden" name="sitePath" id="sitePath" value="${sitePath }" />
							<table class="bbsList table table-bordered table-hover" summary="콘텐츠배포의 히스토리 테이블로 타입, 내용, 행위자, 관리, 콘텐츠상태, 배포일로 구성되어 있습니다.">
							<caption>콘텐츠배포 히스토리</caption>
								<tr>				
									<th style="width: 30px;">타입</th>
									<th>내용</th>
									<th style="width: 40px;">행위자</th>
									<th style="width: 70px;">관리</th>
									<th style="width: 70px;">콘텐츠상태</th>
									<th style="width: 62px;">배포일</th>
								</tr>
								
								<c:forEach var="result" items="${resultList}" varStatus="status">								
								<tr>				
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
									<td>
										<c:if test="${result.disseminateType == 0 }" >
											<c:if test="${result.disseminateUserconfirm == 3 }">
												<span class="green_btn">완료</span>
											</c:if>
											<c:if test="${result.disseminateUserconfirm == 2 }">
												<span class="red_btn">취소</span>
											</c:if>
										</c:if>
										<c:if test="${result.disseminateType == 1 }" >
											<c:if test="${result.disseminateUserconfirm == 0 }">
												<span class="blue_btn">예약신청</span>						
											</c:if>
											<c:if test="${result.disseminateUserconfirm == 1 }">
												<span class="green_btn">완료</span> 
											</c:if>
											<c:if test="${result.disseminateUserconfirm == 2 }">
												<span class="red_btn">예약취소</span>							
											</c:if>
										</c:if>
										<c:if test="${result.disseminateType == 2 }" >
											<c:if test="${result.disseminateUserconfirm == 0 }">						
												<span class="blue_btn">등록</span>
											</c:if>
											<c:if test="${result.disseminateUserconfirm == 1 }">
												<span class="green_btn">승인</span>
											</c:if>
											<c:if test="${result.disseminateUserconfirm == 2 }">
												<span class="red_btn">반려</span>
											</c:if>					
											<c:if test="${result.disseminateUserconfirm == 4 }">
												<span class="orange_btn">재설정</span>
											</c:if>
											<c:if test="${result.disseminateUserconfirm == 5 }">
												<span class="green_btn">강제승인</span>
											</c:if>
											<c:if test="${result.disseminateUserconfirm == 6 }">
												<span class="red_btn">강제반려</span>							
											</c:if>
										</c:if>					
									</td>
									<td>
										<c:if test="${result.disseminateType == 0 }" >
											<c:if test="${result.disseminateConfirm == 3 }">
												<span class="green_btn">완료</span>							
											</c:if>
											<c:if test="${result.disseminateConfirm == 2 }">
												<span class="red_btn">취소</span>							
											</c:if>						
										</c:if>
										<c:if test="${result.disseminateType == 1 }" >
											<c:if test="${result.disseminateConfirm == 0 }">
												<span class="blue_btn">예약신청</span>
											</c:if>
											<c:if test="${result.disseminateConfirm == 1 }">
												<span class="green_btn">완료</span>
											</c:if>
											<c:if test="${result.disseminateConfirm == 2 }">
												<span class="red_btn">예약취소</span>						
											</c:if>
										</c:if>
										<c:if test="${result.disseminateType == 2 }" >
											<c:if test="${result.disseminateConfirm == 0 }">
												<span class="green_btn">진행중</span>
											</c:if>
											<c:if test="${result.disseminateConfirm == 1 }">
												<span class="green_btn">완료</span> 
											</c:if>
											<c:if test="${result.disseminateConfirm == 2 }">
												<span class="red_btn">반려</span>						
											</c:if>
											<c:if test="${result.disseminateConfirm == 4 }">
												<span class="orange_btn">재설정</span>						
											</c:if>
											<c:if test="${result.disseminateConfirm == 5 }">
												<span class="green_btn">강제승인</span>						 
											</c:if>
											<c:if test="${result.disseminateConfirm == 6 }">
												<span class="red_btn">강제승인</span>						
											</c:if>
										</c:if>
									</td>
									<td>
										<fmt:formatDate value="${result.disseminateCreated }" pattern="yyyy-MM-dd"/>	
									</td>
								</tr>								
								</c:forEach>
							</table>
						<div class="row-fluid board-nav">
							<ul>
								<ui:pagination paginationInfo = "${paginationInfo}"
										   type="jnitDefault"
										   jsFunction="fn_egov_link_page"
										   />
								<form:hidden path="pageIndex" id="pageIndex" />
							</ul>
						</div>
						<c:if test="${!empty memoList }">
						<div id="memoDiv">
							<table id="table_memo" class="bbsList table table-bordered table-hover" summary="콘텐츠배포의 히스토리 메모 테이블로 번호, 이름, 메모내용으로 구성되어 있습니다.">
								<caption>콘텐츠배포 히스토리</caption>
								<thead>
								<tr>
									<th>번호</th>
									<th>이름</th>
									<th>메모내용</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="memoList" items="${memoList }">
								<tr>
									<td>${memoList.index }</td>
									<td>${memoList.mbrNm }</td>				
									<td>${memoList.memo == 'null' || memoList.memo == '' ? '없음' : memoList.memo  }</td>
								</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
						</c:if>			
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>