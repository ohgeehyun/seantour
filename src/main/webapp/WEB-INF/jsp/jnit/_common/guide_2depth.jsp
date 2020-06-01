<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<ul class="list_content_btn">
    <li class="f_plus"><a href="#">파일추가</a></li>
    <li class="f_minus"><a href="#">파일삭제</a></li>
    <!--li class="m_plus"><a href="#">구조메뉴</a></li>
    <li class="c_plus"><a href="#">콘텐츠메뉴</a></li-->
</ul>
<div class="list">
    <table cellpadding="0" cellspacing="0" border="0" class="AlignCenter" summary="css 파일 리스트">
        <caption>css 파일 리스트</caption>
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
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>