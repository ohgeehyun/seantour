<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<% String retTypeId = request.getParameter("retTypeId"); %>
<c:set var="retTypeId" value="<%= retTypeId %>" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */
function fn_egov_select(mbrId) {
	var retTypeId = "${retTypeId}";
	document.getElementById("listForm").screenMode.value = "up";
    document.getElementById("listForm").mbrId.value = mbrId;    
    document.getElementById("listForm").action = "<c:url value='/cms/sub2/0102upview.do'/>?retTypeId="+retTypeId;
    document.getElementById("listForm").submit();
   	
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	var retTypeId = "${retTypeId}";
	document.getElementById("listForm").screenMode.value = "";	
	document.getElementById("listForm").action = "<c:url value='/cms/sub2/0102.do'/>?retTypeId="+retTypeId;
   	document.getElementById("listForm").submit();		
}

function fn_egov_pwReset(mbrId){
	if(confirm("정말 비밀번호 lock을 해제하시겠습니까?")){
		var retTypeId = "${retTypeId}";
		$("#mbrId").val(mbrId);
		document.getElementById("listForm").action = "<c:url value='/cms/sub2/lock.do'/>?retTypeId="+retTypeId;
		document.getElementById("listForm").submit();
	}
}

function Jnit_confrim(){
	var retTypeId = "${retTypeId}";	
	document.getElementById("listForm").action = "<c:url value='/cms/sub2/0101.do'/>?retTypeId="+retTypeId;
	document.getElementById("listForm").submit();
}

function Jnit_mbrExcel(type){
	var retTypeId = "${retTypeId}";
	$("#excel").val(type);	
	document.getElementById("listForm").action = "<c:url value='/cms/sub2/0101.do'/>?retTypeId="+retTypeId;
	document.getElementById("listForm").submit();
	$("#excel").val("");
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	var retTypeId = "${retTypeId}";
	
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;	
	document.getElementById("listForm").action = "<c:url value='/cms/sub2/0101.do'/>?retTypeId="+retTypeId;
   	document.getElementById("listForm").submit();
}
$(document).ready(function(){
	var retTypeId = "${retTypeId}";
	$('#searchReset').click(function(e){
		e.preventDefault();
		$('#pageIndex').val(1);
		document.getElementById("listForm").action = "<c:url value='/cms/sub2/0101.do'/>?retTypeId="+retTypeId;
		document.getElementById("listForm").submit();
	});
	
	var orgId = "${orgId}";
	if(orgId != ''){
		$("#orgId").val("${orgId}");
	}
		
	$("#orgId").change(function(){
		$('#pageIndex').val(1);		
		document.getElementById("listForm").action = "<c:url value='/cms/sub2/0101.do'/>?retTypeId="+retTypeId;
	   	document.getElementById("listForm").submit();		
	});
	
	$("#totalconfirm").click(function(){
		if($("#totalconfirm").is(":checked")){
			$("input:checkbox[name='confirmList']").attr("checked",true);
			$("input:checkbox[name='confirmList']").parent().addClass("checked");
		}else{
			$("input:checkbox[name='confirmList']").attr("checked",false);
			$("input:checkbox[name='confirmList']").parent().removeClass("checked");
		}
	});
});
 // -->
