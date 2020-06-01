<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<cfheader name="X-XSS-Protection" value="0">
<script type="text/javascript">
<!--

//탑메뉴 null 체크
function Jnit_topMenuAdd_bln(){
	var target = $("#target_modal").val();
	var depth = $("#depth_modal").val();
	
	if(target == ''){
		alert("유형명을 입력해주세요.");
		$("#target_modal").focus();
		return false;
	}else if(depth == ''){
		alert("뎁스를 입력해주세요.");
		$("#depth_modal").focus();
		return false;
	}
	return true;
}

//탑메뉴 추가
function Jnit_topMenuAddProc(){
	if(Jnit_topMenuAdd_bln()){
		frm = document.getElementById("topMenuForm");
		frm.submit();
	}
}

//allim type 설정
function allimBindType(){
	var bindType = $("#bindType").val();
	
	if(bindType == 'allimView'){
		bindType = 'allim';
	}else if(bindType == 'PopupView'){
		bindType = 'popup';
	}else if(bindType == 'bannerRolling' || bindType == 'bannerMore'){
		bindType = 'banner';
	}
	return bindType;
}

//알리미 추가 modal
function Jnit_skinAdd(){
	var skinNm = $("#skinNm option:selected").val();
	var type = allimBindType();
	var confirmSkinNm;
	if(skinNm == 'allimView' || skinNm == 'bannerRolling' || skinNm == 'PopupView') confirmSkinNm = '기본';
	else confirmSkinNm = skinNm;
	
	if(confirm(confirmSkinNm+" 유형으로 스킨을 추가 하시겠습니까?")){
		
		var headHtml = "<font color='red'>스킨추가 "+(type == 'banner' ? '(배너 더보기에서 생성될시 배너도 같이 생성이 됩니다.)' : '')+"</font>";
		var bodyHtml = "스킨 이름 : <input type='text' id='addSkinNm' name='addSkinNm' />  선택하신 유형 : "+skinNm
						+"<input type='hidden' id='type' name='type' value='"+type+"' />"
						+"<input type='hidden' id='skinType' name='skinType' value='"+skinNm+"' />";
		var footerHtml = "<a href='javascript:Jnit_skinAddProc();' class='btn btn-warning btn-small'>추가</a>";
		
		$(".modal-header").empty();
		$(".modal-header").append(headHtml);
		
		$(".modal-body").empty();
		$(".modal-body").append(bodyHtml);
		
		$("#addBtn").empty();
		$("#addBtn").append(footerHtml);
		
		$('#modal').modal('toggle');
	}
}

//알리미 null 체크
function Jnit_allimSkinAddProc_bln(){
	var skinNm = $("#addSkinNm").val();	
	if(skinNm == '' || skinNm == null){
		alert("스킨이름을 써주시기 바랍니다.");
		$("#addSkinNm").focus();
		return false;
	}else if(skinNm.match("[^ㄱ-ㅎ가-힣]+$") == null){
		alert("한글 파일명은 쓸 수 없습니다.");
		$("#addSkinNm").focus();
		return false;
	}
	return true;
}

//알리미 추가
function Jnit_skinAddProc(){
	var skinNm = $("#addSkinNm").val();
	var bindType = $("#bindType").val(); 
	var type = allimBindType();
	
	if(Jnit_allimSkinAddProc_bln()){
		if(skinNm != ''){
			var skinType = $("#skinType").val();
			$.ajax({
				type:"post",
				url: "<c:url value='/cms/allim/ajax/skin.do'/>",
				data:"skinNm="+skinNm+"&skinType="+skinType+"&type="+type
			}).done(function(data){
				var json = $.parseJSON(data);
				if(json.status == 'success'){
					alert("정상처리되었습니다.");
					$('#modal').modal('toggle');
					if(bindType == 'bannerMore'){
						skinNm = skinNm + "_bannerMore";
					}
					location.href = "${pageContext.request.contextPath}/cms/page/view.do?bindType="+bindType+"&skinNm="+skinNm;
				}else{
					if(json.code != ''){
						if(json.code == 'FAIL 1') alert("같은 파일 이름이 있습니다.");
						if(json.code == 'FAIL 2') alert("파일을 추가 하지 못했습니다.");
						$("#addSkinNm").focus();
					}
				}
			});
		}
	}
}

$(document).ready(function(){
	var message = $("#tplSrc").val();
	var comm = "";
	var res = "";
	var skinNm = "${skinNm}";	
	if(skinNm != '') $("#skinNm").val(skinNm);
	
	comm = /<!(.*?)>/g;
		res = message.replace(comm, '');
	comm = /<\!--(.*?)--\>/g;
		res = message.replace(comm, '');
	comm = /<\%(([^>]{1})(.*?))*?%\>/g;
		res = res.replace(comm, '');
	comm = /<link(.*?)\>/g;
		res = res.replace(comm, '');
	comm = /<meta(.*?)\>/g;
		res = res.replace(comm, '');
	comm = /<script(([^>]{1})(.*?))*?\/script>/g;
		res = res.replace(comm, '');
		

	$("#htmlView").empty();
	$("#htmlView").html(res);
	
	<c:if test="${codeMode == 'top_code'}">
		var target = "${result['target']}";
		var depth = "${result['depth']}";
		
		if(target != ''){
			$("select[name='target']").attr("value", target);
		}else{
			$("select[name='target']").attr("value", " ");	
		}
		
		if(depth != ''){
			$("select[name='depth']").attr("value", depth);
		}else{
			$("select[name='depth']").attr("value", " ");
		}
	</c:if>
	
	$("#upView").click(function(e){
		e.preventDefault();
		
		var px = "";
		var length = "";
		var str = "";
		var sumVal = "";
		
		if($(".CodeMirror").css("height") != null || $(".CodeMirror").css("height") == ''){
			px = $(".CodeMirror").css("height");
			length = px.length-2;
			str = px.substring(0, length);
			sumVal = Number(str) + Number(50);
			$(".CodeMirror").css("height",sumVal);
			$(".CodeMirror-scroll").css("height",sumVal);
		}
		
		px = $("#tplSrc").css("height");
		length = px.length-2;
		str = px.substring(0, length);
		sumVal = Number(str) + Number(50);
		$("#tplSrc").css("height",sumVal);
	});
	
	
	
	$("#downView").click(function(e){
		e.preventDefault();
		
		var px = "";
		var length = "";
		var str = "";
		var sumVal = "";
		
		if($(".CodeMirror").css("height") != null || $(".CodeMirror").css("height") == ''){
			px = $(".CodeMirror").css("height");
			length = px.length-2;
			str = px.substring(0, length);
			sumVal = Number(str) - Number(50);
			$(".CodeMirror").css("height",sumVal);
			$(".CodeMirror-scroll").css("height",sumVal);
		}
		
		px = $("#tplSrc").css("height");
		length = px.length-2;
		str = px.substring(0, length);
		sumVal = Number(str) - Number(50);
		$("#tplSrc").css("height",sumVal);
	});
	
	
	
	$("#upHtml").click(function(e){
		e.preventDefault();
		
		var px = $("#htmlView").css("height");
		var length = px.length-2;
		var str = px.substring(0, length);
		var sumVal = Number(str) + Number(50);
		$("#htmlView").css("height",sumVal);
	});
	
	
	
	$("#downHtml").click(function(e){
		e.preventDefault();
		
		var px = $("#htmlView").css("height");
		var length = px.length-2;
		var str = px.substring(0, length);
		var sumVal = Number(str) - Number(50);
		$("#htmlView").css("height",sumVal);
	});
	
	
	
	$("#tplSrc").keyup(function(){
		
		var message = $("#tplSrc").val();
		var comm = "";
		var res = "";
		
		comm = /<!(.*?)>/g;
			res = message.replace(comm, '');
		comm = /<\%(([^>]{1})(.*?))*?%\>/g;
			res = res.replace(comm, '');
		comm = /<link(.*?)\>/g;
			res = res.replace(comm, '');
		comm = /<meta(.*?)\>/g;
			res = res.replace(comm, '');
		comm = /<script(([^z]{1})(.*?))*?\/script>/g;
			res = res.replace(comm, '');
			

		$("#htmlView").empty();
		$("#htmlView").html(res);
	});
	
	$("#target").on("change", function(){
		
		
		var target = $("#target").val();
		
		$.ajax({
			url:"<c:url value="/menu/topmenuJson.do"/>",
			data:{
				target:target
			},
			success:function(data){
				var result = $.parseJSON(data);				
				$("#depth").empty();
				$("#depth").select2();
				for(var i=0; i<result.length; i++){
					var thisVal = result[i];
					$("#depth").append("<option value='"+thisVal+"'>"+thisVal+"</option");
				}
				
				var selVal = $("#depth option").eq(0).val();
				$("#depth").val(selVal);
				$("#depth").select2();
				
				$("form[id='jnitcmstplVO']").attr("action", "<c:url value="/cms/page/view.do"/>");
				$("form[id='jnitcmstplVO']").submit();
				
			},
			error:function(){
				alert("잠시후 다시 시도해주세요.");
				window.location.href="#";
			}
		});
	});
	
	$("#depth").on("change", function(){
		
		$("form[id='jnitcmstplVO']").attr("action", "<c:url value="/cms/page/view.do"/>");
		$("form[id='jnitcmstplVO']").submit();
		
	});
	
	$("#skinNm").change(function(){
		if($(this).val() != ''){
			document.getElementById("jnitcmstplVO").action = "<c:url value='/cms/page/view.do'/>";
			document.getElementById("jnitcmstplVO").submit();
		}
	});
	
	$("#topAdd").on("click", function(e){
		e.preventDefault();
		
		var headHtml = "<font color='red'>탑메뉴 추가</font>";
		var bodyHtml = ""
						+"<form id='topMenuForm' name='topMenuForm' action='<c:url value="/cms/topMenu/add.do"/>' method='post'>"
							+"<input type='text' id='target_modal' name='target' placeholder='유형 명' /><br />"
							+"<input type='text' id='depth_modal' name='depth' placeholder='뎁스 ex) 1부터 5까지' />"		
						+"</form>";
		var footerHtml = "<a href='javascript:Jnit_topMenuAddProc();' class='btn btn-warning btn-small'>추가</button>";
		
		$("#modal .modal-header").empty();
		$("#modal .modal-header").append(headHtml);
		
		$("#modal .modal-body").empty();
		$("#modal .modal-body").append(bodyHtml);
		
		$("#addBtn").empty();
		$("#addBtn").append(footerHtml);
		
		$("#modal").modal("show");
	});
});
<%--
function fn_save_backup() {
	 if(confirm("백업데이터로 저장 하시겠습니까?(현재 데이터가 정상적으로 작동하는지 확인하여 주십시오)")) {
	   	document.getElementById("jnitcmstplVO").action = "<c:url value='/cms/page/save/backup.do'/>";
	   	document.getElementById("jnitcmstplVO").submit();
	 }
}

