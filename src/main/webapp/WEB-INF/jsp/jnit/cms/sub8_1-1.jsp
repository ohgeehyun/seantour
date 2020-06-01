<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">
<!--
function fn_egov_edit(cntId) {
	window.open('<c:url value="/cms/sub11/0101upview.do?cntId="/>'+cntId,'editWindow','width=900, height=950, toolbar=no, scrollbars=yes, status=yes, resizable=yes');
}

function webStandard(cntId,url,type){		
	$("#url").val(url);
	$("#cntId").val(cntId);
	$("#type").val(type);
	$("#host").val(window.location.protocol + "//" + window.location.host);
	var title;
	var message = "";
	if(type == 'except'){
		title = '평가제외중';		
	}else if(type == 'restore'){
		title = '평가복구중';
	}else {
		title = '평가진행중';
		message = "- css평가시 18초 소요 -";
	}
	var $pJquery = window.parent.$;	
	var dialog = '<div id="dialog" title="'+title+'" style="text-align:center;"><br />'+message+'<br /><img src="<c:url value="/images/loading01.gif"/>" /><br /><font color="red">잠시 하던 일을 중단해 주시기 바랍니다.</font></div>';
	if($pJquery('#dialog').length>0){
		$pJquery('#dialog').remove();
	}
	$pJquery('body').append(dialog);
	$pJquery('#dialog').dialog({
		modal: true,
		close: function( event, ui ) {
			$pJquery(this).dialog('destroy').remove();
		}
	});
	$.ajax({
		type:"POST",
		url:"<c:url value='/cms/sub8/webStandard.do'/>",
		data: $('#listForm').serialize()
	}).done(function(data){
		var json = JSON.parse(data);		
		if(json.status == 'success'){
			$pJquery('#dialog').dialog("destroy");
			alert(json.message);
			document.getElementById("listForm").action = "<c:url value='/cms/sub8/0101.do'/>";
		   	document.getElementById("listForm").submit();
		}else if(json.status == 'error'){
			$pJquery('#dialog').dialog("destroy");
			alert(json.message);
			document.getElementById("listForm").action = "<c:url value='/cms/sub8/0101.do'/>";
		   	document.getElementById("listForm").submit();
		}
	});	
}
/*
function webAccess(url){	
	$("#textUrl").val(url);
	frm = document.getElementById("accessForm");
	frm.action = "https://accessibility.kr/nia/check.php";
	frm.submit();
}
*/
/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){	
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub8/0101.do'/>";
   	document.getElementById("listForm").submit();
}

