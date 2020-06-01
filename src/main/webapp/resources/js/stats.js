
function fn_check(){
	var frm = document.searchForm;
	
	if(frm.prt_code_date.maxLength == 4 && frm.prt_code_date.value.length != 4){
		alert("날짜 형식은 yyyy 입니다.");
		return false;
	}
	if(frm.prt_code_date.maxLength == 6 && frm.prt_code_date.value.length != 6){
		alert("날짜 형식은 yyyyMM 입니다.");
		return false;
	}
	
	if(frm.prt_code_date.value.substr(4,2) > 12 ){
		alert("월은 12월을 넘을 수 없습니다.");
		return false;
	}
	
	if(frm.prt_code_date_end.maxLength == 4 && frm.prt_code_date_end.value.length != 4){
		alert("날짜 형식은 yyyy 입니다.");
		return false;
	}
	if(frm.prt_code_date_end.maxLength == 6 && frm.prt_code_date_end.value.length != 6){
		alert("날짜 형식은 yyyyMM 입니다.");
		return false;
	}
	
	if(frm.prt_code_date_end.value.substr(4,2) > 12 ){
		alert("월은 12월을 넘을 수 없습니다.");
		return false;
	}
	
	return true;

}