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
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<jsp:include page="../../../../../edit/tinymce/edit.jsp" />	
	
<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>

<script type="text/javascript">
<!--

/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitresearchVO").action = "<c:url value='/cms/research/List.do'/>";
   	document.getElementById("jnitresearchVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
	if(confirm("삭제하시겠습니까?")){
	   	document.getElementById("jnitresearchVO").action = "<c:url value='/cms/research/deleteProc.do'/>";
	   	document.getElementById("jnitresearchVO").submit();
	}
}

function fn_egov_save_check(){	
	var category =$("#category").val();
	var starttime =$("#starttime").val();
	var endtime =$("#endtime").val();
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
	} */
	if(starttime == null || starttime == ''){
		alert("시작일을 입력해 주시기 바랍니다.");
		$("#starttime").focus();
		check = "false";
		return false;		
	}
	if(endtime == null || endtime == ''){
		alert("종료일을 입력해 주시기 바랍니다.");
		$("#endtime").focus();
		check = "false";
		return false;		
	}
	
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
				alert("이동설정의 답변입력란에는 숫자를 제외한 문자는 입력하실 수 없습니다.");
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
	
	if(check == ""){
		return true;
	}else{
		return false;
	}
}



/* 글 등록 function */
function fn_egov_save() {	
	
	if(fn_egov_save_check()){
		frm = document.getElementById("jnitresearchVO");
		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/research/EditProc.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/research/addProc.do'/>";
		</c:if>
		
	    frm.submit();
	}
}


/* 글 임시저장 function */
function fn_egov_temp() {	
	if(fn_egov_save_check()){
		$("#tempmode").val("true");
		frm = document.getElementById("jnitresearchVO");
		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/research/EditProc.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/research/addProc.do'/>";
		</c:if>
		
	    frm.submit();
	}
}


$(document).ready(function(){
	$('#endtime').datetimepicker({dateFormat: 'yy-mm-dd'});
	$('#starttime').datetimepicker({dateFormat: 'yy-mm-dd'});
	
	$("#researchTarget").select2();
	dateSet();
});

