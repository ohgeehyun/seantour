<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="topOrder" value="${order < 10 ? '0' : ''}${order}" />
<c:forEach var="menu" items="${menuTree}" varStatus="st">
	<li class="Inb${topOrder} ${menu.over}"><a href="${menu.link}">${menu.title}</a>
		<c:if test="${menu.childCount != null}">
			<div class="Inbsub${topOrder}">
				<ul>
					<c:forEach var="child" items="${menu.childTree}" varStatus="status">
						<li class="sub${order}_${status.count} ${child.over}">
							<c:if test="${child.isexlink == 0}">
								<a href="<c:url value="${child.link}${!empty child.defaultmenu ? '/' : ''}${child.defaultmenu}"/>" title="${child.title}">${child.title}</a>
							</c:if>
							<c:if test="${child.isexlink == 1}">
								<a href="<c:url value="${child.exlink}"/>" title="${child.title} 링크가 새창으로 열립니다." target="${child.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child.extgt}">${child.title}<c:if test="${child.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a>
							</c:if>
							<c:if test="${child.childCount != null}">
								<ul>
									<c:forEach var="child2" items="${child.childTree}" varStatus="status2">
										<li class="sub${order}_${status.count}_${status2.count} ${child2.over}">
											<c:if test="${child2.isexlink == 0}">
												<a href="<c:url value="${child2.link}${!empty child2.defaultmenu ? '/' : ''}${child2.defaultmenu}"/>" title="${child2.title}">${child2.title}</a>
											</c:if>
											<c:if test="${child2.isexlink == 1}">
												<a href="<c:url value="${child2.exlink}"/>" title="${child2.title} 링크가 새창으로 열립니다." target="${child2.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child2.extgt}">${child2.title}<c:if test="${child2.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a>
											</c:if>
											<c:if test="${child2.childCount != null}">
												<ul>
													<c:forEach var="child3" items="${child2.childTree}" varStatus="status3">
														<li class="sub${order}_${status.count}_${status2.count}_${status3.count} ${child3.over}">
															<c:if test="${child3.isexlink == 0}">
																<a href="<c:url value="${child3.link}${!empty child3.defaultmenu ? '/' : ''}${child3.defaultmenu}"/>" title="${child3.title}">${child3.title}</a>
															</c:if>
															<c:if test="${child3.isexlink == 1}">
																<a href="<c:url value="${child3.exlink}"/>" title="${child3.title} 링크가 새창으로 열립니다." target="${child3.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child3.extgt}">${child3.title}<c:if test="${child3.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a>
															</c:if>
															<c:if test="${child3.childCount != null}">
																<ul>
																	<c:forEach var="child4" items="${child3.childTree}" varStatus="status4">
																		<li class="sub${order}_${status.count}_${status2.count}_${status3.count}_${status4.count} ${child4.over}">
																		<c:if test="${child4.isexlink == 0}">
																			<a href="<c:url value="${child4.link}${!empty child4.defaultmenu ? '/' : ''}${child4.defaultmenu}"/>" title="${child4.title}">${child4.title}</a>
																		</c:if>
																		<c:if test="${child4.isexlink == 1}">
																			<a href="<c:url value="${child4.exlink}"/>" title="${child4.title} 링크가 새창으로 열립니다." target="${child4.extgt == 'self' ? '_self' : '_blank'}" class="exlink" rel="${child4.extgt}">${child4.title}<c:if test="${child4.extgt != 'self'}"><img src="/resources/img/jnit_icon_new.gif" alt="새창"/></c:if></a>
																		</c:if>
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
							</c:if>
						</li>
					</c:forEach>
				</ul>
			</div>
		</c:if>
	</li>
</c:forEach>