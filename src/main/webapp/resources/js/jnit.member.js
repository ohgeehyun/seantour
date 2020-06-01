$(document).ready(function(){

	var tel = $('#tel').val();
	if(tel != null){
		var tels = tel.split("-");
		$('#tel1').val(tels[0]);
		$('#tel2').val(tels[1]);
		$('#tel3').val(tels[2]);
	}
	var mobile = $('#mobile').val();	
	if(mobile != null){
		var mobiles = mobile.split("-");
		$('#mobile1').val(mobiles[0]);
		$('#mobile2').val(mobiles[1]);
		$('#mobile3').val(mobiles[2]);
	}
	
	var establishment = $('#establishment').val();
	if(establishment != null){
		var establishments = establishment.split("-");
		$('#establishment1').val(establishments[0]);
		$('#establishment2').val(establishments[1]);
		$('#establishment3').val(establishments[2]);
	}
	var corporation = $('#corporation').val();
	if(corporation != null){
		var corporations = corporation.split("-");
		$('#corporation1').val(corporations[0]);
		$('#corporation2').val(corporations[1]);		
	}
	var primaryKey = $('#primaryKey').val();
	if(primaryKey != null){
		var primaryKeys = primaryKey.split("-");
		$('#primaryKey1').val(primaryKeys[0]);
		$('#primaryKey2').val(primaryKeys[1]);
		$('#primaryKey3').val(primaryKeys[2]);
	}
	var businessPlace = $('#businessPlace').val();
	if(businessPlace != null){
		var businessPlaces = businessPlace.split("-");
		$('#businessPlace1').val(businessPlaces[0]);
		$('#businessPlace2').val(businessPlaces[1]);		
	}
	var groupTel = $('#groupTel').val();
	if(groupTel != null){
		var groupTels = groupTel.split("-");
		$('#groupTel1').val(groupTels[0]);
		$('#groupTel2').val(groupTels[1]);
		$('#groupTel3').val(groupTels[2]);
	}
	var groupPax = $('#groupPax').val();
	if(groupPax != null){
		var groupPaxs = groupPax.split("-");
		$('#groupPax1').val(groupPaxs[0]);
		$('#groupPax2').val(groupPaxs[1]);
		$('#groupPax3').val(groupPaxs[2]);
	}
	var anpost = $('#anpost').val();
	if(anpost != null){
		$('#post').val(anpost);
	}
	var anAddr = $('#anAddr').val();
	if(anAddr != null){
		$('#addr').val(anAddr);
	}
	var anAddr2 = $('#anAddr2').val();
	if(anAddr2 != null){
		var anAddrs2 = anAddr2.split("-");		
		if(anAddrs2.length == 3){
			$('#addr2').val(anAddrs2[0]);
			$('#addrDetail2').val(anAddrs2[1]+"-"+anAddrs2[2]);
		}else if(anAddrs2.length == 2){
			$('#addr2').val(anAddrs2[0]);
			$('#addrDetail2').val(anAddrs2[1]);
		}else{
			$('#addr2').val(anAddr2);
		}
	}
	var anBusinessAddr = $("#anBusinessAddr").val();
	if(anBusinessAddr != null){
		var anBusinessAddrs = anBusinessAddr.split("-");
		if(anBusinessAddrs.length == 3){
			$('#businessAddr').val(anBusinessAddrs[0]);
			$('#businessAddrDetail').val(anBusinessAddrs[1]+"-"+anBusinessAddrs[2]);
		}else if(anBusinessAddrs.length == 2){
			$('#businessAddr').val(anBusinessAddrs[0]);
			$('#businessAddrDetail').val(anBusinessAddrs[1]);
		}else{
			$('#businessAddr').val(anBusinessAddrs[0]);			
		}
	}
	
	var anBusinessAddr2 = $("#anBusinessAddr2").val();
	if(anBusinessAddr2 != null){
		var anBusinessAddrs2 = anBusinessAddr2.split("-");
		if(anBusinessAddrs2.length == 3){
			$('#businessAddr2').val(anBusinessAddrs2[0]);
			$('#businessAddrDetail2').val(anBusinessAddrs2[1]+"-"+anBusinessAddrs2[2]);
		}else if(anBusinessAddrs2.length == 2){
			$('#businessAddr2').val(anBusinessAddrs2[0]);
			$('#businessAddrDetail2').val(anBusinessAddrs2[1]);
		}else{
			$('#businessAddr2').val(anBusinessAddrs2[0]);			
		}
	}
	
	$('#nav').find('li').click(function(){
		var idex = $(this).index();
		$('#tabs').attr('value', $(this).attr('id'));
		$('#tab').attr('value', $('.tab-pane').eq(idex).attr('id'));			
	});
});

