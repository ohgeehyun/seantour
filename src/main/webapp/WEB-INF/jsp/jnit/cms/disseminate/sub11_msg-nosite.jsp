<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
		
<ul class="view_content_btn">
    <!--li class="add"><a href="<c:url value="/cms" />/sub1/0102.do">추가</a></li>
    <li class="back"><a href="#">되돌아가기</a></li>
    <li class="modify"><a href="#">수정</a></li>
    <li class="delete"><a href="#">삭제</a></li-->
    <!--li class="save"><a href="javascript:fn_egov_save();">저장</a></li>
    <li class="search_btn">
        <form action="#" id="search_form" name="search_form">
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
        </form>
    </li-->
    <li style="background:none;"><strong>지정된 사이트 없음</strong></li>
</ul>
<div class="view">
<!--콘텐츠시작-->

<!--콘텐츠끝-->
</div>

<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>

