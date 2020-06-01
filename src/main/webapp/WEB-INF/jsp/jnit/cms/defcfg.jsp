<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/header.jsp" %>
<table cellspacing="0" border="0" height="100%" width="100%" cellpadding="0">
    <tr>
    	<td valign="top"  height="1%"><%@ include file="/WEB-INF/jsp/jnit/include/cms/top_menu.jsp" %><%@ include file="/WEB-INF/jsp/jnit/include/cms/top_line.jsp" %></td>
    </tr>
    <tr>
    	<td valign="top">
    		<table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    			<tr>
                    <td width="175" style="border-right:1px solid #7d7d7d; padding-top:19px;" bgcolor="#fafafa" align="right" valign="top">
                    <%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu0.jsp" %>
                    </td>
    				<td valign="top" style="padding:20px 0 80 20px;">
    				<!--콘텐츠시작-->
    					<table width="95%" border="0" cellspacing="0" cellpadding="0" >
                          <tr>
                            <td colspan="2"><h1>기본설정</h1></td>
                          </tr>
                        </table>
                        <table width="95%" border="0" cellspacing="0" cellpadding="0" class="content2_table" style="line-height:20px;">
                        	
                          <tr>
                            <th ><font color="red">*</font> 비밀번호, 주민번호 암호화 방식</th>
                            <td class="content_1" align="left">
                            <select name="" style="width:98%;">
                            	<option>AES 알고리즘 사용</option>
                                <option>MD5 알고리즘 사용</option>
                                <option>암호화 하지 않음</option>
                            </select>
                            <br/>
                            암호화 방식을 변경하게 되면 이미 DB 에기록된 암호화된 데이타는 DB에서 수동으로 바꿔주셔야 합니다. 바꾸지 않은 상태에서는 비밀번호가 틀리기 때문에 로그인이 되지 않습니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> 어드민 접속이 가능한 IP</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;"/><br/>
                            특정 아이피만 어드민에 접속하고자 할 경우 입력합니다.<br/>
                            ip의 부분입력이 가능하고 각 아이피는 ; 으로 구분합니다.<br/>
                            ex) 192.168;231.234.234.222;121.123.223</td>
                          </tr>
                        </table>
                        <table width="95%" border="0" cellspacing="0" cellpadding="0" style="margin:10px 0 20px 0;">
                          <tr>
                            <td width="25%" align="center"><a href="#"><img src="<c:url value="/images/jnit/cms" />/okbut.gif"></a>&nbsp;<a href="#"><img src="<c:url value="/images/jnit/cms" />/cancelbut.gif"></a></td>
                          </tr>
                        </table>
   					 <!--콘텐츠끝-->
    				</td>
                    <td width="5" bgcolor="#fafafa" style="border-left:1px solid #878a8c;">&nbsp;</td>
                    <td width="175" style="border-left:1px solid #a2a2a2;" valign="top"><%@ include file="/WEB-INF/jsp/jnit/include/cms/quick.jsp" %></td>
    			</tr>
    		</table>
    	</td>
    </tr>
    <tr>
    	<td valign="top" height="1%"><%@ include file="/WEB-INF/jsp/jnit/include/cms/bottom.jsp" %></td>
    </tr>
</table>
<%@ include file="/WEB-INF/jsp/jnit/include/cms/footer.jsp" %>