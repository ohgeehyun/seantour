<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>


<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitcmstplVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javascript">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmstplVO").action = "<c:url value='/cms/sub4/0102.do'/>";
   	document.getElementById("jnitcmstplVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitcmstplVO").action = "<c:url value='/cms/sub4/010201del.do'/>";
   	document.getElementById("jnitcmstplVO").submit();		
}

function fn_egov_save_bln(){
	var tplNm = $("#tplNm").val();	
	if(tplNm == null || tplNm == ''){
		alert("제목을 입력해 주시기 바랍니다.");
		$("#tplNm").focus();
		return false;
	}
	
	if(CodeEditor.getValue().indexOf('{-CONTENT-}') == -1){
		alert("콘텐츠노출영역 {-CONTENT-}코드가 없습니다.\n\n콘텐츠노출영역코드가 없으면 실제 콘텐츠에 템플릿이 반영되지 않습니다.");
		return false;
	}

	if(CodeEditor.getValue().indexOf('{-CONFIG_CSS-}') == -1){
		alert("{-CONFIG_CSS-}코드가 없습니다.");
		return false;
	}

	if(CodeEditor.getValue().indexOf('{-CONFIG_JS-}') == -1){
		alert("{-CONFIG_JS-}코드가 없습니다.");
		return false;
	}
	
	return true;
}

/* 글 등록 function */
function fn_egov_save() {
	if(fn_egov_save_bln()){ //null check
		frm = document.getElementById("jnitcmstplVO");

	        /* ClientSite Validator */
		//if(!validateJnitcmstplVO(frm)){
		//		return;
		//}

	    if($(frm.tplSrc).val().search('{-CONTENT-}') == -1) {
	        alert("콘텐츠노출영역 {-CONTENT-}코드가 없습니다.\n\n콘텐츠노출영역코드가 없으면 실제 콘텐츠에 템플릿이 반영되지 않습니다.");
	    }
	
	    if($("span.cm-tag:contains('%@')").next(":contains('include')").size() > 0 || $("span.cm-tag:contains('%@include')").size() > 0) {
	    	alert("include시 <"+"jsp:include page=''/> Tag를 이용해주세요.");
	    	return;
	    }else {
	        if($(frm.tplSrc).val().search('@ include|@include') != -1) {
	            alert("include시 <"+"jsp:include page=''/> Tag를 이용해주세요.");
	        }    	
	    }
	
		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/sub4/010201up.do'/>";
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/sub4/010201add.do'/>";
		</c:if>
	    frm.submit();	
	}
}

function fn_egov_play(){
	$(document).ready(function(){
		$("form[id='jnitcmstplVO']").attr("action", "/cms/play/proc.do");
		$("form[id='jnitcmstplVO']").submit();
	});
}

function resizeEditor() {
	$('div.view').css('overflow', 'hidden');
	$('div.tplSrcBox').css('padding-top', 10);
	$('div.tplSrcBox').css('padding-left', 10);
	$('textarea[name=cntSrc]').css('height', $(window).height()-270);
	$('.CodeMirror').css('width', $(window).width()-300 );
	$('.CodeMirror').css('height', $(window).height()-500 );
	$('.CodeMirror-scroll').css('height', $(window).height()-500 );
	$('.CodeMirror-scrollbar').css('height', $(window).height()-500 );
}

function fn_egov_hist(){
	$.ajax({
		type:"post",
		url:"<c:url value='/cms/ajax/tpl/hist/list.do'/>",
		data: "tplId="+$("#tplId").val()
	}).done(function(data){		
		$("#histList").empty();
		$("#histList").append(data);
		$('#myModal').modal('toggle');
	});
}

