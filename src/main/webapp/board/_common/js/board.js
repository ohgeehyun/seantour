/**
 * JNIT CMS Board
 * Author : Dael(@daelity.com) At JNIT
 * Version : 1.5
 */
var lang;
var useWyswygType;
$(document).ready(function(){
	lang = $("#boardLang").val();
	useWyswygType = $("#boardUseWyswygType").val();
});
var blackArr = new Array(/*'innerhtml',
		'javascript','eval','onmousewheel','onactive','onfocusout',
		'expression','charset','ondataavailable','oncut','onkeyup',
		'applet','document','onafteripudate','onclick','onkeypress',
		'meta','onmousedown','onchange','onload',
		'xml','create','onbeforeactivate','onbeforecut','onbounce',
		'blink','append','onbeforecopy','ondbclick','onmouseenter',
		'binding','onbeforedeactivate','ondeactivate','onmouseout',
		'alert','ondatasetchaged','ondrag','onmouseover',
		'script','msgbox','cnbeforeprint','ondragend','onsubmit',
		'embed','refresh','cnbeforepaste','ondragenter','onmouseend',
		'void','onbeforeeditfocus','ondragleave','onresizestart',
		'iframe','cookie','onbeforeuload','ondragover','onuload',
		'frame','Href','onbeforeupdate','ondragstart','onselectstart',
		'frameset','onpaste','onpropertychange','ondrop','onreset',
		'ilayer','onresize','ondatasetcomplete','onerror','onmove',
		'onselect','oncellchange','onfinish','onstop',
		'bgsound','base','onlayoutcomplete','onfocus','onrowexit',
		'onblur','onselectionchange','vbscript','onerrorupdate',
		'onbefore','onstart','onrowsinserted','onkeydown','onfilterchage',
		'onmouseup','onfocusin','oncontrolselected','onrowsdelete','onlosecapture',
		'onrowenter','onhelp','onreadystatechange','onmouseleave','onmousemove',*/
		'oncontextmenu');

//파일 확장자 체크
function checkExt(){	
	var boardLenth = $(".upfileWrap > div.upfileElem").length;
	if( boardLenth != 0 ){
		for(var i=0; i<boardLenth; i++){
			var num = (i+1);
			if($('#upfile'+num).val() != ''){
				var ext = $('#upfile'+num).val().split('.').pop().toLowerCase();
				if($.inArray(ext, ["bmp","jpg","gif","png","jpeg","mp3","ogg","wma","wav","mpeg"
				                   ,"wmv","mp4","swf","txt","hwp","doc","docx","ppt","pdf","pptx"
				                   ,"xml","zip","rar","alz","egg","7z","xls","xlsx","avi","p12"]) == -1) {

					alert('bmp, jpg, gif, png, jpeg, mp3, ogg, wma, wav, mpeg, wmv,\n'
						+'mp4, swf, txt, hwp, doc, docx, ppt, pdf, pptx, xml, zip,\n'
						+' rar, alz, egg, 7z, xls, xlsx, avi, p12 \n'+Jnit_isLang('파일만 업로드 할수 있습니다.'));
					$("#upfile"+num).focus();
					return;
				}
			}
		}
	}
	return true;
}
function fnByte(obj, limitB,aNum){
	var str = obj.value;
	var str_len = str.length;
	
	var rByte = 0;
	var rlen =0;
	var one_char = "";
	var str2 = "";
	
	for(var i =0; i<str_len; i++){
		one_char = str.charAt(i);
		if(escape(one_char).length>4){
			rByte+=2;
		}else{
			rByte++;
		}
		
		if(rByte<=limitB){
			rlen=i+1;
		}
	}
	if(rByte>limitB){
		alert("한글"+(limitB/2)+"자 / 영문 "+limitB+"자를 초과 입력할 수 없습니다.");
		str2 = str.substr(0,rlen);                                  //문자열 자르기
	    obj.value = str2;
	    fnByte(obj, limitB, aNum);
	}else{
	    document.getElementById('byteInfo_'+aNum).innerText = rByte;
	}
	
}
//파일 확장자 체크
function checkExt2(){
	if($('#mainfile').val() != ''){
		var ext = $('#mainfile').val().split('.').pop().toLowerCase();
		if($.inArray(ext, ["bmp","jpg","gif","png","jpeg"]) == -1) {
			alert('bmp, pg, gif, png, jpeg'
				  +'\n'+Jnit_isLang('파일만 업로드 할수 있습니다.'));
			$('#mainfile').focus();
			return;
		}
	}
	return true;
}

var log = function(msg){
	if (!window.console) { window.console = { log : function() {} }; }
	console.log(msg);
};

function opendata(n){
	if(!n){
		return;
	}else{
		$('.tl').css('display','none');
		$('#g'+n).css('display','');
	}
}

$(document).ready(function(e){
	if($('#boardUseFilter').length>0){
		$(document).on("submit",'form[name="bbsForm"]',function(e){
			var isSubmit = true;
			var boardType = $("#boardType").val();
			if(boardType.indexOf("gallery") > -1
					|| boardType.indexOf("thumbnail") > -1){
				if(!checkExt2() || !checkExt()){
					isSubmit = false;
				}
			}else{
				if(!checkExt()){
					isSubmit = false;
				}
			}
			if(isSubmit){
				bbsSubmit(e);
			}else{
				e.preventDefault();
			}
		});
	}
});

