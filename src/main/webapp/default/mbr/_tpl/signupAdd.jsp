<%
/**
 *@version 3.2.0.1
 **/
%>
<div class="member_content">

<!-- css -->
<link rel="author" type="text/plain" href="<c:url value="/humans.txt" />" />
<!--js-->
<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>" ></script>
<script type="text/javascript" src="<c:url value="/resources/js/jnit.member.js" />" ></script>
<script src="<c:url value="/resources/js/bootstrap.js"/>" ></script>

<c:set var="type" value="<%= type %>" />
<c:set var="error" value="<%= error %>"/>
<c:set var="prop" value="<%= prop %>" />
<c:set var="authType" value="${sessionScope.snAuth.authType }"/>
<c:set var="retType" value="${sessionScope.snAuth.retType }"/>
<c:set var="errorCode" value="<%= errorCode %>" />
<c:set var="authDefaultYn" value="<%= authDefaultYn %>" />
<script type="text/javascript">
<!--
	$(document).ready(function(){
		var objProp = new Object();
		objProp = <%= prop %>;

		propSettingField(objProp,"sign");
		
		$("#passwd").focusout(function(){
            var passwd = $("#passwd").val();
            if(passwd != ""){
                    $.ajax({
                                    type:"POST",
                                    url:"<c:url value="/jnit/kisalib/pwSafe.do" />",
                                    data:"passwd="+passwd
                    }).done(function(data){
                                    var result = jQuery.parseJSON(data);
                                    var retLvl = "";
                                    var retStr = "";
                                    if(result.level != null) retLvl = result.level;

                                    $("#pwLow").attr("style","display:none;");
                                    $("#pwMid").attr("style","display:none;");
                                    $("#pwTop").attr("style","display:none;");
                                    $("#pwBest").attr("style","display:none;");

                                    if(retLvl == '하'){
                                            $("#pwLow").attr("style","display:block;");
                                    }else if(retLvl == '중'){
                                            $("#pwMid").attr("style","display:block;");
                                    }else if(retLvl == '상'){
                                            $("#pwTop").attr("style","display:block;");
                                    }else if(retLvl == '최상'){
                                            $("#pwBest").attr("style","display:block;");
				}
                    });
            }else{
                    $("#pwLow").attr("style","display:none;");
                    $("#pwMid").attr("style","display:none;");
                    $("#pwTop").attr("style","display:none;");
                    $("#pwBest").attr("style","display:none;");
            }
		});
	});
	
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
	    $("#post").val(zipNo);
		$("#addr").val(roadFullAddr);
	}
//-->	
</script>
<c:if test="${prop['captcha'] != 0}">
<% String ctxPath = request.getContextPath(); %>
<script type="text/javascript">
   <!--
var rand;

//캡차 오디오 요청
function audioCaptcha(type) {
	var kor = (type > 0) ? "lan=kor&":""; 
	$.ajax({
		url: '<%=ctxPath%>/captcha/CaptChaAudio.jsp',
		type: 'POST',
		dataType: 'text',
		data: 'rand=' + rand + '&ans=y',
		async: false,		
		success: function(resp) {
			var uAgent = navigator.userAgent;
			var soundUrl = '<%=ctxPath%>/captcha/CaptChaAudio.jsp?' + kor + 'rand=' + rand + '&ans=' + resp;
			//console.log(soundUrl);
			if (uAgent.indexOf('Trident') > -1 || uAgent.indexOf('MSIE') > -1) {
				winPlayer(soundUrl+'&agent=msie');
			} else if (!!document.createElement('audio').canPlayType) {
				try { new Audio(soundUrl).play(); } catch(e) { winPlayer(soundUrl); }
			} else window.open(soundUrl, '', 'width=1,height=1');
		}
	});
}
function winPlayer(objUrl) {
	$('#audiocatpch').html(' <bgsound src="' + objUrl + '">');
}

//캡차 이미지 요청 (캐쉬문제로 인해 이미지가 변경되지 않을수있으므로 요청시마다 랜덤숫자를 생성하여 요청)
function changeCaptcha() {
	rand = Math.random();
	$('#catpcha').html('<img src="<%=ctxPath%>/captcha/CaptChaImg.jsp?rand=' + rand + '"/>');
}

$(document).ready(function() {
	
	changeCaptcha(); //캡차 이미지 요청
	
	$('#reLoad').click(function(){ changeCaptcha(); }); //새로고침버튼에 클릭이벤트 등록
	$('#soundOn').click(function(){ audioCaptcha(0); });	//음성듣기버튼에 클릭이벤트 등록
	$('#soundOnKor').click(function(){ audioCaptcha(1); }); //한글음성듣기 버튼에 클릭이벤트 등록
	
	//확인 버튼 클릭시
	$('#frmSubmit').click(function(){
		if ( !$('#answer').val() ) {
			alert('이미지에 보이는 숫자 또는 스피커를 통해 들리는 숫자를 입력해 주세요.');
		} else {
			$.ajax({
				url: '<%=ctxPath%>/captcha/captchaSubmit.jsp',
				type: 'POST',
				dataType: 'text',
				data: 'answer=' + $('#answer').val(),
				async: false,		
				success: function(resp) {
					alert(resp);
					$('#reLoad').click();
					$('#answer').val('');
				}
			});
		}
	});
});
// -->
</script> 
</c:if>
<div id="myModal" class="modal hide fade">	
	<div class="modal-body">
		<p id="member"></p>
	</div>
	<div class="modal-footer">		
		<button id="modal_colse" class="btn" data-dismiss="modal" aria-hidden="true">Close</button>		
	</div>
