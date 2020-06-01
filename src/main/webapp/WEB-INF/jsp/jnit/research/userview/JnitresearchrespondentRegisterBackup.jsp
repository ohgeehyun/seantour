<%
/**
 *@version 3.2.0.1
 **/
%>
<%--
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javaScript" language="javascript" defer="defer">


$(document).ready(function(){
		
	//fnCheck();	
});
function fnCheck(nm){

	if($('#'+nm).attr('disabled') == 'disabled'){
		$('#'+nm).attr('disabled',false);
	}else{
		$('#'+nm).attr('disabled',true);
		$('#'+nm).attr('value','');
	}
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitresearchVO");
	frm.action = "<c:url value='/jnitresearch/addJnitresearchusercheck.do'/>";
    frm.submit();

}
</script>

<form:form commandName="jnitresearchVO" name="jnitresearch" method="post">
<input type="hidden" name="researchId" id="researchId" value="${researchId}" />

<div id="content">
	<div class="contentStyle">
 	<table width="665" class="research_write" summary="설문조사정보">
        <caption>설문정보</caption>
        <thead>
        	<tr>
            	<th style="font-size:1.4em; padding:8px 0;">설문정보&nbsp;
                </th>
            </tr>
        </thead>
		<tbody>
		<tr>
				<td><c:out value="${jnitresearchVO.researchNm}"/>&nbsp;</td>
		</tr>
		<tr>
				<td>${jnitresearchVO.introduce}</td>
		</tr>
		<td>   			
                        <c:set var="Qnum" value="0" />
                        <c:set var="Anum" value="0" />
                        <c:set var="radioNum" value="0" />
                        <c:forEach var="queResult" items="${queListResult}" varStatus="status">
                        <c:set var="Qnum" value="${Qnum +1}" />
                             <table width="665" class="research_write" summary="설문조사정보">
                            <caption>설문</caption>
                            <tbody>
                            	<tr>
									<th rowspan="100" width="20%">질문${Qnum}</th>
										<td>
											<c:out value="${queResult.questionNm}"/><br>
											<c:if test="${queResult.fileUrl != null && queResult.fileUrl != ''}">
                                                        <img src="<c:url value="${queResult.fileUrl}"/>" width="250" height="250" >
                                                        
                                        	</c:if>										
										</td>
								</tr>
							<c:if test='${queResult.type == 0}'>
							<c:set var="radioNum" value="${radioNum +1}" />
								<c:if test='${fn:length(ansListResult) != 0 }'>
                       				<c:forEach var="ansResult" items="${ansListResult}" varStatus="status"> 
                       				<%--	<c:forEach var="ansResult" items="${queResult.questionId == alist.questionId}" varStatus="status"> --%>
 <%--                      					  <c:if test='${queResult.questionId == ansResult.questionId }'>
                       					  	<c:if test='${ansResult.type != 9}'>
                       					<c:set var="Anum" value="${Anum +1}" />
										<tr>
											<c:set var="orderAnswerId" value="${ansResult.answerId}" />
											<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
											<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
											<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
											<td width="106px"><input type="radio" name="radioAnswer${radioNum}" id="radioAnswer${radioNum}" value='${ansResult.answerId}'  <c:out value="onclick=javascript:fnCheck('${orderAnswerId}');"/> />
											
												<c:out value="${ansResult.answerNm}"/> <br/>
												<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
                                                        <img src="<c:url value="${ansResult.fileUrl}"/>" width="100" height="100" >     
                                        		</c:if>
											</td>
										</tr>
											</c:if>
										  </c:if>
									</c:forEach>
									<c:forEach var="ansResult" items="${ansListResult}" varStatus="status"> 
                       					  <c:if test='${queResult.questionId == ansResult.questionId }'>
											 <c:if test='${queResult.ordercheck == 1}'>
											 	<c:if test='${ansResult.type == 9}'>
											 		<c:set var="orderAnswerId" value="${ansResult.answerId}" />
											 		 <td width="106px"><input type="radio" name="radioAnswer${radioNum}" id="radioAnswer${radioNum}" value='${ansResult.answerId}'  <c:out value="onclick=javascript:fnCheck('${orderAnswerId}');"/> />
													 기타:<input type="text" name="${orderAnswerId}" id="${orderAnswerId}" disabled="disabled"/>
													 </td>
											 	</c:if>
											 </c:if>
										  </c:if>
									</c:forEach>

								</c:if>
							 </c:if>
							 <c:if test='${queResult.type == 1}'>
								<c:if test='${fn:length(ansListResult) != 0 }'>
									 
                       				 <c:forEach var="ansResult" items="${ansListResult}" varStatus="status">
                       					  <c:if test='${queResult.questionId == ansResult.questionId }'>
                       					  	<c:if test='${ansResult.type != 9}'>
                       					<c:set var="Anum" value="${Anum +1}" />
										<tr>
											<c:set var="orderAnswerId" value="${ansResult.answerId}" />
											<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
											<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
											<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
											<td width="106px"><input type="checkbox" name="resAnswer${Anum}" id="resAnswer${Anum}" value="1" <c:out value="onclick=javascript:fnCheck('${orderAnswerId}');"/> />           
											
												<c:out value="${ansResult.answerNm}"/> <br/>
												<c:if test="${ansResult.fileUrl != null  && ansResult.fileUrl != '' }">
                                                        <img src="<c:url value="${ansResult.fileUrl}"/>" width="100" height="100" >          
                                        		</c:if>
											</td>
										</tr>
											
										  	</c:if>
										  </c:if>
									</c:forEach>
									<c:forEach var="ansResult" items="${ansListResult}" varStatus="status"> 
                       					  <c:if test='${queResult.questionId == ansResult.questionId }'>
											 <c:if test='${queResult.ordercheck == 1}'>
											 	<c:if test='${ansResult.type == 9}'>
											 		<c:set var="orderAnswerId" value="${ansResult.answerId}" />
											 		 <td width="106px"><input type="checkbox" name="resAnswer${Anum}" id="resAnswer${Anum}" value="1" <c:out value="onclick=javascript:fnCheck('${orderAnswerId}');"/> />
													 기타:<input type="text" name="${orderAnswerId}" id="${orderAnswerId}" disabled="disabled"/>
													 </td>
											 	</c:if>
											 </c:if>
										  </c:if>
									</c:forEach>
								</c:if>
							 </c:if>
							 
							  <c:if test='${queResult.type == 2}'>
								<c:if test='${fn:length(ansListResult) != 0 }'>
									 
                       				 <c:forEach var="ansResult" items="${ansListResult}" varStatus="status">
                       					  <c:if test='${queResult.questionId == ansResult.questionId }'>
                       					  	<c:if test='${ansResult.type != 9}'>
                       					<c:set var="Anum" value="${Anum +1}" />
										<tr>
											<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
											<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
											<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
											<td width="106px">
											
												<c:out value="${ansResult.answerNm}"/> <br>
												<input type="text" name="resAnswer${Anum}" id="resAnswer${Anum}"/>
												<c:if test="${ansResult.fileUrl != null  && ansResult.fileUrl != '' }">
                                                        <img src="<c:url value="${ansResult.fileUrl}"/>" width="100" height="100" >          
                                        		</c:if>
											</td>
										</tr>
											</c:if>
										  </c:if>
									</c:forEach>
								</c:if>
							 </c:if>
                            </tbody>
                        	</table>
                        </c:forEach>
    	          	
			</td>		

		</tbody>
	</table>
	<p class="FloatRight"><a href="javascript:fn_egov_save();" class="research_write">설문제출</a></p>
	<p class="FloatRight MAR20"><a href="javascript:history.back();" class="list_go"><span>목록</span></a></p>
	</div>
</div>
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>

--%>

