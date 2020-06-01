/**
 * @version 3.2.0.1
 */
package jnit.visit.log;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.property.EgovPropertyService;
import jnit.cms.handler.CmsProperty;
import jnit.login.log.JnitloginlogService;
import jnit.visit.count.JnitvisitcountService;


/**
 * @Class Name : JnitvisitlogController.java
 * @Description : Jnitvisitlog Controller class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitvisitlogVO.class)
public class JnitvisitlogController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitvisitlogService")
    private JnitvisitlogService jnitvisitlogService;
    
    @Resource(name = "jnitvisitcountService")
    private JnitvisitcountService jnitvisitcountService;
    
    @Resource(name = "jnitloginlogService")
    private JnitloginlogService jnitloginlogService;
    
    @Resource(name = "cmsProperty")
    private CmsProperty cmsProperty;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    public static final String SEPERATOR = File.separator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    
    /**
	 * 1.loginlog에서 클릭한 값의 바로 위의 값을 클릭하여 
	 * 
	 * 
	 * 
	 */
    
    @RequestMapping(value="/visit/getActionLogin.do")
    public String loginActionJnitvisitlogList( 
    		
    		@ModelAttribute("searchVO")  JnitvisitlogDefaultVO visitlogDefalitVO, 
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	/*
    	Calendar cal = Calendar.getInstance();
    	String time = NullUtil.nullString(request.getParameter("when"));
    	String action = NullUtil.nullString(request.getParameter("action"));
    	
    	if(time.equals("")){
    		model.addAttribute("alert","잘못된 접근입니다.");
    		return "/jnit/util/alertBack";
    	}
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	if(NullUtil.nullString(loginVO.getMbrId()).equals("")){
    		model.addAttribute("alert","잘못된 접근입니다.");
    		return "/jnit/util/alertBack";
    	}
    	if(action.equals("")){
    		action = "view";
    	}
    	
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	
        
        JnitloginlogDefaultVO searchVO = new JnitloginlogDefaultVO();		
		
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		//searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		//searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setPageIndex(0);			 
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(100000);
		
		searchVO.setSearchCondition("3");
		searchVO.setSearchKeyword(loginVO.getMbrId());
		searchVO.setSearchDate(sdf.parse(time));
        List logList = jnitloginlogService.selectJnitloginlogList(searchVO);  
        String created = "";
        if(logList.size() == 0){
        	created = sdf.format(cal.getTime());
        	if("true".equals(deDug)) log.debug("last value");
        }else{
        	Iterator i = (Iterator)logList.iterator();	
      		while(i.hasNext()){
      			EgovMap log = (EgovMap)i.next();
      			created = String.valueOf(log.get("created"));
      		    
      		}
      		if("true".equals(deDug)) log.debug("created : "+created);
        }
        JnitvisitlogVO jnitvisitlogVO = new JnitvisitlogVO();
        
        
        //JnitvisitlogDefaultVO  = new JnitvisitlogDefaultVO();
        
        paginationInfo.setCurrentPageNo(visitlogDefalitVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(15);
		paginationInfo.setPageSize(visitlogDefalitVO.getPageSize());
		
		visitlogDefalitVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		visitlogDefalitVO.setLastIndex(paginationInfo.getLastRecordIndex());
		visitlogDefalitVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        
        visitlogDefalitVO.setSearchCondition("4");
        visitlogDefalitVO.setSearchKeyword(time);
        visitlogDefalitVO.setSearchKeyword2(created);
        visitlogDefalitVO.setSearchKeyword3(loginVO.getMbrId());
        visitlogDefalitVO.setSearchKeyword4(action);
        
		
        
		model.addAttribute("when",time);
		model.addAttribute("action",action);
		
    	List sitelog = jnitvisitlogService.selectJnitvisitlogList(visitlogDefalitVO);
    	model.addAttribute("resultList",sitelog);
    	
    	int totCnt = jnitvisitlogService.selectJnitvisitlogListTotCnt(visitlogDefalitVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        */
    	return "/jnit/visit/search_action";
    } 
    
    
    /**
	 * Insert Data
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitlogDefaultVO
	 * @return "/jnit/tpl-temp/jnitvisitlog/JnitvisitlogList"
	 * @exception Exception
	 */
    @RequestMapping(value="/visit/logJcms.do")
    public String insertLogDataFromJCMS(ModelMap model)
            throws Exception {
    	/*
    	CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
    	HttpServletRequest request = cmsClientProperty.request;
    	//HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	//HttpServletRequest request = (cmsProperty.multipartRequest.get(oriRequest.getRequestedSessionId()) != null ? cmsProperty.multipartRequest.get(oriRequest.getRequestedSessionId()) : oriRequest);
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	Calendar cal = Calendar.getInstance();
    	String regexesPath = cmsClientProperty.docRoot + SEPERATOR + "WEB-INF"+SEPERATOR+"config"+SEPERATOR+"jnit"+SEPERATOR+"regexes.yaml";
    	File regexesFile = new File(regexesPath);
    	InputStream regexesIs = new java.io.FileInputStream(regexesFile);
    	Parser uaParser = new Parser(regexesIs);
    	String userAgent = NullUtil.nullString(request.getHeader("user-agent"));
    	Client c = uaParser.parse(userAgent);
    	String site = NullUtil.nullString(request.getServerName());
    	String ipaddr = NullUtil.nullString(request.getRemoteAddr());
    	String referer = NullUtil.nullString(request.getHeader("referer"));
    	String userOs = c.os.family + " " + NullUtil.nullString(c.os.major);
    	userOs = userOs.trim();
    	String browser = c.userAgent.family + " " + c.userAgent.major;
    	//로그인된 사용자이면 MBR_ID를 남기고 그렇지 않는 경우 IP Address를 남긴다.
    	String user = loginVO.getMbrId() == null ? ipaddr : loginVO.getMbrId(); 
    	   	
    	String page = request.getRequestURL().toString();
    	//String page = NullUtil.nullString(request.getParameter("page"));

    	JnitvisitlogVO jnitvisitlogVO = new JnitvisitlogVO();
    	jnitvisitlogVO.setWhenDatetime(cal.getTime());
    	jnitvisitlogVO.setWherDate("true");
    	jnitvisitlogVO.setSite(site);
    	jnitvisitlogVO.setIpaddr(ipaddr);
    	jnitvisitlogVO.setReferer(referer);
    	jnitvisitlogVO.setUserOs(userOs);
    	jnitvisitlogVO.setBrowser(browser);
    	jnitvisitlogVO.setUserAgent(userAgent);
    	jnitvisitlogVO.setUser(user);
    	jnitvisitlogVO.setPage(page);

    	JnitvisitcountVO jnitvisitcountVO = new JnitvisitcountVO();
    	jnitvisitcountVO.setSite(site);
    	jnitvisitcountVO.setVdate(cal.getTime());
    	jnitvisitcountVO.setVhour(cal.get(Calendar.HOUR_OF_DAY));
    	jnitvisitcountVO.setUserOs(userOs);
    	jnitvisitcountVO.setBrowser(browser);
    	
    	String logSses = userAgent + "|" + ipaddr + "|" + page;
    	
    	try{
    		if( ! logSses.equals(request.getSession().getAttribute("logSess")) ){
    			jnitvisitlogService.insertJnitvisitlog(jnitvisitlogVO);
    			jnitvisitcountService.insertJnitvisitcount(jnitvisitcountVO);
    		}
    	}catch(DuplicateKeyException e){
    		log.error(e.getMessage());
    	}

    	request.getSession().setAttribute("logSess", logSses);
    	if(regexesIs != null) regexesIs.close();
    	model.addAttribute("json","");
    	*/
    	return "/jnit/util/json";
    }
    /**
	 * Insert Data
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitlogDefaultVO
	 * @return "/jnit/tpl-temp/jnitvisitlog/JnitvisitlogList"
	 * @exception Exception
	 */
    @RequestMapping(value="/visit/log.do")
    public String insertLogData(ModelMap model)
            throws Exception {
    	/*
    	CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
    	HttpServletRequest request = cmsClientProperty.request;
    	//HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	//HttpServletRequest request = (cmsProperty.multipartRequest.get(oriRequest.getRequestedSessionId()) != null ? cmsProperty.multipartRequest.get(oriRequest.getRequestedSessionId()) : oriRequest);
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	Calendar cal = Calendar.getInstance();
    	String regexesPath = PathUtil.getRealPath(request) + "WEB-INF"+SEPERATOR+"config"+SEPERATOR+"jnit"+SEPERATOR+"regexes.yaml";
    	File regexesFile = new File(regexesPath);
    	InputStream regexesIs = new java.io.FileInputStream(regexesFile);
    	Parser uaParser = new Parser(regexesIs);
    	String userAgent = NullUtil.nullString(request.getHeader("user-agent"));
    	Client c = uaParser.parse(userAgent);
    	String site = NullUtil.nullString(request.getServerName());
    	String ipaddr = NullUtil.nullString(request.getRemoteAddr());
    	String referer = NullUtil.nullString(request.getHeader("referer"));
    	String userOs = c.os.family + " " + NullUtil.nullString(c.os.major);
    	userOs = userOs.trim();
    	String browser = c.userAgent.family + " " + c.userAgent.major;
    	//로그인된 사용자이면 MBR_ID를 남기고 그렇지 않는 경우 IP Address를 남긴다.
    	String user = loginVO.getMbrId() == null ? ipaddr : loginVO.getMbrId(); 
    	   	
    	String page = request.getRequestURL().toString();
    	//String page = NullUtil.nullString(request.getParameter("page"));

    	JnitvisitlogVO jnitvisitlogVO = new JnitvisitlogVO();
    	jnitvisitlogVO.setWhenDatetime(cal.getTime());
    	jnitvisitlogVO.setWherDate("true");
    	jnitvisitlogVO.setSite(site);
    	jnitvisitlogVO.setIpaddr(ipaddr);
    	jnitvisitlogVO.setReferer(referer);
    	jnitvisitlogVO.setUserOs(userOs);
    	jnitvisitlogVO.setBrowser(browser);
    	jnitvisitlogVO.setUserAgent(userAgent);
    	jnitvisitlogVO.setUser(user);
    	jnitvisitlogVO.setPage(page);

    	JnitvisitcountVO jnitvisitcountVO = new JnitvisitcountVO();
    	jnitvisitcountVO.setSite(site);
    	jnitvisitcountVO.setVdate(cal.getTime());
    	jnitvisitcountVO.setVhour(cal.get(Calendar.HOUR_OF_DAY));
    	jnitvisitcountVO.setUserOs(userOs);
    	jnitvisitcountVO.setBrowser(browser);
    	
    	String logSses = userAgent + "|" + ipaddr + "|" + page;
    	
    	try{
    		if( ! logSses.equals(request.getSession().getAttribute("logSess")) ){
    			jnitvisitlogService.insertJnitvisitlog(jnitvisitlogVO);
    			jnitvisitcountService.insertJnitvisitcount(jnitvisitcountVO);
    		}
    	}catch(DuplicateKeyException e){
    		log.error(e.getMessage());
    	}

    	request.getSession().setAttribute("logSess", logSses);
    	if(regexesIs != null) regexesIs.close();
    	model.addAttribute("json","");
    	*/
    	return "/jnit/util/json";
    }

    /**
	 * JNITVISITLOG 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitlogDefaultVO
	 * @return "/jnit/tpl-temp/jnitvisitlog/JnitvisitlogList"
	 * @exception Exception
	 */
    
    @RequestMapping(value="/visit/getData.do")
    public String selectJnitvisitlogList( 
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	/*
    	Calendar cal = Calendar.getInstance();
    	JnitvisitlogVO jnitvisitlogVO = new JnitvisitlogVO();
    	String site = NullUtil.nullString(request.getParameter("path"));
    	jnitvisitlogVO.setSite(site);
    	
        int totCnt = jnitvisitlogService.selectJnitvisitlogDataCnt(jnitvisitlogVO);
    	
        jnitvisitlogVO.setWherDate("true");
        int todayCnt = jnitvisitlogService.selectJnitvisitlogDataCnt(jnitvisitlogVO);
        JSONObject jObj = new JSONObject();
        jObj.put("total", totCnt);
        jObj.put("today", todayCnt);
        
    	model.addAttribute("json",jObj.toJSONString());
    	*/
    	return "/jnit/util/json";
    } 
    


}
