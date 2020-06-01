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
  * @Class Name : JnitguregistList.jsp
  * @Description : Jnitguregist List 화면
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
<title>목록</title>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(guregistId) {
    document.getElementById("listForm").guregistId.value = guregistId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/jnitguregist/updateJnitguregistView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitguregist/addJnitguregistView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jnitguregist/JnitguregistList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
    <input type="hidden" name="guregistId" />
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
								<col/>				
							</colgroup>		  
			<tr>
								<th align="center">GuregistId</th>
								<th align="center">Rdate</th>
								<th align="center">H1</th>
								<th align="center">H2</th>
								<th align="center">H3</th>
								<th align="center">H4</th>
								<th align="center">H5</th>
								<th align="center">H6</th>
								<th align="center">H7</th>
								<th align="center">H8</th>
								<th align="center">Km1</th>
								<th align="center">Km2</th>
								<th align="center">Km3</th>
								<th align="center">Km4</th>
								<th align="center">Km5</th>
								<th align="center">Km6</th>
								<th align="center">Km7</th>
								<th align="center">Km8</th>
								<th align="center">Kw1</th>
								<th align="center">Kw2</th>
								<th align="center">Kw3</th>
								<th align="center">Kw4</th>
								<th align="center">Kw5</th>
								<th align="center">Kw6</th>
								<th align="center">Kw7</th>
								<th align="center">Kw8</th>
								<th align="center">Fm1</th>
								<th align="center">Fm2</th>
								<th align="center">Fm3</th>
								<th align="center">Fm4</th>
								<th align="center">Fm5</th>
								<th align="center">Fm6</th>
								<th align="center">Fm7</th>
								<th align="center">Fm8</th>
								<th align="center">Fw1</th>
								<th align="center">Fw2</th>
								<th align="center">Fw3</th>
								<th align="center">Fw4</th>
								<th align="center">Fw5</th>
								<th align="center">Fw6</th>
								<th align="center">Fw7</th>
								<th align="center">Fw8</th>
								<th align="center">Om1</th>
								<th align="center">Om2</th>
								<th align="center">Om3</th>
								<th align="center">Om4</th>
								<th align="center">Om5</th>
								<th align="center">Om6</th>
								<th align="center">Om7</th>
								<th align="center">Om8</th>
								<th align="center">Ow1</th>
								<th align="center">Ow2</th>
								<th align="center">Ow3</th>
								<th align="center">Ow4</th>
								<th align="center">Ow5</th>
								<th align="center">Ow6</th>
								<th align="center">Ow7</th>
								<th align="center">Ow8</th>
								<th align="center">Created</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
		 				<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.guregistId}"/>')"><c:out value="${result.guregistId}"/></a>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.rdate}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.h1}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.h2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.h3}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.h4}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.h5}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.h6}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.h7}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.h8}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.km1}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.km2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.km3}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.km4}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.km5}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.km6}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.km7}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.km8}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.kw1}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.kw2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.kw3}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.kw4}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.kw5}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.kw6}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.kw7}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.kw8}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fm1}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fm2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fm3}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fm4}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fm5}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fm6}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fm7}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fm8}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fw1}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fw2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fw3}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fw4}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fw5}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fw6}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fw7}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.fw8}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.om1}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.om2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.om3}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.om4}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.om5}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.om6}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.om7}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.om8}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ow1}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ow2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ow3}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ow4}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ow5}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ow6}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ow7}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.ow8}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.created}"/>&nbsp;</td>
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
