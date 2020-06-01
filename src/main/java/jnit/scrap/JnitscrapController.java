/**
 * @version 3.2.0.1
 */
package jnit.scrap;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.com.utl.fcc.service.WebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitscrapController.java
 * @Description : Jnitscrap Controller class
 * @Modification Information
 *
 * @author tactful
 * @since 2013.03.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitscrapVO.class)
public class JnitscrapController {

    @Resource(name = "jnitscrapService")
    private JnitscrapService jnitscrapService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /**
	 * jnitscrap 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitscrapDefaultVO
	 * @return "/jnit/tpl-temp/jnitscrap/JnitscrapList"
	 * @exception Exception
	 */
    @RequestMapping(value="/scrap/list.do")
    public String selectJnitscrapList(
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	if(loginVO.getMbrId() == null) {
    		model.addAttribute("msg", "E01");
    	}

    	JnitscrapDefaultVO searchVO = new JnitscrapDefaultVO();

    	searchVO.setSearchCondition("0");
    	searchVO.setSearchKeyword(loginVO.getMbrId());
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(20);
    	//searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List jnitscrapList = jnitscrapService.selectJnitscrapList(searchVO);
        model.addAttribute("resultList", jnitscrapList);
        
        int totCnt = jnitscrapService.selectJnitscrapListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/scrap/list";
    }
    
    @RequestMapping("/scrap/add.do")
    public String addJnitscrap(
    	HttpServletRequest request,
    	ModelMap model)
            throws Exception {

    	String url = "";
    	if(request.getParameter("url") != null) {
    		url = request.getParameter("url").toString();
    	}else {
    		model.addAttribute("msg", "E02");
    		return "/jnit/msg";
    	}
    	
    	String title = "";
    	if(request.getParameter("title") != null) {
    		title = request.getParameter("title").toString();    		
    		title = WebUtil.removeTag(title);    		
    	}else {
    		model.addAttribute("msg", "E03");
    		return "/jnit/msg";
    	}
    	
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	if(loginVO.getMbrId() == null) {
    		model.addAttribute("msg", "E01");
    		return "/jnit/msg";
    	}
    	String mbrId = loginVO.getMbrId();
    	JnitscrapDefaultVO searchVO = new JnitscrapDefaultVO();
    	searchVO.setSearchCondition("0");
    	searchVO.setSearchKeyword(mbrId);
    	int totCnt = jnitscrapService.selectJnitscrapListTotCnt(searchVO);
    	
    	if(totCnt < 20) {
        	JnitscrapVO jnitscrapVO = new JnitscrapVO();
        	jnitscrapVO.setMbrId(mbrId);        	
        	jnitscrapVO.setTitle(title);
        	jnitscrapVO.setUrl(url);        	
        	try {
        		jnitscrapService.insertJnitscrap(jnitscrapVO);
        		model.addAttribute("msg", "OK");
        	} catch (NullPointerException e){
        		model.addAttribute("msg", "E05");
        	}catch(Exception e) {
        		model.addAttribute("msg", "E05");
        	}
        	
        	return "/jnit/msg";
    	}else {
    		model.addAttribute("msg", "E04");
    		return "/jnit/msg";
    	}
    }
    
    @RequestMapping("/scrap/del.do")
    public String deleteJnitscrap(
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	
    	String scrapId = "";
    	if(request.getParameter("scrapId") != null) {
    		scrapId = request.getParameter("scrapId").toString();
    	}else {
    		model.addAttribute("msg", "E01");
    		return "/jnit/msg";
    	}
    	
       	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	if(loginVO.getMbrId() == null) {
    		model.addAttribute("msg", "E02");
    		return "/jnit/msg";
    	}
    	String mbrId = loginVO.getMbrId();
    	JnitscrapDefaultVO searchVO = new JnitscrapDefaultVO();
    	searchVO.setSearchCondition("0");
    	searchVO.setSearchKeyword(mbrId);
    	int totCnt = jnitscrapService.selectJnitscrapListTotCnt(searchVO);
    	
    	if(totCnt > 0) {
        	JnitscrapVO jnitscrapVO = new JnitscrapVO();
        	jnitscrapVO.setScrapId(scrapId);
        	jnitscrapVO.setMbrId(mbrId);
        	        	
        	try {
        		jnitscrapService.deleteJnitscrap(jnitscrapVO);
        		model.addAttribute("msg", "OK");
        	} catch (NullPointerException e){
        		model.addAttribute("msg", "E04");
        	}catch(Exception e) {
        		model.addAttribute("msg", "E04");
        	}
        	
        	return "/jnit/msg";
    	}else {
    		model.addAttribute("msg", "E03");
    		return "/jnit/msg";
    	}
    }
    
    /*
    @RequestMapping("/jnitscrap/addJnitscrapView.do")
    public String addJnitscrapView(
            @ModelAttribute("searchVO") JnitscrapDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitscrapService.getLastIdJnitscrap());
        model.addAttribute("jnitscrapVO", new JnitscrapVO());
        return "/jnit/tpl-temp/jnitscrap/JnitscrapRegister";
    }
    
    @RequestMapping("/jnitscrap/addJnitscrap.do")
    public String addJnitscrap(
            @ModelAttribute("searchVO") JnitscrapDefaultVO searchVO,
	    @ModelAttribute("jnitscrapVO") JnitscrapVO jnitscrapVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitscrapVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitscrap/JnitscrapRegister";
	// }

        jnitscrapService.insertJnitscrap(jnitscrapVO);
        status.setComplete();
        return "forward:/jnitscrap/JnitscrapList.do";
    }
    
    @RequestMapping("/jnitscrap/updateJnitscrapView.do")
    public String updateJnitscrapView(
            @RequestParam("scrapId") java.lang.String scrapId ,
            @ModelAttribute("searchVO") JnitscrapDefaultVO searchVO, Model model)
            throws Exception {
        JnitscrapVO jnitscrapVO = new JnitscrapVO();
        jnitscrapVO.setScrapId(scrapId);        
        // 변수명은 CoC 에 따라 jnitscrapVO
        model.addAttribute(selectJnitscrap(jnitscrapVO, searchVO));
        return "/jnit/tpl-temp/jnitscrap/JnitscrapRegister";
    }

    @RequestMapping("/jnitscrap/selectJnitscrap.do")
    public @ModelAttribute("jnitscrapVO")
    JnitscrapVO selectJnitscrap(
            JnitscrapVO jnitscrapVO,
            @ModelAttribute("searchVO") JnitscrapDefaultVO searchVO) throws Exception {
        return jnitscrapService.selectJnitscrap(jnitscrapVO);
    }

    @RequestMapping("/jnitscrap/updateJnitscrap.do")
    public String updateJnitscrap(
            @ModelAttribute("searchVO") JnitscrapDefaultVO searchVO,
	    @ModelAttribute("jnitscrapVO") JnitscrapVO jnitscrapVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitscrapVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitscrap/JnitscrapRegister";
	// }

        jnitscrapService.updateJnitscrap(jnitscrapVO);
        status.setComplete();
        return "forward:/jnitscrap/JnitscrapList.do";
    }
    
    @RequestMapping("/jnitscrap/deleteJnitscrap.do")
    public String deleteJnitscrap(
            JnitscrapVO jnitscrapVO,
            @ModelAttribute("searchVO") JnitscrapDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitscrapService.deleteJnitscrap(jnitscrapVO);
        status.setComplete();
        return "forward:/jnitscrap/JnitscrapList.do";
    }
	*/
}
