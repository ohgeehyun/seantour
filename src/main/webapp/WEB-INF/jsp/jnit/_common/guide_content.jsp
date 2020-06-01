<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<ul class="view_content_btn">
    <!--li class="view_btn1"><a href="#">등록</a></li-->
    <li class="view_btn2"><a href="#">추가</a></li>
    <li class="view_btn6"><a href="#">되돌아가기</a></li>
    <li class="view_btn4"><a href="#">수정</a></li>
    <li class="view_btn3"><a href="#">삭제</a></li>
    <li class="view_btn5"><a href="#">저장</a></li>
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
        <!--form action="#" id="search_form" name="search_form">
            <input name="search_day1" id="search_day" type="text" />&nbsp;<strong>~</strong>&nbsp;
            <input name="search_day2" id="search_day" type="text" />
            <a href="#">검색</a>
        </form-->
    </li>
</ul>
<div class="view">
    <table cellpadding="0" cellspacing="0" border="0" class="AlignCenter" summary="파일 리스트">
        <caption>파일 리스트</caption>
        <thead>
            <tr>
                <th>No.</th>
                <th class="BorderRightNone">파일명</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td class="BorderRightNone">base.css</td>
            </tr>
            <tr>
                <td>2</td>
                <td class="BorderRightNone">style.css</td>
            </tr>
            <tr>
                <td>3</td>
                <td class="BorderRightNone">main.css</td>
            </tr>
            <tr>
                <td>4</td>
                <td class="BorderRightNone">sub.css</td>
            </tr>
            <tr>
                <td>5</td>
                <td class="BorderRightNone">content.css</td>
            </tr>
        </tbody>
    </table>
    <!--페이지 내비게이션-->
    <div id="page_navi">
        <a class="pagebtn first" href="#"><img src="<c:url value="/img/common/first.gif" />" alt="처음으로" /></a>
        <a class="pagebtn previous" href="#"><img src="<c:url value="/img/common/previous.gif" />" alt="이전" /></a>
        <a class="pagebtn on BorderNone" href="#">1</a>
        <a class="pagebtn" href="#">2</a>
        <a class="pagebtn" href="#">3</a>
        <a class="pagebtn" href="#">4</a>
        <a class="pagebtn" href="#">5</a>
        <a class="pagebtn" href="#">6</a>
        <a class="pagebtn" href="#">7</a>
        <a class="pagebtn" href="#">8</a>
        <a class="pagebtn" href="#">9</a>
        <a class="pagebtn" href="#">10</a>
        <a class="pagebtn next" href="#"><img src="<c:url value="/img/common/next.gif" />" alt="다음" /></a>
        <a class="pagebtn end" href="#"><img src="<c:url value="/img/common/end.gif" />" alt="끝으로" /></a>
    </div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>