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

<script type="text/javascript">
<!--
/* 글 수정 화면 function */


function fn_egov_select(ipId) {
    document.getElementById("listForm").ipId.value = ipId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/login/logEdit.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/login/logAdd.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/login/logList.do'/>";
   	document.getElementById("listForm").submit();
}
function fn_save_confirm(){
	var selectType = $('#selectType option:selected').val();
	if(selectType == 0){
		var searchKey = $("#searchKey").val();
		if(searchKey == '' || searchKey == null){
			alert('검색 값을 입력해주시기 바랍니다.');
			$("#searchKey").focus();
			return false;
		}
	}else if(selectType == 1){
		var searchKey = $("#searchKey").val();
		if(searchKey == '' || searchKey == null){
			alert('IP를 입력해주시기 바랍니다.');
			$("#searchKey").focus();
			return false;
		}
	}else if(selectType == 2){
		var searchKey2 = $("#searchKey2").val();
		var searchKey3 = $("#searchKey3").val();
		if(searchKey2 == '' || searchKey2 == null){
			alert('시작 날짜를 입력해주시기 바랍니다.');
			$("#searchKey").focus();
			return false;
		}
		if(searchKey3 == '' || searchKey3 == null){
			alert('종료 날짜를 입력해주시기 바랍니다.');
			$("#searchKey").focus();
			return false;
		}
	}
	return true;
}

$(document).ready(function(){
	$('#searchKey2').datepicker();
	$('#searchKey3').datepicker();
	if(!('${selectType}' == "" || '${selectType}' == null))$('#selectType').val("${selectType}");
	
	
	var selectType = $('#selectType option:selected').val();
	
	if(selectType != 2){
		/* $('#searchKey').show();
		$('#searchKey2').hide(); */
		$('#searchKey').css('display','');
		$('#searchKey2').css('display','none');
		$('#searchKey3').css('display','none');
	}else if(selectType == 2){
		/* $('#searchKey').hide();
		$('#searchKey2').show(); */
		$('#searchKey').css('display','none');
		$('#searchKey2').css('display','');
		$('#searchKey3').css('display','');
	}
	
	$('#selectType').change(function(e){
		e.preventDefault();
		var selectType = $('#selectType option:selected').val();
				
		if(selectType != 2){
			/* $('#searchKey').show();
			$('#searchKey2').hide(); */
			$('#searchKey').css('display','');
			$('#searchKey2').css('display','none');
			$('#searchKey3').css('display','none');
		}else if(selectType == 2){
			/* $('#searchKey').hide();
			$('#searchKey2').show(); */
			$('#searchKey').css('display','none');
			$('#searchKey2').css('display','');
			$('#searchKey3').css('display','');
		}		
	});
	
	$('#searchKeyup').click(function(e){		
		e.preventDefault();		
		if(fn_save_confirm() == true ){
			$("#pageIndex").val("1");
			frm = document.getElementById("listForm");
			frm.action = "<c:url value='/login/logList.do' />";
			frm.submit();
		};		
	});	
});
 // -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		<input type="hidden" name="screenMode" />
		<input type="hidden" name="ipId" />
		
		<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>접속로그</h3>
					</div>
					<div class="widget-title">
						<select name="selectType" id="selectType" >
							<option value=" " selected="selected">전체</option>
							<option value="0">이름</option>
							<option value="1">접속IP</option>
							<option value="2">날짜</option>							
						</select>
						<input type='text' name='searchKey' id='searchKey' value="${searchKey }" />
						<input type='text' name='searchKey2' id='searchKey2' value="${searchKey2 }" style="display: none;" /> - 
						<input type="text" name="searchKey3" id="searchKey3" value="${searchKey3 }" style="display: none;" />
						<button type="button" id="searchKeyup" class="btn btn-small">검색</button>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped table-hover">				
							<thead>	  
								<tr>
									<!-- <th align="center">IpId</th> -->
									<th>이름</th>
									<th>접속IP</th>
									<th>접속일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td><c:out value="${result.mbrNm}"/>&nbsp;</td>
										<td><c:out value="${result.ipAddr}"/>&nbsp;</td>
										<td>											
											<c:if test="${DBType == 'ORACLE' || DBType == 'TIBERO'}" >
												${result.created}											
											</c:if>
											<c:if test="${DBType != 'ORACLE' && DBType != 'TIBERO'}" >
												<fmt:formatDate value="${result.created}" pattern="yyyy-MM-dd HH:mm:ss"/>											
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>										
					</div>
				</div>
			</div>
		</div>
		<div id="page_navi" class="pagination">
				<ui:pagination paginationInfo = "${paginationInfo}"
				   type="jnitDefault"
				   jsFunction="fn_egov_link_page" />
				<form:hidden path="pageIndex" />
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
								<b>본 cms의 관리자 페이지에 접근한 접속로그를 보여줍니다.</b>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>