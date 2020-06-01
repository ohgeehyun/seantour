/**
 * @version 3.2.0.1
 */
package jnit.board.good;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import net.sf.json.JSONObject;

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

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitboardgoodController.java
 * @Description : Jnitboardgood Controller class
 * @Modification Information
 *
 * @author JNITBOARADGOOD
 * @since 2013.11.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitboardgoodVO.class)
public class JnitboardgoodController {

    @Resource(name = "jnitboardgoodService")
    private JnitboardgoodService jnitboardgoodService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    @RequestMapping("/jnitboard/good.do")
    public String addJnitboardgoodAjax(
            @ModelAttribute("searchVO") JnitboardgoodDefaultVO searchVO, Model model
            , HttpServletRequest request)
            throws Exception {
    		String boardId = NullUtil.nullString(request.getParameter("boardId"));
    		String boardCntId = NullUtil.nullString(request.getParameter("boardCntId"));
    		String ipaddr = request.getRemoteAddr();
    		JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
         	int join = 0;
         	JnitboardgoodVO jnitboardgoodVO = new JnitboardgoodVO();
         	jnitboardgoodVO.setBoardId(boardId);
         	jnitboardgoodVO.setBoardCntId(Integer.parseInt(boardCntId));
         	jnitboardgoodVO.setIpaddr(ipaddr);
         	searchVO.setSearchBoardId(boardId);
         	searchVO.setSearchBoardCntId(boardCntId);
         	
    		if(loginVO.getMbrId() == null){
         		searchVO.setSearchCondition("4");//로그인이 되어 있지 않은경우 IP체크
         		searchVO.setSearchKeyword(ipaddr);
        		join = jnitboardgoodService.selectJnitboardgoodListTotCnt(searchVO);
         	}else{
         		searchVO.setSearchCondition("3");//로그인 되어 있을 경우 ID 체크
         		jnitboardgoodVO.setMbrId(loginVO.getMbrId());
         		searchVO.setSearchKeyword(loginVO.getMbrId());
         		
         		join = jnitboardgoodService.selectJnitboardgoodListTotCnt(searchVO);
         	}
    		
    		JSONObject jsonObjSet = new JSONObject();
    		jsonObjSet.put("join",false);
    		
    		if(join > 0){
    			jsonObjSet.put("join",true);
    		}else{
    			jnitboardgoodService.insertJnitboardgood(jnitboardgoodVO);
    		}
    		
         	
    		searchVO.setSearchCondition("2");
    		int totCnt = jnitboardgoodService.selectJnitboardgoodListTotCnt(searchVO);
	    	
			jsonObjSet.put("totCnt",totCnt);
			model.addAttribute("json",jsonObjSet);
    		
        return "/jnit/util/json";
    }
    
    
    
    
    /**
	 * jnitboardgood 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitboardgoodDefaultVO
	 * @return "/jnit/tpl-temp/jnitboardgood/JnitboardgoodList"
	 * @exception Exception
	 */
    @RequestMapping(value="/jnitboardgood/JnitboardgoodList.do")
    public String selectJnitboardgoodList(@ModelAttribute("searchVO") JnitboardgoodDefaultVO searchVO, 
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
		
        List jnitboardgoodList = jnitboardgoodService.selectJnitboardgoodList(searchVO);
        model.addAttribute("resultList", jnitboardgoodList);
        
        int totCnt = jnitboardgoodService.selectJnitboardgoodListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/tpl-temp/jnitboardgood/JnitboardgoodList";
    } 
    
    @RequestMapping("/jnitboardgood/addJnitboardgoodView.do")
    public String addJnitboardgoodView(
            @ModelAttribute("searchVO") JnitboardgoodDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitboardgoodService.getLastIdJnitboardgood());
        model.addAttribute("jnitboardgoodVO", new JnitboardgoodVO());
        return "/jnit/tpl-temp/jnitboardgood/JnitboardgoodRegister";
    }
    
    @RequestMapping("/jnitboardgood/addJnitboardgood.do")
    public String addJnitboardgood(
            @ModelAttribute("searchVO") JnitboardgoodDefaultVO searchVO,
	    @ModelAttribute("jnitboardgoodVO") JnitboardgoodVO jnitboardgoodVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitboardgoodVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitboardgood/JnitboardgoodRegister";
	// }

        jnitboardgoodService.insertJnitboardgood(jnitboardgoodVO);
        status.setComplete();
        return "forward:/jnitboardgood/JnitboardgoodList.do";
    }
    
    @RequestMapping("/jnitboardgood/updateJnitboardgoodView.do")
    public String updateJnitboardgoodView(
            @RequestParam("idx") java.lang.String idx ,
            @ModelAttribute("searchVO") JnitboardgoodDefaultVO searchVO, Model model)
            throws Exception {
        JnitboardgoodVO jnitboardgoodVO = new JnitboardgoodVO();
        jnitboardgoodVO.setIdx(idx);        
        // 변수명은 CoC 에 따라 jnitboardgoodVO
        model.addAttribute(selectJnitboardgood(jnitboardgoodVO, searchVO));
        return "/jnit/tpl-temp/jnitboardgood/JnitboardgoodRegister";
    }

    @RequestMapping("/jnitboardgood/selectJnitboardgood.do")
    public @ModelAttribute("jnitboardgoodVO")
    JnitboardgoodVO selectJnitboardgood(
            JnitboardgoodVO jnitboardgoodVO,
            @ModelAttribute("searchVO") JnitboardgoodDefaultVO searchVO) throws Exception {
        return jnitboardgoodService.selectJnitboardgood(jnitboardgoodVO);
    }

    @RequestMapping("/jnitboardgood/updateJnitboardgood.do")
    public String updateJnitboardgood(
            @ModelAttribute("searchVO") JnitboardgoodDefaultVO searchVO,
	    @ModelAttribute("jnitboardgoodVO") JnitboardgoodVO jnitboardgoodVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitboardgoodVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitboardgood/JnitboardgoodRegister";
	// }

        jnitboardgoodService.updateJnitboardgood(jnitboardgoodVO);
        status.setComplete();
        return "forward:/jnitboardgood/JnitboardgoodList.do";
    }
    
    @RequestMapping("/jnitboardgood/deleteJnitboardgood.do")
    public String deleteJnitboardgood(
            JnitboardgoodVO jnitboardgoodVO,
            @ModelAttribute("searchVO") JnitboardgoodDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitboardgoodService.deleteJnitboardgood(jnitboardgoodVO);
        status.setComplete();
        return "forward:/jnitboardgood/JnitboardgoodList.do";
    }

}
