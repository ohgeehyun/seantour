<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
   	<%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu_top.jsp" %>
          <tr>
            <td class="lefttitle">템플릿관리</td>
          </tr>
          <tr>
            <td>
            	<table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub4/0101.do">메인 템플릿</a></td>
                  </tr>
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub4/0102.do">서브 템플릿</a></td>
                  </tr>
                  <tr>
                    <td class="leftmenu_1"><a href="<c:url value="/cms" />/sub4/010201.do">- 등록</a></td>
                  </tr>
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub4/0103.do">로그인 템플릿</a></td>
                  </tr>
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub4/0104.do">회원가입 템플릿</a></td>
                  </tr>
                </table>

            </td>
          </tr>
        </table>