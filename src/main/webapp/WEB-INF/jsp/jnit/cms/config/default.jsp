<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--
function fn_egov_save() {	
	frm = document.getElementById("JnitDefaultInfoVO");
	frm.action = "<c:url value='/cms/config/save.do'/>";
    frm.submit();
}
function Jnit_siteSearch(){
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/config/ajax/site.do'/>",
		data : ""
	}).done(function(data){		
		$("#modelHtml").empty();
		$("#modelHtml").append(data);
		$('#myModal').modal('toggle');
	});
}

function Jnit_span(type,name){
	if(type){
		$("."+name).css("display","");
	}else{
		$("."+name).css("display","none");
	}
}

$(document).ready(function(){	
	//SSL 기본설정	
	if($("#ssl1").is(":checked")){
		$("#sslpwlable").css('display','');
		$("#sslpw").css('display','');		
	}else{
		$("#sslpwlable").css('display','none');
		$("#sslpw").css('display','none');
	}	
	
	//SSL 설정 클릭 설정
	$("#ssl1").click(function(){
		$("#sslpwlable").css('display','');
		$("#sslpw").css('display','');
	});
	$("#ssl0").click(function(){		
		if(confirm("기존 비밀번호를 초기화하고 사용안함으로 설정하시겠습니까?")){
			$("#sslpwlable").css('display','none');
			$("#sslpw").css('display','none');
			$("#sslpw").val("");	
		}else{
			$("#ssl1").attr("checked",true);
			$("#ssl0").attr("checked",false);
		}		
	});
	
	var displayList = ["facebook1","twitter1","google1"];
	for(var i=0; i<displayList.length; i++){
		if($("#"+displayList[i]).is(":checked")){
			$("."+displayList[i]).css("display","");
		}else{
			$("."+displayList[i]).css("display","none");
		}
	}
});

function Jnit_default_question(num){
	var baseId = "JnitDefaultQuestion"+num;
	var baseObject = $("#"+baseId);
	var displayState = baseObject.css("display");
	
	if(displayState == "none"){
		baseObject.show();
	}else{
		baseObject.hide();
	}
}

