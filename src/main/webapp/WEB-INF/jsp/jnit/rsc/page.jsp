<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javascript">
<!--
function fn_egov_excel(){	
	alert("기간과 사이트의 크기에 따라 다소 시간이 걸릴 수 있습니다.");
	document.getElementById("listForm").action = "<c:url value='/cms/rsc/excel/down.do'/>";
   	document.getElementById("listForm").submit();
}
var searchStats = function(){
	$('#listForm').attr('method','post');
	document.getElementById("listForm").pageIndex.value = "1";
	$('#listForm').submit();
};

$(document).ready(function(){	
	$("#date01").datepicker();
	$("#date02").datepicker();
	$('#listForm select[name=sitepath]').val("${param.sitepath}");
});

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "";
   	document.getElementById("listForm").submit();
}
//-->
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
			<input type="hidden" name="screenMode" />
			<input type="hidden" name="searchCondition" id="searchCondition" value="${searchVO.searchCondition}" />
			<input type="hidden" name="searchKeyword" id="searchKeyword" value="${searchVO.searchKeyword}" />
			<div class="row-fluid">
	           	<div class="span12">
	               	<div class="widget-box">
	                   	<div class="widget-title">
	                       	<h3>페이지별 평가 통계</h3>
	                       	<%-- <a href="javascript:fn_egov_selectList();" class="btn btn-small"><i class="icon-repeat"></i> 되돌아가기</a>
							<select name="sitepath" onchange="searchStats();">
								<option value=" ">--사이트선택--</option>
								<c:forEach var="entry" items="${siteCd_result}">
									<option value="${entry.value.cd}">${entry.value.nm}</option>
								</c:forEach>
							</select> --%>							
							<input type="text" name="date01" id="date01" value="${data01 }" /> ~ <input type="text" name="date02" id="date02" value="${data02 }" />
							<a href="javascript:fn_egov_excel();" class="btn btn-small">엑셀 다운로드</a>
	                    </div>
	                    <div class="widget-title" style="height: 20px;">
							<font color="red">* 기간을 입력하지 않으면 전체리스트를 엑셀 다운로드 할 수 있습니다.</font>
	                    </div>
	                    <div class="widget-content nopadding">
							<table class="table table-bordered table-striped table-hover" summary="페이지별 평가 통계">
								<thead>
									<tr>
										<th width="55%">페이지URL</td>
										<th>페이지제목</td>
										<th>조회수</th>
										<th>매우불만족</td>
										<th>불만족</td>
										<th>보통</td>
										<th>만족</td>
										<th>매우만족</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList}" var="result">
									<tr>
										<td><a href="<c:url value="${result.pageUrl}"/>" target="_blank"><c:out value="${result.pageUrl}" escapeXml="true" /></a></td>
										<td width="100" align="center"><c:out value="${result.menuNm}" escapeXml="true" /></td>
										<td width="100" align="center"><c:out value="${result.pageView}" escapeXml="true" /></td>
										<td width="100" align="center"><c:out value="${result.hit1}" escapeXml="true" /></td>
										<td width="100" align="center"><c:out value="${result.hit2}" escapeXml="true" /></td>
										<td width="100" align="center"><c:out value="${result.hit3}" escapeXml="true" /></td>
										<td width="100" align="center"><c:out value="${result.hit4}" escapeXml="true" /></td>
										<td width="100" align="center"><c:out value="${result.hit5}" escapeXml="true" /></td>
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
								<b>서브 페이지 하단에 노출되는 페이지 평가 정보를 한눈에 보실 수 있는 페이지입니다.</b><br />
								<b>기간을 설정하여 전체 페이지의 평가점수 및 평가메세지를 확인할 수 있습니다.</b><br />
								<b>삽입 코드</b><br />
								<b>&lt;jsp:include page="/cms/import/rscPage.jsp"&gt;&lt;/jsp:include&gt;</b>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>