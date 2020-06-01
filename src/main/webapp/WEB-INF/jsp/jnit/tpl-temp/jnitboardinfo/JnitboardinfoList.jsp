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
<%
 /**
  * @Class Name : JnitboardinfoList.jsp
  * @Description : Jnitboardinfo List 화면
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
<title>목록</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(boardId) {
    document.getElementById("listForm").boardId.value = boardId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/jnitboardinfo/updateJnitboardinfoView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitboardinfo/addJnitboardinfoView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jnitboardinfo/JnitboardinfoList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
    <input type="hidden" name="boardId" />
<div id="content_pop">
	<!-- 타이틀 -->
	<div id="title">
		<ul>
			<li><img src="<c:url value='/images/egovframework/rte/title_dot.gif'/>" alt="title" /> List </li>
		</ul>
	</div>
	<!-- // 타이틀 -->
	<!-- List -->
	<div id="table">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<colgroup>
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
								<col/>				
							</colgroup>		  
			<tr>
								<th align="center">BoardId</th>
								<th align="center">BoardGroup</th>
								<th align="center">BoardTitle</th>
								<th align="center">BoardType</th>
								<th align="center">BoardSkin</th>
								<th align="center">BoardCnt</th>
								<th align="center">BoardSort</th>
								<th align="center">BoardLbl</th>
								<th align="center">UseCmt</th>
								<th align="center">UseSecret</th>
								<th align="center">UseNotice</th>
								<th align="center">UseFilter</th>
								<th align="center">UseWyswyg</th>
								<th align="center">UseFile</th>
								<th align="center">UseImage</th>
								<th align="center">UseMovie</th>
								<th align="center">UseSms</th>
								<th align="center">UseCategory</th>
								<th align="center">Category</th>
								<th align="center">UseExt01</th>
								<th align="center">Ext01Opt</th>
								<th align="center">Ext01Lbl</th>
								<th align="center">UseExt02</th>
								<th align="center">Ext02Opt</th>
								<th align="center">Ext02Lbl</th>
								<th align="center">UseExt03</th>
								<th align="center">Ext03Opt</th>
								<th align="center">Ext03Lbl</th>
								<th align="center">UseExt04</th>
								<th align="center">Ext04Opt</th>
								<th align="center">Ext04Lbl</th>
								<th align="center">UseExt05</th>
								<th align="center">Ext05Opt</th>
								<th align="center">Ext05Lbl</th>
								<th align="center">UseExt06</th>
								<th align="center">Ext06Opt</th>
								<th align="center">Ext06Lbl</th>
								<th align="center">UseExt07</th>
								<th align="center">Ext07Opt</th>
								<th align="center">Ext07Lbl</th>
								<th align="center">UseExt08</th>
								<th align="center">Ext08Opt</th>
								<th align="center">Ext08Lbl</th>
								<th align="center">UseDate01</th>
								<th align="center">Date01Opt</th>
								<th align="center">Date01Lbl</th>
								<th align="center">UseDate02</th>
								<th align="center">Date02Opt</th>
								<th align="center">Date02Lbl</th>
								<th align="center">AdmExt</th>
								<th align="center">AdmList</th>
								<th align="center">PermList</th>
								<th align="center">PermView</th>
								<th align="center">PermWrite</th>
								<th align="center">PermCmt</th>
								<th align="center">AnonPermList</th>
								<th align="center">AnonPermView</th>
								<th align="center">Active</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
		 				<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.boardId}"/>')"><c:out value="${result.boardId}"/></a>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.boardGroup}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.boardTitle}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.boardType}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.boardSkin}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.boardCnt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.boardSort}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.boardLbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useCmt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useSecret}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useNotice}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useFilter}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useWyswyg}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useFile}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useImage}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useMovie}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useSms}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useCategory}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.category}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useExt01}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext01Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext01Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useExt02}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext02Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext02Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useExt03}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext03Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext03Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useExt04}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext04Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext04Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useExt05}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext05Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext05Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useExt06}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext06Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext06Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useExt07}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext07Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext07Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useExt08}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext08Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ext08Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useDate01}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.date01Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.date01Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.useDate02}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.date02Opt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.date02Lbl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.admExt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.admList}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.permList}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.permView}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.permWrite}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.permCmt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.anonPermList}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.anonPermView}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.active}"/>&nbsp;</td>
									</tr>
			</c:forEach>
		</table>
	</div>
	<!-- /List -->
	<div id="paging">
		<ui:pagination paginationInfo = "${paginationInfo}"
				   type="image"
				   jsFunction="fn_egov_link_page"
				   />
		<form:hidden path="pageIndex" />
	</div>
	<div id="sysbtn1">
		<ul>
			<li>
				<div id="sysbtn">
					<span class="btn_blue_l"><a href="javascript:fn_egov_addView();">등록</a><img src="<c:url value='/images/egovframework/rte/btn_bg_r.gif'/>" alt="" />
					</span>
				</div>
			</li>
		</ul>
	</div>
</div>
</form:form>
</body>
</html>
