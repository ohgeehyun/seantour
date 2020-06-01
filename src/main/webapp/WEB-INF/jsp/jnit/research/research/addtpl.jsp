<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>
<jsp:include page="../../../../../edit/tinymce/edit.jsp" />
<script type="text/javascript">
<!--

function fn_egov_save_check(){	
	var category =$("#category").val();
	var check = "";
	
	var ansNm = $('input[name=researchNm]').val();
	if(ansNm.length >1000){
		alert("설문제목의 글자수는 1000자를 넘을수 없습니다.");
		$(this).focus();
		check = "false";
		return false;
	}
	
	/* 
	if(category == null || category == ''){
		alert("카테고리를 선택해 주시기 바랍니다.");
		$("#category").focus();
		check = "false";
		return false;		
	}
	 */

	$('input[name*=fileWidth]').each(function(){
		var fileW = $(this).val();
		if(fileW>1000){
			alert("이미지의 가로값은 1000을 넘길 수 없습니다.");
			check = "false";
			$(this).focus();
			return false;
		}
		if(fileW.match(/^[0-9]+$/) == null){
			alert("이미지 크기값에는 숫자만 들어갈수 있습니다.");
			$(this).focus();
			check = "false";
			return false;
		}
	});
	
	$('input[name*=fileHeight]').each(function(){
		var fileH = $(this).val();
		if(fileH>1000){
			alert("이미지의 세로값은 1000을 넘길 수 없습니다.");
			$(this).focus();
			check = "false";
			return false;
		}
		if(fileH.match(/^[0-9]+$/) == null){
			alert("이미지 크기값에는 숫자만 들어갈수 있습니다.");
			$(this).focus();
			check = "false";
			return false;
		}
	});
	
	$('input[name*=questionNm]').each(function(){
		var queNm = $(this).val();
		if(queNm.length >4000){
			alert("질문의 글자수는 4000자를 넘을수 없습니다.");
			$(this).focus();
			check = "false";
			return false;
		}
	});
	
	$('input[name*=answerNm]').each(function(){
		var ansNm = $(this).val();
		if(ansNm.length >4000){
			alert("답의 글자수는 4000자를 넘을수 없습니다.");
			$(this).focus();
			check = "false";
			return false;
		}
	});
	
	$('input[name*=ansoptNum]').each(function(){
		var ansoptN = $(this).val();
		if(ansoptN != ""){
			if(ansoptN.match(/^[0-9\,]/) == null){
				alert("활성화설정의 답변입력란에는 숫자와 콤마를 제외한 문자는 입력하실 수 없습니다.");
				$(this).focus();
				check = "false";
				return false;
			}
		}
	});
	
	$('input[name*=ansoptMove]').each(function(){
		var ansoptM = $(this).val();
		if(ansoptM != ""){
			if(ansoptM.match(/^[0-9]/) == null){
				alert("활성화설정의 답변입력란에는 숫자를 제외한 문자는 입력하실 수 없습니다.");
				$(this).focus();
				check = "false";
				return false;
			}
		}
	});
	
	$('input[name*=answerCnt]').each(function(){
		var answerCnt = $(this).val();
		if(answerCnt != ""){
			if(answerCnt.match(/^[0-9]+$/) == null){
				alert("멀티개수의 입력란에는 숫자를 제외한 문자는 입력하실 수 없습니다.");
				$(this).focus();
				check = "false";
				return false;
			}
		}
	});
	
	var counttpl = $('#countaddtpl').val();
	if(counttpl.match(/^[0-9]/) == null){
		alert("질문 생성 개수에는 숫자만 입력 가능합니다.");
		$(this).focus();
		check = "false";
		return false;
	}
	
	if(check == ""){
		return true;
	}else{
		return false;
	}
		
	return true;
}
/* 글 등록 function */
function fn_egov_save() {
	if(confirm("등록하시겠습니까?")){
		if(fn_egov_save_check()){
			$("#tempmode").val("true");
			var frm = document.getElementById("jnitresearchVO");
			frm.action = "<c:url value='/cms/research/addtplProc.do'/>";
			frm.submit();
		}
	}
}

