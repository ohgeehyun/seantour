<%--2020년 20월 12일8시 39분 서브템플릿에서 수정되었습니다. 직접 수정하지마세요 --%>
<% String servletPathHanding = request.getServletPath(); %>
<% if(!"".equals(CmsServletPathProperty.getProp(servletPathHanding,"metaTitle"))){%><meta name="title" content="<%= CmsServletPathProperty.getProp(servletPathHanding,"metaTitle") %>" /><% } %>
<% if(!"".equals(CmsServletPathProperty.getProp(servletPathHanding,"metaSubject"))){%><meta name="subject" content="<%= CmsServletPathProperty.getProp(servletPathHanding,"metaSubject") %>" /><% } %>
<% if(!"".equals(CmsServletPathProperty.getProp(servletPathHanding,"metaKeyword"))){%><meta name="keywords" content="<%= CmsServletPathProperty.getProp(servletPathHanding,"metaKeyword") %>" /><% } %>
<% if(!"".equals(CmsServletPathProperty.getProp(servletPathHanding,"metaDescription"))){%><meta name="description" content="<%= CmsServletPathProperty.getProp(servletPathHanding,"metaDescription") %>" /><% } %>
<% if(!"".equals(CmsServletPathProperty.getProp(servletPathHanding,"metaClassification"))){%><meta name="classification" content="<%= CmsServletPathProperty.getProp(servletPathHanding,"metaClassification") %>" /><% } %>
<% if(!"".equals(CmsServletPathProperty.getProp(servletPathHanding,"metaReply"))){%><meta name="reply-to" content="<%= CmsServletPathProperty.getProp(servletPathHanding,"metaReply") %>" /><% } %>
<% if(!"".equals(CmsServletPathProperty.getProp(servletPathHanding,"metaLanguage"))){%><meta name="content-language" content="<%= CmsServletPathProperty.getProp(servletPathHanding,"metaLanguage") %>" /><% } %>
<% if(!"".equals(CmsServletPathProperty.getProp(servletPathHanding,"metaBuild"))){%><meta name="build" content="<%= CmsServletPathProperty.getProp(servletPathHanding,"metaBuild") %>" /><% } %>