<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" >
<!--
function fn_egov_recover(histId){
	if(confirm("정말 복구 하시겠습니까?")){
		$.ajax({
			type:"post",
			url :"<c:url value='/cms/ajax/tpl/hist.do'/>",
			data:"histId="+histId
		}).done(function(data){			
			var json = $.parseJSON(data);	
			
			if(json.status == 'success'){
				alert("복구하였습니다.");
				$('#myModal').modal('hide');				
				
				if(json.tplType == 'B'){					
					location.href = json.ctxRoot+"/cms/sub4/010201upview.do?screenMode=up&tplId="+json.tplId;					
				}else if(json.path != '' && json.path != undefined){ //controller class json path					
					location.href = json.path;
				}else{					
					location.reload();
				}				
			}else{
				alert("복구를 하지 못했습니다.");
			}			
		});
	}	
}

/* pagination 페이지 링크 function */
function fn_egov_hist_page(pageNo){   	
   	$.ajax({
   		type:"post",
   		url:"<c:url value='/cms/ajax/tpl/hist/list.do'/>",
		data: "tplId="+$("#tplId").val()+"&pageIndex="+pageNo
   	}).done(function(data){   		
   		$("#histList").empty();
		$("#histList").append(data);		
   	});
}
 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
<input type="hidden" name="screenMode" />
<input type="hidden" name="histId" id="histId" />
<input type="hidden" name="tplId" id="tplId" value="<c:out value="${tplId }"/>" />
<div class="row-fluid">
	<div class="span12">
		<div class="widget-box">
			<!-- <div class="widget-title">
			
			</div> -->
			<div class="widget-content nopadding">
				<table class="table table-bordered">
					<tr>
						<th>생성일</th>
						<th>수정자</th>
						<th>아이피</th>
						<th>관리</th>
					</tr>
					<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>									
							<fmt:formatDate value="${dateMap[result.histId] }" pattern="yyyy-MM-dd HH:mm"/>
						</td>						
						<td><c:out value="${mbrNmMap[result.histId] }"/></td>
						<td><c:out value="${result.actIp }"/></td>
						<td><a href="javascript:fn_egov_recover('${result.histId }');" class="btn btn-small">선택</a></td>
					</tr>
					</c:forEach>
				</table>						
			</div>
		</div>
		<div id="page_navi" class="pagination">
			<ui:pagination paginationInfo = "${paginationInfo}"
					   type="jnitDefault"
					   jsFunction="fn_egov_hist_page"
					   />
			<form:hidden path="pageIndex" />
		</div>
	</div>
</div>
</form:form>