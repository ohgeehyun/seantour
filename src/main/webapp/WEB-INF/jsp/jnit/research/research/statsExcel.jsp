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
<title>설문조사 통계</title>
<%

  response.setHeader("Content-Type", "application/vnd.ms-xls");

  response.setHeader("Content-Disposition", "inline; filename=researchAnswer.xls");

%>
</head>

<div id="content">
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"><i class="icon-th"></i></span>
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
														<tbody>
															<tr>
																<th width="15%">질문${Qnum}</th>
																<td width="8%"></td>
																<td width="60%"><strong><c:out value="${queResult.questionNm}"/></strong>
																</td>
																<td></td>
															</tr>
															<c:if test='${fn:length(ansListResult) != 0 }'>
																<c:set var="Anum" value="0" />
																<c:forEach var="ansResult" items="${ansListResult}" varStatus="status">
																	<c:if test='${queResult.questionId == ansResult.questionId }'>
																		<c:if test='${ansResult.type != 9}'>
																		<c:set var="Anum" value="${Anum +1}" />
																		<tr> 
																			<td>답${Anum}</td>
																			<td>
																				<c:out value="${ansResult.answerNm}"/>
																			</td> 
																			<td>
																				<c:if test='${queResult.type != 2}'>
																					<c:set var="AnsId" value="${ansResult.answerId}"/>
																					득표수 :
																					${answerCount[ansResult.answerId]} / ${answerFullCount[ansResult.answerId]}<br/>
																					<fmt:formatNumber minFractionDigits="1" maxFractionDigits="1" value="${100 * (answerCount[ansResult.answerId] / answerFullCount[ansResult.answerId])}" />%
																				</c:if>
																				<%--
																				주관식 답변의 경우 개인별 통계를 받아주세요.
																				<c:if test='${queResult.type == 2}'>
																					<td>주관식답변</td>
																					<td>
																					<c:forEach var="rpdResult" items="${rpdList}" varStatus="status">
																						<c:if test="${rpdResult.answerId == ansResult.answerId}">
																							<c:if test="${rpdResult.answer != null && rpdResult.answer != ''}">
																								${rpdResult.answer}<br />
																							</c:if>
																						</c:if>
																					</c:forEach>
																					</td>
																				</c:if>
																				 --%>
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
																						<c:out value="${ansResult.answerNm}"/>
																					</td> 
																					<td>
																						<c:set var="AnsId" value="${ansResult.answerId}"/>
																						득표수 :
																						${answerCount[ansResult.answerId]} / ${answerFullCount[ansResult.answerId]}<br/>
																						<fmt:formatNumber minFractionDigits="1" maxFractionDigits="1" value="${100 * (answerCount[ansResult.answerId] / answerFullCount[ansResult.answerId])}" />%	
												                              			
												                              		</td>			
																				</tr>
																				<tr>
																					<td>기타답변</td>
																					<td>
																					<c:forEach var="rpdResult" items="${rpdList}" varStatus="status">
																						<c:if test="${rpdResult.answerId == ansResult.answerId}">
																							<c:if test="${rpdResult.orderAnswer != null && rpdResult.orderAnswer != ''}">
																								${rpdResult.orderAnswer}<br />
																							</c:if>
																						</c:if>
																					</c:forEach>
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