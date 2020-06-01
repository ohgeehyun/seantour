/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.util.List;

import javax.annotation.Resource;

import jnit.cms.org.JnitcmsorgDefaultVO;
import jnit.cms.org.JnitcmsorgService;
import jnit.cms.org.JnitcmsorgVO;

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
@SessionAttributes(types=JnitcmsorgVO.class)
public class CmsManageSub1_2Controller {
	
    @Resource(name = "jnitcmsorgService")
    private JnitcmsorgService jnitcmsorgService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    @Autowired
	private DefaultBeanValidator beanValidator;

    // 부서관리 > 부서리스트
    @RequestMapping("/cms/sub1/0201.do")
    public String cmsManageSub1_0201(@ModelAttribute("searchVO") JnitcmsorgDefaultVO searchVO, 
    		ModelMap model)
		    throws Exception {
    	AdminUtil.setMenuId("m02010200");
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
		
		List jnitcmsorgList = jnitcmsorgService.selectJnitcmsorgList(searchVO);
		model.addAttribute("resultList", jnitcmsorgList);
		
		int totCnt = jnitcmsorgService.selectJnitcmsorgListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "jnit/cms/sub1_2-1";
    }
    
    // 부서관리 > 부서등록
    @RequestMapping("/cms/sub1/0202.do")
    public String cmsManageSub1_0202(
            @ModelAttribute("searchVO") JnitcmsorgDefaultVO searchVO, Model model)
		    throws Exception {
    	AdminUtil.setMenuId("m02010200");
		model.addAttribute("nid",  jnitcmsorgService.getLastIdJnitcmsorg());
		model.addAttribute("jnitcmsorgVO", new JnitcmsorgVO());
		
		return "jnit/cms/sub1_2-2";
    }
    
    @RequestMapping("/cms/sub1/0202add.do")
    public String addJnitcmsorg(
            @ModelAttribute("searchVO") JnitcmsorgDefaultVO searchVO,
            @ModelAttribute("jnitcmsorgVO") JnitcmsorgVO jnitcmsorgVO,
            BindingResult bindingResult,
            SessionStatus status)
            throws Exception {
    	
    	beanValidator.validate(jnitcmsorgVO, bindingResult); //validation 수행
		if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
			return "jnit/cms/sub1_2-2";
		}
		
        jnitcmsorgService.insertJnitcmsorg(jnitcmsorgVO);
        status.setComplete();
        return "redirect:/cms/sub1/0201.do";
    }
    
    @RequestMapping("/cms/sub1/0202upview.do")
    public String updateJnitcmsorgView(
            @RequestParam("orgId") java.lang.String orgId ,
            @ModelAttribute("searchVO") JnitcmsorgDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02010200");
        JnitcmsorgVO jnitcmsorgVO = new JnitcmsorgVO();
        jnitcmsorgVO.setOrgId(orgId);
        // 변수명은 CoC 에 따라 jnitcmsorgVO
        model.addAttribute(selectJnitcmsorg(jnitcmsorgVO, searchVO));
        
        return "jnit/cms/sub1_2-2";
    }

    @RequestMapping("/cms/sub1/0202view.do")
    public @ModelAttribute("jnitcmsorgVO")
    JnitcmsorgVO selectJnitcmsorg(
            JnitcmsorgVO jnitcmsorgVO,
            @ModelAttribute("searchVO") JnitcmsorgDefaultVO searchVO) throws Exception {
        return jnitcmsorgService.selectJnitcmsorg(jnitcmsorgVO);
    }

    @RequestMapping("/cms/sub1/0202up.do")
    public String updateJnitcmsorg(
            @ModelAttribute("searchVO") JnitcmsorgDefaultVO searchVO,
            @ModelAttribute("jnitcmsorgVO") JnitcmsorgVO jnitcmsorgVO,
            BindingResult bindingResult,
            SessionStatus status)
            throws Exception {
    	
    	beanValidator.validate(jnitcmsorgVO, bindingResult); //validation 수행
		if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
			return "jnit/cms/sub1_2-2";
		}
		
        jnitcmsorgService.updateJnitcmsorg(jnitcmsorgVO);
        status.setComplete();
        return "redirect:/cms/sub1/0201.do";
    }
    
    @RequestMapping("/cms/sub1/0202del.do")
    public String deleteJnitcmsorg(
            JnitcmsorgVO jnitcmsorgVO,
            @ModelAttribute("searchVO") JnitcmsorgDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsorgService.deleteJnitcmsorg(jnitcmsorgVO);
        status.setComplete();
        return "forward:/cms/sub1/0201.do";
    }

}