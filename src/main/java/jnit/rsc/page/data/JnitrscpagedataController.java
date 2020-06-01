/**
 * @version 3.2.0.1
 */
package jnit.rsc.page.data;

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
 * @Class Name : JnitrscpagedataController.java
 * @Description : Jnitrscpagedata Controller class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitrscpagedataVO.class)
public class JnitrscpagedataController {

    @Resource(name = "jnitrscpagedataService")
    private JnitrscpagedataService jnitrscpagedataService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitrscpagedata 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitrscpagedataDefaultVO
	 * @return "/jnit/tpl-temp/jnitrscpagedata/JnitrscpagedataList"
	 * @exception Exception
	 */
    @RequestMapping(value="/jnitrscpagedata/JnitrscpagedataList.do")
    public String selectJnitrscpagedataList(@ModelAttribute("searchVO") JnitrscpagedataDefaultVO searchVO, 
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
		
        List jnitrscpagedataList = jnitrscpagedataService.selectJnitrscpagedataList(searchVO);
        model.addAttribute("resultList", jnitrscpagedataList);
        
        int totCnt = jnitrscpagedataService.selectJnitrscpagedataListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/tpl-temp/jnitrscpagedata/JnitrscpagedataList";
    } 
    
    @RequestMapping("/jnitrscpagedata/addJnitrscpagedataView.do")
    public String addJnitrscpagedataView(
            @ModelAttribute("searchVO") JnitrscpagedataDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitrscpagedataService.getLastIdJnitrscpagedata());
        model.addAttribute("jnitrscpagedataVO", new JnitrscpagedataVO());
        return "/jnit/tpl-temp/jnitrscpagedata/JnitrscpagedataRegister";
    }
    
    @RequestMapping("/jnitrscpagedata/addJnitrscpagedata.do")
    public String addJnitrscpagedata(
            @ModelAttribute("searchVO") JnitrscpagedataDefaultVO searchVO,
	    @ModelAttribute("jnitrscpagedataVO") JnitrscpagedataVO jnitrscpagedataVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitrscpagedataVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitrscpagedata/JnitrscpagedataRegister";
	// }

        jnitrscpagedataService.insertJnitrscpagedata(jnitrscpagedataVO);
        status.setComplete();
        return "forward:/jnitrscpagedata/JnitrscpagedataList.do";
    }
    
    @RequestMapping("/jnitrscpagedata/updateJnitrscpagedataView.do")
    public String updateJnitrscpagedataView(
            @RequestParam("pdataId") java.lang.String pdataId ,
            @ModelAttribute("searchVO") JnitrscpagedataDefaultVO searchVO, Model model)
            throws Exception {
        JnitrscpagedataVO jnitrscpagedataVO = new JnitrscpagedataVO();
        jnitrscpagedataVO.setPdataId(pdataId);        
        // 변수명은 CoC 에 따라 jnitrscpagedataVO
        model.addAttribute(selectJnitrscpagedata(jnitrscpagedataVO, searchVO));
        return "/jnit/tpl-temp/jnitrscpagedata/JnitrscpagedataRegister";
    }

    @RequestMapping("/jnitrscpagedata/selectJnitrscpagedata.do")
    public @ModelAttribute("jnitrscpagedataVO")
    JnitrscpagedataVO selectJnitrscpagedata(
            JnitrscpagedataVO jnitrscpagedataVO,
            @ModelAttribute("searchVO") JnitrscpagedataDefaultVO searchVO) throws Exception {
        return jnitrscpagedataService.selectJnitrscpagedata(jnitrscpagedataVO);
    }

    @RequestMapping("/jnitrscpagedata/updateJnitrscpagedata.do")
    public String updateJnitrscpagedata(
            @ModelAttribute("searchVO") JnitrscpagedataDefaultVO searchVO,
	    @ModelAttribute("jnitrscpagedataVO") JnitrscpagedataVO jnitrscpagedataVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitrscpagedataVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitrscpagedata/JnitrscpagedataRegister";
	// }

        jnitrscpagedataService.updateJnitrscpagedata(jnitrscpagedataVO);
        status.setComplete();
        return "forward:/jnitrscpagedata/JnitrscpagedataList.do";
    }
    
    @RequestMapping("/jnitrscpagedata/deleteJnitrscpagedata.do")
    public String deleteJnitrscpagedata(
            JnitrscpagedataVO jnitrscpagedataVO,
            @ModelAttribute("searchVO") JnitrscpagedataDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitrscpagedataService.deleteJnitrscpagedata(jnitrscpagedataVO);
        status.setComplete();
        return "forward:/jnitrscpagedata/JnitrscpagedataList.do";
    }

}
