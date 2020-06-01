<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header_skeleton.jsp" %>
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script src="<c:url value="/resources/js/jquery.form.js"/> "></script>
<script type="text/javaScript" language="javascript" defer="defer">

$(document).ready(function(){
	$('input[type=checkbox],input[type=radio],input[type=file]').uniform();
	$('select[class!="noSelect2"]').select2();
    $('.colorpicker').colorpicker();
    $('.datepicker').datepicker();
});
// <!--
/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsmenuVO");
	frm.action = "<c:url value='/cms/sub6/0101editDetail.do'/>";
	
	$("form#jnitcmsmenuVO").ajaxSubmit({
		success:function(data){			
	    	$("div#attrEditor").html(data);
	    	alert("적용되었습니다");
	    }
	});
	
	/*
	$.ajax({
		  type: "POST",
		  url: frm.action,
		  data: $("form#jnitcmsmenuVO").serialize(),
		  success:function(data) {
			$("div#attrEditor").html(data);
		  },
		  error:function(result) {
			//alert(result);
		  }
	});
	return false;
	*/
    
}

function fn_edit(cntId) {
	var msg = window.open('<c:url value="/cms/sub7/0101upview.do?cntId="/>'+cntId,'editWindow','width=1000,height=850,scrollbars=yes,resizable=yes');
}

function fn_save() {
	var msg = fn_egov_save();
}

function open_mbrSearch() {
	if($("div#mbrSearch").css("display") == "none") {
		$("div#mbrSearch").show();
		$('#myModal').modal('toggle');
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
		$('#myModal').modal('toggle');
	}
}

$(document).ready(function(){
	
	<c:if test="${success == 'true'}">
	reloadDanaTree();
	</c:if>
	
	<c:if test="${jnitcmsmenuVO.islink == 1}">
	$('table#linkOpt').show();
	</c:if>
	
	<c:if test="${jnitcmsmenuVO.iscnt == 0}">
		$('input#menuPath').alphanumeric();
		//$('input#sitePath').css('ime-mode', 'enabled');
		$('input#menuPath').live("blur keyup", function() {
		  if($(this).val().search(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/) > -1) {
			$('input#menuPath').val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '') );
			$('span#menuPathMsg').html("폴더명은 영문/숫자만 입력가능합니다.").fadeIn('slow').fadeTo(3000,0);
		  }
		});
	</c:if>
	$('div.view').css('height',$(window).height()-$('ul.view_content_btn').height()-13);
});

var linkUrlOptOpen = function() {
	var node = getActNode();
	var childNodeCount = 0;
	try{
		childNodeCount = node.childList.length;
	}catch(e) {
		//
	}
	if(childNodeCount > 0) {
		alert("하위메뉴가 존재하므로, 링크URL을 사용할 수 없습니다.");
		$('input#islink1').attr("checked", true);
		return false;
	}
	$('table#linkOpt').show();
}
var linkUrlOptClose = function() {
	$('table#linkOpt').hide();
}

var editContent = function() {
	alert('준비중');
}

$('#myModal').on('hide', function () {
	$("div#mbrSearch").hide();
	});
// -->
$(document).ready(function(){
	var cclYn = "${cclVal}";
	
	if(cclYn == '0'){
		$('.cclSelectView').hide();
		$("[id*='cclChange']").attr('checked', false);
		$("[id*='cclProfit']").attr('checked', false);
	}
	$('#cclYn0').click(function(){
		$('.cclSelectView').hide();
		$('.cclSelectView').hide();
		$("[id*='cclChange']").attr('checked', false);
		$("[id*='cclProfit']").attr('checked', false);
	});
	$('#cclYn1').click(function(){
		$("[id*='cclChange']").parent().removeClass();
		$("[id*='cclProfit']").parent().removeClass();
		$("#cclChange0").parent().addClass('checked');
		$("#cclChange0").attr('checked', true);
		$("#cclProfit0").parent().addClass('checked');
		$("#cclProfit0").attr('checked', true);
		$('.cclSelectView').show();
	});
});

