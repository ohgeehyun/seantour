/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrlog;

import java.util.List;

import javax.annotation.Resource;

import jnit.cms.AdminUtil;
import jnit.com.util.DBType;

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
 * @Class Name : JnitcmsmbrlogController.java
 * @Description : Jnitcmsmbrlog Controller class
 * @Modification Information
 *
 * @author JNITCMSMBRLOG
 * @since 2014.03.09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsmbrlogVO.class)
public class JnitcmsmbrlogController {

    @Resource(name = "jnitcmsmbrlogService")
    private JnitcmsmbrlogService jnitcmsmbrlogService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * JNITCMSMBRLOG 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsmbrlogDefaultVO
	 * @return "/jnit/cms/jnitcmsmbrlog/JnitcmsmbrlogList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/mbrlog/mbrlogList.do")
    public String selectJnitcmsmbrlogList(@ModelAttribute("searchVO") JnitcmsmbrlogDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m03020600");
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
		
		if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
			searchVO.setFormatCondition("1");
		}
        List jnitcmsmbrlogList = jnitcmsmbrlogService.selectJnitcmsmbrlogList(searchVO);
        model.addAttribute("resultList", jnitcmsmbrlogList);
        
        int totCnt = jnitcmsmbrlogService.selectJnitcmsmbrlogListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("DBType", DBType.getDbTypeString());
        
        return "/jnit/cms/mbrlog/mbrlogList";
    } 
    
    @RequestMapping("/cms/mbrlog/add.do")
    public String addJnitcmsmbrlogView(
            @ModelAttribute("searchVO") JnitcmsmbrlogDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmsmbrlogService.getLastIdJnitcmsmbrlog());
        model.addAttribute("jnitcmsmbrlogVO", new JnitcmsmbrlogVO());
        return "/jnit/cms/mbrlog/mbrlogEdit";
    }
    
    @RequestMapping("/cms/mbrlog/addProc.do")
    public String addJnitcmsmbrlog(
            @ModelAttribute("searchVO") JnitcmsmbrlogDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmbrlogVO") JnitcmsmbrlogVO jnitcmsmbrlogVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsmbrlogVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmsmbrlog/JnitcmsmbrlogRegister";
	// }

        jnitcmsmbrlogService.insertJnitcmsmbrlog(jnitcmsmbrlogVO);
        status.setComplete();
        return "forward:/cms/mbrlog/mbrlogList.do";
    }
    
    @RequestMapping("/cms/mbrlog/edit.do")
    public String updateJnitcmsmbrlogView(
            @RequestParam("mbrlogId") java.lang.String mbrlogId ,
            @ModelAttribute("searchVO") JnitcmsmbrlogDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmsmbrlogVO jnitcmsmbrlogVO = new JnitcmsmbrlogVO();
        jnitcmsmbrlogVO.setMbrlogId(mbrlogId);
        // 변수명은 CoC 에 따라 jnitcmsmbrlogVO
        model.addAttribute(selectJnitcmsmbrlog(jnitcmsmbrlogVO, searchVO));
        return "/jnit/cms/mbrlog/mbrlogEdit";
    }

    @RequestMapping("/jnitcmsmbrlog/selectJnitcmsmbrlog.do")
    public @ModelAttribute("jnitcmsmbrlogVO")
    JnitcmsmbrlogVO selectJnitcmsmbrlog(
            JnitcmsmbrlogVO jnitcmsmbrlogVO,
            @ModelAttribute("searchVO") JnitcmsmbrlogDefaultVO searchVO) throws Exception {
        return jnitcmsmbrlogService.selectJnitcmsmbrlog(jnitcmsmbrlogVO);
    }

    @RequestMapping("/cms/mbrlog/editProc.do")
    public String updateJnitcmsmbrlog(
            @ModelAttribute("searchVO") JnitcmsmbrlogDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmbrlogVO") JnitcmsmbrlogVO jnitcmsmbrlogVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsmbrlogVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmsmbrlog/JnitcmsmbrlogRegister";
	// }

        jnitcmsmbrlogService.updateJnitcmsmbrlog(jnitcmsmbrlogVO);
        status.setComplete();
        return "forward:/cms/mbrlog/mbrlogList.do";
    }
    
    @RequestMapping("/mbrlog/deleteProc.do")
    public String deleteJnitcmsmbrlog(
            JnitcmsmbrlogVO jnitcmsmbrlogVO,
            @ModelAttribute("searchVO") JnitcmsmbrlogDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsmbrlogService.deleteJnitcmsmbrlog(jnitcmsmbrlogVO);
        status.setComplete();
        return "forward:/cms/mbrlog/mbrlogList.do";
    }

}
