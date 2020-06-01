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
	<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.js"/>" ></script>
		<script type="text/javascript">
	<!--
		$(document).ready(function(){
			
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
	
	<c:set var="tabs" value="<%= tabs %>" />
	<c:set var="tab" value="<%= tab %>" />
	<c:set var="scrapPageNavi" value="<%= scrapPageNavi %>" />
	<c:set var="scrapList" value="<%= scrapList %>" />
	<c:set var="loginlogPageNavi" value="<%= loginlogPageNavi %>" />
	<c:set var="loginLogList" value="<%= loginLogList %>" />
	<c:set var="error" value="<%= error %>"/>
	<c:set var="prop" value="<%= prop %>" />
	<c:set var="errorCode" value="<%= errorCode %>" />
	<c:set var="scrapStartNum" value="<%=scrapStartNum %>" />
	<c:set var="logStartNum" value="<%=logStartNum%>" />
	<c:set var="DBType" value="<%= DBType.getDbTypeString() %>" />
	<script type="text/javascript">
	<!--
		$(document).ready(function(){
			var tabs  = $("#tabs").val();
			var tab = $("#tab").val();
			
			myPageActive(tab, tabs);
			checkDP();
	
			var objProp = new Object();
			objProp = <%= prop %>;
	
			propSettingField(objProp,"myPage","${loginVO.ex01}","${loginVO.ex02}","${loginVO.ex03}");
		});
	//-->
	</script>
	
	<div id="myModal" class="modal hide fade">	
		<div class="modal-body">
			<p id="member"></p>
		</div>
		<div class="modal-footer">
			<button class="btn btn-primary" id="signGo">탈퇴신청</button>
			<button id="modal_colse" class="btn" data-dismiss="modal" aria-hidden="true">Close</button>		
		</div>
	</div>
	
	<div class="tabbable black-box" style="margin-top: 20px;margin-bottom: 18px;">
	<input type="hidden" id="tabs" name="tabs" value="${tabs}"/>
	<input type="hidden" id="tab" name="tab" value="${tab}"/>
		<ul class="nav nav-tabs" id="nav">
				<li id="tabs1" class=""><a href="#tab1" data-toggle="tab">회원정보 수정</a></li>
				<li id="tabs2" class=""><a href="#tab2" data-toggle="tab">스크랩</a></li>
				<li id="tabs3" class=""><a href="#tab3" data-toggle="tab">로그인 정보</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane" id="tab1">
				<div class="padded">
					<div class="member_join_form">
					<c:if test="${loginVO.typeId != '30006'}" >
						<form name="mbrForm" id="mbrForm" action="<c:url value='/mbr/modify_savembr.do'/>" method="post" onsubmit="$('#passwd').val($('#passwd').val().replace(/&/g, '*')); $('#passwdConfirm').val($('#passwdConfirm').val().replace(/&/g, '*')); return true;">
							<input type="hidden" name="mbrId" id="mbrId" value="${loginVO.mbrId}"/>
							<input type="hidden" name="site" id="site" value="${Jnit_sitePath }"  />
							<input type="hidden" name="next" id="next" value="/mbr/memberCancel.jsp" />
							<input type="hidden" name="mobile" id="mobile" value="${loginVO.mobile}" />
							<input type="hidden" name="tel" id="tel" value="${loginVO.tel}"/>
							<input type="hidden" name="checkout" id="checkout" value="myPage"/>
							<input type="hidden" name="localYn" id="localYn" value="${localYn }" />	
							<input type="hidden" name="anpost" id="anpost" value="${loginVO.postcode}"/>
							<input type="hidden" name="anAddr" id="anAddr" value="${loginVO.address}"/>
							
							<table class="table table-bordered box member_join" summary="회원정보 수정페이지입니다.">
								<caption>회원정보 수정</caption>
								<tbody>
									<tr>
										<th><label for="name">이름</label></th>
										<td>
											<input type="text" id="mbrNm" name="mbrNm" value="${loginVO.mbrNm}" />
										</td>
									</tr>
									<c:if test="${prop['tel'] != 0}" >
									<tr>
										<th><c:if test="${prop['tel']  == 2}"><font color="red"> (필수) </font></c:if><label for="tel1">전화번호</label></th>
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
											<c:if test="${prop['email'] != 0}" ><c:if test="${prop['email'] == 2}"><c:set var="configEmail" value="${prop['email'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="email" id="email" value="${loginVO.email}" ${configEmail} /><c:if test="${prop['email']  == 2}"><font color="red"> * </font></c:if></c:if>
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
											<c:if test="${prop['emailRecv'] != 0}" ><c:set var="anEamilRecv" value="${loginVO.emailRecv == '1' ? 'checked' : ''}" /><c:if test="${prop['emailRecv'] == 2}"><c:set var="configEmailRecv" value="${prop['emailRecv'] == '2' ? 'required' : '' }"/></c:if>동의함 <input type="checkbox" name="emailRecv" id="emailRecv" ${configEmailRecv} value="1" ${anEamilRecv}  /><c:if test="${prop['emailRecv']  == 2}"><font color="red"> * </font></c:if></c:if>
										</td>
									</tr>
									</c:if>
									<c:if test="${prop['smsRecv'] != 0}" >
									<tr>
										<th><c:if test="${prop['smsRecv']  == 2}"><font color="red"> (필수) </font></c:if><label for="smsRecv">SMS수신동의</label></th>
										<td>
											<c:if test="${prop['smsRecv'] != 0}" ><c:set var="anSmsRecv" value="${loginVO.smsRecv == '1' ? 'checked' : ''}" /><c:if test="${prop['smsRecv'] == 2}"><c:set var="configSmsRecv" value="${prop['smsRecv'] == '2' ? 'required' : '' }"/></c:if>동의함 <input type="checkbox" name="smsRecv" id="smsRecv" ${configSmsRecv} value="1" ${anSmsRecv} /><c:if test="${prop['smsRecv']  == 2}"><font color="red"> * </font></c:if></c:if>
										</td>
									</tr>
									</c:if>
									<c:if test="${prop['ex01Add'] != 0}">
									<tr>
							        	<th><c:if test="${prop['ex01Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex01']}</th>
							        	<td>
							        		<c:if test="${prop['ex01Add'] != 0}"><c:if test="${prop['ex01Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex01Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex01Type'] == 'text'}"><input type="text" name="ex01" ${configEx01Add} value="${loginVO.ex01 }" /></c:if><c:if test="${prop['ex01Type'] == 'select'}"><select id="ex01" name="ex01"></select></c:if><c:if test="${prop['ex01Type'] == 'checkbox'}"><div id="ex01checkbox"></div></c:if><c:if test="${prop['ex01Type'] == 'radio'}"><div id="ex01radio"></div></c:if><c:if test="${prop['ex01Type'] == 'multiinput'}"><label for="ex01_1" style="display: none;"></label><input type="text" id="ex01_1" name="ex01_1" style="width:50px;" />- <label for="ex01_2" style="display: none;"></label><input type="text" id="ex01_2" name="ex01_2" style="width:50px;" />- <label for="ex01_3" style="display: none;"></label><input type="text" id="ex01_3" name="ex01_3" style="width:50px;"/></c:if></c:if>
							        	</td>							        	
							        </tr>
							        </c:if>
							        <c:if test="${prop['ex02Add'] != 0}">
							        <tr>
							        	<th><c:if test="${prop['ex02Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex02']}</th>
							        	<td>
							        		<c:if test="${prop['ex02Add'] != 0}"><c:if test="${prop['ex02Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex02Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex02Type'] == 'text'}"><input type="text" name="ex02" ${configEx01Add} value="${loginVO.ex02 }" /></c:if><c:if test="${prop['ex02Type'] == 'select'}"><select id="ex02" name="ex02"></select></c:if><c:if test="${prop['ex02Type'] == 'checkbox'}"><div id="ex02checkbox"></div></c:if><c:if test="${prop['ex02Type'] == 'radio'}"><div id="ex02radio"></div></c:if><c:if test="${prop['ex02Type'] == 'multiinput'}"><label for="ex02_1" style="display: none;"></label><input type="text" id="ex02_1" name="ex02_1" style="width:50px;" />- <label for="ex02_2" style="display: none;"></label><input type="text" id="ex02_2" name="ex02_2" style="width:50px;" />- <label for="ex02_3" style="display: none;"></label><input type="text" id="ex02_3" name="ex02_3" style="width:50px;"/></c:if></c:if>
							        	</td>							        	
							        </tr>
							        </c:if>
							        <c:if test="${prop['ex03Add'] != 0}">
									<tr>
							        	<th><c:if test="${prop['ex03Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex03']}</th>
							        	<td>
							        		<c:if test="${prop['ex03Add'] != 0}"><c:if test="${prop['ex03Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex03Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex03Type'] == 'text'}"><input type="text" name="ex03" ${configEx01Add} value="${loginVO.ex03 }" /></c:if><c:if test="${prop['ex03Type'] == 'select'}"><select id="ex03" name="ex03"></select></c:if><c:if test="${prop['ex03Type'] == 'checkbox'}"><div id="ex03checkbox"></div></c:if><c:if test="${prop['ex03Type'] == 'radio'}"><div id="ex03radio"></div></c:if><c:if test="${prop['ex03Type'] == 'multiinput'}"><label for="ex03_1" style="display: none;"></label><input type="text" id="ex03_1" name="ex03_1" style="width:50px;" />- <label for="ex03_2" style="display: none;"></label><input type="text" id="ex03_2" name="ex03_2" style="width:50px;" />- <label for="ex03_3" style="display: none;"></label><input type="text" id="ex03_3" name="ex03_3" style="width:50px;"/></c:if></c:if>
							        	</td>							        	
							        </tr>
							        </c:if>
							        <tr>
										<th><label for="passwd"><strong>비밀번호</strong></label></th>
										<td>
											<input type="password" id="passwd" name="passwd"/>
											<span id="pwLow" style="display: none;"><img src="/default/common/img/passwd/pass_level_img01.gif" alt="패스워드 안정성 하" /></span>
											<span id="pwMid" style="display: none;"><img src="/default/common/img/passwd/pass_level_img02.gif" alt="패스워드 안정성 중" /></span>
											<span id="pwTop" style="display: none;"><img src="/default/common/img/passwd/pass_level_img03.gif" alt="패스워드 안정성 상" /></span>
											<span id="pwBest" style="display: none;"><img src="/default/common/img/passwd/pass_level_img04.gif" alt="패스워드 안정성 최상" /></span>
										</td>
									</tr>
									<tr>
										<th><label for="passwdConfirm"><strong>비밀번호확인</strong></label></th>
										<td><input type="password" id="passwdConfirm" name="passwdConfirm"/><div id="pawConfirm"><strong>영문, 숫자8~12자 이내로 입력해주시기 바랍니다.</strong></div></td>
									</tr>
								</tbody>
							</table>
							<c:if test="${loginVO != null}">
							<button type="submit" class="btn btn-primary">정보수정</button>
							<button id="memberCancel" class="btn btn-primary">회원탈퇴</button>
							<button id="sginupCel" class="btn btn-danger">취소</button>
							</c:if>
						</form>
						</c:if>
						<c:if test="${loginVO.typeId == '30006'}">
						<form id="groupMbrForm" name="groupMbrForm" action="<c:url value="/mbr/signup_groupModify.do"/>" method="post">
						<input type="hidden" name="site" id="site" value="${Jnit_sitePath }" />
						<input type="hidden" name="next" id="next" value="/mbr/memberCancel.jsp" />
						<input type="hidden" name="mobile" id="mobile" value="${loginVO.mobile}" />
						<input type="hidden" name="tel" id="tel" value="${loginVO.tel}"/>
						<input type="hidden" name="establishment" id="establishment" value="${loginVO.establishment}"/>
						<input type="hidden" name="corporation" id="corporation" value="${loginVO.corporation}" />
						<input type="hidden" name="primaryKey" id="primaryKey" value="${loginVO.primaryKey}"/>
						<input type="hidden" name="anBusinessAddr" id="anBusinessAddr" value="${loginVO.businessAddr}" />
						<input type="hidden" name="anBusinessAddr2" id="anBusinessAddr2" value="${loginVO.businessAddrNew}" />
						<input type="hidden" name="businessPlace" id="businessPlace" value="${loginVO.businessPlace}"/>
						<input type="hidden" name="groupTel" id="groupTel" value="${loginVO.groupTel}" />
						<input type="hidden" name="groupPax" id="groupPax" value="${loginVO.groupPax}" />
						<input type="hidden" name="checkout" id="checkout" value="myPage"/>	
						<input type="hidden" name="typeCheck" id="typeCheck">
						<input type="hidden" name="localYn" id="localYn" value="${localYn }" />
						<input type="hidden" name="anpost" id="anpost" value="${loginVO.postcode}"/>
						<input type="hidden" name="anAddr" id="anAddr" value="${loginVO.address}"/>
							<c:if test="${error != null}">
								<strong>${error}</strong>
							</c:if>
							<c:if test="${error == null}">
								<table class="table table-bordered box member_join" summary="단체회원 작성페이지입니다.">
									<tbody>
										<tr>
											<th><label for="groupNm">단체이름</label></th>
											<td><input type="text" name="groupNm" id="groupNm" value="${loginVO.mbrNm}"/></td>
										</tr>
										<tr>
											<th><label for="groupPasswd">패스워드</label></th>
											<td><input type="password" name="groupPasswd" id="groupPasswd" /></td>
										</tr>
										<tr>
											<th><label for="groupPasswdConfrim">패스워드확인</label></th>
											<td><input type="password" name="groupPasswdConfrim" id="groupPasswdConfrim" /><div id="groupPawConfirm"><strong>영문, 숫자8~12자 이내로 입력해주시기 바랍니다.</strong></div></td>
										</tr>
										<tr>
										<th><label for="name">이름</label></th>
											<td>
												<input type="text" id="mbrNm" name="mbrNm" value="${loginVO.mbrNm}" />
											</td>
										</tr>
										<c:if test="${prop['tel'] != 0}" >
										<tr>
											<th><c:if test="${prop['tel']  == 2}"><font color="red"> (필수) </font></c:if><label for="tel1">전화번호</label></th>
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
												<c:if test="${prop['email'] != 0}" ><c:if test="${prop['email'] == 2}"><c:set var="configEmail" value="${prop['email'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="email" id="email" value="${loginVO.email}" ${configEmail} /><c:if test="${prop['email']  == 2}"><font color="red"> * </font></c:if></c:if>
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
												<c:if test="${prop['emailRecv'] != 0}" ><c:set var="anEamilRecv" value="${loginVO.emailRecv == '1' ? 'checked' : ''}" /><c:if test="${prop['emailRecv'] == 2}"><c:set var="configEmailRecv" value="${prop['emailRecv'] == '2' ? 'required' : '' }"/></c:if>동의함 <input type="checkbox" name="emailRecv" id="emailRecv" ${configEmailRecv} value="1" ${anEamilRecv}  /><c:if test="${prop['emailRecv']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['smsRecv'] != 0}" >
										<tr>
											<th><c:if test="${prop['smsRecv']  == 2}"><font color="red"> (필수) </font></c:if><label for="smsRecv">SMS수신동의</label></th>
											<td>
												<c:if test="${prop['smsRecv'] != 0}" ><c:set var="anSmsRecv" value="${loginVO.smsRecv == '1' ? 'checked' : ''}" /><c:if test="${prop['smsRecv'] == 2}"><c:set var="configSmsRecv" value="${prop['smsRecv'] == '2' ? 'required' : '' }"/></c:if>동의함 <input type="checkbox" name="smsRecv" id="smsRecv" ${configSmsRecv} value="1" ${anSmsRecv} /><c:if test="${prop['smsRecv']  == 2}"><font color="red"> * </font></c:if></c:if>
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
										<c:if test="${prop['mutual'] != 0}" >
										<tr class="groupType4" style="display: none;">
											<th><label for="mutual">상호</label></th>
											<td>
												<c:if test="${prop['mutual'] != 0}"><c:if test="${prop['mutual'] == 2}"><c:set var="configMutual" value="${prop['mutual'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="mutual" id="mutual" value="${loginVO.mutual}" ${configMutual} /><c:if test="${prop['mutual']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['corporateName'] != 0}" >																		
										<tr>
											<th><c:if test="${prop['corporateName']  == 2}"><font color="red"> (필수) </font></c:if><label for="corporateName">법인명(단체명)</label></th>
											<td>
												<c:if test="${prop['corporateName'] != 0}"><c:if test="${prop['corporateName'] == 2}"><c:set var="configCorporateNmae" value="${prop['corporateName'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="corporateName" id="corporateName" value="${loginVO.corporateName}"  ${configCorporateNmae}/><c:if test="${prop['corporateName']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['groupName'] != 0}" >
										<tr>
											<th><c:if test="${prop['groupName']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupName">대표자명</label></th>
											<td>
												<c:if test="${prop['groupName'] != 0}"><c:if test="${prop['groupName'] == 2}"><c:set var="configGroupNmae" value="${prop['groupName'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="groupName" id="groupName" value="${loginVO.groupName}" ${configGroupNmae} /><c:if test="${prop['groupName']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['businessPlace'] != 0}" >
										<tr>
											<th><c:if test="${prop['businessPlace']  == 2}"><font color="red"> (필수) </font></c:if><label for="businessPlace1">사업장 소재지</label></th>
											<td>
												<c:if test="${prop['businessPlace'] != 0}"><c:if test="${prop['businessPlace'] == 2}"><c:set var="configBusinessPlace" value="${prop['businessPlace'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="businessPlace1" id="businessPlace1" ${configBusinessPlace} style="width:50px;" />-<label for="businessPlace2" style="display: none;"></label><input type="text" name="businessPlace2" id="businessPlace2" ${configBusinessPlace} style="width:50px;"/><button class="btn btn-mini" id="groupPostFind">주소찾기</button><c:if test="${prop['businessPlace']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['businessAddr'] != 0}" >
										<tr>
											<th><c:if test="${prop['businessAddr']  == 2}"><font color="red"> (필수) </font></c:if><label for="businessAddr">사업장 주소</label></th>
											<td>
												<c:if test="${prop['businessAddr'] != 0}"><c:if test="${prop['businessAddr'] == 2}"><c:set var="configBusinessAddr" value="${prop['businessAddr'] == '2' ? 'required' : '' }"/></c:if> 구주소 <input type="text" name="businessAddr" id="businessAddr" ${configBusinessAddr} /> 상세주소 <label for="businessAddrDetail" style="display: none;"></label><input type="text" name="businessAddrDetail" id="businessAddrDetail" ${configBusinessAddr} /><br/> 신주소 <label for="businessAddr2" style="display: none;"></label><input type="text" name="businessAddr2" id="businessAddr2" /> 상세주소 <label for="businessAddrDetail2" style="display: none;"></label><input type="text" name="businessAddrDetail2" id="businessAddrDetail2" /><c:if test="${prop['businessAddr']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['groupKind'] != 0}" >
										<tr>
											<th><c:if test="${prop['groupKind']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupKind">대표종목</label></th>
											<td>
												<c:if test="${prop['groupKind'] != 0}"><c:if test="${prop['groupKind'] == 2}"><c:set var="configGroupKind" value="${prop['groupKind'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="groupKind" id="groupKind" value="${loginVO.groupKind}" ${configGroupKind}/><c:if test="${prop['groupKind']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['groupTel'] != 0}" >
										<tr>
											<th><c:if test="${prop['groupTel']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupTel1">대표전화</label></th>
											<td>
												<c:if test="${prop['groupTel'] != 0}"><c:if test="${prop['groupTel'] == 2}"><c:set var="configGroupTel" value="${prop['groupTel'] == '2' ? 'required' : '' }"/></c:if><select name="groupTel1" id="groupTel1" style="width: 70px;"><option value="02">02</option><option value="032">032</option><option value="033">033</option><option value="041">041</option><option value="042">042</option><option value="043">043</option><option value="051">051</option><option value="052">052</option><option value="053">053</option><option value="054">054</option><option value="055">055</option><option value="061">061</option><option value="062">062</option><option value="063">063</option><option value="064">064</option><option value="070">070</option></select>-<label for="groupTel2" style="display: none;"></label><input type="text" name="groupTel2" id="groupTel2" ${configGroupTel} maxlength="4" style="width:50px;" />-<label for="groupTel3" style="display: none;"></label><input type="text" name="groupTel3" id="groupTel3" ${configGroupTel} maxlength="4" style="width:50px;" /><c:if test="${prop['groupTel']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['groupPax'] != 0}" >
										<tr>
											<th><c:if test="${prop['groupPax']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupPax1">대표팩스</label></th>
											<td>
												<c:if test="${prop['groupPax'] != 0}"><c:if test="${prop['groupPax'] == 2}"><c:set var="configGroupPax" value="${prop['groupPax'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="groupPax1" id="groupPax1" ${configGroupPax} style="width:50px;" maxlength="4" />-<label for="groupPax2" style="display: none;"></label><input type="text" name="groupPax2" id="groupPax2" ${configGroupPax} style="width:50px;" maxlength="4" />-<label for="groupPax3" style="display: none;"></label><input type="text" name="groupPax3" id="groupPax3" ${configGroupPax} style="width:50px;" maxlength="4" /><c:if test="${prop['groupPax']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['ex01Add'] != 0}">
										<tr>
								        	<th><c:if test="${prop['ex01Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex01']}</th>
								        	<td>
								        		<c:if test="${prop['ex01Add'] != 0}"><c:if test="${prop['ex01Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex01Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex01Type'] == 'text'}"><input type="text" name="ex01" ${configEx01Add} value="${loginVO.ex01 }" /></c:if><c:if test="${prop['ex01Type'] == 'select'}"><select id="ex01" name="ex01"></select></c:if><c:if test="${prop['ex01Type'] == 'checkbox'}"><div id="ex01checkbox"></div></c:if><c:if test="${prop['ex01Type'] == 'radio'}"><div id="ex01radio"></div></c:if><c:if test="${prop['ex01Type'] == 'multiinput'}"><label for="ex01_1" style="display: none;"></label><input type="text" id="ex01_1" name="ex01_1" style="width:50px;" />- <label for="ex01_2" style="display: none;"></label><input type="text" id="ex01_2" name="ex01_2" style="width:50px;" />- <label for="ex01_3" style="display: none;"></label><input type="text" id="ex01_3" name="ex01_3" style="width:50px;"/></c:if></c:if>
								        	</td>							        	
								        </tr>
								        </c:if>
								        <c:if test="${prop['ex02Add'] != 0}">
								        <tr>
								        	<th><c:if test="${prop['ex02Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex02']}</th>
								        	<td>
								        		<c:if test="${prop['ex02Add'] != 0}"><c:if test="${prop['ex02Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex02Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex02Type'] == 'text'}"><input type="text" name="ex02" ${configEx01Add} value="${loginVO.ex02 }" /></c:if><c:if test="${prop['ex02Type'] == 'select'}"><select id="ex02" name="ex02"></select></c:if><c:if test="${prop['ex02Type'] == 'checkbox'}"><div id="ex02checkbox"></div></c:if><c:if test="${prop['ex02Type'] == 'radio'}"><div id="ex02radio"></div></c:if><c:if test="${prop['ex02Type'] == 'multiinput'}"><label for="ex02_1" style="display: none;"></label><input type="text" id="ex02_1" name="ex02_1" style="width:50px;" />- <label for="ex02_2" style="display: none;"></label><input type="text" id="ex02_2" name="ex02_2" style="width:50px;" />- <label for="ex02_3" style="display: none;"></label><input type="text" id="ex02_3" name="ex02_3" style="width:50px;"/></c:if></c:if>
								        	</td>							        	
								        </tr>
								        </c:if>
								        <c:if test="${prop['ex03Add'] != 0}">
										<tr>
								        	<th><c:if test="${prop['ex03Add']  == 2}"><font color="red"> (필수) </font></c:if>${prop['ex03']}</th>
								        	<td>
								        		<c:if test="${prop['ex03Add'] != 0}"><c:if test="${prop['ex03Add'] == 2}"><c:set var="configEx01Add" value="${prop['ex03Add'] == '2' ? 'required' : '' }"/></c:if><c:if test="${prop['ex03Type'] == 'text'}"><input type="text" name="ex03" ${configEx01Add} value="${loginVO.ex03 }" /></c:if><c:if test="${prop['ex03Type'] == 'select'}"><select id="ex03" name="ex03"></select></c:if><c:if test="${prop['ex03Type'] == 'checkbox'}"><div id="ex03checkbox"></div></c:if><c:if test="${prop['ex03Type'] == 'radio'}"><div id="ex03radio"></div></c:if><c:if test="${prop['ex03Type'] == 'multiinput'}"><label for="ex03_1" style="display: none;"></label><input type="text" id="ex03_1" name="ex03_1" style="width:50px;" />- <label for="ex03_2" style="display: none;"></label><input type="text" id="ex03_2" name="ex03_2" style="width:50px;" />- <label for="ex03_3" style="display: none;"></label><input type="text" id="ex03_3" name="ex03_3" style="width:50px;"/></c:if></c:if>
								        	</td>							        	
								        </tr>
								        </c:if>
								        <c:if test="${prop['groupTitle'] != 0}" >
										<tr>
											<th><c:if test="${prop['groupTitle']  == 2}"><font color="red"> (필수) </font></c:if><label for="groupTitle">회사명</label></th>
											<td>
												<c:if test="${prop['groupTitle'] != 0}"><c:if test="${prop['groupTitle'] == 2}"><c:set var="configgroupTitle" value="${prop['groupTitle'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="groupTitle" id="groupTitle" value="${loginVO.groupTitle}" ${configgroupTitle} /><c:if test="${prop['groupTitle']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>
										<c:if test="${prop['gradeNm'] != 0}" >
										<tr>
											<th><c:if test="${prop['gradeNm']  == 2}"><font color="red"> (필수) </font></c:if><label for="gradeNm">직책</label></th>
											<td>
												<c:if test="${prop['gradeNm'] != 0}"><c:if test="${prop['gradeNm'] == 2}"><c:set var="configgradeNm" value="${prop['gradeNm'] == '2' ? 'required' : '' }"/></c:if><input type="text" name="gradeNm" id="gradeNm" value="${loginVO.gradeNm}" ${configgradeNm} /><c:if test="${prop['gradeNm']  == 2}"><font color="red"> * </font></c:if></c:if>
											</td>
										</tr>
										</c:if>									        
									</tbody>
								</table>
							</c:if>
							<button type="submit" class="btn btn-primary">정보수정</button>
							<button id="memberCancel" class="btn btn-primary">회원탈퇴</button>
							<button id="sginupCel" class="btn btn-danger">취소</button>
						</form>
						</c:if>
					</div>
				</div>
			</div>
			<div class="tab-pane" id="tab2">
				<div class="padded">
					<div class="member_join_form">
						<table class="table" summary="스크랩 정보 페이지입니다.">
							<caption>스크랩 정보</caption>
							<thead>
								<tr>
									<th>순번</th>
									<th>메뉴명</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${!empty scrapList }">
									<c:forEach var="result" items="${scrapList}" varStatus="status">
										<tr rel="${result.scrapId}">
											<td>${scrapStartNum - status.index}</td>
											<td class="AlignLeft"><a href="${result.url}" target="_blank" title="새 창으로 열립니다.">${result.title}</a></td>
											<td><a href="javascript:delScrap('${result.scrapId}');"><img src="${pageContext.request.contextPath }/{-SITEPATH-}/common/img/scrap_del.gif" alt="스크랩 삭제" /></a></td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty scrapList }">
									<tr>
										<td colspan="3">스크랩 된 자료가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<div id="page_navi" class="pagination">
								<ui:pagination paginationInfo = "${scrapPageNavi}"
										   type="jnitDefault"
										   jsFunction="fn_myPage_navi"
										   />
							
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane" id="tab3">
				<div class="padded">
					<div class="member_join_form">
						<table class="table"summary="로그인 정보 페이지입니다.">
							<caption>로그인 정보</caption>
							<thead>
								<tr>
									<th>순번</th>
									<th>IP</th>
									<th>접속시간</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${empty loginLogList}" >
								<tr>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</c:if>
							<c:if test="${!empty loginLogList}" >
								<c:forEach var="resultLoginLog" items="${loginLogList}" varStatus="status">
									<tr>
										<td>${logStartNum - status.index}</td>
										<td>${resultLoginLog.ipAddr}</td>
										<td>
											<c:if test="${DBType == 'ORACLE' || DBType == 'TIBERO'}">
												<c:out value="${resultLoginLog.created}" />
											</c:if>
											<c:if test="${DBType != 'ORACLE' && DBType != 'TIBERO' }">
												<fmt:formatDate value="${resultLoginLog.created}" pattern="yyyy-MM-dd HH:mm:ss"/>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							</tbody>
						</table>
						<div id="page_navi" class="pagination">
								<ui:pagination paginationInfo = "${loginlogPageNavi}"
										   type="jnitDefault"
										   jsFunction="fn_myPage_link_navi"
										   />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>