function dateSet(){
	
	$('#starttime').datetimepicker("option", "onClose", function(selectedDate){
		$('#endtime').datetimepicker("option", "minDate", selectedDate);
	});
	
	
	$('#endtime').datetimepicker("option", "onClose", function(selectedDate){
		$('#starttime').datetimepicker("option", "maxDate", selectedDate);
	});
	

	
	$('#starttime').datetimepicker("option", "maxDate", $('#endtime').val());
	$('#endtime').datetimepicker("option", "minDate", $('#starttime').val());
	
}
$(document).ready(function(){

	<c:if test="${registerFlag == '수정'}">
		$("#category").val("${jnitresearchVO.categoryId}");
	</c:if>
	
    // 질문추가 버튼 클릭시
    var countaddFields = 0;
    $(".addItemBtn").click(function(e){
    	e.preventDefault();
    	var rowNum = countaddFields+1;
    	
    	var html="<tr>" +
        "<td>" +
        "<table id = 'question" + rowNum + "'  class='table table_conbered table-striped table-hover'>" +			        
        "<tr><th rowspan='300' width='20%'>질문" + rowNum + " <input type='button' id='delbtn' class='delbtn btn btn-danger btn-small' value='삭제'> <input type='hidden' name='lineupCnt" + rowNum +"' id='lineupCnt" + rowNum +"' value='0'>"+ 
        "<br/><div class='tool' style='display:inline;'><input type='radio' name='visible" + rowNum + "' id='visible" + rowNum + "' value='0' checked=\"checked\" /><span class='tip'>해당 질문을 노출합니다.</span></div>노출"+
        "<div class='tool' style='display:inline;'><input type='radio' name='visible" + rowNum + "' id='visible" + rowNum + "' value='1' /><span class='tip'>해당 질문을 노출하지 않습니다.</span></div>비노출</th></tr>" + 
        "<tr><td width='106px'>질문</td>" + 
        "<td colspan='2'>" + 
        "<input name='questionNm" + rowNum + "' type='text' style='width:99%;' title='질문을 입력해 주세요.'>" +
        "</td></tr>" + 
        "<tr><td width='106px'>질문 이미지 첨부</td>" +
        "<td colspan='2'>" +
        "<input name='upimg" + rowNum + "' type='file' style='width:99%;'>" +
		"이미지 가로 : <input type='text' style='width:40px;' name='fileWidth" + rowNum + "' id='fileWidth" + rowNum + "' value='100' />" +
		"이미지 세로 : <input type='text' style='width:40px;' name='fileHeight" + rowNum + "' id='fileHeight" + rowNum + "' value='100' />" +
        "<tr><td width='106px'>답변유형</td>" + 
        "<td colspan='2'>" + 
        "<select style='width:20%;' name='type"+ rowNum +"' id='type"+ rowNum +"' onchange='javascript:selecttype("+ rowNum +", this.value)'>" +
        "<option value='0' selected=\"selected\">단일</option>" +
        "<option value='1' >멀티</option>" +
        "<option value='2' >주관식</option>" +
        "</select>" +
        "<div id='questionOrder" + rowNum + "' >" +
        "<input type='checkbox' name='ordercheck" + rowNum + "' id='ordercheck" + rowNum + "' value='1' />기타 문항</div>" +
		"<div id='questionMulti" + rowNum + "' style='display:none;'>" +
		"<input type='text' name='answerCnt" + rowNum + "' id='answerCnt" + rowNum + "' value='5' />개 선택가능</div>" +
		"<div id='questionSubjec" + rowNum + "' style='display:none;'>" +
		"<div class='tool' style='display:inline'><input type='checkbox' name='answerForm" + rowNum + "' id='answerForm" + rowNum + "' value='1' /><span class='tip'>기존의 단문형이었던 입력창이<br/>장문형으로 바뀝니다.</span></div>장문형</div>" + 
		"</td></tr>" +
		"<tr><td width='106px'>답변 정렬방식</td>"	+
		"<td colspan='2'><div style='display:inline;' class='tool'><input type='radio' name='lineup" + rowNum + "' id='lineup" + rowNum + "' value='0' checked=\"checked\" /><span class='tip'><img src='/images/research/lineup.gif' style='max-width:70%; max-height:150px;'/></span></div>세로형"	+
		"<div style='display:inline;' class='tool'><input type='radio' name='lineup" + rowNum + "' id='lineup" + rowNum + "' value='1' /><span class='tip'><img src='/images/research/wlineup.gif' style='max-width:70%; max-height:150px;'/></span></div>가로형</td></tr>"+
		"<tr>" +
        " <td width='106px'><input type='button' id='addAns' value='답변 추가' class='btn btn-info btn-small' onclick='javascript:addAnswerBtn("+ rowNum +")'/></td>"+
        "<td colspan='2'></td>" +
		"</tr>" +
        "</table>" +
        "</td></tr>";	
			        
        $("#example").append(html);
        
        $("#countAddFields").val(countaddFields+1);
    	countaddFields = parseInt($("#countAddFields").val());
                
      
    });
 // 삭제버튼 클릭시
    $(document).delegate(".delbtn", "click", function(){
    	
        var clickedRow = $(this).parent().parent().parent().parent().parent().parent();
        	clickedRow.remove();
    });
 	
 	//수정 페이지 접근시 초기설정
    $("input:radio[name^='UPtype']").each(function(i){
    	if($(this).is(":checked")){
    		if($(this).val() == 0){
    			$("#UPquestionMulti"+$(this).attr("name").substr(6,1)).css("display","none");
    	 		$("#UPquestionSubjec"+$(this).attr("name").substr(6,1)).css("display","none");
    		}
    		if($(this).val() == 1){
    			$("#UPquestionMulti"+$(this).attr("name").substr(6,1)).css("display","");
    	 		$("#UPquestionSubjec"+$(this).attr("name").substr(6,1)).css("display","none");
    		}
    		if($(this).val() == 2){
    			$("#UPquestionMulti"+$(this).attr("name").substr(6,1)).css("display","none");
    	 		$("#UPquestionSubjec"+$(this).attr("name").substr(6,1)).css("display","");
    		}
    	}
    });
    $("input:checkbox[name^='AUPansopt']").each(function(i){
		if($(this).is(":checked")){
			$("#AUPansoptOption"+$(this).attr("name").substr(9,1)).css("display","");
		}
	});
    
    
    
    
});
function delQuestion(Qnum){

	var questionId = $("#UPquestionId"+Qnum).val();
	var researchId = $("#researchId").val();

	if(confirm('해당 질문을 삭제 하시겠습니까?') == true) {
		$.ajax({
		
			type:"POST",
			url: "<c:url value='/cms/research/questionDeleteProc.do'/>",
			dataType: "json",
			data:({"questionId":questionId,"researchId":researchId})
		
		});
		$('#example'+Qnum).remove();
		
		
	}
};

function delQuestionimg(Qnum){
	var questionId = $("#UPquestionId"+Qnum).val();
	var researchId = $("#researchId").val();

	if(confirm('해당 이미지를 삭제 하시겠습니까?') == true) {
		$.ajax({
		
			type:"POST",
			url: "<c:url value='/cms/research/questionImgDeleteProc.do' />",
			data:"questionId="+questionId +" &researchId=" + researchId
		
		});
		$('#Qimg'+Qnum).remove();
		
		$("#UPfileUrl"+Qnum).attr('value',''); 
		$("#UPfilePath"+Qnum).attr('value',''); 
		$("#UPfileNm"+Qnum).attr('value',''); 
		$("#UPfileOnm"+Qnum).attr('value',''); 

	}
};

function delAnswer(Anum){

	var answerId = $("#AUPanswerId"+Anum).val();
	var researchId = $("#researchId").val();
	if(confirm('해당 답을 삭제 하시겠습니까?') == true) {
		$.ajax({
		
			type:"POST",
			url: "<c:url value='/cms/research/answerDeleteProc.do' />",
			dataType: "json",
			data:({"answerId":answerId,"researchId":researchId})
		
		});
		$('.AUPanswer'+Anum).remove();
		
		
	}
};