function jnitBoardPage(pageIdx){
	$('#bbsForm input[name="pageIdx"]').val(pageIdx);
	$('#bbsForm').submit();
	return false;
};

var jnitBoardSearch = function(){
	$('#bbsForm input[name="pageIdx"]').val(1);
	$('#bbsForm').submit();
	return false;
};

var sendMail = function(){
	var boardId = $('input[name=boardId]').val();
	var cntId = $('input[name=cntId]').val();
	
	var sname = $('input[name=sname]').val();
	var semail = $('input[name=semail]').val();
	var remail = $('input[name=remail]').val();
	
	if(sname.length < 2 || sname == Jnit_isLang("성명을 입력하세요.")) {
		alert(Jnit_isLang("성명을 입력하세요."));
		return;
	}
	
	if(semail.length < 2 || semail == Jnit_isLang("이메일 주소를 입력하세요.")) {
		alert(Jnit_isLang("보낸는이 이메일을 입력하세요."));
		return;
	}
	
	if(remail.length < 2 || remail == Jnit_isLang("이메일 주소를 입력하세요.")) {
		alert(Jnit_isLang("받는이 이메일을 입력하세요."));
		return;
	}
	
	$.ajax({
		type: "POST",
		url: '/board/send_email.do',
		data: {
			boardId: boardId,
			cntId: cntId,
			sname: sname,
			semail: semail,
			remail: remail
		},
		error: function(data) {
			alert("error: "+ data.status);
		},
		beforeSend: function(data){
			waitMessage();
		},
		success: function(data){
			//alert(data);
			alert(Jnit_isLang("발송했습니다."));
			$('#waitDialog').css('display','none');
			$('#myModal').modal('toggle');
			
		}
	});
};
var waitMessage = function (msg) {
	if(msg == null || msg == undefined) msg = Jnit_isLang("처리중입니다. 잠시만 기다려주세요.");
	$('#waitDialog').css('display','block');
};
//* 메일전송 버튼**//
$(document).on("click",'#sendMail',function(e){
	e.preventDefault();
	$('#myModal').modal('toggle');
	
});

$(document).on("click",'#sendMail_submit',function(e){
	e.preventDefault();
	sendMail();
});
//* 삭제 버튼**//
$(document).on("click",'#linkDelete',function(e){	
	if(confirm(Jnit_isLang("정말 삭제 하시겠습니까?"))){
		if($("#yourinput").val() != ""){
			var deletelink =document.getElementById("linkDelete").getAttribute("href");
			var yourinput = $("#yourinput").val();
			$("#linkDelete").prop("href", deletelink+"&yourinput="+yourinput);
		}
		return true;
	}else{
		e.preventDefault();
		return false;
	}
});
//* 비회원 삭제 버튼**//
$(document).on("click","#deletebtn",function(e){
	alert(Jnit_isLang("패스워드를 입력해주세요."));
	$("#yourinput").focus();
	$("#yourInput").css("display","inline-block");
	$("#deletebtn").css("display","none"); 
});
//* 비회원 삭제 취소 버튼**//
$(document).on("click","#deleteCancle",function(e){	
	$("#yourInput").css("display","none");
	$("#deletebtn").css("display","inline-block"); 
});
//* 영구삭제 버튼**//
$(document).on("click",'#linkAllDelete',function(e){
	var msg = Jnit_isLang("정말 삭제 하시겠습니까?")+"\n\n"
		     +Jnit_isLang("해당 게시물은 영구 삭제가 되며")+"\n\n"
		     +Jnit_isLang("관련된 모든 자료는 삭제가 됩니다.")+"";	
	if(confirm(Jnit_isLang(msg))){
		return true;
	}else{
		e.preventDefault();
		return false;
	}	
});

//* dateTimePicker**//
$(document).on("focus",'.datetime',function(e){
	$(this).datetimepicker({showSecond:true,dateFormat: 'yy-mm-dd',timeFormat: 'hh:mm:ss'});
	$(this).focus(function(){
		$("#ui-datepicker-div").css("z-index",999);
	});
});
//* datePicker**//
$(document).on("focus",'.date',function(e){
	$(this).datepicker({dateFormat: 'yy-mm-dd'});
	$(this).focus(function(){
		$("#ui-datepicker-div").css("z-index",999);
	});
});
//* minwon Manage**//
$(document).on("click",'#linkManage.minwon',function(e){
	e.preventDefault();
	var linkHref = $(this).attr('href');
	var manageWin = window.open(linkHref,'managePop','width=550, height=680, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no');
	if(!manageWin){
		alert(Jnit_isLang("팝업차단을 해제해주세요"));
	}
});
//* Article Manage**//
$(document).on("click",'#linkManage.article',function(e){
	e.preventDefault();
	var linkHref = $(this).attr('href');
	var manageWin = window.open(linkHref,'managePop','width=830, height=690, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=no');
	if(!manageWin){
		alert(Jnit_isLang("팝업차단을 해제해주세요"));
	}
});

