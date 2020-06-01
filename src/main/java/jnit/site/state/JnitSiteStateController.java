/**
 * @version 3.2.0.1
 */
package jnit.site.state;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : JnitsitestatelistController.java
 * @Description : Jnitsitestatelist Controller class
 * @Modification Information
 *
 * @author JNITSITESTATE
 * @since 2014.07.10
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitSiteStateVO.class)
public class JnitSiteStateController {

    @Resource(name = "jnitSiteStateService")
    private JnitSiteStateService jnitSiteStateService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator 
     * @throws Exception */
    
    //@Autowired
    //private DefaultBeanValidator beanValidator;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /**
	 * JNITSITESTATELIST 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitsitestatelistDefaultVO
	 * @return "/jnit/tpl-temp/jnitsitestatelist/JnitsitestatelistList"
	 * @exception Exception
	 */
    
    /*
    @RequestMapping(value="/jnitsitestatelist/JnitsitestatelistList.do")
    public String selectJnitsitestatelistList(@ModelAttribute("searchVO") JnitSiteStateDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List jnitsitestatelistList = jnitSiteStateService.selectJnitsitestatelistList(searchVO);
        model.addAttribute("resultList", jnitsitestatelistList);
        
        int totCnt = jnitSiteStateService.selectJnitsitestatelistListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/tpl-temp/jnitsitestatelist/JnitsitestatelistList";
    } 
    
    @RequestMapping("/jnitsitestatelist/addJnitsitestatelistView.do")
    public String addJnitsitestatelistView(
            @ModelAttribute("searchVO") JnitSiteStateDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitSiteStateService.getLastIdJnitsitestatelist());
        model.addAttribute("jnitsitestatelistVO", new JnitsitestatelistVO());
        return "/jnit/tpl-temp/jnitsitestatelist/JnitsitestatelistRegister";
    }
    
    @RequestMapping("/jnitsitestatelist/addJnitsitestatelist.do")
    public String addJnitsitestatelist(
            @ModelAttribute("searchVO") JnitSiteStateDefaultVO searchVO,
	    @ModelAttribute("jnitsitestatelistVO") JnitsitestatelistVO jnitsitestatelistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitsitestatelistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitsitestatelist/JnitsitestatelistRegister";
	// }

        jnitSiteStateService.insertJnitsitestatelist(jnitsitestatelistVO);
        status.setComplete();
        return "forward:/jnitsitestatelist/JnitsitestatelistList.do";
    }
    
    @RequestMapping("/jnitsitestatelist/updateJnitsitestatelistView.do")
    public String updateJnitsitestatelistView(
            @RequestParam("whenDate") java.lang.String whenDate ,
            @ModelAttribute("searchVO") JnitSiteStateDefaultVO searchVO, Model model)
            throws Exception {
        JnitsitestatelistVO jnitsitestatelistVO = new JnitsitestatelistVO();
        jnitsitestatelistVO.setWhenDate(whenDate);        
        // 변수명은 CoC 에 따라 jnitsitestatelistVO
        model.addAttribute(selectJnitsitestatelist(jnitsitestatelistVO, searchVO));
        return "/jnit/tpl-temp/jnitsitestatelist/JnitsitestatelistRegister";
    }

    @RequestMapping("/jnitsitestatelist/selectJnitsitestatelist.do")
    public @ModelAttribute("jnitsitestatelistVO")
    JnitsitestatelistVO selectJnitsitestatelist(
            JnitsitestatelistVO jnitsitestatelistVO,
            @ModelAttribute("searchVO") JnitSiteStateDefaultVO searchVO) throws Exception {
        return jnitSiteStateService.selectJnitsitestatelist(jnitsitestatelistVO);
    }

    @RequestMapping("/jnitsitestatelist/updateJnitsitestatelist.do")
    public String updateJnitsitestatelist(
            @ModelAttribute("searchVO") JnitSiteStateDefaultVO searchVO,
	    @ModelAttribute("jnitsitestatelistVO") JnitsitestatelistVO jnitsitestatelistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitsitestatelistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitsitestatelist/JnitsitestatelistRegister";
	// }

        jnitSiteStateService.updateJnitsitestatelist(jnitsitestatelistVO);
        status.setComplete();
        return "forward:/jnitsitestatelist/JnitsitestatelistList.do";
    }
    
    @RequestMapping("/jnitsitestatelist/deleteJnitsitestatelist.do")
    public String deleteJnitsitestatelist(
            JnitsitestatelistVO jnitsitestatelistVO,
            @ModelAttribute("searchVO") JnitSiteStateDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitSiteStateService.deleteJnitsitestatelist(jnitsitestatelistVO);
        status.setComplete();
        return "forward:/jnitsitestatelist/JnitsitestatelistList.do";
    }
     */
}