</div>

<c:if test="${type == null}">
<form name="mbrForm" id="mbrForm" action="<c:url value='/mbr/signup_savembr.do'/>" method="post">
<input type="hidden" name="localYn" id="localYn" value="${localYn }" />
<input type="hidden" name="site" id="site" value="${Jnit_sitePath }" />
<input type="hidden" name="next" id="next" value="/mbr/signupSuccess.jsp" />
<input type="hidden" name="IDCheck" id="IDCheck" />
<input type="hidden" name="authType" value="${authType }" />
<input type="hidden" name="retType" id="retType" value="${retType }"/>
<input type="hidden" name="siteId" id="siteId" value="${siteId }" />
<script type="text/javascript">
<!--
	$(document).ready(function(){
		var authDefaultYn = "${authDefaultYn}";
		if( authDefaultYn != 'Y'){
			checkDP();
		}
	});
//-->
</script>
<div class="member_join_form">
<table class="table table-bordered box member_join" summary="회원가입 작성페이지입니다." style="margin-top:20px;">	
	<caption>회원가입 작성</caption>
    <tbody>
    	<tr>
        	<th>인증유형</th>
            <td>
            	<c:if test="${authType == 'si' }" > 실명인증 </c:if>
            	<c:if test="${authType == 'gpin' }" > G-Pin </c:if>
            	<c:if test="${authType == 'sign' }" > 공인인증 </c:if>
            	<c:if test="${authDefaultYn == 'Y' }">기본가입</c:if>            	
            </td>
        </tr>
    	<tr>
        	<th><label for="mbrLogin"><strong>아이디</strong></label></th>
            <td>
				<input type="text" id="mbrLogin" name="mbrLogin" />
				<button id="idCheck" class="btn btn-primary btn-mini">중복체크</button>
			</td>
        </tr>
        <tr>
        	<th>이름</th>
            <td>
            	<c:if test="${authDefaultYn != 'Y' }">
            		<input type="hidden" id="mbrNm" name="mbrNm" value="${sessionScope.snAuth.nm}" />
            	</c:if>
            	<c:if test="${authDefaultYn == 'Y' }">
            		<input type="text" id="mbrNm" name="mbrNm" value="" />
            	</c:if>
            </td>
        </tr>
    	<tr>
        	<th><label for="passwd"><strong>비밀번호</strong></label></th>
            <td>
				<input type="password" id="passwd" name="passwd" maxlength="12"/>
				<span id="pwLow" style="display: none;"><img src="/default/common/img/passwd/pass_level_img01.gif" alt="패스워드 안정성 하" /></span>
				<span id="pwMid" style="display: none;"><img src="/default/common/img/passwd/pass_level_img02.gif" alt="패스워드 안정성 중" /></span>
				<span id="pwTop" style="display: none;"><img src="/default/common/img/passwd/pass_level_img03.gif" alt="패스워드 안정성 상" /></span>
				<span id="pwBest" style="display: none;"><img src="/default/common/img/passwd/pass_level_img04.gif" alt="패스워드 안정성 최상" /></span>
			</td>
        </tr>
    	<tr>
        	<th><label for="passwdConfirm"><strong>비밀번호확인</strong></label></th>
            <td><input type="password" id="passwdConfirm" name="passwdConfirm" maxlength="12" /><div id="pawConfirm"><strong>영문, 숫자10~16자 이내로 입력해주시기 바랍니다.</strong></div></td>
        </tr>
        <c:if test="${prop['tel'] != 0}" >
    	<tr>
        	<th><c:if test="${prop['tel']  == 2}"><font color="red"> (필수) </font></c:if><label for="tel1">일반전화번호</label></th>
            <td>
				<c:if test="${prop['tel'] != 0}" ><c:if test="${prop['tel']  == 2}"><c:set var="configTel" value="${prop['tel'] == 2 ? 'required' : ''} "/></c:if><select name="tel1" id="tel1" style="width: 70px;"><option value="02">02</option><option value="031">031</option><option value="032">032</option><option value="033">033</option><option value="041">041</option><option value="042">042</option><option value="043">043</option><option value="051">051</option><option value="052">052</option><option value="053">053</option><option value="054">054</option><option value="055">055</option><option value="061">061</option><option value="062">062</option><option value="063">063</option><option value="064">064</option><option value="070">070</option></select>- <label for="tel2" style="display: none;"></label><input type="text" name="tel2" id="tel2" maxlength="4" ${configTel} style="width:50px;"/>- <label for="tel3" style="display: none;"></label><input type="text" name="tel3" id="tel3" maxlength="4" ${configTel} style="width:50px;"/><c:if test="${prop['tel']  == 2}"><font color="red"> * </font></c:if></c:if>
			</td>
        </tr>
        </c:if>
        <c:if test="${prop['phone'] != 0}" >
    	<tr>
        	<th><c:if test="${prop['phone']  == 2}"><font color="red"> (필수) </font></c:if><label for="mobile1">휴대폰</label></th>
            <td>
				<c:if test="${prop['phone'] != 0}" ><c:if test="${prop['phone'] == 2}"><c:set var="configPhone" value="${prop['phone'] == '2' ? 'required' : '' }"/></c:if><select name="mobile1" id="mobile1" style="width:70px;"><option value="010">010</option><option value="011">011</option><option value="016">016</option><option value="017">017</option><option value="018">018</option><option value="019">019</option></select>-<label for="mobile2" style="display: none;"></label><input type="text" name="mobile2" id="mobile2" ${configPhone} maxlength="4" style="width:50px" />-<label for="mobile3" style="display: none;"></label><input type="text" name="mobile3" id="mobile3" ${configPhone} maxlength="4" style="width:50px" /><c:if test="${prop['phone']  == 2}"><font color="red"> * </font></c:if></c:if>
			</td>
        </tr>
        </c:if>
        <c:if test="${prop['email'] != 0}" >
    	<tr>
        	<th><c:if test="${prop['email']  == 2}"><font color="red"> (필수) </font></c:if><label for="email">이메일</label></th>
            <td>
            	<c:if test="${prop['email'] != 0}" ><c:if test="${prop['email'] == 2}"><c:set var="configEmail" value="${prop['email'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="email" id="email" ${configEmail} /><c:if test="${prop['email']  == 2}"><font color="red"> * </font></c:if></c:if>
            </td>
        </tr>
        </c:if>
        <c:if test="${prop['post'] != 0}" >
    	<tr>
        	<th><c:if test="${prop['post']  == 2}"><font color="red"> (필수) </font></c:if><label for="post">우편번호</label></th>
            <td>
            	<c:if test="${prop['post'] != 0}" ><c:if test="${prop['post'] == 2}"><c:set var="configPost" value="${prop['post'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="post" id="post" ${configPost} style="width: 50px;" /><button class="btn btn-mini" id="postFind">주소찾기</button><c:if test="${prop['post']  == 2}"><font color="red"> * </font></c:if></c:if>
            </td>
        </tr>
        </c:if>
        <c:if test="${prop['addr'] != 0}" >
    	<tr>
        	<th><c:if test="${prop['addr']  == 2}"><font color="red"> (필수) </font></c:if><label for="addr">주소</label></th>
            <td>
            	<c:if test="${prop['addr'] != 0}" ><c:if test="${prop['addr'] == 2}"><c:set var="configAddr" value="${prop['addr'] == '2' ? 'required' : '' }"/></c:if> <input type="text" name="addr" id="addr" ${configAddr}/> <c:if test="${prop['addr']  == 2}"><font color="red"> * </font></c:if></c:if>
            </td>
        </tr>
        </c:if>
        <c:if test="${prop['emailRecv'] != 0}" >
    	<tr>
        	<th><c:if test="${prop['emailRecv']  == 2}"><font color="red"> (필수) </font></c:if><label for="emailRecv">메일수신동의</label></th>
            <td>
            	<c:if test="${prop['emailRecv'] != 0}" ><c:if test="${prop['emailRecv'] == 2}"><c:set var="configEmailRecv" value="${prop['emailRecv'] == '2' ? 'required' : '' }"/></c:if>동의함 <input type="checkbox" name="emailRecv" id="emailRecv" ${configEmailRecv} value="1" /><c:if test="${prop['emailRecv']  == 2}"><font color="red"> * </font></c:if></c:if>
            </td>
        </tr>
        </c:if>
        <c:if test="${prop['smsRecv'] != 0}" >
    	<tr>
        	<th><c:if test="${prop['smsRecv']  == 2}"><font color="red"> (필수) </font></c:if><label for="smsRecv">SMS수신동의</label></th>
            <td>
            	<c:if test="${prop['smsRecv'] != 0}" ><c:if test="${prop['smsRecv'] == 2}"><c:set var="configSmsRecv" value="${prop['smsRecv'] == '2' ? 'required' : '' }"/></c:if>동의함 <input type="checkbox" name="smsRecv" id="smsRecv" ${configSmsRecv} value="1"/><c:if test="${prop['smsRecv']  == 2}"><font color="red"> * </font></c:if></c:if>
            </td>
        </tr>
        </c:if>
        <c:if test="${prop['ex01Add'] != 0}">
        <tr>
        	<th><c:if test="${prop['ex01Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex01']}</th>
        	<td>
        		<c:if test="${prop['ex01Add'] != 0}"><c:if test="${prop['ex01Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex01Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex01Type'] == 'text'}"><input type="text" name="ex01" ${configEx01Add} /></c:if><c:if test="${prop['ex01Type'] == 'select'}"><select id="ex01" name="ex01"></select></c:if><c:if test="${prop['ex01Type'] == 'checkbox'}"><div id="ex01checkbox"></div></c:if><c:if test="${prop['ex01Type'] == 'radio'}"><div id="ex01radio"></div></c:if><c:if test="${prop['ex01Type'] == 'multiinput'}"><label for="ex01_1" style="display: none;"></label><input type="text" id="ex01_1" name="ex01_1" style="width:50px;" />- <label for="ex01_2" style="display: none;"></label><input type="text" id="ex01_2" name="ex01_2" style="width:50px;" />- <label for="ex01_3" style="display: none;"></label><input type="text" id="ex01_3" name="ex01_3" style="width:50px;"/></c:if></c:if>
        	</td>
        </tr>
        </c:if>
        <c:if test="${prop['ex02Add'] != 0}">
        <tr>
        	<th><c:if test="${prop['ex02Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex02']}</th>
        	<td>
        		<c:if test="${prop['ex02Add'] != 0}"><c:if test="${prop['ex02Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex02Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex02Type'] == 'text'}"><input type="text" name="ex02" ${configEx01Add} /></c:if><c:if test="${prop['ex02Type'] == 'select'}"><select id="ex02" name="ex02"></select></c:if><c:if test="${prop['ex02Type'] == 'checkbox'}"><div id="ex02checkbox"></div></c:if><c:if test="${prop['ex02Type'] == 'radio'}"><div id="ex02radio"></div></c:if><c:if test="${prop['ex02Type'] == 'multiinput'}"><label for="ex02_1" style="display: none;"></label><input type="text" id="ex02_1" name="ex02_1" style="width:50px;" />- <label for="ex02_2" style="display: none;"></label><input type="text" id="ex02_2" name="ex02_2" style="width:50px;" />- <label for="ex02_3" style="display: none;"></label><input type="text" id="ex02_3" name="ex02_3" style="width:50px;"/></c:if></c:if>
        	</td>
        </tr>
        </c:if>
        <c:if test="${prop['ex03Add'] != 0}">
        <tr>
        	<th><c:if test="${prop['ex03Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex03']}</th>
        	<td>
        		<c:if test="${prop['ex03Add'] != 0}"><c:if test="${prop['ex03Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex03Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex03Type'] == 'text'}"><input type="text" name="ex03" ${configEx01Add} /></c:if><c:if test="${prop['ex03Type'] == 'select'}"><select id="ex03" name="ex03"></select></c:if><c:if test="${prop['ex03Type'] == 'checkbox'}"><div id="ex03checkbox"></div></c:if><c:if test="${prop['ex03Type'] == 'radio'}"><div id="ex03radio"></div></c:if><c:if test="${prop['ex03Type'] == 'multiinput'}"><label for="ex03_1" style="display: none;"></label><input type="text" id="ex03_1" name="ex03_1" style="width:50px;" />- <label for="ex03_2" style="display: none;"></label><input type="text" id="ex03_2" name="ex03_2" style="width:50px;" />- <label for="ex03_3" style="display: none;"></label><input type="text" id="ex03_3" name="ex03_3" style="width:50px;"/></c:if></c:if>
        	</td>
        </tr>
        </c:if>
    </tbody>
