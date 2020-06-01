/**
 * @version 3.2.0.1
 */
package jnit.cms;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class JnitPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;
	
	public JnitPaginationRenderer() {
	}
	public void initVariables() {
		firstPageLabel = "<span class=\"pagebtn\"><a class=\"first\" href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\""+ servletContext.getContextPath() +"/images/common/btn_first.gif\" alt=\"처음페이지\" /></a></span>"; 
        previousPageLabel = "<span class=\"pagebtn\"><a class=\"prev\" href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\""+ servletContext.getContextPath() +"/images/common/btn_pre.gif\" alt=\"이전페이지\" /></a></span>";
        currentPageLabel = "<strong>{0}</strong>";
        otherPageLabel = "<a class=\"other\" href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>";
        nextPageLabel = "<span class=\"pagebtn\"><a class=\"next\" href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\""+ servletContext.getContextPath() +"/images/common/btn_next.gif\" alt=\"다음페이지\" /></a></span>";
        lastPageLabel = "<span class=\"pagebtn\"><a class=\"last\" href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\""+ servletContext.getContextPath() +"/images/common/btn_end.gif\" alt=\"마지막페이지\" /></a></span>";
	}

	@Override
	public String renderPagination(PaginationInfo paginationInfo,
			String jsFunction) {
		
		return super.renderPagination(paginationInfo, jsFunction);
	}
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