function initDanaCopyTree(){
	 // --- Initialize first Dynatree -------------------------------------------
	 $("#modalBody").dynatree({
	   initAjax: {
	     url: "<c:url value="/cms/sub6/0101getModalJson.do"/>"
	   },
	   autoCollapse: false,
	   clickFolderMode: 1,
	   persist: true,
	   onActivate: function(node) {
	     $("#echoActivated").text(node.data.title + ", key=" + node.data.key);
	   },
	   onClick: function(node, event) {
	     // Close menu on click
	     if(node.data.isFolder == true) {
//	   	  return false;
	     }
	     if( $(".contextMenu:visible").length > 0 ){
	       $(".contextMenu").hide();
//	       return false;
	     }
	     $("#copyMenu").val(loadEditorCopyForm(node));
	     $("#copyMenuCopy").val(loadEditorCopyForm(node));
	   }
	 });
}

var loadEditorCopyForm = function(node) {
	return node.data.menuid;	
}
function fn_adm_cancel(){
	if(confirm("정말 관리자 등록 취소하겠습니까")){
		frm = document.getElementById("jnitcmsmenuVO");
		frm.action ="<c:url value='/cms/sub6/adm/cancel.do'/>";
		$("form#jnitcmsmenuVO").ajaxSubmit({
			success:function(data){				
		    	$("div#attrEditor").html(data);
		    }
		});	
	}	
}

$(document).ready(function(){
	$("#menuShow").click(function(e){
		e.preventDefault();
		
		var originMenu = $("#menuId").val();
		var originPid = $("#pid").val();
		
		$("#originMenuCopy").val(originMenu);
		$("#originPidCopy").val(originPid);
		
		initDanaCopyTree();
		$('#menuModal').modal({keyboard: false}, {backdrop: false},'show');
	});
	$("#menuChoice").click(function(e){
		e.preventDefault();
		
		<%--
		var originMenu =  $("#originMenu").val();
		var copyNm = $("#copyNm").val();
		--%>
		var copyMenu = $("#copyMenu").val();
		if(copyMenu == null || copyMenu == ''){
			alert("복사할 폴더를 선택해 주세요.");
			return false;
		}
		$('#menuModal').modal('hide');
		$("#copyCnt").submit();
		//location.href="<c:url value="/cms/sub7/cntCopy.do"/>?originMenu="+originMenu+"&copyMenu="+copyMenu+"&copyNm="+copyNm;
	});
});
</script>

<style>
	table.content2_table th{text-align:left;padding-left:8px;}
	table.content2_table td{padding-left:10px;}
	table.content2_table table td{padding-left:0;}
