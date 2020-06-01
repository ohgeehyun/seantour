/**
 * @version 3.2.0.1
 */
package jnit.ebook.file;

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
 * @Class Name : JnitebookfileController.java
 * @Description : Jnitebookfile Controller class
 * @Modification Information
 *
 * @author JNITEBOOKFILE
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitebookfileVO.class)
public class JnitebookfileController {

    @Resource(name = "jnitebookfileService")
    private JnitebookfileService jnitebookfileService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * JNITEBOOKFILE 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitebookfileDefaultVO
	 * @return "/jnit/ebook/jnitebookfile/JnitebookfileList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/ebook/file/list.do")
    public String selectJnitebookfileList(@ModelAttribute("searchVO") JnitebookfileDefaultVO searchVO, 
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
		
        List jnitebookfileList = jnitebookfileService.selectJnitebookfileList(searchVO);
        model.addAttribute("resultList", jnitebookfileList);
        
        int totCnt = jnitebookfileService.selectJnitebookfileListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/ebook/file/fileList";
    } 
    
    @RequestMapping("/cms/ebook/file/add.do")
    public String addJnitebookfileView(
            @ModelAttribute("searchVO") JnitebookfileDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitebookfileService.getLastIdJnitebookfile());
        model.addAttribute("jnitebookfileVO", new JnitebookfileVO());
        return "/jnit/ebook/file/fileEdit";
    }
    
    @RequestMapping("/cms/ebook/file/addProc.do")
    public String addJnitebookfile(
            @ModelAttribute("searchVO") JnitebookfileDefaultVO searchVO,
	    @ModelAttribute("jnitebookfileVO") JnitebookfileVO jnitebookfileVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitebookfileVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/ebook/jnitebookfile/JnitebookfileRegister";
	// }

        jnitebookfileService.insertJnitebookfile(jnitebookfileVO);
        status.setComplete();
        return "forward:/cms/ebook/file/list.do";
    }
    
    @RequestMapping("/cms/ebook/file/edit.do")
    public String updateJnitebookfileView(
            @RequestParam("fileId") java.lang.String fileId ,
            @ModelAttribute("searchVO") JnitebookfileDefaultVO searchVO, Model model)
            throws Exception {
        JnitebookfileVO jnitebookfileVO = new JnitebookfileVO();
        jnitebookfileVO.setFileId(fileId);
        // 변수명은 CoC 에 따라 jnitebookfileVO
        model.addAttribute(selectJnitebookfile(jnitebookfileVO, searchVO));
        return "/jnit/ebook/file/fileEdit";
    }

    @RequestMapping("/jnitebookfile/selectJnitebookfile.do")
    public @ModelAttribute("jnitebookfileVO")
    JnitebookfileVO selectJnitebookfile(
            JnitebookfileVO jnitebookfileVO,
            @ModelAttribute("searchVO") JnitebookfileDefaultVO searchVO) throws Exception {
        return jnitebookfileService.selectJnitebookfile(jnitebookfileVO);
    }

    @RequestMapping("/cms/ebook/file/editProc.do")
    public String updateJnitebookfile(
            @ModelAttribute("searchVO") JnitebookfileDefaultVO searchVO,
	    @ModelAttribute("jnitebookfileVO") JnitebookfileVO jnitebookfileVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitebookfileVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/ebook/jnitebookfile/JnitebookfileRegister";
	// }

        jnitebookfileService.updateJnitebookfile(jnitebookfileVO);
        status.setComplete();
        return "forward:/cms/ebook/file/list.do";
    }
    
    @RequestMapping("/ebook/file/delete.do")
    public String deleteJnitebookfile(
            JnitebookfileVO jnitebookfileVO,
            @ModelAttribute("searchVO") JnitebookfileDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitebookfileService.deleteJnitebookfile(jnitebookfileVO);
        status.setComplete();
        return "forward:/cms/ebook/file/list.do";
    }

}
