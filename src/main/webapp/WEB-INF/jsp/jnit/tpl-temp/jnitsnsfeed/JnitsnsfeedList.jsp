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
  * @Class Name : JnitsnsfeedList.jsp
  * @Description : Jnitsnsfeed List 화면
  * @Modification Information
  * 
  * @author Dael @ JNIT
  * @since 2013.01.03
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


function fn_egov_select(feedId) {
    document.getElementById("listForm").feedId.value = feedId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/jnitsnsfeed/updateJnitsnsfeedView.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/jnitsnsfeed/addJnitsnsfeedView.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/jnitsnsfeed/JnitsnsfeedList.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>
</head>
<body>
<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
    <input type="hidden" name="feedId" />
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
							</colgroup>		  
			<tr>
								<th align="center">FeedId</th>
								<th align="center">FeedType</th>
								<th align="center">Provider</th>
								<th align="center">PvdId</th>
								<th align="center">TagUserKey</th>
								<th align="center">UserKey</th>
								<th align="center">Nickname</th>
								<th align="center">UserId</th>
								<th align="center">ProfileImg</th>
								<th align="center">Content</th>
								<th align="center">Image</th>
								<th align="center">Link</th>
								<th align="center">Created</th>
							</tr>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
		 				<td align="center" class="listtd"><a href="javascript:fn_egov_select('<c:out value="${result.feedId}"/>')"><c:out value="${result.feedId}"/></a>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.feedType}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.provider}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.pvdId}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.tagUserKey}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.userKey}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.nickname}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.userId}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.profileImg}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.content}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.image}"/>&nbsp;</td>
								<td align="center" class="listtd"><c:out value="${result.link}"/>&nbsp;</td>
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