$(document).on("click","#idCheck",function(e){
	e.preventDefault();	
	$("#member").empty();
	$('#IDCheck').val('0');
	var localYn = $("#localYn").val();
	var mbrLogin  = $("#mbrLogin").val();
	var groupId = $("#groupId").val();
	
	if(groupId != null){
		mbrLogin = groupId;
	}	
	if(mbrLogin == ""){		
		$("#member").append("<font color='red'>아이디를 입력해주세요</font>");
		//$("#myModal").modal('show');
		$("#myModal").css('display','block');
		return false;
	}
	var patten = /^[a-zA-Z0-9]+$/;	
	if(mbrLogin.match(patten) == null){		
		$("#member").append("<font color='red'>아이디는 영문,숫자만 쓸 수 있습니다.</font>");
		//$("#myModal").modal('show');
		$("#myModal").css('display','block');
		return false;
	}
	var site = $("#site").val();	
	$.ajax({
		type:"POST",
		url: (localYn == 'Y' ? "../.." : "")+"/mbr/idcheck.do",
		data:"mbrLogin="+mbrLogin+"&site="+site,
	}).done(function(data){
			var resData = "";
			eval("resData = " + $.trim(data));			
			if(resData.status == "ok"){
				$('#IDCheck').val('1');
			}
			$("#member").append(resData.message);
			//$("#myModal").modal('show');
			$("#myModal").css('display','block');
	});
});

$("#IdCheck").click(function(e){
	e.preventDefault();		
	$("#member").empty();
	$('#IDCheck').val('0');
	var mbrLogin  = $("#mbrLogin").val();
	var groupId = $("#groupId").val();
	
	if(groupId != null){
		mbrLogin = groupId;
	}	
	if(mbrLogin == ""){		
		alert('아이디를 입력해주세요');
		return false;
	}
	var patten = /^[a-zA-Z0-9]+$/;	
	if(mbrLogin.match(patten) == null){		
		alert('아이디는 영문,숫자만 쓸 수 있습니다.');
		return false;
	}
	var site = $("#site").val();
	$.ajax({
		type:"POST",
		url: "/mbr/idcheck.do",
		data:"mbrLogin="+mbrLogin+"&site="+site,
	}).done(function(data){			
			var resData = "";
			eval("resData = " + $.trim(data));			
			if(resData.status == "ok"){
				$('#IDCheck').val('1');
			}
			alert(resData.message);			
	});
});
//개인회원가입 passwd blur
$(document).on("blur","#passwd", function(e){
	e.preventDefault();
	$('#pawConfirm').empty();
	var passwd = $('#passwd').val();
	var passwdConfirm = $('#passwdConfirm').val();
	var patten = /^[a-zA-Z0-9]/;
	var id = "pawConfirm";
	setOnblur(id, passwd, passwdConfirm, patten);
});
//End 개인회원가입 passwd blur

//개인회원가입 passwdConfirm blur
$(document).on("blur","#passwdConfirm", function(e){
	e.preventDefault();
	$('#pawConfirm').empty();
	var passwd = $('#passwd').val();
	var passwdConfirm = $('#passwdConfirm').val();
	var patten = /^[a-zA-Z0-9]/;
	var id = "pawConfirm";
	setOnblur(id, passwd, passwdConfirm, patten);
});
//End 개인회원가입 passwdConfirm blur

