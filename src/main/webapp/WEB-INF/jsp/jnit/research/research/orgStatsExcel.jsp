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
<%

  response.setHeader("Content-Type", "application/vnd.ms-xls");

  response.setHeader("Content-Disposition", "inline; filename=researchAnswer.xls");

%>
<title>설문조사 통계</title>
</head>
<body>

<div id="content">
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
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
											<strong>${jnitresearchquestionVO.questionNm}</strong>
								                		
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
														<c:out value="${ansResult.answerNm}"/>&nbsp;&nbsp;
														
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
														<c:out value="${ansResult.answerNm}"/>&nbsp;&nbsp;
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