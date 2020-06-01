<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

/* 글 등록 function */
function fn_egov_save() {	
	alert('사이트 복사가 완료된 후 해당 모든 기본설정들은 복사된 사이트에 정보를 가지고 있습니다. 템플릿 및 콘텐츠 페이지를 재저장 하셔야만 정상적인 새로운 경로로 기본세팅이 완료됩니다.');
	frm = document.getElementById("jnitcmssiteVO");
	
		frm.action = "<c:url value='/cms/copySite/start.do'/>";

	$.getJSON('<c:url value="/cms/getSessSiteId.do?siteId="/>', '', function(data, status) {
		frm.submit();
	});
}

$(document).ready(function(){
	$.getJSON('<c:url value="/cms/getSessSiteId.do?siteId="/>', '', function(data, status) {});
	siteReloadStopMsg = "사이트관리 이용중에는 선택할 수 없습니다.";
	siteReloadStop = true;
	
	$('input#sitePath').alphanumeric();
	//$('input#sitePath').css('ime-mode', 'enabled');
	$('input#sitePath').live("blur keyup", function() {
	  if($(this).val().search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/) > -1) {
		$('input#sitePath').val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '') );
		$('span#sitePathMsg').html("사이트 경로는 영문/숫자만 입력가능합니다.").fadeIn('slow').fadeTo(3000,0);
	  	//$('span#sitePathMsg').html("사이트 경로는 영문/숫자만 입력가능합니다.");
	  }
	});
});

$(document).ready(function(){
	$('#mbrSearchBtn').click(function(e){
		e.preventDefault();
		if($("div#mbrSearch").css("display") == "none") {
			$("div#mbrSearch").show();
			$.ajax({
				  type: "GET",
				  url: "<c:url value='/cms/sub2/0101.do?ajax=Y'/>",
				  success:function(data) {
					$("div#mbrSearch").html(data);
				  },
				  error:function(result) {
					//alert(result);
				  }
			});
		}else {
			$("div#mbrSearch").hide();
		}
	});
});
// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>사이트 등록</h3>
						 <a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitcmssiteVO">
							<form:hidden path="admMbrId" />
						    <table class="table table-bordered table-striped th_left" summary="사이트 등록">
						        <tbody>
						        	
						            <tr>
						                <th width="30%"><font color="red">*</font>복사할 사이트</th>
						                <td>
						                	<select name="parentSiteId" id="parentSiteId" class="noSelect2">
						                	<option value="">사이트를 선택하세요</option>
						                	 <c:forEach var="result" items="${resultList}" varStatus="status">
						                     	<option value="<c:out value="${result.siteId}"/>"><c:out value="${result.siteNm}"/></option>
						                     </c:forEach>
						                     </select>
						                </td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> 사이트명</th>
						                <td>
						                <form:input path="siteNm" cssClass="txt"/>
						                &nbsp;<form:errors path="siteNm" />*복사한후, 복사한 사이트의 서브템플릿을 갱신 저장해주셔야 합니다.</td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> 경로</th>
						                <td>
						                <form:input path="sitePath" cssClass="txt"/>
						                &nbsp;<form:errors path="sitePath" />
						                <c:if test="${errormsg != null}">
						                <c:out value="${errormsg}" />
						                </c:if>
						                <span id="sitePathMsg"></span>
						                </td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> 공개</th>
						                <td>
						                <select name="active" id="active">
						                <option value="0" <c:out value='${activeValue == "0" ? "selected" : "" }'/>>아니오</option>
						                <option value="1" <c:out value='${activeValue == "1" || jnitcmssiteVO.siteId == null ? "selected" : "" }'/>>예</option>
						                </select></td>
						            </tr>
						
						            <tr>
						                <th width="30%"> 표시순서</th>
						                <td>
						                <form:input path="siteOrd" maxlength="2" cssStyle="width:30px;" cssClass="txt"/>
						                &nbsp;<form:errors path="siteOrd" />
						                </td>            
						            </tr>
						            
								    <%-- <tr> 2013-03-10 by.나성재 수정
								    	<th><font color="red">*</font> <c:if test="${jnitcmsmenuVO.iscnt == 0}">콘텐츠 기본</c:if> 관리자 선택</th>
								        <td>
								            <table border="0" cellspacing="0" cellpadding="0" class="content2_table" style="border:0;">
								                <tr>
								                    <td width="99%" style="border:0;"><span id="admMbrText" type="text" style="display:block; padding-left:1px; padding-top:2px; height:18px; border:1px #cccccc solid; width:100%;"><c:out value="${admMbrText}"/></span></td>
								                    <td width="1%" style="border:0;"><button class="btn btn-small" id="mbrSearchBtn"><i class="icon-search"></i></button></td>
								                </tr>
								            </table>
								        </td>
								    </tr> --%>
								    
						    	</tbody>
						    </table>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--콘텐츠끝-->

<div id="mbrSearch" style="width:400px; position:absolute; display:none; top:250px; right:40px; background-color:#ffffff;"></div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
