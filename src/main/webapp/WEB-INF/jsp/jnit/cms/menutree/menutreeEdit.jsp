<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/init.jsp" %>
<c:set var="registerFlag" value="${empty jnitcmsmenutreeVO.menuCodeId ? '등록' : '수정'}"/>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("detailForm").action = "<c:url value='/jnitcmsmenutree/List.do'/>";
   	document.getElementById("detailForm").submit();
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("detailForm").action = "<c:url value='/jnitcmsmenutree/delete.do'/>";
   	document.getElementById("detailForm").submit();
}

/* 글 등록 function */
function fn_egov_save() {
	frm = document.getElementById("detailForm");

	/* TODO Validation기능 보완 */
	if(chkSubmit()){
  		frm.action = "<c:url value="${registerFlag == '등록' ? '/jnitcmsmenutree/addproc.do' : '/jnitcmsmenutree/Editproc.do'}"/>";
    	frm.submit();
	}
	return false;
}

function chkSubmit(){
	if($('#menuName').val() == ''){
		alert('제목을 입력해 주세요.');
		$('#menuName').focus();
		return false;
	}
	if($('#menuIcon').val() == ''){
		alert('아이콘을 입력해 주세요.');
		$('#menuIcon').focus();
		return false;
	}

	return true;
}

$(document).ready(function(){
	<c:if test="${registerFlag == '등록'}">
		$("#menuActive[value='1']").attr("checked","checked");
	</c:if>

	var menuid = $("#menuId").val();

	var depth1sel = "";
	var depth2sel = "";
	var depth3sel = "";

	if(menuid != "" || menuid != null){
		depth1sel = menuid.substring(0,3) + "000000";
		depth2sel = menuid.substring(0,5) + "0000";
		depth3sel = menuid.substring(0,7) + "00";
	}

	var menuList;
	var setmenuSelect = function(menuId,level){
		$.ajax({
			type:"POST",
			url:"<c:url value='/cms/menutree/subset.do'/>",
			data:"menuId="+menuId
		}).done(function(data){
			menuList = jQuery.parseJSON(data);
			var addStr = "";
			var depth = "";
			if(level == "depth0"){
				depth="#depth1";
			}else if(level == "depth1"){
				depth="#depth2";
			}else if(level == "depth2"){
				depth="#depth3";
			}
			$(depth).empty();
			if(menuid != "" || menuid != null){
				$(depth).append("<option value='0'>선택</option>");
			}else if(menuid == "" || menuid == null){
				$(depth).append("<option value='0'>선택</option>");
			}
			menuList = menuList[0];
			var optionValue = "";
			var optionName = "";

			for(var i=0;i<menuList.length;i++){
				optionValue = menuList[i].menuId;
				optionName = menuList[i].menuName;
				if(menuid != "" || menuid != null){
					if(depth == "#depth1"){
						if(optionValue == depth1sel){
							$(depth).append("<option value='" + optionValue + "' selected=selected>" + optionName + "</option>");
						}else{
							$(depth).append("<option value='" + optionValue + "'>" + optionName + "</option>");
						}
					}else if(depth == "#depth2"){
						if(optionValue == depth2sel){
							$(depth).append("<option value='" + optionValue + "' selected=selected>" + optionName + "</option>");
						}else{
							$(depth).append("<option value='" + optionValue + "'>" + optionName + "</option>");
						}
					}else if(depth == "#depth3"){
						if(optionValue == depth3sel){
							$(depth).append("<option value='" + optionValue + "' selected=selected>" + optionName + "</option>");
						}else{
							$(depth).append("<option value='" + optionValue + "' disabled='disabled'>" + optionName + "</option>");
						}
					}

				}else if(menuid == "" || menuid == null){
					$(depth).append("<option value='" + optionValue + "'>" + optionName + "</option>");
				}
			}
			$(depth).append(addStr);
			$(depth).select2();

		});
	};

	setmenuSelect("","depth0");


	<c:if test="${registerFlag == '수정'}">
		if(menuid != depth1sel){
			$("#depth1").select2();
			setmenuSelect(depth1sel,"depth1");
		}else{
			$("#depth1").select2();
			setmenuSelect(depth1sel,"depth1");
		}

		if(menuid != depth2sel){
			$("#depth2").select2();
			setmenuSelect(depth2sel,"depth2");
		}else{
			$("#depth2").select2();
			setmenuSelect(depth2sel,"depth2");
		}

		if(menuid != depth3sel){
			$("#depth3").select2();
		}else{
			$("#depth3").select2();
		}
	</c:if>

	$("#depth1").change(function(e){
		var menuId = $(this).attr('value');
		var level = $(this).attr('id');

		$("#depth2").empty();
		$("#depth2").append("<option value='0'>선택</option>");
		$("#depth3").empty();
		$("#depth3").append("<option value='0'>선택</option>");

		if(menuId=="0"){
			return false;
		}else{
			setmenuSelect(menuId,level);
		}
	});
	$("#depth2").change(function(e){
		var menuId = $(this).attr('value');
		var level = $(this).attr('id');

		$("#depth3").empty();
		$("#depth3").append("<option value='0'>선택</option>");

		if(menuId=="0"){
			return false;
		}else{
			setmenuSelect(menuId,level);
		}
	});

	var iconclasses="cog,cogs,file,file-text-alt,copy,lock,user,hdd,time,signal,desktop,wrench,group,sitemap,apple,bar-chart,book,th-list,star,picture,comment,info-sign,ban-circle,warning-sign,eve-open";
	var iconsplit = iconclasses.split(',');

	var icons = new Array();

	for(var i=0; i<iconsplit.length;i++ ){
		icons.push({
			id: iconsplit[i],
			text:iconsplit[i]
		});
	}
	$("#menuIcon").select2({
		data:icons,
		escapeMarkup: function(markup){
			return markup;
		}
	});

	$("#menuIcon").change(function(){
		var icono = $(this).val();
		$("#iconview").html('<i class="icon icon-' + icono + '"></i>');
	});

	<c:if test="${registerFlag == '수정'}">
		var iconselect = "<c:out value='${jnitcmsmenutreeVO.menuIcon}'/>";
		$("#menuIcon > option[value="+iconselect+"]").attr("selected", "true");
		$("#menuIcon").select2();
		$("#iconview").html('<i class="icon icon-' + iconselect + '"></i>');
	</c:if>

});
// -->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="jnitcmsmenutreeVO" name="detailForm" id="detailForm" >
		<input type='hidden' name='menuCodeId' id='menuCodeId' value="${jnitcmsmenutreeVO.menuCodeId}" />
		<input type='hidden' name='menuId' id='menuId' value="${jnitcmsmenutreeVO.menuId}" />
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<h3>메뉴관리</h3>
						<a href="javascript:fn_egov_selectList();" class="btn"><i class="icon-repeat"></i> 되돌아가기</a>
						<a href="javascript:fn_egov_save();" class="btn"><i class="icon-ok-sign"></i> 저장</a>
						<c:if test="${registerFlag == '수정'}">
							<a href="javascript:fn_egov_delete();" class="btn btn-sel" style="float:right;"><i class="icon-ok-sign"></i> 삭제</a>
						</c:if>
					</div>
					<div class="widget-content nopadding">
						<table  class="table table-view">
							<tr>
								<th>MENU_ID</th>
								<td>
									<c:out value="${jnitcmsmenutreeVO.menuId }"/>
								</td>
							</tr>
							<tr>
			              		<th>1뎁스</th>
			              		<td colspan="3">
			              			<select id="depth1" name="depth1" style="width:200px;">
			              				<option value="0">선택</option>
			              			</select>
			              		</td>
			              	</tr>
			              	<tr>
			              		<th>2뎁스</th>
			              		<td colspan="3">
			              			<select id="depth2" name="depth2" style="width:200px;">
			              				<option value="0">선택</option>
			              			</select>
			              		</td>
			              	</tr>
			              	<tr>
			              		<th>3뎁스</th>
			              		<td colspan="3">
			              			<select id="depth3" name="depth3" style="width:200px;">
			              				<option value="0">선택</option>
			              			</select>
			              		</td>
			              	</tr>
							<tr>
								<th>메뉴명</th>
								<td>
									<input type="text" id="menuName" name="menuName" value="<c:out value="${jnitcmsmenutreeVO.menuName }"/>">
								</td>
							</tr>
							<tr>
								<th>메뉴링크</th>
								<td>
									<input type="text" id="menuLink" name="menuLink" style="width:98%;" value="<c:out value="${jnitcmsmenutreeVO.menuLink }"/>">
								</td>
							</tr>
							<tr>
								<th>메뉴아이콘</th>
								<td>
									<select id="menuIcon" name="menuIcon" style="width:200px;">
			              			</select>
			              			<span id="iconview" style="font-size: 20px;"></span>
								</td>
							</tr>
							<tr>
								<th>활성화여부</th>
								<td>
									<input type="radio" name="menuActive" id="menuActive" value="0" <c:out value="${(jnitcmsmenutreeVO.menuActive == 0) ? 'checked=\"checked\"' : ''}"/> />비활성화
									<input type="radio" name="menuActive" id="menuActive" value="1" <c:out value="${(jnitcmsmenutreeVO.menuActive == 1) ? 'checked=\"checked\"' : ''}"/> />활성화
									&nbsp;<span style="color: red;">※메뉴를 비활성화 시킬시 모든 회원 유형에서 해당 메뉴 및 하위 뎁스의 메뉴까지 탑 혹은 레프트 메뉴에서 보이지 않게 됩니다.</span>
								</td>
							</tr>
						</table>
				  </div>
				</div>
			</div>
		</div>
		<!-- 검색조건 유지 -->
		<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
		<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>