//단체회원 passwd blur
$(document).on("blur","#groupPasswd", function(e){
	e.preventDefault();	
	$('#groupPawConfirm').empty();
	var passwd = $('#groupPasswd').val();
	var passwdConfirm = $('#groupPasswdConfrim').val();
	var patten = /^[a-zA-Z0-9]/;
	var id = "groupPawConfirm";
	setOnblur(id, passwd, passwdConfirm, patten);
	
});
//End 단체회원 passwd blur

//단체회원 passwdConfirm blur
$(document).on("blur","#groupPasswdConfrim", function(e){
	e.preventDefault();
	$('#groupPawConfirm').empty();
	var passwd = $('#groupPasswd').val();
	var passwdConfirm = $('#groupPasswdConfrim').val();
	var patten = /^[a-zA-Z0-9]/;
	var id = "groupPawConfirm";
	setOnblur(id, passwd, passwdConfirm, patten);	
});
//End 단체회원 passwdConfirm blur

//setOnblur
function setOnblur(Name, value, valueConfirm, patten){
	if(valueConfirm != ''){
		if(!Jnit_rexgex(value)){
			$("#"+Name+"").append('<strong>특수문자 하나이상포합해야합니다.</strong>');
		}else if(value.match(patten) == null || value.length < 10 || value.length > 16){
			$("#"+Name+"").append('<strong>영문, 숫자, 특수문자로 조합된 10~16자 이내로 써주시기 바랍니다.</strong>');
		}else if(value == valueConfirm){
			$("#"+Name+"").append('<strong>사용가능한 비밀번호입니다.</strong>');
		}else{
			$("#"+Name+"").append('<strong>비밀번호가 틀립니다.</strong>');
		}
	}else{
		$("#"+Name+"").append("<strong>비밀번호를 다시입력해주세요</strong>");
	}
}
//End setOnblur

//특수문자 체크
function Jnit_rexgex(passwd){
	var regexList = "!,@,#,$,%,^,&,*,(,),_,-,+,~,`,{,},<,>,?,:,\",;,'";
	var regex = regexList.split(",");
	var regexbln = false;
	for(var i=0; i<regex.length; i++){		
		if(passwd.indexOf(regex[i]) > -1){
			regexbln = true;
			break;
		}
	}	
	return regexbln;
}
//End 특수문자 체크

$(document).on("click", "#postFind", function(e){
	e.preventDefault();	
	newZipSearch(e);
	
});

function newZipSearch(e) {	
	e.preventDefault();
	var localYn = $("#localYn").val();
	var url = (localYn == 'Y' ? "../.." : "")+"/gis/zip.do?retForm=mbrForm"
			+"&retZip1=post1"
			+"&retZip2=post2"
			+"&retAddr=addr"
			+"&retAddrDetail=addrDetail"			
			+"&retNewaddr=addr2"
			+"&retNewaddrDetail=addrDetail2"
			/*
			+"&retFunction=afterAddress"
			*/
			;
	
	var zipPop = window.open(url, "새주소검색", "width=600,height=500,top=0,left=0,scrollbars=yes");
	zipPop.focus();
}

$(document).on("click", "#postFindGroup", function(e){
	e.preventDefault();	
	groupDefaultNewZipSearch(e);
	
});

function groupDefaultNewZipSearch(e) {	
	e.preventDefault();
	var localYn = $("#localYn").val();
	var url = (localYn == 'Y' ? '../..':'')+"/gis/zip.do?retForm=groupMbrForm"
			+"&retZip1=post1"
			+"&retZip2=post2"
			+"&retAddr=addr"			
			+"&retAddrDetail=addrDetail"
			+"&retNewaddr=addr2"
			+"&retNewaddrDetail=addrDetail2"
			/*
			+"&retFunction=afterAddress"
			*/
			;
	
	var zipPop = window.open(url, "새주소검색", "width=600,height=500,top=0,left=0,scrollbars=yes");
	zipPop.focus();
}

$(document).on("click", "#groupPostFind", function(e){
	e.preventDefault();	
	groupNewZipSearch(e);
	
});

