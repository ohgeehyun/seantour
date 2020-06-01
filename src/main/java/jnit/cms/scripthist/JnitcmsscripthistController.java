/**
 * @version 3.2.0.1
 */
package jnit.cms.scripthist;

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
 * @Class Name : JnitcmsscripthistController.java
 * @Description : Jnitcmsscripthist Controller class
 * @Modification Information
 *
 * @author JNITCMSSCRIPTHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsscripthistVO.class)
public class JnitcmsscripthistController {

    @Resource(name = "jnitcmsscripthistService")
    private JnitcmsscripthistService jnitcmsscripthistService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * JNITCMSSCRIPTHIST 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsscripthistDefaultVO
	 * @return "/jnit/cms/jnitcmsscripthist/JnitcmsscripthistList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/js/hist/list.do")
    public String selectJnitcmsscripthistList(@ModelAttribute("searchVO") JnitcmsscripthistDefaultVO searchVO, 
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
		
        List jnitcmsscripthistList = jnitcmsscripthistService.selectJnitcmsscripthistList(searchVO);
        model.addAttribute("resultList", jnitcmsscripthistList);
        
        int totCnt = jnitcmsscripthistService.selectJnitcmsscripthistListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/hist/js/jshistList";
    } 
    
    @RequestMapping("/cms/js/hist/add.do")
    public String addJnitcmsscripthistView(
            @ModelAttribute("searchVO") JnitcmsscripthistDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmsscripthistService.getLastIdJnitcmsscripthist());
        model.addAttribute("jnitcmsscripthistVO", new JnitcmsscripthistVO());
        return "/jnit/cms/hist/js/jshistEdit";
    }
    
    @RequestMapping("/cms/js/hist/addProc.do")
    public String addJnitcmsscripthist(
            @ModelAttribute("searchVO") JnitcmsscripthistDefaultVO searchVO,
	    @ModelAttribute("jnitcmsscripthistVO") JnitcmsscripthistVO jnitcmsscripthistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsscripthistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmsscripthist/JnitcmsscripthistRegister";
	// }

        jnitcmsscripthistService.insertJnitcmsscripthist(jnitcmsscripthistVO);
        status.setComplete();
        return "forward:/cms/js/hist/list.do";
    }
    
    @RequestMapping("/cms/js/hist/edit.do")
    public String updateJnitcmsscripthistView(
            @RequestParam("histId") java.lang.String histId ,
            @ModelAttribute("searchVO") JnitcmsscripthistDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmsscripthistVO jnitcmsscripthistVO = new JnitcmsscripthistVO();
        jnitcmsscripthistVO.setHistId(histId);
        // 변수명은 CoC 에 따라 jnitcmsscripthistVO
        model.addAttribute(selectJnitcmsscripthist(jnitcmsscripthistVO, searchVO));
        return "/jnit/cms/hist/js/jshistEdit";
    }

    @RequestMapping("/jnitcmsscripthist/selectJnitcmsscripthist.do")
    public @ModelAttribute("jnitcmsscripthistVO")
    JnitcmsscripthistVO selectJnitcmsscripthist(
            JnitcmsscripthistVO jnitcmsscripthistVO,
            @ModelAttribute("searchVO") JnitcmsscripthistDefaultVO searchVO) throws Exception {
        return jnitcmsscripthistService.selectJnitcmsscripthist(jnitcmsscripthistVO);
    }

    @RequestMapping("/cms/js/hist/editProc.do")
    public String updateJnitcmsscripthist(
            @ModelAttribute("searchVO") JnitcmsscripthistDefaultVO searchVO,
	    @ModelAttribute("jnitcmsscripthistVO") JnitcmsscripthistVO jnitcmsscripthistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsscripthistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmsscripthist/JnitcmsscripthistRegister";
	// }

        jnitcmsscripthistService.updateJnitcmsscripthist(jnitcmsscripthistVO);
        status.setComplete();
        return "forward:/cms/js/hist/list.do";
    }
    
    @RequestMapping("/js/hist/deleteProc.do")
    public String deleteJnitcmsscripthist(
            JnitcmsscripthistVO jnitcmsscripthistVO,
            @ModelAttribute("searchVO") JnitcmsscripthistDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsscripthistService.deleteJnitcmsscripthist(jnitcmsscripthistVO);
        status.setComplete();
        return "forward:/cms/js/hist/list.do";
    }

}