function delAnswerimg(Anum){
	var answerId = $("#AUPanswerId"+Anum).val();
	var researchId = $("#researchId").val();
	if(confirm('해당 이미지를 삭제 하시겠습니까?') == true) {
		$.ajax({
		
			type:"POST",
			url: "<c:url value='/cms/research/answerImgDeleteProc.do' />",
			dataType: "json",
			data:({"answerId":answerId,"researchId":researchId})
	
		});
	$('#Aimg'+Anum).remove();
	$("#AUPfileUrl"+Anum).attr('value',''); 
	$("#AUPfilePath"+Anum).attr('value',''); 
	$("#AUPfileNm"+Anum).attr('value',''); 
	$("#AUPfileOnm"+Anum).attr('value',''); 
	
	}
};

function delAnswerBtn(ansNum){
	var row = $(".answer"+ansNum);
	var rowimg = $(".answerimg"+ansNum);
	row.remove();
	rowimg.remove();
};
	
var countanswerFields = 0;
function addAnswerBtn(queNum){
	var ansCount = 1;
	var oldAnsCount = $("#example").find('input[name^='+queNum+'answerNm]').length;
		ansCount = ansCount + oldAnsCount;
		
	var ansNum = countanswerFields+1;
	 var html="<tr class = 'answer"+ ansNum +"'>" +
	 "<th rowspan='5'>답변"+ansCount+"<input type='button' id='delans' value='삭제' class='btn btn-danger btn-mini' onclick='javascript:delAnswerBtn("+ ansNum +")'/></th>" +
	 "</tr>" +
	 "<tr class = 'answer"+ ansNum +"'>" +
     "<td width='106px' id = 'answer"+ ansNum +"'>답변</td>" + 
     "<td>" + 									
     "<input name='"+ queNum +"answerNm" + ansNum + "' type='text' style='width:99%;' title='해당 질문에 대한 답변을 입력해 주세요.'>" +
     "</td></tr>" + 
     "<tr class = 'answerimg"+ ansNum +"'><td width='106px'>답변 이미지 첨부</td>" +
	 "<td><input name='"+ queNum +"upimg" + ansNum + "' type='file' style='width:99%;'>" +
	 "이미지 가로 : <input type='text' style='width:40px;' name='"+ queNum +"fileWidth" + ansNum + "' id='"+ queNum +"fileWidth" + ansNum + "' value='75' />" + 
	 "이미지 세로 : <input type='text' style='width:40px;' name='"+ queNum +"fileHeight" + ansNum + "' id='"+ queNum +"fileHeight" + ansNum + "' value='75' />" + 
	 "</td></tr>" +
     "<tr class='answer"+ ansNum +"'><td width='106px'></td>" +
     "<td><div style='display:inline;' class='tool'><input type='checkbox' name='"+ queNum +"criterionOpt" + ansNum + "' id='"+ queNum +"criterionOpt" + ansNum + "' value='1'/><span class='critertip'>결과보기 엑셀 다운로드 후<br/>척도계산을 위한 기능입니다.</span></div> 척도설정" +
	 "<input type='text' name='"+ queNum +"criterionCnt" + ansNum + "' id='"+ queNum +"criterionCnt" + ansNum + "' value='0' /> 점" +
     "</td></tr>" +
	 "<tr class='answer"+ ansNum +"'><td width='106px'></td>" +
	 "<td><input type='checkbox' name='"+ queNum +"ansopt" + ansNum + "' id='"+ queNum +"ansopt" + ansNum + "' value='1' onclick='javascript:addAnsOption("+queNum+","+ansNum+");' />문항설정" +
	 "<div id='"+ queNum +"addAnsoptOption" + ansNum + "' style='display:none;'>&nbsp; &nbsp; &nbsp; &nbsp;-활성화설정 : 해당답변 선택시" +
	 "<input type='text' name='"+ queNum +"ansoptNum" + ansNum + "' id='"+ queNum +"ansoptNum" + ansNum + "' value='${ansResult.ansoptNum}' /> 번 질문 " + 
	 "<input type='radio' name='"+ queNum +"ansoptVisible" + ansNum + "' id='"+ queNum +"ansoptVisible" + ansNum + "' value='0' checked=\"checked\" />활성화 " +
	 "<input type='radio' name='"+ queNum +"ansoptVisible" + ansNum + "' id='"+ queNum +"ansoptVisible" + ansNum + "' value='1' />비활성화" +
	 "<br />&nbsp; &nbsp; &nbsp; &nbsp;-이동설정 :   해당답변 선택시" +
	 "<input type='text' name='"+ queNum +"ansoptMove" + ansNum + "' id='"+ queNum +"ansoptMove" + ansNum + "' value='' /> 번 질문으로 이동" +
	 "</div></td></tr>";
				        
	        
	        $("#question"+queNum).append(html);
	        
	        $("#countanswerFields").val(countanswerFields+1);
	        countanswerFields = parseInt($("#countanswerFields").val());
	                
	        
};

function delUPAnswerBtn(Anum){
	var row = $(".NEWanswer"+Anum);
	var rowimg = $(".NEWanswerimg"+Anum);
	row.remove();
	rowimg.remove();
};

