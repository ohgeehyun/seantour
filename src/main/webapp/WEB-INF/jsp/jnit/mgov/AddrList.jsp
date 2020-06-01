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
<script src="<c:url value="/resources/js/jquery.form.js"/> "></script>
<script>
<!--

$(document).ready(function(){
	/*
	$.ajax({
		type:"post",
		url:"<c:url value="/cms/sms/addressbookAjax.do"/>",
		success:function(data){
			$("#ajax").empty();
			$("#ajax").append(data);
		}
	});
	*/
	
	$("#grpTypeAdd").on("click", function(e){
		e.preventDefault();
		
		$("#addrModal").modal("show");
	});
	
	$("#grpAdd").on("click", function(e){
		e.preventDefault();
		
		var grpNm = $("#grpNm").val();
		$("#addrModal").modal("hide");
		$.ajax({
			type:"post",
			url:"<c:url value="/cms/mgov/addrGrpAdd.do"/>",
			data:{
				grpNm:grpNm
			},
			success:function(data){
				window.location.href=window.location.pathname;
			},
			failed:function(){
				alert("주소록 유형 생성 실패");
			}
		});
	});
	
	$("#grpTypeDel").on("click", function(e){
		e.preventDefault();
		
		var grpId = $.trim($("#grpType").val());
		
		if(grpId == ''){
			alert("주소록 유형을 선택해주세요.");
			return false;
		}
		$.ajax({
			type:"post",
			url:"<c:url value="/cms/mgov/addrGrpDel.do"/>",
			data:{
				grpId:grpId
			},
			success:function(data){
				var result = $.trim(data);
				if(result == 'success'){
					alert("주소록 유형이 삭제되었습니다.");
					window.location.href=window.location.pathname;
				}else if(result == 'failed'){
					alert("주소록의 데이터를 모두 삭제하고 그룹을 제거해주세요.");
				}
			},
			failed:function(){
				alert("다시 시도해주세요.");
			}
		});
	});
	
	$("#grpType").on("change", function(e){
		e.preventDefault();
		
		var thisVal = $(this).val();
		$.ajax({
			type:"post",
			url:"<c:url value="/cms/mgov/addrAjax.do" />",
			data:{
				grpId:thisVal
			},
			success:function(data){
				$("#ajax").empty();
				$("#ajax").append(data);
			},
			failed:function(){
				alert("조회 실패");
			}
		});
	});
	
	$("#searchBtn").click(function(e){
		e.preventDefault();

		var chk = $("#searchList").attr('class');
		
		$("#searchBtn").addClass("btn-primary");
		if(chk == 'span6'){
			$("#searchList").slideDown();
			$("#searchList").addClass('on');
			$("#searchBtn").text("회원조회 닫기");
			$("#excelUploadSpace").slideUp();
			$("#excelUpload").removeClass("btn-primary");
			$("#excelUpload").text("엑셀 업로드");
			fileCheckReset();
			$("#searchNm").focus();
		}else{
			$("#searchList").slideUp();
			$("#searchList").removeClass('on');
			$("#searchBtn").removeClass("btn-primary");
			$("#searchBtn").text("회원조회");
		}
		
		
	});
	
	$("[id*=ctgr]").click(function(e){
		e.preventDefault();
		$("[id*=ctgr]").removeClass('btn-primary');
		$(this).addClass('btn-primary');
		
		var choice = $(this).val();
		
		$("[id*='sh']").attr('style', 'display:none');
		
		if(choice == 'name'){
			$("#shNm").attr('style', 'display:block');
			$("#searchOrg").val("");
			$("#searchPhone").val("");
			$("#searchNm").focus();
		}else if(choice == 'org'){
			$("#shOrg").attr('style', 'display:block');
			$("#searchNm").val("");
			$("#searchPhone").val("");
			$("#searchOrg").focus();
		}else if(choice == 'phone'){
			$("#shPhone").attr('style', 'display:block');
			$("#searchNm").val("");
			$("#searchOrg").val("");
			$("#searchPhone").focus();
		}
		
	});
	
	$("#search").click(function(e){
		e.preventDefault();
		
		var searchNm = $("#searchNm").val();
		var searchOrg = $("#searchOrg").val();
		var searchPhone = $("#searchPhone").val();
		
		$.ajax({
			type : "POST",
			url : "<c:url value="/cms/mgov/SearchAjax.do"/>",
			data : {
				searchNm : searchNm,
				searchOrg : searchOrg,
				searchPhone : searchPhone
			}
		}).done(function(data){
			$("#resultTd").empty();
			$("#resultTd").append(data);
			$("#grpTypeAjax").append($("#grpType option").clone());
		});
	});
	
	$("#addrDel").click(function(e){
		e.preventDefault();
		
		var chk = $("[name='chkBox']").is(":checked");
		
		if(chk == true){
			if(confirm("목록에서 제거하시겠습니까?")){
				var url = "<c:url value="/cms/mgov/addrDelProc.do"/>";
				$("#listForm").attr("action", url).submit();
			}
		}else{
			alert("삭제할 번호를 선택해 주세요.");
		}
	});
	
	$("#individualAdd").click(function(e){
		e.preventDefault();
		
		var val = "";
		var nameVal = $("#addrNm").val().replace("-","");
		var thisVal = $("#addrPhone").val();
		var grpId = $.trim($("#grpType").val());
		var frontNum = thisVal.substring(0,3);
		var frontNumOk = new Array("010","011","016","017","018","019");
		
		var chk = true;
		var frontNumChk = false;
		
		var regexNm = /^[a-zA-Z가-힣 ]+$/;
		var regexNum = /^[0-9]+$/;
		var regexNumLength = /^[0-9]{10,11}$/;
		
		if(nameVal == ''){
			alert("성명을 입력해 주세요.");
			$("#addrNm").focus();
			return false;
		}else if(thisVal == ''){
			alert("핸드폰 번호를 입력해주세요.");
			$("#addrPhone").focus();
			return false;
		}else if(grpId == ''){
			alert("주소록 유형을 선택해주세요.");
			$("#grpType").focus();
			return false;
		}
		
		if(!nameVal.match(regexNm)){
			alert("성명란에 문자만 입력 가능 합니다.");
			$("#addrNm").focus();
			return false;
		}else if(!thisVal.match(regexNum)){
			alert("핸드폰 번호 입력시 숫자만 입력 가능 합니다.");
			$("#addrPhone").focus();
			return false;
		}else if(!thisVal.match(regexNumLength)){
			alert("핸드폰 번호 자릿수 10~11까지 가능 합니다.\n현재 자릿수 : "+thisVal.length);
			$("#addrPhone").focus();
			return false;
		}
		
		for(var i=0; i<frontNumOk.length; i++){
			
			if(frontNumOk[i] == frontNum){
				frontNumChk = true;
				break;
			}
			
		}
		if(frontNumChk == false){
			alert("핸드폰 앞번호를 확인해주세요\n010,011,016,017,018,019만 허용 됩니다.");
			return false;
		}
		
		$("[name='chkBox']").each(function(index){
			val = $(this).val().split(",")[1];
			if(thisVal == val){
				alert("기존의 주소록에 이미 존재한 번호 입니다.");
				chk = false;
				return false;
			}
		});
		
		if(chk == true){
			var url = "<c:url value="/cms/mgov/addrAddProc.do"/>";
			$("#listForm").attr("action", url).submit();
		}
		
	});
	
	$("#excelUpload").click(function(e){
		e.preventDefault();
		
		var showChk = $("#excelUploadSpace").css("display");
		if(showChk == 'block'){
			$("#excelUploadSpace").slideUp();
			$("#excelUpload").removeClass("btn-primary");
			$("#excelUpload").text("엑셀 업로드");
			$("#upFile").val("");
			$(".filename").text("선택된 파일 없음");
			$("#excelFileUpload").parent().parent().slideUp();
			fileCheckReset();
		}else{
			$("#searchList").slideUp();
			$("#searchList").removeClass('on');
			$("#searchBtn").removeClass("btn-primary");
			$("#searchBtn").text("회원조회");
			$("#excelUploadSpace").slideDown();
			$("#excelUpload").addClass("btn-primary");
			$("#excelUpload").text("엑셀 업로드 닫기");
		}
	});
	
	$("#excelFileChk").click(function(e){
		e.preventDefault();
		
		var upFile = $("#upFile").val();
		
		if(upFile == ''){
			alert("업로드 할 파일을 선택해주세요.");
			return false;
		}
		$("#listForm").ajaxSubmit({
			url:"<c:url value="/cms/mgov/AddrExcelChk.do"/>",
			success:function(data){
				var strChk = $.trim(data).substring(0,5);
				
				if(strChk == 'ERROR'){
					$("#upFileChk").val("error");
					
					$("#errorModal>.modal-body>p").empty();
					$("#errorModal>.modal-body>p").append(data);
					$("#errorModal").modal('show');
					return false;
				}else{
					$("#upFileChk").val("pass");
					$("#excelFileChk").removeClass("btn-danger");
					$("#fileCompleteModal").modal('show');
					$("#excelFileUpload").parent().parent().slideDown();
				}
			},
			error:function(){
				alert("파일검사 중 문제가 발생했습니다.");
			}
		});
	});
	
	$("#excelFileUpload").click(function(e){
		e.preventDefault();
		
		var grpId = $.trim($("#grpType").val());

		if(grpId == ''){
			alert("주소록 유형을 선택해주세요.");
			$("#grpType").focus();
			return false;
		}
		
		$("#myModal").modal("show");
		var url = "<c:url value="/cms/mgov/AddrExcelUpload.do"/>";
		
		$("#listForm").attr("action", url).submit();
	});
	
	$("#upFile").click(function(){
		fileCheckReset();
	});
	
	$("#duplicate").click(function(){
		fileCheckReset();
	});
	
	function fileCheckReset(){
		var classNm = $("#excelFileChk").attr("class");
		var chk = classNm.indexOf("btn-danger");
		var fileChk = $("#upFileChk").val();
		$("#upFile").val("");
		$(".filename").text("선택된 파일 없음");
		
		if(chk == "-1" || fileChk == "pass"){
			$("#excelFileChk").addClass("btn-danger");
			$("#upFileChk").val("error");
			$("#excelFileUpload").parent().parent().slideUp();
		}
	}
	
	function searchReset(){
		$("#searchNm").val("");
		$("#searchOrg").val("");
		$("#searchPhone").val("");
	}
});

