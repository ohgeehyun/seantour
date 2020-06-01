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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jtag" uri="/WEB-INF/tlds/jnittag.tld"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsmbrpackageVO").action = "<c:url value='/cms/mbrPackage/list.do'/>";
   	document.getElementById("jnitcmsmbrpackageVO").submit();		
}

/* 글 등록 function */
function fn_egov_perm_check() {
	
	var thisVal = "";
	$("select[id*='mbr'],select[id*='org'],select[id*='pos'],select[id*='type']").each(function(index){
		thisVal += ($(this).val() == null ? '' : $(this).val()); 
	});
	thisVal = (thisVal == '' ? null : thisVal);
	
	if(thisVal == null){
		return false;
	}else{
		return true;
	}
}

function fn_egov_packageNm_check(){
	var packageNm = $("#packageNm");
	var packageNmVal = packageNm.val();
	packageNmVal = (packageNmVal == '' ? null : packageNmVal); 
	
	if(packageNmVal == null){
		return false;
	}else{
		return true;
	}
}

function fn_egov_save(){
	
	var packageNmVal = fn_egov_packageNm_check();
	var permCheckVal = fn_egov_perm_check();
	
	if(!packageNmVal){
		alert("패키지 명을 입력해주세요.");
		$("#packageNm").focus();
	}else if(!permCheckVal){
		alert("권한을 한개 이상 선택해주세요.");
	}else{
		
		var frm = document.getElementById("jnitcmsmbrpackageVO");
		
		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/mbrPackage/editProc.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/mbrPackage/addProc.do'/>";
		</c:if>
	    frm.submit();
	}
}

$(document).ready(function(){
	
	<%-- 회원 허용 --%>
	$("#mbrAccessAdd").on("click", function(e){
		e.preventDefault();
		
		var target = "mbr";
		var type = "access";
		
		searchAjaxList(target, type);
		$("#modal").modal("show");
	});
	<%-- 회원 차단 --%>
	$("#mbrDenyAdd").on("click", function(e){
		e.preventDefault();
		
		var target = "mbr";
		var type = "deny";
		
		searchAjaxList(target, type);
		$("#modal").modal("show");
	});
	
	<%-- 직급 허용 --%>
	$("#orgAccessAdd").on("click", function(e){
		e.preventDefault();
		
		var target = "org";
		var type = "access";
		
		searchAjaxList(target, type);
		$("#modal").modal("show");
	});
	<%-- 직급 차단 --%>
	$("#orgDenyAdd").on("click", function(e){
		e.preventDefault();
		
		var target = "org";
		var type = "deny";
		
		searchAjaxList(target, type);
		$("#modal").modal("show");
	});
	
	<%-- 부서 허용 --%>
	$("#posAccessAdd").on("click", function(e){
		e.preventDefault();
		
		var target = "pos";
		var type = "access";
		
		searchAjaxList(target, type);
		$("#modal").modal("show");
	});
	<%-- 부서 차단 --%>
	$("#posDenyAdd").on("click", function(e){
		e.preventDefault();
		
		var target = "pos";
		var type = "deny";
		
		searchAjaxList(target, type);
		$("#modal").modal("show");
	});
	
	<%-- 유형 허용 --%>
	$("#typeAccessAdd").on("click", function(e){
		e.preventDefault();
		
		var target = "type";
		var type = "access";
		
		searchAjaxList(target, type);
		$("#modal").modal("show");
	});
	<%-- 회원 차단 --%>
	$("#typeDenyAdd").on("click", function(e){
		e.preventDefault();
		
		var target = "type";
		var type = "deny";
		
		searchAjaxList(target, type);
		$("#modal").modal("show");
	});
	
});