var countUPanswerFields = 0;
function addUPAnswerBtn(Qnum){
	var ansNum = countUPanswerFields+1;
	var questionId = $("#UPquestionId"+Qnum).val();
	var ansCount = 1;
	var oldAnsCount = $("#example"+Qnum).find('input[name^=NEWanswerNm]').length;
	var newAnsCount = $("#example"+Qnum).find('input[name^=AUPanswerNm]').length;
		ansCount = ansCount + oldAnsCount + newAnsCount;
	 var html="<tr class = 'NEWanswer"+ ansNum +"'>" +
	 "<th rowspan='5'>답변"+ansCount+"<input type='button' id='delUpAns' value='삭제' class='btn btn-danger btn-mini' onclick='javascript:delUPAnswerBtn("+ ansNum +")'/>" +
	 "</tr>" +
	 "<tr class = 'NEWanswer"+ ansNum +"'>" +
		"<input name='NEWquestionId" + ansNum + "' type='hidden' value='"+ questionId +"'>" +
     "<td width='106px' class = 'NEWanswer"+ ansNum +"'>답변</td>" + 
     "<td>" + 									
     "<input name='NEWanswerNm" + ansNum + "' type='text' style='width:99%;' title='해당 질문에 대한 답변을 입력해 주세요.'>" +
     "</td></tr>" + 
     "<tr class = 'NEWanswerimg"+ ansNum +"'><td width='106px'>답변 이미지 첨부</td>" +
		"<td><input name='NEWupimg" + ansNum + "' type='file' style='width:99%;'>" +
		"이미지 가로 : <input type='text' style='width:40px;' name='NEWfileWidth" + ansNum + "' id='NEWfileWidth" + ansNum + "' value='75' />" + 
		"이미지 세로 : <input type='text' style='width:40px;' name='NEWfileHeight" + ansNum + "' id='NEWfileHeight" + ansNum + "' value='75' />" + 
		"</td></tr>" +
     "<tr class='NEWanswer"+ ansNum +"'><td width='106px'></td>" +
     "<td><div style='display:inline;' class='tool'><input type='checkbox' name='NEWcriterionOpt" + ansNum + "' id='NEWcriterionOpt" + ansNum + "' value='1'/><span class='critertip'>결과보기 엑셀 다운로드 후<br/>척도계산을 위한 기능입니다.</span></div> 척도설정" +
		"<input type='text' name='NEWcriterionCnt" + ansNum + "' id='NEWcriterionCnt" + ansNum + "' value='0' /> 점" +
     "</td></tr>" +
		"<tr class='NEWanswer"+ ansNum +"'><td width='106px'></td><td>" +
		"<input type='checkbox' name='NEWansopt" + ansNum + "' id='NEWansopt" + ansNum + "' value='1' onclick='javascript:NEWaddAnsOption("+ansNum+");' /> 문항설정" +
		"<div id='NEWaddAnsoptOption" + ansNum + "' style='display:none;'>&nbsp; &nbsp; &nbsp; &nbsp;-활성화설정 : 해당답변 선택시" +
		"<input type='text' name='NEWansoptNum" + ansNum + "' id='NEWnsoptNum" + ansNum + "' value='' /> 번 질문 " + 
		"<input type='radio' name='NEWansoptVisible" + ansNum + "' id='NEWansoptVisible" + ansNum + "' value='0' checked=\"checked\" />활성화 " +
		"<input type='radio' name='NEWansoptVisible" + ansNum + "' id='NEWansoptVisible" + ansNum + "' value='1' />비활성화" +
		"<br />&nbsp; &nbsp; &nbsp; &nbsp;-이동설정 :   해당답변 선택시" +
		"<input type='text' name='NEWansoptMove" + ansNum + "' id='NEWansoptMove" + ansNum + "' value='' /> 번 질문으로 이동" +
		"</div></td></tr>";
				        
	        
	        $("#example"+Qnum).append(html);
	        
	        $("#countUPanswerFields").val(countUPanswerFields+1);
	        countUPanswerFields = parseInt($("#countUPanswerFields").val());

};

function selecttype(num, v){
	if(v == 0){
		$("#ordercheck"+num).removeAttr("disabled");
		$("#questionOrder"+num).css("display","");
		$("#questionMulti"+num).css("display","none");
		$("#questionSubjec"+num).css("display","none");
	}else if(v == 1){
		$("#questionMulti"+num).css("display","");
		$("#ordercheck"+num).removeAttr("disabled");
		$("#questionOrder"+num).css("display","");
		$("#questionSubjec"+num).css("display","none");
	}else{
		$("#questionMulti"+num).css("display","none");
		$("#ordercheck"+num).attr("disabled",true);
		$("#questionOrder"+num).css("display","none");
		$("#questionSubjec"+num).css("display","");
	}
}

function ansOption(num){
	if($("#ansopt"+num).is(":checked")){
		$("#ansoptOption"+num).css("display","");
	}else{
		$("#ansoptOption"+num).css("display","none");
	}
}

function UPselecttype(num, v){
	if(v == 0){
		$("#UPordercheck"+num).removeAttr("disabled");
		$("#UPquestionOrder"+num).css("display","");
		$("#UPquestionMulti"+num).css("display","none");
		$("#UPquestionSubjec"+num).css("display","none");
	}else if(v == 1){
		$("#UPquestionMulti"+num).css("display","");
		$("#UPordercheck"+num).removeAttr("disabled");
		$("#UPquestionOrder"+num).css("display","");
		$("#UPquestionSubjec"+num).css("display","none");
	}else{
		$("#UPquestionMulti"+num).css("display","none");
		$("#UPordercheck"+num).attr("disabled",true);
		$("#UPquestionOrder"+num).css("display","none");
		$("#UPquestionSubjec"+num).css("display","");
	}
}

