<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/jnit/_common/header.jsp" %>
<%@ page import = "jnit.cms.*, jnit.cms.mbr.*, jnit.cms.handler.*, egovframework.com.cmm.service.EgovProperties"%>
<%
	AdminUtil.setGnbList();
	data = (JSONObject) new JSONParser().parse(AdminUtil.CmsMenuTree(""));
	dataMap = new TreeMap<String, JSONObject>();
	treeMap = new TreeMap<String, JSONObject>();
	
	dataMap = AdminUtil.jobj2map(dataMap, data);
	treeMap = AdminUtil.map2treemap(dataMap, treeMap);
	
%>
<style>
#s2id_typeId {width: 20%; text-align: center;}
#s2id_levelList {width: 20%; text-align: center;}
#s2id_powerList {width: 100%; text-align: center;}
</style>
<script>
	$(document).ready(function(){
		
		
		$("[id*='allCheck']").click(function(e){
			e.preventDefault();
			var value = $(this).val();
			var confirm = $("button[value='"+value+"']").parent().children().children().find("span").attr('class');
			
			if(confirm != 'checked'){
				$("button[value='"+value+"']").parent().children().children().find("span").addClass("checked");
				$("button[value='"+value+"']").parent().children().children().find("span").children().attr('checked',true);
			}else{
				$("button[value='"+value+"']").parent().children().children().find("span").removeClass();
				$("button[value='"+value+"']").parent().children().children().find("span").children().attr('checked',false);
			}
		});
		
		//권한 리스트에 추가
		<%--
		$("[id*='depthButton']").click(function(e){
			e.preventDefault();
			
			var typeId = $.trim($("#typeId").val());
			var powerVal = $(this).val();
			var powerNm = $(this).parent().find("span").text();
			var nmSplit = powerNm.split(" ");
			var powerListText = $("#powerList").text();
			
			if(typeId != ''){
				if(nmSplit.length > 2){
					for(var i=0; i<nmSplit.length; i++){
						if(i==1){
							name = nmSplit[i] + " : ";
						}else{
							name += "+" + nmSplit[i] + " ";
						}
					}
				}else{
					name = nmSplit[1].replace("추가", "");
				}
				
				var powerListSize = $("#powerList option[value='"+powerVal+"']").length;
				
				if(powerListSize == 0){
					$("#powerList").append(
						"<option value="+powerVal+" selected='selected'>"+name+"</option>"
					);
					$("#area").append(powerNm);
					$("#powerList").select2();
				}else{
					alert("중복되는 메뉴입니다.");
					$("#typeId").focus();
					return false;
				}
			}else{
				alert("회원유형을 먼저 선택해주세요.");
				return false;
			}
		});
		--%>
	});
	var request_uri = '<c:out value="${requestScope['javax.servlet.forward.request_uri']}" />';
	var context_path = '<c:out value="${requestScope['javax.servlet.forward.context_path']}" />';
	request_uri = request_uri.replace(context_path, '');
	var menuId = '<c:out value="${menuId}" />';
	
	function Jnit_menu_question(num){
		var baseId = "JnitMenuQuestion"+num;
		var baseObject = $("#"+baseId);
		var displayState = baseObject.css("display");
		
		if(displayState == "none"){
			baseObject.show();
		}else{
			baseObject.hide();
		}
	}