// -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post" enctype="multipart/form-data">
		    <input type="hidden" name="screenMode" />
		    <input type="hidden" name="addrId" />
		    <input type="hidden" id="upFileChk" name="upFileChk" />
			<div class="row-fluid">
	           	<div class="span6">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>SMS 주소록 테이블</h3>
	                       	<%-- <button id="searchBtn" class="btn btn-small">회원조회</button>  --%>
	                       	<button id="excelUpload" class="btn btn-small">엑셀 업로드</button>
	                       	<a href="<c:url value="/excelSample/excelSample.xlsx"/>" class="btn btn-small" target="_blank" title="다운로드" style="float: right;">엑셀 샘플 다운로드</a>
	                    </div>
	                    <div class="widget-title">
	                    	<h3>주소록 유형</h3>
	                    	<select id="grpType" name="grpType">
	                    		<option value=" ">선택해주세요.</option>
	                    		<c:forEach var="result" items="${grpList}" varStatus="status">
		                    		<option value="${result.grpId}">${result.grpNm}</option>
		                    	</c:forEach>
	                    	</select>
	                    	<button class="btn btn-small" id="grpTypeDel" name="grpTypeDel" style="float: right;">유형 삭제</button>
	                    	<button id="grpTypeAdd" class="btn btn-small" style="float: right; margin-right: 10px;">유형 추가</button>
	                    </div>
	                    <table class="table table-bordered table-striped table-hover" summary="SMS 주소록 추가" style="margin-bottom: 0px;">
							<tbody>
								<tr>
									<th>개별추가</th>
									<td>
										<font>성명 : </font><input type="text" id="addrNm" name="addrNm">&nbsp;
										<font>핸드폰 : </font><input type="text" id="addrPhone" name="addrPhone">
										<button id="individualAdd" class="btn btn-small" style="float: rigth; margin-right: 10px;">추가</button>
										<button id="addrDel" class="btn btn-small" style="float: rigth;">삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
	                    <div style="height: 590px; overflow-y:scroll;" >
		                    <div id="ajax" class="widget-content nopadding">
		                    
							</div>
						</div>
					</div>
				</div>
				<div class="span6" id="searchList" style="display:none;">
					<div class="widget-box">
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped th_left" summary="sms 테이블" align="center">
								<tbody>
									<tr>
										<th>회원 조회 <br />
											<strong>!!</strong>&nbsp;핸드폰 앞번호가 <strong>010, 011, 016, 017, 018, 019</strong>를 제외한 번호는 리스트에 나오지 않습니다.
										</th>
									</tr>
									<tr>
										<td>
											<button class="btn btn-primary" id="ctgrName" value="name">성명</button>
											<button class="btn" id="ctgrOrg" value="org">부서</button>
											<button class="btn" id="ctgrPhone" value="phone">전화번호</button>
										</td>
									</tr>
									<tr>
										<td id="shNm" style="display: block;">
											<font>성명 : </font><input type="text" id="searchNm" name="searchNm" style="width: 150px;" /> &nbsp;&nbsp;<font>Ex) 홍길동</font>
										</td>
										<td id="shOrg" style="display: none;">
											<font>부서 : </font><input type="text" id="searchOrg" name="searchOrg" style="width: 150px;" /> &nbsp;&nbsp;<font>Ex) 기타</font>
										</td>
										<td id="shPhone" style="display: none;">
											<font>전화번호 : </font><input type="text" id="searchPhone" name="searchPhone" style="width: 150px;" /> &nbsp;&nbsp;<font>Ex) 1234 or 6789</font>
										</td>
									</tr>
									<tr>
										<td>
											<button id="search" class="btn" style="width: 100%;">검색</button>
										</td>
									</tr>
									<tr id="resultTr">
										<td id="resultTd">
											
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="span6" id="excelUploadSpace" style="display:none;">
					<div class="widget-box">
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped th_left" summary="sms 테이블" align="center">
								<tbody>
									<tr>
										<th>엑셀 업로드</th>
										<td>
											<input type="file" id="upFile" name="upFile" /> <input type="checkbox" id="duplicate" name="duplicate" value="Y" /> <fotn>중복 검사</fotn>
											<button id="excelFileChk" class="btn btn-small btn-danger" style="float: right;">파일 검사</button>
										</td>
									</tr>
									<tr style="display:none;">
										<th>엑셀 파일 등록</th>
										<td><button id="excelFileUpload" class="btn btn-small">엑셀 등록</button></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<%--
			<div id="page_navi" class="pagination">
				<ul>
					<ui:pagination paginationInfo = "${paginationInfo}"
							   type="jnitDefault"
							   jsFunction="fn_egov_link_page"
							   />
					<form:hidden path="pageIndex" />
				</ul>
			</div>
			--%>
		</form:form>
	</div>
