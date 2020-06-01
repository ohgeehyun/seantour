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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>페이지 만족도평가</title>
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/rsc/Jnit_research.css"/>" media="screen"   />
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/rsc/Jnit_base.css"/>" media="screen"   />
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"/>" />

<script type="text/javascript" src="<c:url value="/resources/js/jquery.min.js"/>" ></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.latest.custom.min.js"/> "></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.datepicker-ko.js" /> "></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.ui.timepicker.addon.js" /> "></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.peity.min.js"/>" ></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.flot.min.js"/>" ></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.flot.resize.min.js"/>" ></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.dataTables.min.js"/>" ></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.uniform.js"/>" ></script>
<script src="<c:url value="/resources/js/jquery.plugins/jquery.fullcalendar.min.js"/>" ></script>
<script src="<c:url value="/resources/js/excanvas.min.js"/>" ></script>   
<script type="text/javascript">
<!--	
function fn_egov_close(){
	window.opener.location.reload();
	window.close();
}
function fn_egov_find_bln(){
	var uri = $("#uri").val();
	var date01 = $("#date01").val();
	var date02 = $("#date02").val();
	
	if(uri == '' || uri == null){
		alert("오류가 있습니다 - uri : null");
		return false;
	}else if(date01 == '' || date01 == null){
		alert("시작일을 입력해주시기 바랍니다.");
		$("#date01").focus();
		return false;
	}else if(date02 == '' || date02 == null){
		alert("종료일 입력해주시기 바랍니다.");
		$("#date02").focus();
		return false;
	}
	return true;
}

function fn_egov_find(){
	var uri = $("#uri").val();
	frm = document.getElementById("pageform");
	frm.action = "<c:url value='/user/res/pagePopup.do'/>?uri="+uri;
	frm.submit();
}

$(document).ready(function(){
	$("#date01").datepicker();
	$("#date02").datepicker();
});