</script>
<!--콘텐츠시작-->
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		    <input type="hidden" name="mbrId" id="mbrId" />
		 	<input type="hidden" name="screenMode" />
		 	<input type="hidden" name="retTypeId" id="retTypeId" value="${retTypeId }" />
		 	<input type="hidden" name="excel" id="excel" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>회원 리스트</h3>
	                       	<c:if test="${retTypeId != 'lock' }">
	                       		<a href="javascript:fn_egov_addView();" class="btn btn-small"><i class="icon-plus-sign"></i> 추가</a>
	                       	</c:if>
	                       	<c:if test="${retTypeId == 'company' }">
	                       	<a href="javascript:Jnit_confrim();" class="btn btn-small"><i class="icon-plus-sign"></i> 일괄승인</a>
	                       	</c:if>
	                       	
	                    </div>
	                   	<div class="widget-title">	                   		
	                   		<select name="orgId" id="orgId">
	                   				<option value=" " selected="selected">부서전체</option>
		                   			<c:forEach var="orgList" items="${orgList }" varStatus="status">
		                   				<option value="${orgList.orgId }"><c:out value="${orgList.orgNm }"/></option>
		                   			</c:forEach>
	                   		</select>
	                   		<select name="searchCondition">
					       		<option value="9" <c:out value="${searchVO.searchCondition == '9' ? 'selected' : ''}"/>>아이디</option>
					       		<option value="10" <c:out value="${searchVO.searchCondition == '10' ? 'selected' : ''}"/>>이름</option>
					       		<option value="7" <c:out value="${searchVO.searchCondition == '7' ? 'selected' : ''}"/>>전화번호</option>
					       		<option value="15" <c:out value="${searchVO.searchCondition == '15' ? 'selected' : ''}"/>>유형</option>				       		
					       	</select>
	                       	<input type="text" name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
	       					<button class="btn btn-small" id="searchReset"><i class="icon-search"></i> 검색</button>	       					
	                    </div>
	                    <div class="widget-title">
	                    	<a href="javascript:Jnit_mbrExcel('page');" class="btn btn-small"><i class="icon-circle-arrow-down"></i> 현재 리스트 엑셀 다운로드</a>
	       					<a href="javascript:Jnit_mbrExcel('all');" class="btn btn-small"><i class="icon-circle-arrow-down"></i> 선택된 부서 전체 리스트 엑셀 다운로드</a>
	                    </div>	
	                    <div class="widget-content nopadding">
									<table class="table table-bordered table-striped table-hover"summary="회원 리스트">
									<thead>
										<tr>
											<c:if test="${retTypeId == 'company' }">
											<th style="width: 6%;">전체<input type="checkbox" id="totalconfirm" value="1"/></th>
											</c:if>
											<th>CODE</th>
											<th>아이디</th>
											<th>이름</th>
											<th>전화번호/핸드폰/이메일</th>
											<th>부서</th>
											<!-- <th>직급분류명</th>
											<th>직급</th> -->
											<th>사업자번호</th>
											<th>회사명</th>
											<th>직책</th>
											<th>담당업무</th>
											<th>유형</th>
											<th>등록일</th>
											<c:if test="${retTypeId == 'lock' }">
											<th>lock 초기화</th>
											</c:if>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">									 	
										 		<tr>
										 			<c:if test="${retTypeId == 'company' }">
														<td style="text-align: center;"><input type="checkbox" id="confirmList${status.count }" name="confirmList" value="${result.mbrId }" /></td>
													</c:if>
													<td><c:out value="${result.mbrId}"/></td>
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.mbrLogin}"/></a></td>
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.mbrNm}"/></a></td>
													<td>
														<c:if test="${!empty result.tel }"><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.tel}"/></a><br /></c:if>
														<c:if test="${!empty result.mobile }"><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.mobile}"/></a><br /></c:if>
														<c:if test="${!empty result.email }"><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.email}"/></a></c:if>													
													</td>
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.orgNm}"/></a></td>
													<%-- <td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.rankName }"/></a></td>												
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.posNm}"/></a></td> --%>
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.establishment }"/></a></td>
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.groupTitle }"/></a></td>
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.gradeNm }"/></a></td>
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.workContents}"/></a></td>
													<td><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.typeNm}"/></a></td>
													<td><fmt:formatDate value="${result.created }" pattern="yyyy-MM-dd" /></td>
													<c:if test="${retTypeId == 'lock' }">
													<td>
														<c:if test="${result.pwMiscnt > 5 }">
															<a href="javascript:fn_egov_pwReset('<c:out value="${result.mbrId}"/>')" class="btn btn-small">해제</a>
														</c:if>
													</td>
													</c:if>
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
							   jsFunction="fn_egov_link_page"
							   />
					<form:hidden path="pageIndex" />
			</div>
			<c:if test="${retTypeId == 'company' || retTypeId == 'lock'}">
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
									<c:if test="${retTypeId == 'company'}">
										<b>단체 회원가입시. 사업자, 회원 으로 가입 할 경우 승인절차에 의해 관리자가 승인 할 수 있는 기능입니다.</b>
									</c:if>
									<c:if test="${retTypeId == 'lock'}">
										<b>사용자 및 관리자가 내 정보 수정 페이지를 통해 정보를 수정하거나 회원가입할 경우 해당 이력을 볼 수 있는 기능입니다.</b>
									</c:if>
								</td>
							</tr>
							</tbody>
							</table>
						</div>
					</div>
				</div>
			</c:if>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