var currentAddrInput = '';
//* address**//
$(document).on("click",'.address',function(e){
	currentAddrInput = $(this).attr('name');
	openZipcode(currentAddrInput);
});
//우편번호 찾기
function openZipcode(target){
	//log(target);
	var winUrl = ctxRoot + "/gis/zip.do?retForm=bbsForm"
	+ "&retAddr=" + target
	+ "&retFunction=boardZip"
	;
	var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0");
	winZip.focus();
}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
	$('input[name='+currentAddrInput+']').val(zipNo + " " +roadFullAddr);
	
	/*
	var addrDetail = "";
	if($('input[name='+currentAddrInput+']').val().search("\\(|\\~") > -1) {
		var addrArr = $('input[name='+currentAddrInput+']').val().split(" ");
		for(i=0;i<addrArr.length-1;i++){
			if( $.trim(addrArr[i]) != "") {
				addrDetail += $.trim(addrArr[i]) + " ";
			}
		}
	}else {
		addrDetail = $('input[name=tmpAddrDetail]').val();
	}
	*/
	
	currentAddrInput = '';

}

//* upfileAdd**//
$(document).on("click",'#upfileAdd',function(e){
	var cnt = $('div.upfileWrap .upfileElem').length + 1;
	/*
	if(cnt == 1){
		$('div.upfileWrap').append('<div class="upfileElem"><label for="upfile'+cnt+'" class="blind">'+Jnit_isLang("파일")+'</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"><label for="mainfile'+cnt+'">'+Jnit_isLang("대표")+'</label><input type="radio" name="mainfile" id="mainfile'+cnt+'" value="upfile'+cnt+'" checked="checked" /></div>');
	}else{
		$('div.upfileWrap').append('<div class="upfileElem"><label for="upfile'+cnt+'" class="blind">'+Jnit_isLang("파일")+'</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"><label for="mainfile'+cnt+'">'+Jnit_isLang("대표")+'</label><input type="radio" name="mainfile" id="mainfile'+cnt+'" value="upfile'+cnt+'" /></div>');
	}
	*/
	if(cnt == 1){
		$('div.upfileWrap').append('<div class="upfileElem"><label for="upfile'+cnt+'" class="blind">'+Jnit_isLang("파일")+'</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"></div>');
	}else{
		$('div.upfileWrap').append('<div class="upfileElem"><label for="upfile'+cnt+'" class="blind">'+Jnit_isLang("파일")+'</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"></div>');
	}
});
//* GalleryupfileAdd**//
$(document).on("click",'#GalleryupfileAdd',function(e){
	var cnt = $('div.upfileWrap .upfileElem').length + 1;
	/*
	if(cnt == 1){
		$('div.upfileWrap').append('<div class="upfileElem"><label for="upfile'+cnt+'" class="blind">'+Jnit_isLang("파일")+'</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"><label for="mainfile'+cnt+'">'+Jnit_isLang("대표")+'</label><input type="radio" name="mainfile" id="mainfile'+cnt+'" value="upfile'+cnt+'" checked="checked" /><br /><br /><label for="upfileAlt'+cnt+'">'+Jnit_isLang("이미지 ALT")+'</label><textarea id="upfileAlt'+cnt+'" name="upfileAlt'+cnt+'" ></textarea></div>');
	}else{
		$('div.upfileWrap').append('<div class="upfileElem"><label for="upfile'+cnt+'" class="blind">'+Jnit_isLang("파일")+'</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"><label for="mainfile'+cnt+'">'+Jnit_isLang("대표")+'</label><input type="radio" name="mainfile" id="mainfile'+cnt+'" value="upfile'+cnt+'" /><br /><br /><label for="upfileAlt'+cnt+'">'+Jnit_isLang("이미지 ALT")+'</label><textarea id="upfileAlt'+cnt+'" name="upfileAlt'+cnt+'" ></textarea></div>');
	}
	*/
	if(cnt == 1){
		$('div.upfileWrap').append('<div class="upfileElem"><label for="upfile'+cnt+'" class="blind">'+Jnit_isLang("파일")+'</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"></div>');
	}else{
		$('div.upfileWrap').append('<div class="upfileElem"><label for="upfile'+cnt+'" class="blind">'+Jnit_isLang("파일")+'</label> <input type="file" id="upfile'+cnt+'" name="upfile'+cnt+'"></div>');
	}
});
//* upfileDel**//
$(document).on("click",'#upfileDel',function(e){
	$('div.upfileWrap .upfileElem:last').remove();
});
function jnitBoardGood(){
	var boardId = $('input[name=boardId]').val();
	var cntId = $('input[name=cntId]').val();
	$.ajax({
		type: "POST",
		url: '/jnitboard/good.do',
		data: {
			boardId: boardId,
			boardCntId: cntId
		}
		}).done(function(data){
			
			resultList = jQuery.parseJSON(data);		
			if(resultList['join'] == true){
				alert(Jnit_isLang('이미 추천한 게시물 입니다'));
			}else{
				alert(Jnit_isLang('추천하셨습니다'));
				$('.viewbtn > .boardlike').html("<a href='#none' onclick='jnitBoardGood();return false;'  id='btnGood' class='btn' >"+resultList['totCnt']+Jnit_isLang("추천 하기")+"</a>");
			}
		});
};
//* List Category Select**//
$(document).on("change",'select[name="category"]',function(e){
	if($('input[name="mode"]').val() == 'list'){
		$('input[name="pageIdx"]').val('1');
		//$('form[name="bbsForm"]').submit();
	}
});
//* cmtEditSumit**//
$(document).on("click",'.btnEdit',function(e){
	
	$('.cmtId').val($(this).parent().parent().find('input').val());
	$('.modifyCmt').val($(this).parent().parent().find('textarea').val());
	if($('.modifyCmt').length==0){
		alert(Jnit_isLang('내용을 입력해 주세요'));
	}else{
		$('form[name="bbsCmtEditForm"]').submit();
	}
	
});
//* 덧글 삭제 버튼**//
$(document).on("click",'.cmtDelete',function(e){
	if(confirm(Jnit_isLang('정말 삭제 하시겠습니까?'))){
		return true;
	}else{
		e.preventDefault();
		return false;
	}
});