function searchAjaxList(target, type){
	
	$.ajax({
		type:"post",
		url:"<c:url value="/cms/mbrPackage/ajax.do"/>",
		data:{
			target:target,
			type:type
		},
		success:function(data){
			$("#mbrSearch").empty();
			$("#mbrSearch").append(data);
		},
		error:function(){
			alert("failed / " + target + " / " + type);
		}
	});
	
}
//-->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>회원 패키지</h3>
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> <c:out value='${registerFlag}'/></a>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitcmsmbrpackageVO">
							<c:if test="${registerFlag == '수정'}">
								<input type="hidden" name="screenMode" value="up" />
							</c:if>
							<c:if test="${registerFlag == '등록'}">
								<input type="hidden" name="screenMode" value="" />
							</c:if>
							<table class="table table-bordered table-striped th_left" summary="회원패키지 보기">
								<tbody>
									<tr>
										<th style="width: 30%; text-align: center;" colspan="2">패키지 명</th>
										<td>
											<form:input path="packageNm" style="width: 20%;"/>
											&nbsp;<form:errors path="packageNm" />
										</td>
									</tr>
									<tr>
										<th rowspan="3" style="width: 10%; text-align: center;">회원</th>
									</tr>
									<tr>
										<th style="width: 10%; text-align: center;">
											허용<br />
											<button class="btn btn-mini btn-primary" id="mbrAccessAdd" name="mbrAccessAdd">추가</button>
										</th>
										<td>
											<form:select path="mbrAccess" multiple="multiple" style="width:100%;">
												<c:forTokens var="result" items="${jnitcmsmbrpackageVO.mbrAccess}" delims="," varStatus="status">
													<form:option value="${result}" selected="selected">${result}</form:option>
												</c:forTokens>
											</form:select>
										</td>
									</tr>	
									<tr>
										<th style="text-align: center;">
											차단<br />
											<button class="btn btn-mini btn-danger" id="mbrDenyAdd" name="mbrDenyAdd">추가</button>
										</th>
										<td>
											<form:select path="mbrDeny" multiple="multiple" style="width:100%;">
												<c:forTokens var="result" items="${jnitcmsmbrpackageVO.mbrDeny}" delims="," varStatus="status">
													<form:option value="${result}" selected="selected">${result}</form:option>
												</c:forTokens>
											</form:select>
										</td>
									</tr>
									<tr>
										<th rowspan="3" style="width: 10%; text-align: center;">부서</th>
									</tr>	
									<tr>
										<th style="text-align: center;">
											허용<br />
											<button class="btn btn-mini btn-primary" id="orgAccessAdd" name="orgAccessAdd">추가</button>
										</th>
										<td>
											<form:select path="orgAccess" multiple="multiple" style="width:100%;">
												<c:forTokens var="result" items="${jnitcmsmbrpackageVO.orgAccess}" delims="," varStatus="status">
													<form:option value="${result}" selected="selected">${mbrOrgMap[result]}</form:option>
												</c:forTokens>
											</form:select>
										</td>
									</tr>	
									<tr>
										<th style="text-align: center;">
											차단<br />
											<button class="btn btn-mini btn-danger" id="orgDenyAdd" name="orgDenyAdd">추가</button>
										</th>
										<td>
											<form:select path="orgDeny" multiple="multiple" style="width:100%;">
												<c:forTokens var="result" items="${jnitcmsmbrpackageVO.orgDeny}" delims="," varStatus="status">
													<form:option value="${result}" selected="selected">${mbrOrgMap[result]}</form:option>
												</c:forTokens>
											</form:select>
										</td>
									</tr>
									<tr>
										<th rowspan="3" style="width: 10%; text-align: center;">직급</th>
									</tr>
									<tr>
										<th style="text-align: center;">
											허용<br />
											<button class="btn btn-mini btn-primary" id="posAccessAdd" name="posAccessAdd">추가</button>
										</th>
										<td>
											<form:select path="posAccess" multiple="multiple" style="width:100%;">
												<c:forTokens var="result" items="${jnitcmsmbrpackageVO.posAccess}" delims="," varStatus="status">
													<form:option value="${result}" selected="selected">${mbrPosMap[result]}</form:option>
												</c:forTokens>
											</form:select>
										</td>
									</tr>	
									<tr>
										<th style="text-align: center;">
											차단<br />
											<button class="btn btn-mini btn-danger" id="posDenyAdd" name="posDenyAdd">추가</button>
										</th>
										<td>
											<form:select path="posDeny" multiple="multiple" style="width:100%;">
												<c:forTokens var="result" items="${jnitcmsmbrpackageVO.posDeny}" delims="," varStatus="status">
													<form:option value="${result}" selected="selected">${mbrPosMap[result]}</form:option>
												</c:forTokens>
											</form:select>
										</td>
									</tr>
									<tr>
										<th rowspan="3" style="width: 10%; text-align: center;">회원유형</th>
									</tr>
									<tr>
										<th style="text-align: center;">
											허용<br />
											<button class="btn btn-mini btn-primary" id="typeAccessAdd" name="typeAccessAdd">추가</button>
										</th>
										<td>
											<form:select path="typeAccess" multiple="multiple" style="width:100%;">
												<c:forTokens var="result" items="${jnitcmsmbrpackageVO.typeAccess}" delims="," varStatus="status">
													<form:option value="${result}" selected="selected">${mbrTypeMap[result]}</form:option>
												</c:forTokens>
											</form:select>
										</td>
									</tr>	
									<tr>
										<th style="text-align: center;">
											차단<br />
											<button class="btn btn-mini btn-danger" id="typeDenyAdd" name="typeDenyAdd">추가</button>
										</th>
										<td>
											<form:select path="typeDeny" multiple="multiple" style="width:100%;">
												<c:forTokens var="result" items="${jnitcmsmbrpackageVO.typeDeny}" delims="," varStatus="status">
													<form:option value="${result}" selected="selected">${mbrTypeMap[result]}</form:option>
												</c:forTokens>
											</form:select>
										</td>
									</tr>
									<tr>
										<th rowspan="3" style="width: 10%; text-align: center;">설 명</th>
									</tr>
									<tr>
										<td colspan="2">
											<form:textarea path="comment" style="width: 98%;"></form:textarea>
										</td>
									</tr>
								</tbody>
							</table>
							<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
							<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	</div>
	<div class="modal-body">
		<div id="mbrSearch"></div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>