function groupNewZipSearch(e) {	
	e.preventDefault();
	var localYn = $("#localYn").val();
	alert(localYn);
	var url = (localYn == 'Y' ? '../..':'')+"/gis/zip.do?retForm=groupMbrForm"
			+"&retZip1=businessPlace1"
			+"&retZip2=businessPlace2"
			+"&retAddr=businessAddr"			
			+"&retAddrDetail=businessAddrDetail"			
			+"&retNewaddr=businessAddr2"
			+"&retNewaddrDetail=businessAddrDetail2"
			/*
			+"&retFunction=afterAddress"
			*/
			;
	
	var zipPop = window.open(url, "새주소검색", "width=600,height=500,top=0,left=0,scrollbars=yes");
	zipPop.focus();
}

function checkDP(){
	var site = $('#site').val();
	var checkout = $('#checkout').val();
	var checkIn ="Y";
	var localYn = $("#localYn").val();	
	$.ajax({		
		type:"POST",		
		url: (localYn == 'Y' ? "../.." : "")+"/mbr/isMbrSn.do",
		data: "checkout="+checkout+"&checkIn="+checkIn
	}).done(function(data){	
		var resData =  $.trim(data);
		eval("resData ="+$.trim(data));
		
		if(resData.message == "FAIL0") {
			alert("만19세 이상 고객만 가입가능합니다.");
			location.replace((localYn == 'Y' ? "../.." : "")+"/"+site);
			return;
		}
		if(resData.message == "FAIL1") {
			alert("이미 가입된 사용자입니다.");
			location.replace((localYn == 'Y' ? "../.." : "")+"/"+site);
			return;
		}
		if(resData.message == "FAIL2") {
			alert("실명인증 후 이용하세요.");			
			location.replace((localYn == 'Y' ? "../.." : "")+"/"+site);
			return;
		}
		if(resData.message == "FAIL6"){
			alert("로그인을 해주시기 바랍니다.");
			location.replace((localYn == 'Y' ? "../.." : "")+"/"+site);
		}
		if(resData.message == "FAIL7"){
			alert("비회원 로그인은 회원가입을 해주시기 바랍니다.");
			location.replace((localYn == 'Y' ? "../.." : "")+"/"+site);
		}
	});	
}
$(document).on("click","#memberCancel",function(e){
	e.preventDefault();
	if(confirm("회원탈퇴시 데이터는 복구될수없습니다 정말탈퇴 하시겠습니까?") == true){		
		/*$('#member').empty();
		$('#messageConfirm').empty();
		$('#member').append("<input type='password' name='mbrPasswd' id='mbrPasswd'/><div id='messageConfirm'><strong>비밀번호를 입력해주시기 바랍니다.</strong></div>");		
		$('#myModal').modal('show');*/
		
		$('#member').empty();
		$('#messageConfirm').empty();
		$('#member').append("<input type='password' name='mbrPasswd' id='mbrPasswd'/><div id='messageConfirm'><strong>비밀번호를 입력해주시기 바랍니다.</strong></div>");
		$("#myModal").css('display','block');
	}	
});

$(document).on("click", "#modal_colse", function(e){	
	$('#member').empty();
	$('#messageConfirm').empty();
	$("#myModal").css('display','none');
	e.preventDefault();
});

$(document).on("click","#signGo",function(e){
	e.preventDefault();
	var passwd = $('#mbrPasswd').val();
	var site = $('#site').val();
	var next = $('#next').val();
	var localYn = $("#localYn").val();
	if(passwd == ''){
		alert("비밀번호를 입력해 주시기 바랍니다.");
		return false;
	}	

	$.ajax({
		type:"POST",
		url:(localYn == 'Y' ? '../..': '')+"/mbr/leave_out.do",
		data:"passwd="+encodeURIComponent(passwd).replace(/&/g, "&")+"&site="+site+"&next="+next
	}).done(function(data){		
		var result = data;
		var anJson = JSON.parse(result);		
		if(anJson.status == 'ok'){
			alert(anJson.message);
			location.replace("/");
			//location.replace("/"+anJson.site+anJson.next); meberCancel.jsp
		}else{
			$('#messageConfirm').empty();
			$('#messageConfirm').append("<strong><font color='red'>"+anJson.message+"</font></strong>");
		}
	});	
});

