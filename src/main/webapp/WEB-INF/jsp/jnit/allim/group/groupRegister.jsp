<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>
<%-- validator:javascript formName="jnitallimGroupVO" staticJavascript="false" xhtml="true" cdata="false"/  --%>
<script type="text/javascript">
<!--

function Jnit_allim_question(num){
	var baseId = "JnitAllimQuestion"+num;
	var baseObject = $("#"+baseId);
	var displayState = baseObject.css("display");
	
	if(displayState == "none"){
		baseObject.show();
	}else{
		baseObject.hide();
	}
}

$(document).ready(function(){
	  //한글입력 안되게 처리
	  $("input[name=groupClassName]").keyup(function(event){ 
	   if (!(event.keyCode >=37 && event.keyCode<=40)) {
	    var inputVal = $(this).val();
	    $(this).val(inputVal.replace(/[^a-z0-9_-]/gi,''));
	   }
	  });
	});
/* 글 삭제 function */
function fn_egov_delete() {
	if(confirm("삭제 하시겠습니까?")){
		var type = "${type}";
		var grpId = $('#grpId').val();
	   	document.getElementById("jnitallimGroupVO").action = "<c:url value='/cms/allim/groupDeleteProc.do'/>?type="+type+"&grpId="+grpId;
	   	document.getElementById("jnitallimGroupVO").submit();
	}
}

/* 글 등록 function */
function fn_egov_save() {	
	
		var grpId = $('#grpId').val();
		var type = $('#groupType').val();
		var name = $('#groupNm').val();
		var classNm = $('#groupClassName').val();
		var width = $('#groupWidth').val();
		var height = $('#groupHeight').val();
		var time = $('#groupChangeTime').val();
		var direction = $.trim($('#groupDirection').val());
		var showItems = $('#groupShowItems').val();
		var auto = $.trim($('#groupAuto').val());
		var timerDelay = $('#groupTimerDelay').val();
		var animationDelay = $('#groupAnimationDelay').val();	
	
		var num = /^[0-9]+$/;
		var space = /[\s]/;
		
		if(type == null || type == ''){
			alert('유형을 지정해 주세요.');
			document.getElementById("groupType").focus();
			return false;
		}else if(name == null || name == ''){
			alert('명칭을 지정해 주세요.');
			document.getElementById("groupNm").focus();
			return false;
		}else if(classNm == null || classNm == ''){
			alert('클래스명을 입력해주세요..');
			document.getElementById("groupClassName").focus();
			return false;
		}else if(width == null || width == ''){
			alert('넓이를 지정해 주세요.');
			document.getElementById("groupWidth").focus();
			return false;
		}else if(width != null && num.test(width) == false){
				alert('상품 넓이는 숫자 형식으로 입력해 주세요');
				$('#groupWidth').focus();
				return false;
		}else if(height == null || height == ''){
			alert('높이를 지정해 주세요.');
			document.getElementById("groupHeight").focus();
			return false;
		}else if(height != null && num.test(height) == false){
				alert('상품 높이는 숫자 형식으로 입력해 주세요');
				$('#groupHeight').focus();
				return false;
		}else if("${type}" == 'allim'){
			if(time == null || time == ''){
				alert('알리미 변경시간초를 지정해주세요.');
				document.getElementById("groupChangeTime").focus();
				return false;
			}else if(time != null && num.test(time) == false){
				alert('알리미 변경시간초는 숫자로 입력해 주세요.');
				$('#groupChangeTime').focus();
				return false;
			}
		}else if("${type}" == 'banner'){
			if(direction == null || direction == ''){
				if("${type}" == 'banner'){
					alert('배너 방향을 설정해주세요');
					document.getElementById("groupDirection").focus();
					return false;
				}
			}else if(showItems == null || showItems == '' ){
				alert('노출될 아이템수를 입력해주세요');
				document.getElementById("groupShowItems").focus();
				return false;
			}else if(num.test(showItems) == false){
				alert('노출 아이템 갯수는 숫자 형식으로 입력해 주세요');
				$('#groupShowItems').focus();
				return false;
			}else if(showItems == 0){
				alert('노출될 아이템수는 최소 1 이상으로 적어주시기 바랍니다.');
				document.getElementById("groupShowItems").focus();
				return false;
			}else if(auto == null || auto == ''){
				alert('자동 롤링 여부를 설정해주세요');
				document.getElementById("groupAuto").focus();
				return false;
			}else if(timerDelay == null || timerDelay == ''){
				alert('반복속도를 입력주세요');
				document.getElementById("groupTimerDelay").focus();
				return false;
			}else if(animationDelay == null || animationDelay == ''){
				alert('애니메이션 속도를 입력해주세요');
				document.getElementById("groupAnimationDelay").focus();
				return false;
			}else if(animationDelay >= timerDelay-500){
				alert("애니매이션 값은 "+(timerDelay-500)+"값 보다 적게 입력해주세요");
				document.getElementById("groupAnimationDelay").focus();
				return false;
			}else if(num.test(animationDelay) == false){
				alert('애니메이션 속도는 숫자 형식으로 입력해 주세요');
				$('#groupAnimationDelay').focus();
				return false;
			}
		}
		return true;
	
}