$(document).ready(function(){
	//css
	$("#defaultTable td").css("text-align","center");
	$("#defaultTable td").css("vertical-align","middle");
	
	$("#assessList").val("${assessList}");
	var selectList = '${selectList}';
	if(selectList != '') $('#selectList').val(selectList);
	
	$("#selectList").change(function(){
		document.getElementById("listForm").pageIndex.value = 1;
		document.getElementById("listForm").action = "<c:url value='/cms/sub8/0101.do'/>";
	   	document.getElementById("listForm").submit();
	});
	
	$("#assessList").change(function(){
		document.getElementById("listForm").pageIndex.value = 1;
		document.getElementById("listForm").action = "<c:url value='/cms/sub8/0101.do'/>";
	   	document.getElementById("listForm").submit();
	});
});

 // -->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		<input type="hidden" name="screenMode" />
	    <input type="hidden" name="siteId" />
	    <input type="hidden" name="cntId" id="cntId" />
	    <input type="hidden" name="url" id="url" />
	    <input type="hidden" name="type" id="type" />
	    <input type="hidden" name="host" id="host" />
	    <c:set var="webRoot" value="${fn:replace(pageContext.request.requestURL,pageContext.request.requestURI,'')}"/>	    
	    
		<div class="row-fluid">			
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<select id="selectList" name="selectList">
							<option value="10" selected="selected">10개</option>
							<option value="50">50개</option>
				            <option value="100">100개</option>
				            <option value="200">200개</option>
				            <option value="300">300개</option>
				        </select>
				        <select name="assessList" id="assessList">
				        	<option value="0" selected="selected">평가 대기</option>
				        	<option value="1">평가 완료</option>				        	
				        	<option value="3">평가 제외</option>
				        </select>			
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered" id="defaultTable">
					        <caption>콘텐츠 리스트</caption>
					        <thead>
					            <tr>
					            	<th>구분</th>					            	
					                <th>메뉴경로</td>					                					                
					                <th>웹표준</td>
					                <th>웹표준(css)</td>
					                <th>웹접근성</td>					                
					                <th>관리</td>
					            </tr>
					        </thead>
					        <tbody>
					        <c:forEach var="result" items="${resultList}" varStatus="status">
					            <tr>
					            	<td>
					            		<c:choose>
					            		 	<c:when test="${result.cntWebStandard == 0 && result.cntWebStandardCss == 0 && result.cntWebAccess == 0 }">
					            		 		<c:out value="평가대기" />
					            		 	</c:when>
					            		 	<c:when test="${result.cntWebStandard == 3 && result.cntWebStandardCss == 3 && result.cntWebAccess == 3 }">
					            		 		<c:out value="평가제외" />
					            		 	</c:when>
					            		 	<c:when test="${result.cntWebStandard == 1 && result.cntWebStandardCss == 1 && result.cntWebAccess == 1 }">
					            		 		<c:out value="평가완료" />
					            		 	</c:when>
					            		 	<c:otherwise>
					            		 		<c:out value="평가대기" />
					            		 	</c:otherwise>
										</c:choose>		            		
					            	</td>
					            	<%-- <td>${status.count }</td> --%>
					                <td><a href="<c:url value="${menuPathMap[result.cntId]}"/>" title="새창" target="_blank" ><c:out value="${menuNameMap[result.cntId]}"/></a></td>
					                <%-- <td><c:out value="${result.menuNm}"/></td>
					                <td><c:out value="${result.tplNm}"/></td> --%>					                					                
					                <%-- <td><c:out value="${menuPathMap[result.cntId]}"/></td> --%>
					                <td><%-- 웹표준 --%>
					                	<c:if test="${result.cntWebStandard == 0 }">
					                		<a href="#" class="btn btn-info btn-small"><c:out value="평가대기"/></a>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="standard"/>');" class="btn btn-small">평가하기</a>&nbsp;
					                	</c:if>
					                	<c:if test="${result.cntWebStandard == 1 }">
					                		<a href="#" class="btn btn-success btn-small"><c:out value="최종합격"/></a>
					                	</c:if>
					                	<c:if test="${result.cntWebStandard == 2 }">
					                		<a href="http://validator.w3.org/check?uri=${webRoot }<c:url value="${menuPathMap[result.cntId]}"/>" title="새창" target="_blank" class="btn btn-danger btn-small"><c:out value="-불 합 격-"/></a>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="standard"/>');" class="btn btn-small">재평가하기</a>&nbsp;
					                	</c:if>
					                	<c:if test="${result.cntWebStandard == 3 }">
					                		<a href="#" class="btn btn-inverse btn-small"><c:out value="평가제외"/></a>
					                	</c:if>
					                	<c:if test="${result.cntWebStandard == 4 }">
					                		<a href="http://validator.w3.org/check?uri=${webRoot }<c:url value="${menuPathMap[result.cntId]}"/>" title="새창" target="_blank" class="btn btn-warning btn-small"><c:out value="-재 검 사-"/></a><br />
					                		<font color="red">서버와의 연결이 <br /> 원할하지 않습니다</font>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="standard"/>');" class="btn btn-small">재평가하기</a>&nbsp;
					                	</c:if>					                							                	
					                </td>
					                <td><%-- 웹표준(css) --%>
					                	<c:if test="${result.cntWebStandardCss == 0 }">
					                		<a href="#" class="btn btn-info btn-small"><c:out value="평가대기"/></a>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="standardCss"/>');" class="btn btn-small">평가하기</a>&nbsp;
					                	</c:if>
					                	<c:if test="${result.cntWebStandardCss == 1 }">
					                		<a href="#" class="btn btn-success btn-small"><c:out value="최종합격"/></a>					                		
					                	</c:if>
					                	<c:if test="${result.cntWebStandardCss == 2 }">
					                		<a href="http://jigsaw.w3.org/css-validator/validator?uri=${webRoot }<c:url value="${menuPathMap[result.cntId]}"/>" title="새창" target="_blank" class="btn btn-danger btn-small"><c:out value="-불 합 격-"/></a>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="standardCss"/>');" class="btn btn-small">재평가하기</a>&nbsp;
					                	</c:if>
					                	<c:if test="${result.cntWebStandardCss == 3 }">
					                		<a href="#" class="btn btn-inverse btn-small"><c:out value="평가제외"/></a>
					                	</c:if>
					                	<c:if test="${result.cntWebStandardCss == 4 }">
					                		<a href="http://jigsaw.w3.org/css-validator/validator?uri=${webRoot }<c:url value="${menuPathMap[result.cntId]}"/>" title="새창" target="_blank" class="btn btn-warning btn-small"><c:out value="-재 검 사-"/></a><br />
					                		<font color="red">서버와의 연결이 <br /> 원할하지 않습니다</font>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="standardCss"/>');" class="btn btn-small">재평가하기</a>&nbsp;
					                	</c:if>
					                							                	
					                </td>
					                <td><%-- 웹접근성 --%>					                	
					                	<c:if test="${result.cntWebAccess == 0 }">
					                		<a href="#" class="btn btn-info btn-small"><c:out value="평가대기"/></a>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="access"/>');" class="btn btn-small">평가하기</a>&nbsp;
					                	</c:if>
					                	<c:if test="${result.cntWebAccess == 1 }">
					                		<a href="#" class="btn btn-success btn-small"><c:out value="최종합격"/></a>					                		
					                	</c:if>
					                	<c:if test="${result.cntWebAccess == 2 }">					                		
					                		<a href="${webRoot}/w3c/access/?url=${webRoot }<c:url value="${menuPathMap[result.cntId]}"/>/" title="새창" target="_blank" class="btn btn-danger btn-small"><c:out value="-불 합 격-"/></a>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="access"/>');" class="btn btn-small">재평가하기</a>&nbsp;
					                	</c:if>
					                	<c:if test="${result.cntWebAccess == 3 }">
					                		<a href="#" class="btn btn-inverse btn-small"><c:out value="평가제외"/></a>
					                	</c:if>
					                	<c:if test="${result.cntWebAccess == 4 }">
					                		<a href="${webRoot}/w3c/access/?url=${webRoot }<c:url value="${menuPathMap[result.cntId]}"/>/" title="새창" target="_blank" class="btn btn-warning btn-small"><c:out value="-재 검 사-"/></a>
					                		<font color="red">서버와의 연결이 <br /> 원할하지 않습니다</font>
					                		<br /><a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="access"/>');" class="btn btn-small">재평가하기</a>&nbsp;
					                	</c:if>             	
					                </td>            
					                <td>
					                	<a href="javascript:fn_egov_edit('<c:out value="${result.cntId}"/>')" class="btn btn-small">콘텐츠수정</a><br />
					                	<c:choose>
					            		 	<c:when test="${result.cntWebStandard == 0 && result.cntWebStandardCss == 0 && result.cntWebAccess == 0 }">					            		 		
					            		 		<a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="except"/>');" class="btn btn-inverse btn-small">평 가 제 외</a>
					            		 	</c:when>
					            		 	<c:when test="${result.cntWebStandard == 3 || result.cntWebStandardCss == 3 || result.cntWebAccess == 3 }">					            		 		
					            		 		<a href="javascript:webStandard('<c:out value="${result.cntId }"/>','<c:out value="${menuPathMap[result.cntId]}"/>','<c:out value="restore"/>');" class="btn btn-inverse btn-small">평 가 복 구</a>
					            		 	</c:when>		            		 	
										</c:choose>
					                </td>
					            </tr>
					        </c:forEach>
					        </tbody>
					    </table>				
					</div>
				</div>
			</div>			
		</div>
		<div id="page_navi" class="pagination">
			<ui:pagination paginationInfo = "${paginationInfo}"
					   type="jnitDefault"
					   jsFunction="fn_egov_link_page"
					   />
			<form:hidden path="pageIndex" />
		</div>
		<div class="row-fluid">
			<div class="widget-box">
				<div class="widget-content nopadding cmstipbox">
					<table class="table table-bordered table-striped th_left">
					<caption>cms TIP</caption>
					<tbody>
					<tr>
						<th colspan="2">
							<span class="icon" style=" font-size: 20px; font-weight: bold; "><i class="icon-lightbulb"></i> TIP</span>
						</th>
						<td>
							<b>웹표준/웹표준(css) 평가 서비스를 제공하는 외부 사이트에서 평가 합니다.</b><br />
							<b>웹표준 - http://validator.w3.org</b><br />
							<b>웹표준(css) - http://jigsaw.w3.org</b><br />
							<b>웹접근성 - ??</b>
						</td>
					</tr>
					</tbody>
					</table>
				</div>
			</div>
		</div>
		</form:form>
		
		<!-- <form id="accessForm" action="http://accessibility.kr/nia/check.php" id='loadform' method="post"  class="well" style="opacity:0">
			<textarea id="textUrl" name="url" rows="10" cols="80" style="display: none"></textarea>
		</form> -->										
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
