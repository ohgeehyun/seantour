/**
 * @version 3.2.0.1
 */
package jnit.sms.data;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : SmsdataController.java
 * @Description : Smsdata Controller class
 * @Modification Information
 *
 * @author JNITSMSDATA
 * @since 2014.02.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=SmsdataVO.class)
public class SmsdataController {

    @Resource(name = "smsdataService")
    private SmsdataService smsdataService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /**
	 * SMSDATA 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SmsdataDefaultVO
	 * @return "/jnit/tpl-temp/smsdata/SmsdataList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/smsdata/list.do")
    public String selectSmsdataList(@ModelAttribute("searchVO") SmsdataDefaultVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
    	
    	AdminUtil.setMenuId("m06080100");
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	String mbrId = NullUtil.nullString(mbrVO.getMbrId());
    	String typeId = NullUtil.nullString(mbrVO.getTypeId());
    	
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
		if("true".equals(deDug)){
			System.out.println("first : " + searchVO.getFirstIndex());
			System.out.println("last : " + searchVO.getLastIndex());
			System.out.println("recoard : " + searchVO.getRecordCountPerPage());
		}
		
		if(!typeId.equals("30020")){
			searchVO.setSearchCondition("2");
			searchVO.setSearchKeyword(mbrId);
		}
		
		List smsdataList = new ArrayList();
		if(!mbrId.equals("")){
			smsdataList = smsdataService.selectSmsdataList(searchVO);
		}
		
        model.addAttribute("resultList", smsdataList);
        
        int totCnt = smsdataService.selectSmsdataListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/smsdata/List";
    }
    
    @RequestMapping("/cms/sms/delProc.do")
    public String delete(HttpServletRequest request) throws Exception{
    	
    	String seqno = NullUtil.nullString(request.getParameter("seqno"));
    	
    	if(!seqno.equals("")){
    		SmsdataVO vo = new SmsdataVO();
    		vo.setSeqno(Integer.parseInt(seqno));
    		
    		smsdataService.deleteSmsdata(vo);
    	}else{
    		if("true".equals(deDug)) System.out.println("Err. Not Exist seqno");
    		return "redirect:/cms/smsdata/list.do";
    	}
    	
    	return "redirect:/cms/smsdata/list.do";
    }
    
    /*
    @RequestMapping("/cms/smsdata/add.do")
    public String addSmsdataView(
            @ModelAttribute("searchVO") SmsdataDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  smsdataService.getLastIdSmsdata());
        model.addAttribute("smsdataVO", new SmsdataVO());
        return "/jnit/smsdata/Add";
    }
    
    @RequestMapping("/cms/smsdata/addProc.do")
    public String addSmsdata(
            @ModelAttribute("searchVO") SmsdataDefaultVO searchVO,
	    @ModelAttribute("smsdataVO") SmsdataVO smsdataVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

        smsdataService.insertSmsdata(smsdataVO);
        return "forward:/smsdata/list.do";
    }
	
    @RequestMapping("/cms/smsdata/edit.do")
    public String updateSmsdataView(
            @RequestParam("seqNo") java.math.BigDecimal seqNo ,
            @ModelAttribute("searchVO") SmsdataDefaultVO searchVO, Model model)
            throws Exception {
        SmsdataVO smsdataVO = new SmsdataVO();
        smsdataVO.setSeqNo(seqNo);
        // 변수명은 CoC 에 따라 smsdataVO
        model.addAttribute(selectSmsdata(smsdataVO, searchVO));
        return "/jnit/smsdata/Add";
    }

    @RequestMapping("/cms/smsdata/selectSmsdata.do")
    public @ModelAttribute("smsdataVO")
    SmsdataVO selectSmsdata(
            SmsdataVO smsdataVO,
            @ModelAttribute("searchVO") SmsdataDefaultVO searchVO) throws Exception {
        return smsdataService.selectSmsdata(smsdataVO);
    }
    
    @RequestMapping("/cms/smsdata/editProc.do")
    public String updateSmsdata(
            @ModelAttribute("searchVO") SmsdataDefaultVO searchVO,
	    @ModelAttribute("smsdataVO") SmsdataVO smsdataVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

        smsdataService.updateSmsdata(smsdataVO);
        status.setComplete();
        return "forward:/smsdata/list.do";
    }
	
    @RequestMapping("/cms/smsdata/deleteSmsdata.do")
    public String deleteSmsdata(
            SmsdataVO smsdataVO,
            @ModelAttribute("searchVO") SmsdataDefaultVO searchVO, SessionStatus status)
            throws Exception {
        smsdataService.deleteSmsdata(smsdataVO);
        status.setComplete();
        return "forward:/smsdata/SmsdataList.do";
    }
    */
}
