/**
 * @version 3.2.0.1
 */
package jnit.scrap;

import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class ScrapUtil {
	
	public static ArrayList scrapList(String pageIndex)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    	
    	JnitscrapService jnitscrapService = (JnitscrapService) wContext.getBean("jnitscrapService");
    	EgovPropertyService propertiesService = (EgovPropertyService) wContext.getBean("propertiesService");
    	JnitscrapDefaultVO searchVO = new JnitscrapDefaultVO();
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
		
    	if(loginVO.getMbrId() == null) {
    		/*model.addAttribute("msg", "E01");*/
    	}
    	   	
    	if(NullUtil.nullString(pageIndex).equals("") || pageIndex == null){
			pageIndex = "1";
		}
		searchVO.setPageIndex(Integer.parseInt(pageIndex));
		
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());		
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setSearchCondition("0");
    	searchVO.setSearchKeyword(loginVO.getMbrId());
        ArrayList scrapList = (ArrayList) jnitscrapService.selectJnitscrapList(searchVO);       
        
		return scrapList;
	}
	
	public static PaginationInfo scrapPageNavi(String pageIndex){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		
		JnitscrapService jnitscrapService = (JnitscrapService) wContext.getBean("jnitscrapService");
		EgovPropertyService propertiesService = (EgovPropertyService) wContext.getBean("propertiesService");
		JnitscrapDefaultVO searchVO = new JnitscrapDefaultVO();
		if(NullUtil.nullString(pageIndex).equals("") || pageIndex == null){
			pageIndex = "1";
		}
		searchVO.setPageIndex(Integer.parseInt(pageIndex));		
		
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());		
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setSearchCondition("0");
    	searchVO.setSearchKeyword(loginVO.getMbrId());
		int totCnt = jnitscrapService.selectJnitscrapListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		return paginationInfo;
	}
	
	public static int scrapStartNum(String pageIndex)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    	
    	JnitscrapService jnitscrapService = (JnitscrapService) wContext.getBean("jnitscrapService");
    	EgovPropertyService propertiesService = (EgovPropertyService) wContext.getBean("propertiesService");
    	JnitscrapDefaultVO searchVO = new JnitscrapDefaultVO();
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
		
    	if(loginVO.getMbrId() == null) {
    		/*model.addAttribute("msg", "E01");*/
    	}
    	   	
    	if(NullUtil.nullString(pageIndex).equals("") || pageIndex == null){
			pageIndex = "1";
		}
		searchVO.setPageIndex(Integer.parseInt(pageIndex));
		
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());		
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setSearchCondition("0");
    	searchVO.setSearchKeyword(loginVO.getMbrId());    	
        int totCnt = jnitscrapService.selectJnitscrapListTotCnt(searchVO);
        int startNum = totCnt - ((paginationInfo.getCurrentPageNo() -1)* paginationInfo.getRecordCountPerPage());        
		return startNum;
	}
}
