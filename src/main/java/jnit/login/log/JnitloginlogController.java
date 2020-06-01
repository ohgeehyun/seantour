/**
 * @version 3.2.0.1
 */
package jnit.login.log;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.com.util.DBType;

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

import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitloginlogController.java
 * @Description : Jnitloginlog Controller class
 * @Modification Information
 *
 * @author JNITLOGINLOG
 * @since 2013.07.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitloginlogVO.class)
public class JnitloginlogController {

    @Resource(name = "jnitloginlogService")
    private JnitloginlogService jnitloginlogService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitloginlog 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitloginlogDefaultVO
	 * @return "/jnit/loginlog/JnitloginlogList"
	 * @exception Exception
	 */
    @RequestMapping(value="/login/logList.do")
    public String selectJnitloginlogList(@ModelAttribute("searchVO") JnitloginlogDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m03020000");
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
		
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		
		//로그인 기반		
		//searchVO.setConditionKeyword(loginVO.getMbrId());
		//searchVO.setCondition("0");		
		
		String selectType = NullUtil.nullString(request.getParameter("selectType"));
		String searchKey = NullUtil.nullString(request.getParameter("searchKey"));
		String searchKey2 = NullUtil.nullString(request.getParameter("searchKey2"));
		String searchKey3 = NullUtil.nullString(request.getParameter("searchKey3"));
		
		if(!searchKey.equals("") || !searchKey2.equals("")){
			
			if(selectType.equals("0")){ //이름
				
				searchVO.setSearchKeyword(searchKey);
				searchVO.setSearchCondition("3"); //MBR_NM
				model.addAttribute("searchKey", searchKey);
				
			}else if(selectType.equals("1")){ //접속IP
				
				searchVO.setSearchKeyword(searchKey);
				searchVO.setSearchCondition("4"); //IP_ADDR
				model.addAttribute("searchKey", searchKey);
				
			}else if(selectType.equals("2")){ //날짜
				
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date disseminateDate = (Date)dateFormat.parse(searchKey2);
				Date disseminateDate2 = (Date)dateFormat.parse(searchKey3);
				
				searchVO.setSearchDate(disseminateDate);
				searchVO.setSearchDate2(disseminateDate2);
				searchVO.setSearchCondition("5"); //CREATED
				
				model.addAttribute("searchKey2", searchKey2);
				model.addAttribute("searchKey3", searchKey3);
				
			}else if(selectType.equals("")){//전체				
				searchVO.setSearchKeyword(searchKey);
				searchVO.setSearchCondition("6"); 
				model.addAttribute("searchKey", searchKey);
			}
		}
		
        List jnitloginlogList = jnitloginlogService.selectLeftJoinloginlogList(searchVO);
        
        int totCnt = jnitloginlogService.selectLeftJoinloginlogListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("selectType", selectType);
		model.addAttribute("resultList", jnitloginlogList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("DBType", DBType.getDbTypeString());
        return "/jnit/loginlog/list";
    } 
    
    @RequestMapping("/login/logAdd.do")
    public String addJnitloginlogView(
            @ModelAttribute("searchVO") JnitloginlogDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitloginlogService.getLastIdJnitloginlog());
        model.addAttribute("jnitloginlogVO", new JnitloginlogVO());
        return "/jnit/loginlog/logEdit";
    }
    
    @RequestMapping("/login/logAddProc.do")
    public String addJnitloginlog(
            @ModelAttribute("searchVO") JnitloginlogDefaultVO searchVO,
	    @ModelAttribute("jnitloginlogVO") JnitloginlogVO jnitloginlogVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitloginlogVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/loginlog/JnitloginlogRegister";
	// }

        jnitloginlogService.insertJnitloginlog(jnitloginlogVO);
        status.setComplete();
        return "forward:/login/logList.do";
    }
    
    @RequestMapping("/login/logEdit.do")
    public String updateJnitloginlogView(
            @RequestParam("ipId") java.lang.String ipId ,
            @ModelAttribute("searchVO") JnitloginlogDefaultVO searchVO, Model model)
            throws Exception {
        JnitloginlogVO jnitloginlogVO = new JnitloginlogVO();
        jnitloginlogVO.setIpId(ipId);        
        // 변수명은 CoC 에 따라 jnitloginlogVO
        model.addAttribute(selectJnitloginlog(jnitloginlogVO, searchVO));
        return "/jnit/loginlog/logEdit";
    }

    @RequestMapping("/jnitloginlog/selectJnitloginlog.do")
    public @ModelAttribute("jnitloginlogVO")
    JnitloginlogVO selectJnitloginlog(
            JnitloginlogVO jnitloginlogVO,
            @ModelAttribute("searchVO") JnitloginlogDefaultVO searchVO) throws Exception {
        return jnitloginlogService.selectJnitloginlog(jnitloginlogVO);
    }

    @RequestMapping("/login/logEditProc.do")
    public String updateJnitloginlog(
            @ModelAttribute("searchVO") JnitloginlogDefaultVO searchVO,
	    @ModelAttribute("jnitloginlogVO") JnitloginlogVO jnitloginlogVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitloginlogVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/loginlog/JnitloginlogRegister";
	// }

        jnitloginlogService.updateJnitloginlog(jnitloginlogVO);
        status.setComplete();
        return "forward:/login/logList.do";
    }
    
    @RequestMapping("/login/logDelete.do")
    public String deleteJnitloginlog(
            JnitloginlogVO jnitloginlogVO,
            @ModelAttribute("searchVO") JnitloginlogDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitloginlogService.deleteJnitloginlog(jnitloginlogVO);
        status.setComplete();
        return "forward:/login/logList.do";
    }

}
