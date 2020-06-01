/**
 * @version 3.2.0.1
 */
package jnit.login.log;

import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.com.util.DBType;

public class loginlogUtil {
	
	public static Log log = LogFactory.getLog(loginlogUtil.class);
	
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	//ip return
	public static String getIP()throws Exception{		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String ip = request.getRemoteAddr();
		if(ip.equals("")){
			//에러처리
			
		}
		return ip; //ip return 
	}
	
	//insertIP start
	public static boolean loginLog()throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
		JnitloginlogService jnitloginlogService  = (JnitloginlogService) wContext.getBean("jnitloginlogService");
		
		String ip = loginlogUtil.getIP(); // get ip	
		
		if(ip.equals("")){
			//에러처리
			if("true".equals(deDug)) log.debug("error ip(null)= " + ip);
			return false;
		}else if(ip.equals("0:0:0:0:0:0:0:1")){
			//에러처리
			if("true".equals(deDug)) log.debug("not insertIP = "+ip); //local 접속은 로그인만 허용
			return true;
		}
		
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		
		if(NullUtil.nullString(loginVO.getMbrId()).equals("")){
			//에러처리
			if("true".equals(deDug)) log.debug("error id(null) =" +loginVO.getMbrId());
			return false;
		}
		
		try {
			JnitloginlogVO jnitloginlogVO = new JnitloginlogVO();
			jnitloginlogVO.setMbrId(loginVO.getMbrId());
			jnitloginlogVO.setIpAddr(ip);
			jnitloginlogService.insertJnitloginlog(jnitloginlogVO);		//insert IP 추가한다.
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {			
			log.error(e.getMessage());
		}
		return true;
		
	}	
	//End of insertIP
	
	/*
	 * ArrayList listIP(String PageIndex)(로그인 정보를 List로 return한다.)
	 * @param PageIndex - 현재페이지.
	 * @retrun ArrayList - AraayList로 리턴한다.
	 */	
	public static ArrayList listIP(String PageIndex)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);		
		EgovPropertyService propertiesService = (EgovPropertyService) wContext.getBean("propertiesService");
		JnitloginlogService jnitloginlogService  = (JnitloginlogService) wContext.getBean("jnitloginlogService");
		
		JnitloginlogDefaultVO searchVO = new JnitloginlogDefaultVO();		
		
		if(NullUtil.nullString(PageIndex).equals("") || PageIndex == null){
			PageIndex = "1";
		}
		searchVO.setPageIndex(Integer.parseInt(PageIndex));			 
		
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
		
		searchVO.setSearchCondition("2");
		searchVO.setSearchKeyword(loginVO.getMbrId());
		if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
			
		}else{
			searchVO.setFieldConditon("1");
		}
        ArrayList logList = (ArrayList) jnitloginlogService.selectJnitloginlogList(searchVO);  
		
		return logList;
	}
	/*
	 * PaginationInfo pageNavi(String PageIndex)(PaginationInfo로 return한다.)
	 * @param PageIndex - 현재페이지.
	 * @retrun paginationInfo - paginationInfo로 리턴한다.
	 */	
	public static PaginationInfo pageNavi(String PageIndex){		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		JnitloginlogService jnitloginlogService  = (JnitloginlogService) wContext.getBean("jnitloginlogService");
		EgovPropertyService propertiesService = (EgovPropertyService) wContext.getBean("propertiesService");		
		
		JnitloginlogDefaultVO searchVO = new JnitloginlogDefaultVO();
		if(NullUtil.nullString(PageIndex).equals("") || PageIndex == null){
			PageIndex = "1";
		}
		searchVO.setPageIndex(Integer.parseInt(PageIndex));
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
		
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		searchVO.setSearchCondition("2");
		searchVO.setSearchKeyword(loginVO.getMbrId());	
		
		int totCnt = jnitloginlogService.selectJnitloginlogListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);
			
		return paginationInfo;
	}
	
	/*
	 * ArrayList listIPStartNum(String PageIndex)(로그인 정보를 int로 return한다.)
	 * @param PageIndex - 현재페이지.
	 * @retrun 시작번호
	 */	
	public static int listIPStartNum(String PageIndex)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);		
		EgovPropertyService propertiesService = (EgovPropertyService) wContext.getBean("propertiesService");
		JnitloginlogService jnitloginlogService  = (JnitloginlogService) wContext.getBean("jnitloginlogService");
		
		JnitloginlogDefaultVO searchVO = new JnitloginlogDefaultVO();		
		
		if(NullUtil.nullString(PageIndex).equals("") || PageIndex == null){
			PageIndex = "1";
		}
		searchVO.setPageIndex(Integer.parseInt(PageIndex));			 
		
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
		
		searchVO.setSearchCondition("2");
		searchVO.setSearchKeyword(loginVO.getMbrId());
		searchVO.setFieldConditon("1");
        
		int totCnt = jnitloginlogService.selectJnitloginlogListTotCnt(searchVO);		
		int startNum = totCnt - ((paginationInfo.getCurrentPageNo()-1)*paginationInfo.getRecordCountPerPage());
		
		return startNum;
	}
}
