<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table width="95%" border="0" cellspacing="0" cellpadding="0">
   	<%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu_top.jsp" %>
          <tr>
            <td class="lefttitle">직급관리</td>
          </tr>
          <tr>
            <td>
            	<table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub1/0101.do">직급 리스트</a></td>
                  </tr>
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub1/0102.do">직급 등록</a></td>
                  </tr>
                  <!-- tr>
                    <td><a href="<c:url value="/cms" />/sub1/0103.do">직급 삭제</a></td>
                  </tr -->
                </table>

            </td>
          </tr>
          <tr>
            <td class="lefttitle">부서관리</td>
          </tr>
          <tr>
            <td>
            	<table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub1/0201.do">부서 리스트</a></td>
                  </tr>
                  <tr>
                    <td><a href="<c:url value="/cms" />/sub1/0202.do">부서 등록</a></td>
                  </tr>
                  <!-- tr>
                    <td><a href="<c:url value="/cms" />/sub1/0203.do">부서 삭제</a></td>
                  </tr -->
                </table>

            </td>
          </tr>
        </table>