function group_save(){
	if(fn_egov_save()){
		
		var grpId = $('#grpId').val();
		var type = $('#groupType').val();
		
		frm = document.getElementById("jnitallimGroupVO");
		<c:if test="${registerFlag == '수정'}">
	  		frm.action = "<c:url value='/cms/allim/groupEditProc.do'/>?type="+type+"&grpId="+grpId;
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			frm.action = "<c:url value='/cms/allim/groupAddProc.do'/>?type="+type+"&grpId="+grpId;
		</c:if>
		frm.submit();
	}
}

//스킨 Modal
function Jnit_allimSkinAdd(){
	var groupCategory = $("#groupCategory option:selected").val();
	var isUse = false;
	
	if(groupCategory != 'allimView' && groupCategory != 'bannerRolling' ){
		if(confirm(groupCategory+"유형으로 스킨을 추가하시겠습니까?")){
			isUse = true;
		}
	}			
	var headerHtml = "<strong>스킨추가</strong>";	
	$("#myModalLabel").empty();
	$("#myModalLabel").append(headerHtml);	
	
	var bodyHtml = "<label>스킨 이름 : </label><input type='text' id='skinNm'/> 선택 스킨유형 : "+(isUse == true ? groupCategory : "기본") 
					+"<input type='hidden' id='skinType' value='"+groupCategory+"'/>";	
	$(".modal-body").empty();
	$(".modal-body").append(bodyHtml);
	
	var footerHtml = "<a href='javascript:Jnit_allimSkinAddProc();' class='btn btn-primary'>추가</a>";
	$("#actionBtn").empty();
	$("#actionBtn").append(footerHtml);
	$('#myModal').modal('toggle');
}
function Jnit_allimSkinAddProc_bln(){
	var skinNm = $("#skinNm").val();	
	if(skinNm == '' || skinNm == null){
		alert("스킨이름을 써주시기 바랍니다.");
		$("#skinNm").focus();
		return false;
	}else if(skinNm.match("[^ㄱ-ㅎ가-힣]+$") == null){
		alert("한글 파일명은 쓸 수 없습니다.");
		$("#skinNm").focus();
		return false;
	}
	return true;
}
//스킨추가
function Jnit_allimSkinAddProc(){
	var skinNm = $("#skinNm").val();
	if(Jnit_allimSkinAddProc_bln()){
		if(skinNm != ''){
			var skinType = $("#skinType").val();
			$.ajax({
				type:"post",
				url: "<c:url value='/cms/allim/ajax/skin.do'/>",
				data:"skinNm="+skinNm+"&skinType="+skinType+"&type=${type}"
			}).done(function(data){
				var json = $.parseJSON(data);
				if(json.status == 'success'){
					alert("정상처리되었습니다. 디자인에서 개발하시기바랍니다.");
					$('#myModal').modal('toggle');
					var redirect;
					<c:if test="${registerFlag == '등록'}">
						redirect = "/groupAdd.do?type=${type}";
					</c:if>
					<c:if test="${registerFlag == '수정'}">
						redirect = "/groupEdit.do?grpId=${grpId}&type=${type}&screenMode=up";
					</c:if>				
					location.href = "${pageContext.request.contextPath}/cms/allim"+redirect;
				}else{
					if(json.code != ''){
						if(json.code == 'FAIL 1') alert("같은 파일 이름이 있습니다.");
						if(json.code == 'FAIL 2') alert("파일을 추가 하지 못했습니다.");
					}
				}
			});
		}
	}
}