//삭제
function Jnit_delete(){
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			type:"post",
			url:"<c:url value='/sub4/ajax/delete.do'/>",
			data:$("#jnitcmstplVO").serialize()
		}).done(function(data){			
			var json = $.parseJSON(data);
			if(json.status == 'success'){
				alert("정상처리 되었습니다.");
				location.href = "<c:url value='/cms/sub4/0102.do'/>";
			}else{
				if(json.code != ''){
					var tplNm = $("#tplNm").val();
					if(json.code == 'FAIL 1'){
						alert("데이터가 올바르게 전송하지 못했습니다.");
					}else if(json.code == 'FAIL 2') {
						alert("삭제 할 수 없습니다. \n메뉴/콘텐츠관리에서 "+(tplNm == '' ? '서브템플릿' : tplNm)+"을 참조하고있습니다.");
					}else if(json.code == 'FAIL 3'){
						alert("회원관련 템플릿에서 "+(tplNm == '' ? '서브템플릿' : tplNm)+"을 참조하고있습니다.");
					}else if(json.code == 'FAIL 4') {
						alert("삭제에 오류가 생겨 삭제 하지못했습니다.");
					}else {
						alert("삭제 할 수 없습니다.");
					}
				}
			}
		});
	}
}

$(document).ready(function(){
	resizeEditor();
	$(window).bind('resize', resizeEditor);
	
	
	
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
	
	/*
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
	*/
	var includeError = "${includeError}";
	if(includeError != "") alert(includeError);
});

// -->
</script>
<c:if test="${registerFlag == '수정'}">
	<input type="hidden" name="screenMode" value="up" />
</c:if>
<c:if test="${registerFlag == '등록'}">
	<input type="hidden" name="screenMode" value="" />
</c:if>


