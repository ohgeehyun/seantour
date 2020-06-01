/**
 * @version 3.2.0.1
 */
package geocni.utils;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class TravelFrontPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	@SuppressWarnings("unused")
	private ServletContext servletContext;
	
	public TravelFrontPaginationRenderer() {
	}
	public void initVariables() {
		firstPageLabel = "<a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"처음페이지\" class=\"page_prevend\"><span>처음</span></a>&nbsp;"; 
        previousPageLabel = "<a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"이전페이지\" class=\"page_prev\"><span>이전</span></a>&nbsp;";
        currentPageLabel = "<strong title=\"현재페이지\">{0}</strong>&nbsp;";
        otherPageLabel = "<a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"{2}페이지\">{2}</a>&nbsp;";
        nextPageLabel = "<a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"다음페이지\" class=\"page_next\"><span>다음</span></a>&nbsp;";
        lastPageLabel = "<a href=\"?pageIdx={1}\" onclick=\"{0}({1}); return false;\" title=\"마지막페이지\" class=\"page_nextend\"><span>마지막</span></a>";
    }

	@Override
	public String renderPagination(PaginationInfo paginationInfo,
			String jsFunction) {
		String pagination = "";
		String rendered = super.renderPagination(paginationInfo, jsFunction);
		pagination = "<div class=\"pagination\">" + rendered + "</div>";
		return pagination;
	}
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
