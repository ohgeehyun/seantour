<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>

<div id="content">
	<div class="container-fluid">
    	<div class="row-fluid">
        	<div class="span12">
            	<div class="widget-box">
                	<div class="widget-title">
                    	<span class="icon"><i class="icon-th"></i></span>
                        <h3>기본 테이블</h3>
                    </div>
                    <div class="widget-content nopadding">
                    	<table class="table table-bordered table-striped table-hover">                                
                            <tbody>
                                <tr>
                                    <th>메뉴 명</th>
                                    <td><input type="text" /></td>                                        
                                </tr>
                                <tr>
                                    <th>유형</th>
                                    <td><input type="text" /></td>                                        
                                </tr>
                                <tr>
                                    <th>URL</th>
                                    <td><input type="text" /></td>                                        
                                </tr>
                                <tr>
                                    <th>활성화</th>
                                    <td><input type="text" /></td>                                        
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