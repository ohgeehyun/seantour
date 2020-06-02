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
  * @Class Name : JnitcmsmbrList.jsp
  * @Description : Jnitcmsmbr List 화면
  * @Modification Information
  * 
  * @author JNIT
  * @since 2012.06.01
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

function fn_egov_select(mbrId) {
    document.getElementById("listForm").mbrId.value = mbrId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/jnitcmsmbr/updateJnitcmsmbrView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitcmsmbr/addJnitcmsmbrView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jnitcmsmbr/JnitcmsmbrList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
    <input type="hidden" name="mbrId" />
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
							</colgroup>		  
			<tr>
								<th align="center">MbrId</th>
								<th align="center">OrgId</th>
								<th align="center">PosId</th>
								<th align="center">MbrNm</th>
								<th align="center">Passwd</th>
								<th align="center">TypeId</th>
								<th align="center">Tel</th>
								<th align="center">Mobile</th>
								<th align="center">Email</th>
								<th align="center">Created</th>
								<th align="center">Modified</th>
								<th align="center">Isdel</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
		 				<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.mbrId}"/>')"><c:out value="${result.mbrId}"/></a>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.orgId}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.posId}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.mbrNm}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.passwd}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.typeId}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.tel}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.mobile}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.email}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.created}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.modified}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.isdel}"/>&nbsp;</td>
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