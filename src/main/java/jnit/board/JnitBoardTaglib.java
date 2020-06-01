/**
 * @version 3.2.0.1
 */
package jnit.board;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.InternalResourceViewResolver;


public class JnitBoardTaglib extends SimpleTagSupport  {

	private Log log = LogFactory.getLog(getClass());
	
	private WebApplicationContext _applicationContext; 
	private String boardId;
	private String customCss;
	private String customJs;

    @Override
    public void doTag() throws JspException, IOException {
    	
    	PageContext pageContext = (PageContext)getJspContext();
    	HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
    	WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
    	
        JspWriter out = getJspContext().getOut();
        JspFragment body = getJspBody();
        ModelMap model = new ModelMap();
        ModelAndView mv;;
        try {
        	//mv = JnitboardController.board(boardId, request, model);
        	InternalResourceViewResolver jspViewResolver = new InternalResourceViewResolver();
            jspViewResolver.setPrefix("/WEB-INF/views/");
            jspViewResolver.setSuffix(".jsp");
           // jspViewResolver.setViewClass(mv.getView().getClass());
        	//log.debug(mv.getView());
        } catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
        out.print(getBoardId());
    }
    
    public String getBoardId() {
		return boardId;
	}
	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}
	public String getCustomCss() {
		return customCss;
	}
	public void setCustomCss(String customCss) {
		this.customCss = customCss;
	}
	public String getCustomJs() {
		return customJs;
	}
	public void setCustomJs(String customJs) {
		this.customJs = customJs;
	}

}

