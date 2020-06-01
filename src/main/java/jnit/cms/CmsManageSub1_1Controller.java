/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.util.List;

import javax.annotation.Resource;

import jnit.cms.pos.JnitcmsposDefaultVO;
import jnit.cms.pos.JnitcmsposService;
import jnit.cms.pos.JnitcmsposVO;

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

@Controller
@SessionAttributes(types=JnitcmsposVO.class)
public class CmsManageSub1_1Controller {
    @Resource(name = "jnitcmsposService")
    private JnitcmsposService jnitcmsposService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    @Autowired
	private DefaultBeanValidator beanValidator;
    
    /**
	 * JNITCMSPOS 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsposDefaultVO
	 * @return "/jnitcmspos/JnitcmsposList"
	 * @exception Exception
	 */

	// 직급관리 > 직급리스트    
    @RequestMapping("/cms/sub1/0101.do")
    public String cmsManageSub1_0101(@ModelAttribute("searchVO") JnitcmsposDefaultVO searchVO, 
    		ModelMap model)
    		throws Exception {
    	AdminUtil.setMenuId("m02010100");
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
		
        List jnitcmsposList = jnitcmsposService.selectJnitcmsposList(searchVO);
        model.addAttribute("resultList", jnitcmsposList);
        
        int totCnt = jnitcmsposService.selectJnitcmsposListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
		
        return "jnit/cms/sub1_1-1";
    }
	
    // 직급관리 > 직급등록 > 등록폼
    @RequestMapping("/cms/sub1/0102.do")
    public String cmsManageSub1_0102(
            @ModelAttribute("searchVO") JnitcmsposDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02010100");
    	model.addAttribute("nid", jnitcmsposService.getNextIdJnitcmspos());
        model.addAttribute("jnitcmsposVO", new JnitcmsposVO());

        return "jnit/cms/sub1_1-2";
    }
    
    // 직급관리 > 직급등록 > 보기 & 수정폼
    @RequestMapping("/cms/sub1/0102up.do")
    public String cmsManageSub1_0102up(
            @RequestParam("posId") java.lang.String posId ,
            @ModelAttribute("searchVO") JnitcmsposDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02010100");
        JnitcmsposVO jnitcmsposVO = new JnitcmsposVO();
        jnitcmsposVO.setPosId(posId);        
        // 변수명은 CoC 에 따라 jnitcmsposVO
        model.addAttribute(cmsManageSub1_0101once(jnitcmsposVO, searchVO));
        return "jnit/cms/sub1_1-2";
    }
    
    // 직급관리 > 1건 조회
    @RequestMapping("/cms/sub1/0101once.do")
    public @ModelAttribute("jnitcmsposVO")
    JnitcmsposVO cmsManageSub1_0101once(
            JnitcmsposVO jnitcmsposVO,
            @ModelAttribute("searchVO") JnitcmsposDefaultVO searchVO) throws Exception {
        return jnitcmsposService.selectJnitcmspos(jnitcmsposVO);
    }
    
    // 직급관리 > 수정저장
    @RequestMapping("/cms/sub1/0102upexe.do")
    public String cmsManageSub1_0102upexe(
            @ModelAttribute("searchVO") JnitcmsposDefaultVO searchVO,
            @ModelAttribute("jnitcmsposVO") JnitcmsposVO jnitcmsposVO,
            BindingResult bindingResult,
            SessionStatus status)
            throws Exception {
    	
    	beanValidator.validate(jnitcmsposVO, bindingResult); //validation 수행
		if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
			return "jnit/cms/sub1_1-2";
		}
		
        jnitcmsposService.updateJnitcmspos(jnitcmsposVO);
        status.setComplete();
        return "redirect:/cms/sub1/0101.do";
    }
    
    // 직급관리 > 직급등록 > 저장
    @RequestMapping("/cms/sub1/0102add.do")
    public String cmsManageSub1_0102add(
            @ModelAttribute("searchVO") JnitcmsposDefaultVO searchVO,
            @ModelAttribute("jnitcmsposVO") JnitcmsposVO jnitcmsposVO,
            BindingResult bindingResult,
            SessionStatus status)
            throws Exception {
    	
    	beanValidator.validate(jnitcmsposVO, bindingResult); //validation 수행
		if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
			return "jnit/cms/sub1_1-2";
		}
		
        jnitcmsposService.insertJnitcmspos(jnitcmsposVO);
        status.setComplete();
        return "redirect:/cms/sub1/0101.do";
    }
}