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
  * @Class Name : JnitvoteRegister.jsp
  * @Description : Jnitvote Register 화면
  * @Modification Information
  * 
  * @author Dael @ JNIT
  * @since 2012.11.09
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
 <c:set var="registerFlag" value="${empty jnitvoteVO.jumin1 ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitvoteVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitvoteVO").action = "<c:url value='/jnitvote/JnitvoteList.do'/>";
   	document.getElementById("jnitvoteVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitvoteVO").action = "<c:url value='/jnitvote/deleteJnitvote.do'/>";
   	document.getElementById("jnitvoteVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitvoteVO");

        /* ClientSite Validator */
	//if(!validateJnitvoteVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/jnitvote/updateJnitvote.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/jnitvote/addJnitvote.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitvoteVO">
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
			<th>JUMIN1</th>
			<td>
				<form:input path="jumin1" cssClass="txt"/>
				&nbsp;<form:errors path="jumin1" />
			</td>
		</tr>	
		<tr>
			<th>JUMIN2</th>
			<td>
				<form:input path="jumin2" cssClass="txt"/>
				&nbsp;<form:errors path="jumin2" />
			</td>
		</tr>	
		<tr>
			<th>JNAME</th>
			<td>
				<form:input path="jname" cssClass="txt"/>
				&nbsp;<form:errors path="jname" />
			</td>
		</tr>	
		<tr>
			<th>GENDER</th>
			<td>
				<form:input path="gender" cssClass="txt"/>
				&nbsp;<form:errors path="gender" />
			</td>
		</tr>	
		<tr>
			<th>AREA</th>
			<td>
				<form:input path="area" cssClass="txt"/>
				&nbsp;<form:errors path="area" />
			</td>
		</tr>	
		<tr>
			<th>PLACE</th>
			<td>
				<form:input path="place" cssClass="txt"/>
				&nbsp;<form:errors path="place" />
			</td>
		</tr>	
		<tr>
			<th>DONG</th>
			<td>
				<form:input path="dong" cssClass="txt"/>
				&nbsp;<form:errors path="dong" />
			</td>
		</tr>	
		<tr>
			<th>RECORD</th>
			<td>
				<form:input path="record" cssClass="txt"/>
				&nbsp;<form:errors path="record" />
			</td>
		</tr>	
		<tr>
			<th>LOCATION</th>
			<td>
				<form:input path="location" cssClass="txt"/>
				&nbsp;<form:errors path="location" />
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
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitvoteVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

