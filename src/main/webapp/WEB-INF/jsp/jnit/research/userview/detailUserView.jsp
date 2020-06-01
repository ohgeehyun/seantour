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
<%@ page import="java.util.Date" %>
    
<style>
span.accReady {
	color:orange;
}
span.accstate {
	color:green;
}
span.accEnd {
	color:red;
}

</style>

<script type="text/javaScript" language="javascript" defer="defer">

function fn_egov_reg(researchId) {
    document.getElementById("jnitresearchDetail").researchId.value = researchId;
    document.getElementById("jnitresearchDetail").screenMode.value = "";
   	document.getElementById("jnitresearchDetail").action = "<c:url value='/jnitresearch/entryJnitresearchUser.do'/>";
   	document.getElementById("jnitresearchDetail").submit();
}

</script>


<form:form commandName="jnitresearchVO" id="jnitresearchDetail" name="jnitresearchDetail" enctype="multipart/form-data">
<input type="hidden" name="researchId" />
<input type="hidden" name="state" value = "${jnitresearchVO.state}" />
<input type="hidden" name="screenMode" />
<c:set var ="today" value = "<%=new Date()%>" />

	 <table class="bbsView table table-bordered" border="0" cellspacing="0" cellpadding="0" >
	 	<colgroup>
			<col width="150"/>
		</colgroup>
		<tr>
			<td>
			<c:if test = "${(jnitresearchVO.state == 0) && (today < jnitresearchVO.starttime)}"><span class="accReady">설문접수이전</span></c:if>
			
			<c:if test = "${(jnitresearchVO.state == 0) && (today > jnitresearchVO.starttime) && (jnitresearchVO.endtime > today)}">
			<input type = "button" value = "참여 하기" onclick="javascript:fn_egov_reg('<c:out value="${jnitresearchVO.researchId}"/>')"/>
			</c:if>
			
			<c:if test = "${(jnitresearchVO.state == 0) && (jnitresearchVO.endtime < today)}"><span class="accstate">설문기간만료</span></c:if>
			<c:if test = "${jnitresearchVO.state == 1}">설문종료</c:if>
			<c:if test = "${jnitresearchVO.state == 1}"><span class="accEnd">종료되었습니다</span></c:if>
			
			</td>
		</tr>
 	</table>

	 <table border="0" cellspacing="0" cellpadding="0" class="table content2_table">
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
		<tr>
			<th>설문명</th>
				<td class="listtd"><c:out value="${jnitresearchVO.researchNm}"/>&nbsp;</td>
		</tr>
		<tr>
			<th>설문소개</th>
				<td>${jnitresearchVO.introduce}</td>
				
		</tr>
	</table>


</form:form>
		