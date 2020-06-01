<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<script type="text/javascript">
<!--
$(document).ready(function(){
	var smsMaxCount = ("${smsProp['smsMaxCount']}" == null ? " " : "${smsProp['smsMaxCount']}");
	$("#smsMaxCount").val(smsMaxCount);
});
//-->
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
        	<div class="row-fluid">
            	<div class="span12">
                	<div class="widget-box">
                	<form id="configForm" name="configForm" method="post" action="<c:url value='/cms/config/smsSave.do'/>">
                    	<div class="widget-title">
                        	<span class="icon"><i class="icon-cog"></i></span>
                            <button type="submit" class="btn btn-small"><i class="icon icon-ok"></i> 저장</button>
                        </div>
                        <div class="widget-content nopadding">
						    <table class="table table-bordered table-striped th_left" summary="보안설정">
						        <tbody>
						        	<%--
						            <tr>
						            	<th colspan="2"><strong>*</strong> 연동설정</th>
						                <td>
							                <label><input type="radio" id="sms0" name="sms" value="no" <c:out value="${smsProp['sms'] == 'no' ? 'checked' : '' }"/>/> 사용안함</label>
							                <label><input type="radio" id="sms1" name="sms" value="lts" <c:out value="${smsProp['sms'] == 'lts' ? 'checked' : '' }"/>/> 사용함(LTSKorea모듈)</label>
							                <label><input type="radio" id="sms2" name="sms" value="egov" <c:out value="${smsProp['sms'] == 'egov' ? 'checked' : '' }"/>/> 사용함(정부통합전산모듈)</label>
						                </td>
						            </tr>
						            --%>
						            <tr>
						            	<th rowspan="33" style="width:90px;">SMS모듈설정</th>
						            	<th colspan="2" style="text-align: center;"><lable for="">기본 설정</lable></th>
						            	<%--
						                <th> <lable for="smsId">ID</lable></th>
						                <td>
							                <input type="text" id="smsId" name="smsId" value="<c:out value="${smsProp['smsId'] != '' ? smsProp['smsId'] : '' }" />" />
						                </td>
						                --%>
						            </tr>
						            <%--
						            <tr>
						                <th><lable for="smspw">패스워드</lable></th>
						                <td>
							                <input type="text" id="smsPw" name="smsPw" value="<c:out value="${smsProp['smsPw'] != '' ? smsProp['smsPw'] : '' }" />" />
						                </td>
						            </tr>
						            --%>
						            <tr>
						            	<th style="width: 230px;"><lable for="smsType">SMS 유형</lable></th>
						            	<td>
						            		<label><input type="radio" id="smsType1" name="smsType" value="no" <c:out value="${smsProp['smsType'] == 'no' || empty smsProp['smsType'] ? 'checked' : '' }"/> /> 사용안함</label>
							                <label><input type="radio" id="smsType2" name="smsType" value="ltskorea" <c:out value="${smsProp['smsType'] == 'ltskorea' ? 'checked' : '' }"/> /> 사용함(LTSKorea모듈)</label>
							                <label><input type="radio" id="smsType3" name="smsType" value="mgov" <c:out value="${smsProp['smsType'] == 'mgov' ? 'checked' : '' }"/> /> 사용함(정부통합전산모듈)</label>
										</td>
						            </tr>
						            <tr>
						            	<th><lable for="loginMemberUse">로그인 회원 사용여부</lable></th>
						            	<td>
						            		<label><input type="radio" id="loginMemberUse1" name="loginMemberUse" value="N" <c:out value="${smsProp['loginMemberUse'] == 'N' || empty smsProp['loginMemberUse'] ? 'checked' : '' }"/> /> 사용안함</label>
							                <label><input type="radio" id="loginMemberUse2" name="loginMemberUse" value="Y" <c:out value="${smsProp['loginMemberUse'] == 'Y' ? 'checked' : '' }"/> /> 사용함</label>
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="mbrCheck">회원조회 기능 사용 여부</lable></th>
						            	<td>
						            		<label><input type="radio" id="mbrCheck1" name="mbrCheck" value="N" <c:out value="${smsProp['mbrCheck'] == 'N' || empty smsProp['mbrCheck'] ? 'checked' : '' }"/> /> 사용안함</label>
							                <label><input type="radio" id="mbrCheck2" name="mbrCheck" value="Y" <c:out value="${smsProp['mbrCheck'] == 'Y' ? 'checked' : '' }"/> /> 사용함</label>
										</td>
						            </tr>
						            <%--
						            <tr>
						            	<th><lable for="memberTypeUse">회원유형 사용여부</lable></th>
						            	<td>
						            		<label><input type="radio" id="memberTypeUse1" name="memberTypeUse" value="N" <c:out value="${smsProp['memberTypeUse'] == 'N' ? 'checked' : '' }"/> /> 사용안함</label>
							                <label><input type="radio" id="memberTypeUse2" name="memberTypeUse" value="Y" <c:out value="${smsProp['memberTypeUse'] == 'Y' ? 'checked' : '' }"/> /> 사용함</label>
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="memberType">회원유형</lable></th>
						            	<td>
						            		<textarea id="memberType" name="memberType" style="width: 430px; height: 90px;"><c:out value="${smsProp['memberType'] != '' ? smsProp['memberType'] : '' }" /></textarea>
						            	</td>
						            </tr>
						            --%>
						            <tr>
						            	<th><lable for="smsMaxCount">SMS 최대 분할 값</lable></th>
						            	<td>
						            		<select id="smsMaxCount" name="smsMaxCount" style="width: 20%;">
						            			<option value=" ">선택해주세요.</option>
						            			<c:forEach var="result" begin="1" end="5" step="1" varStatus="status">
						            				<option value="${status.count}">${status.count}</option>
						            			</c:forEach>
						            		</select>
						            	</td>
						            </tr>
						            <tr>
						            	<th colspan="2" style="text-align: center;"><lable for="">보내는 사람의 기본으로 지정한 번호</lable></th>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel0">보내는 사람의 기본으로 지정한 번호0</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel0" name="defaultTel0" value="<c:out value="${smsProp['defaultTel0'] != '' ? smsProp['defaultTel0'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel1">보내는 사람의 기본으로 지정한 번호1</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel1" name="defaultTel1" value="<c:out value="${smsProp['defaultTel1'] != '' ? smsProp['defaultTel1'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel2">보내는 사람의 기본으로 지정한 번호2</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel2" name="defaultTel2" value="<c:out value="${smsProp['defaultTel2'] != '' ? smsProp['defaultTel2'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel3">보내는 사람의 기본으로 지정한 번호3</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel3" name="defaultTel3" value="<c:out value="${smsProp['defaultTel3'] != '' ? smsProp['defaultTel3'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel4">보내는 사람의 기본으로 지정한 번호4</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel4" name="defaultTel4" value="<c:out value="${smsProp['defaultTel4'] != '' ? smsProp['defaultTel4'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel5">보내는 사람의 기본으로 지정한 번호5</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel5" name="defaultTel5" value="<c:out value="${smsProp['defaultTel5'] != '' ? smsProp['defaultTel5'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel6">보내는 사람의 기본으로 지정한 번호6</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel6" name="defaultTel6" value="<c:out value="${smsProp['defaultTel6'] != '' ? smsProp['defaultTel6'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel7">보내는 사람의 기본으로 지정한 번호7</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel7" name="defaultTel7" value="<c:out value="${smsProp['defaultTel7'] != '' ? smsProp['defaultTel7'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel8">보내는 사람의 기본으로 지정한 번호8</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel8" name="defaultTel8" value="<c:out value="${smsProp['defaultTel8'] != '' ? smsProp['defaultTel8'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultTel9">보내는 사람의 기본으로 지정한 번호9</lable></th>
						            	<td>
						            		<input type="text" id="defaultTel9" name="defaultTel9" value="<c:out value="${smsProp['defaultTel9'] != '' ? smsProp['defaultTel9'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th colspan="2" style="text-align: center;"><lable for="">보내는 사람의 기본으로 지정한 이름</lable></th>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm0">보내는 사람의 기본으로 지정한 이름0</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm0" name="defaultNm0" value="<c:out value="${smsProp['defaultNm0'] != '' ? smsProp['defaultNm0'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm1">보내는 사람의 기본으로 지정한 이름1</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm1" name="defaultNm1" value="<c:out value="${smsProp['defaultNm1'] != '' ? smsProp['defaultNm1'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm2">보내는 사람의 기본으로 지정한 이름2</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm2" name="defaultNm2" value="<c:out value="${smsProp['defaultNm2'] != '' ? smsProp['defaultNm2'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm3">보내는 사람의 기본으로 지정한 이름3</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm3" name="defaultNm3" value="<c:out value="${smsProp['defaultNm3'] != '' ? smsProp['defaultNm3'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm4">보내는 사람의 기본으로 지정한 이름4</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm4" name="defaultNm4" value="<c:out value="${smsProp['defaultNm4'] != '' ? smsProp['defaultNm4'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm5">보내는 사람의 기본으로 지정한 이름5</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm5" name="defaultNm5" value="<c:out value="${smsProp['defaultNm5'] != '' ? smsProp['defaultNm5'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm6">보내는 사람의 기본으로 지정한 이름6</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm6" name="defaultNm6" value="<c:out value="${smsProp['defaultNm6'] != '' ? smsProp['defaultNm6'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm7">보내는 사람의 기본으로 지정한 이름7</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm7" name="defaultNm7" value="<c:out value="${smsProp['defaultNm7'] != '' ? smsProp['defaultNm7'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm8">보내는 사람의 기본으로 지정한 이름8</lable></th>
						            	<td>
						            		<input type="text" id=""defaultNm8 name="defaultNm8" value="<c:out value="${smsProp['defaultNm8'] != '' ? smsProp['defaultNm8'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultNm9">보내는 사람의 기본으로 지정한 이름9</lable></th>
						            	<td>
						            		<input type="text" id="defaultNm9" name="defaultNm9" value="<c:out value="${smsProp['defaultNm9'] != '' ? smsProp['defaultNm9'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th colspan="2" style="text-align: center;"><lable for="">받는 사람의 기본으로 지정한 이름</lable></th>
						            </tr>
						            <tr>
						            	<th><lable for="defaultFromNm0">받는 사람의 기본으로 지정한 이름0</lable></th>
						            	<td>
						            		<input type="text" id="defaultFromNm0" name="defaultFromNm0" value="<c:out value="${smsProp['defaultFromNm0'] != '' ? smsProp['defaultFromNm0'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultFromNm1">받는 사람의 기본으로 지정한 이름1</lable></th>
						            	<td>
						            		<input type="text" id="defaultFromNm1" name="defaultFromNm1" value="<c:out value="${smsProp['defaultFromNm1'] != '' ? smsProp['defaultFromNm1'] : '' }" />" />
						            	</td>
						            </tr>
						            <tr>
						            	<th><lable for="defaultFromNm2">받는 사람의 기본으로 지정한 이름2</lable></th>
						            	<td>
						            		<input type="text" id="defaultFromNm2" name="defaultFromNm2" value="<c:out value="${smsProp['defaultFromNm2'] != '' ? smsProp['defaultFromNm2'] : '' }" />" />
						            	</td>
						            </tr>
						        </tbody>
						    </table>
                        </div>
                    </form>
                    </div>
                </div>
            </div>
		<%-- Contents End --%>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>