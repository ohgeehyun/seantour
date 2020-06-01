/**
 * @version 3.2.0.1
 */
package jnit.cms;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class JnitDefaultPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;
	
	public JnitDefaultPaginationRenderer() {
	}
	public void initVariables() {
		firstPageLabel = "<li class=\"first_page\"><a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"처음페이지\">«</a></li>"; 
        previousPageLabel = "<li class=\"prev_page\"><a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"이전페이지\">‹</a></li>";
        currentPageLabel = "<li class=\"active\"><a href=\"?pageIdx={0}\" onclick=\"return false;\" title=\"현재 페이지\">{0}</a></li>";
        otherPageLabel = "<li><a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"{2}페이지\">{2}</a></li>";
        nextPageLabel = "<li class=\"next_page\"><a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"다음페이지\">›</a></li>";
        lastPageLabel = "<li class=\"last_page\"><a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"마지막페이지\">»</a></li>";
    }

	@Override
	public String renderPagination(PaginationInfo paginationInfo,
			String jsFunction) {
		String pagination = "";
		String rendered = super.renderPagination(paginationInfo, jsFunction);
		pagination = "<div class=\"pagination pagination-small\"><ul>" + rendered + "</ul></div>";
		return pagination;
	}
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
