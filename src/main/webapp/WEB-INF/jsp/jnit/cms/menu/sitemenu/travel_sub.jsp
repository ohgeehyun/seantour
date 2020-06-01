<%
/**
 *@version 3.2.0.1
 **/
%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ include file='/_common/header.jsp' %>
<% { %>
		<div id="leftMenu">
		<c:forEach var="menu" items="${menuTree}" varStatus="status">
            <h2>${menu.title} <span></span></h2>
            <c:if test="${menu.childCount > 0}">
              <ul class="leftMenuList">
					<c:forEach var="child" items="${menu.childTree}" varStatus="status2">
                       	<li id="left<fmt:formatNumber pattern="00" value="${status2.index+1}"  />" class="<c:out value="${child.over}" />">
                       		<c:if test="${child.isexlink == 0}"><a href="<c:url value="${child.link}${!empty child.defaultmenu ? '/' : ''}${child.defaultmenu}"/>" title="${child.title}">${child.title}</a></c:if>
                       		<c:if test="${child.isexlink == 1}"><a href="<c:url value="${child.exlink}"/>" title="${child.title} 링크가 새창으로 열립니다." target="${child.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child.extgt}">${child.title}<c:if test="${child.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a></c:if>
	                       	<c:if test="${child.over == 'on' && child.childCount > 0}">
	                       	<div id="leftSub<fmt:formatNumber pattern="00" value="${status2.index+1}"  />" style="display: block;">
								<ul>
									<c:forEach var="child2" items="${child.childTree}" varStatus="status3">
									<li id="leftSubImg<fmt:formatNumber pattern="00" value="${status3.index+1}"  /><fmt:formatNumber pattern="00" value="${status3.index+1}"  />" class="<c:out value="${child2.over}" />">
		                       			<c:if test="${child2.isexlink == 0}"><a href="<c:url value="${child2.link}${!empty child2.defaultmenu ? '/' : ''}${child2.defaultmenu}"/>" title="${child2.title}">${child2.title}</a></c:if>
										<c:if test="${child2.isexlink == 1}"><a href="<c:url value="${child2.exlink}"/>" title="${child2.title} 링크가 새창으로 열립니다." target="${child2.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child2.extgt}">${child2.title}<c:if test="${child2.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a></c:if>
										<c:if test="${child2.over == 'on' && child2.childCount > 0}">
					                       	<div id="leftSubSub<fmt:formatNumber pattern="00" value="${status3.index+1}"  />" style="display: block;">
												<ul>
													<c:forEach var="child3" items="${child2.childTree}" varStatus="status4">
													<li id="leftSubSubImg<fmt:formatNumber pattern="00" value="${status4.index+1}"  /><fmt:formatNumber pattern="00" value="${status4.index+1}"  />" class="<c:out value="${child3.over}" />">
						                       			<c:if test="${child3.isexlink == 0}"><a href="<c:url value="${child3.link}${!empty child3.defaultmenu ? '/' : ''}${child3.defaultmenu}"/>" title="${child3.title}">${child3.title}</a></c:if>
														<c:if test="${child3.isexlink == 1}"><a href="<c:url value="${child3.exlink}"/>" title="${child3.title} 링크가 새창으로 열립니다." target="${child3.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child3.extgt}">${child3.title}<c:if test="${child3.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a></c:if>
														
														<c:if test="${child3.over == 'on' && child3.childCount > 0}">
									                       	<div id="leftSubSubSub<fmt:formatNumber pattern="00" value="${status4.index+1}"  />" style="display: block;">
																<ul>
																	<c:forEach var="child4" items="${child3.childTree}" varStatus="status5">
																	<li id="leftSubSubSubImg<fmt:formatNumber pattern="00" value="${status5.index+1}"  /><fmt:formatNumber pattern="00" value="${status5.index+1}"  />" class="<c:out value="${child4.over}" />">
										                       			<c:if test="${child4.isexlink == 0}"><a href="<c:url value="${child4.link}${!empty child4.defaultmenu ? '/' : ''}${child4.defaultmenu}"/>" title="${child4.title}">${child4.title}</a></c:if>
																		<c:if test="${child4.isexlink == 1}"><a href="<c:url value="${child4.exlink}"/>" title="${child4.title} 링크가 새창으로 열립니다." target="${child3.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child4.extgt}">${child4.title}<c:if test="${child4.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a></c:if>
																		
																		
																		<c:if test="${child4.over == 'on' && child4.childCount > 0}">
																			<div id="leftSubSubSub<fmt:formatNumber pattern="00" value="${status4.index+1}"  />" style="display: block;">
																				<ul>																					
																					<c:forEach var="child5" items="${child4.childTree}" varStatus="status6">
																					<li id="leftSubSubSubImg<fmt:formatNumber pattern="00" value="${status6.index+1}"  /><fmt:formatNumber pattern="00" value="${status6.index+1}"  />" class="<c:out value="${child5.over}" />">
																						<c:if test="${child5.isexlink == 0}"><a href="<c:url value="${child5.link}${!empty child5.defaultmenu ? '/' : ''}${child5.defaultmenu}"/>" title="${child5.title}">${child5.title}</a></c:if>
																						<c:if test="${child5.isexlink == 1}"><a href="<c:url value="${child5.exlink}"/>" title="${child5.title} 링크가 새창으로 열립니다." target="${child3.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child5.extgt}">${child5.title}<c:if test="${child5.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a></c:if>
																					</li>
																					</c:forEach>
																				</ul>
																			</div>
																		</c:if>
																		
																	</li>
																	</c:forEach>
																</ul>
															</div>
														</c:if>
														
													</li>
													</c:forEach>
												</ul>
											</div>
										</c:if>
									</li>
									</c:forEach>
								</ul>
							</div>
							</c:if>
                       	</li>
					</c:forEach>
                </ul>
            </c:if>
			</c:forEach>
        </div>

<c:if test="${!empty param.embedJquery}">
<script type="text/javascript" src="<c:url value="/js/jquery-1.8.2.min.js"/>"></script>
</c:if>
<c:if test="${!empty msg}">
<script type="text/javascript">
<!--
alert("${msg } 빌드를 해주시기 바랍니다.");
//-->
</script>
</c:if>
<script type="text/javascript">
<!--
try {
$(document).ready(function(){
	$('a.exlink').each(function(k, el){
		if(el.rel.indexOf('pop') != -1) {
			var opt = el.rel.replace('pop', '');
			opt = opt.replace('(', '');
			opt = opt.replace(')', '');
			
			$(el).bind('click', function(e){
				e.preventDefault();
				
				opts = opt.split(':');
				var msg = window.open(this.href, this.title, "left="+opts[0]+",top="+opts[1]+",width="+opts[2]+",height="+opts[3]);
			});
		} 
	});
	
	<c:if test='${!empty pageNavTitle}'>	
		//var pageNavTitle = Jnit_replaceAll("${pageNavTitle}","&#60;","<"); 
		//document.title = pageNavTitle; 
	</c:if>
	
	<c:if test='${!empty pageLinkNav}'>
		$("#activePageLinkNav").empty();
		$("#activePageLinkNav").append("${pageLinkNav}");
	</c:if>
});
}catch(e) {
	
}
function Jnit_replaceAll(str,character,replaceChar){
    var word = str;

    while(word.indexOf(character) != -1)
        word = word.replace(character,replaceChar);

    return word;
}
//-->
</script>
<% } %>
