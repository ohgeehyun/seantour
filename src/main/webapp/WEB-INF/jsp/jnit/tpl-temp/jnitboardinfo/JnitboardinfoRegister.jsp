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
  * @Class Name : JnitboardinfoRegister.jsp
  * @Description : Jnitboardinfo Register 화면
  * @Modification Information
  * 
  * @author Dael @ JNIT
  * @since 2013.01.21
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
 <c:set var="registerFlag" value="${empty jnitboardinfoVO.boardId ? '등록' : '수정'}"/>			
-->

<c:set var="registerFlag" value="${empty searchVO.screenMode ? '등록' : '수정'}"/>


<title> <c:out value="${registerFlag}"/> </title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>

<!--For Commons Validator Client Side-->
<!-- script type="text/javascript" src="<c:url value="/validator.do"/>"></script -->
<!-- validator:javascript formName="jnitboardinfoVO" staticJavascript="false" xhtml="true" cdata="false"/ -->

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 목록 화면 function */
function fn_egov_selectList() {
   	document.getElementById("jnitboardinfoVO").action = "<c:url value='/jnitboardinfo/JnitboardinfoList.do'/>";
   	document.getElementById("jnitboardinfoVO").submit();		
}

/* 글 삭제 function */
function fn_egov_delete() {
   	document.getElementById("jnitboardinfoVO").action = "<c:url value='/jnitboardinfo/deleteJnitboardinfo.do'/>";
   	document.getElementById("jnitboardinfoVO").submit();		
}

/* 글 등록 function */
function fn_egov_save() {	
	frm = document.getElementById("jnitboardinfoVO");

        /* ClientSite Validator */
	//if(!validateJnitboardinfoVO(frm)){
	//		return;
	//}

	<c:if test="${registerFlag == '수정'}">
  		frm.action = "<c:url value='/jnitboardinfo/updateJnitboardinfo.do'/>";
	</c:if>
	<c:if test="${registerFlag == '등록'}">
		frm.action = "<c:url value='/jnitboardinfo/addJnitboardinfo.do'/>";
	</c:if>
    frm.submit();

}

// -->
</script>
</head>
<body>

