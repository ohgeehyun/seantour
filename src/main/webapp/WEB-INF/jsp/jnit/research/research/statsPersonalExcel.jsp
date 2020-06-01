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
							<table>
								<thead>
									<tr>
										<th style="font-size:1.4em; padding:8px 0;">개인별답변정보</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="person" items="${personRpdList}" varStatus="status">
									<tr>
										<td>
											${person.mbrLogin}(${person.mbrId})
										</td>
										<c:if test="${jnitresearchVO.nameOpen == 1}">
										<td>
											${person.mbrNm}
										</td>
										</c:if>
										<td>
											${person.questionNm}
										</td>
										<td>
											${person.answerNm}
										</td>
										<td>
											${person.answer}
										</td>
										<td>
											${person.orderAnswer}
										</td>
										<c:forEach var="ansResult" items="${ansListResult}" varStatus="status">
											<c:if test="${person.answerId == ansResult.answerId}">
												<c:if test="${ansResult.criterionOpt == 1}">
													<td>
														${ansResult.criterionCnt} 점
													</td>
												</c:if>
											</c:if>
										</c:forEach>
									</tr>
									</c:forEach>
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