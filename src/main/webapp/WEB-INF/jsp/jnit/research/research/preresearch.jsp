<%
/**
 *@version 3.2.0.1
 **/
%>
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<link type="text/css" href="/resources/research/Jnit_content.css" media='all' rel='stylesheet' />
<c:set var ="today" value = "<%=new Date()%>" />
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<script type="text/javascript">
<!--
var questionIdArr = new Array();
<c:forEach var="queResult" items="${queListResult}" varStatus="status">
	questionIdArr.push("${queResult.questionId}");
</c:forEach>
$(document).ready(function(){
	
	<c:forEach var="queResult" items="${queListResult}" varStatus="status">
		<c:if test="${queResult.type == 1}">
			setLimitForMultiAnswer('${queResult.questionId}',${queResult.answerCnt});
		</c:if>
	</c:forEach>
	<c:forEach var="queResult" items="${queListResult}" varStatus="status">
		<c:if test="${queResult.visible == 1}">
			$("#${queResult.questionId}").find("input").attr("disabled", "disabled");
		</c:if>
	</c:forEach>
	
}); 

function fnByte(obj, limitB,aNum){
	var str = obj.value;
	var str_len = str.length;
	
	var rByte = 0;
	var rlen =0;
	var one_char = "";
	var str2 = "";
	
	for(var i =0; i<str_len; i++){
		one_char = str.charAt(i);
		if(escape(one_char).length>4){
			rByte+=2;
		}else{
			rByte++;
		}
		
		if(rByte<=limitB){
			rlen=i+1;
		}
	}
	if(rByte>limitB){
		alert("한글"+(limitB/2)+"자 / 영문 "+limitB+"자를 초과 입력할 수 없습니다.");
		str2 = str.substr(0,rlen);                                  //문자열 자르기
	    obj.value = str2;
	    fnByte(obj, limitB, aNum);
	}else{
	    document.getElementById('byteInfo'+aNum).innerText = rByte;
	}
	
}

function setLimitForMultiAnswer (questionId,count) {
		var $answers = $("#"+questionId).find("input:checkbox[id^='resAnswer']");
		if ($answers.length > 0){ 
			$answers.on('click', function(){
				var l = $("#"+questionId).find("input:checkbox[id^='resAnswer']:checked").length;
				if (l > count) {
					$(this).attr('checked', false);
				}
			});
		}
}


function fnCheck(nm){
<%--
	if($('#'+nm).attr('disabled') == 'disabled'){
		$('#'+nm).attr('disabled',false);
	}else{
		$('#'+nm).attr('disabled',true);
		$('#'+nm).attr('value','');
	}
	--%>
}
function fnAnsopt(questionNums,move,visible){
	if(questionNums != "" && questionNums != null){
		var Num = questionNums.split(",");
		for(var i=0;i<Num.length;i++){
			if(visible == '0'){
				$("#"+questionIdArr[Num[i]-1]).css("display","");
				$("#"+questionIdArr[Num[i]-1]).find("input").removeAttr("disabled");
				if(move != ''){
					$('body, html').css('scrollTop', $("#"+questionIdArr[move-1]).offset().top);
					$('body, html').animate({ scrollTop: $("#"+questionIdArr[move-1]).offset().top }, 1000); 
					window.scrollTo(0, $("#"+questionIdArr[move-1]).offset().top);
				}
			}else if(visible == '1'){
				$("#"+questionIdArr[Num[i]-1]).css("display","none");
				$("#"+questionIdArr[Num[i]-1]).find("input").attr("disabled", "disabled");
				if(move != ''){
					$('body, html').css('scrollTop', $("#"+questionIdArr[move-1]).offset().top);
					$('body, html').animate({ scrollTop: $("#"+questionIdArr[move-1]).offset().top }, 1000); 
					window.scrollTo(0, $("#"+questionIdArr[move-1]).offset().top);
				}
			}
		}
	}
	if(move != "" && move != null){
		$("#"+questionIdArr[move]).focus();
	}
}


// -->
</script>

