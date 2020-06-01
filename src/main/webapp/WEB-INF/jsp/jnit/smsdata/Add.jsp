<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : SmsdataRegister.jsp
  * @Description : Smsdata Register 화면
  * @Modification Information
  * 
  * @author JNITSMSDATA
  * @since 2014.02.17
  * @version 1.0
  * @see
  *  
  * Copyright (C) All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!--
 <c:set var="registerFlag" value="${empty smsdataVO.seqNo ? '등록' : '수정'}"/>
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="smsdataVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("smsdataVO").action = "<c:url value='/smsdata/SmsdataList.do'/>";
   	document.getElementById("smsdataVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("smsdataVO").action = "<c:url value='/smsdata/deleteSmsdata.do'/>";
   	document.getElementById("smsdataVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("smsdataVO");

        /* ClientSite Validator */
	//if(!validateSmsdataVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/smsdata/updateSmsdata.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/smsdata/addSmsdata.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="smsdataVO">
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/egovframework/rte/title_dot.gif'/>" alt="" /><c:out value="${registerFlag}"/></li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<div id="table">
	<table width="100%" border="1" cellpadding="0" cellspacing="0" >
		<colgroup>
			<col width="150"/>
			<col width=""/>
		</colgroup>
			
		<c:if test="${registerFlag == '수정'}">
			<input type="hidden" name="screenMode" value="up" />
	   <tr>
			<th>${model.attribute.get(0).name} *</th>
			<td>
				<form:input path="${model.attribute.get(0).ccName}" cssClass="essentiality" readonly="true" />
			</td>			
		</tr>	
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			<input type="hidden" name="screenMode" value="" />
	   <tr>
			<th>${model.attribute.get(0).name} *</th>
			<td>
				<form:input path="${model.attribute.get(0).ccName}" cssClass="txt" readonly="false" />
			</td>			
		</tr>	
		</c:if>		
		<tr>
			<th>IN_DATE</th>
			<td>
				<form:input path="inDate" cssClass="txt"/>
				&nbsp;<form:errors path="inDate" />
			</td>
		</tr>	
		<tr>
			<th>IN_TIME</th>
			<td>
				<form:input path="inTime" cssClass="txt"/>
				&nbsp;<form:errors path="inTime" />
			</td>
		</tr>	
		<tr>
			<th>MEMBER</th>
			<td>
				<form:input path="member" cssClass="txt"/>
				&nbsp;<form:errors path="member" />
			</td>
		</tr>	
		<tr>
			<th>SEND_ID</th>
			<td>
				<form:input path="sendId" cssClass="txt"/>
				&nbsp;<form:errors path="sendId" />
			</td>
		</tr>	
		<tr>
			<th>SEND_NAME</th>
			<td>
				<form:input path="sendName" cssClass="txt"/>
				&nbsp;<form:errors path="sendName" />
			</td>
		</tr>	
		<tr>
			<th>R_PHONE1</th>
			<td>
				<form:input path="RPhone1" cssClass="txt"/>
				&nbsp;<form:errors path="RPhone1" />
			</td>
		</tr>	
		<tr>
			<th>R_PHONE2</th>
			<td>
				<form:input path="RPhone2" cssClass="txt"/>
				&nbsp;<form:errors path="RPhone2" />
			</td>
		</tr>	
		<tr>
			<th>R_PHONE3</th>
			<td>
				<form:input path="RPhone3" cssClass="txt"/>
				&nbsp;<form:errors path="RPhone3" />
			</td>
		</tr>	
		<tr>
			<th>RECV_NAME</th>
			<td>
				<form:input path="recvName" cssClass="txt"/>
				&nbsp;<form:errors path="recvName" />
			</td>
		</tr>	
		<tr>
			<th>S_PHONE1</th>
			<td>
				<form:input path="SPhone1" cssClass="txt"/>
				&nbsp;<form:errors path="SPhone1" />
			</td>
		</tr>	
		<tr>
			<th>S_PHONE2</th>
			<td>
				<form:input path="SPhone2" cssClass="txt"/>
				&nbsp;<form:errors path="SPhone2" />
			</td>
		</tr>	
		<tr>
			<th>S_PHONE3</th>
			<td>
				<form:input path="SPhone3" cssClass="txt"/>
				&nbsp;<form:errors path="SPhone3" />
			</td>
		</tr>	
		<tr>
			<th>MSG</th>
			<td>
				<form:input path="msg" cssClass="txt"/>
				&nbsp;<form:errors path="msg" />
			</td>
		</tr>	
		<tr>
			<th>URL</th>
			<td>
				<form:input path="url" cssClass="txt"/>
				&nbsp;<form:errors path="url" />
			</td>
		</tr>	
		<tr>
			<th>R_DATE</th>
			<td>
				<form:input path="RDate" cssClass="txt"/>
				&nbsp;<form:errors path="RDate" />
			</td>
		</tr>	
		<tr>
			<th>R_TIME</th>
			<td>
				<form:input path="RTime" cssClass="txt"/>
				&nbsp;<form:errors path="RTime" />
			</td>
		</tr>	
		<tr>
			<th>RESULT</th>
			<td>
				<form:input path="result" cssClass="txt"/>
				&nbsp;<form:errors path="result" />
			</td>
		</tr>	
		<tr>
			<th>KIND</th>
			<td>
				<form:input path="kind" cssClass="txt"/>
				&nbsp;<form:errors path="kind" />
			</td>
		</tr>	
		<tr>
			<th>ERR_CODE</th>
			<td>
				<form:input path="errCode" cssClass="txt"/>
				&nbsp;<form:errors path="errCode" />
			</td>
		</tr>	
		<tr>
			<th>RECV_TIME</th>
			<td>
				<form:input path="recvTime" cssClass="txt"/>
				&nbsp;<form:errors path="recvTime" />
			</td>
		</tr>	
	</table>
  </div>
	<div id="sysbtn">
		<ul>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_selectList();">List</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_save();"><c:out value='${registerFlag}'/></a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			<c:if test="${registerFlag == '수정'}">
			<li><span class="btn_blue_l"><a href="javascript:fn_egov_delete();">삭제</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li>
			</c:if>
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("smsdataVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

