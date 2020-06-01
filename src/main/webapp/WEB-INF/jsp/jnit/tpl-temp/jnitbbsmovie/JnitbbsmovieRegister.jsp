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
  * @Class Name : JnitbbsmovieRegister.jsp
  * @Description : Jnitbbsmovie Register 화면
  * @Modification Information
  * 
  * @author JNIT
  * @since 2012.09.12
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
 <c:set var="registerFlag" value="${empty jnitbbsmovieVO.bbsId ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitbbsmovieVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitbbsmovieVO").action = "<c:url value='/jnitbbsmovie/JnitbbsmovieList.do'/>";
   	document.getElementById("jnitbbsmovieVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitbbsmovieVO").action = "<c:url value='/jnitbbsmovie/deleteJnitbbsmovie.do'/>";
   	document.getElementById("jnitbbsmovieVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitbbsmovieVO");

        /* ClientSite Validator */
	//if(!validateJnitbbsmovieVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/jnitbbsmovie/updateJnitbbsmovie.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/jnitbbsmovie/addJnitbbsmovie.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitbbsmovieVO">
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
			<th>BBS_ID</th>
			<td>
				<form:input path="bbsId" cssClass="txt"/>
				&nbsp;<form:errors path="bbsId" />
			</td>
		</tr>	
		<tr>
			<th>ID</th>
			<td>
				<form:input path="id" cssClass="txt"/>
				&nbsp;<form:errors path="id" />
			</td>
		</tr>	
		<tr>
			<th>UKEY</th>
			<td>
				<form:input path="ukey" cssClass="txt"/>
				&nbsp;<form:errors path="ukey" />
			</td>
		</tr>	
		<tr>
			<th>THUMBPOS</th>
			<td>
				<form:input path="thumbpos" cssClass="txt"/>
				&nbsp;<form:errors path="thumbpos" />
			</td>
		</tr>	
		<tr>
			<th>MOV0</th>
			<td>
				<form:input path="mov0" cssClass="txt"/>
				&nbsp;<form:errors path="mov0" />
			</td>
		</tr>	
		<tr>
			<th>MOV1</th>
			<td>
				<form:input path="mov1" cssClass="txt"/>
				&nbsp;<form:errors path="mov1" />
			</td>
		</tr>	
		<tr>
			<th>TB0</th>
			<td>
				<form:input path="tb0" cssClass="txt"/>
				&nbsp;<form:errors path="tb0" />
			</td>
		</tr>	
		<tr>
			<th>TB1</th>
			<td>
				<form:input path="tb1" cssClass="txt"/>
				&nbsp;<form:errors path="tb1" />
			</td>
		</tr>	
		<tr>
			<th>TB2</th>
			<td>
				<form:input path="tb2" cssClass="txt"/>
				&nbsp;<form:errors path="tb2" />
			</td>
		</tr>	
		<tr>
			<th>TB3</th>
			<td>
				<form:input path="tb3" cssClass="txt"/>
				&nbsp;<form:errors path="tb3" />
			</td>
		</tr>	
		<tr>
			<th>TB4</th>
			<td>
				<form:input path="tb4" cssClass="txt"/>
				&nbsp;<form:errors path="tb4" />
			</td>
		</tr>	
		<tr>
			<th>TB5</th>
			<td>
				<form:input path="tb5" cssClass="txt"/>
				&nbsp;<form:errors path="tb5" />
			</td>
		</tr>	
		<tr>
			<th>THTITLE</th>
			<td>
				<form:input path="thtitle" cssClass="txt"/>
				&nbsp;<form:errors path="thtitle" />
			</td>
		</tr>	
		<tr>
			<th>STATE</th>
			<td>
				<form:input path="state" cssClass="txt"/>
				&nbsp;<form:errors path="state" />
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
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitbbsmovieVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