//* cmtEdit**//
$(document).on("click",'.cmt_edit',function(e){
	e.preventDefault();
	$(this).parent().parent().find('.edit_btn').css('display','none');
	$(this).parent().parent().find('.edit_cancelBtn').css('display','block');
	$(this).parent().parent().parent().parent().find('.editText').css('display','block');
	$(this).parent().parent().parent().parent().find('p').css('display','none');
});
$(document).on("click",'.cmt_edit_cancel',function(e){
	e.preventDefault();
	$(this).parent().parent().find('.edit_btn').css('display','block');
	$(this).parent().parent().find('.edit_cancelBtn').css('display','none');
	$(this).parent().parent().parent().parent().find('.editText').css('display','none');
	$(this).parent().parent().parent().parent().find('p').css('display','block');
	
});

//* bbsSubmit**//
var bbsSubmit = function(e){
	var valid = 1;
	if($('input').length>0){
		for(var i = 0;i<$('input').length;i++){
			for(var j = 0;j<blackArr.length;j++){
				if($('input')[i].value.toLowerCase().match(blackArr[j]) != null){
					alert(blackArr[j]+Jnit_isLang(' 는 사용하실 수 없습니다.'));
					valid = 0;
					$('input')[i].focus();
					if(e != undefined){
						e.preventDefault();
					}
					valid = 0;
					return false;
				}
			}
		}
	}
	if($('textarea').length>0){
		for(var i = 0;i<$('textarea').length;i++){
			for(var j = 0;j<blackArr.length;j++){
				if($('textarea')[i].value.toLowerCase().match(blackArr[j]) != null){
					alert(blackArr[j]+Jnit_isLang(' 는 사용하실 수 없습니다.'));
					$('textarea')[i].focus();
					valid = 0;
					if(e != undefined){
						e.preventDefault();
					}
					return false;
				}
			}
		}
	}
	
	
	//필수항목 입력여부	
	$.each($('form[name="bbsForm"] *[required]'),function(index,item){
		//alert($(item).val());
		if($(item).val()==""){
			var fId = $(item).attr('name');
			var fLbl = $('label[for="'+fId+'"]').text();
			alert(fLbl + Jnit_isLang("은(는) 필수항목입니다."));
			$(item).focus();
			if(e != undefined){
				e.preventDefault();
			}
			valid = 0;
			return false;
		}
	});
	$.each($('.boardEmail'),function(index,item){
		//alert($(item).val());
		var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
		var fId = $(item).attr('name');
		var fLbl = $('label[for="'+fId+'"]').text();
		if($(item).val()==""){
			alert(fLbl + Jnit_isLang("은(는) 필수항목입니다."));
			$(item).focus();
			if(e != undefined){
				e.preventDefault();
			}
			valid = 0;
			return false;
		}
		if (!$(item).val().match(regExp)){
			alert(fLbl + Jnit_isLang("을(를) 올바른 이메일 형식으로 입력해 주세요"));
			$(item).focus();
			if(e != undefined){
				e.preventDefault();
			}
			valid = 0;
			return false;
		}
	});
	
	if($("#date01").length>0 && $("#date02").length>0){
		var date1 = $("#date01").val();
		var year = date1.substring(0, 4);
		var month = date1.substring(5, 7);
		var day = date1.substring(8, 10);
		var hour = date1.substring(11, 13);
		var minute = date1.substring(14, 16);
		var second = date1.substring(17, 19);

		date1 = new Date(year, month, day, hour, minute, second);
		
		var date2 = $("#date02").val();
		year = date2.substring(0, 4);
		month = date2.substring(5, 7);
		day = date2.substring(8, 10);
		hour = date2.substring(11, 13);
		minute = date2.substring(14, 16);
		second = date2.substring(17, 19);

		date2 = new Date(year, month, day, hour, minute, second);
		
		if(date1>date2){
			alert(Jnit_isLang("시작 날짜가 종료 날짜보다 더 큽니다."));
			if(e != undefined){
				e.preventDefault();
			}
			valid = 0;
			return false;
		}
	}
	
	if($('select[name="category"]').length>0 && $('input[name="mode"]').val() == 'proc'){
		if($('select[name="category"] option:selected').val() == ''){
			alert($('label[for="category"]').text() + Jnit_isLang('는 필수항목입니다.'));
			$('select[name="category"]').focus();
			if(e != undefined){
				e.preventDefault();
			}
			valid = 0;
			return false;
		}
	}
	//개인정보제공 동의 여부확인
	if($("input[type='checkbox'][value*='"+Jnit_isLang("개인정보제공")+"']").length>0){
		if(!$("input[type='checkbox'][value*='"+Jnit_isLang("개인정보제공")+"']").is(":checked")){
			alert(Jnit_isLang("개인정보제공 동의는 필수항목입니다."));
			$("input[type='checkbox'][value*='"+Jnit_isLang("개인정보제공")+"']").focus();
			if(e != undefined){
				e.preventDefault();
			}
			valid = 0;
			return false;
		}
	}
	
	if($('#tx_trex_container').length>0){
	   	var movies = Editor.getSidebar().getAttachments("movie");
	   	$('input[name="tx_attach_movie[]"]').remove();
	   	for (var i = 0, len = movies.length; i < len; i++) {
	   		$('#tx_trex_container').append('<input type="hidden" name="tx_attach_movie[]" value = "' + movies[i].data.ukey + '" />');
	   	}
	   	var images = Editor.getSidebar().getAttachments("image");
	   	$('input[name="tx_attach_image[]"]').remove();
	   	for (var i = 0, len = images.length; i < len; i++) {
	   		$('#tx_trex_container').append('<input type="hidden" name="tx_attach_image[]" value = "' + images[i].data.fileid + '" />');
	   	}
	   	log("editor");
	   	var frm = document.getElementById("tx_canvas_wysiwyg");
	    if (frm == null) return;

	    var fDoc = frm.contentWindow || frm.contentDocument;
	    if (fDoc.document) {
	      fDoc = fDoc.document;
	    }

	    //fDoc.body.style.backgroundColor = "red";
			for(var j = 0;j<blackArr.length;j++){
				if(fDoc.body.outerText.toLowerCase().match(blackArr[j]) != null){
					alert(blackArr[j]+Jnit_isLang(' 는 사용하실 수 없습니다.'));
					valid = 0;
					if(e != undefined){
						e.preventDefault();
					}
					return false;
				}
			}
		
		
	   	
	   	if($('#boardUseFilter').length>0){
		/*	
			if(document.getElementsByName('content').length>0){
				var cntLen = document.getElementsByName('content').length;
				for(var i=0; i<cntLen;i++){
					document.getElementsByName('content')[0].remove();
				}
			}*/
	   		var element = document.getElementsByTagName("textarea");
		   	for (index = element.length - 1; index >= 0; index--) {
		   	    element[index].parentNode.removeChild(element[index]);
		   	}
		}
	   	
		/*필터가 1일때 걸렸던 content가 있을 수 있으니, 있으면 먼저 지워라*/
	   	if(e != undefined) e.preventDefault();
	   	if(valid ==1){
	   		Editor.save();
	   	}
	}
	if(useWyswygType == "smartEditor"){
		smartEditor.setText("Jnit_edit");
	}
	if(e == undefined){
		if(valid ==1){
			$('form[name="bbsForm"]').submit();
		}
	}
};
var bbsCmtSubmit = function(e){
	var valid = 1;
	//필수항목 입력여부
	$.each($('form[name="bbsCmtForm"] *[required]'),function(index,item){
		if($(item).val()==""){
			var fId = $(item).attr('name');
			var fLbl = $('label[for="'+fId+'"]').text();
			alert(fLbl + Jnit_isLang("은(는) 필수항목입니다."));
			$(item).focus();
			if(e != undefined){
				e.preventDefault();
			}
			valid = 0;
			return false;
		}
	});
	if(e == undefined){
		if(valid ==1){
			$('form[name="bbsCmtForm"]').submit();
		}
	}
};
var bbsCmtEdit = function(e){
	log("submit");
	var valid = 1;
	//필수항목 입력여부
	$.each($('form[name="bbsCmtEditForm"] *[required]'),function(index,item){
		if($(item).val()==""){
			var fId = $(item).attr('name');
			var fLbl = $('label[for="'+fId+'"]').text();
			alert(fLbl + Jnit_isLang("은(는) 필수항목입니다."));
			$(item).focus();
			if(e != undefined){
				e.preventDefault();
			}
			valid = 0;
			return false;
		}
	});
	if(e == undefined){
		if(valid ==1){
			$('form[name="bbsCmtEditForm"]').submit();
		}
	}
};
/* WYSIWIG Editro Function */
var validForm = function(editor) {
	// Place your validation logic here

	// sample : validate that content exists
	var validator = new Trex.Validator();
	var content = editor.getContent();

	if (!validator.exists(content)) {
		alert(Jnit_isLang('내용을 입력하세요'));
		return false;
	}

	return true;
};
var setForm = function(editor) {
	var formGenerator = editor.getForm();
	var content = editor.getContent();
	//console.log(content);
	formGenerator.createField(
			tx.textarea({
				'name': "content", // 본문 내용을 필드를 생성하여 값을 할당하는 부분
				'style': { 'display': "none" }
			}, content)
	);
	return true;
};
/*
var setModify = function(){
	Editor.modify({
	    /"attachments": function() { // 저장된 첨부가 있을 경우 배열로 넘김, 위의 부분을 수정하고 아래 부분은 수정없이 사용 
	        var allattachments = [];
	        for (var i in attachments) {
	            allattachments = allattachments.concat(attachments[i]);
	        }
	        return allattachments;
	    }(),/
	    "content": document.getElementById("origin_bbs_text") / 내용 문자열, 주어진 필드(textarea) 엘리먼트 /
	});	
};
*/
/* End of WYSIWIG Editro Function */