</style>

			<%-- Contents Start --%>
			<form:form commandName="jnitcmsmenuVO"  onsubmit="return fn_egov_save();" enctype="multipart/form-data">
			<form:hidden path="menuId" />
			<form:hidden path="iscnt" />
			<form:hidden path="pid" />
			<form:hidden path="cntId" />
			<form:hidden path="admMbrId" />
			<form:hidden path="menuImgFile" />
			<form:hidden path="menuImgPath" />
			<input type="hidden" name="admNm" id="admNm" />
			<input type="hidden" name="admTel" id="admTel" />
			<c:if test="${jnitcmsmenuVO.iscnt == 1}">
				<form:hidden path="tplId" />
			</c:if>
			<input type="hidden" id="originMenu" name="originMenu"/>
			<input type="hidden" id="originPid" name="originPid"/>
			<input type="hidden" id="copyMenu" name="copyMenu"/>
			<input type="hidden" id="copyPid" name="copyPid"/>
			<div class="content_btn">
			    <a href="javascript:fn_save();" class=" btn btn-small"><i class="icon-ok-sign"></i><span>적용</span></a>
			    <c:if test="${jnitcmsmenuVO.iscnt == 1}">
			        <a href="javascript:fn_edit('${jnitcmsmenuVO.cntId}');" class="btn btn-small"><i class="icon-wrench"></i><span>콘텐츠 수정</span></a>
			        <a href="<c:url value='${previewUrl}'/>" target="_blank" class="btn btn-small pull-right" ><i class="icon-share-alt"></i><span>콘텐츠 미리보기</span></a>
			        <a href="#" id="menuShow" class="btn btn-small"><i class="icon-plus"></i><span>콘텐츠 복사</span></a>
		        </c:if>
		    </div>
		    <div class="content_in"> 
				<table border="0" cellspacing="0" cellpadding="0" class="table content2_table" style="border:0;">
				<!--tr>
				<td width="32%" align="right"><font color="red">*</font> 유형 : </td>
				<td width="68%" align="left" class="content_1">
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				<td width="6%"><input name="radio1" type="radio" id="radio1" value="radio" checked="checked" /></td>
				<td width="44%">구조메뉴</td>
				<td width="6%"><input type="radio" name="radio" id="radio" value="radio" /></td>
				<td width="44%">콘텐츠메뉴</td>
				</tr>
				</table>
				
				
				</td>
				</tr-->
				    <tr>
				    	<th> 메뉴ID </th>
				    </tr>
				    <tr>
				    	<td>&nbsp; <c:out value="${jnitcmsmenuVO.menuId}"/></td>
				    </tr>
				    <tr>
				    	<th><font color="red">*</font> 타이틀</th>
				    </tr>
				    <tr>
				        <td>
				            <table border="0" class="content2_table" cellspacing="0" cellpadding="0" style="border:0;">
				                <tr>
				                    <td style="border:0;"><form:input path="menuNm" cssClass="txt" />
				                    &nbsp;<form:errors path="menuNm" />
				                    &nbsp;</td>
				                </tr>
				                <tr>
				                	<td style="border:0;">페이지 내비게이션과 동일하게 사용됨.</td>
				                </tr>
				            </table>
				        </td>
				    </tr>
				    <c:if test="${jnitcmsmenuVO.iscnt == 1}">
				        <tr>
				        	<th> 타이틀 이미지</th>
				        </tr>
				        <tr>
				            <td style="">
				                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
				                    <tr>
				                   		<td>
						                	<input type="file" name="menuImg">
				                   		</td>
				                    </tr>
				                    <tr>
				                    	<td style="border:0;">이미지를 등록하시면, 템플릿에서 타이틀 이미지가 표시됩니다.</td>
				                    </tr>
				                </table>
				            </td>
				        </tr>
				        <tr>
				        	<th> 기본 페이지 설정</th>
				        </tr>
				        <tr>
				            <td style="">
				                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
				                    <tr>
				                        <td style="border:0;">
				                            <input type="radio" name="isDefaultPage" value="1" id="isDefaultPage1" <c:out value="${isDefaultPage == true ? 'checked' : ''}"/>> <label for="isDefaultPage1">예</label>
				                            <input type="radio" name="isDefaultPage" value="0" id="isDefaultPage0" <c:out value="${isDefaultPage == false ? 'checked' : ''}"/>> <label for="isDefaultPage0">아니오</label>
				                        </td>
				                    </tr>
				                    <tr>
				                    	<td style="border:0;">기본페이지로 설정하시면, 상위메뉴접근시 본 페이지를 첫페이지로 사용합니다.</td>
				                    </tr>
				                </table>
				            </td>
				        </tr>
				        <tr>
				        	<th> CCL(Creative Commons License) 설정</th>
				        </tr>
				        <tr>
				            <td style="">
				                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border:0;">
				                    <tr>
				                    	<th id="cclYnTr">CCL 사용 여부</th>
				                    </tr>
				                    <tr>
				                        <td style="border:0;">
				                        	<input type="radio" id="cclYn1" name="cclYn" value="1" <c:out value="${fn:substring(cclVal,0,1) == 1 ? 'checked' : ''}"/>><label for="cclYn1">예</label>
				                        	<input type="radio" id="cclYn0" name="cclYn" value="0" <c:out value="${fn:substring(cclVal,0,1) == 0 ? 'checked' : ''}"/>><label for="cclYn0">아니요</label>
				                        </td>
									</tr>
									<tr class="cclSelectView">
				                        <th>저작물 변경을 허락합니까?</th>
									</tr>
									<tr class="cclSelectView">
				                        <td>
				                        	<input type="radio" id="cclChange1" name="cclChange" value="1" <c:out value="${fn:substring(cclVal,1,2) == 1 ? 'checked' : ''}"/>><label for="cclChange1">예</label>
				                        	<input type="radio" id="cclChange0" name="cclChange" value="0" <c:out value="${fn:substring(cclVal,1,2) == 0 ? 'checked' : ''}"/>><label for="cclChange0">아니요</label>
				                        	<input type="radio" id="cclChange2" name="cclChange" value="2" <c:out value="${fn:substring(cclVal,1,2) == 2 ? 'checked' : ''}"/>><label for="cclChange2">예, 단 동일한 라이선스 적용</label>
				                        </td>
									</tr>
									<tr class="cclSelectView">
				                        <th>영리 목적을 허락합니까?</th>
									</tr>
									<tr class="cclSelectView">
				                        <td>
				                        	<input type="radio" id="cclProfit1" name="cclProfit" value="1" <c:out value="${fn:substring(cclVal,2,3) == 1 ? 'checked' : ''}"/>><label for="cclProfit1">예</label>
				                        	<input type="radio" id="cclProfit0" name="cclProfit" value="0" <c:out value="${fn:substring(cclVal,2,3) == 0 ? 'checked' : ''}"/>><label for="cclProfit0">아니요</label>
				                        </td>
				                    </tr>
				                </table>
				            </td>
				        </tr>
				    </c:if>
				    <tr>
				    	<th><font color="red">*</font> <c:if test="${jnitcmsmenuVO.iscnt == 0}">폴더</c:if><c:if test="${jnitcmsmenuVO.iscnt == 1}">콘텐츠 경로</c:if>명</th>
				    </tr>
				    <tr>
				        <td><form:input path="menuPath" cssClass="txt"/>
				        &nbsp;<form:errors path="menuPath" /><span id="menuPathMsg"></span></td>
				    </tr>
				    <c:if test="${jnitcmsmenuVO.iscnt == 0}">
				    <tr>
				    	<th><font color="red">*</font> 콘텐츠 기본 템플릿 선택</th>
				    </tr>
				    <tr>
				        <td>
				            <form:select path="tplId" id="tplId" title="서브템플릿">
				            <form:option value=" " label="--선택하세요--"/>
				            <form:options items="${tplId_result}" itemValue="code" itemLabel="codeNm"/>
				            </form:select>
				            &nbsp;<form:errors path="tplId" />
				        </td>
				    </tr>
				    </c:if>
				    <tr>
				    	<th><font color="red">*</font> <c:if test="${jnitcmsmenuVO.iscnt == 0}">콘텐츠 기본</c:if> 관리자 선택 <c:if test="${not empty jnitcmsmenuVO.admMbrId}"><a href="javascript:fn_adm_cancel();" class="btn btn-small" >취소</a></c:if></th>
				    </tr>
				    <tr>
				        <td>
				            <table border="0" cellspacing="0" cellpadding="0" class="content2_table" style="border:0;">
				                <tr>
				                    <td width="96%" style="border:0;"><span id="admMbrText" type="text" style="display:block; padding-left:1px; padding-top:2px; height:18px; border:1px #cccccc solid; width:100%;"><c:out value="${admMbrText}"/></span></td>
				                    <td width="4%" style="border:0;"><a href="javascript:open_mbrSearch();" target="_self" style="float:right; font-size:20px;" class="icon-search"></a></td>
				                </tr>
				            </table>
				        </td>
				    </tr>
				    <c:if test="${jnitcmsmenuVO.iscnt == 0}">
				        <tr>
				        	<th><font color="red">*</font> 링크URL 사용</th>
				        </tr>
				        <tr>
				            <td style="border:0;">
				                <input onclick="linkUrlOptOpen();" type="radio" id="islink0" name="islink" value="1" <c:out value="${jnitcmsmenuVO.islink == 1 ? 'checked' : ''}"/> /><label for="islink0">사용</label>
				                <input onclick="linkUrlOptClose();" type="radio" id="islink1" name="islink" value="0" <c:out value="${jnitcmsmenuVO.islink == 0 ? 'checked' : ''}"/> /><label for="islink1">사용안함</label>
				                &nbsp;<form:errors path="islink" />
				            </td>
				        </tr>
				    </c:if>
				</table>
				
				
				
				<c:if test="${jnitcmsmenuVO.iscnt == 0}">
					<table id="linkOpt" border="0" cellspacing="0" cellpadding="0" class="content2_table" style="border:0; display:none;">
				        <tr>
				            <td style="border:0;"><strong style="color:#990000;">링크URL 사용시 하위메뉴 또는 콘텐츠 사용이 제한되오니, 유의하시기 바랍니다.</strong></td>
				        </tr>
				        <tr>
				        	<th><font color="red">*</font> 링크URL</th>
				        </tr>
				        <tr>
				            <td>
				                <form:input path="linkurl" style="width:99%;" /><br />
				                &nbsp;
				                    <table border="0" cellspacing="0" cellpadding="0" class="content2_table" style="margin:5px 0;">
				                        <thead>
				                            <tr>
				                            	<th>설명</th>
				                            </tr>
				                        </thead>
				                        <tbody>
				                            <tr>
				                            	<td>1. http:// 로 시작하면 외부링크</td>
				                            </tr>
				                            <tr>
				                            	<td>2. http:// 가 없이 시작하면 내부링크</td>
				                            </tr>
				                        </tbody>
				                    </table>
				                &nbsp;<form:errors path="linkurl" />
				            </td>
				        </tr>
				        
				        
				        
				        <tr>
				        	<th><font color="red">*</font> 링크타겟</th>
				        </tr>
				        <tr>
				            <td>
				                <form:input path="linktgt" style="width:99%;" /><br />
				                &nbsp;
				                    <table border="0" cellspacing="0" cellpadding="0" class="content2_table" style="margin:5px 0;">
				                        <thead>
				                            <tr>
				                                <th>코드(옵션)</th>
				                                <th>설명</th>
				                        	</tr>
				                        </thead>
				                        <tbody>
				                            <tr>
				                                <td>self</td>
				                                <td>같은 창에서 링크</td>
				                            </tr>
				                            <tr>
				                                <td>new</td>
				                                <td>새 창으로 링크</td>
				                            </tr>
				                            <tr>
				                                <td>pop(x:y:width:height)</td>
				                                <td>팝업 창으로 링크<br /><br />
				                                    - x:팝업시작위치 좌측<br />
				                                    - y:팝업시작위치 상단<br />
				                                    - width:팝업 가로크기<br />
				                                    - height:팝업 세로크기<br />
				                                </td>
				                            </tr>
				                        </tbody>
				                    </table>
				                &nbsp;<form:errors path="linktgt" />
				            </td>
				        </tr>
				    </table>
				</c:if>
			</div>
			</form:form>
				<%-- Contents End --%>
			<!-- Modal -->
		<div id="menuModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel" style="text-align: center;">컨텐츠를 복사할 폴더를 클릭하고 <strong style="color: blue;">"선택"</strong>을 눌러주세요.</h3>
			</div>
			<div class="modal-body">
				  <div id="modalBody"></div>
			</div>
			<div class="modal-footer">
				<form id="copyCnt" action="<c:url value="/cms/sub7/cntCopy.do"/>" method="post">
					<input type="hidden" id="originMenuCopy" name="originMenuCopy"/>
					<input type="hidden" id="originPidCopy" name="originPidCopy"/>
					<input type="hidden" id="copyMenuCopy" name="copyMenuCopy"/>
					<strong style="float: left; margin-top: 4px;">복사할 컨텐츠 명 변경: </strong>&nbsp;<input type="text" id="copyNmCopy" name="copyNmCopy" style="float: left; width: 200px; margin-left: 5px;" />
					<button class="btn btn-primary" id="menuChoice">선택</button>
					<button class="btn btn-danger" data-dismiss="modal">닫기</button>
				</form>
			</div>
		</div>
		<%@ include file="/WEB-INF/jsp/jnit/_common/footer_skeleton.jsp" %>