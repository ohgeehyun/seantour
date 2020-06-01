/**
 * @version 3.2.0.1
 */
package jnit.visit.count;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.AdminUtil;
import jnit.cms.site.JnitcmssiteDefaultVO;
import jnit.cms.site.JnitcmssiteService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : JnitvisitcountController.java
 * @Description : Jnitvisitcount Controller class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.11.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitvisitcountVO.class)
public class JnitvisitcountController {

    @Resource(name = "jnitvisitcountService")
    private JnitvisitcountService jnitvisitcountService;
    
    @Resource(name = "jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /**
	 * 일별 시간별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/day_time.do")
    public String selectJnitvisitcountList_dayTime(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020101");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	int max = 0;
    	int sum = 0;
    	
    	if("true".equals(deDug)) System.out.println("searchSite : " + searchSite);
    	
    	if(!"".equals(searchDateStr)){
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(1);
    	searchVO.setSearchCondition("1");
    	if(!"".equals(searchSite)){
    		if("true".equals(deDug)) System.out.println("searchSite if on : " + searchSite);
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    		siteSearchVO.setFirstIndex(0);
    		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("searchDateStr", searchDateStr);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
    	
    	
        return "/jnit/visit/stats_day_time";
    } 
    /**
	 * 일별 브라우저별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/day_browser.do")
    public String selectJnitvisitcountList_dayBrowser(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020102");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr)){
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(1);
    	searchVO.setSearchCondition("2");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("searchDateStr", searchDateStr);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_day_browser";
    } 
    /**
	 * 일별 OS별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/day_os.do")
    public String selectJnitvisitcountList_dayOs(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020103");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr)){
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(1);
    	searchVO.setSearchCondition("3");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("searchDateStr", searchDateStr);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_day_os";
    } 
    /**
	 * 월간 일별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/month_day.do")
    public String selectJnitvisitcountList_monthDay(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020203");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchDateStr2 = NullUtil.nullString(request.getParameter("search_day2"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	model.addAttribute("searchDateStr", searchDateStr+"-"+searchDateStr2);
    	
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr) && !"".equals(searchDateStr2)){
    		searchDateStr = searchDateStr + "-" + searchDateStr2 + "-" + "01"; 
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(2);
    	searchVO.setSearchCondition("4");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_month_day";
    }
    
    /**
	 * 월간 시간별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/month_time.do")
    public String selectJnitvisitcountList_monthTime(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020201");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchDateStr2 = NullUtil.nullString(request.getParameter("search_day2"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	model.addAttribute("searchDateStr", searchDateStr+"-"+searchDateStr2);
    	
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr) && !"".equals(searchDateStr2)){
    		searchDateStr = searchDateStr + "-" + searchDateStr2 + "-" + "01"; 
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(2);
    	searchVO.setSearchCondition("1");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_day_time";
    } 
    /**
	 * 월간 브라우저별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/month_browser.do")
    public String selectJnitvisitcountList_monthBrowser(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020202");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchDateStr2 = NullUtil.nullString(request.getParameter("search_day2"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	model.addAttribute("searchDateStr", searchDateStr+"-"+searchDateStr2);
    	
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr) && !"".equals(searchDateStr2)){
    		searchDateStr = searchDateStr + "-" + searchDateStr2 + "-" + "01"; 
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(2);
    	searchVO.setSearchCondition("2");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_day_browser";
    } 
    /**
	 * 월간 OS별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/month_os.do")
    public String selectJnitvisitcountList_monthOs(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020203");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchDateStr2 = NullUtil.nullString(request.getParameter("search_day2"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	model.addAttribute("searchDateStr", searchDateStr+"-"+searchDateStr2);
    	
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr) && !"".equals(searchDateStr2)){
    		searchDateStr = searchDateStr + "-" + searchDateStr2 + "-" + "01"; 
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(2);
    	searchVO.setSearchCondition("3");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_day_os";
    }
    /**
	 * 연간 월별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/year_month.do")
    public String selectJnitvisitcountList_yearMonth(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020304");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	model.addAttribute("searchDateStr", searchDateStr);
    	
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr)){
    		searchDateStr = searchDateStr + "-" + "01" + "-" + "01";
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(3);
    	searchVO.setSearchCondition("5");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_year_month";
    }
    /**
	 * 년간 시간별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/year_time.do")
    public String selectJnitvisitcountList_yearTime(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020301");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	model.addAttribute("searchDateStr", searchDateStr);
    	
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr)){
    		searchDateStr = searchDateStr + "-" + "01" + "-" + "01";
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(3);
    	searchVO.setSearchCondition("1");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_day_time";
    } 
    /**
	 * 년간 브라우저별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/year_browser.do")
    public String selectJnitvisitcountList_yearBrowser(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020302");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	model.addAttribute("searchDateStr", searchDateStr);
    	
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr)){
    		searchDateStr = searchDateStr + "-" + "01" + "-" + "01";
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(3);
    	searchVO.setSearchCondition("2");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_day_browser";
    } 
    /**
	 * 년간 OS별 방문자 통계
	 * @param searchVO - 조회할 정보가 담긴 JnitvisitcountDefaultVO
	 * @return "/jnit/visit/stats_day_time"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/visit/stats/year_os.do")
    public String selectJnitvisitcountList_yearOs(@ModelAttribute("searchVO") JnitvisitcountDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m05020303");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	
    	String searchDateStr = NullUtil.nullString(request.getParameter("search_day1"));
    	String searchSite = NullUtil.nullString(request.getParameter("searchSite")).trim();
    	model.addAttribute("searchDateStr", searchDateStr);
    	
    	int max = 0;
    	int sum = 0;
    	
    	if(!"".equals(searchDateStr)){
    		searchDateStr = searchDateStr + "-" + "01" + "-" + "01";
    		cal.setTime(sdf.parse(searchDateStr));
    	}else{
    		searchDateStr = sdf.format(cal.getTime());
    	}
    	searchVO.setSearchDate(cal.getTime());
    	searchVO.setSearchTerm(3);
    	searchVO.setSearchCondition("3");
    	if(!"".equals(searchSite)){
    		searchVO.setSearchSite(searchSite);
    	}
    	List resultList = jnitvisitcountService.selectJnitvisitcountStats(searchVO);
    	
    	JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteDefaultVO();
    	siteSearchVO.setFirstIndex(0);
		siteSearchVO.setLastIndex(1000);
    	List resultSiteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
    	
    	Iterator hit = (Iterator)resultList.iterator();
		while(hit.hasNext()){
			EgovMap hitList = (EgovMap)hit.next();
			max = Math.max(Integer.parseInt(String.valueOf(hitList.get("hit"))), max);
			sum += Integer.parseInt(String.valueOf(hitList.get("hit")));
		}
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("day", searchVO.getSearchTerm());
    	model.addAttribute("max", max);
    	model.addAttribute("sum", sum);
    	model.addAttribute("resultSiteList", resultSiteList);
    	
        return "/jnit/visit/stats_day_os";
    }    
    
}
