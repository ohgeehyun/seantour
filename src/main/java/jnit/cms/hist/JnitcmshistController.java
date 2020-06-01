/**
 * @version 3.2.0.1
 */
package jnit.cms.hist;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitcmshistController.java
 * @Description : Jnitcmshist Controller class
 * @Modification Information
 *
 * @author tactful
 * @since 2012.12.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmshistVO.class)
public class JnitcmshistController {

    @Resource(name = "jnitcmshistService")
    private JnitcmshistService jnitcmshistService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitcmshist 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmshistDefaultVO
	 * @return "/jnit/tpl-temp/jnitcmshist/JnitcmshistList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/sub7/history.do")
    public String selectJnitcmshistList(@ModelAttribute("searchVO") JnitcmshistDefaultVO searchVO,
    		ModelMap model)
            throws Exception {
    	
    	searchVO.setSearchCondition("2");
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(15);
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List jnitcmshistList = jnitcmshistService.selectJnitcmshistList(searchVO);
        model.addAttribute("resultList", jnitcmshistList);
        
        int totCnt = jnitcmshistService.selectJnitcmshistListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/sub7_history";
    }
    
    @RequestMapping("/cms/sub7/getHistory.do")
    public String selectJnitcmshist(
            @RequestParam("histId") java.lang.String histId,
            ModelMap model) throws Exception {
    	
    	JnitcmshistVO vo = new JnitcmshistVO();
    	vo.setHistId(histId);
    	vo = jnitcmshistService.selectJnitcmshist(vo);
    	
    	model.addAttribute("msg", vo.getCntSrc());
    	
        return "/jnit/msg";
    }
    
    /*
    @RequestMapping("/jnitcmshist/addJnitcmshistView.do")
    public String addJnitcmshistView(
            @ModelAttribute("searchVO") JnitcmshistDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmshistService.getLastIdJnitcmshist());
        model.addAttribute("jnitcmshistVO", new JnitcmshistVO());
        return "/jnit/tpl-temp/jnitcmshist/JnitcmshistRegister";
    }
    
    @RequestMapping("/jnitcmshist/addJnitcmshist.do")
    public String addJnitcmshist(
            @ModelAttribute("searchVO") JnitcmshistDefaultVO searchVO,
	    @ModelAttribute("jnitcmshistVO") JnitcmshistVO jnitcmshistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmshistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitcmshist/JnitcmshistRegister";
	// }

        jnitcmshistService.insertJnitcmshist(jnitcmshistVO);
        status.setComplete();
        return "forward:/jnitcmshist/JnitcmshistList.do";
    }
    
    @RequestMapping("/jnitcmshist/updateJnitcmshistView.do")
    public String updateJnitcmshistView(
            @RequestParam("histId") java.lang.String histId ,
            @ModelAttribute("searchVO") JnitcmshistDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmshistVO jnitcmshistVO = new JnitcmshistVO();
        jnitcmshistVO.setHistId(histId);        
        // 변수명은 CoC 에 따라 jnitcmshistVO
        model.addAttribute(selectJnitcmshist(jnitcmshistVO, searchVO));
        return "/jnit/tpl-temp/jnitcmshist/JnitcmshistRegister";
    }

    @RequestMapping("/jnitcmshist/selectJnitcmshist.do")
    public @ModelAttribute("jnitcmshistVO")
    JnitcmshistVO selectJnitcmshist(
            JnitcmshistVO jnitcmshistVO,
            @ModelAttribute("searchVO") JnitcmshistDefaultVO searchVO) throws Exception {
        return jnitcmshistService.selectJnitcmshist(jnitcmshistVO);
    }

    @RequestMapping("/jnitcmshist/updateJnitcmshist.do")
    public String updateJnitcmshist(
            @ModelAttribute("searchVO") JnitcmshistDefaultVO searchVO,
	    @ModelAttribute("jnitcmshistVO") JnitcmshistVO jnitcmshistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmshistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitcmshist/JnitcmshistRegister";
	// }

        jnitcmshistService.updateJnitcmshist(jnitcmshistVO);
        status.setComplete();
        return "forward:/jnitcmshist/JnitcmshistList.do";
    }
    
    @RequestMapping("/jnitcmshist/deleteJnitcmshist.do")
    public String deleteJnitcmshist(
            JnitcmshistVO jnitcmshistVO,
            @ModelAttribute("searchVO") JnitcmshistDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmshistService.deleteJnitcmshist(jnitcmshistVO);
        status.setComplete();
        return "forward:/jnitcmshist/JnitcmshistList.do";
    }
    */

}
