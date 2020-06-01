<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script>
	$(document).ready(function(){
		$("#regist").click(function(e){
			e.preventDefault();
			var addip = $.trim($("#ipadd").val());
			var confrimSize = $("#iplist option[value='"+addip+"']").length;
			var variable = "<option value="+addip+" selected='selected'>"+addip+"</option>";
			var expUrl = /^([1]\d\d|[2][0-5][0-5]|[1-9][0-9]|[0-9]){1}(\.([1]\d\d|[2][0-5][0-5]|[1-9][0-9]|[0-9]|[\*])){3}$/;

			if(addip == ''){
				alert('IP를 입력해 주세요');
				$("#addip").focus();
				return false;
			/*	
			}else if(!expUrl.test(addip)){
				alert('IP유형이 아닙니다.');
				$("#addip").focus();
				return false;
			*/
			}else if(confrimSize > 0){
				alert('중복된 데이터가 존재합니다');
				$("#addip").focus();
				return false;
			}
			$('#iplist').append(variable);
			$('#iplist').select2();
			$('#noIp').attr('style','display:block;');
			
		});
	});
	
	function Jnit_secure_question(num){
		var baseId = "JnitSecureQuestion"+num;
		var baseObject = $("#"+baseId);
		var displayState = baseObject.css("display");
		
		if(displayState == "none"){
			baseObject.show();
		}else{
			baseObject.hide();
		}
	}
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
        	<div class="row-fluid">
            	<div class="span12">
                	<div class="widget-box">
                	<form id="configForm" name="configForm" method="post" action="<c:url value='/cms/config/secureSave.do'/>">
                    	<div class="widget-title">
                        	<span class="icon"><i class="icon-cog"></i></span>
                            <button type="submit" class="btn btn-small" id="save"><i class="icon icon-ok"></i> 저장</button>
                            <font color="red"><c:out value="접속 IP : ${myIP }"/></font> 
                        </div>
                        <div class="widget-content nopadding">
						    <table class="table table-bordered table-striped th_left" summary="보안설정">
						        <tbody>
						            <tr>
						            	<th style="width: 100px;" <%--rowspan="2"--%>><strong>*</strong> 암호화설정</th>
						                <th style="width: 110px;"> 패스워드 알고리즘</th>
						                <td>
							                <%-- <label><input type="radio" id="secpw1" name="secpw" value="md5" <c:out value="${secureProp['secpw'] == 'md5' ? 'checked' : '' }" />/> MD5</label> --%>
							                <label><input type="radio" id="secpw2" name="secpw" value="sha-256" <c:out value="${secureProp['secpw'] == 'sha-256' ? 'checked' : '' }" />/> SHA-256</label>
						                </td>
						            </tr>
						            <%--
						            <tr>
						                <th> 개인정보 알고리즘</th>
						                <td>
							                <label><input type="radio" id="sec1" name="sec" value="des" <c:out value="${secureProp['sec'] == 'des' ? 'checked' : '' }" />/> DES</label>
							                <label><input type="radio" id="sec2" name="sec" value="aes" <c:out value="${secureProp['sec'] == 'aes' ? 'checked' : '' }" />/> AES</label>
						                </td>
						            </tr>
						             --%>
									<tr>
										<th rowspan="3"><strong>*</strong> IP접근설정</th>
						                <th> 타입 &nbsp;<a href="javascript:Jnit_secure_question('1');"><i class="icon-question-sign"></i></a></th>
						                <td>
							                <label><input type="radio" id="ip0" name="ipFilterType" value="no" <c:out value="${secureProp['ipFilterType'] == 'no' ? 'checked' : '' }" />/> 사용안함</label>
							                <label data-toggle="tooltip" title="IP리스트의 IP를 차단합니다."><input type="radio" id="ip1" name="ipFilterType" value="blackList" <c:out value="${secureProp['ipFilterType'] == 'blackList' ? 'checked' : '' }" />/> 차단리스트관리</label>
							                <label data-toggle="tooltip" title="IP리스트를 제외한 모든 IP를 차단합니다."><input type="radio" id="ip2" name="ipFilterType" value="whiteList" <c:out value="${secureProp['ipFilterType'] == 'whiteList' ? 'checked' : '' }" />/> 허용리스트관리</label>
							                <br />
                                       		<span id="JnitSecureQuestion1" style="display: none;">
												&nbsp;- 차단리스트 관리 : ip 리스트에 등록된 아이피만 관리자모드 접근을 차단합니다.<br />
												&nbsp;- 허용리스트 관리 : 해당 아이피 이외의 다른 모든 아이피의 관리자모드 접근을 차단합니다.
												
											</span>
						                </td>
						            </tr>
						            <tr>
						                <th> IP 리스트</th>
						                <td>
						                	<select multiple="multiple" id="iplist" name="iplist" class="input-xxxlarge">
						                		<c:forEach items="${ipList}" var="ip">
						                			<option value="${ip}" selected="selected">${ip}</option>
						                		</c:forEach>
						                	</select>
						                </td>
						            </tr>
						            <tr>
						            	<th> IP 추가</th>
						            	<td>
						            		<input type="text" id="ipadd" name="ipadd" value="" />
						                	<button id="regist" class="btn btn-small">추가하기</button>
						            	</td>
						            </tr>
						        </tbody>
						    </table>
                        </div>
                    </form>
                    </div>
                </div>
            </div>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>