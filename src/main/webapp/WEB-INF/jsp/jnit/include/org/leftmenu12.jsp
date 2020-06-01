<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
          
<table width="95%" border="0" cellspacing="0" cellpadding="0">
   	<%@ include file="/WEB-INF/jsp/jnit/include/cms/leftmenu_top.jsp" %>
   	
    <tr>
    	<td class="lefttitle">조직도 DB</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/org" />/sub12/0101.do">조직도 리스트</a></td>
                </tr>
                <!-- 
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/org" />/sub12/0102.do">- 등록</a></td>
                </tr>
                 -->
            </table>
        </td>
    </tr>
    <tr>
    	<td class="lefttitle">민원사무 DB</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/guide" />/sub13/0101.do">민원사무 편람 리스트</a></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
    	<td class="lefttitle">메뉴 DB</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/menu" />/sub14/0101.do">메뉴 리스트</a></td>
                </tr>
                <!-- 
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/org" />/sub12/0102.do">- 등록</a></td>
                </tr>
                 -->
            </table>
        </td>
    </tr>
    <tr>
    	<td class="lefttitle">모바일주변정보 DB</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
			    <tr>
			    	<td class="lefttitle">카테고리관리</td>
			    </tr>
			    <tr>
			        <td>
			            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
			                <tr>
			                	<td><a href="<c:url value="/poi" />/sub15/010101.do">대분류관리</a></td>
			                </tr>
			                <tr>
			                	<td class="leftmenu_1"><a href="<c:url value="/poi" />/sub15/010101.do">- 리스트</a></td>
			                </tr>
			                <tr>
			                	<td class="leftmenu_1"><a href="<c:url value="/poi" />/sub15/010101.do?ctgryMode=WRITE">- 등록</a></td>
			                </tr>
			                <tr>
			                	<td><a href="<c:url value="/poi" />/sub15/010201.do">소분류관리</a></td>
			                </tr>
			                <tr>
			                	<td class="leftmenu_1"><a href="<c:url value="/poi" />/sub15/010201.do">- 리스트</a></td>
			                </tr>
			                <tr>
			                	<td class="leftmenu_1"><a href="<c:url value="/poi" />/sub15/010201.do?ctgryMode=WRITE">- 등록</a></td>
			                </tr>
			            </table>
			        
			        </td>
			    </tr>
			    <tr>
			    	<td class="lefttitle">데이터관리</td>
			    </tr>
			    <tr>
			        <td>
			            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
			                <tr>
			                	<td><a href="<c:url value="/poi" />/sub15/0201.do">리스트</a></td>
			                </tr>
			                <tr>
			                	<td><a href="<c:url value="/poi" />/sub15/0201.do?goodsMode=WRITE">등록</a></td>
			                </tr>
			            </table>
			        
			        </td>
			    </tr>
            </table>
        </td>
    </tr>
    <tr>
    	<td class="lefttitle">체육시설 예약</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub16/0101.do">체육시설예약 리스트</a></td>
                </tr>
                <tr>
                	<td><a href="<c:url value="/rsv" />/sub16/0101.do?facilitiesMode=WRITE">체육시설예약 추가</a></td>
                </tr>
                <!-- 
                <tr>
                	<td class="leftmenu_1"><a href="<c:url value="/org" />/sub12/0102.do">- 등록</a></td>
                </tr>
                 -->
            </table>
        </td>
    </tr>
	<tr>
		<td class="lefttitle">주민등록인구</td>
	</tr>
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
				<tr>
					<td><a href="<c:url value="/gu/add.do" />">등록</a></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="lefttitle">문화관광예약</td>
	</tr>
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
				<tr>
					<td><a>예약관리</a></td>
				</tr>
				<tr>
					<td class="leftmenu_1"><a href="<c:url value="/rsvtour/regList.do" />">- 리스트</a></td>
				</tr>
				<tr>
					<td><a>코스관리</a></td>
				</tr>
				<tr>
					<td class="leftmenu_1"><a href="<c:url value="/rsvtour/dateList.do" />">- 스케쥴리스트</a></td>
				</tr>
				<tr>
					<td class="leftmenu_1"><a href="<c:url value="/rsvtour/courseList.do" />">- 코스리스트</a></td>
				</tr>
				<tr>
					<td class="leftmenu_1"><a href="<c:url value="/rsvtour/courseAdd.do" />">- 코스등록</a></td>
				</tr>
			</table>
		</td>
	</tr>	
	<tr>
		<td class="lefttitle">정보화교육신청</td>
	</tr>
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0" class="leftmenu">
				<tr>
					<td><a>신청관리</a></td>
				</tr>
				<tr>
					<td class="leftmenu_1"><a href="<c:url value="/rsvedu/regList.do" />">- 리스트</a></td>
				</tr>
				<tr>
					<td><a>교육관리</a></td>
				</tr>
				<tr>
					<td class="leftmenu_1"><a href="<c:url value="/rsvedu/eduList.do" />">- 교육리스트</a></td>
				</tr>
				<tr>
					<td class="leftmenu_1"><a href="<c:url value="/rsvedu/eduAdd.do" />">- 교육등록</a></td>
				</tr>
			</table>
		</td>
	</tr>	
</table>