$(document).ready(function(){
	var groupCategory = $('#category').val();
	if(groupCategory != "") $('#groupCategory').val(groupCategory);
	
	if("${type}" == 'banner'){
		<c:if test="${registerFlag == '등록'}">
		$('#groupShowItems').val(1);
		$('#groupAuto').val('');
		$('#groupTimerDelay').val(2000);
		$("#groupAnimationDelay").val(1000);
		</c:if>
		$('#groupTimerDelay').change(function(){
			var timerDelay = $('#groupTimerDelay').val();
			if(timerDelay != ''){
				$.ajax({
					type:"POST",
					url:"<c:url value='/jnitallimGroup/ajaxGroup.do'/>",
					data:"timerDelay="+timerDelay
				}).done(function(data){
					$("#appendTimer").empty();
					$("#appendTimer").append(data);					
				});
			}			
		});
		$('#detail').change(function(){
			if($('#detail').val() == 0){
				$('.detailSetup').hide();
			}else if($('#detail').val() == 1 ){
				$('.detailSetup').show();
			}
		});
		
		<c:if test="${registerFlag == '수정'}">		
			var timerDelay = $('#groupTimerDelay').val();			
			$.ajax({
				type:"POST",
				url:"<c:url value='/jnitallimGroup/ajaxGroup.do'/>",
				data:"timerDelay="+timerDelay
			}).done(function(data){
				$("#appendTimer").empty();
				$("#appendTimer").append(data);
			});			
		</c:if>
	}
	
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
                   		<h3>그룹 <c:out value='${registerFlag}'/></h3>
                   		<a href="<c:url value="/cms/allim/groupList.do"/>?grpId=${grpId}&type=${type}" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
                   		<a href="javascript:group_save()" class="btn btn-small"><i class="icon-ok-sign"></i> <c:out value='${registerFlag}'/></a>
						<c:if test="${registerFlag == '수정'}">
							<a href="javascript:fn_egov_delete()" class="btn btn-small btn-del" style="float:right;"><i class="icon-minus-sign"></i> 삭제</a>
						</c:if>
                    </div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitallimGroupVO">
							<input type="hidden" name="category" id="category" value="${groupCategory}"/>
							<input type="hidden" name="grpId" id="grpId" value="${grpId}"/>							
							<table class="table table-bordered table-striped th_left" summary="그룹 테이블">
								<c:if test="${registerFlag == '수정'}">
									<input type="hidden" name="screenMode" value="up" />
								</c:if>
								<c:if test="${registerFlag == '등록'}">
									<input type="hidden" name="screenMode" value="" />
								</c:if>
								<tr>
									<th style="width:120px;">유형</th>
									<td>
										<c:if test="${type == 'banner' }">
											<p><strong>배너</strong></p>
											<form:hidden path="groupType" value="${type}" readonly="true"/>
										</c:if>
										<c:if test="${type == 'allim' }">
											<p><strong>알리미</strong></p>
											<form:hidden path="groupType" value="${type}" readonly="true"/>
										</c:if>
										<c:if test="${type == 'popup' }">
											<p><strong>팝업</strong></p>
											<form:hidden path="groupType" value="${type}" readonly="true"/>
										</c:if>
									</td>
								</tr>
								<tr>
									<th>스킨설정 <a href="javascript:Jnit_allimSkinAdd();" class="btn btn-small">추가</a></th>
									<td>
										<select id="groupCategory" name="groupCategory">
											<c:choose>
												<c:when test="${!empty skinList }">
													<c:forEach var="skinList" items="${skinList }">
														<option value="${skinList }" <c:out value="${skinList == 'allimView' || skinList == 'bannerRolling' || skinList == 'PopupView'  ? 'selected' : '' }"/>>
															<c:out value="${skinList == 'allimView' || skinList == 'bannerRolling' || skinList == 'PopupView'  ? '기본' : skinList }"/>
														</option>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<option value="allimView" selected="selected">기본</option>
												</c:otherwise>
											</c:choose>
										</select>
									</td>
								</tr>
								<tr>
									<th>명칭</th>
									<td>
										<form:input path="groupNm" cssClass="txt"/>
										&nbsp;<form:errors path="groupNm" />
									</td>
								</tr>
								<tr>
									<th>클래스 명&nbsp;<a href="javascript:Jnit_allim_question('1');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:input path="groupClassName" cssClass="txt"/>
										&nbsp;<form:errors path="groupClassName" />
										
										<div id="JnitAllimQuestion1" style="display: none;">
											<strong>&nbsp;- 클래스 명을 지정합니다.</strong>
										</div>
									</td>
								</tr>
								<tr>
									<th>상품 너비&nbsp;<a href="javascript:Jnit_allim_question('2');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:input path="groupWidth" cssClass="txt"/>
										&nbsp;<form:errors path="groupWidth" />
										 
										<div id="JnitAllimQuestion2" style="display: none;">
											<strong>&nbsp;- 이미지의 가로 길이를 지정합니다.</strong>
										</div>
									</td>
								</tr>	
								<tr>
									<th>상품 높이&nbsp;<a href="javascript:Jnit_allim_question('3');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:input path="groupHeight" cssClass="txt"/>
										&nbsp;<form:errors path="groupHeight" />
										 
										<div id="JnitAllimQuestion3" style="display: none;">
											<strong>&nbsp;- 이미지의 세로 길이를 지정합니다.</strong>
										</div>
									</td>
								</tr>		
								<c:if test="${type == 'banner' }">
								<tr>
									<th>배너 방향&nbsp;<a href="javascript:Jnit_allim_question('4');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:select path="groupDirection" id="groupDirection">
											<form:option value="1" label="왼쪽 방향" />
											<form:option value="2" label="오른쪽 방향" />
											<form:option value="3" label="상단 방향" />
											<form:option value="4" label="하단 방향" />
										</form:select>
										 
										<div id="JnitAllimQuestion4" style="display: none;">
											<strong>&nbsp;- 배너가 흘러갈 방향을 정합니다.</strong>
										</div>	
									</td>
								</tr>
								<tr>
									<th>노출될 아이템수&nbsp;<a href="javascript:Jnit_allim_question('5');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:input path="groupShowItems" cssClass="txt"/>
										&nbsp;<form:errors path="groupShowItems" />
										 
										<div id="JnitAllimQuestion5" style="display: none;">
											<strong>&nbsp;- 한번에 노출 될 배너의 수를 정합니다.</strong>
										</div>
									</td>
								</tr>
								<tr>
									<th>자동롤링&nbsp;<a href="javascript:Jnit_allim_question('6');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:select path="groupAuto">
											<form:option value="0" label="미사용" />
											<form:option value="1" label="사용" />
										</form:select>
										
										<div id="JnitAllimQuestion6" style="display: none;">
											<strong>&nbsp;- 시간이 지나면 순서대로 맨 뒤로 이동하게 설정합니다.</strong>
										</div>
									</td>
								</tr>
								<tr>
									<th>세부설정&nbsp;<a href="javascript:Jnit_allim_question('7');"><i class="icon-question-sign"></i></a></th>
									<td>
										<select id="detail" name="detail">
											<option value="0">감추기</option>
											<option value="1">보이기</option>
										</select>
										
										<div id="JnitAllimQuestion7" style="display: none;">
											<strong>&nbsp;- 롤링되는 속도를 조절할 수 있습니다.</strong>
										</div>
									</td>
								</tr>			
								<tr class="detailSetup" style="display:none">
									<th>반복 속도&nbsp;<a href="javascript:Jnit_allim_question('8');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:select path="groupTimerDelay">
											<form:option value="1000" label="1초" />
											<form:option value="1500" label="1.5초" />
											<form:option value="2000" label="2초" />
											<form:option value="2500" label="2.5초" />
											<form:option value="3000" label="3초" />
											<form:option value="3500" label="3.5초" />
											<form:option value="4000" label="4초" />
											<form:option value="4500" label="4.5초" />
											<form:option value="5000" label="5초" />									
										</form:select>
										<div id="JnitAllimQuestion8" style="display: none;">
											<strong>&nbsp;- 이미지가 넘어갈때까지 기다리는 시간</strong>
										</div>
									</td>
								</tr>
								<tr class="detailSetup" style="display:none">
									<th>애니매이션 속도&nbsp;<a href="javascript:Jnit_allim_question('9');"><i class="icon-question-sign"></i></a></th>
									<td>
										<form:input path="groupAnimationDelay" cssClass="txt"/>
										&nbsp;<form:errors path="groupAnimationDelay" /><br/>
										<font size="2" color="Red">*1000=1초 클수록 속도가느려짐<br/>
											*애니매이션속도는 <div id="appendTimer"></div>이상 값보다 크면안됨<br/>
											*기본값 : 반복속도 2초 애니매이션속도 1000</font>
										<div id="JnitAllimQuestion9" style="display: none;">
											<strong>&nbsp;- 배너가 이동하는 속도</strong>
										</div>
									</td>
								</tr>		
								</c:if>
								<c:if test="${type == 'allim' }">
								<tr>
									<th>알리미 변경시간(초)</th>
									<td>
										<form:input path="groupChangeTime" cssClass="txt"/>
										&nbsp;<form:errors path="groupChangeTime" />
									</td>
								</tr>				
								</c:if>
							</table>
							<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
							<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel"></h3>
	</div>
	<div class="modal-body">
		
	</div>
	<div class="modal-footer">
		<span id="actionBtn"></span>
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>		
	</div>
</div>
<!-- 검색조건 유지 -->
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>