$(document).on("click","#sginupCel",function(e){
	e.preventDefault();
	if(confirm("작성중이던 작업이 취소됩니다. 나가시겠습니까?") == true){
		var site = $('#site').val();
		location.replace("/"+site);
	}
});

//단체회원 가입 번호 중복체크 script 사용시
$(document).ready(function(){
	$("input:radio[name='groupType']").click(function(){
		$(".groupType1").hide();
		$(".groupType2").hide();
		$(".groupType3").hide();
		$(".groupType4").hide();
			var type = $(this).val();
			if(type == '개인'){
				$(".groupType1").show();
				$(".groupType4").show();
			}else if(type == '영리'){
				$(".groupType1").show();
				$(".groupType2").show();
			}else if(type =='비영리'){
				$(".groupType1").show();
				$(".groupType2").show();
				$(".groupType3").show();
			}else if(type == '공식'){
				$(".groupType3").show();
			}
	});

	$("#CheckType").click(function(e){				
		e.preventDefault();				
		$('#typeCheck').val(0);
		var type = $("input:radio[name='groupType']:checked").val();
		
		var establishment1 = $("#establishment1").val();
		var establishment2 = $("#establishment2").val();
		var establishment3 = $("#establishment3").val();
			
		var corporation1 = $("#corporation1").val();
		var corporation2 = $("#corporation2").val();

		var primaryKey1 = $("#primaryKey1").val();
		var primaryKey2 = $("#primaryKey2").val();
		var primaryKey3 = $("#primaryKey3").val();
		
		var localYn = $("#localYn").val();
		
		if(type != null){			
			if(checkType(type)){
				$.ajax({
					type:"post",
					url: (localYn == "Y" ? '../..' : '')+"/mbr/CheckType.do",
					data:"establishment1="+establishment1+"&establishment2="+establishment2 + "&establishment3="+establishment3 +
						 "&corporation1="+corporation1+"&corporation2="+corporation2+
						 "&primaryKey1="+primaryKey1+"&primaryKey2="+primaryKey2+"&primaryKey3="+primaryKey3 +	
						 "&type="+type
				}).done(function(data){
					var JSONdata = "";
						try{
							JSONdata = JSON.parse(data);
						}catch(Exception){
							alert("사업자 번호를 다시한번 확인해주세요.");
						}
						if(JSONdata.status == 'ok'){							
							alert(JSONdata.message);
							$('#typeCheck').val(1);
						}else{
							if(JSONdata.message != null){
								alert(JSONdata.message);
							}
						}
				});
			}		
		}								
	});
});

