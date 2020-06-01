/**
 * @version 3.2.0.1
 */
package jnit.cms.rank;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.AdminUtil;
import jnit.cms.org.JnitcmsorgDefaultVO;
import jnit.cms.org.JnitcmsorgService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitcmsrankController.java
 * @Description : Jnitcmsrank Controller class
 * @Modification Information
 *
 * @author JNITCMSRANK
 * @since 2013.11.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsrankVO.class)
public class JnitcmsrankController {

    @Resource(name = "jnitcmsrankService")
    private JnitcmsrankService jnitcmsrankService;
    
    @Resource(name = "jnitcmsorgService")
    private JnitcmsorgService jnitcmsorgService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitcmsrank 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsrankDefaultVO
	 * @return "/jnit/cms/sub1_4-1"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/sub1/0401.do")
    public String selectJnitcmsrankList(@ModelAttribute("searchVO") JnitcmsrankDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m02010300");
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
		searchVO.setSearchCondition("3");
        List jnitcmsrankList = jnitcmsrankService.selectLeftJoinrankList(searchVO);
        model.addAttribute("resultList", jnitcmsrankList);
        
        int totCnt = jnitcmsrankService.selectJnitcmsrankListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/sub1_4-1";
    } 
    
    @RequestMapping("/cms/sub1/0402add.do")
    public String addJnitcmsrankView(
            @ModelAttribute("searchVO") JnitcmsrankDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02010300");
    	JnitcmsorgDefaultVO jnitcmsorgDefaultVO = new JnitcmsorgDefaultVO();
    	List orgList = jnitcmsorgService.selectcmsorgList(jnitcmsorgDefaultVO);
    	
    	model.addAttribute("orgList", orgList);
        model.addAttribute("nid",  jnitcmsrankService.getLastIdJnitcmsrank());
        model.addAttribute("jnitcmsrankVO", new JnitcmsrankVO());
        return "/jnit/cms/sub1_4-2";
    }
    
    @RequestMapping("/cms/sub1/0402addProc.do")
    public String addJnitcmsrank(
            @ModelAttribute("searchVO") JnitcmsrankDefaultVO searchVO,
	    @ModelAttribute("jnitcmsrankVO") JnitcmsrankVO jnitcmsrankVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsrankVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitcmsrank/JnitcmsrankRegister";
	// }
    	
    	String orgId = NullUtil.nullString(request.getParameter("orgId"));    	
    	jnitcmsrankVO.setOrgId(orgId);
    	jnitcmsrankVO.setRankName(NullUtil.nullString(jnitcmsrankVO.getRankName()).trim());
        jnitcmsrankService.insertJnitcmsrank(jnitcmsrankVO);
        status.setComplete();
        return "forward:/cms/sub1/0401.do";
    }
    
    @RequestMapping("/cms/sub1/0402Edit.do")
    public String updateJnitcmsrankView(
            @RequestParam("rankId") java.lang.String rankId ,
            @ModelAttribute("searchVO") JnitcmsrankDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02010300");
    	JnitcmsorgDefaultVO jnitcmsorgDefaultVO = new JnitcmsorgDefaultVO();
    	List orgList = jnitcmsorgService.selectcmsorgList(jnitcmsorgDefaultVO);
    	
        JnitcmsrankVO jnitcmsrankVO = new JnitcmsrankVO();
        jnitcmsrankVO.setRankId(rankId);        
        // 변수명은 CoC 에 따라 jnitcmsrankVO
        
        model.addAttribute("nid", jnitcmsrankService.getLastIdJnitcmsrank());
        model.addAttribute("orgList", orgList);
        model.addAttribute(selectJnitcmsrank(jnitcmsrankVO, searchVO));
        return "/jnit/cms/sub1_4-2";
    }

    @RequestMapping("/jnitcmsrank/selectJnitcmsrank.do")
    public @ModelAttribute("jnitcmsrankVO")
    JnitcmsrankVO selectJnitcmsrank(
            JnitcmsrankVO jnitcmsrankVO,
            @ModelAttribute("searchVO") JnitcmsrankDefaultVO searchVO) throws Exception {
        return jnitcmsrankService.selectJnitcmsrank(jnitcmsrankVO);
    }

    @RequestMapping("/cms/sub1/0402EditProc.do")
    public String updateJnitcmsrank(
            @ModelAttribute("searchVO") JnitcmsrankDefaultVO searchVO,
	    @ModelAttribute("jnitcmsrankVO") JnitcmsrankVO jnitcmsrankVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsrankVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitcmsrank/JnitcmsrankRegister";
	// }
    	String orgId = NullUtil.nullString(request.getParameter("orgId"));
    	jnitcmsrankVO.setOrgId(orgId);
    	jnitcmsrankVO.setRankName(NullUtil.nullString(jnitcmsrankVO.getRankName()).trim());
        jnitcmsrankService.updateJnitcmsrank(jnitcmsrankVO);
        status.setComplete();
        return "forward:/cms/sub1/0401.do";
    }
    
    @RequestMapping("/cms/sub1/0402delProc.do")
    public String deleteJnitcmsrank(
            JnitcmsrankVO jnitcmsrankVO,
            @ModelAttribute("searchVO") JnitcmsrankDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsrankService.deleteJnitcmsrank(jnitcmsrankVO);
        status.setComplete();
        return "forward:/cms/sub1/0401.do";
    }

}
