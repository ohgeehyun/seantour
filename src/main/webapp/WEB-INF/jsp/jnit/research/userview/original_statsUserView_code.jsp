<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
<!--
function popup_answer(answerId){
	
	var winUrl = "<c:url value='/answer/popup.do?answerId="+answerId+"&researchId=${researchId}'/>";
	var winZip = window.open(winUrl,"answerPop","width=500,height=400,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
function popup_orderAnswer(answerId){
	
	var winUrl = "<c:url value='/answer/popup.do?answerId="+answerId+"&mode=order&researchId=${researchId}'/>";
	var winZip = window.open(winUrl,"orderAnswerPop","width=500,height=400,top=0,left=0,scrollbars = yes");
	winZip.focus();
}
// -->
</script>
<form:form commandName="jnitresearchVO" name="jnitresearch" method="post">
<div class="research_list">
	<c:set var="AnswerCt" value="1" />
	<br />
	<p class="tit" style="text-align: center; font-size: 20px;"><strong><c:out value="${jnitresearchVO.researchNm}"/></strong></p>
	<dl>
		<c:if test='${fn:length(queListResult) != 0 }'>
		<c:set var="Qnum" value="0" />
		<c:set var="CountNum" value="0" />
		<c:forEach var="queResult" items="${queListResult}" varStatus="status"><!-- 문제의 갯수만큼  foreach 합니다 -->
			<c:set var="Qnum" value="${Qnum +1}" />
			<dt>		
				<img src="/images/research/Jnit_btn_q.gif" alt="질문" />
				<c:if test="${queResult.fileUrl != null && queResult.fileUrl != ''}"><!--문제의 이미지가 있다면,-->
					<img src="<c:url value="${queResult.fileUrl}"/>" width="${queResult.fileWidth}" height="${queResult.fileHeight}" />							
				</c:if>
				${Qnum}.<c:out value="${queResult.questionNm}"/>
			</dt>
			<dd>
				<c:if test='${fn:length(ansListResult) != 0 }'><!--답변의 갯수가 정상적인지를 체크하는 if문입니다-->
					<c:set var="Anum" value="0" />
					<ul>						
						<c:set var="AnswerCtAll" value="0" />
						<c:forEach var="ansResult" items="${ansListResult}" varStatus="status"> <!--답변을 Foreach 하는 함수입니다..-->
							<c:if test='${queResult.questionId == ansResult.questionId }'>
								<c:if test='${ansResult.type != 9}'>
									<c:set var="Anum" value="${Anum +1}" />
										<li>
											<label>
												${Anum}) <c:out value="${ansResult.answerNm}"/>	
												<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
													<br /><img src="<c:url value="${ansResult.fileUrl}"/>" width="${ansResult.fileWidth}" height="${ansResult.fileHeight}" /> 
												</c:if>
											</label>
											<c:if test='${queResult.type != 2}'><!-- 문제가 주관식이 아니라면-->
											<br />
											<span class="grap">
												<b style="width:${100 * (answerCount[ansResult.answerId] / answerFullCount[ansResult.answerId])}%;">&nbsp;</b>
											</span>
											</c:if>
											<em>										
												<c:if test='${queResult.type != 2}'><!-- 문제가 주관식이 아니라면-->
												<c:set var="AnsId" value="${ansResult.answerId}"/>
												득표수 :
												${answerCount[ansResult.answerId]} / ${answerFullCount[ansResult.answerId]}
												(<fmt:formatNumber minFractionDigits="1" maxFractionDigits="1" value="${100 * (answerCount[ansResult.answerId] / answerFullCount[ansResult.answerId])}" />)	
												</c:if>

												<c:if test='${queResult.type == 2}'>
												<a class="anspop" href="javascript:popup_answer('${ansResult.answerId}')">주관식답변보기</a>
												</c:if>
												
												<c:set var="AnswerCt" value="${AnswerCt +1}" />
												<c:set var="CountNum" value="${CountNum +1}" />
											</em>
										</li>
									<c:set var="AnswerCtAll" value="${AnswerCtAll + answerCount[ansResult.answerId]}" />
								</c:if>
							</c:if>
						</c:forEach>
					</ul>
					<c:forEach var="ansResult" items="${ansListResult}" varStatus="status"> 
						<c:if test='${queResult.questionId == ansResult.questionId }'>
							<c:if test="${queResult.ordercheck == 1}">
								<c:if test='${ansResult.type == 9}'><!-- 답변이 기타의견일때입니다.-->
									<c:set var="Anum" value="${Anum +1}" />
										<ul>
											<li>
												<label>
													${Anum}) <c:out value="${ansResult.answerNm}"/>
													<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
														<br /><img src="<c:url value="${ansResult.fileUrl}"/>" width="${ansResult.fileWidth}" height="${ansResult.fileHeight}" />  
													</c:if>
												</label>
												<br />
												<span class="grap">
													<b style="width:${100 * (answerCount[ansResult.answerId] / answerFullCount[ansResult.answerId])}%;">&nbsp;</b> <!--  -->
												</span>
												<em>
													<c:set var="AnsId" value="${ansResult.answerId}"/>
													득표수 :
													${answerCount[ansResult.answerId]} / ${answerFullCount[ansResult.answerId]}
													(<fmt:formatNumber minFractionDigits="1" maxFractionDigits="1" value="${100 * (answerCount[ansResult.answerId] / answerFullCount[ansResult.answerId])}" />)		
													
													<a class="anspop" href="javascript:popup_orderAnswer('${ansResult.answerId}')">기타답변보기</a>
																						
												</em>
											</li>
										</ul>
									<c:set var="AnswerCt" value="${AnswerCt +1}" />
									<c:set var="CountNum" value="${CountNum +1}" />
								</c:if>
							</c:if>
						</c:if>	 
					</c:forEach>
				</c:if>
			</dd>								
	   </c:forEach>
	</c:if>		
	</dl> 	
	<div class="row-fluid">
		<div class="span3 listbtn">
			<a href="?mode=list" class="btn btn"><i class="icon-repeat"></i>목록</a>
		</div>
	</div>

</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/><input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/> <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>           
</form:form>