function checkType(type){
	var establishment1 = $("#establishment1").val();
	var establishment2 = $("#establishment2").val();					
	var establishment3 = $("#establishment3").val();
		
	var corporation1 = $("#corporation1").val();
	var corporation2 = $("#corporation2").val();
	

	var primaryKey1 = $("#primaryKey1").val();
	var primaryKey2 = $("#primaryKey2").val();
	var primaryKey3 = $("#primaryKey3").val();		
	
	if(type == '개인'){
		if(establishment1 == '' || establishment1 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');
			$("#establishment1").focus();
			return false;
		}else if(establishment2 == '' || establishment2 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');			
			$("#establishment2").focus();
			return false;
		}else if(establishment3 == '' || establishment3 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');			
			$("#establishment3").focus();
			return false;
		}
	}else if(type =='영리'){
		if(establishment1 == '' || establishment1 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');
			$("#establishment1").focus();
			return false;
		}else if(establishment2 == '' || establishment2 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');
			$("#establishment2").focus();
			return false;
		}else if(establishment3 == '' || establishment3 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');			
			$("#establishment3").focus();
			return false;
		}else if(corporation1 == '' || corporation1 == null){
			alert('법인 등록번호를 입력해 주시기 바랍니다');
			$("#corporation1").focus();
			return false;
		}else if(corporation2 == '' || corporation2 == null){
			alert('법인 등록번호를 입력해 주시기 바랍니다');
			$("#corporation2").focus();
			return false;
		}
	}else if(type == '비영리'){
		if(establishment1 == '' || establishment1 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');
			$("#establishment1").focus();
			return false;
		}else if(establishment2 == '' || establishment2 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');
			$("#establishment2").focus();
			return false;
		}else if(establishment3 == '' || establishment3 == null){
			alert('사업자번호를 입력해 주시기 바랍니다.');			
			$("#establishment3").focus();
			return false;
		}else if(corporation1 == '' || corporation1 == null){
			alert('법인 등록번호를 입력해 주시기 바랍니다');
			$("#corporation1").focus();
			return false;
		}else if(corporation2 == '' || corporation2 == null){
			alert('법인 등록번호를 입력해 주시기 바랍니다');
			$("#corporation2").focus();
			return false;
		}else if(primaryKey1 == '' || primaryKey1 == null){
			alert('고유번호를 입력해 주시기 바랍니다.');
			$("#primaryKey1").focus();
			return false;
		}else if(primaryKey2 == '' || primaryKey2 == null){
			alert('고유번호를 입력해 주시기 바랍니다.');
			$("#primaryKey2").focus();
			return false;
		}else if(primaryKey3 == '' || primaryKey3 == null){
			alert('고유번호를 입력해 주시기 바랍니다.');
			$("#primaryKey3").focus();
			return false;
		}
	}else if(type == '공식'){
		if(primaryKey1 == '' || primaryKey1 == null){
			alert('고유번호를 입력해 주시기 바랍니다.');
			$("#primaryKey1").focus();
			return false;
		}else if(primaryKey2 == '' || primaryKey2 == null){
			alert('고유번호를 입력해 주시기 바랍니다.');
			$("#primaryKey2").focus();
			return false;
		}else if(primaryKey3 == '' || primaryKey3 == null){
			alert('고유번호를 입력해 주시기 바랍니다.');
			$("#primaryKey3").focus();
			return false;
		}
	}
	return true;
}

//End 단체회원 가입 번호 중복체크 script 사용시

//myPage navi script
function fn_myPage_link_navi(logPageNo){	 //loginlog navi	
	var tabs =$('#tabs').val();
	var tab = $('#tab').val();		
	location.href= "myPage.jsp?logPageNo="+logPageNo+"&tabs="+tabs+"&tab="+tab; 
}
function fn_myPage_navi(scrapPageNo){	 //scrap navi		
	var tabs =$('#tabs').val();
	var tab = $('#tab').val();		
	location.href= "myPage.jsp?scrapPageNo="+scrapPageNo+"&tabs="+tabs+"&tab="+tab; 
}
//End myPage navi script

//myPage tabbable black-box Active - bootstrap.js 필요
function myPageActive(tab, tabs){
	if(tabs != '' && tab != ''){		
		var len = $('#nav li').length;
		for(var i=1; i<=len; i++){				
			$("#tab"+i+"").removeClass('active');
			$("#tabs"+i+"").removeClass('active');
		}			
		$("#"+tabs+"").addClass('active');
		$("#"+tab+"").addClass('active');		
	}else{
		$("#tab1").addClass('active');
		$("#tabs1").addClass('active');
	}
}
//End myPage tabbable black-box Active

//login tabbable black-box Active - bootstrap.js 필요
function loginActive(siauth,gpinauth,pkiauth,facebook,twitter,google){
	if(siauth == 'true'){
		$('#tabs1').addClass("active");
		$('#tab1').addClass("active");
	}else if(gpinauth == 'true'){
		$('#tabs2').addClass("active");
		$('#tab2').addClass("active");
	}else if(pkiauth == 'true') {
		$('#tabs3').addClass("active");
		$('#tab3').addClass("active");
	}else if(facebook == "1"){
		$('#tabs4').addClass("active");
		$('#tab4').addClass("active");
	}else if(twitter == "1"){
		$('#tabs5').addClass("active");
		$('#tab5').addClass("active");
	}else if(google == "1"){
		$('#tabs6').addClass("active");
		$('#tab6').addClass("active");
	}
}
// End of login tabbable black-box Active