function fn_egov_cancel(){
	if(confirm("등록을 취소하시겠습니까?")){
		window.close();
	}
}

$(document).ready(function(){

 // 삭제버튼 클릭시
    $(document).delegate(".delbtn", "click", function(){
    	
        var clickedRow = $(this).parent().parent().parent().parent().parent().parent();
        	clickedRow.remove();
    });
    
});

function delAnswerBtn(ansNum){
	var row = $(".answer"+ansNum);
	var rowimg = $(".answerimg"+ansNum);
	row.remove();
	rowimg.remove();
};
	
var countanswerFields = 0;
function addAnswerBtn(){
	var ansCount = 1;
	var oldAnsCount = $("#example").find('input[name^=answerNm]').length;
		ansCount = ansCount + oldAnsCount;
		
	var ansNum = countanswerFields+1;
	 var html="<tr class = 'answer"+ ansNum +"'>" +
	 "<th rowspan='5'>답변"+ansCount+"<input type='button' id='delans' value='삭제' class='btn btn-danger btn-mini' onclick='javascript:delAnswerBtn("+ ansNum +")'/></th>" +
	 "</tr>" +
	 "<tr class = 'answer"+ ansNum +"'>" +
     "<td width='106px' id = 'answer"+ ansNum +"'>답변</td>" + 
     "<td>" + 									
     "<input name='answerNm" + ansNum + "' type='text' style='width:99%;' title='해당 질문에 대한 답변을 입력해 주세요.'>" +
     "</td></tr>" + 
     "<tr class = 'answerimg"+ ansNum +"'><td width='106px'>답변 이미지 첨부</td>" +
	 "<td><input name='upimg" + ansNum + "' type='file' style='width:99%;'>" +
	 "이미지 가로 : <input type='text' name='fileWidth" + ansNum + "' id='fileWidth" + ansNum + "' value='75' />" + 
	 "이미지 세로 : <input type='text' name='fileHeight" + ansNum + "' id='fileHeight" + ansNum + "' value='75' />" + 
	 "</td></tr>" +
     "<tr class='answer"+ ansNum +"'><td width='106px'></td>" +
     "<td><div style='display:inline;' class='tool'><input type='checkbox' name='criterionOpt" + ansNum + "' id='criterionOpt" + ansNum + "' value='1'/><span class='critertip'>결과보기 엑셀 다운로드 후<br/>척도계산을 위한 기능입니다.</span></div> 척도설정" +
	 "<input type='text' name='criterionCnt" + ansNum + "' id='criterionCnt" + ansNum + "' value='0' /> 점" +
     "</td></tr>" +
	 "<tr class='answer"+ ansNum +"'><td width='106px'></td>" +
	 "<td><input type='checkbox' name='ansopt" + ansNum + "' id='ansopt" + ansNum + "' value='1' onclick='javascript:addAnsOption("+ansNum+");' />문항설정" +
	 "<div id='addAnsoptOption" + ansNum + "' style='display:none;'>&nbsp; &nbsp; &nbsp; &nbsp;-활성화설정 : 해당답변 선택시 " +
	 "<input type='text' name='ansoptNum" + ansNum + "' id='ansoptNum" + ansNum + "' value='${ansResult.ansoptNum}' /> 번 질문 " + 
	 "<input type='radio' name='ansoptVisible" + ansNum + "' id='ansoptVisible" + ansNum + "' value='0' checked=\"checked\" />활성화 " +
	 "<input type='radio' name='ansoptVisible" + ansNum + "' id='ansoptVisible" + ansNum + "' value='1' />비활성화" +
	 "<br />&nbsp; &nbsp; &nbsp; &nbsp;-이동설정 :   해당답변 선택시 " +
	 "<input type='text' name='ansoptMove" + ansNum + "' id='ansoptMove" + ansNum + "' value='' /> 번 질문으로 이동" +
	 "</div></td></tr>";
				        
	        
	        $("#question").append(html);
	        
	        $("#countanswerFields").val(countanswerFields+1);
	        countanswerFields = parseInt($("#countanswerFields").val());
	                
	        
};

