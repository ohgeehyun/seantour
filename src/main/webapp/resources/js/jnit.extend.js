// 배열 관련 ///////////////////////////////////////////////////////////
//오브젝트타입의 배열일 때 배열안의 오브젝트[keyName]의 값을 obj[keyName]와 비교하여 있는지 체크 해서 있으면 마지막 index리턴.
function existObjectInArray(arr,obj,keyName){
	var ret = -1;
	$(arr).each(function(index,item){
		if(this[keyName] == obj[keyName]){
			ret = index;
		}
	});
	return ret;
}

//오브젝트타입 배열에 obj를 추가할 때 keyName을 체크하여 없을때는 추가 있을때는 수정.
function pushUniqueObjectInArray(arr,obj,keyName){
	var idx = existObjectInArray(arr,obj,keyName);
	if(idx < 0)arr.push(obj);
	else{
		arr[idx] = obj;
	}
	
}

//오브젝트타입 배열에 keyName을 체크하여 오브젝트 삭제
function removeObjectInArray(arr,obj,keyName){
	var len = arr.length;
	if(len > 0){
		var arrIdx = new Array();
		$.each(arr,function(index,item){
			if(this[keyName] == obj[keyName]){
				arrIdx.push(index);
				//arr.splice(index,1);
			}
		});
		var idxLength = arrIdx.length;
		for(var i = idxLength; i > 0; i--){
			arr.splice(arrIdx[i - 1],1);
		}
	}
}

//오브젝트타입 배열에 keyName에 해당하는 obj가 있을때는 삭제, 없으면 추가.
function toggleUniqueObjectInArray(arr,obj,keyName){
	if(existObjectInArray(arr,obj,keyName) < 0)arr.push(obj);
	else removeObjectInArray(arr,obj,keyName);
}
// -- 배열 관련 ///////////////////////////////////////////////////////////



//공통 펑션 관련 ///////////////////////////////////////////////////////////
//새주소검색
function commonNewZipSearch(formName,zip1Field,zip2Field,addrField,addrDetailField,newaddrField,newaddrDetailField) {	
	var localYn = "N";
	var url = (localYn == 'Y' ? '../..':'')+"/gis/zip.do?retForm="+formName
			+"&retZip1="+zip1Field
			+"&retZip2="+zip2Field
			+"&retAddr="+addrField			
			+"&retAddrDetail="+addrDetailField			
			+"&retNewaddr="+newaddrField
			+"&retNewaddrDetail="+newaddrDetailField
			/*
			+"&retFunction=afterAddress"
			*/
			;
	
	var zipPop = window.open(url, "새주소검색", "width=600,height=500,top=0,left=0,scrollbars=yes");
	zipPop.focus();
}
//* upfileAdd**//
function upfileBind(addBtn,delBtn,upfileWrap,upfileElem){
	$("#"+addBtn).bind("click",function(e){
		var cnt = $('div.'+upfileWrap+' .'+upfileElem).length + 1;
		if(cnt == 1){
			$('div.'+upfileWrap).append('<div class="'+upfileElem+'"><label for="upfile'+cnt+'" class="blind">파일</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"></div>');
		}else{
			$('div.'+upfileWrap).append('<div class="'+upfileElem+'"><label for="upfile'+cnt+'" class="blind">파일</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"></div>');
		}
	});
	$("#"+delBtn).bind("click",function(e){
		$('div.'+upfileWrap+' .'+upfileElem+':last').remove();
	});
}

//datepicker 옵션
function getDatepickerOption(obj){
	
	var calendarDefault = {};
	var monthNames = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
	var monthNamesShort = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
	var dayNamesMin = ['일','월','화','수','목','금','토'];
	var dateFormat = 'yy-mm-dd';
	var minDate = '';
	var buttonImage = '/epis/images/program/calendar_bg_icon.gif';
	var yearRange = '1990:2020';
	calendarDefault = {
			monthNames: monthNames,
			monthNamesShort: monthNamesShort,
			dayNamesMin: dayNamesMin,
			weekHeader: 'Wk',
			dateFormat: dateFormat,
		    yearSuffix: '년',
			autoSize: false,
			changeMonth: true,
			changeYear: true,
			showMonthAfterYear: true,
			buttonImageOnly: true,
			buttonText: '달력선택',
			buttonImage: buttonImage,
			showOn: "both",
		    minDate: minDate,
			yearRange: yearRange
		};
	for(var k in obj){
		calendarDefault[k] = obj[k];
	}
	return calendarDefault;
}

