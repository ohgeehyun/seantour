<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
   	<%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu_top.jsp" %>
          <tr>
            <td class="lefttitle">회원관리</td>
          </tr>
          <tr>
            <td>
            	<table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub2/0101.do">회원 리스트</a></td>
                  </tr>
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub2/0102.do">회원 등록</a></td>
                  </tr>
                </table>

            </td>
          </tr>
          <tr>
            <td class="lefttitle">유형관리</td>
          </tr>
          <tr>
            <td>
            	<table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub2/0201.do">유형 리스트</a></td>
                  </tr>
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub2/0202.do">유형 등록</a></td>
                  </tr>
                </table>

            </td>
          </tr>
          <tr>
            <td class="lefttitle"><a href="<c:url value="/cms/sub2/020101.do" />">접근레벨관리</a></td>
          </tr>
        </table>