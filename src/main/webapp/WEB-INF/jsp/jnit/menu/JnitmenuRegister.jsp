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
  * @Class Name : JnitmenuRegister.jsp
  * @Description : Jnitmenu Register 화면
  * @Modification Information
  * 
  * @author JNIT
  * @since 2012.08.28
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
 <c:set var="registerFlag" value="${empty jnitmenuVO.menuSeq ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitmenuVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitmenuVO").action = "<c:url value='/jnitmenu/JnitmenuList.do'/>";
   	document.getElementById("jnitmenuVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitmenuVO").action = "<c:url value='/jnitmenu/deleteJnitmenu.do'/>";
   	document.getElementById("jnitmenuVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitmenuVO");

        /* ClientSite Validator */
	//if(!validateJnitmenuVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/jnitmenu/updateJnitmenu.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/jnitmenu/addJnitmenu.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitmenuVO">
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
			<th>MENU_SEQ</th>
			<td>
				<form:input path="menuSeq" cssClass="txt"/>
				&nbsp;<form:errors path="menuSeq" />
			</td>
		</tr>	
		<tr>
			<th>SITE_NM</th>
			<td>
				<form:input path="siteNm" cssClass="txt"/>
				&nbsp;<form:errors path="siteNm" />
			</td>
		</tr>	
		<tr>
			<th>MENU_DEPTH1</th>
			<td>
				<form:input path="menuDepth1" cssClass="txt"/>
				&nbsp;<form:errors path="menuDepth1" />
			</td>
		</tr>	
		<tr>
			<th>MENU_DEPTH2</th>
			<td>
				<form:input path="menuDepth2" cssClass="txt"/>
				&nbsp;<form:errors path="menuDepth2" />
			</td>
		</tr>	
		<tr>
			<th>MENU_DEPTH3</th>
			<td>
				<form:input path="menuDepth3" cssClass="txt"/>
				&nbsp;<form:errors path="menuDepth3" />
			</td>
		</tr>	
		<tr>
			<th>MENU_DEPTH4</th>
			<td>
				<form:input path="menuDepth4" cssClass="txt"/>
				&nbsp;<form:errors path="menuDepth4" />
			</td>
		</tr>	
		<tr>
			<th>MENU_DEPTH5</th>
			<td>
				<form:input path="menuDepth5" cssClass="txt"/>
				&nbsp;<form:errors path="menuDepth5" />
			</td>
		</tr>	
		<tr>
			<th>MENU_DEPTH6</th>
			<td>
				<form:input path="menuDepth6" cssClass="txt"/>
				&nbsp;<form:errors path="menuDepth6" />
			</td>
		</tr>	
		<tr>
			<th>MENU_DEPTH7</th>
			<td>
				<form:input path="menuDepth7" cssClass="txt"/>
				&nbsp;<form:errors path="menuDepth7" />
			</td>
		</tr>	
		<tr>
			<th>MENU_URL</th>
			<td>
				<form:input path="menuUrl" cssClass="txt"/>
				&nbsp;<form:errors path="menuUrl" />
			</td>
		</tr>	
		<tr>
			<th>MENU_DEPT</th>
			<td>
				<form:input path="menuDept" cssClass="txt"/>
				&nbsp;<form:errors path="menuDept" />
			</td>
		</tr>	
		<tr>
			<th>MENU_PART</th>
			<td>
				<form:input path="menuPart" cssClass="txt"/>
				&nbsp;<form:errors path="menuPart" />
			</td>
		</tr>	
		<tr>
			<th>MENU_TEL</th>
			<td>
				<form:input path="menuTel" cssClass="txt"/>
				&nbsp;<form:errors path="menuTel" />
			</td>
		</tr>	
		<tr>
			<th>MENU_MEMID</th>
			<td>
				<form:input path="menuMemid" cssClass="txt"/>
				&nbsp;<form:errors path="menuMemid" />
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
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitmenuVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