</div>
<div id="addrModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-body">
        <font>유형 명 :</font>
        <input type="input" id="grpNm" name="grpNm" />
        <button type="button" class="btn btn-small btn-primary" id="grpAdd" name="grAdd">추가</button>
        <button type="button" class="btn btn-small" data-dismiss="modal">닫기</button>
    </div>
</div>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-body">
        <img alt="loading" src="<c:out value="/images/loading03.gif"/> " style="width: 200px; margin-left: 30%"/><br />
        <font style="text-align: center; margin-left:34%;">주소록 추가 중입니다.</font><br /><br /><br />
        <strong style="color: black; text-align: center; margin-left: 20%;">완료 후 페이지가 새로고침 됩니다.</strong><br />
        <strong style="color: red; text-align: center; margin-left: 20%;">※ 강제로 종료하지 마세요.</strong>
    </div>
</div>
<div id="fileCheckModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-body">
        <img alt="loading" src="<c:out value="/images/loading03.gif"/> " style="width: 200px; margin-left: 30%"/><br />
        <font style="text-align: center; margin-left:34%;">파일 검사중 입니다.</font><br /><br /><br />
    </div>
</div>
<div id="fileCompleteModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h3>엑셀파일 검증 완료<font style="float: right;">(닫기 : x 또는 ESC)</font></h3>
	</div>
    <div class="modal-body">
        <font style="text-align: center; margin-left:34%;"><strong>엑셀파일이 검증되었습니다.</strong></font><br /><br /><br />
    </div>
</div>
<div id="errorModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h3>엑셀파일 핸드폰 번호 중복 리스트<font style="float: right;">(닫기 : x 또는 ESC)</font></h3>
	</div>
	<div class="modal-body">
	    <p style="marin-left: 15%;"></p>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>