//댓글 추가
function Jnit_boardCmtAdd(url){
	$.ajax({
		type : "post",
		url : url,
		data: $("#bbsForm").serialize()
	}).done(function(data){
		$("#Jnit_boardCmt").empty();
		$("#Jnit_boardCmt").append(data);
		$("#cmtsubmit_text").val("");
		$("#cmtsubmit_text").focus();
	});
}

//댓글 수정
function Jnit_boardCmtEdit(boardId,cntId,cmtId,url){
	var cmtEditarea = $("#cmtEditarea_"+cmtId).val();
	if(confirm(Jnit_isLang("수정하시겠습니까?"))){
		if(cmtEditarea != ''){
			$.ajax({
				type : "post",
				url : url,
				data: "boardId="+boardId+"&cntId="+cntId+"&cmtId="+cmtId+"&cmtEditarea="+cmtEditarea
			}).done(function(data){
				$("#Jnit_boardCmt").empty();
				$("#Jnit_boardCmt").append(data);
			});
		}
	}	
}

//댓글 삭제
function Jnit_boardCmtDel(boardId,cntId,cmtId,url,type){
	if(confirm(Jnit_isLang("정말 삭제하시겠습니까?"))){
		if(cmtId != ''){
			$.ajax({
				type : "post",
				url : url,
				data: "boardId="+boardId+"&cntId="+cntId+"&cmtId="+cmtId+"&type="+type
			}).done(function(data){
				$("#Jnit_boardCmt").empty();
				$("#Jnit_boardCmt").append(data);
			});
		}
	}	
}

