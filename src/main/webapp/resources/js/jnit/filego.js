
//검색
function fnFilegoSearch(){
	$("#filegoModal>.modal-header #pageIndex").val(1);		//페이지네비 초기화
	
	var searchCondition = $("#filegoModal>.modal-header #searchCondition").val();
	var searchKeyword = $("#filegoModal>.modal-header #searchKeyword").val();
	var searchDateCondition = $("#filegoModal>.modal-header #searchDateCondition").val();
	var searchStartDate = $("#filegoModal>.modal-header #searchStartDate").val();
	var searchEndDate = $("#filegoModal>.modal-header #searchEndDate").val();
	var logListType = $("#filegoModal>.modal-header #logListType").val();
	var pageIndex = $("#filegoModal>.modal-header #pageIndex").val();
	
	filegoPop(logListType, pageIndex, searchCondition, searchKeyword, searchDateCondition, searchStartDate, searchEndDate);
}

//파일고 페이지네비
function fn_filego_link_page(pageIndex){
	if(pageIndex == undefined || pageIndex == null || pageIndex == '' || pageIndex == 0) pageIndex = 1;
	$("#filegoModal>.modal-header #pageIndex").val(pageIndex);		//페이지 Index 설정
	
	var searchCondition = $("#filegoModal>.modal-header #searchCondition").val();
	var searchKeyword = $("#filegoModal>.modal-header #searchKeyword").val();
	var searchDateCondition = $("#filegoModal>.modal-header #searchDateCondition").val();
	var searchStartDate = $("#filegoModal>.modal-header #searchStartDate").val();
	var searchEndDate = $("#filegoModal>.modal-header #searchEndDate").val();
	var logListType = $("#filegoModal>.modal-header #logListType").val();
	var pageIndex = $("#filegoModal>.modal-header #pageIndex").val();
	
	filegoPop(logListType, pageIndex, searchCondition, searchKeyword, searchDateCondition, searchStartDate, searchEndDate);
}

//파일고 배포로그 팝업 열기
function filegoPop(logListType, pageIndex, searchCondition, searchKeyword, searchDateCondition, searchStartDate, searchEndDate){
	/*
		logListType 0 : 성공로그
		logListType 1 : 실패로그
		logListType 2 : 실패확인로그
	*/
	if(logListType == undefined || logListType == null) logListType = 1;
	logListType = Number(logListType);
	
	if(pageIndex == undefined || pageIndex == null || pageIndex == '') pageIndex = 1;
	if(searchCondition == undefined || searchCondition == null || searchCondition == '') searchCondition = '';
	if(searchKeyword == undefined || searchKeyword == null || searchKeyword == '') searchKeyword = '';
	if(searchDateCondition == undefined || searchDateCondition == null || searchDateCondition == '') searchDateCondition = '';
	if(searchStartDate == undefined || searchStartDate == null || searchStartDate == '') searchStartDate = '';
	if(searchEndDate == undefined || searchEndDate == null || searchEndDate == '') searchEndDate = '';
	
	$("#filegoModal>.modal-header").empty().append("");		//모달 x버튼
	
	//실패로그 리스트일때
	var searchHtml = "<form id='filegoSearchForm' name='filegoSearchForm'>"
						+makeSearchFormHtml(pageIndex, logListType, searchCondition, searchKeyword, searchDateCondition, searchStartDate, searchEndDate);
					+"</form>";
	$("#filegoModal>.modal-header").append(searchHtml);
	$("#searchStartDate,#searchEndDate").datepicker();
	
	var html = filegoListHtml(logListType);
	$("#filegoModal>.modal-body").empty().append(html);
	$("#filegoModal").modal('show');
	
	//select2를 적용하게되면 디자인이 뒤로 먹어버리는 현상으로인해 주석처리
	//$("#logListType").select2();
	//$("#searchCondition").select2();
	
	//로그확인 액션 바인드
	$("#filegoLogConrim").bind("click", function(){
		confirmLog();
	});
	
	//전체체크 액션 바인드
	$("#allChk").bind("click", function(){
		allChk($(this));
	});
	
	//로그목록 유형 변경시 자동으로 이동
	$("#logListType").bind("change", function(){
		fnFilegoSearch();
	});
	
	//bootstrap tooltip
	$("[id^='filego_']").tooltip();
	
	//체크박스 UNIFORM
	$("#filegoModal>.modal-body input[type='checkbox']").uniform();
}

