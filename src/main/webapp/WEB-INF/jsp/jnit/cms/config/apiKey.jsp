<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--
$(document).ready(function(){	
	$("#naverMapnaverMapUrl").val("추후 서비스제공예정");
	$("#naverMapKey").val("추후 서비스제공예정");
});
function api_question(url){
	window.open('${pageContext.request.contextPath}'+url,'메뉴얼','width=600,height=800');
	
}

function Jnit_api_question(num){
	var baseId = "JnitApiQuestion"+num;
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
                	<form id="apikeyForm" name="apikeyForm" method="post" action="<c:url value='/cms/config/apiKeySave.do'/>">
                    	<div class="widget-title">
                        	<span class="icon"><i class="icon-cog"></i></span>
                            <button type="submit" class="btn btn-small" id="save"><i class="icon icon-ok"></i> 저장</button>
                        </div>
                        <div class="widget-content nopadding">
						    <table class="table table-bordered table-striped th_left" summary="보안설정">
						    	<tbody>
						    		<tr>
						    			<th style="width: 10%;">주소 API <a class="a-api-question" href="https://www.juso.go.kr/addrlink/devAddrLinkRequestWrite.do?returnFn=write&cntcMenu=URL" target="_blank"><i class="icon-question-sign i-api-question"></i></a></th>
						    			<th style="width: 10%;">KEY : </th>
						    			<td><input type="text" id="addrKey" name="addrKey" style="width: 95%" value="<c:out value="${mapApi['addrKey']}" />" /></td>
					    			</tr>
						    		<tr>
						    			<th rowspan="2">카카오지도 API</th>
						    			<th>URL</th>
						    			<td><input type="text" id="daumMapUrl" name="daumMapUrl" style="width: 95%" readOnly="readOnly" value="<c:out value="//dapi.kakao.com/v2/maps/sdk.js?appkey=" />" /></td>
						    		</tr>
					    			<tr>
					    				<th>KEY&nbsp;<a href="javascript:Jnit_api_question('1');"><i class="icon-question-sign"></i></a></th>
					    				<td>
					    					<input type="text" id="daumMapKey" name="daumMapKey" style="width: 95%" value="<c:out value="${mapApi['daumKey']}" />" />
					    					
					    					<div id="JnitApiQuestion1" style="display: none;">
							                	<a href="https://developers.kakao.com/" target="_blank"><img src="/map_api/images/pop_img02.png" alt="카카오 지도 API Key입력 방법 이미지" /></a>
							                	이미지 클릭시 발급페이지로 이동
							                </div>
					    				</td>
						    		</tr>
						    		<%--
						    		<tr>
						    			<th rowspan="2" style="width: 20%;">네이버(NAVER) API &nbsp;<a href="http://dev.naver.com/" target="_blank" title="새창" /> api key 발급</a></th>
						    			<th style="width: 5%;">URL</th>
						    			<td><input type="text" id="naverMapnaverMapUrl" name="naverMapUrl" style="width: 95%" value="<c:out value="${mapApi['naverUrl']}" />" /></td>
					    			<tr>
					    				<th style="width: 5%;">KEY</th>
					    				<td><input type="text" id="naverMapKey" name="naverMapKey" style="width: 95%" value="<c:out value="${mapApi['naverKey']}" />" /></td>
						    		</tr>
						    		
						    		<tr>
						    			<th rowspan="2" style="width: 20%;">구글(GOOGLE) API &nbsp;<a href="https://developers.google.com/maps/documentation/android/?hl=ko-KR" target="_blank" title="새창" /> api key 발급</a></th>
						    			<th style="width: 5%;">URL</th>
						    			<td><input type="text" id="googleMapUrl" name="googleMapUrl" style="width: 95%" value="<c:out value="${mapApi['googleUrl']}" />" /></td>
					    			<tr>
					    				<th style="width: 5%;">KEY</th>
					    				<td><input type="text" id="naverMapKey" name="naverMapKey" style="width: 95%" value="<c:out value="${mapApi['naverKey']}" />" /></td>
						    		</tr>
						    		--%>
						    		<tr>
						    			<th rowspan="5" style="width: 20%;">구글(google) SMTP &nbsp;</th>
						    			<th style="width: 10%;">PORT</th>
						    			<td><input type="text" id="gsmtpport" name="gsmtpport" style="width: 95%" readOnly="readOnly" value="587" /></td>
						    		</tr>
						    		<tr>
						    			<th style="width: 10%;">HOSTNAME</th>
						    			<td><input type="text" id="gsmtphost" name="gsmtphost" style="width: 95%" readOnly="readOnly" value="smtp.gmail.com" /></td>
						    		</tr>
					    			<tr>
					    				<th style="width: 10%;">NAME <a href="javascript:Jnit_api_question('2');"><i class="icon-question-sign"></i></a></th>
					    				<td><input type="text" id="gsmtpname" name="gsmtpname" style="width: 95%" value="<c:out value="${mapApi['gsmtpname']}" />" />
					    					<div id="JnitApiQuestion2" style="display: none;"><br />
							                	<strong>-메일 전송시 보낸 사람 이름으로 표시되어 보내집니다.</strong>
							                </div>
					    				</td>
						    		</tr>
						    		<tr>
					    				<th style="width: 10%;">USER ID</th>
					    				<td><input type="text" id="gsmtpuser" name="gsmtpuser" style="width: 95%" value="<c:out value="${mapApi['gsmtpuser']}" />" /></td>
						    		</tr>
						    		<tr>
					    				<th style="width: 10%;">PASSWORD</th>
					    				<td><input type="text" id="gsmtppass" name="gsmtppass" style="width: 95%" value="<c:out value="${mapApi['gsmtppass']}" />" /></td>
						    		</tr>
						    	</tbody>
						    </table>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="widget-box">
				<div class="widget-content nopadding cmstipbox" >
					<table class="table table-bordered table-striped th_left">
					<caption>cms TIP</caption>
					<tbody>
					<tr>
						<th colspan="2">
							<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
						</th>
						<td>
							<b>&lt;iframe src="/roadview/?addr=[주소]&roadView=false" /&gt;</b><br />
							<b>파라미터 roadView</b><br />
							<b>roadView=false - 지도 api만 보여줌</b><br />
							<b>roadView=true - 지도 api 하단에 로드뷰 포함해서 보여줌</b>
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>