</table>
</div>
<c:if test="${prop['captcha'] != 0}">
   <div id="catpcha"></div>
   <div id="audiocatpch" style="display: none;"></div>
   
   <input id="reLoad" type="button" value="새로고침" />
   <input id="soundOn" type="button" value="음성듣기" />
   <input id="soundOnKor" type="button" value="한글음성" />
   <br />
   <input type="text" id="answer" name="answer" value="" />
</c:if>
<button type="submit" class="btn btn-primary">가입</button>
<button id="sginupCel" class="btn btn-danger">취소</button>
</form>
</c:if>

<c:if test="${type != null}">
<div class="box">
	<form id="groupMbrForm" name="groupMbrForm" action="<c:url value="/mbr/signup_groupSave.do"/>" method="post">
	<input type="hidden" name="site" id="site" value="${Jnit_sitePath }" />
	<input type="hidden" name="next" id="next" value="/mbr/signupSuccess.jsp" />
	<input type="hidden" name="IDCheck" id="IDCheck" />
	<input type="hidden" name="typeCheck" id="typeCheck" />
	<input type="hidden" name="localYn" id="localYn" value="${localYn }" />
	<input type="hidden" name="siteId" id="siteId" value="${siteId }" />
		<c:if test="${error != null}">
			<strong>${error}</strong>
		</c:if>
		<c:if test="${error == null}">
			<table class="table table-bordered box member_join" summary="단체회원 작성페이지입니다.">
				<tbody>
					<tr>
						<th><label for="groupId">단체아이디</label></th>
						<td><input type="text" name="groupId" id="groupId" />
						<button id="idCheck" class="btn btn-primary btn-mini">중복체크</button></td>
					</tr>
					<tr>
						<th><label for="groupNm">단체이름</label></th>
						<td><input type="text" name="groupNm" id="groupNm" /></td>
					</tr>
					<tr>
						<th><label for="groupPasswd">패스워드</label></th>
						<td><input type="password" name="groupPasswd" id="groupPasswd" maxlength="12" /></td>
					</tr>
					<tr>
						<th><label for="groupPasswdConfrim">패스워드확인</label></th>
						<td><input type="password" name="groupPasswdConfrim" id="groupPasswdConfrim" maxlength="12" /><div id="groupPawConfirm"><strong>영문, 숫자8~12자 이내로 입력해주시기 바랍니다.</strong></div></td>
					</tr>
					<c:if test="${prop['tel'] != 0}" >
			    	<tr>
			        	<th><c:if test="${prop['tel']  == 2}"><font color="red"> (필수) </font></c:if><label for="tel1">일반전화번호</label></th>
			            <td>
							<c:if test="${prop['tel'] != 0}" ><c:if test="${prop['tel']  == 2}"><c:set var="configTel" value="${prop['tel'] == 2 ? 'required' : ''} "/></c:if><select name="tel1" id="tel1" style="width: 70px;"><option value="02">02</option><option value="031">031</option><option value="032">032</option><option value="033">033</option><option value="041">041</option><option value="042">042</option><option value="043">043</option><option value="051">051</option><option value="052">052</option><option value="053">053</option><option value="054">054</option><option value="055">055</option><option value="061">061</option><option value="062">062</option><option value="063">063</option><option value="064">064</option><option value="070">070</option></select>- <label for="tel2" style="display: none;"></label><input type="text" name="tel2" id="tel2" maxlength="4" ${configTel} style="width:50px;"/>- <label for="tel3" style="display: none;"></label><input type="text" name="tel3" id="tel3" maxlength="4" ${configTel} style="width:50px;"/><c:if test="${prop['tel']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['phone'] != 0}" >
			    	<tr>
			        	<th><c:if test="${prop['phone']  == 2}"><font color="red"> (필수) </font></c:if><label for="mobile1">휴대폰</label></th>
			            <td>
							<c:if test="${prop['phone'] != 0}" ><c:if test="${prop['phone'] == 2}"><c:set var="configPhone" value="${prop['phone'] == '2' ? 'required' : '' }"/></c:if><select name="mobile1" id="mobile1" style="width:70px;"><option value="010">010</option><option value="011">011</option><option value="016">016</option><option value="017">017</option><option value="018">018</option><option value="019">019</option></select>-<label for="mobile2" style="display: none;"></label><input type="text" name="mobile2" id="mobile2" ${configPhone} maxlength="4" style="width:50px" />-<label for="mobile3" style="display: none;"></label><input type="text" name="mobile3" id="mobile3" ${configPhone} maxlength="4" style="width:50px" /><c:if test="${prop['phone']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['email'] != 0}" >
			    	<tr>
			        	<th><c:if test="${prop['email']  == 2}"><font color="red"> (필수) </font></c:if><label for="email">이메일</label></th>
			            <td>
			            	<c:if test="${prop['email'] != 0}" ><c:if test="${prop['email'] == 2}"><c:set var="configEmail" value="${prop['email'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="email" id="email" ${configEmail} /><c:if test="${prop['email']  == 2}"><font color="red"> * </font></c:if></c:if>
			            </td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['post'] != 0}" >
			    	<tr>
			        	<th><c:if test="${prop['post']  == 2}"><font color="red"> (필수) </font></c:if><label for="post">우편번호</label></th>
			            <td>
			            	<c:if test="${prop['post'] != 0}" ><c:if test="${prop['post'] == 2}"><c:set var="configPost" value="${prop['post'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="post" id="post" ${configPost} style="width: 50px;" /><button class="btn btn-mini" id="postFind">주소찾기</button><c:if test="${prop['post']  == 2}"><font color="red"> * </font></c:if></c:if>
			            </td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['addr'] != 0}" >
			    	<tr>
			        	<th><c:if test="${prop['addr']  == 2}"><font color="red"> (필수) </font></c:if><label for="addr">주소</label></th>
			            <td>
			            	<c:if test="${prop['addr'] != 0}" ><c:if test="${prop['addr'] == 2}"><c:set var="configAddr" value="${prop['addr'] == '2' ? 'required' : '' }"/></c:if> <input type="text" name="addr" id="addr" ${configAddr}/> <c:if test="${prop['addr']  == 2}"><font color="red"> * </font></c:if></c:if>
			            </td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['emailRecv'] != 0}" >
			    	<tr>
			        	<th><c:if test="${prop['emailRecv']  == 2}"><font color="red"> (필수) </font></c:if><label for="emailRecv">메일수신동의</label></th>
			            <td>
			            	<c:if test="${prop['emailRecv'] != 0}" ><c:if test="${prop['emailRecv'] == 2}"><c:set var="configEmailRecv" value="${prop['emailRecv'] == '2' ? 'required' : '' }"/></c:if>동의함 <input type="checkbox" name="emailRecv" id="emailRecv" ${configEmailRecv} value="1" /><c:if test="${prop['emailRecv']  == 2}"><font color="red"> * </font></c:if></c:if>
			            </td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['smsRecv'] != 0}" >
			    	<tr>
			        	<th><c:if test="${prop['smsRecv']  == 2}"><font color="red"> (필수) </font></c:if><label for="smsRecv">SMS수신동의</label></th>
			            <td>
			            	<c:if test="${prop['smsRecv'] != 0}" ><c:if test="${prop['smsRecv'] == 2}"><c:set var="configSmsRecv" value="${prop['smsRecv'] == '2' ? 'required' : '' }"/></c:if>동의함 <input type="checkbox" name="smsRecv" id="smsRecv" ${configSmsRecv} value="1"/><c:if test="${prop['smsRecv']  == 2}"><font color="red"> * </font></c:if></c:if>
			            </td>
			        </tr>
			        </c:if>
					<tr>
						<th><font color="red">*</font> 단체종류선택</th>
						<td>
							<c:if test="${prop['personal'] != 0}"><input type="radio" name="groupType" id="groupType" value="개인" checked>개인사업자</c:if>
							<c:if test="${prop['profit'] != 0}"><input type="radio" name="groupType" id="groupType" value="영리">영리 법인</c:if>
							<c:if test="${prop['nonprofit'] != 0}"><input type="radio" name="groupType" id="groupType" value="비영리">비영리 법인</c:if>
							<c:if test="${prop['organization'] != 0}"><input type="radio" name="groupType" id="groupType " value="공식">공식 단체</c:if>

							<br /><p><strong>사업자 등록증을 보내주시면 관리자가 확인 후에 완료처리 해드립니다.</strong><br /><strong style="color: red;">${prop['companyAddr']}</strong></p>
						</td>
					</tr>
					<tr class="groupType1" style="display: hide;">
						<th><label for="establishment1"><font color="red">*</font> 사업자번호</label></th>
						<td>
							<input type="text" name="establishment1" id="establishment1" style="width: 96px;"/>-<label for="establishment2" style="display: none;"></label><input type="text" name="establishment2" id="establishment2" style="width: 66px;" />-<label for="establishment3" style="display: none;"></label><input type="text" name="establishment3" id="establishment3" style="width: 96px;" />
						</td>
					</tr>
					<tr class="groupType2" style="display: none;">
						<th><label for="corporation1"><font color="red">*</font> 법인등록번호</label></th>
						<td>
							<input type="text" name="corporation1" id="corporation1" style="width: 96px;" />-<label for="corporation2" style="display: none;"></label><input type="text" name="corporation2" id="corporation2" style="width: 96px;" />
						</td>
					</tr>
					<tr class="groupType3" style="display: none;">
						<th><label for="primaryKey1"><font color="red">*</font> 고유번호</label></th>
						<td>
							<input type="text" name="primaryKey1" id="primaryKey1" style="width: 96px;" />-<label for="primaryKey2" style="display: none;"></label><input type="text" name="primaryKey2" id="primaryKey2" style="width: 66px;" />-<label for="primaryKey3" style="display: none;"></label><input type="text" name="primaryKey3" id="primaryKey3" style="width: 96px;" />
						</td>
					</tr>
					<tr>	
						<th>인증 확인</th>
						<td>
							<button id="CheckType" class="btn btn-primary btn-mini">중복체크</button>
						</td>
					</tr>
					<c:if test="${prop['mutual'] != 0}">
					<tr class="groupType4" style="display: none;">
						<th><c:if test="${prop['mutual']  == 2}"><font color="red"> (필수) </font></c:if><label for="mutual">상호</label></th>
						<td>
							<c:if test="${prop['mutual'] != 0}"><c:if test="${prop['mutual'] == 2}"><c:set var="configMutual" value="${prop['mutual'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="mutual" id="mutual" ${configMutual} /><c:if test="${prop['mutual']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['corporateName'] != 0}">
					<tr>
						<th><c:if test="${prop['corporateName']  == 2}"><font color="red"> (필수) </font></c:if><label for="corporateName">법인명(단체명)</label></th>
						<td>
							<c:if test="${prop['corporateName'] != 0}"><c:if test="${prop['corporateName'] == 2}"><c:set var="configCorporateNmae" value="${prop['corporateName'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="corporateName" id="corporateName"  ${configCorporateNmae}/><c:if test="${prop['corporateName']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['groupName'] != 0}">
					<tr>
						<th><c:if test="${prop['groupName']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupName">대표자명</label></th>
						<td>
							<c:if test="${prop['groupName'] != 0}"><c:if test="${prop['groupName'] == 2}"><c:set var="configGroupNmae" value="${prop['groupName'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="groupName" id="groupName" ${configGroupNmae} /><c:if test="${prop['groupName']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['businessPlace'] != 0}">
					<tr>
						<th><c:if test="${prop['businessPlace']  == 2}"><font color="red"> (필수) </font></c:if><label for="businessPlace1">사업장 소재지</label></th>
						<td>
							<c:if test="${prop['businessPlace'] != 0}"><c:if test="${prop['businessPlace'] == 2}"><c:set var="configBusinessPlace" value="${prop['businessPlace'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="businessPlace1" id="businessPlace1" ${configBusinessPlace} style="width:50px;" />-<label for="businessPlace2" style="display: none;"></label><input type="text" name="businessPlace2" id="businessPlace2" ${configBusinessPlace} style="width:50px;"/><button class="btn btn-mini" id="groupPostFind">주소찾기</button><c:if test="${prop['businessPlace']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['businessAddr'] != 0}">
					<tr>
						<th><c:if test="${prop['businessAddr']  == 2}"><font color="red"> (필수) </font></c:if><label for="businessAddr">사업장 주소</label></th>
						<td>
							<c:if test="${prop['businessAddr'] != 0}"><c:if test="${prop['businessAddr'] == 2}"><c:set var="configBusinessAddr" value="${prop['businessAddr'] == '2' ? 'required' : '' }"/></c:if> 구주소 <input type="text" name="businessAddr" id="businessAddr" ${configBusinessAddr} /> 상세주소 <label for="businessAddrDetail" style="display: none;"></label><input type="text" name="businessAddrDetail" id="businessAddrDetail" ${configBusinessAddr} /><br/> 신주소 <label for="businessAddr2" style="display: none;"></label><input type="text" name="businessAddr2" id="businessAddr2" /> 상세주소 <label for="businessAddrDetail2" style="display: none;"></label><input type="text" name="businessAddrDetail2" id="businessAddrDetail2" /><c:if test="${prop['businessAddr']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['groupKind'] != 0}">
					<tr>
						<th><c:if test="${prop['groupKind']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupKind">대표 종목</label></th>
						<td>
							<c:if test="${prop['groupKind'] != 0}"><c:if test="${prop['groupKind'] == 2}"><c:set var="configGroupKind" value="${prop['groupKind'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="groupKind" id="groupKind" ${configGroupKind}/><c:if test="${prop['groupKind']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['groupTel'] != 0}">
					<tr>
						<th><c:if test="${prop['groupTel']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupTel">대표 전화번호</label></th>
						<td>
							<c:if test="${prop['groupTel'] != 0}"><c:if test="${prop['groupTel'] == 2}"><c:set var="configGroupTel" value="${prop['groupTel'] == '2' ? 'required' : '' }"/></c:if><select name="groupTel1" id="groupTel1" style="width: 70px;"><option value="02">02</option><option value="032">032</option><option value="033">033</option><option value="041">041</option><option value="042">042</option><option value="043">043</option><option value="051">051</option><option value="052">052</option><option value="053">053</option><option value="054">054</option><option value="055">055</option><option value="061">061</option><option value="062">062</option><option value="063">063</option><option value="064">064</option><option value="070">070</option></select>-<label for="groupTel2" style="display: none;"></label><input type="text" name="groupTel2" id="groupTel2" ${configGroupTel} maxlength="4" style="width:50px;" />-<label for="groupTel3" style="display: none;"></label><input type="text" name="groupTel3" id="groupTel3" ${configGroupTel} maxlength="4" style="width:50px;" /><c:if test="${prop['groupTel']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['groupPax'] != 0}">
					<tr>
						<th><c:if test="${prop['groupPax']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupPax1">대표 팩스</label></th>
						<td>
							<c:if test="${prop['groupPax'] != 0}"><c:if test="${prop['groupPax'] == 2}"><c:set var="configGroupPax" value="${prop['groupPax'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="groupPax1" id="groupPax1" ${configGroupPax} style="width:50px;" maxlength="4" />-<label for="groupPax2" style="display: none;"></label><input type="text" name="groupPax2" id="groupPax2" ${configGroupPax} style="width:50px;" maxlength="4" />-<label for="groupPax3" style="display: none;"></label><input type="text" name="groupPax3" id="groupPax3" ${configGroupPax} style="width:50px;" maxlength="4" /><c:if test="${prop['groupPax']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['ex01Add'] != 0}">
			        <tr>
			        	<th><c:if test="${prop['ex01Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex01']}</th>
			        	<td>
			        		<c:if test="${prop['ex01Add'] != 0}"><c:if test="${prop['ex01Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex01Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex01Type'] == 'text'}"><input type="text" name="ex01" ${configEx01Add} /></c:if><c:if test="${prop['ex01Type'] == 'select'}"><select id="ex01" name="ex01"></select></c:if><c:if test="${prop['ex01Type'] == 'checkbox'}"><div id="ex01checkbox"></div></c:if><c:if test="${prop['ex01Type'] == 'radio'}"><div id="ex01radio"></div></c:if><c:if test="${prop['ex01Type'] == 'multiinput'}"><label for="ex01_1" style="display: none;"></label><input type="text" id="ex01_1" name="ex01_1" style="width:50px;" />- <label for="ex01_2" style="display: none;"></label><input type="text" id="ex01_2" name="ex01_2" style="width:50px;" />- <label for="ex01_3" style="display: none;"></label><input type="text" id="ex01_3" name="ex01_3" style="width:50px;"/></c:if></c:if>
			        	</td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['ex02Add'] != 0}">
			        <tr>
			        	<th><c:if test="${prop['ex02Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex02']}</th>
			        	<td>
			        		<c:if test="${prop['ex02Add'] != 0}"><c:if test="${prop['ex02Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex02Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex02Type'] == 'text'}"><input type="text" name="ex02" ${configEx01Add} /></c:if><c:if test="${prop['ex02Type'] == 'select'}"><select id="ex02" name="ex02"></select></c:if><c:if test="${prop['ex02Type'] == 'checkbox'}"><div id="ex02checkbox"></div></c:if><c:if test="${prop['ex02Type'] == 'radio'}"><div id="ex02radio"></div></c:if><c:if test="${prop['ex02Type'] == 'multiinput'}"><label for="ex02_1" style="display: none;"></label><input type="text" id="ex02_1" name="ex02_1" style="width:50px;" />- <label for="ex02_2" style="display: none;"></label><input type="text" id="ex02_2" name="ex02_2" style="width:50px;" />- <label for="ex02_3" style="display: none;"></label><input type="text" id="ex02_3" name="ex02_3" style="width:50px;"/></c:if></c:if>
			        	</td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['ex03Add'] != 0}">
			        <tr>
			        	<th><c:if test="${prop['ex03Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex03']}</th>
			        	<td>
			        		<c:if test="${prop['ex03Add'] != 0}"><c:if test="${prop['ex03Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex03Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex03Type'] == 'text'}"><input type="text" name="ex03" ${configEx01Add} /></c:if><c:if test="${prop['ex03Type'] == 'select'}"><select id="ex03" name="ex03"></select></c:if><c:if test="${prop['ex03Type'] == 'checkbox'}"><div id="ex03checkbox"></div></c:if><c:if test="${prop['ex03Type'] == 'radio'}"><div id="ex03radio"></div></c:if><c:if test="${prop['ex03Type'] == 'multiinput'}"><label for="ex03_1" style="display: none;"></label><input type="text" id="ex03_1" name="ex03_1" style="width:50px;" />- <label for="ex03_2" style="display: none;"></label><input type="text" id="ex03_2" name="ex03_2" style="width:50px;" />- <label for="ex03_3" style="display: none;"></label><input type="text" id="ex03_3" name="ex03_3" style="width:50px;"/></c:if></c:if>
			        	</td>
			        </tr>
			        </c:if>
			        <c:if test="${prop['groupTitle'] != 0}">
					<tr>
						<th><c:if test="${prop['groupTitle']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupTitle">회사명</label></th>
						<td>
							<c:if test="${prop['groupTitle'] != 0}"><c:if test="${prop['groupTitle'] == 2}"><c:set var="configgroupTitle" value="${prop['groupTitle'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="groupTitle" id="groupTitle" ${configgroupTitle} /><c:if test="${prop['groupTitle']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
					<c:if test="${prop['gradeNm'] != 0}">
					<tr>
						<th><c:if test="${prop['gradeNm']  == 2}"><font color="red"> (필수) </font></c:if><label for="gradeNm">직책</label></th>
						<td>
							<c:if test="${prop['gradeNm'] != 0}"><c:if test="${prop['gradeNm'] == 2}"><c:set var="configgradeNm" value="${prop['gradeNm'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="gradeNm" id="gradeNm" ${configgradeNm} /><c:if test="${prop['gradeNm']  == 2}"><font color="red"> * </font></c:if></c:if>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</c:if>
		<c:if test="${prop['captcha'] != 0}">
		   <div id="catpcha"></div>
		   <div id="audiocatpch" style="display: none;"></div>
		   
		   <input id="reLoad" type="button" value="새로고침" />
		   <input id="soundOn" type="button" value="음성듣기" />
		   <input id="soundOnKor" type="button" value="한글음성" />
		   <br />
		   <input type="text" id="answer" name="answer" value="" />
		</c:if>
		<input type="submit" value="가입" />
	</form>
</div>
</c:if>
</div>