<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		
		<form:form commandName="jnitcmstplVO">
		<input type="hidden" name="siteId" value="<c:out value="${searchVO.siteId}" />" />
		<input type="hidden" name="sitePath" value="<c:out value="${searchVO.sitePath}" />" />
		<input type="hidden" name="tplId" id="tplId" value="<c:out value="${jnitcmstplVO.tplId}" />" />		
		<div class="widget-box">
			<div class="widget-title">
    	   		<h3>서브템플릿 등록</h3>
    	   		<a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
		    	<a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 저장</a>
		    	<%-- <a href="javascript:fn_egov_play();" class="btn btn-small"><i class="icon-ok-sign"></i> 실적용</a> --%>
		    	&nbsp;&nbsp;<a href="javascript:fn_egov_hist();" class="btn btn-small"><i class="icon-book"></i> 히스토리</a>
		    	<a href="javascript:Jnit_delete();" class="btn btn-small btn-del" style="float:right; margin-right: 10px;"><i class="icon-minus-sign"></i> 삭제</a>
		    	 
       	    </div>
			<div class="widget-content nopadding">
			    <table class="table table-bordered" summary="서브템플릿 등록">
			        <tbody>
			            <tr>
			                <th>템플릿명</th>
			                <td width="89%">
			                <form:input path="tplNm" id="tplNm" style="width:99%;"/>
			                <form:errors path="tplNm" /></td>
			            </tr>
			            <tr>
			                <th>템플릿 설명</th>
			                <td width="89%">
			                <form:input path="tplDesc" style="width:99%;"/>
			                <form:errors path="tplDesc" /></td>
			            </tr>
			           <c:if test="${!empty codeList }">
			           	<tr>
			           		<th>적용되지않는 리스트</th>
			           		<td>
				                <font color="red"><c:out value="${codeList }"/></font>
				                <input type="hidden" name="codeList" id="codeList" value="<c:out value="${codeList }"/>" />
			           		</td>
			            </tr>    
		                </c:if>		                
		                <c:if test="${!empty includeErrorList }">
		                <tr>
		                	<th>서브템플릿 사용안함으로 변경된 리스트</th>
		                	<td>
			                	<font color="red"><c:out value="${includeErrorList }"/></font>
			                </td>
			            </tr>   	                
		                </c:if> 
		                <tr>
				        	<th>퀵 코드삽입</th>
				        	<td><%@ include file="/WEB-INF/jsp/jnit/cms/disseminate/help_code_button.jsp" %></td>
				        </tr>
			        </tbody>
			    </table>
			    
			    <div class="tplSrcBox">
					<p><strong>ㆍ ${jnitcmstplVO.tplNm} 소스
				   		<c:if test="${newFileCnt == 'Y'}"><span style="color:red;">(서버에서 변경된 페이지입니다)</span></c:if>
				   		<c:if test="${notFileCnt == 'Y'}"><span style="color:red;">(파일이 없습니다)</span></c:if>
					</strong><button id="upView" class="btn btn-small">▼</button> <button id="downView" class="btn btn-small">▲</button></p>
				    <form:textarea path="tplSrc" rows="30" style="width:100%" escape="false"/><br />
				    <form:errors path="tplSrc" />
			    </div>			   
			</div>	
		</div>
		
		<!-- 검색조건 유지 -->
		<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
		<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form:form>
		<table class="table table-bordered table-striped th_left">
			<tr>
				<th style="text-align: center;">템플릿 아이템 코드</th>
			</tr>
			<tr>
				<td>
					<table class="table table-bordered table-striped th_left">
						<tr>
							<th>{-CONTENT-}</th>
							<td>콘텐츠노출영역</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<th style="text-align: center;">콘텐츠 아이템 코드 / 필수코드는 <font color="red">빨강색</font>입니다.</th>
			</tr>
			<tr>
				<td>
					<table class="table table-bordered table-striped th_left">						
						<tr>			
						  	<th><strong>{-CONFIG_CSS-}</strong></th>
						  	<td>CSS 파일 호출 코드</td>
						</tr>
						<tr>
						  	<th><strong>{-CONFIG_JS-}</strong></th>
						  	<td>JS 파일 호출 코드</td>
						</tr>
						<tr>
							<th>{-PAGETITLE-}</th>
							<td>콘텐츠페이지 제목 텍스트 표시</td>
						</tr>
						<tr>
							<th>{-SUBTITLE-}</th>
							<td>콘텐츠 부제목 텍스트 표시</td>
						</tr>
						<tr>
							<th>{-PAGEIMGTITLE-}</th>
							<td>콘텐츠페이지 제목 이미지 HTML 표시</td>
						</tr>
						<tr>
							<th>{-PAGENAV-}</th>
							<td>콘텐츠페이지 네비게이션 텍스트 표시</td>
						</tr>
						<tr>
							<th>{-PAGELINKNAV-}</th>
							<td>콘텐츠페이지 링크 네비게이션 HTML 표시</td>
						</tr>
						<tr>
 		                	<th>{-PAGENAVTITLE-}</th>
 		                	<td>상위에서 하위메뉴까지의 텍스트 표시</td>
 	           		    </tr>
						<tr>
							<th>{-CCL_LINK-}</th>
							<td>CCL 링크주소</td>
						</tr>
						<tr>
							<th>{-CCL_GENERAL_IMG-}</th>
							<td>CCL 이미지</td>
						</tr>
						<tr>
							<th>{-CCL_ALT-}</th>
							<td>CCL 이미지 설명글</td>
						</tr>
						<tr>
							<th>{-CCL_KEYWORD-}</th>
							<td>CCL 라이센스 내역</td>
						</tr>
						<tr>
							<th>{-CCL_TEXT-}</th>
							<td>CCL 설명글</td>
						</tr>
						<tr>			
						  	<th>{-STATE-} / {-STATE_TOTAL-} / {-STATE_TODAY-} / {-STATE_YESTERDAY-}</th> 
						  	<td>사이트별 통계 호출 코드 / 총 접속자 수 / 오늘 접속자 수 / 어제 접속자 수</td> 
						</tr>
						<tr>
							<th>
								&lt;jsp:include page="/make/allim/allim/html/알리미코드.jsp" flush="false" &gt;&lt;/jsp:include&gt;								
							</th>
							<td>알리미 기본 삽입형식</td>
						</tr>
						<tr>
							<th>
								&lt;jsp:include page="/make/allim/banner/html/배너코드.jsp?bannerMorePath=더보기 경로" flush="false" &gt;&lt;/jsp:include&gt;								
							</th>
							<td>배너 삽입형식</td>
						</tr>
						<tr>
							<th>
								&lt;jsp:include page="/make/allim/popup/html/팝업코드.jsp" flush="false" &gt;&lt;/jsp:include&gt;								
							</th>
							<td>팝업 삽입형식</td>
						</tr>
						<tr>
							<th>
								&lt;c:import url="/menu/getTopMenu.do"&gt;<br />
								&lt;c:param name="target" value="[탑메뉴 명칭]" /&gt;<br />
								&lt;c:param name="menuNm" value="[출력할 메뉴 명칭]" /&gt;<br />
								&lt;c:param name="depth" value="[출력할 뎁스]" /&gt;<br />
								&lt;c:param name="order" value="[class 순서 ex: 0]" /&gt;<br />
								&lt;/c:import&gt;
							</th>
							<td>
								target : 탑메뉴 명칭 ex) sample<br />
								menuNm : 출력할 메뉴 이름 ( 1뎁스 )<br />
								depth : 출력하고 싶은 뎁스 입력 ex) 3<br />
								order : class 순서 ex : 0
							</td>
						</tr>
						<tr>
							<th>
								&lt;script type="text/javascript"&gt;<br />
			                	&lt;!--<br />
			                      $(document).ready(function(){<br />
			                      var location = $(document.location).attr('href');<br />
			                          var title = $("h3").text();<br />
			                          $(".txtQrcode").html("오른쪽 QR Code 이미지를 스마트폰에 인식시키면 자동으로 이 페이지로 연결됩니다.&lt;br /&gt;"<br />
			                          +" 이 QR Code는 &lt;strong&gt;"+title+"&lt;/strong&gt; 페이지의 정보를 담고 있습니다.");<br />
			                          $("#qrCode").attr("alt","스마트폰으로 찍으면 현재 페이지("+title+" "+location+") 으로 연결되는 QR코드");<br />
			                          
			                          $("#qrCodeZoom").attr("alt","스마트폰으로 찍으면 현재 페이지("+title+" "+location+") 으로 연결되는 QR코드");<br />
			                      });<br />
			                      var zoomQr = function(){<br />
			                        if($('div.qrZoom').css('display') == 'none') {<br />
			                            $('div.qrZoom').fadeIn();<br />
			                        }else {<br />
			                            $('div.qrZoom').fadeOut();<br />
			                        }<br />
			                    }<br />
			                    // --&gt;<br />
			                    &lt;/script&gt;<br />
			                    &lt;p class="qr_title"&gt;QR CODE&lt;/p&gt;<br />
			                    &lt;p class="txtQrcode"&gt;오른쪽 QR Code 이미지를 스마트폰에 인식시키면 자동으로 이 페이지로 연결됩니다.&lt;br /&gt;<br />
			                    이 QR Code는 &lt;strong&gt;현재 페이지&lt;/strong&gt; 의 정보를 담고 있습니다.&lt;/p&gt;<br />
			                  	&lt;a href="javascript:zoomQr();"&gt;<br />
			                  		&lt;img id="qrCode" src="${pageContext.request.contextPath }/qr/mini/make.do?w=100&amp;h=100" alt="현재페이지로 연결되는 QR코드" /&gt;
			                  	&lt;/a&gt;<br />
			                  	&lt;div class="qrZoom" style="text-align:right; display:none;"&gt;<br />
			                        &lt;a href="javascript:zoomQr();"&gt;<br />
			                        	&lt;img id="qrCodeZoom" src="${pageContext.request.contextPath }/qr/mini/make.do?w=200&amp;h=200" alt="현재페이지로 연결되는 QR코드" /&gt;
			                        &lt;/a&gt;<br />
			                    &lt;/div&gt;
							</th>
							<td>QR코드</td>
						</tr>
						<tr>
							<th>
								&lt;jsp:include page="/cms/import/getSubMenu.jsp"&gt;&lt;/jsp:include&gt;
							</th>
							<td>레프트 메뉴</td>
						</tr>
						<tr>
							<th>
								&lt;jsp:include page="/cms/import/rscPage.jsp"&gt;&lt;/jsp:include&gt;
							</th>
							<td>페이지 평가</td>
						</tr>
						<tr>
							<th>
								&lt;jsp:include page="/cms/import/사이트경로_content_admin.jsp"&gt;&lt;/jsp:include&gt; 
							</th>
							<td>담당자 지정</td>
						</tr>
						<tr>
							<th>
								&lt;jsp:include page="/cms/import/{-SITEPATH-}_updateButton.jsp"&gt;&lt;/jsp:include&gt;
							</th>
							<td>콘텐츠 수정 <font>* 로그인템플릿,회원템플릿관련 페이지에서는 표출이 되지 않습니다.</font></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>
<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Modal header</h3>
  </div>
  <div class="modal-body">
    <div id="histList"></div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
    <!-- <button class="btn btn-primary">Save changes</button> -->
  </div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>