function fn_load_backup(){
	if(confirm("백업데이터를 불러 오시겠습니까?()")) {
		document.getElementById("jnitcmstplVO").action = "<c:url value='/cms/page/load/backup.do'/>";
   		document.getElementById("jnitcmstplVO").submit();
	}
}

--%>
function Jnit_skinDelete() {
	 if(confirm("삭제하시겠습니까?(삭제시 복구되지 않습니다.)")) {
	   	document.getElementById("jnitcmstplVO").action = "<c:url value='/cms/page/delete.do'/>";
	   	document.getElementById("jnitcmstplVO").submit();
	 }
}
//-->
</script>


<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
		<div class="content_skeleton container-fluid">
		<%-- Contents Start --%>
			<div class="row-fluid">
				<div class="span12">
					<div class="widget-box">
						<form:form commandName="jnitcmstplVO" action="${ctxRoot}/cms/page/save.do">
						<input type="hidden" name="fileSave" value="fileSave" />						
						<div class="widget-title">
							<span class="icon"><i class="icon-cog"></i></span>
							<button type="submit" class="btn btn-small"><i class="icon icon-ok"></i> 저장</button>
							<c:if test="${codeMode == 'top_code'}">
								<button id="topAdd" class="btn btn-small"><i class="icon icon-plus"></i> 탑메뉴 추가</button>
							</c:if>
							<c:if test="${allimSkin == 'Y' }">
								<a href="javascript:Jnit_skinAdd();" class="btn btn-small"><i class="icon icon-plus"></i> 스킨 추가</a>
							</c:if>
							<c:if test="${param.bindType == 'bannerRolling' || param.bindType == 'bannerMore' || param.bindType == 'allimView' || param.bindType == 'PopupView' || param.bindType == 'topMenu' || param.bindType == 'sitemap' }">
								<a href="javascript:Jnit_skinDelete();" class="btn btn-small btn-del" style="float:right;"><i class="icon icon-minus-sign"></i> 삭제</a>
							</c:if>
						</div>		
						<c:if test="${codeMode == 'top_code'}">
							<div class="widget-title">					
								<span>탑메뉴 유형 : </span><select id="target" name="target">
									<c:forEach var="result" items="${result['targetList']}" varStatus="status">
										<option value="${result}">${result}</option>
									</c:forEach>
								</select>
								
								<span style="margin-left: 10px;">탑메뉴 뎁스 : </span><select id="depth" name="depth">
									<c:forEach var="result" items="${result['depthList']}" varStatus="status">
										<option value="${result}">${result}</option>
									</c:forEach>
								</select>
							</div>
						</c:if>
						<c:if test="${allimSkin == 'Y' }">
							<div class="widget-title">		
								스킨 디자인 선택 : <select id="skinNm" name="skinNm">
								<c:forEach var="skinList" items="${skinList }" varStatus="status">
									<option value="${skinList }" <c:out value="${skinList == 'allimView' || skinList == 'bannerRolling' || skinList == 'bannerMore' ? 'selected' : skinList }"/>>
										<c:out value="${skinList == 'allimView' || skinList == 'bannerRolling' || skinList == 'bannerMore' ? '기본' : skinList }"/>
									</option>
								</c:forEach>
								</select>		
							<%-- <button onClick="javascript:fn_save_backup(); return false;" class="btn btn-small"><i class="icon icon-ok"></i> 백업데이터로 저장</button>
							<button onClick="javascript:fn_load_backup(); return false;" class="btn btn-small"><i class="icon icon-ok"></i> 백업데이터 불러오기</button> --%>
							</div>
						</c:if>
						<div class="widget-content nopadding">
							<table class="table table-bordered table-striped th_left" summary="파일설정">
								<tbody>
									<tr>
										<th>파일크기</th>
										<td><span class="filesize"><fmt:formatNumber maxFractionDigits="1" minFractionDigits="1" value="${file.size}" />k</span></td>
										<th>수정일시</th>
										<td><span class="filedate"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${file.date}" /></span></td>
									</tr>
								</tbody>
							</table>
							<input type="hidden" name="screenMode" value="" />
							<input type="hidden" name="siteId" value="" />
							<input type="hidden" name="tplId" value="" />
							<input type="hidden" name="sitePath" value="<c:out value="${sitePath}" />" />
							<input type="hidden" name="searchKeyword" value="<c:out value="${param.bindType}" />,<c:out value="${param.dirType}" />,<c:out value="${param.fileName}" />" />	
							<input type="hidden" id="bindType" name="bindType" value="<c:out value="${bindType}" />" />
							<div class="tplSrcBox" style="padding-top:10px;padding-left:10px;">
								<p><b>ㆍ 소스 편집</b>&nbsp;<button id="upView" class="btn btn-small">▼</button> <button id="downView" class="btn btn-small">▲</button></p>
								<form:textarea path="tplSrc" rows="20" style="width:95%" escape="false"/><br />
								<form:errors path="tplSrc" />
							</div>
						</div>
						</form:form>						
					</div>
				</div>
			</div>
		<%-- Contents End --%>
		<%-- 디자인관리 > 레프트메뉴, 탑메뉴, 콘텐츠담당자, 콘텐츠수정버튼만 하단 TIP --%>
			<c:if test="${codeMode == 'sub_code' || codeMode == 'top_code' || codeMode == 'contentAdmin' || codeMode == 'updateButton' || codeMode == 'bannerMore' || codeMode == 'sitemap'}">
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
								<c:if test="${codeMode == 'sub_code'}">		<%-- 레프트 메뉴 --%>
									<b>레프트 메뉴 코드 &lt;jsp:include page="/cms/import/getSubMenu.jsp"&gt;&lt;/jsp:include&gt;</b><br />
									<b>메뉴/콘텐츠 관리에서 만든 메뉴 순서대로 나타내 보여집니다. </b><br />
									<b>메뉴 노출/비 노출 설정은 콘텐츠 관리자 &gt; 메뉴/콘텐츠에서 설정할 수 있습니다</b>
								</c:if>
								<c:if test="${codeMode == 'top_code'}">		<%-- 탑 메뉴 --%>
									<b>사용방법</b><br />
									<b>탑메뉴 코드</b><br />
									<b>        &lt;c:import url="/menu/getTopMenu.do"&gt;</b><br />
									<b>                &lt;c:param name="target" value="[탑메뉴 target명]" /&gt;</b><br />
									<b>                &lt;c:param name="menuNm" value="[메뉴명]" /&gt;</b><br />
									<b>                &lt;c:param name="depth" value="[뎁스]" /&gt;</b><br />
									<b>                &lt;c:param name="order" value="[class순서 ex:0]" /&gt;</b><br />
									<b>                &lt;c:param name="menuId" value="[메뉴아이디,메뉴명이 겹칠경우 사용]" /&gt;</b><br />
									<b>        &lt;/c:import&gt;</b><br />
									<b>해당코드를 탑메뉴가 들어가는 html 코드에 올려주시면 됩니다.</b><br />
									<b>1뎁스 메뉴명을 입력해주셔야합니다.</b><br />
									<b>해당 메뉴의 메뉴/콘텐츠를 클릭시 노출/비노출 여부를 체크하실 수 있습니다.</b><br />
									<b>메뉴/콘텐츠를 드래그 하여 순서를 바꾸거나 이름을 수정 등 메뉴가 변경되는 사항이 있을땐</b><br />
									<b>메뉴 관리 상단의 빌드 버튼을 눌러주셔야 적용됩니다.</b>
								</c:if>
								<c:if test="${codeMode == 'contentAdmin'}">		<%-- 콘텐츠담당자 --%>
									<b>콘텐츠 담당자 코드</b>
									<b>&lt;jsp:include page="/cms/import/사이트경로_content_admin.jsp"&gt;&lt;/jsp:include&gt;</b><br />
									<b>위 코드를 서브템플릿에 추가해 사용 하실수 있습니다.</b><br />
									<b>메뉴/콘텐츠 관리에서 해당 콘텐츠의 담당자를 최대 2명까지 지정 할 수 있습니다.</b>
								</c:if>
								<c:if test="${codeMode == 'updateButton'}">		<%-- 콘텐츠수정버튼 --%>
									<b>콘텐츠 수정 버튼 코드</b><br />
									<b>&lt;jsp:include page="/cms/import/{-SITEPATH-}_updateButton.jsp"&gt;&lt;/jsp:include&gt;</b><br />
									<b>위 코드를 서브템플릿에 추가해 사용 하실수 있습니다.</b><br />
									<b>로그인템플릿, 회원템플릿 관련 페이지에는 표출되지 않습니다.</b>
								</c:if>
								<c:if test="${codeMode == 'bannerMore'}">		<%-- 콘텐츠수정버튼 --%>
									<b>배너로 등록한 아이템을 리스트로 뿌려 보여지는 페이지입니다.</b>
								</c:if>
								<c:if test="${codeMode == 'sitemap'}">		<%-- 콘텐츠수정버튼 --%>
									<b>삭제버튼 콘텐츠 관리의 메뉴명에 근거하며 사이트맵을 만들어줍니다.</b><br />
									<b>사이트맵에 나타나는 메뉴의 노출/비노출은 해당 메뉴/콘텐츠 상세정보에 들어가셔서 설정하실 수 있습니다.</b><br />
									<b>사이트맵 코드</b><br />
									<b>&lt;c:import url='/menu/getSiteMap.do'&gt;</b><br />
									<b>&lt;c:param name='siteNm' value='사이트 명칭'&gt;&lt;/c:param&gt;</b><br />
									<b>&lt;c:param name='titles' value='대메뉴(1뎁스) 메뉴명을 콤마(,)로 구분하여 입력 해주시기 바랍니다.'&gt;&lt;/c:param&gt;</b><br />
									<b>&lt;/c:import&gt;</b>
								</c:if>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
			</c:if>
		</div>
	<%-- 디자인관리 > 레프트메뉴, 탑메뉴 제외 --%>
	<c:if test="${codeMode != 'sub_code' && codeMode != 'top_code' && codeMode != '' && codeMode != null}" >	
	<table class="table table-bordered table-striped th_left">
		<tr>
			<th>치환코드</th><th>내용</th><th>설명</th>
		</tr>
		<c:if test="${codeMode == 'bannerRoll'}">
		<tr><td>{bannerRollingUrl_1}</td><td>배너롤링.js를 선언</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_1}</td><td>&#36;{Direction}</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_2}</td><td>&#36;{ShowItems}</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_3}</td><td>&#36;{TimerDelay}</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_4}</td><td>&#36;{AnimationDelay}</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_5}</td><td>&#36;{Auto}</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_6}</td><td>&#36;{ImgWidth}</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_7}</td><td>&#36;{ImgHeight}</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_8}</td><td>&#36;{bannerMorePath }</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_9}</td><td>&lt;c:out value="&#36;{bannerMorePath }?jnitallim/bannerMore.do?groupId=&#36;{groupId }" /></td><td></td></tr>
    	<tr><td>{bannerRollingFunction_10}</td><td>&#36;{resultList.itemLink }</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_11}</td><td>&#36;{resultList.itemTarget }</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_12}</td><td>&lt;c:out value='&#36;{pageContext.request.contextPath }' />&#36;{resultList.itemUrl }</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_13}</td><td>&#36;{resultList.itemAlt}</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_14}</td><td>&#36;{resultList.groupWidth }</td><td></td></tr>
    	<tr><td>{bannerRollingFunction_15}</td><td>&#36;{resultList.groupHeight }</td><td></td></tr>
    	<tr><td>{bannerRollingForeach_1}</td><td>&lt;c:forEach var="resultList" items="&#36;{groupList}" varStatus="status" end="22"></td><td></td></tr>
    	<tr><td>{bannerRollingForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	</c:if>
    	<%-- c:if test="${codeMode == 'bannerMore'}">
    	<tr><td>{bannerMoreFunction_1}</td><td>&lt;c:url value="&#36;{moreList.itemUrl }" /></td><td></td></tr>
    	<tr><td>{bannerMoreFunction_2}</td><td>&lt;c:out value="&#36;{moreList.itemAlt }" /></td><td></td></tr>
    	<tr><td>{bannerMoreFunction_3}</td><td>&lt;c:out value="&#36;{moreList.itemAlt }"/></td><td></td></tr>
    	<tr><td>{bannerMoreFunction_4}</td><td>&lt;c:out value="&#36;{moreList.itemLink }" /></td><td></td></tr>
    	<tr><td>{bannerMoreFunction_5}</td><td>&lt;c:out value="&#36;{fn:substring(moreList.itemLink,0,40) }" escapeXml="false" /></td><td></td></tr>
    	<tr><td>{bannerMoreFunction_6}</td><td>&lt;c:out value="&#36;{fn:length(moreList.itemLink) > 41 ? '...' : '' }" /></td><td></td></tr>
    	<tr><td>{bannerMorePagination}</td><td>&lt;ui:pagination paginationInfo = "&#36;{paginationInfo}" type="jnitDefault" jsFunction="fn_egov_link_page" /> &lt;form:hidden path="pageIndex" /></td><td></td></tr>
    	<tr><td>{bannerMoreForeach_1}</td><td>&lt;c:forEach var="moreList" items="&#36;{moreList }" varStatus="status"></td><td></td></tr>
    	<tr><td>{bannerMoreForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	</c:if --%>
    	<c:if test="${codeMode == 'AllimView'}">
    	<tr><td>{allimFunction_1}</td><td>&#36;{grpResultSize}</td><td></td></tr>
    	<tr><td>{allimFunction_2}</td><td>&#36;{grpValue.groupChangeTime}</td><td></td></tr>
    	<tr><td>{allimFunction_3}</td><td>&#36;{grpValue.groupClassName}</td><td></td></tr>
    	<tr><td>{allimFunction_4}</td><td>&#36;{status.count}</td><td></td></tr>
    	<tr><td>{allimFunction_5}</td><td>&#36;{allim.itemLink}</td><td></td></tr>
    	<tr><td>{allimFunction_6}</td><td>&#36;{allim.itemTarget}</td><td></td></tr>
    	<tr><td>{allimFunction_7}</td><td>&lt;c:out value="&#36;{allim.itemUrl}" /></td><td></td></tr>
    	<tr><td>{allimFunction_8}</td><td>&#36;{allim.itemAlt}</td><td></td></tr>
    	<tr><td>{allimFunction_9}</td><td>&#36;{allim.groupWidth}</td><td></td></tr>
    	<tr><td>{allimFunction_10}</td><td>&#36;{allim.groupHeight}</td><td></td></tr>
    	<tr><td>{allimCif_1}</td><td>&lt;c:if test="&#36;{allim.itemTarget == '_blank'}"></td><td></td></tr>
    	<tr><td>{allimCif_2}</td><td>&lt;c:if test="&#36;{allim.itemTarget != '_blank'}"></td><td></td></tr>
    	<tr><td>{allimCifend}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{allimForeach_1}</td><td>&lt;c:forEach var="allim" items="&#36;{grpResult}" varStatus="status"></td><td></td></tr>
    	<tr><td>{allimForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'PopupView'}">
    	<tr><td>{bannerFunction_1}</td><td>&#36;{popup.itemExt01}</td><td></td></tr>
    	<tr><td>{bannerFunction_2}</td><td>&#36;{popup.itemWidth}</td><td></td></tr>
    	<tr><td>{bannerFunction_3}</td><td>&#36;{popup.itemHeight}</td><td></td></tr>
    	<tr><td>{bannerFunction_4}</td><td>&#36;{popup.itemTop}</td><td></td></tr>
    	<tr><td>{bannerFunction_5}</td><td>&#36;{popup.itemRight}</td><td></td></tr>
    	<tr><td>{bannerFunction_6}</td><td>&#36;{popup.itemExt02}</td><td></td></tr>
    	<tr><td>{bannerFunction_7}</td><td>&#36;{popup.itemMode}</td><td></td></tr>
    	<tr><td>{bannerFunction_8}</td><td>&#36;{popup.itemUrl}</td><td></td></tr>
    	<tr><td>{bannerFunction_9}</td><td>&#36;{popup.itemId}</td><td></td></tr>
    	<tr><td>{bannerFunction_10}</td><td>&#36;{popup.itemHtmlcode}</td><td></td></tr>
    	<tr><td>{bannerForeach_1}</td><td>&lt;c:forEach var="popup" items="&#36;{grpResult}" varStatus="status"></td><td></td></tr>
    	<tr><td>{bannerForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'cultEnvirons'}">
    	<tr><td>{cultFunction_1}</td><td>&#36;{cultInfoSize<0 ? '0' : cultInfoSize }</td><td></td></tr>
    	<tr><td>{cultFunction_2}</td><td>&lt;c:set var="cultInfoId" value="&#36;{cultInfoList.cultId }" /></td><td></td></tr>
    	<tr><td>{cultFunction_3}</td><td>&lt;c:set var="cultInfoTypeId" value="&#36;{cultInfoList.typeId }"/></td><td></td></tr>
    	<tr><td>{cultFunction_4}</td><td>&lt;c:set var="cultInfoNm" value="&#36;{cultInfoList.cultNm }"/></td><td></td></tr>
    	<tr><td>{cultFunction_5}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" /></td><td></td></tr>
    	<tr><td>{cultFunction_6}</td><td>&#36;{cultInfoList.fileUrl}</td><td></td></tr>
    	<tr><td>{cultFunction_7}</td><td>&lt;c:out value="&#36;{viewPath }" />&lt;c:out value="?mode=&#36;{mode }&cultId=&#36;{cultInfoId}&typeId=&#36;{cultInfoTypeId}" /></td><td></td></tr>
    	<tr><td>{cultFunction_8}</td><td>&#36;{cultInfoList.cultNm }</td><td></td></tr>
    	<tr><td>{cultFunction_9}</td><td>&#36;{status.count}</td><td></td></tr>
    	<tr><td>{cultFunction_10}</td><td>&#36;{cultInfoList.newAddr }</td><td></td></tr>
    	<tr><td>{cultFunction_11}</td><td>&#36;{cultInfoList.phone }</td><td></td></tr>
    	<tr><td>{cultFunction_12}</td><td>&#36;{lat}</td><td></td></tr>
    	<tr><td>{cultFunction_13}</td><td>&#36;{lng}</td><td></td></tr>
    	<tr><td>{cultFunction_14}</td><td>&#36;{cultInfoList.gridX}</td><td></td></tr>
    	<tr><td>{cultFunction_15}</td><td>&#36;{cultInfoList.gridY}</td><td></td></tr>
    	<tr><td>{cultCif_1}</td><td>&lt;c:if test='&#36;{fn:length(cultInfoList) <= 1 }'></td><td></td></tr>
    	<tr><td>{cultCif_2}</td><td>&lt;c:if test='&#36;{fn:length(cultInfoList) != 1 }'></td><td></td></tr>
    	<tr><td>{cultCif_end}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{cultForeach_1}</td><td>&lt;c:forEach var="cultInfoList" items="&#36;{cultInfoList }" begin="1" varStatus="status"></td><td></td></tr>
    	<tr><td>{cultForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	<tr><td>{cultPagenavi}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{paginationInfo}" type="jnitDefault" jsFunction="fn_egov_cultInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'foodEnvirons'}">
    	<tr><td>{foodFunction_1}</td><td>&#36;{foodInfoSize<0 ? '0' : foodInfoSize  }</td><td></td></tr>
    	<tr><td>{foodFunction_2}</td><td>&lt;c:set var="foodInfoId" value="&#36;{foodInfoList.cultId }" /></td><td></td></tr>
    	<tr><td>{foodFunction_3}</td><td>&lt;c:set var="foodInfoTypeId" value="&#36;{foodInfoList.typeId }"/></td><td></td></tr>
    	<tr><td>{foodFunction_4}</td><td>&lt;c:set var="foodInfoNm" value="&#36;{foodInfoList.cultNm }"/></td><td></td></tr>
    	<tr><td>{foodFunction_5}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" /></td><td></td></tr>
    	<tr><td>{foodFunction_6}</td><td>&#36;{foodInfoList.fileUrl}</td><td></td></tr>
    	<tr><td>{foodFunction_7}</td><td>&lt;c:out value="&#36;{viewPath }" />&lt;c:out value="?mode=&#36;{mode }&foodId=&#36;{foodInfoId}&typeId=&#36;{foodInfoTypeId}" /></td><td></td></tr>
    	<tr><td>{foodFunction_8}</td><td>&#36;{foodInfoList.cultNm }</td><td></td></tr>
    	<tr><td>{foodFunction_9}</td><td>&#36;{status.count}</td><td></td></tr>
    	<tr><td>{foodFunction_10}</td><td>&#36;{foodInfoList.newAddr }</td><td></td></tr>
    	<tr><td>{foodFunction_11}</td><td>&#36;{foodInfoList.phone }</td><td></td></tr>
    	<tr><td>{foodFunction_12}</td><td>&#36;{lat}</td><td></td></tr>
    	<tr><td>{foodFunction_13}</td><td>&#36;{lng}</td><td></td></tr>
    	<tr><td>{foodFunction_14}</td><td>&#36;{foodInfoList.gridX}</td><td></td></tr>
    	<tr><td>{foodFunction_15}</td><td>&#36;{foodInfoList.gridY}</td><td></td></tr>
    	<tr><td>{foodCif_1}</td><td>&lt;c:if test='&#36;{fn:length(foodInfoList) <= 1 }'></td><td></td></tr>
    	<tr><td>{foodCif_2}</td><td>&lt;c:if test='&#36;{fn:length(foodInfoList) != 1 }'></td><td></td></tr>
    	<tr><td>{foodCif_end}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{foodForeach_1}</td><td>&lt;c:forEach var="foodInfoList" items="&#36;{foodInfoList }" begin="1" varStatus="status"></td><td></td></tr>
    	<tr><td>{foodForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	<tr><td>{foodPagenavi}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{paginationInfo}" type="jnitDefault" jsFunction="fn_egov_foodInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'fstvEnvirons'}">
    	<tr><td>{fstvFunction_1}</td><td>&#36;{fstvInfoSize<0 ? '0' : fstvInfoSize  }</td><td></td></tr>
    	<tr><td>{fstvFunction_2}</td><td>&lt;c:set var="fstvInfoId" value="&#36;{fstvInfoList.cultId }" /></td><td></td></tr>
    	<tr><td>{fstvFunction_3}</td><td>&lt;c:set var="fstvInfoTypeId" value="&#36;{fstvInfoList.typeId }"/></td><td></td></tr>
    	<tr><td>{fstvFunction_4}</td><td>&lt;c:set var="fstvInfoNm" value="&#36;{fstvInfoList.cultNm }"/></td><td></td></tr>
    	<tr><td>{fstvFunction_5}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" /></td><td></td></tr>
    	<tr><td>{fstvFunction_6}</td><td>&#36;{fstvInfoList.fileUrl}</td><td></td></tr>
    	<tr><td>{fstvFunction_7}</td><td>&lt;c:out value="&#36;{viewPath }" />&lt;c:out value="?mode=&#36;{mode }&fstvId=&#36;{fstvInfoId}&typeId=&#36;{fstvInfoTypeId}" /></td><td></td></tr>
    	<tr><td>{fstvFunction_8}</td><td>&#36;{fstvInfoList.cultNm }</td><td></td></tr>
    	<tr><td>{fstvFunction_9}</td><td>&#36;{status.count}</td><td></td></tr>
    	<tr><td>{fstvFunction_10}</td><td>&#36;{fstvInfoList.newAddr }</td><td></td></tr>
    	<tr><td>{fstvFunction_11}</td><td>&#36;{fstvInfoList.phone }</td><td></td></tr>
    	<tr><td>{fstvFunction_12}</td><td>&#36;{lat}</td><td></td></tr>
    	<tr><td>{fstvFunction_13}</td><td>&#36;{lng}</td><td></td></tr>
    	<tr><td>{fstvFunction_14}</td><td>&#36;{fstvInfoList.gridX}</td><td></td></tr>
    	<tr><td>{fstvFunction_15}</td><td>&#36;{fstvInfoList.gridY}</td><td></td></tr>
    	<tr><td>{fstvCif_1}</td><td>&lt;c:if test='&#36;{fn:length(fstvInfoList) <= 1 }'></td><td></td></tr>
    	<tr><td>{fstvCif_2}</td><td>&lt;c:if test='&#36;{fn:length(fstvInfoList) != 1 }'></td><td></td></tr>
    	<tr><td>{fstvCif_end}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{fstvForeach_1}</td><td>&lt;c:forEach var="fstvInfoList" items="&#36;{fstvInfoList }" begin="1" varStatus="status"></td><td></td></tr>
    	<tr><td>{fstvForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	<tr><td>{fstvPagenavi}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{paginationInfo}" type="jnitDefault" jsFunction="fn_egov_fstvInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'shopEnvirons'}">
    	<tr><td>{shopFunction_1}</td><td>&#36;{shopInfoSize<0 ? '0' : shopInfoSize  }</td><td></td></tr>
    	<tr><td>{shopFunction_2}</td><td>&lt;c:set var="shopInfoId" value="&#36;{shopInfoList.cultId }" /></td><td></td></tr>
    	<tr><td>{shopFunction_3}</td><td>&lt;c:set var="shopInfoTypeId" value="&#36;{shopInfoList.typeId }"/></td><td></td></tr>
    	<tr><td>{shopFunction_4}</td><td>&lt;c:set var="shopInfoNm" value="&#36;{shopInfoList.cultNm }"/></td><td></td></tr>
    	<tr><td>{shopFunction_5}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" /></td><td></td></tr>
    	<tr><td>{shopFunction_6}</td><td>&#36;{shopInfoList.fileUrl}</td><td></td></tr>
    	<tr><td>{shopFunction_7}</td><td>&lt;c:out value="&#36;{viewPath }" />&lt;c:out value="?mode=&#36;{mode }&shopId=&#36;{shopInfoId}&typeId=&#36;{shopInfoTypeId}" /></td><td></td></tr>
    	<tr><td>{shopFunction_8}</td><td>&#36;{shopInfoList.cultNm }</td><td></td></tr>
    	<tr><td>{shopFunction_9}</td><td>&#36;{status.count}</td><td></td></tr>
    	<tr><td>{shopFunction_10}</td><td>&#36;{shopInfoList.newAddr }</td><td></td></tr>
    	<tr><td>{shopFunction_11}</td><td>&#36;{shopInfoList.phone }</td><td></td></tr>
    	<tr><td>{shopFunction_12}</td><td>&#36;{lat}</td><td></td></tr>
    	<tr><td>{shopFunction_13}</td><td>&#36;{lng}</td><td></td></tr>
    	<tr><td>{shopFunction_14}</td><td>&#36;{shopInfoList.gridX}</td><td></td></tr>
    	<tr><td>{shopFunction_15}</td><td>&#36;{shopInfoList.gridY}</td><td></td></tr>
    	<tr><td>{shopCif_1}</td><td>&lt;c:if test='&#36;{fn:length(shopInfoList) <= 1 }'></td><td></td></tr>
    	<tr><td>{shopCif_2}</td><td>&lt;c:if test='&#36;{fn:length(shopInfoList) != 1 }'></td><td></td></tr>
    	<tr><td>{shopCif_end}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{shopForeach_1}</td><td>&lt;c:forEach var="shopInfoList" items="&#36;{shopInfoList }" begin="1" varStatus="status"></td><td></td></tr>
    	<tr><td>{shopForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	<tr><td>{shopPagenavi}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{paginationInfo}" type="jnitDefault" jsFunction="fn_egov_shopInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'stayEnvirons'}">
    	<tr><td>{stayFunction_1}</td><td>&#36;{stayInfoSize<0 ? '0' : stayInfoSize  }</td><td></td></tr>
    	<tr><td>{stayFunction_2}</td><td>&lt;c:set var="stayInfoId" value="&#36;{stayInfoList.cultId }" /></td><td></td></tr>
    	<tr><td>{stayFunction_3}</td><td>&lt;c:set var="stayInfoTypeId" value="&#36;{stayInfoList.typeId }"/></td><td></td></tr>
    	<tr><td>{stayFunction_4}</td><td>&lt;c:set var="stayInfoNm" value="&#36;{stayInfoList.cultNm }"/></td><td></td></tr>
    	<tr><td>{stayFunction_5}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" /></td><td></td></tr>
    	<tr><td>{stayFunction_6}</td><td>&#36;{stayInfoList.fileUrl}</td><td></td></tr>
    	<tr><td>{stayFunction_7}</td><td>&lt;c:out value="&#36;{viewPath }" />&lt;c:out value="?mode=&#36;{mode }&stayId=&#36;{stayInfoId}&typeId=&#36;{stayInfoTypeId}" /></td><td></td></tr>
    	<tr><td>{stayFunction_8}</td><td>&#36;{stayInfoList.cultNm }</td><td></td></tr>
    	<tr><td>{stayFunction_9}</td><td>&#36;{status.count}</td><td></td></tr>
    	<tr><td>{stayFunction_10}</td><td>&#36;{stayInfoList.newAddr }</td><td></td></tr>
    	<tr><td>{stayFunction_11}</td><td>&#36;{stayInfoList.phone }</td><td></td></tr>
    	<tr><td>{stayFunction_12}</td><td>&#36;{lat}</td><td></td></tr>
    	<tr><td>{stayFunction_13}</td><td>&#36;{lng}</td><td></td></tr>
    	<tr><td>{stayFunction_14}</td><td>&#36;{stayInfoList.gridX}</td><td></td></tr>
    	<tr><td>{stayFunction_15}</td><td>&#36;{stayInfoList.gridY}</td><td></td></tr>
    	<tr><td>{stayCif_1}</td><td>&lt;c:if test='&#36;{fn:length(stayInfoList) <= 1 }'></td><td></td></tr>
    	<tr><td>{stayCif_2}</td><td>&lt;c:if test='&#36;{fn:length(stayInfoList) != 1 }'></td><td></td></tr>
    	<tr><td>{stayCif_end}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{stayForeach_1}</td><td>&lt;c:forEach var="stayInfoList" items="&#36;{stayInfoList }" begin="1" varStatus="status"></td><td></td></tr>
    	<tr><td>{stayForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	<tr><td>{stayPagenavi}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{paginationInfo}" type="jnitDefault" jsFunction="fn_egov_stayInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'viewDetail'}">
    	<tr><td>{ctDetailUrl_1}</td><td>&lt;c:url value="/resources/js/geo.js"/></td><td></td></tr>
    	<tr><td>{ctDetailUrl_2}</td><td>&lt;c:url value='/cms/ct/cultList.do'/></td><td></td></tr>
    	<tr><td>{ctDetailUrl_3}</td><td>&lt;c:url value="/roadview/?addr=&#36;{oldAddr0} &#36;{oldAddr1}" /></td><td></td></tr>
    	<tr><td>{ctDetailFunction_1}</td><td>&#36;{distance}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_2}</td><td>&#36;{cultId }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_3}</td><td>{typeId }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_4}</td><td>&#36;{mode }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_5}</td><td>&#36;{cultMainList.cultNm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_6}</td><td>&lt;c:out value='&#36;{pageContext.request.contextPath }' />&#36;{cultMainList.fileUrl}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_7}</td><td>&#36;{status.index }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_8}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" />&#36;{cultList.fileUrl}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_9}</td><td>&#36;{status.count }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_10}</td><td>&#36;{cultMainList.grp == null ? '-' : cultMainList.grp }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_11}</td><td>&#36;{cultMainList.grp2 == null ? '-' : cultMainList.grp2 }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_12}</td><td>&#36;{cultMainList.newAddr == null ? '-' : cultMainList.newAddr }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_13}</td><td>&#36;{cultMainList.phone == null ? '-' : cultMainList.phone}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_14}</td><td>&#36;{cultMainList.fax == null ? '-' : cultMainList.fax}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_15}</td><td>&#36;{cultMainList.email == null ? '-' : cultMainList.email }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_16}</td><td>&#36;{cultMainList.admNm == null ? '-' : cultMainList.admNm}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_17}</td><td>&#36;{cultMainList.admPhone == null ? '-' : cultMainList.admPhone}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_18}</td><td>&#36;{areaNm == null ? '-' : areaNm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_19}</td><td>&#36;{zoneNm == null ? '-' : zoneNm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_20}</td><td>&#36;{originNm == null ? '-' : originNm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_21}</td><td>&#36;{cultMainList.detailInfo == null ? '소개글이 없습니다' : cultMainList.detailInfo }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_22}</td><td>&#36;{cultMainList.cultAppoint == null ? '-' : cultMainList.cultAppoint }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_23}</td><td>&#36;{cultMainList.cultYear == null ? '-' : cultMainList.cultYear }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_24}</td><td>&#36;{cultMainList.cultYear == null ? '-' : cultMainList.cultYear }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_25}</td><td>&#36;{cultMainList.serviceTime == null ? '-' : cultMainList.serviceTime }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_26}</td><td>&#36;{cultMainList.rsvPhone == null ? '-': cultMainList.rsvPhone }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_27}</td><td>&#36;{cultMainList.rsvInternet == null ? '-' : cultMainList.rsvInternet }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_28}</td><td>&#36;{cultMainList.disableInfo == null ? '-' : cultMainList.disableInfo }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_29}</td><td>&#36;{cultMainList.toilet == null ? '-' : cultMainList.toilet  }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_30}</td><td>&#36;{cultMainList.holiday == null ? '-' : cultMainList.holiday  }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_31}</td><td>&#36;{cultMainList.languageInfo == null ? '-' : cultMainList.languageInfo }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_32}</td><td>&#36;{cultMainList.chargePrice == null ? '-' : cultMainList.chargePrice }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_33}</td><td>&#36;{cultMainList.openYear == null ? '-' : cultMainList.openYear }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_34}</td><td>&#36;{cultMainList.roomCnt == null ? '-' : cultMainList.roomCnt }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_35}</td><td>&#36;{cultMainList.summerPeck == null ? '-' : cultMainList.summerPeck }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_36}</td><td>&#36;{cultMainList.winterPeck == null ? '-' : cultMainList.winterPeck}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_37}</td><td>&#36;{cultMainList.weekPrice == null ? '-' : cultMainList.weekPrice }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_38}</td><td>&#36;{cultMainList.addPeoplePrice == null ? '-' : cultMainList.addPeoplePrice }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_39}</td><td>&#36;{cultMainList.seatCnt == null ? '-' : cultMainList.seatCnt }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_40}</td><td>&#36;{cultMainList.fstvSupport == null ? '-' : cultMainList.fstvSupport }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_41}</td><td>&#36;{cultMainList.fstvHost == null ? '-' : cultMainList.fstvHost }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_42}</td><td>&#36;{cultMainList.fstvTerm == null ? '-' : cultMainList.fstvTerm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_43}</td><td>&#36;{cultMainList.fstvPlace == null ? '-' : cultMainList.fstvPlace  }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_44}</td><td>&#36;{cultMainList.fstvSupervision == null ? '-' : cultMainList.fstvSupervision }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_45}</td><td>&#36;{cultMainList.tourGuide == null ? '-' : cultMainList.tourGuide }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_46}</td><td>&#36;{cultMainList.guideCar == null ? '-' : cultMainList.guideCar }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_47}</td><td>&#36;{cultMainList.guidePublic == null ? '-' : cultMainList.guidePublic }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_48}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" />&#36;{foodMenuList.fileUrl}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_49}</td><td>&#36;{foodMenuList.foodNm == '' ? '-' : foodMenuList.foodNm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_50}</td><td>&#36;{foodMenuList.foodDiv == null ? '-' : foodMenuList.foodDiv }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_51}</td><td>&#36;{foodMenuList.foodInfo == '' ? '-' : foodMenuList.foodInfo }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_52}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" />&#36;{stayMenuList.fileUrl}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_53}</td><td>&#36;{stayMenuList.stayNm == '' ? '-' : stayMenuList.stayNm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_54}</td><td>&#36;{stayMenuList.staySort == null ? '-' : stayMenuList.staySort }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_55}</td><td>&#36;{stayMenuList.stayAvrpeople == '' ? '-' : stayMenuList.stayAvrpeople }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_56}</td><td>&#36;{stayMenuList.stayMaxpeople == '' ? '-' : stayMenuList.stayMaxpeople }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_57}</td><td>&#36;{stayMenuList.stayCnt == '' ? '-' : stayMenuList.stayCnt }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_58}</td><td>&#36;{stayMenuList.stayComposition == '' ? '-' : stayMenuList.stayComposition }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_59}</td><td>&#36;{stayMenuList.stayArea == '' ? '-' : stayMenuList.stayArea }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_60}</td><td>&#36;{stayMenuList.stayPrice == '' ? '-' : stayMenuList.stayPrice }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_61}</td><td>&#36;{stayMenuList.stayPreference == '' ? '-' : stayMenuList.stayPreference }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_62}</td><td>&#36;{stayMenuList.stayFacilities == '' ? '-' : stayMenuList.stayFacilities }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_63}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" />&#36;{shopMenuList.fileUrl}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_64}</td><td>&#36;{shopMenuList.shopNm == '' ? '-' : shopMenuList.shopNm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_65}</td><td>&#36;{shopMenuList.shopPrice == '' ? '-' : shopMenuList.shopPrice }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_66}</td><td>&#36;{shopMenuList.shopVolume == '' ? '-' : shopMenuList.shopVolume }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_67}</td><td>&#36;{shopMenuList.shopOrtherinfo == '' ? '-' : shopMenuList.shopOrtherinfo }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_68}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" />&#36;{fstvMenuList.fileUrl}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_69}</td><td>&#36;{fstvMenuList.fstvNm == null ? '-' : fstvMenuList.fstvNm }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_70}</td><td>&#36;{fstvMenuList.fstvInfo == null ? '-' : fstvMenuList.fstvInfo }</td><td></td></tr>
    	<tr><td>{ctDetailFunction_71}</td><td>&lt;c:set var="cultInfoId" value="&#36;{cultInfoList.cultId }" /></td><td></td></tr>
    	<tr><td>{ctDetailFunction_72}</td><td>&lt;c:set var="cultInfoTypeId" value="&#36;{cultInfoList.typeId }"/></td><td></td></tr>
    	<tr><td>{ctDetailFunction_73}</td><td>&lt;c:set var="cultInfoNm" value="&#36;{cultInfoList.cultNm }"/></td><td></td></tr>
    	<tr><td>{ctDetailFunction_74}</td><td>&lt;c:out value="&#36;{pageContext.request.contextPath }" />&#36;{cultInfoList.fileUrl}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_75}</td><td>&lt;c:out value="&#36;{viewPath }" />&lt;c:out value="?mode=&#36;{mode }&cultId=&#36;{cultInfoId}&typeId=&#36;{cultInfoTypeId}" /></td><td></td></tr>
    	<tr><td>{ctDetailFunction_76}</td><td>&#36;{lat}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_77}</td><td>&#36;{lng}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_78}</td><td>&#36;{cultInfoList.gridX}</td><td></td></tr>
    	<tr><td>{ctDetailFunction_79}</td><td>&#36;{cultInfoList.gridY}</td><td></td></tr>
    	
    	
    	<tr><td>{ctDetailCif_1}</td><td>&lt;c:if test="&#36;{typeFields['cultAppoint'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_2}</td><td>&lt;c:if test="&#36;{typeFields['cultYear'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_3}</td><td>&lt;c:if test="&#36;{typeFields['storytelling'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_4}</td><td>&lt;c:if test="&#36;{typeFields['serviceTime'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_5}</td><td>&lt;c:if test="&#36;{typeFields['rsvPhone'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_6}</td><td>&lt;c:if test="&#36;{typeFields['rsvInternet'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_7}</td><td>&lt;c:if test="&#36;{typeFields['cardYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_8}</td><td>&lt;c:if test="&#36;{typeFields['parkYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_9}</td><td>&lt;c:if test="&#36;{typeFields['petYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_10}</td><td>&lt;c:if test="&#36;{typeFields['disableYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_11}</td><td>&lt;c:if test="&#36;{typeFields['disableInfo'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_12}</td><td>&lt;c:if test="&#36;{typeFields['smokeYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_13}</td><td>&lt;c:if test="&#36;{typeFields['toilet'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_14}</td><td>&lt;c:if test="&#36;{typeFields['holiday'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_15}</td><td>&lt;c:if test="&#36;{typeFields['baycarYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_16}</td><td>&lt;c:if test="&#36;{typeFields['languageYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_17}</td><td>&lt;c:if test="&#36;{typeFields['languageInfo'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_18}</td><td>&lt;c:if test="&#36;{typeFields['TipYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_19}</td><td>&lt;c:if test="&#36;{typeFields['chargePrice'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_20}</td><td>&lt;c:if test="&#36;{typeFields['openYear'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_21}</td><td>&lt;c:if test="&#36;{typeFields['roomCnt'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_22}</td><td>&lt;c:if test="&#36;{typeFields['summerPeck'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_23}</td><td>&lt;c:if test="&#36;{typeFields['winterPeck'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_24}</td><td>&lt;c:if test="&#36;{typeFields['weekPrice'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_25}</td><td>&lt;c:if test="&#36;{typeFields['addPeoplePrice'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_26}</td><td>&lt;c:if test="&#36;{typeFields['stayBeakfastYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_27}</td><td>&lt;c:if test="&#36;{typeFields['packYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_28}</td><td>&lt;c:if test="&#36;{typeFields['companion'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_29}</td><td>&lt;c:if test="&#36;{typeFields['mood'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_30}</td><td>&lt;c:if test="&#36;{typeFields['seatCnt'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_31}</td><td>&lt;c:if test="&#36;{typeFields['kidRoomYn'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_32}</td><td>&lt;c:if test="&#36;{typeFields['fstvSupport'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_33}</td><td>&lt;c:if test="&#36;{typeFields['fstvHost'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_34}</td><td>&lt;c:if test="&#36;{typeFields['fstvTerm'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_35}</td><td>&lt;c:if test="&#36;{typeFields['fstvPlace'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_36}</td><td>&lt;c:if test="&#36;{typeFields['fstvSupervision'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_37}</td><td>&lt;c:if test="&#36;{typeFields['tourGuide'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_38}</td><td>&lt;c:if test="&#36;{typeFields['guideCar'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_39}</td><td>&lt;c:if test="&#36;{typeFields['guidePublic'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_40}</td><td>&lt;c:if test="&#36;{typeFields['noAdd'] == true}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_41}</td><td>&lt;c:if test="&#36;{cultMainList.typeId != 'CULT' }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_42}</td><td>&lt;c:if test="&#36;{cultMainList.typeId == 'FOOD' }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_43}</td><td>&lt;c:if test="&#36;{cultMainList.typeId == 'STAY' }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_44}</td><td>&lt;c:if test="&#36;{cultMainList.typeId == 'SHOP' }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_45}</td><td>&lt;c:if test="&#36;{cultMainList.typeId == 'FSTV' }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_46}</td><td>&lt;c:if test="&#36;{cultMainList.cardYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_47}</td><td>&lt;c:if test="&#36;{cultMainList.cardYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_48}</td><td>&lt;c:if test="&#36;{cultMainList.cardYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_49}</td><td>&lt;c:if test="&#36;{cultMainList.parkYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_50}</td><td>&lt;c:if test="&#36;{cultMainList.parkYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_51}</td><td>&lt;c:if test="&#36;{cultMainList.parkYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_52}</td><td>&lt;c:if test="&#36;{cultMainList.petYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_53}</td><td>&lt;c:if test="&#36;{cultMainList.petYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_54}</td><td>&lt;c:if test="&#36;{cultMainList.petYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_55}</td><td>&lt;c:if test="&#36;{cultMainList.disableYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_56}</td><td>&lt;c:if test="&#36;{cultMainList.disableYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_57}</td><td>&lt;c:if test="&#36;{cultMainList.disableYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_58}</td><td>&lt;c:if test="&#36;{cultMainList.smokeYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_59}</td><td>&lt;c:if test="&#36;{cultMainList.smokeYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_60}</td><td>&lt;c:if test="&#36;{cultMainList.smokeYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_61}</td><td>&lt;c:if test="&#36;{cultMainList.baycarYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_62}</td><td>&lt;c:if test="&#36;{cultMainList.baycarYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_63}</td><td>&lt;c:if test="&#36;{cultMainList.baycarYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_64}</td><td>&lt;c:if test="&#36;{cultMainList.languageYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_65}</td><td>&lt;c:if test="&#36;{cultMainList.languageYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_66}</td><td>&lt;c:if test="&#36;{cultMainList.languageYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_67}</td><td>&lt;c:if test="&#36;{cultMainList.TipYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_68}</td><td>&lt;c:if test="&#36;{cultMainList.TipYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_69}</td><td>&lt;c:if test="&#36;{cultMainList.TipYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_70}</td><td>&lt;c:if test="&#36;{cultMainList.stayBeakfastYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_71}</td><td>&lt;c:if test="&#36;{cultMainList.stayBeakfastYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_72}</td><td>&lt;c:if test="&#36;{cultMainList.stayBeakfastYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_73}</td><td>&lt;c:if test="&#36;{cultMainList.packYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_74}</td><td>&lt;c:if test="&#36;{cultMainList.packYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_75}</td><td>&lt;c:if test="&#36;{cultMainList.packYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_76}</td><td>&lt;c:if test="&#36;{cultMainList.companion == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_77}</td><td>&lt;c:if test="&#36;{cultMainList.companion == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_78}</td><td>&lt;c:if test="&#36;{cultMainList.companion == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_79}</td><td>&lt;c:if test="&#36;{cultMainList.companion == 3 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_80}</td><td>&lt;c:if test="&#36;{cultMainList.companion == 4 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_81}</td><td>&lt;c:if test="&#36;{cultMainList.companion == 5 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_82}</td><td>&lt;c:if test="&#36;{cultMainList.companion == 6 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_83}</td><td>&lt;c:if test="&#36;{cultMainList.mood == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_84}</td><td>&lt;c:if test="&#36;{cultMainList.mood == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_85}</td><td>&lt;c:if test="&#36;{cultMainList.mood == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_86}</td><td>&lt;c:if test="&#36;{cultMainList.mood == 3 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_87}</td><td>&lt;c:if test="&#36;{cultMainList.mood == 4 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_88}</td><td>&lt;c:if test="&#36;{cultMainList.mood == 5 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_89}</td><td>&lt;c:if test="&#36;{cultMainList.mood == 6 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_90}</td><td>&lt;c:if test="&#36;{cultMainList.kidRoomYn == 0 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_91}</td><td>&lt;c:if test="&#36;{cultMainList.kidRoomYn == 1 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_92}</td><td>&lt;c:if test="&#36;{cultMainList.kidRoomYn == 2 }"></td><td></td></tr>
    	<tr><td>{ctDetailCif_93}</td><td>&lt;c:if test="&#36;{foodMenuList.foodNm != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_94}</td><td>&lt;c:if test="&#36;{foodMenuList.foodInfo != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_95}</td><td>&lt;c:if test="&#36;{stayMenuList.stayNm != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_96}</td><td>&lt;c:if test="&#36;{stayMenuList.stayAvrpeople != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_97}</td><td>&lt;c:if test="&#36;{stayMenuList.stayMaxpeople != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_98}</td><td>&lt;c:if test="&#36;{stayMenuList.stayCnt != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_99}</td><td>&lt;c:if test="&#36;{stayMenuList.stayComposition != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_100}</td><td>&lt;c:if test="&#36;{stayMenuList.stayArea != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_101}</td><td>&lt;c:if test="&#36;{stayMenuList.stayPrice != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_102}</td><td>&lt;c:if test="&#36;{stayMenuList.stayPreference != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_103}</td><td>&lt;c:if test="&#36;{stayMenuList.stayFacilities != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_104}</td><td>&lt;c:if test="&#36;{shopMenuList.shopNm != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_105}</td><td>&lt;c:if test="&#36;{shopMenuList.shopPrice != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_106}</td><td>&lt;c:if test="&#36;{shopMenuList.shopVolume != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_107}</td><td>&lt;c:if test="&#36;{shopMenuList.shopOrtherinfo != null}"></td><td></td></tr>
    	<tr><td>{ctDetailCif_108}</td><td>&lt;c:if test='&#36;{fn:length(cultInfoList) <= 1 }'></td><td></td></tr>
    	<tr><td>{ctDetailCif_109}</td><td>&lt;c:if test='&#36;{fn:length(cultInfoList) != 1 }'></td><td></td></tr>
    	<tr><td>{ctDetailCif_110}</td><td>&#36;{cultInfoSize<0 ? '0' : cultInfoSize }</td><td></td></tr>
    	<tr><td>{ctDetailCif_111}</td><td>&#36;{foodInfoSize<0 ? '0' : foodInfoSize  }</td><td></td></tr>
    	<tr><td>{ctDetailCif_112}</td><td>&#36;{stayInfoSize<0 ? '0' : stayInfoSize  }</td><td></td></tr>
    	<tr><td>{ctDetailCif_113}</td><td>&#36;{shopInfoSize<0 ? '0': shopInfoSize }</td><td></td></tr>
    	<tr><td>{ctDetailCif_114}</td><td>&#36;{fstvInfoSize<0 ? '0' : fstvInfoSize  }</td><td></td></tr>
    	
    	
    	<tr><td>{ctDetailCif_end}</td><td>&lt;/c:if>	</td><td></td></tr>
    	
    	<tr><td>{ctDetailForeach_1}</td><td>&lt;c:forEach var="cultMainList" items="&#36;{cultMainList }" varStatus="status"></td><td></td></tr>
    	<tr><td>{ctDetailForeach_2}</td><td>&lt;c:forEach var="cultList" items="&#36;{cultList }" varStatus="status"></td><td></td></tr>
    	<tr><td>{ctDetailForeach_3}</td><td>&lt;c:forEach var="foodMenuList" items="&#36;{foodMenuList }"></td><td></td></tr>
    	<tr><td>{ctDetailForeach_4}</td><td>&lt;c:forEach var="stayMenuList" items="&#36;{stayMenuList }"></td><td></td></tr>
    	<tr><td>{ctDetailForeach_5}</td><td>&lt;c:forEach var="shopMenuList" items="&#36;{shopMenuList }"></td><td></td></tr>
    	<tr><td>{ctDetailForeach_6}</td><td>&lt;c:forEach var="fstvMenuList" items="&#36;{fstvMenuList }"></td><td></td></tr>
    	<tr><td>{ctDetailForeach_7}</td><td>&lt;c:forEach var="cultInfoList" items="&#36;{cultInfoList }" begin="1" varStatus="status"></td><td></td></tr>
    	<tr><td>{ctDetailForeach_end}</td><td>&lt;/c:forEach></td><td></td></tr>
    	
    	
    	<tr><td>{ctDetailPagenavi_1}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{cultInfo}" type="jnitDefault" jsFunction="fn_egov_cultInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	<tr><td>{ctDetailPagenavi_2}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{foodInfo}" type="jnitDefault" jsFunction="fn_egov_foodInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	<tr><td>{ctDetailPagenavi_3}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{stayInfo}" type="jnitDefault" jsFunction="fn_egov_stayInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	<tr><td>{ctDetailPagenavi_4}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{shopInfo}" type="jnitDefault" jsFunction="fn_egov_shopInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	<tr><td>{ctDetailPagenavi_5}</td><td><ul>&lt;ui:pagination paginationInfo = "&#36;{fstvInfo}" type="jnitDefault" jsFunction="fn_egov_fstvInfo" /> &lt;input type="hidden" name="pageIndex" id="pageIndex" /> </ul></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'respondentRegister'}">
    	<tr><td>{rechResponUrl_1}</td><td>&lt;c:url value="/resources/css/jnit.css"/></td><td></td></tr>
    	<tr><td>{rechResponUrl_2}</td><td>&lt;c:url value="/resources/css/select.css"/></td><td></td></tr>
    	<tr><td>{rechResponUrl_3}</td><td>&lt;c:url value="/resources/css/color_picker.css"/></td><td></td></tr>
    	<tr><td>{rechResponUrl_4}</td><td>&lt;c:url value="/resources/css/date_picker.css"/></td><td></td></tr>
    	<tr><td>{rechResponUrl_5}</td><td>&lt;c:url value="/resources/js/jquery.min.js"/></td><td></td></tr>
    	<tr><td>{rechResponFunction_1}</td><td>&#36;{researchId}</td><td></td></tr>
    	<tr><td>{rechResponFunction_2}</td><td>&lt;c:out value="&#36;{jnitresearchVO.researchNm}"/></td><td></td></tr>
    	<tr><td>{rechResponFunction_3}</td><td>&#36;{jnitresearchVO.introduce}</td><td></td></tr>
    	<tr><td>{rechResponFunction_4}</td><td>&lt;c:set var="Qnum" value="0" /></td><td></td></tr>
    	<tr><td>{rechResponFunction_5}</td><td>&lt;c:set var="Anum" value="0" /></td><td></td></tr>
    	<tr><td>{rechResponFunction_6}</td><td>&lt;c:set var="radioNum" value="0" /></td><td></td></tr>
    	<tr><td>{rechResponFunction_7}</td><td>&lt;c:set var="Qnum" value="&#36;{Qnum +1}" /></td><td></td></tr>
    	<tr><td>{rechResponFunction_8}</td><td>&#36;{Qnum}</td><td></td></tr>
    	<tr><td>{rechResponFunction_9}</td><td>&lt;c:out value="&#36;{queResult.questionNm}"/></td><td></td></tr>
    	<tr><td>{rechResponFunction_10}</td><td>&lt;c:url value="&#36;{queResult.fileUrl}"/></td><td></td></tr>
    	<tr><td>{rechResponFunction_11}</td><td>&lt;c:set var="radioNum" value="&#36;{radioNum +1}" /></td><td></td></tr>
    	<tr><td>{rechResponFunction_12}</td><td>&#36;{Anum}</td><td></td></tr>
    	<tr><td>{rechResponFunction_13}</td><td>&#36;{queResult.questionId}</td><td></td></tr>
    	<tr><td>{rechResponFunction_14}</td><td>&#36;{ansResult.answerId}</td><td></td></tr>
    	<tr><td>{rechResponFunction_15}</td><td>&#36;{queResult.type}</td><td></td></tr>
    	<tr><td>{rechResponFunction_16}</td><td>&#36;{radioNum}</td><td></td></tr>
    	<tr><td>{rechResponFunction_17}</td><td>&lt;c:out value="onclick=javascript:fnCheck('&#36;{orderAnswerId}');"/></td><td></td></tr>
    	<tr><td>{rechResponFunction_18}</td><td>&lt;c:out value="&#36;{ansResult.answerNm}"/></td><td></td></tr>
    	<tr><td>{rechResponFunction_19}</td><td>&lt;c:set var="orderAnswerId" value="&#36;{ansResult.answerId}" /></td><td></td></tr>
    	<tr><td>{rechResponFunction_20}</td><td>&#36;{orderAnswerId}</td><td></td></tr>
    	<tr><td>{rechResponFunction_21}</td><td>&lt;c:out value='&#36;{searchVO.searchCondition}'/></td><td></td></tr>
    	<tr><td>{rechResponFunction_22}</td><td>&lt;c:out value='&#36;{searchVO.searchKeyword}'/></td><td></td></tr>
    	<tr><td>{rechResponFunction_23}</td><td>&lt;c:out value='&#36;{searchVO.pageIndex}'/></td><td></td></tr>    	
    	<tr><td>{rechResponFunction_24}</td><td>&lt;c:url value="&#36;{ansResult.fileUrl}"/></td><td></td></tr>
    	<tr><td>{rechResponFunction_25}</td><td>&lt;c:set var="Anum" value="&#36;{Anum +1}" /></td><td></td></tr>
    	<tr><td>{rechResponFunction_26}</td><td>&lt;c:set var="orderAnswerId" value="&#36;{ansResult.answerId}" /></td><td></td></tr>
    	<tr><td>{rechResponFunction_27}</td><td>&lt;c:url value="&#36;{ansResult.fileUrl}"/></td><td></td></tr>
    
    	
    	<tr><td>{rechResponCif_1}</td><td>&lt;c:if test="&#36;{queResult.fileUrl != null && queResult.fileUrl != ''}"></td><td></td></tr>
    	<tr><td>{rechResponCif_2}</td><td>&lt;c:if test='&#36;{queResult.type == 0}'></td><td></td></tr>
    	<tr><td>{rechResponCif_3}</td><td>&lt;c:if test='&#36;{fn:length(ansListResult) != 0 }'></td><td></td></tr>
    	<tr><td>{rechResponCif_4}</td><td>&lt;c:if test='&#36;{queResult.questionId == ansResult.questionId }'></td><td></td></tr>
    	<tr><td>{rechResponCif_5}</td><td>&lt;c:if test='&#36;{ansResult.type != 9}'></td><td></td></tr>
    	<tr><td>{rechResponCif_6}</td><td>&lt;c:set var="Anum" value="&#36;{Anum +1}" /></td><td></td></tr>
    	<tr><td>{rechResponCif_7}</td><td>&lt;c:set var="orderAnswerId" value="&#36;{ansResult.answerId}" /></td><td></td></tr>
    	<tr><td>{rechResponCif_8}</td><td>&lt;c:if test="&#36;{ansResult.fileUrl != null && ansResult.fileUrl != ''}"></td><td></td></tr>
    	<tr><td>{rechResponCif_9}</td><td>&lt;c:url value="&#36;{ansResult.fileUrl}"/></td><td></td></tr>
    	<tr><td>{rechResponCif_10}</td><td>&lt;c:if test='&#36;{queResult.ordercheck == 1}'></td><td></td></tr>
    	<tr><td>{rechResponCif_11}</td><td>&lt;c:if test='&#36;{ansResult.type == 9}'></td><td></td></tr>
    	<tr><td>{rechResponCif_12}</td><td> &lt;c:if test='&#36;{queResult.type == 1}'></td><td></td></tr>
    	<tr><td>{rechResponCif_13}</td><td>&lt;c:if test='&#36;{fn:length(ansListResult) != 0 }'></td><td></td></tr>
    	<tr><td>{rechResponCif_14}</td><td>&lt;c:if test='&#36;{queResult.type == 2}'></td><td></td></tr>    	
    	
    	<tr><td>{rechResponCifEnd}</td><td>&lt;/c:if></td><td></td></tr>
    	
    	
    	<tr><td>{rechResponForeach_1}</td><td>&lt;c:forEach var="queResult" items="&#36;{queListResult}" varStatus="status"></td><td></td></tr>
    	<tr><td>{rechResponForeach_2}</td><td>&lt;c:forEach var="ansResult" items="&#36;{ansListResult}" varStatus="status"> </td><td></td></tr>    	
    	
    	<tr><td>{rechResponForeachEnd}</td><td>&lt;/c:forEach></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'statsUserView'}">
    	<tr><td>{rechResponFunction_5}</td><td>&lt;c:set var="Anum" value="0" /></td><td></td></tr>
    	
    	<tr><td>{rechResponFunction_12}</td><td>&#36;{Anum}</td><td></td></tr>
    	<tr><td>{rechResponFunction_18}</td><td>&lt;c:out value="&#36;{ansResult.answerNm}"/></td><td></td></tr>
    	
    	
    	<tr><td>{rechResponForeach_1}</td><td>&lt;c:forEach var="queResult" items="&#36;{queListResult}" varStatus="status"></td><td></td></tr>
    	<tr><td>{rechResponForeach_2}</td><td>&lt;c:forEach var="ansResult" items="&#36;{ansListResult}" varStatus="status"> </td><td></td></tr>    	
    	
    	<tr><td>{rechResponCif_3}</td><td>&lt;c:if test='&#36;{fn:length(ansListResult) != 0 }'></td><td></td></tr>
    	<tr><td>{rechResponCif_4}</td><td>&lt;c:if test='&#36;{queResult.questionId == ansResult.questionId }'></td><td></td></tr>
    	<tr><td>{rechResponCif_5}</td><td>&lt;c:if test='&#36;{ansResult.type != 9}'></td><td></td></tr>
		<tr><td>{rechResponCif_8}</td><td>&lt;c:if test="&#36;{ansResult.fileUrl != null && ansResult.fileUrl != ''}"></td><td></td></tr>
    	
		<tr><td>{rechResponCif_9}</td><td>&lt;c:url value="&#36;{ansResult.fileUrl}"/></td><td></td></tr>
    	<tr><td>{rechResponCif_11}</td><td>&lt;c:if test='&#36;{ansResult.type == 9}'></td><td></td></tr>
    	
    	<tr><td>{rechResponCif_14}</td><td>&lt;c:if test='&#36;{queResult.type == 2}'></td><td></td></tr>   
    	
    	
    	<tr><td>{rechStatFunction_1}</td><td>&lt;c:url value="/resources/js/jquery.min.js"/></td><td></td></tr>
    	<tr><td>{rechStatFunction_2}</td><td>&lt;c:url value='/answer/popup.do?answerId="+answerId+"'/></td><td></td></tr>
    	<tr><td>{rechStatFunction_3}</td><td>&lt;c:set var="AnswerCt" value="1" /></td><td></td></tr>
    	<tr><td>{rechStatFunction_4}</td><td>&lt;c:set var="Qnum" value="0" /></td><td></td></tr>
    	<tr><td>{rechStatFunction_5}</td><td>&lt;c:set var="CountNum" value="0" /></td><td></td></tr>
    	<tr><td>{rechStatFunction_6}</td><td>&lt;c:set var="Qnum" value="&#36;{Qnum +1}" /></td><td></td></tr>
    	<tr><td>{rechStatFunction_7}</td><td>&lt;c:out value="&#36;{queResult.questionNm}"/></td><td></td></tr>
    	<tr><td>{rechStatFunction_8}</td><td>&lt;c:url value="&#36;{queResult.fileUrl}"/></td><td></td></tr>
    	<tr><td>{rechStatFunction_9}</td><td>&lt;c:set var="Anum" value="&#36;{Anum +1}" /></td><td></td></tr>
    	<tr><td>{rechStatFunction_10}</td><td>&lt;c:set var="AnsId" value="&#36;{ansResult.answerId}"/></td><td></td></tr>
    	<tr><td>{rechStatFunction_11}</td><td>&#36;{answerCount[ansResult.answerId]} / &#36;{jnitresearchVO.entry}</td><td></td></tr>
    	<tr><td>{rechStatFunction_12}</td><td>&lt;c:set var="AnswerCt" value="&#36;{AnswerCt +1}" /></td><td></td></tr>
    	<tr><td>{rechStatFunction_13}</td><td>&lt;c:set var="CountNum" value="&#36;{CountNum +1}" /></td><td></td></tr>
    	<tr><td>{rechStatFunction_14}</td><td>&lt;c:out value='&#36;{searchVO.searchCondition}'/></td><td></td></tr>
    	<tr><td>{rechStatFunction_15}</td><td>&lt;c:out value='&#36;{searchVO.searchKeyword}'/></td><td></td></tr>
    	<tr><td>{rechStatFunction_16}</td><td>&lt;c:out value='&#36;{searchVO.pageIndex}'/></td><td></td></tr>
    	<tr><td>{rechStatFunction_17}</td><td>&#36;{100 * (answerCount[ansResult.answerId] / jnitresearchVO.entry)}</td><td></td></tr>
 
    	<tr><td>{rechStatCif_1}</td><td>&lt;c:if test='&#36;{fn:length(queListResult) != 0 }'></td><td></td></tr>
    	<tr><td>{rechStatCif_2}</td><td>&lt;c:if test="&#36;{queResult.fileUrl != null && queResult.fileUrl != ''}"></td><td></td></tr>
    	<tr><td>{rechStatCif_3}</td><td>&lt;c:if test='&#36;{ansResult.type != 2}'></td><td></td></tr>
    	<tr><td>{rechStatCif_4}</td><td>&lt;c:if test="${empty resultList }" ></td><td></td></tr>
    	<tr><td>{rechStatCif_5}</td><td>&lt;c:if test="${!empty resultList }" ></td><td></td></tr>
    	<tr><td>{rechStatCif_6}</td><td>&lt;c:if test="${queResult.type == 0}"></td><td></td></tr>
    	<tr><td>{rechStatCif_1_End}</td><td>&lt;/c:forEach></td><td></td></tr>
    	<tr><td>{rechStatCif_2_End}</td><td>&lt;/c:forEach></td><td></td></tr>
    	<tr><td>{rechStatCif_3_End}</td><td>&lt;/c:forEach></td><td></td></tr>
    	
    	<tr><td>{rechStatForeach_1}</td><td> &lt;c:forEach var="queResult" items="&#36;{queListResult}" varStatus="status"></td><td></td></tr>
    	<tr><td>{rechStatForeach_1_End}</td><td>&lt;/c:forEach></td><td></td></tr>
    	</c:if>
    	<c:if test="${codeMode == 'researchImport'}">
    	<tr><td>{rechImportCif1}</td><td>&lt;c:if test="&#36;{not empty error}"></td><td></td></tr>
    	<tr><td>{rechImportCifEnd1}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{rechImportFunction1}</td><td>&lt;%=request.getRequestURI()%></td><td></td></tr>
    	<tr><td>{rechImportFunction2}</td><td>&#36;{page}</td><td></td></tr>
    	<tr><td>{rechImportFunction3}</td><td>&lt;c:out value="&#36;{error}"/></td><td></td></tr>
    	
    	</c:if>
    	<c:if test="${codeMode == 'listProgress' || codeMode == 'listEnd'}">
    	<tr><td>{rechListFunction_1}</td><td>&lt;c:set var ="today" value = "현재날짜" /></td><td></td></tr>
    	<tr><td>{rechListFunction_2}</td><td>&lt;c:set var="cnt" value="&#36;{empty cnt ? paginationInfo.totalRecordCount : cnt}"/></td><td></td></tr>
    	<tr><td>{rechListFunction_3}</td><td>&lt;c:out value="&#36;{result.researchNm}"/></td><td></td></tr>
    	<tr><td>{rechListFunction_4}</td><td>&lt;c:out value="&#36;{result.researchId}"/></td><td></td></tr>
    	<tr><td>{rechListFunction_5}</td><td>&lt;c:out value="&#36;{result.starttime}"/></td><td></td></tr>
    	<tr><td>{rechListFunction_6}</td><td>&lt;c:out value="&#36;{result.endtime}"/></td><td></td></tr>
    	<tr><td>{rechListFunction_7}</td><td>&lt;c:out value="&#36;{result.entry}"/></td><td></td></tr>
    	<tr><td>{rechListFunction_8}</td><td>&lt;c:set var ="cnt" value = "&#36;{cnt -1}" /></td><td></td></tr>
    	<tr><td>{rechListFunction_9}</td><td>&#36;{cnt}</td><td></td></tr>
    	
    	
    	<tr><td>{rechListCif_1}</td><td>&lt;c:if test = "&#36;{(result.state == 0) && (today < result.starttime)}"></td><td></td></tr>
    	<tr><td>{rechListCif_2}</td><td>&lt;c:if test = "&#36;{(result.state == 0) && (today > result.starttime) && (result.endtime > today)}"></td><td></td></tr>
    	<tr><td>{rechListCif_3}</td><td>&lt;c:if test = "&#36;{(result.state == 0) && (result.endtime < today)}"></td><td></td></tr>
    	<tr><td>{rechListCif_4}</td><td>&lt;c:if test = "&#36;{result.state == 1}"></td><td></td></tr>
    	<tr><td>{rechListCif_5}</td><td>&lt;c:if test = "&#36;{result.block == 0}"></td><td></td></tr>
    	<tr><td>{rechListCif_6}</td><td>&lt;c:if test = "&#36;{result.block == 1}"></td><td></td></tr>
    	<tr><td>{rechListCifEnd}</td><td>&lt;/c:if></td><td></td></tr>
    	
    	<tr><td>{rechListForeach_1}</td><td>&lt;c:forEach var="result" items="&#36;{resultList}" varStatus="status"></td><td></td></tr>
    	<tr><td>{rechListForeachEnd}</td><td>&lt;/c:forEach></td><td></td></tr>
    	
    	<tr><td>{rechListPaginavi}</td><td>&lt;div class="span6 offset3"> &lt;ui:pagination paginationInfo = "&#36;{paginationInfo}"   type="jnitDefault"   jsFunction="fn_egov_link_page"   /> &lt;/div></td><td></td></tr>
    	</c:if>
	<c:if test="${codeMode == 'contentAdmin'}">
		<tr><td>{contentFunction1}</td><td>&lt;%</td><td></td></tr>
    	<tr><td>{contentFunction2}</td><td>%></td><td></td></tr>
    	<tr><td>{contentFunction3}</td><td>&lt;c:set var="admNm2" value="&lt;%=amdNm2 %>" /></td><td></td></tr>
    	<tr><td>{contentFunction4}</td><td>&lt;c:set var="admTel2" value="&lt;%=amdTel2 %>" /></td><td></td></tr>
    	<tr><td>{contentFunction5}</td><td>&lt;c:set var="admNm" value="&lt;%=amdNm %>" /></td><td></td></tr>
    	<tr><td>{contentFunction6}</td><td>&lt;c:set var="admTel" value="&lt;%=amdTel %>" /></td><td></td></tr>
    	<tr><td>{contentFunction7}</td><td>&#36;{admNm2}</td><td></td></tr>
    	<tr><td>{contentFunction8}</td><td>&#36;{admTel2}</td><td></td></tr>
    	<tr><td>{contentFunction9}</td><td>&#36;{admNm}</td><td></td></tr>
    	<tr><td>{contentFunction10}</td><td>&#36;{admTel}</td><td></td></tr>
    	
    	<tr><td>{contentCifFunction1}</td><td>&lt;c:if test="&#36;{!empty admNm2}"></td><td></td></tr>
    	<tr><td>{contentCifFunction2}</td><td>&lt;c:if test="&#36;{empty admNm2}"></td><td></td></tr>
    	<tr><td>{contentCifFunction3}</td><td>&lt;c:if test="&#36;{empty admTel2}"></td><td></td></tr>
    	<tr><td>{contentCifFunction4}</td><td>&lt;c:if test="&#36;{empty admNm}"></td><td></td></tr>
    	<tr><td>{contentCifFunction5}</td><td>&lt;c:if test="&#36;{empty admTel}"></td><td></td></tr>
    	
    	<tr><td>{contentCifEnd1}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{contentCifEnd2}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{contentCifEnd3}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{contentCifEnd4}</td><td>&lt;/c:if></td><td></td></tr>
    	<tr><td>{contentCifEnd5}</td><td>&lt;/c:if></td><td></td></tr>
	</c:if>
	<c:if test="${codeMode == 'updateButton'}">
		<tr><td>{upBtnFunction1}</td><td>&lt;%</td><td></td></tr>
    	<tr><td>{upBtnFunction2}</td><td>%></td><td></td></tr>
    	<tr><td>{upBtnFunction3}</td><td>&lt;c:set var="cntCntId" value="&lt;%= cntId %>"/></td><td></td></tr>
    	<tr><td>{upBtnFunction4}</td><td>&lt;c:set var="cntSiteId" value="&lt;%= siteId %>"/></td><td></td></tr>
    	<tr><td>{upBtnFunction5}</td><td>&lt;c:url value="/cms/sub11/0101upview.do?cntId=&#36;{cntCntId}&siteId=&#36;{cntSiteId}"/></td><td></td></tr>
    	<tr><td>{upBtnCifFunction1}</td><td>&lt;c:if test="&#36;{login.typeVO.typeLv == 'A' || (admId == login.mbrId) || (admId2 == login.mbrId) && login.mbrId != null && !empty admId && !empty admId2 }"></td><td></td></tr>
    	<tr><td>{upBtnCifEnd1}</td><td>&lt;/c:if></td><td></td></tr>
	</c:if>
	
	</table>    
	</c:if>
</div>

<div id="modal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	</div>
	<div class="modal-body">
		
	</div>
	<div class="modal-footer">
		<span id="addBtn"></span>
    	<button class="btn btn-small" data-dismiss="modal" aria-hidden="true">닫기</button>	    
	</div>	
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>