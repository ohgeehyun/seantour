<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--
function Jnit_list(){
	document.getElementById("jnitboardinfoVO").action = "<c:url value='/cms/board/list.do'/>";
	document.getElementById("jnitboardinfoVO").submit();
}
function Jnit_step2(){
	if(confirm("다음단계로 넘어가시겠습니까?")){
		document.getElementById("jnitboardinfoVO").action = "<c:url value='/cms/board/add.do'/>";
		document.getElementById("jnitboardinfoVO").submit();
	}	
}
$(document).on("change",'#boardSkin',function(e){
	$.getJSON("<c:url value='/cms/board/_getSkinType.do'/>",{skin:$("#boardSkin option:selected").val()},function(data){
		if(data.length < 1){
			alert("선택하신 유형에는 게시판스킨이 없습니다.");
			$("#boardSkin option[value='default']").attr("selected","selected");
			$('#boardSkin').trigger('change'); 			
		}
		$('#boardType').empty();
		$.each(data,function(k,v){
			if('<c:out value="${jnitboardinfoVO.boardSkin}" />' == $("#boardSkin option:selected").val() && '<c:out value="${jnitboardinfoVO.boardType}" />' == v){
				$('#boardType').append('<option value="'+ v +'" selected="selected">'+ v +'</option>');
			}else{
				$('#boardType').append('<option value="'+ v +'" >'+ v +'</option>');
			}
		});
	});
});
//-->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="jnitboardinfoVO">
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<a href="javascript:Jnit_list();" class="btn btn-small"><i class="icon-repeat"></i> 돌아가기 </i></a>
						<a href="javascript:Jnit_step2();" class="btn btn-small">다음단계 <i class="icon-share-alt"></i></a>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered">
							 <tr>
				                <th width="30%">국가별 언어 선택</th>
				                <td>
					                <select name="useLanguage" id="useLanguage">
						                <option value="korea" <c:out value="${jnitboardinfoVO.useLanguage == 'korea' ? 'selected' : ''}"/>>한국어</option>
						                <option value="eng" <c:out value="${jnitboardinfoVO.useLanguage == 'eng' ? 'selected' : ''}"/>>영어</option>
						                <option value="chi" <c:out value="${jnitboardinfoVO.useLanguage == 'chi' ? 'selected' : ''}"/>>중국어</option>
						                <option value="japan" <c:out value="${jnitboardinfoVO.useLanguage == 'japan' ? 'selected' : ''}"/>>일본어</option>
					                </select>				                
				                </td>
				            </tr>    
				            <tr>
				                <th width="30%"><font color="red">*</font> 게시판 스킨</th>
				                <td>
					                <select name="boardType" id="boardType">
						                <c:forEach var="item" items="${skinTypeList}">
						                	<option value="<c:out value="${item}" />" <c:out value='${(jnitboardinfoVO.boardType == item || (mode == "add" && item == "normal")) ? "selected" : "" }'/>><c:out value="${item}" /></option>
						                </c:forEach>
					                </select>
				                </td>
				            </tr>
				            <tr>
				                <th width="30%"><font color="red">*</font> 게시판 유형</th>
				                <td>
					                <select name="boardSkin" id="boardSkin">
						                <c:forEach var="item" items="${skinList}">
						                	<option value="<c:out value="${item}" />" <c:out value='${(jnitboardinfoVO.boardSkin == item || (mode == "add" && item == "basic")) ? "selected" : "" }'/>><c:out value="${item}" /></option>
						                </c:forEach>
					                </select>					                
				                </td>
				            </tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		</form:form>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>