function getTinyOption(obj){
	var ret = {
		language:"ko_KR", //언어설정
	    selector: "#editTinymce", //id
	    plugins: [ //플러그인 주석부분은 오류로인하여 주석처리함
	          "advlist anchor autolink autoresize", // autosave
	          //"bbcode"
	          "charmap code contextmenu",
	          "directionality",
	          "emoticons example example_dependency",
	          //"fullpage fullscreen", <!DOCTYPE html>기본html 생성
	          "hr",
	          "image  insertdatetime",//importcss
	          "layer link lists", //legacyoutput
	          //"media"
	          "nonbreaking noneditable",
	          "pagebreak paste preview print",
	          "save searchreplace spellchecker",
	          "tabfocus table template textcolor",
	          "visualblocks visualchars",
	          //"wordcount"
	      ],
	      target_list: [ //link target 지정
			{title: '_blank', value: '_blank'},
			{title: '_self', value: '_self'}     
	      ],
	      image_advtab : true, // 사용자 지정 스타일
	      autoresize_min_height: 300, //편집기 최소높이
	      //forced_root_block: false,//IE에서 한글입력 문제 해결을 위해서 //한칸띠고 다음문장적을시 지워지는 문제 발생
	      relative_urls : false,//이미지 상대경로 치환부분 막기
	      //폰트지정
	      //theme_advanced_fonts: "굴림=굴림;굴림체=굴림체;궁서=궁서;궁서체=궁서체;돋움=돋움;돋움체=돋움체;바탕=바탕;바탕체=바탕체;Arial=Arial; Comic Sans MS='Comic Sans MS';Courier New='Courier New';Tahoma=Tahoma;Times New Roman='Times New Roman';Verdana=Verdana",
	      //toolbar = | 그룹 구분자
	      /* 2014-10-31 by.나성재 수정 툴바 수정
	   	  toolbar1: "newdocument | fullpage | bold | italic | underline | strikethrough | alignleft | aligncenter | alignright | alignjustify",
	      toolbar2: "bullist | numlist | outdent | indent | blockquote | undo | redo | cut | copy | paste | searchreplace",
	      toolbar3: "table | hr | removeformat | subscript | superscript | charmap | emoticons | print | fullscreen | link | unlink | anchory", //| spellchecker | template | pagebreak
	      toolbar4: "ltr | rtl | visualchars | visualblocks | nonbreaking | image | code | inserttime | preview | forecolor | backcolor",
	      toolbar5: "fontselect | fontsizeselect" //fontsizeselect 와 기본 format headings 오류있음
	      */
	      toolbar1: "code | undo | redo | cut | copy | paste | searchreplace | charmap | emoticons | image | table | visualblocks",
	      toolbar2: "fontselect | fontsizeselect | forecolor | backcolor | bold | italic | underline | strikethrough | alignleft | aligncenter | alignright | alignjustify | bullist | numlist | outdent | indent | hr | removeformat | subscript | superscript | link | unlink | anchory"      
	 };

	for(var k in obj){
		ret[k] = obj[k];
	}
	return ret;
}

//숫자만 입력가능.(keyup이벤트에 사용)
function pressInt(){
	if (this.value != this.value.replace(/[^0-9]/g, '')){
		this.value = this.value.replace(/[^0-9]/g, '');
		this.focus();
	}
}

//에디터 이미지 업로드 
function Jnit_img_upload(){	
	window.open("/eite/img/upload/popup.do",'imgFileEdit','width=350, height=330, toolbar=no, scrollbars=yes, status=yes, resizable=yes');
}
// -- 공통 펑션 관련 ///////////////////////////////////////////////////////////
