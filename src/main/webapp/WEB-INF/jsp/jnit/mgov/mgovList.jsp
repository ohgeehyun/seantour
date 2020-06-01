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
  * @Class Name : JnitsmsmgovList.jsp
  * @Description : Jnitsmsmgov List 화면
  * @Modification Information
  * 
  * @author JNITSMSMGOV
  * @since 2013.11.25
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


function fn_egov_select(msgNo) {
    document.getElementById("listForm").msgNo.value = msgNo;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/jnitsmsmgov/updateJnitsmsmgovView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitsmsmgov/addJnitsmsmgovView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jnitsmsmgov/JnitsmsmgovList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
    <input type="hidden" name="msgNo" />
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
							</colgroup>		  
			<tr>
								<th align="center">MsgNo</th>
								<th align="center">MsgKey</th>
								<th align="center">MsgUid</th>
								<th align="center">MsgSendNo</th>
								<th align="center">MsgRcvName</th>
								<th align="center">MsgRcvNo</th>
								<th align="center">MsgType</th>
								<th align="center">MsgType2</th>
								<th align="center">MsgSubject</th>
								<th align="center">MsgTxt</th>
								<th align="center">MsgUrl</th>
								<th align="center">MsgFile1</th>
								<th align="center">MsgFile2</th>
								<th align="center">MsgFile3</th>
								<th align="center">MsgStatus</th>
								<th align="center">MsgRststus</th>
								<th align="center">MsgTelco</th>
								<th align="center">MsgCode</th>
								<th align="center">MsgTransDt</th>
								<th align="center">MsgSendDt</th>
								<th align="center">MsgReptDt</th>
								<th align="center">MsgRsltDt</th>
								<th align="center">MsgDate</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
		 				<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.msgNo}"/>')"><c:out value="${result.msgNo}"/></a>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgKey}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgUid}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgSendNo}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgRcvName}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgRcvNo}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgType}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgType2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgSubject}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgTxt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgUrl}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgFile1}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgFile2}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgFile3}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgStatus}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgRststus}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgTelco}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgCode}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgTransDt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgSendDt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgReptDt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgRsltDt}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.msgDate}"/>&nbsp;</td>
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