<form:form commandName="jnitresearchVO" name="jnitresearch" method="post">
<input type="hidden" name="researchId" id="researchId" value="${researchId}" />
<input type="hidden" id="returnUrl" name="returnUrl" />
<div class="research_list">
	<p class="tit" style="text-align: center; font-size: 20px;"><strong><c:out value="${jnitresearchVO.researchNm}"/></strong></p>
	<div class="research_content">
		${jnitresearchVO.introduce}
	</div>
	<c:set var="Qnum" value="0" />
	<c:set var="Anum" value="0" />
	<c:set var="radioNum" value="0" />
	
	<c:forEach var="queResult" items="${queListResult}" varStatus="status"><!-- 문제를 만드는 Foreach를 시작하는 함수입니다.-->
		<c:set var="Qnum" value="${Qnum +1}" />
		<c:set var="firstNum" value="0" />
		<dl id="${queResult.questionId}" <c:if test="${queResult.visible == 1}">style="display:none;"</c:if> >
			<dt>
				<img src="/images/research/Jnit_btn_q.gif" alt="질문" />
				${Qnum}.<c:out value="${queResult.questionNm}"/> <br/>
				<c:if test="${queResult.fileUrl != null && queResult.fileUrl != ''}"><!--문제의 이미지가 있다면,-->
					<img src="<c:url value="${queResult.fileUrl}"/>" width="${queResult.fileWidth}" height="${queResult.fileHeight}" />							
				</c:if>
			</dt>
			<dd>
				<c:if test='${queResult.type == 0}'><!--문제가 단일형일 때 적용되는 부분입니다 -->
				<c:set var="radioNum" value="${radioNum +1}" />
					<c:if test='${fn:length(ansListResult) != 0 }'>
						<c:forEach var="ansResult" items="${ansListResult}" varStatus="status"> 
							<c:if test='${queResult.questionId == ansResult.questionId }'>
								<c:if test='${ansResult.type != 9}'>
									<c:set var="Anum" value="${Anum +1}" />
									<ul 
										<c:if test="${queResult.lineup == 0}">
											class=research_lineup
										</c:if>
										<c:if test="${queResult.lineup != 0}">
											class=research_wlineup
										</c:if>
									>
										<li>
											<c:set var="orderAnswerId" value="${ansResult.answerId}" />
											<c:set var="firstNum" value="${firstNum + 1}" />
											<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
											<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
											<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
											<input type="hidden" name="restypeNum${Anum}" id="restypeNum${Anum}" value="${radioNum}" />
											<input type="radio" name="radioAnswer${radioNum}" id="radioAnswer${radioNum}" value='${ansResult.answerId}' 
												<c:if test="${ansResult.ansopt == 1}">
													onclick=javascript:fnAnsopt('${ansResult.ansoptNum}','${ansResult.ansoptMove}','${ansResult.ansoptVisible}');
												</c:if> 
											${firstNum == 1 ? 'checked="checked"' : ''} />
	
											<c:out value="${ansResult.answerNm}"/>
											<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
												<br /><img src="<c:url value="${ansResult.fileUrl}"/>" width="${ansResult.fileWidth}" height="${ansResult.fileHeight}" />     
											</c:if>
										</li>
									</ul>									
								</c:if>
								<c:if test="${queResult.ordercheck == 1}">
									<c:if test='${ansResult.type == 9}'>
										<c:set var="Anum" value="${Anum +1}" />
										<ul>
											<li>
												<c:set var="orderAnswerId" value="${ansResult.answerId}" />
												<c:set var="firstNum" value="${firstNum + 1}" />
												<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
												<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
												<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
												<input type="hidden" name="restypeNum${Anum}" id="restypeNum${Anum}" value="${radioNum}" />
												<input type="hidden" name="restypeOrder${Anum}" id="restypeOrder${Anum}" value="order" />
												<input type="radio" name="radioAnswer${radioNum}" id="radioAnswer${radioNum}" value='${ansResult.answerId}'  <c:out value="onclick=javascript:fnCheck('${orderAnswerId}');"/> ${firstNum == 1 ? 'checked="checked"' : ''} />
												<c:out value="${ansResult.answerNm}"/>
												<input type="text" name="orderAnswer${Anum}" onKeyUp="javascript:fnByte(this,'4000',${Anum})" id="" value="" class="order_answer" />
												<span id="byteInfo${Anum}">0</span>/4000Byte
												<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
													<br /><img src="<c:url value="${ansResult.fileUrl}"/>" width="${ansResult.fileWidth}" height="${ansResult.fileHeight}" />     
												</c:if>
											</li>
										</ul>									
									</c:if>
								</c:if>
							</c:if>
						</c:forEach>						
					</c:if>
				 </c:if><!--문제가 단일형일 때 적용되는 부분의 끝 입니다 -->

				  <c:if test='${queResult.type == 1}'><!--문제가 복수형일 때 적용되는 부분입니다 -->
					<c:if test='${fn:length(ansListResult) != 0 }'>						 
						 <c:forEach var="ansResult" items="${ansListResult}" varStatus="status"> 
							  <c:if test='${queResult.questionId == ansResult.questionId }'>
								<c:if test='${ansResult.type != 9}'>
									<c:set var="Anum" value="${Anum +1}" />
									<ul
										<c:if test="${queResult.lineup == 0}">
											class=research_lineup
										</c:if>
										<c:if test="${queResult.lineup != 0}">
											class=research_wlineup
										</c:if>
									>
										<li>
											<c:set var="orderAnswerId" value="${ansResult.answerId}" />
											<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
											<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
											<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
											
											<input type="checkbox" name="resAnswer${Anum}" id="resAnswer${Anum}" value="1"
												<c:if test="${ansResult.ansopt == 1}">
													onclick=javascript:fnAnsopt('${ansResult.ansoptNum}','${ansResult.ansoptMove}','${ansResult.ansoptVisible}');
												</c:if> 
											 />           
											
											<c:out value="${ansResult.answerNm}"/>
											<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
												<br /><img src="<c:url value="${ansResult.fileUrl}"/>" width="${ansResult.fileWidth}" height="${ansResult.fileHeight}" />          
											</c:if>
										
										</li>
									</ul>								
								</c:if>
								<c:if test="${queResult.ordercheck == 1}">
									<c:if test='${ansResult.type == 9}'>
										<c:set var="Anum" value="${Anum +1}" />
										<ul>
											<li>
												<c:set var="orderAnswerId" value="${ansResult.answerId}" />
												<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
												<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
												<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
												
												<input type="checkbox" name="resAnswer${Anum}" id="resAnswer${Anum}" value="1"<c:out value="onclick=javascript:fnCheck('${orderAnswerId}');"/> />           
												<c:out value="${ansResult.answerNm}"/>
												<input type="text" name="orderAnswer${Anum}" onKeyUp="javascript:fnByte(this,'4000',${Anum})" id="" value="" class="order_answer" />
												<span id="byteInfo${Anum}">0</span>/4000Byte
												<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
													<br /><img src="<c:url value="${ansResult.fileUrl}"/>" width="${ansResult.fileWidth}" height="${ansResult.fileHeight}" />          
												</c:if>
											
											</li>
										</ul>									
									</c:if>
								</c:if>
							  </c:if>
						</c:forEach>						
					</c:if>
				 </c:if><!--문제가 복수형일 때 적용되는 부분의 끝 입니다 -->

				 <c:if test='${queResult.type == 2}'><!--문제가 주관식일 때 적용되는 부분입니다 -->
					<c:if test='${fn:length(ansListResult) != 0 }'>						 
						<c:forEach var="ansResult" items="${ansListResult}" varStatus="status"> 
							  <c:if test='${queResult.questionId == ansResult.questionId }'>
								<c:if test='${ansResult.type != 9}'>
									<c:set var="Anum" value="${Anum +1}" />
									<ul
										<c:if test="${queResult.lineup == 0}">
											class=research_lineup
										</c:if>
										<c:if test="${queResult.lineup != 0}">
											class=research_wlineup
										</c:if>
									>
										<li>
											<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
											<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
											<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
														
											<c:out value="${ansResult.answerNm}"/>
											<c:if test="${queResult.answerForm == 0}">
												<input type="text" onKeyUp="javascript:fnByte(this,'4000',${Anum})" name="resAnswer${Anum}" id="resAnswer${Anum}"/>
												<span id="byteInfo${Anum}">0</span>/4000Byte
											</c:if>
											<c:if test="${queResult.answerForm == 1}">
												<textarea cols="50" rows="5" onKeyUp="javascript:fnByte(this,'4000',${Anum})" name="resAnswer${Anum}" id="resAnswer${Anum}"></textarea>
												<span id="byteInfo${Anum}">0</span>/4000Byte
											</c:if>
											<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
													<br /><img src="<c:url value="${ansResult.fileUrl}"/>" width="${ansResult.fileWidth}" height="${ansResult.fileHeight}" />          
											</c:if>
										</li>
									</ul>
								</c:if>
								<c:if test="${queResult.ordercheck == 1}">
									<c:if test='${ansResult.type == 9}'>
										<c:set var="Anum" value="${Anum +1}" />
										<ul>
											<li>
												<input type="hidden" name="resQid${Anum}" id="resQid${Anum}" value="${queResult.questionId}" />
												<input type="hidden" name="resAid${Anum}" id="resAid${Anum}" value="${ansResult.answerId}" />
												<input type="hidden" name="restype${Anum}" id="restype${Anum}" value="${queResult.type}" />
															
												<c:out value="${ansResult.answerNm}"/>
												<input type="text" name="orderAnswer${Anum}" onKeyUp="javascript:fnByte(this,'4000',${Anum})" id="" value="" class="order_answer" />
												<span id="byteInfo${Anum}">0</span>/4000Byte
												<c:if test="${ansResult.fileUrl != null && ansResult.fileUrl != ''}">
														<br /><img src="<c:url value="${ansResult.fileUrl}"/>" width="${ansResult.fileWidth}" height="${ansResult.fileHeight}" />          
												</c:if>
											</li>
										</ul>					
									</c:if>
								</c:if>
							  </c:if>
						</c:forEach>
					</c:if>
				 </c:if><!--문제가 주관식일 때 적용되는 부분의 끝 입니다 -->
			</dd>
		</dl>	
	</c:forEach><!--문제 작성 종료 -->	

	<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/><input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/> <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</div>
</form:form>