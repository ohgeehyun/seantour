/**
 * @version 3.2.0.1
 */
package jnit.cms;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class Jnit2PaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;
	
	public Jnit2PaginationRenderer() {
	}
	public void initVariables() {
		firstPageLabel = "<a class=\"first pagebtn\" href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\""+ servletContext.getContextPath() +"/images/common/btn_first.gif\" alt=\"처음페이지\" /></a>"; 
        previousPageLabel = "<a class=\"prev pagebtn\" href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\""+ servletContext.getContextPath() +"/images/common/btn_pre.gif\" alt=\"이전페이지\" /></a>";
        currentPageLabel = "<span class=\"pagebtn\"><a data-page=\"{0}\" class=\"on\" href=\"#\" onclick=\"return false;\">{0}</a></span>";
        otherPageLabel = "<span class=\"pagebtn\"><a data-page=\"{1}\" class=\"other\" href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a></span>";
        nextPageLabel = "<a class=\"next pagebtn\" href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\""+ servletContext.getContextPath() +"/images/common/btn_next.gif\" alt=\"다음페이지\" /></a>";
        lastPageLabel = "<a class=\"last pagebtn\" href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\""+ servletContext.getContextPath() +"/images/common/btn_end.gif\" alt=\"마지막페이지\" /></a>";
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