//검색폼 html
function makeSearchFormHtml(pageIndex, logListType, searchCondition, searchKeyword, searchDateCondition, searchStartDate, searchEndDate){
	
	//닫기버튼
	var closeBtnHtml = "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>";
	
	//실패로그 확입너튼
	var logConfrimHtml = "<button type='button' id='filegoLogConrim' class='btn btn-small' style='margin-right: 10px;'>확인처리</button>";
	
	//로그 유형
	var logListTypeHtml = "";
	if(logListType != 1){		//실패로그가 아닐때(margin-left 추가)
		logListTypeHtml = "<select id='logListType' name='logListType' style='width: 120px; margin-left: 84px;'>"
								+"<option value='0' "+(logListType == 0 ? 'selected' : '')+">성공로그</option>"
								+"<option value='1' "+(logListType == 1 ? 'selected' : '')+">실패로그</option>"
								+"<option value='2' "+(logListType == 2 ? 'selected' : '')+">실패확인로그</option>"
							+"</select>";
	}else{						//실패로그일때
		logListTypeHtml = "<select id='logListType' name='logListType' style='width: 120px;'>"
								+"<option value='0' "+(logListType == 0 ? 'selected' : '')+">성공로그</option>"
								+"<option value='1' "+(logListType == 1 ? 'selected' : '')+">실패로그</option>"
								+"<option value='2' "+(logListType == 2 ? 'selected' : '')+">실패확인로그</option>"
							+"</select>";
	}
	
	//searchCondition
	var seletHtml = "";
	if(logListType == 0){							//성공로그
		seletHtml = "<select id='searchCondition' name= 'searchCondition' style='margin-right: 5px; margin-left: 10px; width: 100px;'>"
						+"<option value='1' "+(searchCondition == 1 ? 'selected' : '')+">보낸서버</option>"
						+"<option value='2' "+(searchCondition == 2 ? 'selected' : '')+">받는서버</option>"
						+"<option value='3' "+(searchCondition == 3 ? 'selected' : '')+">파일명</option>"
					+"</select>"
					+"<input type='text' id='searchKeyword' name='searchKeyword' value='"+searchKeyword+"' placeHolder='검색 키워드' style='margin-right: 10px;' />";  
	}else if(logListType == 1){						//실패로그일때
		seletHtml = "<select id='searchCondition' name= 'searchCondition' style='margin-right: 5px; margin-left: 10px; width: 100px;'>"
						+"<option value='1' "+(searchCondition == 1 ? 'selected' : '')+">보낸서버</option>"
						+"<option value='2' "+(searchCondition == 2 ? 'selected' : '')+">받는서버</option>"
						+"<option value='3' "+(searchCondition == 3 ? 'selected' : '')+">파일명</option>"
						+"<option value='4' "+(searchCondition == 4 ? 'selected' : '')+">메시지</option>"
					+"</select>"
					+"<input type='text' id='searchKeyword' name='searchKeyword' value='"+searchKeyword+"' placeHolder='검색 키워드' style='margin-right: 10px;' />";
	}else if(logListType == 2){						//실패 확인로그일때
		seletHtml = "<select id='searchCondition' name= 'searchCondition' style='margin-right: 5px; margin-left: 10px; width: 100px;'>"
						+"<option value='1' "+(searchCondition == 1 ? 'selected' : '')+">보낸서버</option>"
						+"<option value='2' "+(searchCondition == 2 ? 'selected' : '')+">받는서버</option>"
						+"<option value='3' "+(searchCondition == 3 ? 'selected' : '')+">파일명</option>"
						+"<option value='4' "+(searchCondition == 4 ? 'selected' : '')+">메시지</option>"
						+"<option value='5' "+(searchCondition == 5 ? 'selected' : '')+">확인자</option>"
					+"</select>"
					+"<input type='text' id='searchKeyword' name='searchKeyword' value='"+searchKeyword+"' placeHolder='검색 키워드' style='margin-right: 10px;' />"; 
	}
	
	//searchDateCondition
	var searchDateConditionHtml = "";
	
	if(logListType == 0){				//성공로그
		searchDateConditionHtml = 	"<select id='searchDateCondition' name='searchDateCondition' style='margin-left: 20px; width: 100px;'>"
									+"<option value='0' "+(searchDateCondition == 0 ? 'selected' : '')+">전송일자</option>"
								+"</select>";
	} else if(logListType == 1){		//실패로그
		searchDateConditionHtml = 	"<select id='searchDateCondition' name='searchDateCondition' style='margin-left: 20px; width: 130px;'>"
									+"<option value='0' "+(searchDateCondition == 0 ? 'selected' : '')+">전송 실패일자</option>"
								+"</select>";
	} else if(logListType == 2){		//실패 로그 확인
		searchDateConditionHtml = 	"<select id='searchDateCondition' name='searchDateCondition' style='margin-left: 20px; width: 130px;'>"
									+"<option value='0' "+(searchDateCondition == 0 ? 'selected' : '')+">전송 실패일자</option>"
									+"<option value='1' "+(searchDateCondition == 1 ? 'selected' : '')+">확인 일자</option>"
								+"</select>";
	}
	
	//searchDate
	var searchDateHtml = "<input type='text' id='searchStartDate' name='searchStartDate' value='"+searchStartDate+"' placeHolder='시작일' style='margin-left: 10px; width: 70px;' />"
						+" ~ "
						+"<input type='text' id='searchEndDate' name='searchEndDate' value='"+searchEndDate+"' placeHolder='종료일' style='margin-right: 10px; width: 70px; ' />";
	
	//검색버튼
	var searchBtn = "<a href='#' class='btn btn-small' onclick='fnFilegoSearch();return false;'>검색</a>";
	
	//페이지Index
	var pageIndexHtml = "<input type='hidden' id='pageIndex' name='pageIndex' value='"+pageIndex+"' />";
	
	if(logListType == 0){			//성공로그
		return 	logListTypeHtml
				+seletHtml
				+searchDateConditionHtml
				+searchDateHtml
				+searchBtn
				+pageIndexHtml
				+closeBtnHtml; 
	}else if(logListType == 1){		//실패로그
		return 	logConfrimHtml			//로그확인 버튼
				+logListTypeHtml
				+seletHtml
				+searchDateConditionHtml
				+searchDateHtml
				+searchBtn
				+pageIndexHtml
				+closeBtnHtml;
	}else if(logListType == 2){		//실패확인 로그
		return 	logListTypeHtml
				+seletHtml
				+searchDateConditionHtml
				+searchDateHtml
				+searchBtn
				+pageIndexHtml
				+closeBtnHtml;
	}
}

