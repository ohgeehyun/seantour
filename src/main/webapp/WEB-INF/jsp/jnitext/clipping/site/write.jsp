<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>


<c:set var="registerFlag" value="${empty result ? '등록' : '수정'}"/>			

<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.extends.js"/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
$(document).ready(function(){
	$("#clippingSiteSsl").change(function(){
		$("#clippingSitePort").val((this.value == '0')?'80':'443');
	});
	if($("#clippingSitePort").val() == "")$("#clippingSiteSsl").trigger("change");
	
	$('#fwrite').validate({
		rules: {
			clippingSiteName: "required"
			,clippingSiteSsl: "required"
			,clippingSiteUrl: "required"
			,clippingSiteIp: {"required":true,ipaddress:true}
			,clippingSitePort: {"required":true,number:true,range:[1,99999]}
			,clippingSiteUseip: "required"
			,clippingSiteTimeout: {"required":true,number:true,min:0}
		},
		errorClass: 'help-block',
		errorElement: 'span',
		highlight: function(element, errorClass, validClass) {
			$(element).removeClass('has-success').addClass('has-error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).removeClass('has-error').addClass('has-success');
		},
		submitHandler:function(form){
			form.submit();
		}
	});
});

/* 글 목록 화면 function */
function fn_egov_selectList() {
   	history.back();
}

function Jnit_delete(){
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			type:"post",
			url:"<c:url value='/cms/clipping/site/index.do'/>",
			data:{csMode:"deleteAction",clippingSiteId:$("#clippingSiteId").val()},
			dataType : "json"
		}).done(function(data){			
			if(data.isSuccess == true){
				alert("정상처리되었습니다");
				location.href= "<c:url value='?'/>";
			}else{
				alert("삭제에 실패하였습니다.");				
			}
		});
	}
}
/* 글 등록 function */
function fn_egov_save() {	
	$("#fwrite").submit();
}

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
                   		<h3>수집사이트 ${registerFlag }</h3>
						<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> ${registerFlag }</a>
						<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<c:if test="${!empty result }"><a href="javascript:Jnit_delete();" class="btn btn-small"><i class="icon-minus-sign"></i> 삭제</a></c:if>
                    </div>
					<div class="widget-content nopadding">
						<form id="fwrite" name="fwrite" method="post" action="<c:url value="/cms/clipping/site/index.do" />">
						<input type="hidden" id="retUrl" name="retUrl" value="" />
						<input type="hidden" id="csMode" name="csMode" value="writeAction" />
						<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value="${searchVO.pageIndex }"/>" />
						<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value="${searchVO.searchCondition }"/>" />
						<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword }"/>" />
						    <table class="table table-bordered table-striped th_left" summary="수집사이트 등록">
						        <tbody>
						            <tr>
						                <th width="30%">코드</th>
						                <td><input type="text" id="clippingSiteId" name="clippingSiteId" value="<c:out value='${result.clippingSiteId}'/>" readonly placeholder="자동입력됩니다."/></td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> 수집사이트명</th>
						                <td><input type="text" id="clippingSiteName" name="clippingSiteName" value="<c:out value='${result.clippingSiteName}'/>" placeholder="수집사이트명."/></td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> SSL여부</th>
						                <td>
						                <select id="clippingSiteSsl" name="clippingSiteSsl">
						                	<option value="0">N</option>
						                	<option value="1"${result.clippingSiteSsl?' selected':''}>Y</option>
						                </select>
						                </td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> 도메인</th>
						                <td><input type="text" id="clippingSiteUrl" name="clippingSiteUrl" value="<c:out value='${result.clippingSiteUrl}'/>" placeholder="포트를 제외한 도메인주소(www포함)를 입력해 주세요." style="width:98%"/></td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> IP</th>
						                <td><input type="text" id="clippingSiteIp" name="clippingSiteIp" value="<c:out value='${result.clippingSiteIp}'/>" placeholder="IP"/></td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> PORT</th>
						                <td><input type="text" id="clippingSitePort" name="clippingSitePort" value="<c:out value='${result.clippingSitePort}'/>" placeholder="PORT"/></td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> IP로 호출</th>
						                <td>
						                <select id="clippingSiteUseip" name="clippingSiteUseip">
						                	<option value="0">N</option>
						                	<option value="1"${result.clippingSiteUseip?' selected':''}>Y</option>
						                </select></td>
						            </tr>
						            <tr>
						                <th width="30%"><font color="red">*</font> 호출제한시간(mSec)</th>
						                <td><input type="text" id="clippingSiteTimeout" name="clippingSiteTimeout" value="<c:out value='${result.clippingSiteTimeout}'/>" placeholder="단위:millisecond"/></td>
						            </tr>
						    	</tbody>
						    </table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--콘텐츠끝-->
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<c:set var="noform" value="Y" />
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>