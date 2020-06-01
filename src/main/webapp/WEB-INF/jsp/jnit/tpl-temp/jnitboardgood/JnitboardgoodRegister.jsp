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
  * @Class Name : JnitboardgoodRegister.jsp
  * @Description : Jnitboardgood Register 화면
  * @Modification Information
  * 
  * @author JNITBOARADGOOD
  * @since 2013.11.24
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
 <c:set var="registerFlag" value="${empty jnitboardgoodVO.idx ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitboardgoodVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitboardgoodVO").action = "<c:url value='/jnitboardgood/JnitboardgoodList.do'/>";
   	document.getElementById("jnitboardgoodVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitboardgoodVO").action = "<c:url value='/jnitboardgood/deleteJnitboardgood.do'/>";
   	document.getElementById("jnitboardgoodVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitboardgoodVO");

        /* ClientSite Validator */
	//if(!validateJnitboardgoodVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/jnitboardgood/updateJnitboardgood.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/jnitboardgood/addJnitboardgood.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitboardgoodVO">
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
			<th>IDX</th>
			<td>
				<form:input path="idx" cssClass="txt"/>
				&nbsp;<form:errors path="idx" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_ID</th>
			<td>
				<form:input path="boardId" cssClass="txt"/>
				&nbsp;<form:errors path="boardId" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_CNT_ID</th>
			<td>
				<form:input path="boardCntId" cssClass="txt"/>
				&nbsp;<form:errors path="boardCntId" />
			</td>
		</tr>	
		<tr>
			<th>MBR_ID</th>
			<td>
				<form:input path="mbrId" cssClass="txt"/>
				&nbsp;<form:errors path="mbrId" />
			</td>
		</tr>	
		<tr>
			<th>IPADDR</th>
			<td>
				<form:input path="ipaddr" cssClass="txt"/>
				&nbsp;<form:errors path="ipaddr" />
			</td>
		</tr>	
		<tr>
			<th>CREATED</th>
			<td>
				<form:input path="created" cssClass="txt"/>
				&nbsp;<form:errors path="created" />
			</td>
		</tr>	
		<tr>
			<th>MODIFIED</th>
			<td>
				<form:input path="modified" cssClass="txt"/>
				&nbsp;<form:errors path="modified" />
			</td>
		</tr>	
		<tr>
			<th>EXT01</th>
			<td>
				<form:input path="ext01" cssClass="txt"/>
				&nbsp;<form:errors path="ext01" />
			</td>
		</tr>	
		<tr>
			<th>EXT02</th>
			<td>
				<form:input path="ext02" cssClass="txt"/>
				&nbsp;<form:errors path="ext02" />
			</td>
		</tr>	
		<tr>
			<th>ISDEL</th>
			<td>
				<form:input path="isdel" cssClass="txt"/>
				&nbsp;<form:errors path="isdel" />
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
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitboardgoodVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

