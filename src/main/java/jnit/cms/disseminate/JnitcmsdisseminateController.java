/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminate;

import java.util.List;

import javax.annotation.Resource;

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

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitcmsdisseminateController.java
 * @Description : Jnitcmsdisseminate Controller class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATE
 * @since 2013.11.05
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsdisseminateVO.class)
public class JnitcmsdisseminateController {

    @Resource(name = "jnitcmsdisseminateService")
    private JnitcmsdisseminateService jnitcmsdisseminateService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitcmsdisseminate 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsdisseminateDefaultVO
	 * @return "/jnit/cms/disseminate/jnitcmsdisseminate/JnitcmsdisseminateList"
	 * @exception Exception
	 */
    @RequestMapping(value="/jnitcmsdisseminate/JnitcmsdisseminateList.do")
    public String selectJnitcmsdisseminateList(@ModelAttribute("searchVO") JnitcmsdisseminateDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
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
		
        List jnitcmsdisseminateList = jnitcmsdisseminateService.selectJnitcmsdisseminateList(searchVO);
        model.addAttribute("resultList", jnitcmsdisseminateList);
        
        int totCnt = jnitcmsdisseminateService.selectJnitcmsdisseminateListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/disseminate/jnitcmsdisseminate/JnitcmsdisseminateList";
    } 
    
    @RequestMapping("/jnitcmsdisseminate/addJnitcmsdisseminateView.do")
    public String addJnitcmsdisseminateView(
            @ModelAttribute("searchVO") JnitcmsdisseminateDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmsdisseminateService.getLastIdJnitcmsdisseminate());
        model.addAttribute("jnitcmsdisseminateVO", new JnitcmsdisseminateVO());
        return "/jnit/cms/disseminate/jnitcmsdisseminate/JnitcmsdisseminateRegister";
    }
    
    @RequestMapping("/jnitcmsdisseminate/addJnitcmsdisseminate.do")
    public String addJnitcmsdisseminate(
            @ModelAttribute("searchVO") JnitcmsdisseminateDefaultVO searchVO,
	    @ModelAttribute("jnitcmsdisseminateVO") JnitcmsdisseminateVO jnitcmsdisseminateVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsdisseminateVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/disseminate/jnitcmsdisseminate/JnitcmsdisseminateRegister";
	// }

        jnitcmsdisseminateService.insertJnitcmsdisseminate(jnitcmsdisseminateVO);
        status.setComplete();
        return "forward:/jnitcmsdisseminate/JnitcmsdisseminateList.do";
    }
    
    @RequestMapping("/jnitcmsdisseminate/updateJnitcmsdisseminateView.do")
    public String updateJnitcmsdisseminateView(
            @RequestParam("disseminateId") java.lang.String disseminateId ,
            @ModelAttribute("searchVO") JnitcmsdisseminateDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmsdisseminateVO jnitcmsdisseminateVO = new JnitcmsdisseminateVO();
        jnitcmsdisseminateVO.setDisseminateId(disseminateId);        
        // 변수명은 CoC 에 따라 jnitcmsdisseminateVO
        model.addAttribute(selectJnitcmsdisseminate(jnitcmsdisseminateVO, searchVO));
        return "/jnit/cms/disseminate/jnitcmsdisseminate/JnitcmsdisseminateRegister";
    }

    @RequestMapping("/jnitcmsdisseminate/selectJnitcmsdisseminate.do")
    public @ModelAttribute("jnitcmsdisseminateVO")
    JnitcmsdisseminateVO selectJnitcmsdisseminate(
            JnitcmsdisseminateVO jnitcmsdisseminateVO,
            @ModelAttribute("searchVO") JnitcmsdisseminateDefaultVO searchVO) throws Exception {
        return jnitcmsdisseminateService.selectJnitcmsdisseminate(jnitcmsdisseminateVO);
    }

    @RequestMapping("/jnitcmsdisseminate/updateJnitcmsdisseminate.do")
    public String updateJnitcmsdisseminate(
            @ModelAttribute("searchVO") JnitcmsdisseminateDefaultVO searchVO,
	    @ModelAttribute("jnitcmsdisseminateVO") JnitcmsdisseminateVO jnitcmsdisseminateVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsdisseminateVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/disseminate/jnitcmsdisseminate/JnitcmsdisseminateRegister";
	// }

        jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);
        status.setComplete();
        return "forward:/jnitcmsdisseminate/JnitcmsdisseminateList.do";
    }
    
    @RequestMapping("/jnitcmsdisseminate/deleteJnitcmsdisseminate.do")
    public String deleteJnitcmsdisseminate(
            JnitcmsdisseminateVO jnitcmsdisseminateVO,
            @ModelAttribute("searchVO") JnitcmsdisseminateDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsdisseminateService.deleteJnitcmsdisseminate(jnitcmsdisseminateVO);
        status.setComplete();
        return "forward:/jnitcmsdisseminate/JnitcmsdisseminateList.do";
    }

}
