/**
 * @version 3.2.0.1
 */
/*package jnit.rscdata;

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

import jnit.rscdata.JnitrscdataService;
import jnit.rscdata.JnitrscdataDefaultVO;
import jnit.rscdata.JnitrscdataVO;

*//**
 * @Class Name : JnitrscdataController.java
 * @Description : Jnitrscdata Controller class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 *//*

@Controller
@SessionAttributes(types=JnitrscdataVO.class)
public class JnitrscdataController {

    @Resource(name = "jnitrscdataService")
    private JnitrscdataService jnitrscdataService;
    
    *//** EgovPropertyService *//*
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    *//** Validator *//*
    @Autowired
    private DefaultBeanValidator beanValidator;

    *//**
	 * JNITRSCDATA 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitrscdataDefaultVO
	 * @return "/jnit/tpl-temp/jnitrscdata/JnitrscdataList"
	 * @exception Exception
	 *//*
    @RequestMapping(value="/jnitrscdata/JnitrscdataList.do")
    public String selectJnitrscdataList(@ModelAttribute("searchVO") JnitrscdataDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	*//** EgovPropertyService.sample *//*
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	*//** pageing *//*
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List jnitrscdataList = jnitrscdataService.selectJnitrscdataList(searchVO);
        model.addAttribute("resultList", jnitrscdataList);
        
        int totCnt = jnitrscdataService.selectJnitrscdataListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/tpl-temp/jnitrscdata/JnitrscdataList";
    } 
    
    @RequestMapping("/jnitrscdata/addJnitrscdataView.do")
    public String addJnitrscdataView(
            @ModelAttribute("searchVO") JnitrscdataDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitrscdataService.getLastIdJnitrscdata());
        model.addAttribute("jnitrscdataVO", new JnitrscdataVO());
        return "/jnit/tpl-temp/jnitrscdata/JnitrscdataRegister";
    }
    
    @RequestMapping("/jnitrscdata/addJnitrscdata.do")
    public String addJnitrscdata(
            @ModelAttribute("searchVO") JnitrscdataDefaultVO searchVO,
	    @ModelAttribute("jnitrscdataVO") JnitrscdataVO jnitrscdataVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitrscdataVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitrscdata/JnitrscdataRegister";
	// }

        jnitrscdataService.insertJnitrscdata(jnitrscdataVO);
        status.setComplete();
        return "forward:/jnitrscdata/JnitrscdataList.do";
    }
    
    @RequestMapping("/jnitrscdata/updateJnitrscdataView.do")
    public String updateJnitrscdataView(
            @RequestParam("dataId") java.lang.String dataId ,
            @ModelAttribute("searchVO") JnitrscdataDefaultVO searchVO, Model model)
            throws Exception {
        JnitrscdataVO jnitrscdataVO = new JnitrscdataVO();
        jnitrscdataVO.setDataId(dataId);        
        // 변수명은 CoC 에 따라 jnitrscdataVO
        model.addAttribute(selectJnitrscdata(jnitrscdataVO, searchVO));
        return "/jnit/tpl-temp/jnitrscdata/JnitrscdataRegister";
    }

    @RequestMapping("/jnitrscdata/selectJnitrscdata.do")
    public @ModelAttribute("jnitrscdataVO")
    JnitrscdataVO selectJnitrscdata(
            JnitrscdataVO jnitrscdataVO,
            @ModelAttribute("searchVO") JnitrscdataDefaultVO searchVO) throws Exception {
        return jnitrscdataService.selectJnitrscdata(jnitrscdataVO);
    }

    @RequestMapping("/jnitrscdata/updateJnitrscdata.do")
    public String updateJnitrscdata(
            @ModelAttribute("searchVO") JnitrscdataDefaultVO searchVO,
	    @ModelAttribute("jnitrscdataVO") JnitrscdataVO jnitrscdataVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitrscdataVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitrscdata/JnitrscdataRegister";
	// }

        jnitrscdataService.updateJnitrscdata(jnitrscdataVO);
        status.setComplete();
        return "forward:/jnitrscdata/JnitrscdataList.do";
    }
    
    @RequestMapping("/jnitrscdata/deleteJnitrscdata.do")
    public String deleteJnitrscdata(
            JnitrscdataVO jnitrscdataVO,
            @ModelAttribute("searchVO") JnitrscdataDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitrscdataService.deleteJnitrscdata(jnitrscdataVO);
        status.setComplete();
        return "forward:/jnitrscdata/JnitrscdataList.do";
    }

}
*/