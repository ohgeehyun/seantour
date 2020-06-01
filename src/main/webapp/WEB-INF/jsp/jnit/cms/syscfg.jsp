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
    		<table class="table"  width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
    			<tr>
                    <td width="175" style="border-right:1px solid #7d7d7d; padding-top:19px;" bgcolor="#fafafa" align="right" valign="top">
                    <%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu0.jsp" %>
                    </td>
    				<td valign="top" style="padding:20px 0 80 20px;">
    				<!--콘텐츠시작-->
    					<table width="95%" border="0" cellspacing="0" cellpadding="0" >
                          <tr>
                            <td colspan="2"><h1>시스템설정</h1></td>
                          </tr>
                        </table>
                        <table width="95%" border="0" cellspacing="0" cellpadding="0" class="content2_table" style="line-height:20px;">
                          <tr>
                            <th ><font color="red">*</font> client(고객사) 아이디</th>
                            <td align="left" class="content_1"><input name="" type="text" style=" width:98%;" value="gure"/><br/>
                            수정은 설정 파일에서 직접 해야합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> JDK 버전</th>
                            <td class="content_1" align="left">
                            <select name="" style="width:98%;">
                            	<option>1.4</option>
                                <option>1.5</option>
                                <option>1.6</option>
                            </select>
                            </td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> Web Application Server</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;" value="tomcat"/><br/>
                            수정은 설정 파일에서 직접 해야합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> 데이타베이스</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;" value="MySQL"/><br/>
                            수정은 설정 파일에서 직접 해야합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> DB 커넥션풀을 사용할 경우 풀 네임</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;" value="JWXE"/><br/>
                            <strong>공백</strong>일 경우에는 자동으로 드라이버를 사용합니다.<br/>
                            수정은 설정 파일에서 직접 해야합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> JDBC Driver 커넥션을 드라이버로 사용할경우 드라이버</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;" value="선택"/><br/>
                            수정은 설정 파일에서 직접 해야합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> JDBC Driver url</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;"/><br/>
                            jdbc:mysql://localhost:3306/jwxe
                            <br>
                            jdbc:sqlserver://localhost:1433;databaseName=jwxe
                            <br>
                            jdbc:jtds:sqlserver://localhost:1433;databaseName=jwxe
                            <br>
                            jdbc:oracle:thin:@localhost:1521:jwxe
                            <br>
                            jdbc:tibero:thin:@localhost:8629:jwxe<br/>
                            수정은 설정 파일에서 직접 해야합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> Database User</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;"/><br/>
                            수정은 설정 파일에서 직접 해야합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> Database Password</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;"/><br/>
                            수정은 설정 파일에서 직접 해야합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> Database Password</th>
                            <td class="content_1" align="left">
                            <select name="" style="width:98%;">
                            	<option>사용함</option>
                                <option>사용하지 않음</option>
                            </select>
                            <br/>
                            발생되는 <strong>모든 쿼리를 System log 에서 확인</strong>합니다.<br>
                            이 기능은 개발시에만 사용할 것을 권장합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> 사용자 아이피값 구하는 방식</th>
                            <td class="content_1" align="left">
                            <select name="" style="width:98%;">
                            	<option>다이렉트 방식</option>
                                <option>포워딩 방식</option>
                            </select>
                            <br/>
                            서버의 중간에 방화벽 또는 L4 장비를 사용하여 사용자의 아이피가 한가지로만 동일하게 나올때 포워딩방식을 활성화 합니다.</td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> 메일서버 IP</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;"/></td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> 메일서버 PORT</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;"/></td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> 인증 메일서버일 경우 ID</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;"/></td>
                          </tr>
                          <tr>
                            <th ><font color="red">*</font> 인증 메일서버일 경우 Password</th>
                            <td class="content_1" align="left"><input name="" type="text" style=" width:98%;"/></td>
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