//-->	
</script>
</head>
<body>
	<form  name="pageform" id="pageform" action="" method="post">
	<input type="hidden" name="uri" id="uri" value="${pagePath }" />
	<input type="hidden" name="condition" id="condition" value="${condition }" />
	<c:if test="${condition != 'search' }"><!-- 통계  -->
		<c:set var="rscPeople" value="${jnitrscpageVO.hit1+jnitrscpageVO.hit2+jnitrscpageVO.hit3+jnitrscpageVO.hit4+jnitrscpageVO.hit5}" />
		<c:set var="maxHit" value="${jnitrscpageVO.hit1}" /><c:set var="maxHitStr" value="매우불만족" />
		<c:if test="${maxHit <= jnitrscpageVO.hit2}"><c:set var="maxHit" value="${jnitrscpageVO.hit2}" /><c:set var="maxHitStr" value="불만족" /></c:if>
		<c:if test="${maxHit <= jnitrscpageVO.hit3}"><c:set var="maxHit" value="${jnitrscpageVO.hit3}" /><c:set var="maxHitStr" value="보통" /></c:if>
		<c:if test="${maxHit <= jnitrscpageVO.hit4}"><c:set var="maxHit" value="${jnitrscpageVO.hit4}" /><c:set var="maxHitStr" value="만족" /></c:if>
		<c:if test="${maxHit <= jnitrscpageVO.hit5}"><c:set var="maxHit" value="${jnitrscpageVO.hit5}" /><c:set var="maxHitStr" value="매우만족" /></c:if>
		
		<c:set var="hit1" value="${jnitrscpageVO.hit1 }" />
		<c:set var="hit2" value="${jnitrscpageVO.hit2 }" />
		<c:set var="hit3" value="${jnitrscpageVO.hit3 }" />
		<c:set var="hit4" value="${jnitrscpageVO.hit4 }" />
		<c:set var="hit5" value="${jnitrscpageVO.hit5 }" />
		
		<c:set var="hit1Per" value="${(272 * (jnitrscpageVO.hit1 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit1 / rscPeople) }" />
		<c:set var="hit2Per" value="${(272 * (jnitrscpageVO.hit2 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit2 / rscPeople) }" />
		<c:set var="hit3Per" value="${(272 * (jnitrscpageVO.hit3 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit3 / rscPeople) }" />
		<c:set var="hit4Per" value="${(272 * (jnitrscpageVO.hit4 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit4 / rscPeople) }" />
		<c:set var="hit5Per" value="${(272 * (jnitrscpageVO.hit5 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit5 / rscPeople) }" />
	</c:if>
	<c:if test="${condition == 'search' }"><!-- 기간 조건 검색시   -->
		<c:set var="rscPeople" value="${rscMaxPeople}" />
		<c:set var="maxHit" value="${rscMaxHit}" />
		<c:set var="maxHitStr" value="${srcMaxHitStr }" />
		
		<c:set var="hit1" value="${maxHit1 }" />
		<c:set var="hit2" value="${maxHit2 }" />
		<c:set var="hit3" value="${maxHit3 }" />
		<c:set var="hit4" value="${maxHit4 }" />
		<c:set var="hit5" value="${maxHit5 }" />
				
		<c:set var="hit1Per" value="${maxHit1 == 0 ? 1 : 272 * (maxHit1/rscPeople) }" />
		<c:set var="hit2Per" value="${maxHit2 == 0 ? 1 : 272 * (maxHit2/rscPeople) }" />
		<c:set var="hit3Per" value="${maxHit3 == 0 ? 1 : 272 * (maxHit3/rscPeople) }" />
		<c:set var="hit4Per" value="${maxHit4 == 0 ? 1 : 272 * (maxHit4/rscPeople) }" />
		<c:set var="hit5Per" value="${maxHit5 == 0 ? 1 : 272 * (maxHit5/rscPeople) }" />
	</c:if>
	
	
	<div id="researchRusult" class="listBlock">
	  	<h4>만족도조사결과 <span>(참여인원:${rscPeople}명)</span></h4>
	  	<div class="program_search">		
		    <input type="text" class="input_m" title="검색 시작일" id="date01" name="date01" value="${date01 }" >  ~
		    <input type="text" class="input_m" title="검색 종료일" id="date02" name="date02" value="${date02 }" >	    
		    <a href="javascript:fn_egov_find();" class="btn02 MAL5">검색</a>		
		</div>	    
	    <ul class="graph">
	    	<li>
	        	<div class="bar_list">
	            	<dl>
	                	<dt>매우만족</dt>
	                    <dd><img src="${pageContext.request.contextPath }/resources/img/rsc/Jnit_bar01.gif" width="${hit5Per}" height="19" alt="매우만족" /><span id="value01">${hit5}표</span></dd>
	                </dl>
	            </div>
	        </li>
	    	<li>
	        	<div class="bar_list">
	            	<dl>
	                	<dt>만족</dt>
	                    <dd><img src="${pageContext.request.contextPath }/resources/img/rsc/Jnit_bar02.gif" width="${hit4Per}" height="19" alt="만족" /><span id="value02">${hit4}표</span></dd>
	                </dl>
	            </div>
	        </li>
	    	<li>
	        	<div class="bar_list">
	            	<dl>
	                	<dt>보통</dt>
	                    <dd><img src="${pageContext.request.contextPath }/resources/img/rsc/Jnit_bar03.gif" width="${hit3Per}" height="19" alt="보통" /><span id="value03">${hit3}표</span></dd>
	                </dl>
	            </div>
	        </li>
	    	<li>
	        	<div class="bar_list">
	            	<dl>
	                	<dt>불만족</dt>
	                    <dd><img src="${pageContext.request.contextPath }/resources/img/rsc/Jnit_bar04.gif" width="${hit2Per}" height="19" alt="불만족" /><span id="value04">${hit2}표</span></dd>
	                </dl>
	            </div>
	        </li>
	    	<li>
	        	<div class="bar_list">
	            	<dl>
	                	<dt>매우불만족</dt>
	                    <dd><img src="${pageContext.request.contextPath }/resources/img/rsc/Jnit_bar05.gif" width="${hit1Per}" height="19" alt="매우불만족" /><span id="value05">${hit1}표</span></dd>
	                </dl>
	            </div>
	        </li>
	    </ul>
	    <h5 class="h5_point01">한줄의견</h5>
	    <div class="line_comment">
	    	<ul>
	    		<c:forEach var="result" items="${pagedataList }" varStatus="status">	    		
	    		<li>${result.memo }</li>
	    		</c:forEach>
	    	</ul>
	    </div>
	    <h5 class="h5_point02">만족도조사 요약설명</h5>
	    <p class="point">만족도 조사에 참여해 주셔서 감사합니다.<br/>
	    현재 페이지의 만족도 투표는 <strong>총 ${rscPeople}명</strong>이 참여하였으며, 현재 "<strong>${maxHitStr}</strong>"이 ${maxHit}표로 가장 많은 표를 받았습니다.<br/>
	    투표에 참여한 시민들은 현 페이지에 대해 "<strong>${maxHitStr}</strong>" 하고 있습니다.</p>	    
	    <p class="btn_close"><a href="#researchRusult" onclick="fn_egov_close(); return false;"><img src="${pageContext.request.contextPath }/resources/img/rsc/Jnit_btn_close.gif" alt="결과보기 닫기" width="28px;"/></a></p>
	  </div>
	  </form>
</body>
</html>