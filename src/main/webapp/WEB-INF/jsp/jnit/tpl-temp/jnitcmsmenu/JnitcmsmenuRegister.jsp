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
  * @Class Name : JnitcmsmenuRegister.jsp
  * @Description : Jnitcmsmenu Register 화면
  * @Modification Information
  * 
  * @author JNIT
  * @since 2012.07.08
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
 <c:set var="registerFlag" value="${empty jnitcmsmenuVO.siteId ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitcmsmenuVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitcmsmenuVO").action = "<c:url value='/jnitcmsmenu/JnitcmsmenuList.do'/>";
   	document.getElementById("jnitcmsmenuVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitcmsmenuVO").action = "<c:url value='/jnitcmsmenu/deleteJnitcmsmenu.do'/>";
   	document.getElementById("jnitcmsmenuVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitcmsmenuVO");

        /* ClientSite Validator */
	//if(!validateJnitcmsmenuVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/jnitcmsmenu/updateJnitcmsmenu.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/jnitcmsmenu/addJnitcmsmenu.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitcmsmenuVO">
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
			<th>SITE_ID</th>
			<td>
				<form:input path="siteId" cssClass="txt"/>
				&nbsp;<form:errors path="siteId" />
			</td>
		</tr>	
		<tr>
			<th>MENU_ID</th>
			<td>
				<form:input path="menuId" cssClass="txt"/>
				&nbsp;<form:errors path="menuId" />
			</td>
		</tr>	
		<tr>
			<th>MENU_NM</th>
			<td>
				<form:input path="menuNm" cssClass="txt"/>
				&nbsp;<form:errors path="menuNm" />
			</td>
		</tr>	
		<tr>
			<th>MENU_PATH</th>
			<td>
				<form:input path="menuPath" cssClass="txt"/>
				&nbsp;<form:errors path="menuPath" />
			</td>
		</tr>	
		<tr>
			<th>PID</th>
			<td>
				<form:input path="pid" cssClass="txt"/>
				&nbsp;<form:errors path="pid" />
			</td>
		</tr>	
		<tr>
			<th>DEPTH</th>
			<td>
				<form:input path="depth" cssClass="txt"/>
				&nbsp;<form:errors path="depth" />
			</td>
		</tr>	
		<tr>
			<th>METHOD</th>
			<td>
				<form:input path="method" cssClass="txt"/>
				&nbsp;<form:errors path="method" />
			</td>
		</tr>	
		<tr>
			<th>ISLINK</th>
			<td>
				<form:input path="islink" cssClass="txt"/>
				&nbsp;<form:errors path="islink" />
			</td>
		</tr>	
		<tr>
			<th>LINKURL</th>
			<td>
				<form:input path="linkurl" cssClass="txt"/>
				&nbsp;<form:errors path="linkurl" />
			</td>
		</tr>	
		<tr>
			<th>LINKTGT</th>
			<td>
				<form:input path="linktgt" cssClass="txt"/>
				&nbsp;<form:errors path="linktgt" />
			</td>
		</tr>	
		<tr>
			<th>TPL_ID</th>
			<td>
				<form:input path="tplId" cssClass="txt"/>
				&nbsp;<form:errors path="tplId" />
			</td>
		</tr>	
		<tr>
			<th>CNT_ID</th>
			<td>
				<form:input path="cntId" cssClass="txt"/>
				&nbsp;<form:errors path="cntId" />
			</td>
		</tr>	
		<tr>
			<th>ADM_MBR_ID</th>
			<td>
				<form:input path="admMbrId" cssClass="txt"/>
				&nbsp;<form:errors path="admMbrId" />
			</td>
		</tr>	
		<tr>
			<th>ACTIVE</th>
			<td>
				<form:input path="active" cssClass="txt"/>
				&nbsp;<form:errors path="active" />
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
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitcmsmenuVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