function selecttype(v){
	if(v == 0){
		$("#ordercheck").removeAttr("disabled");
		$("#questionOrder").css("display","");
		$("#questionMulti").css("display","none");
		$("#questionSubjec").css("display","none");
	}else if(v == 1){
		$("#questionMulti").css("display","");
		$("#ordercheck").removeAttr("disabled");
		$("#questionOrder").css("display","");
		$("#questionSubjec").css("display","none");
	}else{
		$("#questionMulti").css("display","none");
		$("#ordercheck").attr("disabled",true);
		$("#questionOrder").css("display","none");
		$("#questionSubjec").css("display","");
	}
}
function ansOption(){
	if($("#ansopt").is(":checked")){
		$("#ansoptOption").css("display","");
	}else{
		$("#ansoptOption").css("display","none");
	}
}
function addAnsOption(Anum){
	if($("#ansopt"+Anum).is(":checked")){
		$("#addAnsoptOption"+Anum).css("display","");
	}else{
		$("#addAnsoptOption"+Anum).css("display","none");
	}
}


// -->
</script>
<style>

.tool{
	position: relative;
}

.tool .tip{
	visibility: hidden;
	width: 200px;
	height: auto;
	background-color: #555;
	color: #fff;
	text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    position: absolute;
    z-index: 1;
    bottom: 125%;
    left: 50%;
    margin-left: -100px;
    opacity: 0;
    transition: opacity 1s;
}
.tool .tip::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #555 transparent transparent transparent;
}

.tool:hover .tip {
    visibility: visible;
    opacity: 1;
}
.tool .critertip{
	visibility: hidden;
	width: 200px;
	height: auto;
	background-color: #555;
	color: #fff;
	text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    position: absolute;
    z-index: 1;
    bottom: 125%;
    left: 50%;
    margin-left: -100px;
    opacity: 0;
    transition: opacity 1s;
}
.tool .critertip::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #555 transparent transparent transparent;
}

