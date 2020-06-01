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
  * @Class Name : JnitsmsmgovRegister.jsp
  * @Description : Jnitsmsmgov Register 화면
  * @Modification Information
  * 
  * @author JNITSMSMGOV
  * @since 2013.11.25
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
 <c:set var="registerFlag" value="${empty jnitsmsmgovVO.msgNo ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitsmsmgovVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitsmsmgovVO").action = "<c:url value='/jnitsmsmgov/JnitsmsmgovList.do'/>";
   	document.getElementById("jnitsmsmgovVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitsmsmgovVO").action = "<c:url value='/jnitsmsmgov/deleteJnitsmsmgov.do'/>";
   	document.getElementById("jnitsmsmgovVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitsmsmgovVO");

        /* ClientSite Validator */
	//if(!validateJnitsmsmgovVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/jnitsmsmgov/updateJnitsmsmgov.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/jnitsmsmgov/addJnitsmsmgov.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitsmsmgovVO">
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
		</c:if>
		<c:if test="${registerFlag == '등록'}">
			<input type="hidden" name="screenMode" value="" />
		</c:if>		
		<tr>
			<th>MSG_NO</th>
			<td>
				<form:input path="msgNo" cssClass="txt"/>
				&nbsp;<form:errors path="msgNo" />
			</td>
		</tr>	
		<tr>
			<th>MSG_KEY</th>
			<td>
				<form:input path="msgKey" cssClass="txt"/>
				&nbsp;<form:errors path="msgKey" />
			</td>
		</tr>	
		<tr>
			<th>MSG_UID</th>
			<td>
				<form:input path="msgUid" cssClass="txt"/>
				&nbsp;<form:errors path="msgUid" />
			</td>
		</tr>	
		<tr>
			<th>MSG_SEND_NO</th>
			<td>
				<form:input path="msgSendNo" cssClass="txt"/>
				&nbsp;<form:errors path="msgSendNo" />
			</td>
		</tr>	
		<tr>
			<th>MSG_RCV_NAME</th>
			<td>
				<form:input path="msgRcvName" cssClass="txt"/>
				&nbsp;<form:errors path="msgRcvName" />
			</td>
		</tr>	
		<tr>
			<th>MSG_RCV_NO</th>
			<td>
				<form:input path="msgRcvNo" cssClass="txt"/>
				&nbsp;<form:errors path="msgRcvNo" />
			</td>
		</tr>	
		<tr>
			<th>MSG_TYPE</th>
			<td>
				<form:input path="msgType" cssClass="txt"/>
				&nbsp;<form:errors path="msgType" />
			</td>
		</tr>	
		<tr>
			<th>MSG_TYPE2</th>
			<td>
				<form:input path="msgType2" cssClass="txt"/>
				&nbsp;<form:errors path="msgType2" />
			</td>
		</tr>	
		<tr>
			<th>MSG_SUBJECT</th>
			<td>
				<form:input path="msgSubject" cssClass="txt"/>
				&nbsp;<form:errors path="msgSubject" />
			</td>
		</tr>	
		<tr>
			<th>MSG_TXT</th>
			<td>
				<form:input path="msgTxt" cssClass="txt"/>
				&nbsp;<form:errors path="msgTxt" />
			</td>
		</tr>	
		<tr>
			<th>MSG_URL</th>
			<td>
				<form:input path="msgUrl" cssClass="txt"/>
				&nbsp;<form:errors path="msgUrl" />
			</td>
		</tr>	
		<tr>
			<th>MSG_FILE1</th>
			<td>
				<form:input path="msgFile1" cssClass="txt"/>
				&nbsp;<form:errors path="msgFile1" />
			</td>
		</tr>	
		<tr>
			<th>MSG_FILE2</th>
			<td>
				<form:input path="msgFile2" cssClass="txt"/>
				&nbsp;<form:errors path="msgFile2" />
			</td>
		</tr>	
		<tr>
			<th>MSG_FILE3</th>
			<td>
				<form:input path="msgFile3" cssClass="txt"/>
				&nbsp;<form:errors path="msgFile3" />
			</td>
		</tr>	
		<tr>
			<th>MSG_STATUS</th>
			<td>
				<form:input path="msgStatus" cssClass="txt"/>
				&nbsp;<form:errors path="msgStatus" />
			</td>
		</tr>	
		<tr>
			<th>MSG_RSTSTUS</th>
			<td>
				<form:input path="msgRststus" cssClass="txt"/>
				&nbsp;<form:errors path="msgRststus" />
			</td>
		</tr>	
		<tr>
			<th>MSG_TELCO</th>
			<td>
				<form:input path="msgTelco" cssClass="txt"/>
				&nbsp;<form:errors path="msgTelco" />
			</td>
		</tr>	
		<tr>
			<th>MSG_CODE</th>
			<td>
				<form:input path="msgCode" cssClass="txt"/>
				&nbsp;<form:errors path="msgCode" />
			</td>
		</tr>	
		<tr>
			<th>MSG_TRANS_DT</th>
			<td>
				<form:input path="msgTransDt" cssClass="txt"/>
				&nbsp;<form:errors path="msgTransDt" />
			</td>
		</tr>	
		<tr>
			<th>MSG_SEND_DT</th>
			<td>
				<form:input path="msgSendDt" cssClass="txt"/>
				&nbsp;<form:errors path="msgSendDt" />
			</td>
		</tr>	
		<tr>
			<th>MSG_REPT_DT</th>
			<td>
				<form:input path="msgReptDt" cssClass="txt"/>
				&nbsp;<form:errors path="msgReptDt" />
			</td>
		</tr>	
		<tr>
			<th>MSG_RSLT_DT</th>
			<td>
				<form:input path="msgRsltDt" cssClass="txt"/>
				&nbsp;<form:errors path="msgRsltDt" />
			</td>
		</tr>	
		<tr>
			<th>MSG_DATE</th>
			<td>
				<form:input path="msgDate" cssClass="txt"/>
				&nbsp;<form:errors path="msgDate" />
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
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitsmsmgovVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

