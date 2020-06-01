/**
 * @version 3.2.0.1
 */
package jnit.cms.boardhist;

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
 * @Class Name : JnitcmsboardhistController.java
 * @Description : Jnitcmsboardhist Controller class
 * @Modification Information
 *
 * @author JNITCMSBOARDHIST
 * @since 2014.08.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsboardhistVO.class)
public class JnitcmsboardhistController {

    @Resource(name = "jnitcmsboardhistService")
    private JnitcmsboardhistService jnitcmsboardhistService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * JNITCMSBOARDHIST 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsboardhistDefaultVO
	 * @return "/jnit/cms/jnitcmsboardhist/JnitcmsboardhistList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/board/hist/list.do")
    public String selectJnitcmsboardhistList(@ModelAttribute("searchVO") JnitcmsboardhistDefaultVO searchVO, 
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
		
        List jnitcmsboardhistList = jnitcmsboardhistService.selectJnitcmsboardhistList(searchVO);
        model.addAttribute("resultList", jnitcmsboardhistList);
        
        int totCnt = jnitcmsboardhistService.selectJnitcmsboardhistListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/hist/board/boardhistList";
    } 
    
    @RequestMapping("/cms/board/hist/add.do")
    public String addJnitcmsboardhistView(
            @ModelAttribute("searchVO") JnitcmsboardhistDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmsboardhistService.getLastIdJnitcmsboardhist());
        model.addAttribute("jnitcmsboardhistVO", new JnitcmsboardhistVO());
        return "/jnit/cms/hist/board/boardhistEdit";
    }
    
    @RequestMapping("/cms/board/hist/addProc.do")
    public String addJnitcmsboardhist(
            @ModelAttribute("searchVO") JnitcmsboardhistDefaultVO searchVO,
	    @ModelAttribute("jnitcmsboardhistVO") JnitcmsboardhistVO jnitcmsboardhistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsboardhistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmsboardhist/JnitcmsboardhistRegister";
	// }

        jnitcmsboardhistService.insertJnitcmsboardhist(jnitcmsboardhistVO);
        status.setComplete();
        return "forward:/cms/board/hist/list.do";
    }
    
    @RequestMapping("/cms/board/hist/edit.do")
    public String updateJnitcmsboardhistView(
            @RequestParam("histId") java.lang.String histId ,
            @ModelAttribute("searchVO") JnitcmsboardhistDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmsboardhistVO jnitcmsboardhistVO = new JnitcmsboardhistVO();
        jnitcmsboardhistVO.setHistId(histId);
        // 변수명은 CoC 에 따라 jnitcmsboardhistVO
        model.addAttribute(selectJnitcmsboardhist(jnitcmsboardhistVO, searchVO));
        return "/jnit/cms/hist/board/boardhistEdit";
    }

    @RequestMapping("/jnitcmsboardhist/selectJnitcmsboardhist.do")
    public @ModelAttribute("jnitcmsboardhistVO")
    JnitcmsboardhistVO selectJnitcmsboardhist(
            JnitcmsboardhistVO jnitcmsboardhistVO,
            @ModelAttribute("searchVO") JnitcmsboardhistDefaultVO searchVO) throws Exception {
        return jnitcmsboardhistService.selectJnitcmsboardhist(jnitcmsboardhistVO);
    }

    @RequestMapping("/cms/board/hist/editProc.do")
    public String updateJnitcmsboardhist(
            @ModelAttribute("searchVO") JnitcmsboardhistDefaultVO searchVO,
	    @ModelAttribute("jnitcmsboardhistVO") JnitcmsboardhistVO jnitcmsboardhistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsboardhistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmsboardhist/JnitcmsboardhistRegister";
	// }

        jnitcmsboardhistService.updateJnitcmsboardhist(jnitcmsboardhistVO);
        status.setComplete();
        return "forward:/cms/board/hist/list.do";
    }
    
    @RequestMapping("/board/hist/delete.do")
    public String deleteJnitcmsboardhist(
            JnitcmsboardhistVO jnitcmsboardhistVO,
            @ModelAttribute("searchVO") JnitcmsboardhistDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsboardhistService.deleteJnitcmsboardhist(jnitcmsboardhistVO);
        status.setComplete();
        return "forward:/cms/board/hist/list.do";
    }
}
