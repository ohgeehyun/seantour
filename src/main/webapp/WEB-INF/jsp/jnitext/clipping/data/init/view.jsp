<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>


<c:set var="registerFlag" value="${empty result ? '등록' : '수정'}"/>			

<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.extends.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jnit.extend.js"/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

$(document).ready(function(){
	
	
	$('#fwrite').validate({
		rules: {
			clippingConfName: "required"
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
			url:"<c:url value='/cms/clipping/data/init/index.do'/>",
			data:{cdliMode:"deleteAction",clippingDataListInitId:$("#clippingDataListInitId").val()}
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
                   		<h3>기초데이터 상세보기</h3>
						<!-- a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> ${registerFlag }</a -->
						<a href="#" onclick="fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						<!-- <c:if test="${!empty result }"><a href="javascript:Jnit_delete();" class="btn btn-small"><i class="icon-minus-sign"></i> 삭제</a></c:if> -->
                    </div>
					<div class="widget-content nopadding">
						<form id="fwrite" name="fwrite" method="post" action="<c:url value="/cms/clipping/conf/index.do" />">
						<input type="hidden" id="retUrl" name="retUrl" value="" />
						<input type="hidden" id="cdliMode" name="cdliMode" value="writeAction" />
						<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value="${searchVO.pageIndex }"/>" />
						<input type="hidden" id="searchCondition" name="searchCondition" value="<c:out value="${searchVO.searchCondition }"/>" />
						<input type="hidden" id="searchKeyword" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword }"/>" />
						
						    <table class="table table-bordered table-striped th_left" summary="수집사이트 등록">
						        <tbody>
						            <tr>
						                <th width="10%">코드</th>
						                <td colspan="3"><input type="text" id="clippingDataListInitId" name="clippingDataListInitId" value="<c:out value='${result.clippingDataListInitId}'/>" readonly placeholder="자동입력됩니다."/></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 수집사이트</th>
						                <td colspan="3">
						                <c:forEach items="${clippingSiteList }" var="site">
						                	<c:if test="${site.clippingSiteId == result.clippingSiteId }"><c:out value="${site.clippingSiteName }" /></c:if>
						                </c:forEach>
						                </select>
						                </td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 설정명</th>
						                <td colspan="3"><c:out value="${result.clippingConfName }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> URL</th>
						                <td colspan="3"><c:out value="${result.clippingDataListInitUrl }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 메소드</th>
						                <td colspan="3"><c:out value="${result.clippingDataListInitMethod }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 파라메터</th>
						                <td colspan="3"><c:out value="${result.clippingDataListInitParam }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 페이지</th>
						                <td colspan="3"><c:out value="${result.clippingDataListInitKey }" /></td>
						            </tr>
						            <tr>
						                <th><font color="red">*</font> 수집HTML</th>
						                <td colspan="3">
						                <textarea id="" name="" style="width:98%" rows="10"><c:out value="${result.clippingDataListInitHtml }" /></textarea>
						                </td>
						            </tr>
						        <c:if test="${confVO.clippingConfDetailUse }">
						        	<tr>
						        		<th colspan="4">상세수집관련</th>
						        	</tr>
						        	<tr>
						        		<th>상세수집리스트</th>
						        		<td colspan="3">
						        		<table class="table table-bordered table-striped table-hover" summary="키추가" style="margin-bottom: 0px;">
						                	<thead>
							                	<tr>
							                		<th>URL</th>
							                		<th>메소드</th>
							                		<th>파라메터</th>
							                		<th>키</th>
							                		<th>수집HTML</th>
							                		<th>순서</th>
							                	</tr>
						                	</thead>
											<tbody>
											<c:forEach items="${result.detailList }" var="detail">
												<tr>
													<td><c:out value="${detail.clippingDataDetailInitUrl }" /></td>
													<td><c:out value="${detail.clippingDataDetailInitMethod }" /></td>
													<td><c:out value="${detail.clippingDataDetailInitParam }" /></td>
													<td><c:out value="${detail.clippingDataDetailInitKey }" /></td>
													<td>
														<a onclick="showDetailHtml('${detail.clippingDataDetailInitId}');" class="btn btn-small" style="float: rigth; margin-right: 10px;">보기</a>
													</td>
													<td><c:out value="${detail.clippingDataDetailInitOrder }" /></td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
						        		</td>
						        	</tr>
						        </c:if>
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