//공인인증
function IDNCheck(data, IDN)
{	
	
	/*var pathname = document.location.pathname;		
	var paths = pathname.split("/");
	$('#returnUrl').val(paths[1]);*/
	
	
	var nResult;
	var strReturnData;
	nResult = Init();		
	if( nResult == 117)
		return;
	
	nResult = GPKISecureWeb.SignedDataWithVIDCheck(SiteID, CertOption, data, IDN);

	strReturnData = GPKISecureWeb.GetReturnData();
	
	if( nResult == 1 ) 
	{				
		document.signForm.action="/sign_res.jsp";
		document.signForm.submit();
		return strReturnData;
	}
	else
	{
		if( nResult != 106)				
		return "";
	}
}

/**
 * 실명인증 & G-PIN인증
 */
$(document).on("click","#snSubmit",function(){
	snSubmit();
});


var checkAgree = function() {
	if($('input#agree:checked').size() == 0) {
		alert("약관동의에 체크하신 후 이용하세요.");
		return false;
	}

	return true;
}

var CBA_window;
var GPIN_window;

var snSubmit = function() {
	if(checkAgree() == false) return;

	CBA_window = window.open('<import url="/mbr/si.do" > <param name="retParam" value="signup" /></import>', 'CbaWindow', 'width=500, height=650, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
}

var gpinSubmit = function() {
	if(checkAgree() == false) return;

	GPIN_window = window.open('/kr/gpin.jsp?retParam=signup', 'gPinLoginWin', 'width=360, height=120, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );
}

/////////////////////////////////////

//setting field
function propSettingField(objProp,type,ex01,ex02,ex03){	
	//setting fields ex01
	var ex01Type = objProp["ex01Type"];
	var ex01TypeField = objProp["ex01TypeFields"];
	var ex01TypeFields = ex01TypeField.split(",");
	var ex01s;
	for(var i=0; i<ex01TypeFields.length; i++){
		if(ex01Type == 'select'){
			$('#ex01').append("<option value='"+ex01TypeFields[i]+"' "+(ex01 != '' && ex01 == ex01TypeFields[i] ? 'selected' : '')+" > "+ex01TypeFields[i]+" </option>");
		}else if(ex01Type == 'checkbox'){
			$('#ex01checkbox').append("<input type='checkbox' name='ex01' id='ex01_"+i+"' value='"+ex01TypeFields[i]+"'/> "+ex01TypeFields[i]+" ");
		}else if(ex01Type == 'radio'){
			$('#ex01radio').append("<input type='radio' name='ex01' id='ex01_"+i+"' value='"+ex01TypeFields[i]+"' "+(ex01 != '' && ex01 == ex01TypeFields[i] ? 'checked' : '')+" /> "+ex01TypeFields[i]+" ");
		}
	}
	if(ex01Type == 'checkbox'){
		if(ex01 != null){
			ex01s = ex01.split(",");
			for(var i=0; i<ex01s.length; i++){
				$("input:checkbox[name='ex01']").each(function(){
					if($(this).val() == ex01s[i]){
						$(this).attr("checked",true);
					}
				});
			}
		}
	}else if(ex01Type == 'multiinput'){
		if(ex01 != null){
			ex01s = ex01.split("-");
			$("#ex01_1").val(ex01s[0]);
			$("#ex01_2").val(ex01s[1]);
			$("#ex01_3").val(ex01s[2]);
		}
	}
	//end setting fields ex01
	
	//setting fields ex02
	var ex02Type = objProp["ex02Type"];
	var ex02TypeField = objProp["ex02TypeFields"];
	var ex02TypeFields = ex02TypeField.split(",");
	var ex02s;
	for(var i=0; i<ex02TypeFields.length; i++){
		if(ex02Type == 'select'){
			$('#ex02').append("<option value='"+ex02TypeFields[i]+"' "+(ex02 != '' && ex02 == ex02TypeFields[i] ? 'selected' : '')+" > "+ex02TypeFields[i]+" </option>");
		}else if(ex02Type == 'checkbox'){
			$('#ex02checkbox').append("<input type='checkbox' name='ex02' id='ex02_"+i+"' value='"+ex02TypeFields[i]+"'/> "+ex02TypeFields[i]+" ");
		}else if(ex02Type == 'radio'){
			$('#ex02radio').append("<input type='radio' name='ex02' id='ex02_"+i+"' value='"+ex02TypeFields[i]+"' "+(ex02 != '' && ex02 == ex02TypeFields[i] ? 'checked' : '')+" /> "+ex02TypeFields[i]+" ");
		}
	}
	if(ex02Type == 'checkbox'){
		if(ex02 != null){
			ex02s = ex02.split(",");
			for(var i=0; i<ex02s.length; i++){
				$("input:checkbox[name='ex02']").each(function(){
					if($(this).val() == ex02s[i]){
						$(this).attr("checked",true);
					}
				});
			}
		}
	}else if(ex02Type == 'multiinput'){
		if(ex02 != null){
			ex02s = ex02.split("-");
			$("#ex02_1").val(ex02s[0]);
			$("#ex02_2").val(ex02s[1]);
			$("#ex02_3").val(ex02s[2]);
		}
	}
	//end setting fields ex02
	
	//setting fields ex03
	var ex03Type = objProp["ex03Type"];
	var ex03TypeField = objProp["ex03TypeFields"];
	var ex03TypeFields = ex03TypeField.split(",");
	var ex03s;
	for(var i=0; i<ex03TypeFields.length; i++){
		if(ex03Type == 'select'){
			$('#ex03').append("<option value='"+ex03TypeFields[i]+"' "+(ex03 != '' && ex03 == ex03TypeFields[i] ? 'selected' : '')+" > "+ex03TypeFields[i]+" </option>");
		}else if(ex03Type == 'checkbox'){
			$('#ex03checkbox').append("<input type='checkbox' name='ex03' id='ex03_"+i+"' value='"+ex03TypeFields[i]+"'/> "+ex03TypeFields[i]+" ");
		}else if(ex03Type == 'radio'){
			$('#ex03radio').append("<input type='radio' name='ex03' id='ex03_"+i+"' value='"+ex03TypeFields[i]+"' "+(ex03 != '' && ex03 == ex03TypeFields[i] ? 'checked' : '')+" /> "+ex03TypeFields[i]+" ");
		}
	}
	if(ex03Type == 'checkbox'){
		if(ex03 != null){
			ex03s = ex03.split(",");
			for(var i=0; i<ex03s.length; i++){
				$("input:checkbox[name='ex03']").each(function(){
					if($(this).val() == ex03s[i]){
						$(this).attr("checked",true);
					}
				});
			}
		}
	}else if(ex03Type == 'multiinput'){
		if(ex03 != null){
			ex03s = ex03.split("-");
			$("#ex03_1").val(ex03s[0]);
			$("#ex03_2").val(ex03s[1]);
			$("#ex03_3").val(ex03s[2]);
		}
	}
	//end setting fields ex03
}
//end setting field

/* Copyright (c) 2006 Mathias Bank (http://www.mathias-bank.de)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) 
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 * Thanks to Hinnerk Ruemenapf - http://hinnerk.ruemenapf.de/ for bug reporting and fixing.
 */
jQuery.extend({
/**
* Returns get parameters.
*
* If the desired param does not exist, null will be returned
*
* @example value = $.getURLParam("paramName");
*/
 getURLParam: function(strParamName){

	  var strReturn = "";
	  var strHref = window.location.href;
	  var bFound=false;
	  var cmpstring = strParamName + "=";
	  var cmplen = cmpstring.length;

	  if ( strHref.indexOf("?") > -1 ){
	    var strQueryString = strHref.substr(strHref.indexOf("?")+1);
	    var aQueryString = strQueryString.split("&");
	    for ( var iParam = 0; iParam < aQueryString.length; iParam++ ){
	      if (aQueryString[iParam].substr(0,cmplen)==cmpstring){
	        var aParam = aQueryString[iParam].split("=");
	        strReturn = aParam[1];
	        bFound=true;
	        break;
	      }
	    }
	  }
	  if (bFound==false) return null;
	  return strReturn;
	}

});