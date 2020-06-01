<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<link href="<c:url value='/css/egovframework/com/com.css' />" rel="stylesheet"  type="text/css">
<link href="<c:url value='/css/egovframework/com/button.css' />" rel="stylesheet"  type="text/css">
<link rel="stylesheet" href="<c:url value="/css/research/css/bootstrap.css" />" />
<link rel="stylesheet" href="<c:url value="/css/research/css/bootstrap-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/research/css/jquery-ui.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/research/css/jnit.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/research/css/jnit.main.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/research/css/jnit.dashboard.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/research/css/select.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/research/css/calendar.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/research/css/color_picker.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/research/css/date_picker.css"/>" />
<title>설문조사 통계</title>
<script src="<c:url value="/js/research/jquery.min.js"/> "></script>
<script src="<c:url value="/js/research/jquery.ui.latest.custom.min.js"/> "></script>
<script src="<c:url value="/js/research/jquery.ui.datepicker-ko.js" /> "></script>
<script src="<c:url value="/js/research/jquery.ui.timepicker.addon.js" /> "></script>
<script type="text/javascript">
function excel_download(){
	document.getElementById("jnitresearchVO").action = "<c:url value='/cms/research/orgStats.do?mode=excel'/>";
   	document.getElementById("jnitresearchVO").submit();
}
function search(){
	document.getElementById("jnitresearchVO").action = "<c:url value='/cms/research/orgStats.do'/>";
   	document.getElementById("jnitresearchVO").submit();
}
</script>
</head>
<body>

<div id="content">
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-th"></i></span>
						<a href="javascript:excel_download();" class="btn">엑셀 다운로드</a>
					</div>
					<div class="widget-content nopadding">
						<form:form commandName="jnitresearchVO" name="jnitresearch" enctype="multipart/form-data">
							<input type="hidden" name="researchId" id="researchId" value="${jnitresearchVO.researchId }" />
							<table class="table table-boerded table-striped table-hover" summary="질문에따른 부서별 답변 정보" style="margin-top:20px;">
								<%-- <caption>설문통계</caption> --%>
								<thead>
									<tr>
										<th style="font-size:1.4em; padding:8px 0;">질문에따른 부서별 답변 정보</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<select name="questionSelect" id="questionSelect" style="width:550px;">
												<option value=" ">--질문을 선택하세요--</option>
												 <c:forEach var="queResult" items="${queListResult}" varStatus="status">
								                			<option value="${queResult.questionId}" <c:if test="${queResult.questionId == jnitresearchquestionVO.questionId}">selected="selected"</c:if> >
								                				질문${status.count}.${queResult.questionNm}
								                			</option>
								                 </c:forEach>
											</select>
											<a href="javascript:search();" class="btn btn">검색</a>
										</td>
									</tr>
					                <c:forEach var="groupResult" items="${orgList}" varStatus="status">
					                <tr>
										<td>
					                		<strong><c:out value="${groupResult.orgnztNm}"/></strong>
					                	</td>
					                </tr>
					                	<c:set var="Anum" value="0" />
				                		<c:forEach var="ansResult" items="${ansListResult}" varStatus="status">
				                		
												<c:if test='${ansResult.type != 9}'>
												<c:set var="Anum" value="${Anum +1}" />
												<tr> 
													<td>
														<c:out value="${ansResult.answerNm}"/><br/>
														<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != '' }">
															<img src="<c:url value="${ansResult.fileUrl}"/>" width="100" height="100" >
														</c:if>
														<c:if test='${ansResult.type != 2}'>
															<c:set var="AnsId" value="${ansResult.answerId}"/>
															득표수 :
															<c:set var="tempName">${groupResult.orgnztId}${ansResult.answerId}</c:set>
															<c:set var="ansCount" value="${answerCount[tempName]}" />
															<c:set var="ansFullCount" value="${answerFullCount[tempName]}" />
															
															${answerCount[tempName]} 
															<c:if test="${answerCount[tempName] == null || answerCount[tempName] == ''}">
																0
																<c:set var="ansCount" value="0" />
															</c:if>
															/ 
															${answerFullCount[tempName]}
															<c:if test="${answerFullCount[tempName] == null || answerFullCount[tempName] == ''}">
																0
																<c:set var="ansFullCount" value="0" />
															</c:if>
															<c:if test="${ansCount == 0 || ansFullCount == 0}">
																&nbsp;&nbsp;&nbsp;0%
																
															</c:if>
															<c:if test="${ansCount != 0 && ansFullCount != 0}">
																&nbsp;&nbsp;&nbsp;<fmt:formatNumber minFractionDigits="1" maxFractionDigits="1" value="${100 * (ansCount / ansFullCount)}" />%
															</c:if>
															<br/>
														</c:if>
														<c:if test='${ansResult.type == 2}'>
															<c:forEach var="rpdResult" items="${rpdList}" varStatus="status">
																<c:if test="${rpdResult.answerId == ansResult.answerId}">
																<c:if test="${rpdResult.orgnztId == groupResult.orgnztId}">
																	<c:if test="${rpdResult.answer != null && rpdResult.answer != ''}">
																		${rpdResult.answer}<br />
																	</c:if>
																</c:if>
																</c:if>
															</c:forEach>
														</c:if>
													</td>			
												</tr>											
												</c:if>
										</c:forEach>
										<c:forEach var="ansResult" items="${ansListResult}" varStatus="status">
												<c:if test='${ansResult.type == 9}'>
												<c:if test="${jnitresearchquestionVO.ordercheck == 1}">
												<c:set var="Anum" value="${Anum +1}" />
												<tr> 
													<td>
														<c:out value="${ansResult.answerNm}"/><br/>
														득표수 :
														<c:set var="tempName">${groupResult.orgnztId}${ansResult.answerId}</c:set>
														<c:set var="ansCount" value="${answerCount[tempName]}" />
														<c:set var="ansFullCount" value="${answerFullCount[tempName]}" />
															${answerCount[tempName]} 
															<c:if test="${answerCount[tempName] == null || answerCount[tempName] == ''}">
																0
																<c:set var="ansCount" value="0" />
															</c:if>
															/ 
															${answerFullCount[tempName]}
															<c:if test="${answerFullCount[tempName] == null || answerFullCount[tempName] == ''}">
																0
																<c:set var="ansFullCount" value="0" />
															</c:if>
															<c:if test="${ansCount == 0 || ansFullCount == 0}">
																&nbsp;&nbsp;&nbsp;0%
															</c:if>
															<c:if test="${ansCount != 0 && ansFullCount != 0}">
																&nbsp;&nbsp;&nbsp;<fmt:formatNumber minFractionDigits="1" maxFractionDigits="1" value="${100 * (ansCount / ansFullCount)}" />%
															</c:if>
															
															<br/>
															<c:forEach var="rpdResult" items="${rpdList}" varStatus="status">
																<c:if test="${rpdResult.answerId == ansResult.answerId}">
																<c:if test="${rpdResult.orgnztId == groupResult.orgnztId}">
																	<c:if test="${rpdResult.answer != null && rpdResult.answer != ''}">
																		${rpdResult.orderAnswer}<br />
																	</c:if>
																</c:if>
																</c:if>
															</c:forEach>
													</td>			
												</tr>											
												</c:if>
												</c:if>
										</c:forEach>
										</td>
									</tr>
					                </c:forEach>
										
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
</body>
</html>