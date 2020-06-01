<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>


<c:set var="registerFlag" value="${empty jnitcmssiteVO.siteId ? '등록' : '수정'}"/>	

<!--For Commons Validator Client Side-->
<!-- 
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="jnitcmssiteVO" staticJavascript="false" xhtml="true" cdata="false"/>
 -->
 
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmssiteVO").action = "<c:url value='/cms/sub3/0101.do'/>";
   	document.getElementById("jnitcmssiteVO").submit();		
}

<c:if test="${registerFlag == '수정'}">
/* 글 삭제 function */
function fn_egov_delete() {
	if(confirm('정말 삭제하시겠습니까?\n\n관련된 템플릿, 메뉴, 콘텐츠도 함께 삭제됩니다.') == true) {
		$.getJSON('<c:url value="/cms/setSessSiteId.do?siteId="/>', '', function(data, status) {
			//
		});
   		document.getElementById("jnitcmssiteVO").action = "<c:url value='/cms/sub3/0102del.do'/>";
   		document.getElementById("jnitcmssiteVO").submit();		
	}
}
</c:if>

/* 글 등록 function */
function fn_egov_save() {
	if($("#sitePath").val().length>2){
		$('.blackbackground').css("display","block");
		$('.blackbackground').focus();
		frm = document.getElementById("jnitcmssiteVO");

		/* TODO Validation기능 보완 */
		//if(!validateJnitcmssiteVO(frm)){
		//		return;
		//}
		
		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/sub3/0102up.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/sub3/0102add.do'/>";
		</c:if>
		
		$.getJSON('<c:url value="/cms/getSessSiteId.do?siteId="/>', '', function(data, status) {
			frm.submit();
		});
	}else{
		alert("사이트 경로를 두글자 이상 입력해주시기 바랍니다.");
	}
}

function fn_egov_reset(){
	$("#admMbrId").val('');
	$("#admMbrText").val('');
	alert('저장을 누르시면 초기화됩니다.');
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
	$('#admMbrText').click(function(e){
		e.preventDefault();		
		$("#mbrSearch").empty();
		$.ajax({
			type : "POST",
			url : "<c:url value='/cms/sub2/0101.do'/>?ajax=Y&contentEdit=site",
			data : ""
		}).done(function(data){		
			$("#mbrSearch").append(data);
			$('#myModal').modal('toggle');
		});			
	});
	<c:if test="${registerFlag == '수정'}">
		$("input[name=sitePath]").attr("readonly",true);	
	</c:if>
});

function Jnit_site_question(num){
	var baseId = "JnitSiteQuestion"+num;
	var baseObject = $("#"+baseId);
	var displayState = baseObject.css("display");
	
	if(displayState == "none"){
		baseObject.show();
	}else{
		baseObject.hide();
	}
}
// -->
</script>

<c:if test="${registerFlag == '수정'}">
	<c:set var="activeValue" value="${jnitcmssiteVO.active}"/>
	<input type="hidden" id="siteId" name="siteId" value="<c:out value='${jnitcmssiteVO.siteId}'/>" />
</c:if>
<div class="blackbackground" style="display: none; background: rgb(0, 0, 0); width: 100%; height: 100%; opacity: 0.5; z-index: 500; position: fixed; top: 0px; left: 0px;"></div>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>사이트 등록</h3>
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
						<c:if test="${registerFlag == '수정'}">
					    	<a href="javascript:fn_egov_delete();" class="btn btn-small btn-del" style="float:right;"><i class="icon-minus-sign"></i> 삭제</a>
					    </c:if>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitcmssiteVO">
							<form:hidden path="admMbrId" id="admMbrId" />
						    <table class="table table-bordered table-striped th_left" summary="사이트 등록">
						        <tbody>
						            <tr>
						                <th style="width: 85px;"><font color="red">*</font> 사이트명&nbsp;<a href="javascript:Jnit_site_question('1');"><i class="icon-question-sign"></i></a></th>
						                <td>
							                <form:input path="siteNm" cssClass="txt"/>
							                &nbsp;<form:errors path="siteNm" />
							                
							                <div id="JnitSiteQuestion1" style="display: none;">
												<strong>&nbsp;- 실제 관리형태의 명칭 뿐만 아니라 페이지 네비게이션 등 상단 상태바에 표시되는 공식 명칭입니다.</strong>
											</div>
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 경로&nbsp;<a href="javascript:Jnit_site_question('2');"><i class="icon-question-sign"></i></a></th>
						                <td>
							                <form:input path="sitePath" cssClass="txt"/>
							                &nbsp;<form:errors path="sitePath" />
							                <c:if test="${errormsg != null}">
							                <c:out value="${errormsg}" />
							                </c:if>
							                <span id="sitePathMsg"></span>
							                 
							                <div id="JnitSiteQuestion2" style="display: none;">
												<strong>&nbsp;- 실제로 최상위 폴더 명입니다. / 영문, 숫자로만 입력 가능합니다.</strong>
											</div>
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 공개&nbsp;<a href="javascript:Jnit_site_question('3');"><i class="icon-question-sign"></i></a></th>
						                <td>
							                <select name="active" id="active">
								                <option value="0" <c:out value='${activeValue == "0" ? "selected" : "" }'/>>아니오</option>
								                <option value="1" <c:out value='${activeValue == "1" || jnitcmssiteVO.siteId == null ? "selected" : "" }'/>>예</option>
							                </select>
							                 
							                <div id="JnitSiteQuestion3" style="display: none;">
												<strong>&nbsp;- 공개의 경우 관리자모드 좌측 상단에 표시 되며 비공개의 경우 표시되지 않습니다.</strong><br />
												<strong>&nbsp;- (비공개로 변경해도 사이트는 접속은 가능합니다. )</strong>
											</div>
						                </td>
						            </tr>
						
						            <tr>
						                <th> 표시순서&nbsp;</th>
						                <td>
						                <form:input path="siteOrd" maxlength="2" cssStyle="width:30px;" cssClass="txt"/>
						                &nbsp;<form:errors path="siteOrd" />
						                </td>            
						            </tr>
								    <tr>
								    	<th><font color="red"></font> <c:if test="${jnitcmsmenuVO.iscnt == 0}">콘텐츠 기본</c:if> 관리자 선택</th>
								        <td>
						                    <input type="text" name="admMbrText" id="admMbrText" value="${admMap['0'] }" style="width: 85%" readonly="readonly">&nbsp;&nbsp;&nbsp;<a href="javascript:fn_egov_reset();" class="btn btn-small">초기화</a>
								        </td>
								    </tr>
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

<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	</div>
	<div class="modal-body">
		<div id="mbrSearch"></div>
	</div>
</div>

<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
