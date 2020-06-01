<%
/**
 *@version 3.2.0.1
 **/
%>
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%><%@ page import="java.util.Date" %><%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><c:if test="${!empty msg }">
<script type="text/javascript">
<!--
alert("${msg}");
//-->
</script>
</c:if>
<div class="Jnit_sitemap">
    <c:forEach var="menu" items="${menuTree}" varStatus="status">
        <ul class="sitemap_Dept01">
            <li><a href="<c:url value="${menu.link}"/>">${menu.title}</a>
            <c:if test="${menu.childCount > 0}">
            	<ul class="sitemap_Dept02">
                <c:forEach var="child" items="${menu.childTree}" varStatus="status2">
					<c:if test="${not empty child}">
						<li>
	                    <c:if test="${child.isexlink == 0}">
							<a href="<c:url value="${child.link}${!empty child.defaultmenu ? '/' : ''}${child.defaultmenu}"/>" title="${child.title}">${child.title}</a>
						</c:if>
	                    <c:if test="${child.isexlink == 1}">
							<a href="<c:url value="${child.exlink}"/>" title="${child.title} 링크가 새창으로 열립니다." target="${child.extgt == 'self' ? '_self' : '_blank'}"  rel="${child.extgt}">${child.title}
								<c:if test="${child.extgt != 'self'}">
									<img src="/resources/img/jnit_icon_new.gif" alt="새창" />
								</c:if>
							</a>
						</c:if>
	                    <c:if test="${child.childCount > 0}">
	                        <ul class="sitemap_Dept03">
	                            <c:forEach var="child2" items="${child.childTree}" varStatus="status3">
									<c:if test="${not empty child2}">
	                                <li>
		                                <c:if test="${child2.isexlink == 0}">
											<a href="<c:url value="${child2.link}${!empty child2.defaultmenu ? '/' : ''}${child2.defaultmenu}"/>" title="${child2.title}">${child2.title}</a>
										</c:if>
					                    <c:if test="${child2.isexlink == 1}">
											<a href="<c:url value="${child2.exlink}"/>" title="${child2.title} 링크가 새창으로 열립니다." target="${child2.extgt == 'self' ? '_self' : '_blank'}"  rel="${child2.extgt}">${child2.title}
												<c:if test="${child2.extgt != 'self'}">
													<img src="/resources/img/jnit_icon_new.gif" alt="새창" />
												</c:if>
											</a>
										</c:if>
		                                <c:if test="${child2.childCount > 0}">
		                                    <ul class="sitemap_Dept04">
		                                        <c:forEach var="child3" items="${child2.childTree}" varStatus="status4">
													<c:if test="${not empty child3}">
		                                            <li>
			                                            <c:if test="${child3.isexlink == 0}">
															<a href="<c:url value="${child3.link}${!empty child3.defaultmenu ? '/' : ''}${child3.defaultmenu}"/>" title="${child3.title}">${child3.title}</a>
														</c:if>
									                    <c:if test="${child3.isexlink == 1}">
															<a href="<c:url value="${child3.exlink}"/>" title="${child3.title} 링크가 새창으로 열립니다." target="${child3.extgt == 'self' ? '_self' : '_blank'}"  rel="${child3.extgt}">${child3.title}
																<c:if test="${child3.extgt != 'self'}">
																	<img src="/resources/img/jnit_icon_new.gif" alt="새창" />
																</c:if>
															</a>
														</c:if>
			                                            <c:if test="${child3.childCount > 0}">
			                                                <ul class="sitemap_Dept05">
			                                                    <c:forEach var="child4" items="${child3.childTree}" varStatus="status5">
																	<c:if test="${not empty child4}">
			                                                        <li>
			                                                        <c:if test="${child4.isexlink == 0}">
																		<a href="<c:url value="${child4.link}${!empty child4.defaultmenu ? '/' : ''}${child4.defaultmenu}"/>" title="${child4.title}">${child4.title}</a>
																	</c:if>
												                    <c:if test="${child4.isexlink == 1}">
																		<a href="<c:url value="${child4.exlink}"/>" title="${child4.title} 링크가 새창으로 열립니다." target="${child4.extgt == 'self' ? '_self' : '_blank'}"  rel="${child4.extgt}">${child4.title}
																			<c:if test="${child4.extgt != 'self'}">
																				<img src="/resources/img/jnit_icon_new.gif" alt="새창" />
																			</c:if>
																		</a>
																	</c:if>
			                                                        </li>
																	</c:if>
			                                                    </c:forEach>
			                                                </ul>
			                                            </c:if>
		                                            </li>
													</c:if>
		                                        </c:forEach>
		                                    </ul>
		                                </c:if>
									</li>
									</c:if>
	                            </c:forEach>
	                        </ul>
						</c:if>
						</li>	                    
					</c:if>
				</c:forEach>
				</ul>
			</c:if>
			</li>
			</ul>
	</c:forEach>
</div>