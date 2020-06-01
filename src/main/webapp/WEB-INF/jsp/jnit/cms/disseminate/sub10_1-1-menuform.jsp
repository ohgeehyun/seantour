<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- BackOffice & site 팝업 공용 --%>
<%@ include file="/WEB-INF/jsp/jnit/cms/disseminate/common/menuContent2_Script.jsp" %>
<script type="text/javascript">
<!--
function fn_imgdel(){
	if(confirm("이미지를 삭제 하시겠습니까?")){
		$("#imgDel").val("true");
		fn_save();
	}
	
}
	$(".validator_a").attr("href", "http://validator.w3.org/check?uri="+window.location.protocol + "//" + window.location.host+"<c:url value="${directoryName }" />");
	$(".jigsaw_a").attr("href", "http://jigsaw.w3.org/css-validator/validator?uri="+window.location.protocol + "//" + window.location.host+"<c:url value="${directoryName}"/>");
	$(".w3c_a").attr("href", window.location.protocol + "//" + window.location.host+"/w3c/access/?url="+window.location.protocol + "//" + window.location.host+"<c:url value="${directoryName}"/>/");

	function Jnit_content_question(num){
		var baseId = "JnitContentQuestion"+num;
		var baseObject = $("#"+baseId);
		var displayState = baseObject.css("display");
		
		if(displayState == "none"){
			baseObject.show();
		}else{
			baseObject.hide();
		}
	}
	
	function Jnit_content_question(num){
		var baseId = "JnitContentQuestion"+num;
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
<%-- Contents Start --%>
<form:form commandName="jnitcmsmenuVO"  onsubmit="return fn_egov_save();" enctype="multipart/form-data">
	<form:hidden path="menuId" />
	<form:hidden path="iscnt" />
	<form:hidden path="pid" />
	<form:hidden path="cntId" id="cntId" />
	<%-- <form:hidden path="admMbrId" /> --%>
	<form:hidden path="menuImgFile" />
	<form:hidden path="menuImgPath" />
	<c:if test="${jnitcmsmenuVO.iscnt == 1}">
		<form:hidden path="tplId" />
	</c:if>
	<form:hidden path="depth" />
	<input type="hidden" id="originMenu" name="originMenu"/>
	<input type="hidden" id="originPid" name="originPid"/>
	<input type="hidden" id="copyMenu" name="copyMenu"/>
	<input type="hidden" id="copyPid" name="copyPid"/>
	<input type="hidden" id="copyDepth" name="copyDepth"/>
	<input type="hidden" id="imgDel" name="imgDel" value="false" />
	<%-- 웹표준검사 --%>
	<input type="hidden" name="host" id="host" />
	<input type="hidden" name="url" id="url" />
	<input type="hidden" name="type" id="type" />
	<div class="content_btn" style="background: none;">
		
		<c:if test="${jnitcmsmenuVO.iscnt == 1}">
			<div class="cont-edbtnwr">	
			<b>콘텐츠</b> <a href="javascript:fn_edit('${jnitcmsmenuVO.cntId}');" class="btn btn-small"><i class="icon-wrench"></i><span>수정</span></a>
			<a href="#" id="menuShow" class="btn btn-small"><i class="icon-plus"></i><span>복사</span></a>
			<a href="<c:url value='${previewUrl}'/>" target="_blank" class="btn btn-small "><i class="icon-share-alt"></i><span>바로가기</span></a>
			</div>
		</c:if>
		<c:if test="${jnitcmsmenuVO.iscnt == 0}">
			<div class="cont-edbtnwr">	
			<a href="javascript:Jnit_menuCopy();" class="btn btn-small"><i class="icon-plus"></i><span>메뉴 복사</span></a>
			</div>
		</c:if>
		<a href="javascript:fn_save();" class=" btn btn-small btn-warning" style="float:right;margin-right: 5px;"><i class="icon-ok-sign"></i><span>적용</span></a>
	</div>
	<div class="content_in"> 
		<table class="table table-bordered">				
			<tr>
				<th style="text-align:left; width: 135px;"> 메뉴ID </th>
				<td colspan="2"><c:out value="${jnitcmsmenuVO.menuId}"/></td>
			</tr>
			<c:if test="${jnitcmsmenuVO.iscnt == 1}"><c:set var="rowMenuImg" value="2"/></c:if>
			<tr>
				<th style="text-align:left;" rowspan="${empty rowMenuImg ? 1 : rowMenuImg  }"><font color="red">*</font> 타이틀</th>
				<td style="width: 100px;"><b>텍스트형</b>&nbsp;<a href="javascript:Jnit_content_question('1');"><i class="icon-question-sign"></i></a></td>
				<td>
					<form:input path="menuNm" id="menuNm" cssClass="txt" />
					&nbsp;<form:errors path="menuNm" />
					<br />- 텍스트형 노출시 치환코드는 {-PAGETITLE-}로 적용(기본)<br />- 페이지 내비게이션과 동일하게 사용됨.
					<br />
					<span id="JnitContentQuestion1" style="display: none;">
						<strong>&nbsp;- 서브 템플릿에서 적용할 수 있습니다.</strong><br /> 
						<strong>&nbsp;- (템플릿 관리 &gt; 서브 템플릿 리스트로 페이지 이동 링크)</strong>
					</span>
				</td>	    	
			</tr>
			<c:if test="${jnitcmsmenuVO.iscnt == 1}">
			<tr>
				<td><b>이미지형</b>&nbsp;<a href="javascript:Jnit_content_question('2');"><i class="icon-question-sign"></i></a></td>
				<td>
					<input type="file" name="menuImg">
					<c:if test="${jnitcmsmenuVO.menuImgOnm != '' && jnitcmsmenuVO.menuImgOnm != null}">
					<br />
						- ${jnitcmsmenuVO.menuImgOnm} 파일이 적용중 입니다. <span class="del"><a href="javascript:fn_imgdel();">삭제하기</a></span>
					</c:if>
					<br />- 이미지형 타이틀을 사용할 경우 서브템플릿에 {-PAGEIMGTITLE-} 치환코드로 변경해야 합니다.
					<br />- 이미지를 등록하시면, 템플릿에서 타이틀 이미지가 표시됩니다.
					<br />
					<span id="JnitContentQuestion2" style="display: none;">
						<strong>&nbsp;- 서브 템플릿에서 적용할 수 있습니다.</strong><br />
						<strong>&nbsp;- (템플릿 관리 &gt; 서브 템플릿 리스트로 페이지 이동 링크)</strong>
					</span>
				</td>
			</tr>
			</c:if>
			<tr>
				<th style="text-align:left;"><font color="red">*</font> 
					<c:if test="${jnitcmsmenuVO.iscnt == 0}">폴더</c:if>
					<c:if test="${jnitcmsmenuVO.iscnt == 1}">콘텐츠 경로</c:if>명
					&nbsp;<a href="javascript:Jnit_content_question('3');"><i class="icon-question-sign"></i></a>
				</th>
				<td colspan="2">
					<form:input path="menuPath" cssClass="txt"/>
					&nbsp;<form:errors path="menuPath" /><span id="menuPathMsg"></span>
					<br />
					<span id="JnitContentQuestion3" style="display: none;">
						<strong>&nbsp;- 숫자, 영어로만 구성해주세요. 실제 폴더 경로로 사용되는 이름입니다.</strong>
					</span>
				</td>
			</tr>			
			<c:if test="${jnitcmsmenuVO.iscnt == 0}">
			<tr>
				<th style="text-align:left;"><font color="red">*</font> 콘텐츠 기본 템플릿</th>
				<td colspan="2">
					<form:select path="tplId" id="tplId" title="서브템플릿">
		            <form:option value=" " label="--선택하세요--"/>
		            <form:options items="${tplId_result}" itemValue="code" itemLabel="codeNm"/>
		            </form:select>
		            <form:errors path="tplId" />	
				</td>
			</tr>			
			</c:if>						
			<tr>
				<th id="cclYnTr" rowspan="3" style="text-align:left;">메뉴 노출 여부</th>
				<td style="text-align:left;"><b>상단 메뉴</b>&nbsp;<a href="javascript:Jnit_content_question('4');"><i class="icon-question-sign"></i></a></td>
				<td>
					<input type="radio" id="hDel0" name="hDel" value="Y" <c:out value="${jnitcmsmenuVO.hDel == 'Y' ? 'checked' : ''}"/>><label for="hDel">노출</label>
					<input type="radio" id="hDel1" name="hDel" value="N" <c:out value="${jnitcmsmenuVO.hDel == 'N' ? 'checked' : ''}"/>><label for="hDel">비노출</label>
					<br />
					<span id="JnitContentQuestion4" style="display: none;">
						<strong>&nbsp;- 메뉴 노출 여부를 설정하실 수 있습니다.</strong> 
						<strong>&nbsp;- 관련 코드를 넣어주신 후 적용됩니다. + 코드 수정 페이지 링크</strong>
					</span>
				</td>
			</tr>             
			<tr>
				<td><b>레프트 메뉴</b>&nbsp;<a href="javascript:Jnit_content_question('5');"><i class="icon-question-sign"></i></a></td>
				<td>
					<input type="radio" id="lDel0" name="lDel" value="Y" <c:out value="${jnitcmsmenuVO.lDel == 'Y' ? 'checked' : ''}"/>><label for="lDel">노출</label>
					<input type="radio" id="lDel1" name="lDel" value="N" <c:out value="${jnitcmsmenuVO.lDel == 'N' ? 'checked' : ''}"/>><label for="lDel">비노출</label>
					<br />
					<span id="JnitContentQuestion5" style="display: none;">
						<strong>&nbsp;- 메뉴 노출 여부를 설정하실 수 있습니다.</strong> 
						<strong>&nbsp;- 관련 코드를 넣어주신 후 적용됩니다. + 코드 수정 페이지 링크</strong>
					</span>
				</td>			        	
			</tr>			
			<tr>
				<td><b>사이트맵</b>&nbsp;<a href="javascript:Jnit_content_question('6');"><i class="icon-question-sign"></i></a></td>
				<td>
					<input type="radio" id="sDel0" name="sDel" value="Y" <c:out value="${jnitcmsmenuVO.sDel == 'Y' ? 'checked' : ''}"/>><label for="sDel">노출</label>
					<input type="radio" id="sDel1" name="sDel" value="N" <c:out value="${jnitcmsmenuVO.sDel == 'N' ? 'checked' : ''}"/>><label for="sDel">비노출</label>
					<br />
					<span id="JnitContentQuestion6" style="display: none;">
						<strong>&nbsp;- 메뉴 노출 여부를 설정하실 수 있습니다.</strong> 
						<strong>&nbsp;- 관련 코드를 넣어주신 후 적용됩니다. + 코드 수정 페이지 링크</strong>
					</span>
				</td>        
			</tr>
			<c:if test="${jnitcmsmenuVO.iscnt == 0}">
			<tr>
				<th>강제 이동 URL</th>
				<td colspan="2">
					<form:input path="redirectUrl"/><br />
					- 입력란에 강제로 이동될 URL를 입력하실경우 무조건 해당페이지로 이동합니다.<br />
					- URL은 상대경로를 입력해 주셔야 합니다.<br />
					- 예시:이동될 URL이 "http://www.domain.co.kr/movie/index.jsp" 일경우 "/movie/index.jsp" 입력<br />
					- 입력란에 아무런 값을 넣치 않을경우 좌측메뉴에 가장 첫번째메뉴로 기본이동합니다.<br />
					&nbsp;&nbsp;(단,첫번째메뉴가 숨김처리 되어있을겨우 두번째메뉴로 이동됩니다.)
				</td>
			</tr>
			</c:if>			
			<!-- tr>
				<th style="text-align:left;" colspan="2">robot 검색 허용 설정 </th>
				<td>				                           				                            
					<input type="radio" name="robotYn" value="0" id="robotYn0" <c:out value="${jnitcmsmenuVO.robotYn == 0 ? 'checked' : ''}"/>><label for="robotYn0" >허용</label>
					<input type="radio" name="robotYn" value="1" id="robotYn1" <c:out value="${jnitcmsmenuVO.robotYn == 1 ? 'checked' : ''}"/>><label for="robotYn1">차단</label>
				</td>
			</tr -->			
			<c:if test="${jnitcmsmenuVO.iscnt == 1}">
			<tr style="display: none">
				<td>
					<input type="radio" id="cclYn1" name="cclYn" value="1" <c:out value="${fn:substring(cclVal,0,1) == 1 ? 'checked' : ''}"/>><label for="cclYn1">예</label>
					<input type="radio" id="cclYn0" name="cclYn" value="0" <c:out value="${fn:substring(cclVal,0,1) == 0 ? 'checked' : ''}"/>><label for="cclYn0">아니요</label>
				</td>
			</tr>
			<tr>		        		
				<th style="text-align:left;" rowspan="2"> CCL 설정</th>
				<td style="text-align:left;"><b>저작물변경</b></td>
				<td>
					<input type="radio" id="cclChange1" name="cclChange" value="1" <c:out value="${fn:substring(cclVal,1,2) == 1 ? 'checked' : ''}"/>><label for="cclChange1">예</label>
					<input type="radio" id="cclChange0" name="cclChange" value="0" <c:out value="${fn:substring(cclVal,1,2) == 0 ? 'checked' : ''}"/>><label for="cclChange0">아니요</label>
					<input type="radio" id="cclChange2" name="cclChange" value="2" <c:out value="${fn:substring(cclVal,1,2) == 2 ? 'checked' : ''}"/>><label for="cclChange2">예, 단 동일한 라이선스 적용</label>
				</td>           	
			</tr>			
			<tr>
				<td><b>영리목적허락</b></td>
				<td>
					<input type="radio" id="cclProfit1" name="cclProfit" value="1" <c:out value="${fn:substring(cclVal,2,3) == 1 ? 'checked' : ''}"/>><label for="cclProfit1">예</label>
					<input type="radio" id="cclProfit0" name="cclProfit" value="0" <c:out value="${fn:substring(cclVal,2,3) == 0 ? 'checked' : ''}"/>><label for="cclProfit0">아니요</label>
				</td>
			</tr>						        
			</c:if>
			<c:if test="${!empty cntVO }">
			<c:set var="webRoot" value="${fn:replace(pageContext.request.requestURL,pageContext.request.requestURI,'')}"/>
			<tr>
				<th rowspan="4" style="text-align:left;">
					웹 표준/접근성 평가
					&nbsp;<a href="javascript:Jnit_content_question('7');"><i class="icon-question-sign"></i></a>
				</th>
				<td><b>웹표준평가</b></td>
				<td>
					<c:if test="${cntVO.cntWebStandard == 0 }">
					<a href="#" class="btn btn-info btn-small"><c:out value="평가대기"/></a>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName }"/>','<c:out value="standard"/>');" class="btn btn-small">평가하기</a>
					</c:if>
					<c:if test="${cntVO.cntWebStandard == 1 }">
					<a href="#" class="btn btn-success btn-small"><c:out value="최종합격"/></a>
					</c:if>
					<c:if test="${cntVO.cntWebStandard == 2 }">
					<a href="http://validator.w3.org/check?uri=${webRoot }<c:url value="${directoryName }"/>" title="새창" target="_blank" class="btn btn-danger btn-small validator_a"><c:out value="-불 합 격-"/></a>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName }"/>','<c:out value="standard"/>');" class="btn btn-small">재평가하기</a>					                	</c:if>
					<c:if test="${cntVO.cntWebStandard == 3 }">
					<a href="#" class="btn btn-inverse btn-small"><c:out value="평가제외"/></a>
					</c:if>
					<c:if test="${cntVO.cntWebStandard == 4 }">
					<a href="http://validator.w3.org/check?uri=${webRoot }<c:url value="${directoryName }"/>" title="새창" target="_blank" class="btn btn-warning btn-small validator_a"><c:out value="-재 검 사-"/></a><br />
					<font color="red">서버와의 연결이 <br /> 원할하지 않습니다</font>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName }"/>','<c:out value="standard"/>');" class="btn btn-small">재평가하기</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td><b>웹표준CSS평가</b></td>
				<td>
					<c:if test="${cntVO.cntWebStandardCss == 0 }">
					<a href="#" class="btn btn-info btn-small"><c:out value="평가대기"/></a>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName}"/>','<c:out value="standardCss"/>');" class="btn btn-small">평가하기</a>
					</c:if>
					<c:if test="${cntVO.cntWebStandardCss == 1 }">
					<a href="#" class="btn btn-success btn-small"><c:out value="최종합격"/></a>
					</c:if>
					<c:if test="${cntVO.cntWebStandardCss == 2 }">
					<a href="http://jigsaw.w3.org/css-validator/validator?uri=${webRoot }<c:url value="${directoryName}"/>" title="새창" target="_blank" class="btn btn-danger btn-small jigsaw_a"><c:out value="-불 합 격-"/></a>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName}"/>','<c:out value="standardCss"/>');" class="btn btn-small">재평가하기</a>
					</c:if>
					<c:if test="${cntVO.cntWebStandardCss == 3 }">
					<a href="#" class="btn btn-inverse btn-small"><c:out value="평가제외"/></a>
					</c:if>
					<c:if test="${cntVO.cntWebStandardCss == 4 }">
					<a href="http://jigsaw.w3.org/css-validator/validator?uri=${webRoot }<c:url value="${directoryName}"/>" title="새창" target="_blank" class="btn btn-warning btn-small jigsaw_a"><c:out value="-재 검 사-"/></a><br />
					<font color="red">서버와의 연결이 <br /> 원할하지 않습니다</font>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName}"/>','<c:out value="standardCss"/>');" class="btn btn-small">재평가하기</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td><b>웹접근성평가</b></td>
				<td>
					<c:if test="${cntVO.cntWebAccess == 0 }">
					<a href="#" class="btn btn-info btn-small"><c:out value="평가대기"/></a>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName}"/>','<c:out value="access"/>');" class="btn btn-small">평가하기</a>
					</c:if>
					<c:if test="${cntVO.cntWebAccess == 1 }">
					<a href="#" class="btn btn-success btn-small"><c:out value="최종합격"/></a>
					</c:if>
					<c:if test="${cntVO.cntWebAccess == 2 }">
					<a href="${webRoot}/w3c/access/?url=${webRoot }<c:url value="${directoryName}"/>/" title="새창" target="_blank" class="btn btn-danger btn-small w3c_a"><c:out value="-불 합 격-"/></a>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName}"/>','<c:out value="access"/>');" class="btn btn-small">재평가하기</a>
					</c:if>
					<c:if test="${cntVO.cntWebAccess == 3 }">
					<a href="#" class="btn btn-inverse btn-small"><c:out value="평가제외"/></a>
					</c:if>
					<c:if test="${cntVO.cntWebAccess == 4 }">
					<a href="${webRoot}/w3c/access/?url=${webRoot }<c:url value="${directoryName}"/>/" title="새창" target="_blank" class="btn btn-warning btn-small w3c_a"><c:out value="-재 검 사-"/></a>
					<font color="red">서버와의 연결이 <br /> 원할하지 않습니다</font>
					&nbsp;<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName}"/>','<c:out value="access"/>');" class="btn btn-small">재평가하기</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td><b>평가대상제외</b></td>
				<td>
					<c:choose>
					<c:when test="${cntVO.cntWebStandard == 0 && cntVO.cntWebStandardCss == 0 && cntVO.cntWebAccess == 0 }">
					<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName}"/>','<c:out value="except"/>');" class="btn btn-inverse btn-small">평 가 제 외</a>
					</c:when>
					<c:when test="${cntVO.cntWebStandard == 3 || cntVO.cntWebStandardCss == 3 || cntVO.cntWebAccess == 3 }">
					<a href="javascript:webStandard('<c:out value="${cntVO.cntId }"/>','<c:out value="${directoryName}"/>','<c:out value="restore"/>');" class="btn btn-inverse btn-small">평 가 복 구</a>
					</c:when>
					</c:choose>
				</td>
			</tr>
			<tr id="JnitContentQuestion7" style="display: none;">
				<td colspan="3">
					<strong>&nbsp;- 평가사이트에서 웹 표준/접근성 평가하여 결과를 알려줍니다.</strong><br />
					<strong>&nbsp;- ( 평가 리스트 페이지 링크 )</strong>
				</td>
			</tr>
			</c:if>
			<c:if test="${jnitcmsmenuVO.iscnt == 1}">						
			<tr id="tr_admMbrId1">
				<th style="text-align:left;" rowspan="2">
					<c:if test="${jnitcmsmenuVO.iscnt == 1}">콘텐츠</c:if> 관리자 선택 <c:if test="${not empty jnitcmsmenuVO.admMbrId}"><a href="javascript:fn_adm_cancel();" class="btn btn-small" >초기화</a></c:if>
					&nbsp;<a href="javascript:Jnit_content_question('8');"><i class="icon-question-sign"></i></a>
				</th>
				<td><b>담당자 1</b></td>
				<td>
					<input type="text" name="adm01" id="adm01" value="${admMap['0'] }" readonly="readonly" style="width: 70%" /><a href="javascript:open_mbrSearch(1);" class="btn btn-small">선택</a>
					<input type="hidden" name="admMbrId1" id="admMbrId1" value="${admMbrIdMap['0'] }" />
				</td>
			</tr>		
			<tr id="tr_admMbrId2">
				<td><b>담당자 2</b></td>
				<td>
					<input type="text" name="adm02" id="adm02" value="${admMap['1'] }" readonly="readonly" style="width: 70%" /><a href="javascript:open_mbrSearch(2);" class="btn btn-small">선택</a>
					<input type="hidden" name="admMbrId2" id="admMbrId2" value="${admMbrIdMap['1'] }" />
				</td>
			</tr>
			<tr id="JnitContentQuestion8" style="display: none;">
				<td colspan="3">
					<strong>&nbsp;- 서브템플릿에 코드를 넣어주셔야 적용되어 나타납니다.</strong><br />
					<strong>&lt;jsp:include page="/cms/import/(사이트경로명)_content_admin.jsp"&gt;&lt;/jsp:include&gt;</strong>
				</td>
			</tr>
			</c:if>
			<c:if test="${jnitcmsmenuVO.iscnt == 0}">
			<tr>
				<th style="text-align:left;"><font color="red">*</font> 링크URL 사용</th>
				<td colspan="2">
					<input onclick="linkUrlOptOpen();" type="radio" id="islink0" name="islink" value="1" <c:out value="${jnitcmsmenuVO.islink == 1 ? 'checked' : ''}"/> />&nbsp;<label for="islink0">사용</label>
					<input onclick="linkUrlOptClose();" type="radio" id="islink1" name="islink" value="0" <c:out value="${jnitcmsmenuVO.islink == 0 ? 'checked' : ''}"/> />&nbsp;<label for="islink1">사용안함</label>
				</td>
			</tr>			
			<tr class="islinkOpen" style="display: none;">
				<th>링크URL</th>
				<td colspan="2">
					<form:input path="linkurl" style="width:99%;" />
					<form:errors path="linkurl" />
					<br/>
					- http:// 로 시작하면 외부링크<br />
					- http:// 가 없이 시작하면 내부링크
				</td>
			</tr>
			<tr class="islinkOpen" style="display: none;">
				<th>링크타겟</th>
				<td colspan="2">
					<form:input path="linktgt" style="width:99%;" />
					<form:errors path="linktgt" />
					<br /><strong>self</strong>[같은 창에서 링크], <strong>new</strong>[새창 링크], <br />
					<strong>pop(x:y:width:height)</strong>[- x:팝업시작위치 좌측,y:팝업시작위치 상단,width:팝업 가로크기,height:팝업 세로크기]
				</td>
			</tr>
			<tr class="islinkOpen" style="display: none;">
				<th><strong>주의사항</strong></th>
				<td colspan="2">
					<strong>링크 URL 사용시 하위메뉴에 콘텐츠가 있을경우 사용이 불가합니다. 유의하시기 바랍니다.</strong>
				</td>
			</tr>
			</c:if>
			<c:if test="${jnitcmsmenuVO.iscnt == 1}">
			<tr>
				<th id="meta" rowspan="1" colspan="4" style="text-align:left;">SEO 최적화 설정 <a href="javascript:Jnit_handingClose();" id="metaBtn" class="btn btn-small">열기</a></th>
				<td class="meta" style="display: none;"><b>주제</b>  <a href="javascript:Jnit_help('1');"><i class="icon-question-sign"></i></a></td>
				<td class="meta" style="display: none;">
					<input type="hidden" id="metaTitle" name="metaTitle" value="${jnitcmsmenuVO.menuNm }" readonly="readonly" />
					<input type="hidden" id="metaBuild" name="metaBuild" value="${cntModified }" readonly="readonly" />
					<input type="text" id="metaSubject" name="metaSubject" value="${jnitcmsmenuVO.metaSubject }" style="width: 94%;" />
					<span id="menuHelp1" style="display: none;"><b><br />문서의 주제를 등록합니다.</b></span>
				</td>
			</tr>
			<tr class="meta" style="display: none;">
				<td><b>키워드</b>  <a href="javascript:Jnit_help('2');"><i class="icon-question-sign"></i></td>
				<td>
					<input type="text" id="metaKeyword" name="metaKeyword" value="${jnitcmsmenuVO.metaKeyword }" style="width: 94%;"/>
					<span id="menuHelp2" style="display: none;">
						<b><br />
							이 문서의 핵심 키워드를 <font color="red">콤마(,)</font>로 구분하여 지정합니다.<br />
							키워드의 갯수는 20개미만을 권장합니다.<br />
							키워드는 엔터없이 입력해주세요.<br />
							보기)cms,웹프레임워크
						</b>
					</span>
				</td>
			</tr>
			<tr class="meta" style="display: none;">
				<td><b>설명</b> <a href="javascript:Jnit_help('3');"><i class="icon-question-sign"></i></td>
				<td>
					<textarea rows="10" style="width: 94%;" id="metaDescription" name="metaDescription">${jnitcmsmenuVO.metaDescription }</textarea>
					<span id="menuHelp3" style="display: none;">
						<b><br />
							검색 결과에 표시되는 문자를 지정합니다.<br />
							이 문서를 키워드 위주로 가급적 150자 이내로 설명해 주세요.<br />
							설명글은 엔터없이 입력해 주세요<br />
							보기)웹 프레임워크의 혁신 - cms 대한 다운로드,팁 공유등을 제공합니다.
						</b>
					</span>
				</td>
			</tr>
			<tr class="meta" style="display: none;">
				<td><b>분류</b>  <a href="javascript:Jnit_help('4');"><i class="icon-question-sign"></i></td>
				<td>
					<input type="text" id="metaClassification" name="metaClassification" value="${jnitcmsmenuVO.metaClassification }" style="width: 94%;" />
					<span id="menuHelp4" style="display: none;">
						<b><br />
							이 문서의 분류,카테고리라 할 수 있으며 핵심적인 키워드 1개를 개입합니다.<br />
							보기)cms
						</b>
					</span>
				</td>
			</tr>
			<tr class="meta" style="display: none;">
				<td><b>이메일</b>  <a href="javascript:Jnit_help('5');"><i class="icon-question-sign"></i></td>
				<td>
					<input type="text" id="metaRePly" name="metaRePly" value="${jnitcmsmenuVO.metaRePly }" style="width: 94%;" />
					<span id="menuHelp5" style="display: none;">
						<b><br />문서에 관한 문의쳐 이메일 주소를 등록합니다.</b>
					</span>
				</td>
			</tr>
			<tr class="meta" style="display: none;">
				<td><b>언어</b>  <a href="javascript:Jnit_help('6');"><i class="icon-question-sign"></i></td>
				<td>
					<input type="text" id="metaLanguage" name="metaLanguage" value="${jnitcmsmenuVO.metaLanguage }" style="width: 94%;" />
					<span id="menuHelp6" style="display: none;">
						<b><br />
							제작된 언어를 등록합니다.<br />
							- 한글 : ko<br />
							- 영어 : en<br />
							- 일어 : ja<br />							
							- 중국어 : zh
						<b>
					</span>
				</td>
			</tr>			
			</c:if>
		</table>
	</div>
</form:form>

<%-- Contents End --%>
<!-- Modal -->
<div id="menuModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel" style="text-align: center;"></h3>
	</div>
	<div class="modal-body">
		<div id="modalBody"></div>
	</div>
	<div class="modal-footer">
		<span id="modalFooter"></span>
		<button class="btn btn-danger" data-dismiss="modal">닫기</button>
	</div>
</div>

