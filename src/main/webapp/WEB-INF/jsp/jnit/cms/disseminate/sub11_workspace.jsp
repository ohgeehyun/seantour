<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${mode == 'pop' }">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<html>	
<head>				
<title>내업무함</title>
<!-- <meta http-equiv="X-UA-Compatible" content="IE=9,10" /> -->
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<c:catch var="e">
<jsp:include page="/${sitePath }/common/config/handing/cssHanding.jsp"></jsp:include>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>"></script>
<jsp:include page="/${sitePath }/common/config/handing/jsHanding.jsp"></jsp:include>
</c:catch>
</c:if>
<script type="text/javascript">
<!--
function fn_egov_confirmPass(disseminateId,cntId,Num){
	if(confirm("정말 결제를 승인 하시겠습니까?")){
		window.open("<c:url value='/disseminate/memo.do'/>?disseminateId="+disseminateId+"&cntId="+cntId+"&Num="+Num+"&anConfirm=1"+"&mode=edit",'contentMemo','scorollbars=yes, resizable=no, width=400, height=280');
	};
}

function fn_egov_cancel(disseminateId,cntId,Num){
	if(confirm("정말 결제를 취소 하시겠습니까?")){
		window.open("<c:url value='/disseminate/memo.do'/>?disseminateId="+disseminateId+"&cntId="+cntId+"&Num="+Num+"&anConfirm=2"+"&mode=edit",'contentMemo','scorollbars=yes, resizable=no, width=400, height=280');
	};
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	var contentPath = "${contentPath}";
	$('#ancategory').val($('#category option:selected').val());
	document.getElementById("myWorkspace").pageIndex.value = pageNo;
	if(contentPath == '' || contentPath == null){
		document.getElementById("myWorkspace").action = "<c:url value='/cms/disseminate/workspace.do'/>";	
	}else{
		document.getElementById("myWorkspace").action = contentPath;
	}
	
   	document.getElementById("myWorkspace").submit();
}
function fn_egov_edit(cntId,siteId) {
	var msg = window.open('<c:url value="/cms/sub11/0101upview.do"/>?cntId='+cntId+"&siteId="+siteId,'editWindow','width=1000,height=850,scrollbars=yes,resizable=yes');	
}
function btnContent(cntId){
	var sitePath = $("#sitePath").val();
	window.open("<c:url value='/disseminate/ajaxHistory.do'/>?cntId="+cntId+"&mode=pop&sitePath="+sitePath,'contentHistory','width=980,height=620,scrollbars=yes,resizable=yes');	
}

$(document).ready(function(){
	var category = "${category}";
	if(category != ''){
		$('#category').val("${category}");
	}	
	
	$('#category').change(function(){
		var contentPath = "${contentPath}";
		$('#pageIndex').val(1);		
		$('#ancategory').val($('#category option:selected').val());		
		frm = document.getElementById("myWorkspace");
		if(contentPath == '' || contentPath == null){
			frm.action = "<c:url value='/disseminate/workspace.do'/>";	
		}else{
			frm.action = contentPath;
		}		
		frm.submit();		
	});	
});
//-->
</script>

<c:if test="${mode == 'pop' }">
</head>
<body>
	<c:if test="${!empty  e}">
		<c:out value="${e }"/>
	</c:if>
</c:if>
<form:form id="myWorkspace" name="myWorkspace" method="post" >
<input type="hidden" name="anDisseminateId" id="anDisseminateId" /> 
<input type="hidden" name="anCntId" id="anCntId" />
<input type="hidden" name="ancategory" id="ancategory" />
<input type="hidden" name="mode" value="${mode }" />
<input type="hidden" name="sitePath" id="sitePath" value="${sitePath }" />

<div class="program_search">
	<select title="진행상황 분류" name="category" id="category" class="MAL5" style="padding:3px;">
		<option value=" " selected="selected">-- 선택하세요 --</option>
		<option value="0">승인대기건</option>
		<option value="1">승인완료건</option>
		<option value="2">반려건</option>							
	</select>		    
</div>
		 	
<table class="bbsList table table-bordered table-hover bbs_distributed" summary="콘텐츠배포의 게시글 목록으로 번호, 메뉴경로, 결제라인, 결제대기자, 콘텐츠상태, 미리보기, 관리로 구성되어 있습니다.">
	<caption>콘텐츠배포</caption>						
	<thead>
       <tr>
           <%-- <th>번호</th> --%>
           <th>메뉴경로</th>
           <th>결제라인</th>
           <th>결제대기자</th>
           <th>콘텐츠상태</th>
           <th>미리보기</th>
           <th>관리</th>
       </tr>				
       </thead>
       <tbody>
       <c:if test="${empty resultlist }" >
       <tr>
       		<td colspan="6" align="center">조회 결과가 없습니다.</td>       		
       </tr>
       </c:if>
		<c:if test="${!empty resultlist }" >					
		<c:forEach var="resultlist" items="${resultlist }" varStatus="status">																								
		<tr>
			<%-- <td>${fn:replace(resultlist.disseminateId,'DISSEMINATE_','') }</td> --%>
			<td>${resultlist.contentPath }</td>
			<td>${dethPathmap[resultlist.disseminateId]}</td>
			<td>${dethStandMap[resultlist.disseminateId]}</td>
			<td>
				<c:if test="${resultlist.contentConfirm == 0 }" >
					<a href="javascript:btnContent('${resultlist.cntId }')"><span class="green_btn">진행중</span></a>				
				</c:if>
				<c:if test="${resultlist.contentConfirm == 1 }" >
					<a href="javascript:btnContent('${resultlist.cntId }')"><span class="blue_btn">완료</span></a>				
				</c:if>
				<c:if test="${resultlist.contentConfirm == 2 }" >
					<a href="javascript:btnContent('${resultlist.cntId }')"><span class="red_btn">반려</span></a>				
				</c:if>
				<c:if test="${resultlist.contentConfirm == 4 }" >
					<a href="javascript:btnContent('${resultlist.cntId }')"><span class="orange_btn">재설정</span></a>				
				</c:if>
				<c:if test="${resultlist.contentConfirm == 5 }" >
					<a href="javascript:btnContent('${resultlist.cntId }')"><span class="green_btn">강제 승인</span></a>				
				</c:if>
				<c:if test="${resultlist.contentConfirm == 6 }" >
					<a href="javascript:btnContent('${resultlist.cntId }')"><span class="red_btn">강제 승인</span></a>				
				</c:if>																		
			</td>
			<td><a href="javascript:fn_egov_edit('${resultlist.cntId }','${resultlist.siteId }')" class="btn02">콘텐츠 확인</a></td>
			<td>
				${dethConfirmMap[resultlist.disseminateId]}																	
			</td>
		</tr>	
		</c:forEach>
		</c:if>
	</tbody>							 						
</table>

<div class="row-fluid board-nav">	
	<ui:pagination paginationInfo = "${paginationInfo}"
			   type="jnitDefault"
			   jsFunction="fn_egov_link_page"
			   />
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }" /> 
	<%-- <form:hidden path="pageIndex" /> --%>
</div>
</form:form>
<c:if test="${mode == 'pop' }">
</body>
</html>
</c:if>