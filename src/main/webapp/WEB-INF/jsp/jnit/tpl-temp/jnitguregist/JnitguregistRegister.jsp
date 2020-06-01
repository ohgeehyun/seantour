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
  * @Class Name : JnitguregistRegister.jsp
  * @Description : Jnitguregist Register 화면
  * @Modification Information
  * 
  * @author Dael @ JNIT
  * @since 2012.10.06
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
 <c:set var="registerFlag" value="${empty jnitguregistVO.guregistId ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitguregistVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitguregistVO").action = "<c:url value='/jnitguregist/JnitguregistList.do'/>";
   	document.getElementById("jnitguregistVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitguregistVO").action = "<c:url value='/jnitguregist/deleteJnitguregist.do'/>";
   	document.getElementById("jnitguregistVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitguregistVO");

        /* ClientSite Validator */
	//if(!validateJnitguregistVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/jnitguregist/updateJnitguregist.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/jnitguregist/addJnitguregist.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitguregistVO">
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
			<th>GUREGIST_ID</th>
			<td>
				<form:input path="guregistId" cssClass="txt"/>
				&nbsp;<form:errors path="guregistId" />
			</td>
		</tr>	
		<tr>
			<th>RDATE</th>
			<td>
				<form:input path="rdate" cssClass="txt"/>
				&nbsp;<form:errors path="rdate" />
			</td>
		</tr>	
		<tr>
			<th>H1</th>
			<td>
				<form:input path="h1" cssClass="txt"/>
				&nbsp;<form:errors path="h1" />
			</td>
		</tr>	
		<tr>
			<th>H2</th>
			<td>
				<form:input path="h2" cssClass="txt"/>
				&nbsp;<form:errors path="h2" />
			</td>
		</tr>	
		<tr>
			<th>H3</th>
			<td>
				<form:input path="h3" cssClass="txt"/>
				&nbsp;<form:errors path="h3" />
			</td>
		</tr>	
		<tr>
			<th>H4</th>
			<td>
				<form:input path="h4" cssClass="txt"/>
				&nbsp;<form:errors path="h4" />
			</td>
		</tr>	
		<tr>
			<th>H5</th>
			<td>
				<form:input path="h5" cssClass="txt"/>
				&nbsp;<form:errors path="h5" />
			</td>
		</tr>	
		<tr>
			<th>H6</th>
			<td>
				<form:input path="h6" cssClass="txt"/>
				&nbsp;<form:errors path="h6" />
			</td>
		</tr>	
		<tr>
			<th>H7</th>
			<td>
				<form:input path="h7" cssClass="txt"/>
				&nbsp;<form:errors path="h7" />
			</td>
		</tr>	
		<tr>
			<th>H8</th>
			<td>
				<form:input path="h8" cssClass="txt"/>
				&nbsp;<form:errors path="h8" />
			</td>
		</tr>	
		<tr>
			<th>KM1</th>
			<td>
				<form:input path="km1" cssClass="txt"/>
				&nbsp;<form:errors path="km1" />
			</td>
		</tr>	
		<tr>
			<th>KM2</th>
			<td>
				<form:input path="km2" cssClass="txt"/>
				&nbsp;<form:errors path="km2" />
			</td>
		</tr>	
		<tr>
			<th>KM3</th>
			<td>
				<form:input path="km3" cssClass="txt"/>
				&nbsp;<form:errors path="km3" />
			</td>
		</tr>	
		<tr>
			<th>KM4</th>
			<td>
				<form:input path="km4" cssClass="txt"/>
				&nbsp;<form:errors path="km4" />
			</td>
		</tr>	
		<tr>
			<th>KM5</th>
			<td>
				<form:input path="km5" cssClass="txt"/>
				&nbsp;<form:errors path="km5" />
			</td>
		</tr>	
		<tr>
			<th>KM6</th>
			<td>
				<form:input path="km6" cssClass="txt"/>
				&nbsp;<form:errors path="km6" />
			</td>
		</tr>	
		<tr>
			<th>KM7</th>
			<td>
				<form:input path="km7" cssClass="txt"/>
				&nbsp;<form:errors path="km7" />
			</td>
		</tr>	
		<tr>
			<th>KM8</th>
			<td>
				<form:input path="km8" cssClass="txt"/>
				&nbsp;<form:errors path="km8" />
			</td>
		</tr>	
		<tr>
			<th>KW1</th>
			<td>
				<form:input path="kw1" cssClass="txt"/>
				&nbsp;<form:errors path="kw1" />
			</td>
		</tr>	
		<tr>
			<th>KW2</th>
			<td>
				<form:input path="kw2" cssClass="txt"/>
				&nbsp;<form:errors path="kw2" />
			</td>
		</tr>	
		<tr>
			<th>KW3</th>
			<td>
				<form:input path="kw3" cssClass="txt"/>
				&nbsp;<form:errors path="kw3" />
			</td>
		</tr>	
		<tr>
			<th>KW4</th>
			<td>
				<form:input path="kw4" cssClass="txt"/>
				&nbsp;<form:errors path="kw4" />
			</td>
		</tr>	
		<tr>
			<th>KW5</th>
			<td>
				<form:input path="kw5" cssClass="txt"/>
				&nbsp;<form:errors path="kw5" />
			</td>
		</tr>	
		<tr>
			<th>KW6</th>
			<td>
				<form:input path="kw6" cssClass="txt"/>
				&nbsp;<form:errors path="kw6" />
			</td>
		</tr>	
		<tr>
			<th>KW7</th>
			<td>
				<form:input path="kw7" cssClass="txt"/>
				&nbsp;<form:errors path="kw7" />
			</td>
		</tr>	
		<tr>
			<th>KW8</th>
			<td>
				<form:input path="kw8" cssClass="txt"/>
				&nbsp;<form:errors path="kw8" />
			</td>
		</tr>	
		<tr>
			<th>FM1</th>
			<td>
				<form:input path="fm1" cssClass="txt"/>
				&nbsp;<form:errors path="fm1" />
			</td>
		</tr>	
		<tr>
			<th>FM2</th>
			<td>
				<form:input path="fm2" cssClass="txt"/>
				&nbsp;<form:errors path="fm2" />
			</td>
		</tr>	
		<tr>
			<th>FM3</th>
			<td>
				<form:input path="fm3" cssClass="txt"/>
				&nbsp;<form:errors path="fm3" />
			</td>
		</tr>	
		<tr>
			<th>FM4</th>
			<td>
				<form:input path="fm4" cssClass="txt"/>
				&nbsp;<form:errors path="fm4" />
			</td>
		</tr>	
		<tr>
			<th>FM5</th>
			<td>
				<form:input path="fm5" cssClass="txt"/>
				&nbsp;<form:errors path="fm5" />
			</td>
		</tr>	
		<tr>
			<th>FM6</th>
			<td>
				<form:input path="fm6" cssClass="txt"/>
				&nbsp;<form:errors path="fm6" />
			</td>
		</tr>	
		<tr>
			<th>FM7</th>
			<td>
				<form:input path="fm7" cssClass="txt"/>
				&nbsp;<form:errors path="fm7" />
			</td>
		</tr>	
		<tr>
			<th>FM8</th>
			<td>
				<form:input path="fm8" cssClass="txt"/>
				&nbsp;<form:errors path="fm8" />
			</td>
		</tr>	
		<tr>
			<th>FW1</th>
			<td>
				<form:input path="fw1" cssClass="txt"/>
				&nbsp;<form:errors path="fw1" />
			</td>
		</tr>	
		<tr>
			<th>FW2</th>
			<td>
				<form:input path="fw2" cssClass="txt"/>
				&nbsp;<form:errors path="fw2" />
			</td>
		</tr>	
		<tr>
			<th>FW3</th>
			<td>
				<form:input path="fw3" cssClass="txt"/>
				&nbsp;<form:errors path="fw3" />
			</td>
		</tr>	
		<tr>
			<th>FW4</th>
			<td>
				<form:input path="fw4" cssClass="txt"/>
				&nbsp;<form:errors path="fw4" />
			</td>
		</tr>	
		<tr>
			<th>FW5</th>
			<td>
				<form:input path="fw5" cssClass="txt"/>
				&nbsp;<form:errors path="fw5" />
			</td>
		</tr>	
		<tr>
			<th>FW6</th>
			<td>
				<form:input path="fw6" cssClass="txt"/>
				&nbsp;<form:errors path="fw6" />
			</td>
		</tr>	
		<tr>
			<th>FW7</th>
			<td>
				<form:input path="fw7" cssClass="txt"/>
				&nbsp;<form:errors path="fw7" />
			</td>
		</tr>	
		<tr>
			<th>FW8</th>
			<td>
				<form:input path="fw8" cssClass="txt"/>
				&nbsp;<form:errors path="fw8" />
			</td>
		</tr>	
		<tr>
			<th>OM1</th>
			<td>
				<form:input path="om1" cssClass="txt"/>
				&nbsp;<form:errors path="om1" />
			</td>
		</tr>	
		<tr>
			<th>OM2</th>
			<td>
				<form:input path="om2" cssClass="txt"/>
				&nbsp;<form:errors path="om2" />
			</td>
		</tr>	
		<tr>
			<th>OM3</th>
			<td>
				<form:input path="om3" cssClass="txt"/>
				&nbsp;<form:errors path="om3" />
			</td>
		</tr>	
		<tr>
			<th>OM4</th>
			<td>
				<form:input path="om4" cssClass="txt"/>
				&nbsp;<form:errors path="om4" />
			</td>
		</tr>	
		<tr>
			<th>OM5</th>
			<td>
				<form:input path="om5" cssClass="txt"/>
				&nbsp;<form:errors path="om5" />
			</td>
		</tr>	
		<tr>
			<th>OM6</th>
			<td>
				<form:input path="om6" cssClass="txt"/>
				&nbsp;<form:errors path="om6" />
			</td>
		</tr>	
		<tr>
			<th>OM7</th>
			<td>
				<form:input path="om7" cssClass="txt"/>
				&nbsp;<form:errors path="om7" />
			</td>
		</tr>	
		<tr>
			<th>OM8</th>
			<td>
				<form:input path="om8" cssClass="txt"/>
				&nbsp;<form:errors path="om8" />
			</td>
		</tr>	
		<tr>
			<th>OW1</th>
			<td>
				<form:input path="ow1" cssClass="txt"/>
				&nbsp;<form:errors path="ow1" />
			</td>
		</tr>	
		<tr>
			<th>OW2</th>
			<td>
				<form:input path="ow2" cssClass="txt"/>
				&nbsp;<form:errors path="ow2" />
			</td>
		</tr>	
		<tr>
			<th>OW3</th>
			<td>
				<form:input path="ow3" cssClass="txt"/>
				&nbsp;<form:errors path="ow3" />
			</td>
		</tr>	
		<tr>
			<th>OW4</th>
			<td>
				<form:input path="ow4" cssClass="txt"/>
				&nbsp;<form:errors path="ow4" />
			</td>
		</tr>	
		<tr>
			<th>OW5</th>
			<td>
				<form:input path="ow5" cssClass="txt"/>
				&nbsp;<form:errors path="ow5" />
			</td>
		</tr>	
		<tr>
			<th>OW6</th>
			<td>
				<form:input path="ow6" cssClass="txt"/>
				&nbsp;<form:errors path="ow6" />
			</td>
		</tr>	
		<tr>
			<th>OW7</th>
			<td>
				<form:input path="ow7" cssClass="txt"/>
				&nbsp;<form:errors path="ow7" />
			</td>
		</tr>	
		<tr>
			<th>OW8</th>
			<td>
				<form:input path="ow8" cssClass="txt"/>
				&nbsp;<form:errors path="ow8" />
			</td>
		</tr>	
		<tr>
			<th>CREATED</th>
			<td>
				<form:input path="created" cssClass="txt"/>
				&nbsp;<form:errors path="created" />
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
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitguregistVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

