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


function fn_egov_edit(cntId) {
	var msg = window.open('<c:url value="/cms/sub11/0101upview.do?cntId="/>'+cntId,'editWindow','width:1200,height:750,scrollbars=yes');
}

/* pagination 페이지 링크 function */
function fn_egov_link_page(pageNo){
	document.getElementById("listForm").screenMode.value = "";
	document.getElementById("listForm").pageIndex.value = pageNo;
	document.getElementById("listForm").action = "<c:url value='/cms/sub11/0101.do'/>";
   	document.getElementById("listForm").submit();
}

 // -->
</script>

<form:form commandName="searchVO" name="listForm" id="listForm" method="post">
    <input type="hidden" name="screenMode" />
    <input type="hidden" name="siteId" />
    <input type="hidden" name="cntId" />
    <input type="hidden" name="searchCondition" value="0" />
    
<ul class="view_content_btn">
    <!--li class="add"><a href="<c:url value="/cms" />/sub1/0102.do">추가</a></li>
    <li class="back"><a href="#">되돌아가기</a></li>
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
        </form>
        <input name="searchKeyword" id="search" value="<c:out value='${searchVO.searchKeyword}'/>">
        <button>검색</button>
        <form action="#" id="search_form" name="search_form">
            <input name="search_day1" id="search_day" type="text" />&nbsp;<strong>~</strong>&nbsp;
            <input name="search_day2" id="search_day" type="text" />
            <a href="#">검색</a>
        </form-->
        <select name="">
            <option id="">100개</option>
            <option id="">200개</option>
            <option id="">300개</option>
        </select>
    </li>
</ul>
<div class="view">
<!--콘텐츠시작-->
    <table class="table" cellpadding="0" cellspacing="0" border="0" summary="콘텐츠 리스트">
        <caption>콘텐츠 리스트</caption>
        <thead>
            <tr>
                <th width="29%">메뉴위치▲▼</td>
                <th width="15%">콘텐츠명</td>
                <th width="20%">콘텐츠<br/>템플릿명</td>
                <th width="9%">메인<br/>여부</td>
                <th width="17%">링크주소</td>
                <th width="12%">수정</td>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${resultList}" varStatus="status">
            <tr>
                <td align="center" class="listtd" align="left"><a href="<c:url value="${menuPathMap[result.cntId]}"/>" title="<c:out value="${result.menuNm}"/>" target="_blank"><c:out value="${menuNameMap[result.cntId]}"/></a></td>
                <td align="center" class="listtd"><a href="<c:url value="${menuPathMap[result.cntId]}"/>" title="<c:out value="${result.menuNm}"/>" target="_blank"><c:out value="${result.menuNm}"/></a></td>
                <td align="center" class="listtd"><a href="<c:url value="${menuPathMap[result.cntId]}"/>" title="<c:out value="${result.menuNm}"/>" target="_blank"><c:out value="${result.tplNm}"/></a></td>
                <td align="center" class="listtd"><a href="<c:url value="${menuPathMap[result.cntId]}"/>" title="<c:out value="${result.menuNm}"/>" target="_blank"><c:out value="${result.ismain == 0 ? '' : '메인'}"/></a></td>
                <td align="center" class="listtd" align="left"><a href="<c:url value="${menuPathMap[result.cntId]}"/>" title="<c:out value="${result.menuNm}"/>" target="_blank"><c:out value="${menuPathMap[result.cntId]}"/></a></td>
                <td align="center" class="listtd">
                <a href="javascript:fn_egov_edit('<c:out value="${result.cntId}"/>')"><img src="<c:url value="/images/jnit/cms" />/contentsavebut.gif" alt="수정"></a>
                </td>
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
