/**
 * @version 3.2.0.1
 */
package jnit.board.cmt;

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
 * @Class Name : JnitboardcmtController.java
 * @Description : Jnitboardcmt Controller class
 * @Modification Information
 *
 * @author JNITBOARDCMT
 * @since 2013.07.11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitboardcmtVO.class)
public class JnitboardcmtController {

    @Resource(name = "jnitboardcmtService")
    private JnitboardcmtService jnitboardcmtService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitboardcmt 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitboardcmtDefaultVO
	 * @return "/jnit/tpl-temp/jnitboardcmt/JnitboardcmtList"
	 * @exception Exception
	 */
    @RequestMapping(value="/jnitboardcmt/JnitboardcmtList.do")
    public String selectJnitboardcmtList(@ModelAttribute("searchVO") JnitboardcmtDefaultVO searchVO, 
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
		
        List jnitboardcmtList = jnitboardcmtService.selectJnitboardcmtList(searchVO);
        model.addAttribute("resultList", jnitboardcmtList);
        
        int totCnt = jnitboardcmtService.selectJnitboardcmtListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/tpl-temp/jnitboardcmt/JnitboardcmtList";
    } 
    
    @RequestMapping("/jnitboardcmt/addJnitboardcmtView.do")
    public String addJnitboardcmtView(
            @ModelAttribute("searchVO") JnitboardcmtDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitboardcmtService.getLastIdJnitboardcmt());
        model.addAttribute("jnitboardcmtVO", new JnitboardcmtVO());
        return "/jnit/tpl-temp/jnitboardcmt/JnitboardcmtRegister";
    }
    
    @RequestMapping("/jnitboardcmt/addJnitboardcmt.do")
    public String addJnitboardcmt(
            @ModelAttribute("searchVO") JnitboardcmtDefaultVO searchVO,
	    @ModelAttribute("jnitboardcmtVO") JnitboardcmtVO jnitboardcmtVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitboardcmtVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitboardcmt/JnitboardcmtRegister";
	// }

        jnitboardcmtService.insertJnitboardcmt(jnitboardcmtVO);
        status.setComplete();
        return "forward:/jnitboardcmt/JnitboardcmtList.do";
    }
    
    @RequestMapping("/jnitboardcmt/updateJnitboardcmtView.do")
    public String updateJnitboardcmtView(
            @RequestParam("cmtId") java.lang.String cmtId ,
            @ModelAttribute("searchVO") JnitboardcmtDefaultVO searchVO, Model model)
            throws Exception {
        JnitboardcmtVO jnitboardcmtVO = new JnitboardcmtVO();
        jnitboardcmtVO.setCmtId(cmtId);        
        // 변수명은 CoC 에 따라 jnitboardcmtVO
        model.addAttribute(selectJnitboardcmt(jnitboardcmtVO, searchVO));
        return "/jnit/tpl-temp/jnitboardcmt/JnitboardcmtRegister";
    }

    @RequestMapping("/jnitboardcmt/selectJnitboardcmt.do")
    public @ModelAttribute("jnitboardcmtVO")
    JnitboardcmtVO selectJnitboardcmt(
            JnitboardcmtVO jnitboardcmtVO,
            @ModelAttribute("searchVO") JnitboardcmtDefaultVO searchVO) throws Exception {
        return jnitboardcmtService.selectJnitboardcmt(jnitboardcmtVO);
    }

    @RequestMapping("/jnitboardcmt/updateJnitboardcmt.do")
    public String updateJnitboardcmt(
            @ModelAttribute("searchVO") JnitboardcmtDefaultVO searchVO,
	    @ModelAttribute("jnitboardcmtVO") JnitboardcmtVO jnitboardcmtVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitboardcmtVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitboardcmt/JnitboardcmtRegister";
	// }

        jnitboardcmtService.updateJnitboardcmt(jnitboardcmtVO);
        status.setComplete();
        return "forward:/jnitboardcmt/JnitboardcmtList.do";
    }
    
    @RequestMapping("/jnitboardcmt/deleteJnitboardcmt.do")
    public String deleteJnitboardcmt(
            JnitboardcmtVO jnitboardcmtVO,
            @ModelAttribute("searchVO") JnitboardcmtDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitboardcmtService.deleteJnitboardcmt(jnitboardcmtVO);
        status.setComplete();
        return "forward:/jnitboardcmt/JnitboardcmtList.do";
    }

}
