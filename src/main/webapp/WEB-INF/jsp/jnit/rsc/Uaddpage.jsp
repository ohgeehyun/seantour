<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/_common/header.jsp" %>
<%
	String localUri = request.getServletPath();
%>
<script type="text/javascript">
<!--
function fn_jnit_rsc_save() {

	if($('input[name=hit]:checked').size() < 1) {
		alert('평가점수를 선택하세요.');
		return false;
	}
	if($('#memo').val() == '') {
		alert('평가메시지를 작성하세요.');
		$('#memo').focus();
		return false;
	}
	$("#pageUrl").val($(document.location).attr('pathname'));
	var pageUrl = "${pagePath }";
	if(pageUrl != '') $("#pageUrl").val(pageUrl);
	$.ajax({
		url:"<c:url value='/user/rsc/addpage.do'/>",
		type:"post",
		data:{
			pageUrl:$('#pageUrl').val(),
			menuId:$('#menuId').val(),
			siteId:$('#siteId').val(),
			memo:$('#memo').val(),
			hit:$('input[name=hit]:checked').val()
		},
		success:function(data){
			if($.trim(data) == 'OK') {
				if(confirm('평가했습니다. 반영된 내용은 새로고침 하시면 적용됩니다. \n 새로고침 하시겠습니까?')){
					location.reload();
				}
			}else if($.trim(data) == 'FAIL1') {
				alert('이미 평가한 페이지입니다.');
			}
		}
	});

	return false;
}

// -->
</script>
<div id="contentment">
	<c:set var="sitePath" value="${fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,'')}"/>	      
    <c:forTokens var="token" items="${sitePath }" delims="/" varStatus="status">    		    	
    	<c:if test="${status.count == 1 }"><c:set var="getSite" value="${token }"/></c:if>
    </c:forTokens>
	<div class="research">
		<div class="researchCount">
			<p class="research_title">현재페이지에서 제공되는 <strong>서비스에 대하여 만족하십니까?</strong></p>
			<form onsubmit="return fn_jnit_rsc_save();" action="">
			<input type="hidden" id="siteId" name="siteId" value="<%=CmsServletPathProperty.getProp(localUri,"siteId") %>" /><%--cmsClientProperty.siteId--%>
			<input type="hidden" id="menuId" name="menuId" value="<%=CmsServletPathProperty.getProp(localUri,"menuId") %>" /><%--cmsClientProperty.menuId--%>
			<input type="hidden" id="pageUrl" name="pageUrl" />
				<ol>
					<li><input type="radio" name="hit" id="researchPoint05" value="5" title="매우만족" checked="checked" /><label for="researchPoint05">매우만족</label></li>
					<li><input type="radio" name="hit" id="researchPoint04" value="4" title="만족" /><label for="researchPoint04">만족</label></li>
					<li><input type="radio" name="hit" id="researchPoint03" value="3" title="보통" /><label for="researchPoint03">보통</label></li>
					<li><input type="radio" name="hit" id="researchPoint02" value="2" title="불만족" /><label for="researchPoint02">불만족</label></li>
					<li><input type="radio" name="hit" id="researchPoint01" value="1" title="매우불만족" /><label for="researchPoint01">매우불만족</label></li>
				</ol>
				<ul>
					<li><input type="text" name="memo" id="memo" title="네티즌 여러분의 소중한 의견 부탁 드리겠습니다." class=" researchTxt" /></li>
					<li><input type="image" src="${pageContext.request.contextPath }/resources/img/rsc/Jnit_btn_ok.gif" alt="등록" class="researchBtn" /></li>
				</ul>
			</form>
			
			<p class="resultBtn">
				<a href="#" onclick="window.open('<c:url value="/user/res/pagePopup.do?uri=${pagePath }"/>','upPage','width=714px,height=446px,scrollbars=yes,resizable=yes'); return false;" title="새창으로 열립니다.">
					<img src="${pageContext.request.contextPath }/resources/img/rsc/Jnit_btn_result.gif" alt="만족도결과보기" />
				</a>
			</p>
		</div>
	</div>
</div>