function AUPansOption(num){
	if($("#AUPansopt"+num).is(":checked")){
		$("#AUPansoptOption"+num).css("display","");
	}else{
		$("#AUPansoptOption"+num).css("display","none");
	}
}
function addAnsOption(Qnum,Anum){
	if($("#"+Qnum+"ansopt"+Anum).is(":checked")){
		$("#"+Qnum+"addAnsoptOption"+Anum).css("display","");
	}else{
		$("#"+Qnum+"addAnsoptOption"+Anum).css("display","none");
	}
}

function NEWaddAnsOption(Anum){
	if($("#NEWansopt"+Anum).is(":checked")){
		$("#NEWaddAnsoptOption"+Anum).css("display","");
	}else{
		$("#NEWaddAnsoptOption"+Anum).css("display","none");
	}
}
$(document).on("click",'#orgSelect',function(e){
	window.open('/research/org.do','researchTarget','scrollbars=yes,toolbar=yes,resizable=yes,width=800,height=800,left=0,top=0');

});
function selectPopActive(){
	$("#researchTarget").select2();
}

function Jnit_research_question(num){
	var baseId = "JnitResearchQuestion"+num;
	var baseObject = $("#"+baseId);
	var displayState = baseObject.css("display");
	
	if(displayState == "none"){
		baseObject.show();
	}else{
		baseObject.hide();
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

	<div id="content">
		<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
		<div class="content_view container-fluid">
			<form:form commandName="jnitresearchVO" name="bbsForm" enctype="multipart/form-data">
				<input type="hidden" name="countAddFields" id="countAddFields" value="0" />
				<input type="hidden" name="countanswerFields" id="countanswerFields" value="0" />
				<input type="hidden" name="countUPanswerFields" id="countUPanswerFields" value="0" />
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
								<a href="javascript:fn_egov_selectList();" class="btn"><i class="icon-repeat"></i> 되돌아가기</a>
								<a href="javascript:fn_egov_save();" class="btn"><i class="icon-ok-sign"></i> 저장(공개)</a>
								<a href="javascript:fn_egov_temp();" class="btn"><i class="icon-ok-sign"></i> 임시저장</a>
								<c:if test="${registerFlag == '수정'}">
									<a href="javascript:fn_egov_delete();" class="btn"><i class="icon-ok-sign"></i> 삭제</a>
								</c:if>
								<a href="#" class="btn btn-info addItemBtn" ><i class="icon-plus-sign"></i> 질문추가</a>
							</div>
							<div class="widget-content nopadding">
								<table class="table table_conbered table-striped table-hover">		
									<c:if test="${registerFlag == '수정'}">
										<input type="hidden" name="screenMode" value="up" />
									</c:if>
									<c:if test="${registerFlag == '등록'}">
										<input type="hidden" name="screenMode" value="" />
									</c:if>				
									<tr>
										<th>설문 제목</th>
										<td>
											<form:input style="width:97%" path="researchNm" cssClass="txt input-xxxlarge" title="설문 제목을 입력해 주세요."/><form:errors path="researchNm" />
										</td>
									</tr>
									<tr>
									<th>카테고리&nbsp;<a href="javascript:Jnit_research_question('1');"><i class="icon-question-sign"></i></a></th>
									<td>
										<c:if test="${registerFlag == '등록'}">
											<select name="category" id="category">
													<option value="" selected="selected">선택해주세요</option>
												<c:forEach var="categoryList" items="${categoryList}">
													<option value="${categoryList.categoryId}">${categoryList.categoryName}</option>
												</c:forEach>
											</select>
										</c:if>
										<c:if test="${registerFlag == '수정'}">
											<select name="category" id="category">
													<option value="">선택해주세요</option>
												<c:forEach var="categoryList" items="${categoryList}">
													<option value="${categoryList.categoryId}" 
														<c:if test="${jnitresearchVO.categoryId == categoryList.categoryId}">
															selected="selected"
														</c:if>
													  >${categoryList.categoryName}</option>
												</c:forEach>
											</select>
										</c:if>
										<br />
										<span id="JnitResearchQuestion1" style="display: none;">
											<strong>&nbsp;- 카테고리별로 설문조사를 묶어 페이지에 노출시킵니다.</strong>
										</span>
									</td>
								</tr>
									<!-- 
									//참여대상 주석처리
									<tr>
										<th>참여대상</th>
										<td>
											<select multiple="multiple" id="researchTarget" name="researchTarget" class="input-xxlarge">
						                		<c:forEach items="${targetList}" var="target">
						                			<option value="${target}" selected="selected">${orgJson[target]}</option>
						                		</c:forEach>
						                	</select>
						                	<a href="#none;" id="orgSelect" class="btn"><i class="icon-ok-sign"></i>설정</a>
						                	
										</td>
									</tr>
									 -->
									<tr>
										<th>인증방식&nbsp;<a href="javascript:Jnit_research_question('2');"><i class="icon-question-sign"></i></a></th>
										<td>
											<form:radiobutton name="researchOpen" path="researchOpen" value="0" cssClass="txt"/><form:errors path="nameOpen" /> 로그인 회원 
											<form:radiobutton name="researchOpen" path="researchOpen" value="1" cssClass="txt"/><form:errors path="nameOpen" /> IP 
											<form:radiobutton name="researchOpen" path="researchOpen" value="2" cssClass="txt"/><form:errors path="nameOpen" /> COOKIE
											<br />
											<span id="JnitResearchQuestion2" style="display: none;">
												<strong>&nbsp;- 설문조사 중복참여 여부를 결정할 수 있습니다.</strong>
											</span>      											
										</td>
									</tr>
									<tr>
										<th>익명/실명&nbsp;<a href="javascript:Jnit_research_question('3');"><i class="icon-question-sign"></i></a></th>
										<td>
											<form:radiobutton name="nameOpen" path="nameOpen" value="0" cssClass="txt"/><form:errors path="nameOpen" /> 익명
											<form:radiobutton name="nameOpen" path="nameOpen" value="1" cssClass="txt"/><form:errors path="nameOpen" /> 실명
											<br />
											<span id="JnitResearchQuestion3" style="display: none;">
												<strong>&nbsp;- 실명으로 선택시 투표결과통계에 참여자의 선택결과를 보여줍니다.</strong>
											</span>           											
										</td>
									</tr>
									<tr>
										<th>결과공개/비공개&nbsp;<a href="javascript:Jnit_research_question('4');"><i class="icon-question-sign"></i></a></th>
										<td> 
											<form:radiobutton name="resultOpen" path="resultOpen" value="0" cssClass="txt"/><form:errors path="resultOpen" /> 공개
											<form:radiobutton name="resultOpen" path="resultOpen" value="1" cssClass="txt"/><form:errors path="resultOpen" /> 비공개
											<br />
											<span id="JnitResearchQuestion4" style="display: none;">
												<strong>&nbsp;- 투표 결과를 사용자에게 보여질지 여부를 선택합니다.</strong>
											</span>
										</td>
									</tr>	
									<tr>
										<th>소개정보(4000자 미만)</th>
										<td>
											<textarea id="Jnit_edit" name="introduce"><c:out value="${jnitresearchVO.introduce}"/></textarea>
										</td>
									</tr>
									<tr>
										<th>시작일</th>
										<td>
											<input type="text" id="starttime" name="starttime" value="<fmt:formatDate value="${jnitresearchVO.starttime}" pattern="yyyy-MM-dd HH:mm" />" class="txt" />
										</td>
									</tr>	
									<tr>
										<th>종료일</th>
										<td>
											<input type="text" id="endtime" name="endtime" value="<fmt:formatDate value="${jnitresearchVO.endtime}" pattern="yyyy-MM-dd HH:mm" />" class="txt" />
										</td>
									</tr>	
								</table>
								
								<table class="table table_conbered table-striped table-hover">			
									<thead>
										<tr>
											<th style="font-size:1.4em; padding:8px 0;">설문정보&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										<td>
											<c:if test="${registerFlag == '등록'}">
												<table id="example" class="table table_conbered table-striped table-hover">	
												</table>
											</c:if>
											<c:if test="${registerFlag == '수정'}">  				       
												<c:if test='${fn:length(queListResult) != 0 }'>
													<c:set var="Qnum" value="0" />
													<c:set var="Anum" value="0" />
													<c:set var="ansCount" value="1" />
													
													<c:forEach var="queResult" items="${queListResult}" varStatus="status">
														<c:set var="Qnum" value="${Qnum +1}" />
														<c:set var="ansCount" value="1" />
														<table id="example${Qnum}" class="table table_conbered table-striped table-hover">
															<tbody>
																<tr>
																	<th rowspan="300" width="20%">질문${Qnum}
																		<input type="button" onclick="javascript:delQuestion(${Qnum})" class="btn btn-danger btn-small" value="삭제"/>
																		<input type="hidden" name="UPquestionId${Qnum}" id ="UPquestionId${Qnum}" value ="${queResult.questionId}"/>
																		<input type="hidden" name="UPlineupCnt${Qnum}" id="UPlineupCnt${Qnum}" value="${queResult.lineupCnt}"/>
																		<br/>
																		<div class="tool" style="display:inline;"><input type="radio" name="UPvisible${Qnum}" id="UPvisible${Qnum}" value="0" <c:out value="${(queResult.visible == 0) ? 'checked=\"checked\"' : ''}"/> /><span class="tip">해당 질문을 노출합니다.</span></div>노출
																		<div class="tool" style="display:inline;"><input type="radio" name="UPvisible${Qnum}" id="UPvisible${Qnum}" value="1" <c:out value="${(queResult.visible == 1) ? 'checked=\"checked\"' : ''}"/> /><span class="tip">해당 질문을 노출하지 않습니다.</span></div>비노출
																	</th>
																</tr>
																<tr>
																	<td width="106px">질문</td>
																	<td colspan="2">
																		<input type="text" name="UPquestionNm${Qnum}" id="UPquestionNm${Qnum}" value="<c:out value='${queResult.questionNm}' />" style="width:99%;" title="질문을 입력해 주세요."/>
																	</td>
																</tr>
																<tr>
																	<td width="106px">질문 이미지 첨부</td>
																	<td colspan="2">
																		<c:if test="${queResult.fileUrl != null && queResult.fileUrl != ''}">
																			<div  id="Qimg${Qnum}">
																				<img src="<c:url value="${queResult.fileUrl}"/>" class="questionImg" width="100" height="100" />
																				<a href="javascript:delQuestionimg(${Qnum})" class="btn btn-danger btn-small">X</a>
																			</div>
																			<input type="hidden" name="UPfileUrl${Qnum}" id="UPfileUrl${Qnum}" value="${queResult.fileUrl}"/>
																			<input type="hidden" name="UPfilePath${Qnum}" id="UPfilePath${Qnum}" value="${queResult.filePath}"/>
																			<input type="hidden" name="UPfileNm${Qnum}" id="UPfileNm${Qnum}" value="${queResult.fileNm}"/>
																			<input type="hidden" name="UPfileOnm${Qnum}" id="UPfileOnm${Qnum}" value="${queResult.fileOnm}"/>
																		</c:if>
																		<input name="UPupimg${Qnum}" type="file" style="width:99%;" />
																		이미지 가로 : <input type="text" style="width:40px" name="UPfileWidth${Qnum}" id="UPfileWidth${Qnum}" value="${queResult.fileWidth}" />
																		이미지 세로 : <input type="text" style="width:40px" name="UPfileHeight${Qnum}" id="UPfileHeight${Qnum}"  value="${queResult.fileHeight}" />
															
																	</td>
																</tr>	
																<tr>
																	<td width="106px">답변유형</td>
																	<td colspan="2">
																		<select style="width:20%;" name="UPtype${Qnum}" id="UPtype${Qnum}" onchange="javascript:UPselecttype(${Qnum}, this.value)">
																			<option value="0" 
																				<c:if test="${queResult.type == 0}">
																					selected="selected"
																				</c:if>>단일</option>
																			<option value="1" 
																				<c:if test="${queResult.type == 1}">
																					selected="selected"
																				</c:if>>멀티</option>
																			<option value="2" 
																				<c:if test="${queResult.type == 2}">
																					selected="selected"
																				</c:if>>주관식</option>
																		</select>
																		<div id="UPquestionOrder${Qnum}" style="<c:if test="${queResult.type == 2}">display:none;</c:if>" >
																		<input type="checkbox" name="UPordercheck${Qnum}" id="UPordercheck${Qnum}" value="1" 
																			<c:if test="${queResult.type == 2}">
																				disabled = "disabled"
																			</c:if>
																		<c:out value="${(queResult.ordercheck == 1) ? 'checked=\"checked\"' : ''}"/> />기타 문항</div>
																		<div id="UPquestionMulti${Qnum}" <c:if test="${queResult.type != 1}">style="display:none;"</c:if> ><input type="text" name="UPanswerCnt${Qnum}" id="UPanswerCnt${Qnum}" value="${queResult.answerCnt}" />개 선택가능</div>
																		<div id="UPquestionSubjec${Qnum}" <c:if test="${queResult.type != 2}">style="display:none;"</c:if> ><div class="tool" style="display:inline"><input type="checkbox" name="UPanswerForm${Qnum}" id="UPanswerForm${Qnum}" value="1" <c:out value="${(queResult.answerForm == 1) ? 'checked=\"checked\"' : ''}"/> /><span class="tip">기존의 단문형이었던 입력창이 <br/>장문형으로 바뀝니다.</span></div>장문형</div>
																	</td>
																</tr>
																<tr>
																	<td width="106px">답변 정렬방식</td>
																	<td colspan="2">											 
																		<div style="display:inline;" class="tool"><input type="radio" name="UPlineup${Qnum}" id="UPlineup${Qnum}" value="0" <c:out value="${(queResult.lineup == 0) ? 'checked=\"checked\"' : ''}"/> /><span class="tip"><img src="/images/research/lineup.gif" style="max-width:70%; max-height:150px;"/></span></div>세로형
																		<div style="display:inline;" class="tool"><input type="radio" name="UPlineup${Qnum}" id="UPlineup${Qnum}" value="1" <c:out value="${(queResult.lineup == 1) ? 'checked=\"checked\"' : ''}"/> /><span class="tip"><img src="/images/research/wlineup.gif" style="max-width:80%; max-height:170px;"/></span></div>가로형
																	</td>
																</tr>
																<tr>
																	<td><input type="button" onclick="javascript:addUPAnswerBtn(${Qnum})" class="btn btn-info btn-small" value="답변 추가"/></td>
																	<td colspan="2"></td>
																</tr>
																<c:if test='${fn:length(ansListResult) != 0 }'>
																	<c:forEach var="ansResult" items="${ansListResult}" varStatus="ansStatus">
																		<c:if test='${queResult.questionId == ansResult.questionId }'>
																			<c:if test='${ansResult.type != 9}'>
																				<c:set var="Anum" value="${Anum +1}" />
																				<tr class="AUPanswer${Anum}">
																					<th rowspan="5">답변${ansCount}
																						<input type="button" onclick="javascript:delAnswer(${Anum})" class="btn btn-danger btn-mini" value="삭제"/>
																					</th>
																				</tr>
																				<tr class="AUPanswer${Anum}"> 
																					<td width="106px" >답변
																						<input type="hidden" name="AUPanswerId${Anum}" id="AUPanswerId${Anum}" value="${ansResult.answerId}"/>
																						<input type="hidden" name="AUPquestionId${Anum}" id="AUPquestionId${Anum}" value="${ansResult.questionId}"/>
																						<input type="hidden" name="AUPresearchId${Anum}" id="AUPresearchId${Anum}" value="${ansResult.researchId}"/>
																						<input type="hidden" name="AUPanswerType${Anum}" id="AUPanswerType${Anum}" value="${ansResult.type}"/>
																					</td>
																					<td>
																						<input type="text" name="AUPanswerNm${Anum}" id="AUPanswerNm${Anum}" value="<c:out value='${ansResult.answerNm}' />" style="width:99%;" title="해당 질문에 대한 답변을 입력해 주세요."/>
																					</td>
																				</tr>
																				<tr class="AUPanswer${Anum}">
																					<td width="106px">답변 이미지 첨부</td>
																					<td> 
																						<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != '' }">
																							<div id="Aimg${Anum}">
																								<img src="<c:url value="${ansResult.fileUrl}"/>" width="75" height="75" >
																								<a href="javascript:delAnswerimg(${Anum})" class="btn btn-danger btn-small">X</a>
																							</div>																        
																							<input type="hidden" name="AUPfileUrl${Anum}" id="AUPfileUrl${Anum}" value="${ansResult.fileUrl}"/>
																							<input type="hidden" name="AUPfilePath${Anum}" id="AUPfilePath${Anum}" value="${ansResult.filePath}"/>
																							<input type="hidden" name="AUPfileNm${Anum}" id="AUPfileNm${Anum}" value="${ansResult.fileNm}"/>
																							<input type="hidden" name="AUPfileOnm${Anum}" id="AUPfileOnm${Anum}" value="${ansResult.fileOnm}"/>
																						</c:if>
																						<input name="AUPupimg${Anum}" type="file" style="width:99%;" />
																						이미지 가로 : <input type="text" style="width:40px" name="AUPfileWidth${Anum}" id="AUPfileWidth${Anum}" value="${ansResult.fileWidth}" />
																						이미지 세로 : <input type="text" style="width:40px" name="AUPfileHeight${Anum}" id="AUPfileHeight${Anum}"  value="${ansResult.fileHeight}" />
																					</td>
																				</tr>
																				<tr class="AUPanswer${Anum}">
																					<td width="106px"></td>
																					<td>
																						<div style="display:inline;" class="tool"><input type="checkbox" name="AUPcriterionOpt${Anum}" id="AUPcriterionOpt${Anum}"  value="1" <c:out value="${(ansResult.criterionOpt == 1) ? 'checked=\"checked\"' : ''}"/> /><span class="critertip">결과보기 엑셀 다운로드 후<br/>척도계산을 위한 기능입니다.</span></div>
																						척도설정 
																						<input type="text" name="AUPcriterionCnt${Anum}" id="AUPcriterionCnt${Anum}"  value="${ansResult.criterionCnt}" /> 점
																					</td>
																				</tr>
																				<tr class="AUPanswer${Anum}">
																					<td width="106px"></td>
																					<td>
																						<input type="checkbox" name="AUPansopt${Anum}" id="AUPansopt${Anum}"  value="1" <c:out value="${(ansResult.ansopt == 1) ? 'checked=\"checked\"' : ''}"/> onclick="javascript:AUPansOption(${Anum});" />
																						문항설정
																						<div id="AUPansoptOption${Anum}" <c:if test="${ansResult.ansopt == 0 }">style="display:none;"</c:if> >
																							&nbsp; &nbsp; &nbsp; &nbsp;-노출설정 : 해당답변 선택시 <input type="text" name="AUPansoptNum${Anum}" id="AUPansoptNum${Anum}" value="${ansResult.ansoptNum}" /> 번 질문 
																							<input type="radio" name="AUPansoptVisible${Anum}" id="AUPansoptVisible${Anum}" value="0" <c:out value="${(ansResult.ansoptVisible == 0) ? 'checked=\"checked\"' : ''}"/> />노출 
																							<input type="radio" name="AUPansoptVisible${Anum}" id="AUPansoptVisible${Anum}" value="1" <c:out value="${(ansResult.ansoptVisible == 1) ? 'checked=\"checked\"' : ''}"/> />비노출
																							<br />&nbsp; &nbsp; &nbsp; &nbsp;-이동설정 :   해당답변 선택시<input type="text" name="AUPansoptMove${Anum}" id="AUPansoptMove${Anum}" value="${ansResult.ansoptMove}" /> 번 질문으로 이동
																						</div>
																					</td>
																				</tr>
																			</c:if>
																			<c:set var="ansCount" value="${ansCount + 1}" />								
																		</c:if>
																	</c:forEach>
																</c:if>
															</tbody>
														</table>
													</c:forEach>
												</c:if>
												<table id="example" class="table table_conbered table-striped table-hover" summary="추가설문">	
												
												</table>				
											</c:if>		
											<a href="#" class="btn btn-info addItemBtn"><i class="icon-plus-sign"></i> 질문추가</a>
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
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>