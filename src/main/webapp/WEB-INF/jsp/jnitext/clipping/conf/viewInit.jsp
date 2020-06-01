<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>


<c:set var="registerFlag" value="${empty result ? '등록' : '수정'}"/>			

<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery.plugins/jquery.validate.extends.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jnit.extend.js"/>"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	$("#flist").submit();
}

function fn_init_list_all(){
	
	var pageStart = $("#pageStart").val();
	var pageEnd = $("#pageEnd").val();
	
	if(pageStart == "" || pageEnd == ""){
		alert("수집할 페이지 범위를 입력해 주세요");
		return false;
	}
	
	if(pageStart*1 > pageEnd*1){
		alert("수집종료페이지범위는 수집시작페이지보다 커야합니다.");
		return false;
	}
	
	$("#myModal").modal('toggle');
	$("#myModal .modal-body").html("");
	$.ajax({
		url:"<c:url value="/cms/clipping/crawler/initExcutePopup.do" />"
		,data:{"clippingConfId":"<c:out value="${conf.clippingConfId}" />", pageStart:pageStart, pageEnd:pageEnd}
		,success:function(data){
			$("#myModal .modal-body").html(data);
		}
		,fail:function(xhr){
			console.log(xhr);
		}
	});
	return false;
}

function summary(clippingDataListInitId){

	$("#myModal").modal('toggle');
	$("#myModal .modal-body").html("");
	$.ajax({
		url:"<c:url value="/cms/clipping/data/init/index.do" />"
		,data:{cdliMode:"view","clippingDataListInitId":clippingDataListInitId,"skinClippingDataInitViewUi":"viewSummary"}
		,success:function(data){
			$("#myModal .modal-body").html(data);
		}
		,fail:function(xhr){
			console.log(xhr);
		}
	});
	return false;
}
//-->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
       	<div class="row-fluid">
           	<div class="span12">
               	<div class="widget-box">
                   	<div class="widget-title">
                   		<h3>초기데이터</h3>
						<a href="#" onclick="fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
						
						<input type="text" id="pageStart" name="pageStart" placeholder="수집시작페이지"/>Page부터
						<input type="text" id="pageEnd" name="pageEnd" placeholder="수집종료페이지"/>Page까지
						<a href="#" onclick="fn_init_list_all();" class="btn btn-small"><i class="icon-ok-sign"></i> 수집하기</a>
						
						<!-- a href="javascript:fn_egov_save();" class="btn btn-small"><i class="icon-ok-sign"></i> 초기화</a -->
                    </div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped th_left" summary="초기데이터 관련">
					        <tbody>
					        <tr>
					        	<th colspan="4" class="text-center">리스트 관련</th>
					        </tr>
							<tr>
								<th class="text-center">수집URL(<c:out value="${conf.clippingConfListMethod }" />)</th>
								<td colspan="3"><c:out value="${site.realClippingUrl }" /><c:out value="${conf.clippingConfListUrl }" /></td>
							</tr>
							<tr>
								<th class="text-center">페이지변수</th>
								<td colspan="3"><c:out value="${conf.clippingConfListPageParam }" /></td>
							</tr>
							<tr>
								<th class="text-center">반복호출간격</th>
								<td colspan="3"><c:out value="${conf.clippingConfRepeatInterval }" />(millisecond)</td>
							</tr>
							<tr>
								<th class="text-center">파라메터</th>
								<td colspan="3">
								<c:forEach items="${conf.clippingParamList}" var="clippingParam">
									<c:if test="${clippingParam.clippingParamType == 'LIST'}">
										&<c:out value="${clippingParam.clippingParamName}" />=<c:out value="${clippingParam.clippingParamValue}" />
									</c:if>
								</c:forEach>
								</td>
							</tr>
							<tr>
								<th class="text-center">수집키</th>
								<td colspan="3">
									<table class="table table-bordered table-striped table-hover">
					                	<thead>
						                	<tr>
						                		<th>Key</th>
						                		<th>Class</th>
						                		<th>CssQuery</th>
						                		<th>정규식</th>
						                		<th>고유ID</th>
						                	</tr>
					                	</thead>
					                	<tbody>
										<c:forEach items="${conf.clippingKeyList}" var="clippingKey">
											<c:if test="${clippingKey.clippingKeyType == 'LIST'}">
											<tr>
												<td><c:out value="${clippingKey.clippingKeyName}" /></td>
												<td><c:out value="${clippingKey.clippingKeyClass}" /></td>
												<td><c:out value="${clippingKey.clippingKeyCssQuery}" /></td>
												<td><c:out value="${clippingKey.clippingKeyPattern}" /></td>
												<td><c:out value="${clippingKey.isdetailid?'Y':''}" /></td>
											</tr>
											</c:if>
										</c:forEach>
					                	</tbody>
					                </table>
								</td>
							</tr>								
							<tr>
								<th class="text-center">
									수집결과
								</th>
								<td colspan="3">
									<table class="table table-bordered table-striped table-hover">
					                	<thead>
						                	<tr>
						                		<th>페이지</th>
						                		<th>요약</th>
						                	</tr>
					                	</thead>
					                	<tbody>
										<c:forEach items="${dataListInitList }" var="listInit">
											<tr>
												<td>${listInit.clippingDataListInitKey }</td>
												<td><a onclick="summary('${listInit.clippingDataListInitId}');" class="btn btn-small" style="float: rigth; margin-right: 10px;">보기</a></td>												
											</tr>
										</c:forEach>
					                	</tbody>
					                </table>
								</td>
							</tr>
					        </tbody>
					    </table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--콘텐츠끝-->
<!-- 검색조건 유지 -->
<form id="flist" action="?">
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<c:set var="noform" value="Y" />
</form>

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
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>