//댓글 기본셋팅
$(document).ready(function(){
	var boarcmtUrl = $("#boarcmtUrl").val();
	if(boarcmtUrl != null){
		$.ajax({
			type : "post",
			url : boarcmtUrl,
			data: $("#bbsForm").serialize()
		}).done(function(data){
			$("#Jnit_boardCmt").empty();
			$("#Jnit_boardCmt").append(data);
		});
	}
});


function Jnit_img_upload(url){	
	window.open(url,'imgFileEdit','width=370, height=410, toolbar=no, scrollbars=yes, status=yes, resizable=yes');
}

function Jnit_boardDownload(url,countUrl,num){	
	$.ajax({
		type : "post",
		url : countUrl,
		data : ""
	}).done(function(data){		
		var json = $.parseJSON(data);
		if(json.status == 'success'){
			if(json.count !=  '') {			
				$("#download"+num).empty();			
				$("#download"+num).append(Jnit_isLang("다운로드 ")+json.count+" "+Jnit_isLang("회"));
				location.href = url;    
			}
		}else{
			if(json.message == 'FIAL 1'){
				alert(Jnit_isLang("다운로드 권한이 없습니다."));
			}else if(json.message == 'FIAL 2'){
				alert(Jnit_isLang("로그인후 이용이 가능합니다."));
			}else{
				alert(Jnit_isLang("다운로드 할 수 없습니다."));
			}
		}
	});
}

