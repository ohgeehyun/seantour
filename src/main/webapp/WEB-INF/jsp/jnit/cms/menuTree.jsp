<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<div id="content">
    	<label class="control-label" style="display:none;">관리자 선택</label>
        <div class="controls">
            <select>
            	<option>---관리자선택---</option>
                <option>최고 관리자</option>
                <option>직원 관리자</option>
                <option>사이트 관리자</option>
                <option>개발자 그룹</option>
                <option>유지보수팀</option>
                <option>통합예약 관리자</option>
                <option>정보화교육 관리자</option>
            </select>
        </div>
    	<div class="container-fluid">
        	<div class="row-fluid">
            	<div class="span12">
                	<div class="widget-box">
                    	<div class="widget-title">
                    			
                        	<span class="icon"><i class="icon-th"></i></span>
                            <h3>메뉴 노출 선택</h3>
                        </div>
                        <div class="widget-content nopadding">
                       	<table class="table table-bordered table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>트리코드</th>
                                        <th>트리명</th>
                                        <th>활성화</th>
                                        <th>선택</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>T001000000</td>
                                        <td>환경 설정</td>
                                        <td>노출</td>
                                        <td><input type="checkbox" name="radios"></td>
                                    </tr>
                                    <tr>
                                        <td>T001001000</td>
                                        <td>기본 설정</td>
                                        <td>노출</td>
                                        <td><input type="checkbox" name="radios"></td>
                                    </tr>
                                    <tr>
                                        <td>T001002000</td>
                                        <td>보안설정</td>
                                        <td>노출</td>
                                        <td><input type="checkbox" name="radios"></td>
                                    </tr>
                                    <tr>
                                        <td>T002000000</td>
                                        <td>콘텐츠관리자</td>
                                        <td>노출</td>
                                        <td><input type="checkbox" name="radios"></td>
                                    </tr>
                                    <tr>
                                        <td>T002001000</td>
                                        <td>템플릿관리</td>
                                        <td>노출</td>
                                        <td><input type="checkbox" name="radios"></td>
                                    </tr>
                                    <tr>
                                        <td>T002001001</td>
                                        <td>메인템플릿</td>
                                        <td>숨김</td>
                                       <td><input type="checkbox" name="radios"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


<%@ include file="/WEB-INF/jsp/jnit/_common/footer.jsp" %>