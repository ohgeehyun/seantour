/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtcategory;

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
 * @Class Name : JnitcmsmgmtcategoryController.java
 * @Description : Jnitcmsmgmtcategory Controller class
 * @Modification Information
 *
 * @author JNITCMSMGMTCATEGORY
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsmgmtcategoryVO.class)
public class JnitcmsmgmtcategoryController {

    @Resource(name = "jnitcmsmgmtcategoryService")
    private JnitcmsmgmtcategoryService jnitcmsmgmtcategoryService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * JNITCMSMGMTCATEGORY 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsmgmtcategoryDefaultVO
	 * @return "/jnit/cms/mgmt/category/jnitcmsmgmtcategory/JnitcmsmgmtcategoryList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/mgmt/category/list.do")
    public String selectJnitcmsmgmtcategoryList(@ModelAttribute("searchVO") JnitcmsmgmtcategoryDefaultVO searchVO, 
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
		
        List jnitcmsmgmtcategoryList = jnitcmsmgmtcategoryService.selectJnitcmsmgmtcategoryList(searchVO);
        model.addAttribute("resultList", jnitcmsmgmtcategoryList);
        
        int totCnt = jnitcmsmgmtcategoryService.selectJnitcmsmgmtcategoryListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/mgmt/category/categoryList";
    } 
    
    @RequestMapping("/cms/mgmt/category/add.do")
    public String addJnitcmsmgmtcategoryView(
            @ModelAttribute("searchVO") JnitcmsmgmtcategoryDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmsmgmtcategoryService.getLastIdJnitcmsmgmtcategory());
        model.addAttribute("jnitcmsmgmtcategoryVO", new JnitcmsmgmtcategoryVO());
        return "/jnit/cms/mgmt/category/categoryEdit";
    }
    
    @RequestMapping("/cms/mgmt/category/addProc.do")
    public String addJnitcmsmgmtcategory(
            @ModelAttribute("searchVO") JnitcmsmgmtcategoryDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmgmtcategoryVO") JnitcmsmgmtcategoryVO jnitcmsmgmtcategoryVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsmgmtcategoryVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/mgmt/category/JnitcmsmgmtcategoryRegister";
	// }

        jnitcmsmgmtcategoryService.insertJnitcmsmgmtcategory(jnitcmsmgmtcategoryVO);
        status.setComplete();
        return "forward:/cms/mgmt/category/list.do";
    }
    
    @RequestMapping("/cms/mgmt/category/edit.do")
    public String updateJnitcmsmgmtcategoryView(
            @RequestParam("mgmtCategoryId") java.lang.String mgmtCategoryId ,
            @ModelAttribute("searchVO") JnitcmsmgmtcategoryDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmsmgmtcategoryVO jnitcmsmgmtcategoryVO = new JnitcmsmgmtcategoryVO();
        jnitcmsmgmtcategoryVO.setMgmtCategoryId(mgmtCategoryId);
        // 변수명은 CoC 에 따라 jnitcmsmgmtcategoryVO
        model.addAttribute(selectJnitcmsmgmtcategory(jnitcmsmgmtcategoryVO, searchVO));
        return "/jnit/cms/mgmt/category/categoryEdit";
    }

    @RequestMapping("/jnitcmsmgmtcategory/selectJnitcmsmgmtcategory.do")
    public @ModelAttribute("jnitcmsmgmtcategoryVO")
    JnitcmsmgmtcategoryVO selectJnitcmsmgmtcategory(
            JnitcmsmgmtcategoryVO jnitcmsmgmtcategoryVO,
            @ModelAttribute("searchVO") JnitcmsmgmtcategoryDefaultVO searchVO) throws Exception {
        return jnitcmsmgmtcategoryService.selectJnitcmsmgmtcategory(jnitcmsmgmtcategoryVO);
    }

    @RequestMapping("/cms/mgmt/category/editProc.do")
    public String updateJnitcmsmgmtcategory(
            @ModelAttribute("searchVO") JnitcmsmgmtcategoryDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmgmtcategoryVO") JnitcmsmgmtcategoryVO jnitcmsmgmtcategoryVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsmgmtcategoryVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/mgmt/category/JnitcmsmgmtcategoryRegister";
	// }

        jnitcmsmgmtcategoryService.updateJnitcmsmgmtcategory(jnitcmsmgmtcategoryVO);
        status.setComplete();
        return "forward:/cms/mgmt/category/list.do";
    }
    
    @RequestMapping("/mgmt/category/deleteProc.do")
    public String deleteJnitcmsmgmtcategory(
            JnitcmsmgmtcategoryVO jnitcmsmgmtcategoryVO,
            @ModelAttribute("searchVO") JnitcmsmgmtcategoryDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsmgmtcategoryService.deleteJnitcmsmgmtcategory(jnitcmsmgmtcategoryVO);
        status.setComplete();
        return "forward:/cms/mgmt/category/list.do";
    }

}