function Jnit_isLang(str){	
	if("정말 삭제 하시겠습니까?" == str){
		if(lang == "eng"){
			str = 'Do you really delete?';
		}else if(lang == "chi"){
			str = '是否要删除？';
		}else if(lang == "japan"){
			str = '本当に削除しますか？';
		}
	}else if("성명을 입력하세요." == str){
		if(lang == "eng"){
			str = 'Please enter your name.';
		}else if(lang == "chi"){
			str = '请输入姓名';
		}else if(lang == "japan"){
			str = '氏名を入力してください。';
		}
	}else if("이메일 주소를 입력하세요." == str){
		if(lang == "eng"){
			str = 'Please enter your e-mail address.';
		}else if(lang == "chi"){
			str = '请输入电子邮件地址';
		}else if(lang == "japan"){
			str = 'メールアドレスを入力してください。';
		}
	}else if("처리중입니다. 잠시만 기다려주세요." == str){
		if(lang == "eng"){
			str = 'Being processed. Please wait a moment.';
		}else if(lang == "chi"){
			str = '处理中，请稍后';
		}else if(lang == "japan"){
			str = '処理中です。しばらくお待ちください。';
		}
	}else if("팝업차단을 해제해주세요" == str){
		if(lang == "eng"){
			str = 'Please unbrick pup-up block';
		}else if(lang == "chi"){
			str = '请解除关闭弹出窗';
		}else if(lang == "japan"){
			str = 'ポップアップブロックを無効にしてください';
		}
	}else if("파일" == str){
		if(lang == "eng"){
			str = 'File';
		}else if(lang == "chi"){
			str = '文件';
		}else if(lang == "japan"){
			str = '文件';
		}
	}else if("대표" == str){
		if(lang == "eng"){
			str = 'Prime';
		}else if(lang == "chi"){
			str = '代表';
		}else if(lang == "japan"){
			str = '表示';
		}
	}else if("이미지 ALT" == str){
		if(lang == "eng"){
			str = 'The image ALT';
		}else if(lang == "chi"){
			str = '图片说明';
		}else if(lang == "japan"){
			str = '图片ALT';
		}
	}else if('이미 추천한 게시물 입니다' == str){
		if(lang == "eng"){
			str = 'You already recommended';
		}else if(lang == "chi"){
			str = '已推荐的贴子';
		}else if(lang == "japan"){
			str = '既に推薦された記事です。';
		}
	}else if('추천하셨습니다' == str){
		if(lang == "eng"){
			str = 'Your recommendation has been registered';
		}else if(lang == "chi"){
			str = '推荐完成';
		}else if(lang == "japan"){
			str = 'おすすめました';
		}
	}else if('내용을 입력해 주세요' == str){
		if(lang == "eng"){
			str = 'Please input content';
		}else if(lang == "chi"){
			str = '请输入内容';
		}else if(lang == "japan"){
			str = '内容を入力してください';
		}
	}else if(' 는 사용하실 수 없습니다.' == str){
		if(lang == "eng"){
			str = ' can not be used'; //"Specified Words" can not be used.
		}else if(lang == "chi"){
			str = ' 禁止使用'; //“特定词汇”禁止使用
		}else if(lang == "japan"){
			str = ' は使用することができません。';
		}
	}else if("은(는) 필수항목입니다." == str){
		if(lang == "eng"){
			str = 'is mandatory'; //"Free Posting" is mandatory
		}else if(lang == "chi"){
			str = '为必选项'; //“自由公告栏”为必选项
		}else if(lang == "japan"){
			str = 'は必須項目です。';
		}
	}else if("시작 날짜가 종료 날짜보다 더 큽니다." == str){
		if(lang == "eng"){
			str = 'Chronological error. Beginning date is bigger than the closing date';
		}else if(lang == "chi"){
			str = '开始日期大于结束日期';
		}else if(lang == "japan"){
			str = '開始日が終了日よりも大きくなります。';
		}
	}else if('는 필수항목입니다.' == str){
		if(lang == "eng"){
			str = 'is mandatory';
		}else if(lang == "chi"){
			str = '为必选项'; //“标题”为必选项
		}else if(lang == "japan"){
			str = 'は必須項目です。';
		}
	}else if("개인정보제공" == str){
		if(lang == "eng"){
			str = 'Personal information provision';
		}else if(lang == "chi"){
			str = '个人信息提供';
		}else if(lang == "japan"){
			str = '個人情報の提供';
		}
	}else if("개인정보제공 동의는 필수항목입니다." == str){
		if(lang == "eng"){
			str = 'Agreement on personal information provision is mandatory';
		}else if(lang == "chi"){
			str = '个人信息提供同意为必选项';
		}else if(lang == "japan"){
			str = '個人情報提供の同意は必須項目です。';
		}
	}else if("보낸는이 이메일을 입력하세요." == str){
		if(lang == "eng"){
			str = "Enter sender's e-mail.";
		}else if(lang == "chi"){
			str = '请输入发送人电子邮件地址';
		}else if(lang == "japan"){
			str = '宛ての電子メールを入力してください。';
		}
	}else if("받는이 이메일을 입력하세요." == str){
		if(lang == "eng"){
			str = "Enter recipient's e-mail.";
		}else if(lang == "chi"){
			str = '请输入收件人电子邮件地址';
		}else if(lang == "japan"){
			str = '受取人のメールを入力してください。';
		}
	}else if("발송했습니다." == str){
		if(lang == "eng"){
			str = 'Sent';
		}else if(lang == "chi"){
			str = '已发送';
		}else if(lang == "japan"){
			str = '発送しました';
		}
	}else if("회" == str){
		if(lang == "eng"){
			str = 'times';
		}else if(lang == "chi"){
			str = '次';
		}else if(lang == "japan"){
			str = '회';
		}
	}else if("다운로드" == str){
		if(lang == "eng"){
			str = 'download';
		}else if(lang == "chi"){
			str = '下载';
		}else if(lang == "japan"){
			str = 'ダウンロード';
		}
	}else if("수정하시겠습니까?" == str){
		if(lang == "eng"){
			str = 'Do you want to edit it?';
		}else if(lang == "chi"){
			str = '你想编辑？';
		}else if(lang == "japan"){
			str = '修正しますか？';
		}
	}else if("정말 삭제하시겠습니까?" == str){
		if(lang == "eng"){
			str = 'Are you sure you want to delete?';
		}else if(lang == "chi"){
			str = '你确定要删除?';
		}else if(lang == "japan"){
			str = '本当に削除しますか?';
		}
	}else if("내용을 입력하세요" == str){
		if(lang == "eng"){
			str = 'Please enter your content';
		}else if(lang == "chi"){
			str = '请输入您的信息';
		}else if(lang == "japan"){
			str = '内容を入力してください';
		}
	}else if("해당 파일은 업로드 하실 수 없습니다" == str){
		if(lang == "eng"){
			str = "These files can not be uploaded";
		}else if(lang == "chi"){
			str = "该文件无法上传";
		}else if(lang == "japan"){
			str = "これらのファイルは、アップロードすることができません";
		}
	}else if("마우스로 원하는 파일을 넣어주세요" == str){
		if(lang == "eng"){
			str = "Drag the file with your mouse";
		}else if(lang == "chi"){
			str = "用鼠标拖动文件";
		}else if(lang == "japan"){
			str = "マウスでファイルをドラッグ来る";
		}
	}else if("파일 추가" == str){
		if(lang == "eng"){
			str = "Add file";
		}else if(lang == "chi"){
			str = "添加文件";
		}else if(lang == "japan"){
			str = "ファイルの追加";
		}
	}else if("삭제할 파일을 선택해 주세요" == str){
		if(lang == "eng"){
			str = "Please select a file to delete";
		}else if(lang == "chi"){
			str = "请选择要删除的文件";
		}else if(lang == "japan"){
			str = "削除するファイルを選択してください";
		}
	}else if("선택하신 파일을 삭제하시겠습니까?" == str){
		if(lang == "eng"){
			str = "Are you sure you want to delete the selected file (s)?";
		}else if(lang == "chi"){
			str = "你确定要删除选定的文件？";
		}else if(lang == "japan"){
			str = "選択したファイルを削除しますか？";
		}
	}else if("다운로드할 파일을 선택해 주세요" == str){
		if(lang == "eng"){
			str = "Please select a file to download";
		}else if(lang == "chi"){
			str = "请选择要下载的文件";
		}else if(lang == "japan"){
			str = "ダウンロードするファイルを選択してください";
		}
	}else if("확장자는 업로드가 불가능 합니다." == str){
		if(lang == "eng"){
			str = "This extension can not be uploaded.";
		}else if(lang == "chi"){
			str = "这个扩展不会上传.";
		}else if(lang == "japan"){
			str = "この拡張子は、アップロードができません。";
		}
	}else if("파일 용량은" == str){//파일 폼 업로드 전용
		if(lang == "eng"){
			str = "The file size can not exceed ";
		}else if(lang == "chi"){
			str = "文件大小不能超过";
		}else if(lang == "japan"){
			str = "ファイルサイズは、";
		}
	}else if("파일 개수는" == str){//파일 폼 업로드 전용
		if(lang == "eng"){
			str = "The number of files can not exceed ";
		}else if(lang == "chi"){
			str = "文件数不能超过";
		}else if(lang == "japan"){
			str = "ファイルの数は、";
		}
	}else if("를 초과할 수 없습니다." == str){
		if(lang == "eng"){
			str = " ";
		}else if(lang == "chi"){
			str = " ";
		}else if(lang == "japan"){
			str = "を超えることはできません。";
		}
	}else if("추천 하기" == str){
		if(lang == "eng"){
			str = "Recommend";
		}else if(lang == "chi"){
			str = "推荐";
		}else if(lang == "japan"){
			str = "喜欢";
		}
	}else if("파일만 업로드 할수 있습니다." == str){
		if(lang == "eng"){
			str = "Only files can be uploaded.";
		}else if(lang == "chi"){
			str = "只有文件，您可以上传。";
		}else if(lang == "japan"){
			str = "ファイルのみをアップロードすることができます。";
		}
	}else if("패스워드를 입력해주세요." == str){
		if(lang == "eng"){
			str = "Please enter your password.";
		}else if(lang == "chi"){
			str = "请输入您的密码。";
		}else if(lang == "japan"){
			str = "パスワードを入力してください。";
		}
	}else if("해당 게시물은 영구 삭제가 되며" == str){
		if(lang == "eng"){
			str = "This post will be permanently deleted and all related materials will be deleted.";
		}else if(lang == "chi"){
			str = "这个职位是一个永久删除相关的将被删除的所有数据。";
		}else if(lang == "japan"){
			str = "この記事は、完全に削除がされて";
		}
	}else if("관련된 모든 자료는 삭제가 됩니다." == str){
		if(lang == "eng"){
			str = "";
		}else if(lang == "chi"){
			str = "";
		}else if(lang == "japan"){
			str = "関連するすべてのデータは削除がされます。";
		}
	}else if("을(를) 올바른 이메일 형식으로 입력해 주세요" == str){
		if(lang == "eng"){
			str = "Please enter in the correct email format";
		}else if(lang == "chi"){
			str = "请输入一个有效的电子邮件格式";
		}else if(lang == "japan"){
			str = "有効なメールの形式で入力してください";
		}
	}else if("다운로드 권한이 없습니다." == str){
		if(lang == "eng"){
			str = "You do not have permission to download.";
		}else if(lang == "chi"){
			str = "您没有权限下载。";
		}else if(lang == "japan"){
			str = "ダウンロード権限がありません。";
		}
	}else if("로그인후 이용이 가능합니다." == str){
		if(lang == "eng"){
			str = "It is available after login.";
		}else if(lang == "chi"){
			str = "登录后可用。";
		}else if(lang == "japan"){
			str = "ログイン後利用が可能です。";
		}
	}else if("다운로드 할 수 없습니다." == str){
		if(lang == "eng"){
			str = "Can not download.";
		}else if(lang == "chi"){
			str = "你不能下载。";
		}else if(lang == "japan"){
			str = "ダウンロードすることができません。";
		}
	}
	
	return str;
}