//파일고 종류별 list html 가져오기
function filegoListHtml(logListType){
	/*
		logListType 0 : 성공로그
		logListType 1 : 실패로그
		logListType 2 : 실패확인로그
	*/
	if(logListType == undefined || logListType == null) logListType = 1;
	var html = '';
	var url = '';
	logListType = Number(logListType);
	
	if(logListType == 0){
		url = '/cms/filego/log/success/list.do';		//성공로그
	}else if(logListType == 1){
		url = '/cms/filego/log/fail/list.do';			//실패로그
	}else if(logListType == 2){
		url = '/cms/filego/log/failConfirm/list.do';	//실패확인로그
	}else{
		return false;
	}
	
	$.ajax({
		type:'post',
		url:url,
		data:$("#filegoSearchForm").serialize(),
		success:function(data){
			html += data;
		},
		error:function(error){
			alert('다시 시도해주세요.');
		},
		async:false
	});
	
	return html;
}


//실패내역 전체선택
function allChk(obj){
	var thisChecked = obj.is(":checked");
	var seqs = confirmLogList();
	
	$("input[type='checkbox'][id^='jfflSeqChk_']").prop("checked", thisChecked);
	$("#filegoFailForm>input[type='hidden']#seqs").val(seqs);
	$("#filegoModal>.modal-body input[type='checkbox']").uniform();
}

//실패로그 확인
function confirmLog(){
	var seqs = confirmLogList();
	if(seqs == ''){
		alert('확인처리할 로그를 체크해주세요.');
	}else{
		if(confirm("선택한 항목에 대해서 로그확인 처리하시겠습니까?")){
			var url = '/cms/filego/log/confirm.do';
			$.ajax({
				type:'post',
				url:url,
				data:{
					seqs:seqs
				},
				success:function(data){
					alert('처리 되었습니다.');
				},
				error:function(error){
					alert('로그 확인 실패.');
				},
				async:false
			});
			filegoPop();
		}
	}
}

//체크값 가져오기
function confirmLogList(){
	var seqs = '';
	$("input[type='checkbox'][id^='jfflSeqChk_']:checked").each(function(idx, fnObj){
		if(seqs == ''){
			seqs = fnObj.value;
		}else{
			seqs += ','+fnObj.value;
		}
	});
	return seqs;
}

//실패로그 갯수 셋팅
function setFailCount(obj){
	var url = '/cms/filego/log/failCountJson.do';
	var baseText = "<i class='icon-share'></i>";
	
	$.ajax({
		type:'post',
		url:url,
		data:{
			
		},
		success:function(data){
			if(data == undefined || data == null || data == '') data = '0';
			data = data.trim();
			if(data != '0') obj.empty().append(baseText+"<span class='badge badge-important notify-badge'>"+data+"</span>");
		},
		error:function(error){
			
		}
	});
}

$(document).ready(function(){
	var obj = $("#filegoA");
	setFailCount(obj);
});