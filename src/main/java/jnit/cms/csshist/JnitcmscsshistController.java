/**
 * @version 3.2.0.1
 */
package jnit.cms.csshist;

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
 * @Class Name : JnitcmscsshistController.java
 * @Description : Jnitcmscsshist Controller class
 * @Modification Information
 *
 * @author JNITCMSCSSHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmscsshistVO.class)
public class JnitcmscsshistController {

    @Resource(name = "jnitcmscsshistService")
    private JnitcmscsshistService jnitcmscsshistService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * JNITCMSCSSHIST 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmscsshistDefaultVO
	 * @return "/jnit/cms/jnitcmscsshist/JnitcmscsshistList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/css/hist/list.do")
    public String selectJnitcmscsshistList(@ModelAttribute("searchVO") JnitcmscsshistDefaultVO searchVO, 
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
		
        List jnitcmscsshistList = jnitcmscsshistService.selectJnitcmscsshistList(searchVO);
        model.addAttribute("resultList", jnitcmscsshistList);
        
        int totCnt = jnitcmscsshistService.selectJnitcmscsshistListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/hist/css/csshistList";
    } 
    
    @RequestMapping("/cms/css/hist/add.do")
    public String addJnitcmscsshistView(
            @ModelAttribute("searchVO") JnitcmscsshistDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmscsshistService.getLastIdJnitcmscsshist());
        model.addAttribute("jnitcmscsshistVO", new JnitcmscsshistVO());
        return "/jnit/cms/hist/css/csshistEdit";
    }
    
    @RequestMapping("/cms/css/hist/addProc.do")
    public String addJnitcmscsshist(
            @ModelAttribute("searchVO") JnitcmscsshistDefaultVO searchVO,
	    @ModelAttribute("jnitcmscsshistVO") JnitcmscsshistVO jnitcmscsshistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmscsshistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmscsshist/JnitcmscsshistRegister";
	// }

        jnitcmscsshistService.insertJnitcmscsshist(jnitcmscsshistVO);
        status.setComplete();
        return "forward:/cms/css/hist/list.do";
    }
    
    @RequestMapping("/cms/css/hist/edit.do")
    public String updateJnitcmscsshistView(
            @RequestParam("histId") java.lang.String histId ,
            @ModelAttribute("searchVO") JnitcmscsshistDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmscsshistVO jnitcmscsshistVO = new JnitcmscsshistVO();
        jnitcmscsshistVO.setHistId(histId);
        // 변수명은 CoC 에 따라 jnitcmscsshistVO
        model.addAttribute(selectJnitcmscsshist(jnitcmscsshistVO, searchVO));
        return "/jnit/cms/hist/css/csshistEdit";
    }

    @RequestMapping("/jnitcmscsshist/selectJnitcmscsshist.do")
    public @ModelAttribute("jnitcmscsshistVO")
    JnitcmscsshistVO selectJnitcmscsshist(
            JnitcmscsshistVO jnitcmscsshistVO,
            @ModelAttribute("searchVO") JnitcmscsshistDefaultVO searchVO) throws Exception {
        return jnitcmscsshistService.selectJnitcmscsshist(jnitcmscsshistVO);
    }

    @RequestMapping("/cms/css/hist/editProc.do")
    public String updateJnitcmscsshist(
            @ModelAttribute("searchVO") JnitcmscsshistDefaultVO searchVO,
	    @ModelAttribute("jnitcmscsshistVO") JnitcmscsshistVO jnitcmscsshistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmscsshistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmscsshist/JnitcmscsshistRegister";
	// }

        jnitcmscsshistService.updateJnitcmscsshist(jnitcmscsshistVO);
        status.setComplete();
        return "forward:/cms/css/hist/list.do";
    }
    
    @RequestMapping("/css/hist/deleteProc.do")
    public String deleteJnitcmscsshist(
            JnitcmscsshistVO jnitcmscsshistVO,
            @ModelAttribute("searchVO") JnitcmscsshistDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmscsshistService.deleteJnitcmscsshist(jnitcmscsshistVO);
        status.setComplete();
        return "forward:/cms/css/hist/list.do";
    }

}
