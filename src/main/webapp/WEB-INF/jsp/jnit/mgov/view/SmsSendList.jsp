<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import = "com.ibm.icu.text.SimpleDateFormat, com.ibm.icu.util.Calendar" %>
<%
	SimpleDateFormat yearFormat = new SimpleDateFormat("YYYY");
	String thisYear = yearFormat.format(Calendar.getInstance().getTime());
%>
<c:set var="thisYear" value="<%=thisYear%>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>팝업-sms</title>
<meta http-equiv="X-UA-Compatible" content="IE=8,9,10">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="<c:url value="/resources/js/jquery.min.js"/> "></script>
<link type="text/css" href="<c:url value="/resources/css/sms/jnit_base.css" />" media='all' rel='stylesheet' />
<link type="text/css" href="<c:url value="/resources/css/sms/jnit_sms.css" />" media='all' rel='stylesheet' />
<script type="text/javascript">
<!--

$(document).ready(function(){
	
	var sYear = "${resultDate['sYear']}";
	var sDate = "${resultDate['sDate']}";
	
	$("#sYear").val(sYear);
	$("#sDate").val(sDate);
	
	$("[name='smsSearch']").on("click", function(){
		
		var sYear = $.trim($("#sYear").val());
		var sDate = $.trim($("#sDate").val());
		
		if(sYear == ''){
			alert("년도를 선택해주세요.");
			$("#sYear").focus();
			return false;
		}else if(sDate == ''){
			alert("월을 선택해주세요.");
			$("#sDate").focus();
			return false;
		}
		
	});
});

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/sms/view/smsSendList.do'/>";
   	document.getElementById("listForm").submit();
}

// -->
</script>
</head>

<body>

<div class="Jnitsms">
	<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
		<input type="hidden" name="screenMode" />
	    <div class="Jnitsms_topcontent">
	        <h1 class="Jnitsms_logo"><a href="#"><img src="<c:url value="/resources/img/sms/sms_logo.gif" />" alt="SMS service" /></a></h1>    
	        <div class="Jnitsms_menu">
	            <p class="Jnitsms_menu_title">SMS보내기</p>
	            <ul>
	                <li><a href="<c:url value="/sms/view/page.do" />?pageType=MbrSend">회원조회발송</a></li>
	                <li><a href="<c:url value="/sms/view/page.do" />?pageType=ExcelSend">엑셀발송</a></li>
	                <li><a href="<c:url value="/sms/view/page.do" />?pageType=AddrSend">주소록발송</a></li>
	            </ul>
	            <p class="Jnitsms_menu_title MAL20">발송내역</p>
	            <ul>
	                <li class="on"><a href="<c:url value="/sms/view/smsSendList.do" />">SMS발송내역</a></li>
	                <li><a href="<c:url value="/sms/view/lmsSendList.do" />">LMS발송내역</a></li>
	            </ul>
	        </div>
	        <p class="Jnitsms_address"><a href="<c:url value="/sms/view/page.do?pageType=SmsAddr" />">+ 주소록관리</a></p>
	    </div>    
	    <div class="Jnitsms_box" style="width:965px;margin-left: 15px;">
	        <span class="box_lttop"></span>
	        <span class="box_rttop"></span>
	        <c:choose>
               <c:when test="${smsType == 'mgov'}">
			        <div class="member_search">
			            <p class="member_search_title">SMS 테이블 <span>( ${resultDate['sYear']}년 ${resultDate['sDate']}월 내역 )</span></p>
			            <div class="select_date">
			            	<label for="sYear">년도 선택</label>
			                <select id="sYear" name="sYear">
			                    <option value=" " selected="selected">년도 선택</option>
									<c:forEach var="year" begin="2014" end="${thisYear}" varStatus="status">
										<option value="${year}">${year}년</option>
									</c:forEach>           
			                </select>
			            	<label for="sDate">월 선택</label>
			                <select id="sDate" name="sDate">
			                    <option value=" " selected="selected">월 선택</option>
			               		<c:forEach var="date" begin="01" end="12" varStatus="status">
			               			<option value="${date < 10 ? 0 : ''}${date}">${date}월</option>
			               		</c:forEach>
			                </select>
			                <button class="btn" id="smsSearch" name="smsSearch">검색하기</button>
			                <p class="member_list_stats">
			                	총갯수 : ${resultState['total']} / 
								성공 : ${resultState['success']} / 
								실패 : ${resultState['failed']}
			                </p>
			            </div>
			        </div>
				</c:when>
				<c:otherwise>
				
				</c:otherwise>
			</c:choose>
	        <div class="member_list">
	          	<div class="member_list_box">
	                <table class="member_list_table" summary="순번, 보낸 번호, 받은 번호, 메세지 내용, 보낸 시각, 상태를 조회 할 수 있는 표입니다.">
	                <caption>회원정보 조회</caption>
	                    <thead>
	                        <tr>
	                            <th scope="row">순번</th>
	                            <th scope="row">보낸 번호(From)</th>
	                            <th scope="row">받은 번호(To)</th>
	                            <th scope="row">메세지 내용</th>
	                            <th scope="row">보낸 시각</th>
	                            <th scope="row">상태</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                       <c:if test="${fn:length(resultList) < 1}">
								<td colspan="6" style="text-align: center;"><strong style="color: black;">해당 데이터가 존재하지 않습니다.</strong></td>
							</c:if>
							<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><c:out value="${result.msgSeq}"/></td>
								<td><c:out value="${result.callFrom}"/></td>
								<td><c:out value="${result.callTo}"/></td>
								<td><c:out value="${result.smsTxt}"/></td>
								<td><fmt:formatDate value="${result.reqDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<c:if test="${result.rsltCode2 != '0'}">
									<td><span class="send_fail">전송실패</span></td>
								</c:if>
								<c:if test="${result.rsltCode2 == '0'}">
									<td><span class="send_success">전송성공</span></td>
								</c:if>
							</tr>
							</c:forEach>
	                    </tbody>
	                </table>
	                <div id="page_navi" class="pagination">
							<ui:pagination paginationInfo = "${paginationInfo}"
									   type="jnitDefault"
									   jsFunction="fn_egov_link_page"
									   />
							<form:hidden path="pageIndex" />
					</div>
	          	</div>
	        </div>
	        
	        <span class="box_ltbtm"></span>
	        <span class="box_rtbtm"></span>
	    </div>
	</form:form>
</div>
  
  
</body>  
</html>