</script>
<div id="content">
	<%@ include file="/WEB-INF/jsp/jnit/_common/content_header.jsp" %>
	<div class="content_view container-fluid">
		<%-- Contents Start --%>
        	<div class="row-fluid">
            	<div class="span12">
                	<div class="widget-box">
                	<form id="configForm" name="configForm" method="post" action="<c:url value='/cms/sub2/020101save.do'/>">
                    	<div class="widget-title">
                        	<span class="icon"><i class="icon-cog"></i></span>
                            <button type="submit" class="btn btn-small" id="regist"><i class="icon icon-ok"></i> 저장</button>
                        </div>
                        <div class="widget-content nopadding">
								<table class="table table-bordered table-striped th_left" summary="접근레벨관리" id="slide" style="margin-top: 10px;">
									<tbody>
                                       <tr>
                                       	<th style="width: 50%; text-align: center;" colspan="3">전체 메뉴</th>
                                       </tr>
                                       <tr>
                                       	<td>
                                       		<ul>
												<c:forEach items="${gnb}" var="d1" varStatus="status">
													<%-- <li><i class="icon icon-${d1.value.icon}"></i><span class="txt"> ${d1.value.name}</span><button id="depthButton0" value="${d1.key}" class="btn btn-mini" style="margin-left: 5px;">추가</button> --%>
													<li style="float: left; margin-left: 20px; margin-top: 10px;"><span style="font-size: 16px; font-weight:bold;"><i class="icon-remove-circle"></i> ${d1.value.name}</span>
													<input type="hidden" name="${d1.key}" value="${d1.value.codeId}">
													
													<button id="allCheck" name="allCheck" value="${d1.key}" class="btn btn-mini">전체선택</button>
													<c:choose>
														<c:when test="${status.count == 1}">
															<%request.setAttribute("treeMap", treeMap.get("m01000000"));%>
														</c:when>
														<c:when test="${status.count == 2}">
															<%request.setAttribute("treeMap", treeMap.get("m02000000"));%>
														</c:when>
														<c:when test="${status.count == 3}">
															<%request.setAttribute("treeMap", treeMap.get("m03000000"));%>
														</c:when>
														<c:when test="${status.count == 4}">
															<%request.setAttribute("treeMap", treeMap.get("m04000000"));%>
														</c:when>
														<c:when test="${status.count == 5}">
															<%request.setAttribute("treeMap", treeMap.get("m05000000"));%>
														</c:when>
														<c:when test="${status.count == 6}">
															<%request.setAttribute("treeMap", treeMap.get("m06000000"));%>
														</c:when>
														<c:when test="${status.count == 7}">
															<%request.setAttribute("treeMap", treeMap.get("m07000000"));%>
														</c:when>
														<c:when test="${status.count == 8}">
															<%request.setAttribute("treeMap", treeMap.get("m08000000"));%>
														</c:when>
														<c:when test="${status.count == 9}">
															<%request.setAttribute("treeMap", treeMap.get("m09000000"));%>
														</c:when>
														<c:when test="${status.count == 10}">
															<%request.setAttribute("treeMap", treeMap.get("m10000000"));%>
														</c:when>
													</c:choose>
													<ul>
														<c:forEach var="dp1" items="${treeMap.child}" varStatus="status">
										            		<%--<li class="<c:out value="${fn:substring(menuId,0,5) == fn:substring(dp1.key,0,5) ? 'active open' : ''}" />"><i class="icon icon-${dp1.value.icon}"></i><span><checkbox id="power"> ${dp1.value.name}</checkbox></span><button id="depthButton1" class="btn btn-mini" value="${dp1.key}" style="margin-left: 5px;">추가</button>--%>
										            		<c:if test="${not empty dp1.value.child}">
										            			<li style="margin-left: 10px;"><span style="font-weight:bold;"><i class="icon-remove-circle"></i> ${dp1.value.name}</span>
										            			<input type="hidden" name="${dp1.key}" value="${dp1.value.codeId}">
										            		</c:if>
										            		<c:if test="${empty dp1.value.child}">
										            			<li style="margin-left: 10px;">
										            				<input type="checkbox" id="powerList" name="powerList" value="${dp1.key}" /> <i class="icon icon-${dp1.value.icon}"></i> ${dp1.value.name}
										            				<input type="hidden" name="${dp1.key}" value="${dp1.value.codeId}">
										            		</c:if>
											            		<c:if test="${not empty dp1.value.child}">
											            		<ul class="depth2 off" data-menu-id="${dp1.key}">
											            			<c:forEach var="dp2" items="${dp1.value.child}">
											           				<%-- <li class="<c:out value="${fn:substring(menuId,0,7) == fn:substring(dp2.key,0,7) ? 'active open' : ''}" />"><i class="icon icon-${dp2.value.icon}"></i><span> ${dp2.value.name}</span><button id="depthButton2" class="btn btn-mini" value="${dp2.key}">추가</button> --%>
											           				<c:if test="${not empty dp2.value.child}">
										           						<li style="margin-left: 10px;"><span style="font-weight:bold;"><i class="icon-remove-circle"></i> ${dp2.value.name}</span>
										           						<input type="hidden" name="${dp2.key}" value="${dp2.value.codeId}">
										           					</c:if>
										           					<c:if test="${empty dp2.value.child}">
										           						<li style="margin-left: 10px;">
										           							<input type="checkbox" id="powerList" name="powerList" value="${dp2.key}"/><i class="icon icon-${dp2.value.icon}"></i> ${dp2.value.name}
										           							<input type="hidden" name="${dp2.key}" value="${dp2.value.codeId}">
										           					</c:if>
											           					<c:if test="${not empty dp2.value.child}">
												           						<ul class="depth3 off" data-menu-id="${dp2.key}">
													           						<c:forEach var="dp3" items="${dp2.value.child}">
														           						<%-- <li><span> ${dp3.value.name}</span><button id="depthButton3" class="btn btn-mini" value="${dp3.key}" style="margin-left: 5px;">추가</button></li> --%>
														           						<li style="margin-left: 10px;">
														           							<input type="checkbox" id="powerList" name="powerList" value="${dp3.key}"/><i class=""></i> ${dp3.value.name}
														           							<input type="hidden" name="${dp3.key}" value="${dp3.value.codeId}">
														           						</li>
													           						</c:forEach>
												           						</ul>           					
											           					</c:if>
											           				</li>
											            			</c:forEach>
											            		</ul>
											            		</c:if>
											            	</li>
											           	</c:forEach>
										           	</ul>
										        </li>
												</c:forEach>
											</ul>
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
