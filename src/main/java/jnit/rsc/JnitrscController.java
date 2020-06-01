/**
 * @version 3.2.0.1
 */
package jnit.rsc;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.rscdata.JnitrscdataDefaultVO;
import jnit.rscdata.JnitrscdataService;
import jnit.rscdata.JnitrscdataVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitrscController.java
 * @Description : Jnitrsc Controller class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitrscVO.class)
public class JnitrscController {

    @Resource(name = "jnitrscService")
    private JnitrscService jnitrscService;
    
    @Resource(name = "jnitrscdataService")
    private JnitrscdataService jnitrscdataService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    //@Autowired
    //private DefaultBeanValidator beanValidator;

    /**
	 * JNITRSC 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitrscDefaultVO
	 * @return "/jnit/tpl-temp/jnitrsc/JnitrscList"
	 * @exception Exception
	 */
    @RequestMapping(value="/jnitrsc/JnitrscList.do")
    public String selectJnitrscList(@ModelAttribute("searchVO") JnitrscDefaultVO searchVO, 
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
		
        List jnitrscList = jnitrscService.selectJnitrscList(searchVO);
        model.addAttribute("resultList", jnitrscList);
        
        int totCnt = jnitrscService.selectJnitrscListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/tpl-temp/jnitrsc/JnitrscList";
    } 
    
    @RequestMapping("/jnitrsc/addJnitrscView.do")
    public String addJnitrscView(
            @ModelAttribute("searchVO") JnitrscDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitrscService.getLastIdJnitrsc());
        model.addAttribute("jnitrscVO", new JnitrscVO());
        return "/jnit/tpl-temp/jnitrsc/JnitrscRegister";
    }
    
    @RequestMapping("/jnitrsc/addJnitrsc.do")
    public String addJnitrsc(
    		@RequestParam("url") java.lang.String url,
    		@RequestParam("menu") java.lang.String menu,
    		@RequestParam("comments") java.lang.String comments,
    		@RequestParam("point") java.lang.String point,
    		HttpServletRequest request,
    		SessionStatus status,
    		Model model)
            throws Exception {
    	
    	//String point = request.getParameter("point");
    	
    	if(!NullUtil.nullString(url).equals("")) {
    		url = url.replaceFirst("^\\/", "");
    	}
    	
    	JnitrscVO jnitrscVO = new JnitrscVO();
    	jnitrscVO.setRscMenu(menu);
    	jnitrscVO.setRscUrl(url);
    	
    	// 메인 URL정보 있는지 확인 => 없으면 insert 있으면 select
    	JnitrscDefaultVO searchVO = new JnitrscDefaultVO();
    	searchVO.setSearchCondition("2");
    	searchVO.setSearchKeyword(url);
    	int useCnt = jnitrscService.selectJnitrscListTotCnt(searchVO);
    	
    	String rscId = "";
    	if(useCnt == 0) {  	
    		rscId = jnitrscService.insertJnitrsc(jnitrscVO);
    	}else {
    		jnitrscVO = jnitrscService.selectJnitrscByUrl(url);
    		rscId = jnitrscVO.getRscId();
    	}
        
    	// 동일 IP에서 URL로 데이터 중복 체크
        JnitrscdataDefaultVO rscdataschVO = new JnitrscdataDefaultVO();
        rscdataschVO.setSearchCondition("2");
        rscdataschVO.setSchRscId(rscId);
        rscdataschVO.setSchRemoteAddr(request.getRemoteAddr());
    	int existsData = jnitrscdataService.selectJnitrscdataListTotCnt(rscdataschVO);
    	
    	if(existsData == 0) {  	
            JnitrscdataVO rscdataVO = new JnitrscdataVO();
            rscdataVO.setRscId(rscId);
            rscdataVO.setRemoteAddr(request.getRemoteAddr());
            rscdataVO.setDataScore(Integer.parseInt(point));
    		
    		jnitrscdataService.insertJnitrscdata(rscdataVO);
    		jnitrscService.updateJnitrsc(jnitrscVO);
    		model.addAttribute("result", "OK");
    	}else {
    		model.addAttribute("result", "EXISTS");
    	}
        
    	status.setComplete();

        return "/jnit/rsc/result";
    }
    
    @RequestMapping("/jnitrsc/updateJnitrscView.do")
    public String updateJnitrscView(
            @RequestParam("rscId") java.lang.String rscId ,
            @ModelAttribute("searchVO") JnitrscDefaultVO searchVO, Model model)
            throws Exception {
        JnitrscVO jnitrscVO = new JnitrscVO();
        jnitrscVO.setRscId(rscId);        
        // 변수명은 CoC 에 따라 jnitrscVO
        model.addAttribute(selectJnitrsc(jnitrscVO, searchVO));
        return "/jnit/tpl-temp/jnitrsc/JnitrscRegister";
    }

    @RequestMapping("/jnitrsc/selectJnitrsc.do")
    public @ModelAttribute("jnitrscVO")
    JnitrscVO selectJnitrsc(
            JnitrscVO jnitrscVO,
            @ModelAttribute("searchVO") JnitrscDefaultVO searchVO) throws Exception {
        return jnitrscService.selectJnitrsc(jnitrscVO);
    }

    @RequestMapping("/jnitrsc/updateJnitrsc.do")
    public String updateJnitrsc(
            @ModelAttribute("searchVO") JnitrscDefaultVO searchVO,
	    @ModelAttribute("jnitrscVO") JnitrscVO jnitrscVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitrscVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitrsc/JnitrscRegister";
	// }

        jnitrscService.updateJnitrsc(jnitrscVO);
        status.setComplete();
        return "forward:/jnitrsc/JnitrscList.do";
    }
    
    @RequestMapping("/jnitrsc/deleteJnitrsc.do")
    public String deleteJnitrsc(
            JnitrscVO jnitrscVO,
            @ModelAttribute("searchVO") JnitrscDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitrscService.deleteJnitrsc(jnitrscVO);
        status.setComplete();
        return "forward:/jnitrsc/JnitrscList.do";
    }

}
