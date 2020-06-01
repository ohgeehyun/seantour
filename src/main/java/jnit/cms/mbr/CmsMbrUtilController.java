package jnit.cms.mbr;

import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jnit.cms.CmsHelper;
import jnit.cms.CmsOauthController;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbrsess.JnitcmsmbrsessService;
import jnit.cms.mbrsess.JnitcmsmbrsessVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;
import net.sf.json.JSONArray;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;


import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CmsMbrUtilController {
	private int limitSignupAge = 19;
	
    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
	@Resource(name = "jnitcmsmbrsessService")
	private JnitcmsmbrsessService jnitcmsmbrsessService;	 
    
	@Resource(name = "jnitcmsmbrtypeService")
	private JnitcmsmbrtypeService jnitcmsmbrtypeService;
	
    @RequestMapping("/cms/mbr/search.do")
    public String mbrSearchId(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	
    	String mbrNm = NullUtil.nullString(request.getParameter("mbrNm"));
    	String email = NullUtil.nullString(request.getParameter("email"));
    	    	
    	JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
    	searchVO.setSearchCondition("9");
    	searchVO.setPageUnit(100000);
    	searchVO.setPageSize(1);
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(1);
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	searchVO.setSchMbrNm(mbrNm);
    	searchVO.setSchEmail(email);
    	
    	List schResult = jnitcmsmbrService.selectJnitcmsmbrList(searchVO);
    	if(schResult.size() > 0) {
    		EgovMap mbrMap = (EgovMap)schResult.get(0);
    		model.addAttribute("success", "OK");
    		model.addAttribute("mbrMap", mbrMap);
    	}else {
    		model.addAttribute("success", "FAIL");
    	}

    	return "jnit/cms/mbr/search";
    }
    
    @RequestMapping("/cms/mbr/searchAjax.do")
    public String mbrSearchIdProc(
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	String schTypeId = NullUtil.nullString(request.getParameter("schTypeId"));
    	String searchCondition = NullUtil.nullString(request.getParameter("searchCondition"));
    	String searchKeyword = URLDecoder.decode(NullUtil.nullString(request.getParameter("searchKeyword")),"UTF-8");
    	    	
    	JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
    	if(!"".equals(schTypeId))searchVO.setSchTypeId(schTypeId);
    	searchVO.setSearchCondition(searchCondition);
    	searchVO.setSearchKeyword(searchKeyword);
    	searchVO.setPageUnit(100000);
    	searchVO.setPageSize(1);
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
    	paginationInfo.setCurrentPageNo(1);
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	List schResult = jnitcmsmbrService.selectJnitcmsmbrList(searchVO);
    	
    	JSONArray jsonArr = new JSONArray().fromObject(schResult);
    	
    	model.addAttribute("json",jsonArr);

    	return "jnit/util/json";
    }
    
   
    
	public String actionLogin(
			@ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO,
			HttpServletRequest request,
			HttpServletResponse response ,
			ModelMap model) throws Exception {

		// 1. 일반 로그인 처리
		JnitcmsmbrVO resVO = jnitcmsmbrService.exeLogin(request, jnitcmsmbrVO);
		// JnitcmsmbrVO resVO = new JnitcmsmbrVO();

        if (resVO != null && resVO.getMbrId() != null && !resVO.getMbrId().equals("")) {
        	
        	// 로그인 회원 등급 로딩
        	JnitcmsmbrtypeVO mbrtypeVO = new JnitcmsmbrtypeVO();
        	mbrtypeVO.setTypeId(resVO.getTypeId());
        	mbrtypeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(mbrtypeVO);
        	resVO.setTypeVO(mbrtypeVO);
        	request.getSession().setAttribute("loginVO", resVO);
        	
        	// 2-1. 로그인 정보를 세션에 저장
        	
        	if(request.getParameter("returnUrl") == null) {
        		return "redirect:/";
        	}else {
        		return "redirect:"+request.getParameter("returnUrl");
        	}
        } else {
        	if(request.getParameter("returnUrl") != null) {
        		model.addAttribute("returnUrl", request.getParameter("returnUrl"));
        	}
        	
        	model.addAttribute("message", "로그인 정보가 올바르지 않습니다.");
        	return "redirect:/";
        }
		
	}
    

    

}