//-->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
        	<div class="row-fluid">
            	<div class="span12">
                	<div class="widget-box">
                		<form:form commandName="JnitDefaultInfoVO" method="post" action="${pageContext.request.contextPath }/cms/config/defaultSave.do">                	
                    	<div class="widget-title">
                        	<span class="icon"><i class="icon-cog"></i></span>
                            <button type="submit" class="btn btn-small"><i class="icon icon-ok"></i> 저장</button>
                        </div>
                        <div class="widget-content nopadding">
	                           <table class="table table-bordered table-striped th_left">
	                               <tbody>
	                                   <tr>
	                                       <th colspan="2"><strong>*</strong> <label>OS설정</label></th>
	                                       <td><c:out value='${props["Globals.OsType"]}'/></td>
	                                   </tr>
	                                   <tr>
	                                       <th rowspan="3" style="width: 75px;"><strong>*</strong> DBMS설정</th>
	                                       <th style="width: 60px;"><label>Type</label></th>
	                                       <td><c:out value='${props["Globals.DbType"]}'/></td>
	                                   </tr>
	                                   <tr>
	                                       <th><label>Driver</label></th>
	                                       <td><c:out value='${props["Globals.DriverClassName"]}'/></td>
	                                   </tr>
	                                   <tr>
	                                       <th><label>JDBC</label></th>
	                                       <td><c:out value='${props["Globals.Url"]}'/></td>
	                                   </tr>
	                                   <!-- 
	                                   <tr>
	                                       <th rowspan="3"><strong>*</strong> 인증설정</th>
	                                       <th>실명인증</th>
	                                       <td>
	                                           <input type="radio" name="siauth" value="0" <c:out value="${defaultProp['siauth'] == '0' ? 'checked' : '' }"/>><label> 사용안함</label>
	                                           <input type="radio" name="siauth" value="1" <c:out value="${defaultProp['siauth'] == '1' ? 'checked' : '' }"/>><label> 사용함</label>
	                                           <%-- <input type="radio" name="siauth" value="2" <c:out value="${defaultProp['siauth'] == '2' ? 'checked' : '' }"/>><label> 가상식별코드</label> --%>
	                                       </td>
	                                   </tr>
	                                   <tr>
	                                       <th>GPIN인증</th>
	                                       <td>
	                                           <input type="radio" name="gpinauth" value="0" <c:out value="${defaultProp['gpinauth'] == '0' ? 'checked' : ''}"/>><label> 사용안함</label>
	                                           <input type="radio" name="gpinauth" value="1" <c:out value="${defaultProp['gpinauth'] == '1' ? 'checked' : ''}"/>><label> 사용함</label>
	                                       </td>
	                                   </tr>
	                                   <tr>
	                                       <th>Email 인증</th>
	                                       <td>
	                                           <input type="radio" name="emailauth" value="0" <c:out value="${defaultProp['emailauth'] == '0' ? 'checked' : ''}"/>><label> 사용안함</label>
	                                           <input type="radio" name="emailauth" value="1" <c:out value="${defaultProp['emailauth'] == '1' ? 'checked' : ''}"/>><label> 사용함</label>
	                                       </td>
	                                   </tr>
	                                    -->
	                                   <%--
	                                   <tr>
	                                       <th>공인인증서</th>
	                                       <td>
	                                           <input type="radio" name="pkiauth" value="0" <c:out value="${defaultProp['pkiauth'] == '0' ? 'checked' : ''}"/>><label> 사용안함</label>
	                                           <input type="radio" name="pkiauth" value="1" <c:out value="${defaultProp['pkiauth'] == '1' ? 'checked' : ''}"/>><label> 사용함</label>
	                                       </td>
	                                   </tr>
	                                    --%>
	                                    <tr>
	                                       <th colspan="2"><strong>*</strong> CMS 메인화면 설정 <a href="javascript:Jnit_default_question('1');"><i class="icon-question-sign"></i></a></th>
	                                       <td>
	                                           <input type="radio" id="cmsmain0" name="cmsmain" value="0" <c:out value="${defaultProp['cmsmain'] == '0' ? 'checked' : ''}"/>><label for="cmsmain0">서버상태 메인</label>
	                                           <input type="radio" id="cmsmain1" name="cmsmain" value="1" <c:out value="${defaultProp['cmsmain'] == '1' ? 'checked' : ''}"/>><label for="cmsmain1">구글통계 메인</label>
	                                           
												<div id="JnitDefaultQuestion1" style="display: none;">
													<strong>&nbsp;- 환경설정 &gt; 기본 설정 &gt; ANALYTICS 설정을 해주셔야 정상적으로 작동합니다.</strong>
												</div>
	                                      </td>
	                                   </tr>
	                                   <tr>
	                                       <th colspan="2"><strong>*</strong> SSL설정 <a href="javascript:Jnit_default_question('2');"><i class="icon-question-sign"></i></a></th>
	                                       <td>
	                                           <input type="radio" id="ssl0" name="ssl" value="0" <c:out value="${defaultProp['ssl'] == '0' ? 'checked' : ''}"/>><label for="ssl0">사용안함</label>
	                                           <input type="radio" id="ssl1" name="ssl" value="1" <c:out value="${defaultProp['ssl'] == '1' ? 'checked' : ''}"/>><label for="ssl1">사용함</label>
	                                           <label for="sslpw" id="sslpwlable" style="display: none">패스워드 : </label><input type="text" name="sslpw" id="sslpw" value="<c:out value="${defaultProp['sslpw'] }"/>"  style="display: none"/>
	                                           
												<div id="JnitDefaultQuestion2" style="display: none;">
													<strong>&nbsp;- ssl 해당 설정은 자동으로 되는 것이 아니라 세팅 여부를 체크하기 위한 기능입니다.</strong>
												</div>                                           
	                                       </td>
	                                   </tr>
	                                   <tr>
	                                       <th colspan="2"><strong>*</strong> SSO설정 <a href="javascript:Jnit_default_question('3');"><i class="icon-question-sign"></i></a></th>
	                                       <td>
	                                           <input type="radio" id="sso0" name="sso" value = "0" <c:out value="${defaultProp['sso'] == '0' ? 'checked' : ''}"/>><label for="sso0">사용안함</label>
	                                           <input type="radio" id="sso1" name="sso" value = "1" <c:out value="${defaultProp['sso'] == '1' ? 'checked' : ''}"/>><label for="sso1">사용함(CMS통합로그인)</label>
	                                           <input type="radio" id="sso2" name="sso" value = "2" <c:out value="${defaultProp['sso'] == '2' ? 'checked' : ''}"/>><label for="sso2">사용함(SSO솔루션)</label>
	                                          
												<div id="JnitDefaultQuestion3" style="display: none;">
													<strong>&nbsp;- sso 해당 설정은 cms 통합로그인 옵션 이외의 현황 체크 옵션입니다.</strong>
												</div>
	                                       </td>
	                                   </tr>
	                                   <tr>
	                                   		<th colspan="2">중복로그인 사용여부 <a href="javascript:Jnit_default_question('4');"><i class="icon-question-sign"></i></a></th>
	                                   		<td>
	                                   			<input type="radio" id="overlap0" name="overlap" value="0" <c:out value="${defaultProp['overlap'] == '0' ? 'checked' : ''}"/>/><label for="overlap0">사용안함</label>
	                                   			<input type="radio" id="overlap1" name="overlap" value="1" <c:out value="${defaultProp['overlap'] == '1' ? 'checked' : ''}"/>/><label for="overlap1">사용함</label>
	                                   			 
												<div id="JnitDefaultQuestion4" style="display: none;">
													<strong>&nbsp;- 중복 로그인 사용 시 모든 페이지 접속시 체크를 인터셉터 방식으로 체크합니다.</strong>
												</div>
	                                   		</td>
	                                   </tr>
	                                   <tr>
										    <th colspan="2">CMS 스킨 </th>
										    <td>
										        <div class="radio"><span class="checked"><input type="radio" id="skinMode1" name="skinMode" value="default" <c:out value="${defaultProp['skinMode'] == 'default' ? 'checked' : ''}"/> style="opacity: 0;"></span></div><label for="skinMode1">기본</label>
										
										        <div class="radio"><span class=""><input type="radio" id="skinMode2" name="skinMode" value="white" <c:out value="${defaultProp['skinMode'] == 'white' ? 'checked' : ''}"/> style="opacity: 0;"></span></div><label for="skinMode2">화이트 모드</label>
										
										        <div class="radio"><span class=""><input type="radio" id="skinMode3" name="skinMode" value="black" <c:out value="${defaultProp['skinMode'] == 'black' ? 'checked' : ''}"/> style="opacity: 0;"></span></div><label for="skinMode3">블랙 모드</label>
										    </td>
										</tr>
	                                   <tr>
	                                   		<th colspan="2">
	                                   			redirect 경로 <a href="javascript:Jnit_default_question('5');"><i class="icon-question-sign"></i></a>
	                                   			<a href="javascript:Jnit_siteSearch();" class="btn btn-small" style="float: right;"><i class="icon-search"></i> 찾기</a>
	                                   		</th>
	                                   		<td>
	                                   			<input type="text" id="redirectPath" name="redirectPath" value="<c:out value="${defaultProp['redirectPath']}"/>" style="width: 98%"/>
	                                   			
												<div id="JnitDefaultQuestion5" style="display: none;">
													<strong>&nbsp;- http://도메인/ 로 접근시 디폴트 사이트 지정 기능입니다.</strong>
												</div>
	                                   		</td>
	                                   </tr>
	                               </tbody>
	                           </table>
                        </div>                  
                   		</form:form>
                    </div>
                </div>
            </div>
		<%-- Contents End --%>
	</div>
</div>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">Modal header</h3>
	</div>
	<div class="modal-body">
		<div id="modelHtml"></div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
		<%-- <button class="btn btn-primary">Save changes</button> --%>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>