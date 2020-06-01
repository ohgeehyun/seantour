<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* 글 수정 화면 function */


function fn_egov_select(bbsId) {
    document.getElementById("listForm").bbsId.value = bbsId;
	document.getElementById("listForm").screenMode.value = "up";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub5/0102upview.do'/>";
   	document.getElementById("listForm").submit();
}

/* 글 등록 화면 function */
function fn_egov_addView() {
	document.getElementById("listForm").screenMode.value = "";
   	document.getElementById("listForm").action = "<c:url value='/cms/sub5/0102addview.do'/>";
   	document.getElementById("listForm").submit();		
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub5/0101.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
    <input type="hidden" name="bbsId" />
    <input type="hidden" name="searchCondition" value="1" />
<ul class="view_content_btn">
    <li class="add"><a href="<c:url value="/cms" />/sub5/0102.do">추가</a></li>
    <!--li class="back"><a href="#">되돌아가기</a></li>
    <li class="modify"><a href="#">수정</a></li>
    <li class="delete"><a href="#">삭제</a></li>
    <li class="save"><a href="#">저장</a></li-->
    <li class="search_btn">
        <!--form action="#" id="search_form" name="search_form">
            <select name="search_select" id="search_select">
                <option selected="selected" value="#">등록일순</option>
                <option value="#">수정일순</option>
                <option value="#">이름순</option>
                <option value="#">설명순</option>
                <option value="#">파일명순</option>
            </select>
            <input name="search" id="search" type="text" />
            <a href="#">검색</a>
        </form-->
        <input name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
        <button>검색</button>
        <!--form action="#" id="search_form" name="search_form">
            <input name="search_day1" id="search_day" type="text" />&nbsp;<strong>~</strong>&nbsp;
            <input name="search_day2" id="search_day" type="text" />
            <a href="#">검색</a>
        </form-->
    </li>
</ul>
<div class="view">
<!--콘텐츠시작-->
    <table class="table" cellpadding="0" cellspacing="0" border="0" summary="게시판 리스트">
        <caption>게시판 리스트</caption>
        <thead>
            <tr>
                <th width="10%">
                <c:if test="${!empty bbsGroupList}">
                <select name="schBbsGroup" onchange="fn_egov_link_page(1);">
                <option value="">전체 그룹</option>
                <c:forEach var="groupResult" items="${bbsGroupList}" varStatus="status">
                <c:if test="${!empty groupResult.bbsGroup}">
                <option value="<c:out value="${groupResult.bbsGroup}"/>" <c:out value="${searchVO.schBbsGroup == groupResult.bbsGroup ? 'selected' : ''}"/>><c:out value="${groupResult.bbsGroup}"/></option>
                </c:if>
                </c:forEach>
                </select>
                </c:if></td>
                <th width="13%">코드</td>
                <th width="25%">제목</td>
                <th width="12%">유형</td>
                <th width="12%">스킨</td>
                <th width="18%">권한</td>
                <th width="10%">관리</td>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${resultList}" varStatus="status">
            <tr>
                <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.bbsId}"/>')"><c:out value="${result.bbsGroup}"/></a></td>
                <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.bbsId}"/>')"><c:out value="${result.bbsId}"/></a></td>
                <td><a href="javascript:fn_egov_select('<c:out value="${result.bbsId}"/>')"><c:out value="${result.bbsTitle}"/></a></td>
                <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.bbsId}"/>')"><c:out value="${bbsTypes[result.bbsType]}"/></a></td>
                <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.bbsId}"/>')"><c:out value="${result.bbsSkin}"/></a></td>
                <td align="center"><a href="javascript:fn_egov_select('<c:out value="${result.bbsId}"/>')">
                <label>목록:</label><c:out value="${result.permList}"/>,
                <label>보기:</label><c:out value="${result.permView}"/>,
                <label>쓰기:</label><c:out value="${result.permWrite}"/>,
                <label>댓글:</label><c:out value="${result.permCmt}"/>
                </a>
                </td>
                <td align="center"><a href="<c:url value="/bbs/bbs.do?bbsId=${result.bbsId}"/>" target="_blank">[게시판보기]</a></td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
    <div id="page_navi">
        <ui:pagination paginationInfo = "${paginationInfo}"
                   type="image"
                   jsFunction="fn_egov_link_page"
                   />
        <form:hidden path="pageIndex" />
        
        <!-- 
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/btn_firstp.gif">&nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/prev1.gif"> &nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/cutln.gif">&nbsp;&nbsp;<B>1</B>&nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/cutln.gif">&nbsp;&nbsp;2&nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/cutln.gif">&nbsp;&nbsp;3&nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/cutln.gif">&nbsp;&nbsp;4&nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/cutln.gif">&nbsp;&nbsp;5&nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/cutln.gif">&nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/next1.gif">&nbsp;&nbsp;
            <IMG border=0 align=absMiddle src="<c:url value="/images/jnit/cms" />/btn_lastp.gif">
          -->
	</div>
        <!--TABLE cellSpacing=0 cellPadding=0 width="100%">
            <TR>
                <TD width="90%" align=middle>
                    <INPUT style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; HEIGHT: 19px; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>">
                    <input type=image src='<c:url value="/images/jnit/cms" />/btn_search.gif'>
                </TD>
                <TD><IMG align=absMiddle src="<c:url value="/images/jnit/cms" />/btn_list.gif"></TD>
            </TR>
        </TABLE-->
<!--콘텐츠끝-->
</div>
</form:form>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>