.tool:hover .critertip {
    visibility: visible;
    opacity: 1;
}
</style>

	<div id="content" style="margin-left:0; margin-top:30px">
		<div class="content_view container-fluid">
			<form:form commandName="jnitresearchVO" name="jnitresearchFrom" enctype="multipart/form-data">
				<input type="hidden" name="countanswerFields" id="countanswerFields" value="0" />
				<input type='hidden' name='questionId' id ='questionId'/>
				<input type="hidden" name="queSize" id="queSize" value="${queSize}" />
				<input type='hidden' name="ansSize" id ="ansSize" value="${ansSize}"/>
				<input type='hidden' name='researchId' id='researchId' value="${jnitresearchVO.researchId}" />
				<input type="hidden" name="tempmode" id="tempmode" value="" />
				<div class="row-fluid">
					<div class="span12">
						<div class="widget-box">
							<div class="widget-title">
								<h3>설문조사</h3>
								<a href="javascript:fn_egov_save();" class="btn"><i class="icon-ok-sign"></i> 저장(임시저장)</a>
								<a href="javascript:fn_egov_cancel();" class="btn">취소</a>
							</div>
							<div class="widget-content nopadding">
								<table class="table table_conbered table-striped table-hover">		
										<input type="hidden" name="screenMode" value="" />
									<tr>
										<th>설문 제목</th>
										<td>
											<form:input style="width:97%" path="researchNm" cssClass="txt input-xxxlarge"/><form:errors path="researchNm" />
										</td>
									</tr>
									<tr>
										<th>카테고리</th>
										<td>
												<select name="category" id="category">
														<option value="" selected="selected">선택해주세요</option>
													<c:forEach var="categoryList" items="${categoryList}">
														<option value="${categoryList.categoryId}">${categoryList.categoryName}</option>
													</c:forEach>
												</select>
										</td>
									</tr>
									<tr>
										<th>익명/실명</th>
										<td>
											<form:radiobutton name="nameOpen" path="nameOpen" value="0" cssClass="txt"/><form:errors path="nameOpen" /> 익명
											<form:radiobutton name="nameOpen" path="nameOpen" value="1" cssClass="txt"/><form:errors path="nameOpen" /> 실명           											
										</td>
									</tr>
									<tr>
										<th>결과공개/비공개</th>
										<td> 
											<form:radiobutton name="resultOpen" path="resultOpen" value="0" cssClass="txt"/><form:errors path="resultOpen" /> 공개
											<form:radiobutton name="resultOpen" path="resultOpen" value="1" cssClass="txt"/><form:errors path="resultOpen" /> 비공개           
										</td>
									</tr>	
									<tr>
										<th>소개정보(4000자 미만)</th>
										<td>
											<textarea id="Jnit_edit" name="introduce"><c:out value="${jnitresearchVO.introduce}"/></textarea>
										</td>
									</tr>
									<tr>
										<th>질문 생성 개수</th>
										<td> 
											<input type="text" name="countaddtpl" id="countaddtpl"/>
										</td>
									</tr>
								</table>
								
								<table id="example" class="table table_conbered table-striped table-hover">			
									<thead>
										<tr>
											<th style="font-size:1.4em; padding:8px 0;">설문정보&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										<td>
											<table id="question" class="table table_conbered table-striped table-hover">
												<tbody>
													<tr>
														<th rowspan="300" width="20%">질문
															<input type="hidden" name="lineupCnt" id="lineupCnt" value="0"/>
															<br/>
															<div class="tool" style="display:inline;"><input type="radio" name="visible" id="visible" value="0" checked="checked" /><span class="tip">해당 질문을 노출합니다.</span></div>노출
															<div class="tool" style="display:inline;"><input type="radio" name="visible" id="visible" value="1" /><span class="tip">해당 질문을 노출하지 않습니다.</span></div>비노출
														</th>
													</tr>
													<tr>
														<td width="106px">질문</td>
														<td colspan="2">
															<input type="text" name="questionNm" style="width:99%;" value="질문" readonly="readonly"/>
														</td>
													</tr>
													<tr>
														<td width="106px"></td>
														<td colspan="2">
															<input name="upimg" type="file" style="width:99%;" />
															이미지 가로 : <input type="text" name="fileWidth" id="fileWidth" value="100" />
															이미지 세로 : <input type="text" name="fileHeight" id="fileHeight"  value="100" />
												
														</td>
													</tr>	
													<tr>
														<td width="106px">질문유형</td>
														<td colspan="2">
															<select style="width:20%;" name="type" id="type" onchange="javascript:selecttype(this.value)">
																<option value="0" selected="selected">단일</option>
																<option value="1">멀티</option>
																<option value="2">주관식</option>
															</select>
														
															<div id="questionOrder"><input type="checkbox" name="ordercheck" id="ordercheck" value="1" />기타 문항</div>
															<div id="questionMulti" style="display:none;"><input type="text" name="answerCnt" id="answerCnt" value="5" />개 선택가능</div>
															<div id="questionSubjec" style="display:none;"><div class="tool" style="display:inline"><input type="checkbox" name="answerForm" id="answerForm" value="1" /><span class="tip">기존의 단문형이었던 입력창이 <br/>장문형으로 바뀝니다.</span></div>장문형</div>
														</td>
													</tr>
													<tr>
														<td width="106px">답변 정렬방식</td>
														<td colspan="2">											 
															<div style="display:inline;" class="tool"><input type="radio" name="lineup" id="lineup" value="0" checked="checked" /><span class="tip"><img src="/images/research/lineup.gif" style="max-width:70%; max-height:150px;"/></span></div>세로형
															<div style="display:inline;" class="tool"><input type="radio" name="lineup" id="lineup" value="1" /><span class="tip"><img src="/images/research/wlineup.gif" style="max-width:80%; max-height:170px;"/></span></div>가로형
														</td>
													</tr>
													<tr>
														<td><input type="button" onclick="javascript:addAnswerBtn()" class="btn btn-info btn-small" value="답 추가"/></td>
														<td colspan="2"></td>
													</tr>
												</tbody>
											</table>
										</td>
										
									</tbody>
								</table>							
								<!-- 검색조건 유지 -->
								<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
								<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
								<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
	
	<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel"></h3>
	</div>
	<div class="modal-body">
		
	</div>
	<div class="modal-footer">
		<span id="actionBtn"></span>
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>		
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>