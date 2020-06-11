/**
 * @version 3.2.0.1
 */
package geocni.utils;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class TravelBoardPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{
	
	public TravelBoardPaginationRenderer() {
	}
	public void initVariables() {

		firstPageLabel = "<li class=\"first\"><a href=\"?pageIdx={1}\" onclick=\\\"{0}({1}); return false;\\\" title=\\\"처음페이지\\\">처음</a></li>";
        previousPageLabel = "<li class=\"prev\"><a href=\"?pageIdx={1}\\\" onclick=\\\"{0}({1}); return false;\\\" title=\\\"이전페이지\\\">이전</a></li>";
        currentPageLabel = "<li><a href=\"#none\">{0}</a></li>";
        otherPageLabel = "<li><a href=\"?pageIdx={1}\\\" onclick=\\\"{0}({1}); return false;\\\" title=\\\"{2}페이지\\\">{2}</a></li>";
        nextPageLabel = "<li class=\"next\"><a href=\"?pageIdx={1}\\\" onclick=\\\"{0}({1}); return false;\\\" title=\\\"다음페이지\\\">다음</a></li>";
        lastPageLabel = "<li class=\"last\"><a href=\"?pageIdx={1}\\\" onclick=\\\"{0}({1}); return false;\\\" title=\\\"마지막페이지\\\">마지막</a></li>";
	
	}

	@Override
	public String renderPagination(PaginationInfo paginationInfo,
			String jsFunction) {
		String pagination = "";
		String rendered = super.renderPagination(paginationInfo, jsFunction);
		pagination = "<div class=\"pagination\">" + rendered + "</div>";
		return pagination;
	}
	
	public void setServletContext(ServletContext servletContexts) {
		@SuppressWarnings("unused")
		ServletContext servletContext;
		servletContext = servletContexts;
		initVariables();
	}

}
