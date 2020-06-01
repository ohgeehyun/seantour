<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javaScript" language="javascript" defer="defer">
function popup_answer(answerId){
	var winUrl = "<c:url value='/answer/popup.do?answerId="+answerId+"&researchId=${researchId}'/>";
	var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
function popup_orderAnswer(answerId){
	var winUrl = "<c:url value='/answer/popup.do?answerId="+answerId+"&mode=order&researchId=${researchId}'/>";
	var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
function answer_excel(answerId){
	var winUrl = "<c:url value='/answer/popup.do?answerId="+answerId+"&mode=excel'/>";
	var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
function list(){
	document.getElementById("jnitresearchVO").action = "<c:url value='/cms/research/List.do'/>";
   	document.getElementById("jnitresearchVO").submit();
}
function excel_download(researchId){
	//var winUrl = "<c:url value='/cms/research/stats.do?researchId="+researchId+"&mode=excel'/>";
	//var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0,scrollbars = yes");
	//winZip.focus();
	document.getElementById("jnitresearchVO").action = "<c:url value='/cms/research/stats.do?researchId="+researchId+"&mode=excel'/>";
   	document.getElementById("jnitresearchVO").submit();
}
function personalExcel_download(researchId){
	//var winUrl = "<c:url value='/cms/research/stats.do?researchId="+researchId+"&mode=excel'/>";
	//var winZip = window.open(winUrl,"windowZip","width=500,height=400,top=0,left=0,scrollbars = yes");
	//winZip.focus();
	document.getElementById("jnitresearchVO").action = "<c:url value='/cms/research/stats.do?researchId="+researchId+"&mode=PersonalExcel'/>";
   	document.getElementById("jnitresearchVO").submit();
}


function org_search(researchId){
	var winUrl = "<c:url value='/cms/research/orgStats.do?researchId="+researchId+"'/>";
	var winZip = window.open(winUrl,"windowZip","width=800,height=600,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
</script>

<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-th"></i></span>
						<h3>기본테이블</h3>
						<a href="javascript:list();" class="btn btn"><i class="icon-repeat"></i>목록</a>
						<a href="javascript:excel_download('${jnitresearchVO.researchId}');" class="btn">엑셀 다운로드</a>
						<a href="javascript:personalExcel_download('${jnitresearchVO.researchId}');" class="btn">개인별 답변</a>
						
						<%-- <a href="javascript:org_search('${jnitresearchVO.researchId}');" class="btn">질문별 부서통계</a> --%>
					</div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitresearchVO" name="jnitresearch" enctype="multipart/form-data">
							<c:set var="AnswerCt" value="1" />	
							<table class="table table-boerded table-striped table-hover" summary="설문정보" style="margin-top:20px;">
								<%-- <caption>설문통계</caption> --%>
								<thead>
									<tr>
										<th style="font-size:1.4em; padding:8px 0;">설문통계정보&nbsp;</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<c:if test='${fn:length(queListResult) != 0 }'>
												<c:set var="Qnum" value="0" />
												<c:set var="CountNum" value="0" />
												<c:forEach var="queResult" items="${queListResult}" varStatus="status">
													<c:set var="Qnum" value="${Qnum +1}" />
													<table class="table table-boerded table-striped table-hover" summary="설문정보" style="margin-top:20px;">
														<%-- <caption>설문</caption> --%>
														<tbody>
															<tr>
																<th rowspan="200" width="15%">질문${Qnum}</th>
																<td width="8%">질문</td>
																<td width="60%"><strong><c:out value="${queResult.questionNm}"/></strong><br/>
																	<c:if test="${queResult.fileUrl != null && queResult.fileUrl != ''}">
																		<img src="<c:url value="${queResult.fileUrl}"/>" width="150" height="150" >
																	</c:if>
																</td>
																<td></td>
															</tr>
															<c:if test='${fn:length(ansListResult) != 0 }'>
																<c:set var="Anum" value="0" />
																<c:forEach var="ansResult" items="${ansListResult}" varStatus="status">
																	<%--<c:forEach var="ansCountResult" items="${answerCount}" varStatus="anstatus">--%>
																
																	<c:if test='${queResult.questionId == ansResult.questionId }'>
																		<c:if test='${ansResult.type != 9}'>
																		<c:set var="Anum" value="${Anum +1}" />
																		<tr> 
																			<td>답${Anum}</td>
																			<td>
																				<c:out value="${ansResult.answerNm}"/><br/>
																				<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != '' }">
																					<img src="<c:url value="${ansResult.fileUrl}"/>" width="100" height="100" >
																				</c:if>
																			</td> 
																			<td>
																				<c:if test='${queResult.type != 2}'>
																					<c:set var="AnsId" value="${ansResult.answerId}"/>
																					
																					득표수 :
																					${answerCount[ansResult.answerId]} / ${answerFullCount[ansResult.answerId]}<br/>
																					<c:if test="${answerCount[ansResult.answerId] == 0 || answerFullCount[ansResult.answerId] == 0}">
																						&nbsp;&nbsp;&nbsp;0%
																					</c:if>
																					<c:if test="${answerCount[ansResult.answerId] != 0 && answerFullCount[ansResult.answerId] != 0}">
																						&nbsp;&nbsp;&nbsp;<fmt:formatNumber minFractionDigits="1" maxFractionDigits="1" value="${100 * (answerCount[ansResult.answerId] / answerFullCount[ansResult.answerId])}" />%
																					</c:if>
																						
																				</c:if>
																				<c:if test='${queResult.type == 2}'>
																					<a class="anspop" href="javascript:popup_answer('${ansResult.answerId}')">주관식답변보기</a>
																				</c:if>
																			</td>			
																		</tr>
																		<c:set var="AnswerCt" value="${AnswerCt +1}" />
																		<c:set var="CountNum" value="${CountNum +1}" />											
																		</c:if>
																	</c:if>	 
																</c:forEach>
																<c:forEach var="ansResult" items="${ansListResult}" varStatus="status">
																	<c:if test='${queResult.questionId == ansResult.questionId }'>
																		<c:if test="${queResult.ordercheck == 1}">
																		<c:if test='${ansResult.type == 9}'>
																			<c:set var="Anum" value="${Anum +1}" />
																			<tr> 
																				<td>답${Anum}</td>
																				<td>
																					<c:out value="${ansResult.answerNm}"/><br/>
																					
																					<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != '' }">
																						<img src="<c:url value="${ansResult.fileUrl}"/>" width="100" height="100" >  
																					</c:if>
																				</td> 
																				<td>
																					<c:set var="AnsId" value="${ansResult.answerId}"/>
																					득표수 :
																					${answerCount[ansResult.answerId]} / ${answerFullCount[ansResult.answerId]}<br/>
																					<c:if test="${answerCount[ansResult.answerId] == 0 || answerFullCount[ansResult.answerId] == 0}">
																						&nbsp;&nbsp;&nbsp;0%
																					</c:if>
																					<c:if test="${answerCount[ansResult.answerId] != 0 && answerFullCount[ansResult.answerId] != 0}">
																						&nbsp;&nbsp;&nbsp;<fmt:formatNumber minFractionDigits="1" maxFractionDigits="1" value="${100 * (answerCount[ansResult.answerId] / answerFullCount[ansResult.answerId])}" />%
																					</c:if>
											                              			<a class="anspop" href="javascript:popup_orderAnswer('${ansResult.answerId}')">기타답변보기</a>
											                              		</td>			
																			</tr>
																			<c:set var="AnswerCt" value="${AnswerCt +1}" />
																			<c:set var="CountNum" value="${CountNum +1}" />
																		</c:if>
																		</c:if>
																	</c:if>	 
																</c:forEach>
															</c:if>
														</tbody>
													</table>
												</c:forEach>
											</c:if>
										</td>
									</tr>
								</tbody>
							</table>	
							<!-- 검색조건 유지 -->
							<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
							<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>