<form:form commandName="jnitboardinfoVO">
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
			<th>BOARD_ID</th>
			<td>
				<form:input path="boardId" cssClass="txt"/>
				&nbsp;<form:errors path="boardId" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_GROUP</th>
			<td>
				<form:input path="boardGroup" cssClass="txt"/>
				&nbsp;<form:errors path="boardGroup" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_TITLE</th>
			<td>
				<form:input path="boardTitle" cssClass="txt"/>
				&nbsp;<form:errors path="boardTitle" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_TYPE</th>
			<td>
				<form:input path="boardType" cssClass="txt"/>
				&nbsp;<form:errors path="boardType" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_SKIN</th>
			<td>
				<form:input path="boardSkin" cssClass="txt"/>
				&nbsp;<form:errors path="boardSkin" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_CNT</th>
			<td>
				<form:input path="boardCnt" cssClass="txt"/>
				&nbsp;<form:errors path="boardCnt" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_SORT</th>
			<td>
				<form:input path="boardSort" cssClass="txt"/>
				&nbsp;<form:errors path="boardSort" />
			</td>
		</tr>	
		<tr>
			<th>BOARD_LBL</th>
			<td>
				<form:input path="boardLbl" cssClass="txt"/>
				&nbsp;<form:errors path="boardLbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_CMT</th>
			<td>
				<form:input path="useCmt" cssClass="txt"/>
				&nbsp;<form:errors path="useCmt" />
			</td>
		</tr>	
		<tr>
			<th>USE_SECRET</th>
			<td>
				<form:input path="useSecret" cssClass="txt"/>
				&nbsp;<form:errors path="useSecret" />
			</td>
		</tr>	
		<tr>
			<th>USE_NOTICE</th>
			<td>
				<form:input path="useNotice" cssClass="txt"/>
				&nbsp;<form:errors path="useNotice" />
			</td>
		</tr>	
		<tr>
			<th>USE_FILTER</th>
			<td>
				<form:input path="useFilter" cssClass="txt"/>
				&nbsp;<form:errors path="useFilter" />
			</td>
		</tr>	
		<tr>
			<th>USE_WYSWYG</th>
			<td>
				<form:input path="useWyswyg" cssClass="txt"/>
				&nbsp;<form:errors path="useWyswyg" />
			</td>
		</tr>	
		<tr>
			<th>USE_FILE</th>
			<td>
				<form:input path="useFile" cssClass="txt"/>
				&nbsp;<form:errors path="useFile" />
			</td>
		</tr>	
		<tr>
			<th>USE_IMAGE</th>
			<td>
				<form:input path="useImage" cssClass="txt"/>
				&nbsp;<form:errors path="useImage" />
			</td>
		</tr>	
		<tr>
			<th>USE_MOVIE</th>
			<td>
				<form:input path="useMovie" cssClass="txt"/>
				&nbsp;<form:errors path="useMovie" />
			</td>
		</tr>	
		<tr>
			<th>USE_SMS</th>
			<td>
				<form:input path="useSms" cssClass="txt"/>
				&nbsp;<form:errors path="useSms" />
			</td>
		</tr>	
		<tr>
			<th>USE_CATEGORY</th>
			<td>
				<form:input path="useCategory" cssClass="txt"/>
				&nbsp;<form:errors path="useCategory" />
			</td>
		</tr>	
		<tr>
			<th>CATEGORY</th>
			<td>
				<form:input path="category" cssClass="txt"/>
				&nbsp;<form:errors path="category" />
			</td>
		</tr>	
		<tr>
			<th>USE_EXT01</th>
			<td>
				<form:input path="useExt01" cssClass="txt"/>
				&nbsp;<form:errors path="useExt01" />
			</td>
		</tr>	
		<tr>
			<th>EXT01_OPT</th>
			<td>
				<form:input path="ext01Opt" cssClass="txt"/>
				&nbsp;<form:errors path="ext01Opt" />
			</td>
		</tr>	
		<tr>
			<th>EXT01_LBL</th>
			<td>
				<form:input path="ext01Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="ext01Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_EXT02</th>
			<td>
				<form:input path="useExt02" cssClass="txt"/>
				&nbsp;<form:errors path="useExt02" />
			</td>
		</tr>	
		<tr>
			<th>EXT02_OPT</th>
			<td>
				<form:input path="ext02Opt" cssClass="txt"/>
				&nbsp;<form:errors path="ext02Opt" />
			</td>
		</tr>	
		<tr>
			<th>EXT02_LBL</th>
			<td>
				<form:input path="ext02Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="ext02Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_EXT03</th>
			<td>
				<form:input path="useExt03" cssClass="txt"/>
				&nbsp;<form:errors path="useExt03" />
			</td>
		</tr>	
		<tr>
			<th>EXT03_OPT</th>
			<td>
				<form:input path="ext03Opt" cssClass="txt"/>
				&nbsp;<form:errors path="ext03Opt" />
			</td>
		</tr>	
		<tr>
			<th>EXT03_LBL</th>
			<td>
				<form:input path="ext03Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="ext03Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_EXT04</th>
			<td>
				<form:input path="useExt04" cssClass="txt"/>
				&nbsp;<form:errors path="useExt04" />
			</td>
		</tr>	
		<tr>
			<th>EXT04_OPT</th>
			<td>
				<form:input path="ext04Opt" cssClass="txt"/>
				&nbsp;<form:errors path="ext04Opt" />
			</td>
		</tr>	
		<tr>
			<th>EXT04_LBL</th>
			<td>
				<form:input path="ext04Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="ext04Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_EXT05</th>
			<td>
				<form:input path="useExt05" cssClass="txt"/>
				&nbsp;<form:errors path="useExt05" />
			</td>
		</tr>	
		<tr>
			<th>EXT05_OPT</th>
			<td>
				<form:input path="ext05Opt" cssClass="txt"/>
				&nbsp;<form:errors path="ext05Opt" />
			</td>
		</tr>	
		<tr>
			<th>EXT05_LBL</th>
			<td>
				<form:input path="ext05Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="ext05Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_EXT06</th>
			<td>
				<form:input path="useExt06" cssClass="txt"/>
				&nbsp;<form:errors path="useExt06" />
			</td>
		</tr>	
		<tr>
			<th>EXT06_OPT</th>
			<td>
				<form:input path="ext06Opt" cssClass="txt"/>
				&nbsp;<form:errors path="ext06Opt" />
			</td>
		</tr>	
		<tr>
			<th>EXT06_LBL</th>
			<td>
				<form:input path="ext06Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="ext06Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_EXT07</th>
			<td>
				<form:input path="useExt07" cssClass="txt"/>
				&nbsp;<form:errors path="useExt07" />
			</td>
		</tr>	
		<tr>
			<th>EXT07_OPT</th>
			<td>
				<form:input path="ext07Opt" cssClass="txt"/>
				&nbsp;<form:errors path="ext07Opt" />
			</td>
		</tr>	
		<tr>
			<th>EXT07_LBL</th>
			<td>
				<form:input path="ext07Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="ext07Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_EXT08</th>
			<td>
				<form:input path="useExt08" cssClass="txt"/>
				&nbsp;<form:errors path="useExt08" />
			</td>
		</tr>	
		<tr>
			<th>EXT08_OPT</th>
			<td>
				<form:input path="ext08Opt" cssClass="txt"/>
				&nbsp;<form:errors path="ext08Opt" />
			</td>
		</tr>	
		<tr>
			<th>EXT08_LBL</th>
			<td>
				<form:input path="ext08Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="ext08Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_DATE01</th>
			<td>
				<form:input path="useDate01" cssClass="txt"/>
				&nbsp;<form:errors path="useDate01" />
			</td>
		</tr>	
		<tr>
			<th>DATE01_OPT</th>
			<td>
				<form:input path="date01Opt" cssClass="txt"/>
				&nbsp;<form:errors path="date01Opt" />
			</td>
		</tr>	
		<tr>
			<th>DATE01_LBL</th>
			<td>
				<form:input path="date01Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="date01Lbl" />
			</td>
		</tr>	
		<tr>
			<th>USE_DATE02</th>
			<td>
				<form:input path="useDate02" cssClass="txt"/>
				&nbsp;<form:errors path="useDate02" />
			</td>
		</tr>	
		<tr>
			<th>DATE02_OPT</th>
			<td>
				<form:input path="date02Opt" cssClass="txt"/>
				&nbsp;<form:errors path="date02Opt" />
			</td>
		</tr>	
		<tr>
			<th>DATE02_LBL</th>
			<td>
				<form:input path="date02Lbl" cssClass="txt"/>
				&nbsp;<form:errors path="date02Lbl" />
			</td>
		</tr>	
		<tr>
			<th>ADM_EXT</th>
			<td>
				<form:input path="admExt" cssClass="txt"/>
				&nbsp;<form:errors path="admExt" />
			</td>
		</tr>	
		<tr>
			<th>ADM_LIST</th>
			<td>
				<form:input path="admList" cssClass="txt"/>
				&nbsp;<form:errors path="admList" />
			</td>
		</tr>	
		<tr>
			<th>PERM_LIST</th>
			<td>
				<form:input path="permList" cssClass="txt"/>
				&nbsp;<form:errors path="permList" />
			</td>
		</tr>	
		<tr>
			<th>PERM_VIEW</th>
			<td>
				<form:input path="permView" cssClass="txt"/>
				&nbsp;<form:errors path="permView" />
			</td>
		</tr>	
		<tr>
			<th>PERM_WRITE</th>
			<td>
				<form:input path="permWrite" cssClass="txt"/>
				&nbsp;<form:errors path="permWrite" />
			</td>
		</tr>	
		<tr>
			<th>PERM_CMT</th>
			<td>
				<form:input path="permCmt" cssClass="txt"/>
				&nbsp;<form:errors path="permCmt" />
			</td>
		</tr>	
		<tr>
			<th>ANON_PERM_LIST</th>
			<td>
				<form:input path="anonPermList" cssClass="txt"/>
				&nbsp;<form:errors path="anonPermList" />
			</td>
		</tr>	
		<tr>
			<th>ANON_PERM_VIEW</th>
			<td>
				<form:input path="anonPermView" cssClass="txt"/>
				&nbsp;<form:errors path="anonPermView" />
			</td>
		</tr>	
		<tr>
			<th>ACTIVE</th>
			<td>
				<form:input path="active" cssClass="txt"/>
				&nbsp;<form:errors path="active" />
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
			<li><span class="btn_blue_l"><a href="javascript:document.getElementById("jnitboardinfoVO").reset();">Reset</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" /></span></li></ul>
	</div>
</div>
<!-- 검색조건 유지 -->
<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
<input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>

