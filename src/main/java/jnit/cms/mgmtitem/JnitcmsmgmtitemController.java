/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtitem;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mgmt.mgmtUtil;
import jnit.cms.mgmtcategory.JnitcmsmgmtcategoryService;

/**
 * @Class Name : JnitcmsmgmtitemController.java
 * @Description : Jnitcmsmgmtitem Controller class
 * @Modification Information
 *
 * @author JNITCMSMGMTITEM
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsmgmtitemVO.class)
public class JnitcmsmgmtitemController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmsmgmtitemService")
    private JnitcmsmgmtitemService jnitcmsmgmtitemService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "jnitcmsmgmtcategoryService")
    private JnitcmsmgmtcategoryService jnitcmsmgmtcategoryService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /**
	 * JNITCMSMGMTITEM 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsmgmtitemDefaultVO
	 * @return "/jnit/cms/mgmt/category/itemjnitcmsmgmtitem/JnitcmsmgmtitemList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/mgmt/item/list.do")
    public String selectJnitcmsmgmtitemList(@ModelAttribute("searchVO") JnitcmsmgmtitemDefaultVO searchVO,    		
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	
    	//AdminUtil
    	model.addAllAttributes(AdminJSON(request, model));
    	
    	String siteId = NullUtil.nullString(CmsHelper.getSessionSiteId(request));
    	if("".equals(siteId)){
    		return "/jnit/cms/mgmt/nosite";
    	}    	
		searchVO.setMgmtCategoryId(mgmtUtil.selectJnitcmsmgmtCatetoryId(request, siteId));
		
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
		
        List jnitcmsmgmtitemList = jnitcmsmgmtitemService.selectJnitcmsmgmtitemList(searchVO);
        
        int totCnt = jnitcmsmgmtitemService.selectJnitcmsmgmtitemListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);		
		
		model.addAttribute("resultList", jnitcmsmgmtitemList);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/mgmt/category/item/itemList";
    } 
    
    @RequestMapping("/cms/mgmt/item/add.do")
    public String addJnitcmsmgmtitemView(
            @ModelAttribute("searchVO") JnitcmsmgmtitemDefaultVO searchVO
            , HttpServletRequest request
            , ModelMap model)
            throws Exception {
    	//AdminUtil
    	model.addAllAttributes(AdminJSON(request, model));
    	String siteId = CmsHelper.getSessionSiteId(request);
    	
    	JnitcmsmgmtitemVO jnitcmsmgmtitemVO =  new JnitcmsmgmtitemVO();
    	jnitcmsmgmtitemVO.setMgmtCategoryId(mgmtUtil.selectJnitcmsmgmtCatetoryId(request, siteId));
    	
    	model.addAllAttributes(maxCategorySort(request, model, siteId));
        model.addAttribute("nid",  jnitcmsmgmtitemService.getLastIdJnitcmsmgmtitem());
        model.addAttribute("jnitcmsmgmtitemVO", jnitcmsmgmtitemVO);
        return "/jnit/cms/mgmt/category/item/itemEdit";
    }
    
    @RequestMapping("/cms/mgmt/item/addProc.do")
    public String addJnitcmsmgmtitem(
            @ModelAttribute("searchVO") JnitcmsmgmtitemDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmgmtitemVO") JnitcmsmgmtitemVO jnitcmsmgmtitemVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsmgmtitemVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/mgmt/category/itemjnitcmsmgmtitem/JnitcmsmgmtitemRegister";
	// }

        jnitcmsmgmtitemService.insertJnitcmsmgmtitem(jnitcmsmgmtitemVO);
        status.setComplete();
        return "redirect:/cms/mgmt/item/list.do";
    }
    
    @RequestMapping("/cms/mgmt/item/eidt.do")
    public String updateJnitcmsmgmtitemView(
            @RequestParam("categoryId") java.lang.String categoryId ,
            @ModelAttribute("searchVO") JnitcmsmgmtitemDefaultVO searchVO
            , HttpServletRequest request
            , ModelMap model)
            throws Exception {
    	//AdminUtil
    	model.addAllAttributes(AdminJSON(request, model));
    	
        JnitcmsmgmtitemVO jnitcmsmgmtitemVO = new JnitcmsmgmtitemVO();
        jnitcmsmgmtitemVO.setCategoryId(categoryId);
        // 변수명은 CoC 에 따라 jnitcmsmgmtitemVO
        model.addAttribute(selectJnitcmsmgmtitem(jnitcmsmgmtitemVO, searchVO));      
        return "/jnit/cms/mgmt/category/item/itemEdit";
    }

    @RequestMapping("/jnitcmsmgmtitem/selectJnitcmsmgmtitem.do")
    public @ModelAttribute("jnitcmsmgmtitemVO")
    JnitcmsmgmtitemVO selectJnitcmsmgmtitem(
            JnitcmsmgmtitemVO jnitcmsmgmtitemVO,
            @ModelAttribute("searchVO") JnitcmsmgmtitemDefaultVO searchVO) throws Exception {
        return jnitcmsmgmtitemService.selectJnitcmsmgmtitem(jnitcmsmgmtitemVO);
    }

    @RequestMapping("/cms/mgmt/item/editProc.do")
    public String updateJnitcmsmgmtitem(
            @ModelAttribute("searchVO") JnitcmsmgmtitemDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmgmtitemVO") JnitcmsmgmtitemVO jnitcmsmgmtitemVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsmgmtitemVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/mgmt/category/itemjnitcmsmgmtitem/JnitcmsmgmtitemRegister";
	// }

        jnitcmsmgmtitemService.updateJnitcmsmgmtitem(jnitcmsmgmtitemVO);
        status.setComplete();
        return "redirect:/cms/mgmt/item/list.do";
    }
    
    @RequestMapping("/mgmt/item/deleteProc.do")
    public String deleteJnitcmsmgmtitem(
            JnitcmsmgmtitemVO jnitcmsmgmtitemVO,
            @ModelAttribute("searchVO") JnitcmsmgmtitemDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsmgmtitemService.deleteJnitcmsmgmtitem(jnitcmsmgmtitemVO);
        status.setComplete();
        return "redirect:/cms/mgmt/item/list.do";
    }
    
    private ModelMap AdminJSON(HttpServletRequest request, ModelMap model)throws Exception{
    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));
    	if("css".equals(mgmtType)){
    		AdminUtil.setMenuId("m02050200");
    	}else if("js".equals(mgmtType)){
    		AdminUtil.setMenuId("m02060200");
    	}
    	model.addAttribute("mgmtType", mgmtType);
    	return model;
    }
    
    /**
     * 정렬순서 최고값을 제어한다.
     * @param model
     * @return maxCategorySort
     * @throws Exception
     */
    private ModelMap maxCategorySort(HttpServletRequest request, ModelMap model, String siteId)throws Exception{
    	JnitcmsmgmtitemDefaultVO itemVO = new JnitcmsmgmtitemDefaultVO();
    	itemVO.setCountCondition("1");
    	itemVO.setMgmtCategoryId(mgmtUtil.selectJnitcmsmgmtCatetoryId(request, siteId));
    	int maxCategorySort = 0;    	
    	try {
    		maxCategorySort = jnitcmsmgmtitemService.selectJnitcmsmgmtitemListTotCnt(itemVO)+1;
    	} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
    	model.addAttribute("maxCategorySort", maxCategorySort);
    	return model;
    }
}
