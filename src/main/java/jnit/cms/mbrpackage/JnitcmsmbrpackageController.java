/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrpackage;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
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

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.AdminUtil;
import jnit.cms.mbr.JnitcmsmbrDefaultVO;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbrtype.JnitcmsmbrtypeDefaultVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.org.JnitcmsorgDefaultVO;
import jnit.cms.org.JnitcmsorgService;
import jnit.cms.pos.JnitcmsposDefaultVO;
import jnit.cms.pos.JnitcmsposService;

/**
 * @Class Name : JnitcmsmbrpackageController.java
 * @Description : Jnitcmsmbrpackage Controller class
 * @Modification Information
 *
 * @author JNITCMSMBRPACKAGE
 * @since 2014.05.27
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsmbrpackageVO.class)
public class JnitcmsmbrpackageController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmsmbrpackageService")
    private JnitcmsmbrpackageService jnitcmsmbrpackageService;

    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
    @Resource(name = "jnitcmsorgService")
	private JnitcmsorgService jnitcmsorgService;
	
    @Resource(name = "jnitcmsposService")
	private JnitcmsposService jnitcmsposService;
    
    @Resource(name = "jnitcmsmbrtypeService")
    private JnitcmsmbrtypeService jnitcmsmbrtypeService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /**
	 * JNITCMSMBRPACKAGE 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsmbrpackageDefaultVO
	 * @return "/jnit/tpl-temp/jnitcmsmbrpackage/JnitcmsmbrpackageList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/mbrPackage/list.do")
    public String selectJnitcmsmbrpackageList(@ModelAttribute("searchVO") JnitcmsmbrpackageDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	AdminUtil.setMenuId("m04020000");
    	
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
		
        List jnitcmsmbrpackageList = jnitcmsmbrpackageService.selectJnitcmsmbrpackageList(searchVO);
        model.addAttribute("resultList", jnitcmsmbrpackageList);
        
        int totCnt = jnitcmsmbrpackageService.selectJnitcmsmbrpackageListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/mbrpackage/List";
    } 
    
    @RequestMapping("/cms/mbrPackage/add.do")
    public String addJnitcmsmbrpackageView(
            @ModelAttribute("searchVO") JnitcmsmbrpackageDefaultVO searchVO, Model model)
            throws Exception {

    	AdminUtil.setMenuId("m04020000");
    	
        model.addAttribute("nid",  jnitcmsmbrpackageService.getLastIdJnitcmsmbrpackage());
        model.addAttribute("jnitcmsmbrpackageVO", new JnitcmsmbrpackageVO());
        return "/jnit/cms/mbrpackage/Add";
    }
    
    @RequestMapping("/cms/mbrPackage/addProc.do")
    public String addJnitcmsmbrpackage(
            @ModelAttribute("searchVO") JnitcmsmbrpackageDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmbrpackageVO") JnitcmsmbrpackageVO jnitcmsmbrpackageVO,
	    BindingResult bindingResult, Model model,
	    SessionStatus status)
            throws Exception {

    	String mbrAccess = NullUtil.nullString(jnitcmsmbrpackageVO.getMbrAccess());
    	String mbrDeny = NullUtil.nullString(jnitcmsmbrpackageVO.getMbrDeny());
    	String orgAccess = NullUtil.nullString(jnitcmsmbrpackageVO.getOrgAccess());
    	String orgDeny = NullUtil.nullString(jnitcmsmbrpackageVO.getOrgDeny());
    	String posAccess = NullUtil.nullString(jnitcmsmbrpackageVO.getPosAccess());
    	String posDeny = NullUtil.nullString(jnitcmsmbrpackageVO.getPosDeny());
    	String typeAccess = NullUtil.nullString(jnitcmsmbrpackageVO.getTypeAccess());
    	String typeDeny = NullUtil.nullString(jnitcmsmbrpackageVO.getTypeDeny());

    	if(mbrAccess.equals("") && mbrDeny.equals("") && orgAccess.equals("") && orgDeny.equals("") && posAccess.equals("") && posDeny.equals("") && typeAccess.equals("") && typeDeny.equals("")){
			model.addAttribute("alert", "권한을 하나이상 추가해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	String query = MbrpackageUtil.getMbrpackageQuery(jnitcmsmbrpackageVO);
    	jnitcmsmbrpackageVO.setQuery(query);
    	
        jnitcmsmbrpackageService.insertJnitcmsmbrpackage(jnitcmsmbrpackageVO);
        return "redirect:/cms/mbrPackage/list.do";
    }
    
    @RequestMapping("/cms/mbrPackage/edit.do")
    public String updateJnitcmsmbrpackageView(
            @RequestParam("packId") java.lang.String packId ,
            @ModelAttribute("searchVO") JnitcmsmbrpackageDefaultVO searchVO, Model model)
            throws Exception {
    	
    	AdminUtil.setMenuId("m04020000");
    	
        JnitcmsmbrpackageVO jnitcmsmbrpackageVO = new JnitcmsmbrpackageVO();
        jnitcmsmbrpackageVO.setPackId(packId);
        // 변수명은 CoC 에 따라 jnitcmsmbrpackageVO
        
        jnitcmsmbrpackageVO = selectJnitcmsmbrpackage(jnitcmsmbrpackageVO, searchVO);
        model.addAttribute(jnitcmsmbrpackageVO);
        model.addAttribute("jnitcmsmbrpackageVO", selectJnitcmsmbrpackage(jnitcmsmbrpackageVO, searchVO));
        model.addAttribute("mbrPosMap", this.getMbrPosMap());
        model.addAttribute("mbrOrgMap", this.getMbrOrgMap());
        model.addAttribute("mbrTypeMap", this.getMbrTypeMap());
        
        return "/jnit/cms/mbrpackage/Add";
    }

    @RequestMapping("/jnitcmsmbrpackage/selectJnitcmsmbrpackage.do")
    public @ModelAttribute("jnitcmsmbrpackageVO")
    JnitcmsmbrpackageVO selectJnitcmsmbrpackage(
            JnitcmsmbrpackageVO jnitcmsmbrpackageVO,
            @ModelAttribute("searchVO") JnitcmsmbrpackageDefaultVO searchVO) throws Exception {
        return jnitcmsmbrpackageService.selectJnitcmsmbrpackage(jnitcmsmbrpackageVO);
    }

    @RequestMapping("/cms/mbrPackage/editProc.do")
    public String updateJnitcmsmbrpackage(
            @ModelAttribute("searchVO") JnitcmsmbrpackageDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmbrpackageVO") JnitcmsmbrpackageVO jnitcmsmbrpackageVO,
	    BindingResult bindingResult, Model model,
	    SessionStatus status)
            throws Exception {


    	String mbrAccess = NullUtil.nullString(jnitcmsmbrpackageVO.getMbrAccess());
    	String mbrDeny = NullUtil.nullString(jnitcmsmbrpackageVO.getMbrDeny());
    	String orgAccess = NullUtil.nullString(jnitcmsmbrpackageVO.getOrgAccess());
    	String orgDeny = NullUtil.nullString(jnitcmsmbrpackageVO.getOrgDeny());
    	String posAccess = NullUtil.nullString(jnitcmsmbrpackageVO.getPosAccess());
    	String posDeny = NullUtil.nullString(jnitcmsmbrpackageVO.getPosDeny());
    	String typeAccess = NullUtil.nullString(jnitcmsmbrpackageVO.getTypeAccess());
    	String typeDeny = NullUtil.nullString(jnitcmsmbrpackageVO.getTypeDeny());

    	if(mbrAccess.equals("") && mbrDeny.equals("") && orgAccess.equals("") && orgDeny.equals("") && posAccess.equals("") && posDeny.equals("") && typeAccess.equals("") && typeDeny.equals("")){
			model.addAttribute("alert", "권한을 하나이상 추가해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	String query = MbrpackageUtil.getMbrpackageQuery(jnitcmsmbrpackageVO);
    	jnitcmsmbrpackageVO.setQuery(query);
    	
        jnitcmsmbrpackageService.updateJnitcmsmbrpackage(jnitcmsmbrpackageVO);
        
        String result = MbrpackageUtil.getMbrpackageResult("PACK_00001");
        if("true".equals(deDug)) log.debug("result : " + result);
        
        return "redirect:/cms/mbrPackage/list.do";
    }

    
    @RequestMapping("/cms/mbrPackage/ajax.do")
    public String searchMbrAjaxList(HttpServletRequest request, Model model) throws Exception{
    
    	String target = NullUtil.nullString(request.getParameter("target"));
    	String type = NullUtil.nullString(request.getParameter("type"));
    	String searchKeyword = NullUtil.nullString(request.getParameter("searchKeyword"));
    	String searchCondition = NullUtil.nullString(request.getParameter("searchCondition"));
    	
    	if(target.equals("") || type.equals("")){
    		
    		return "";
    	}
    	
    	if(target.equals("mbr")){
    		
    		if(!searchCondition.equals("") && !searchKeyword.equals("")){
    		
	    		JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
	    		searchVO.setSearchCondition(searchCondition);
	    		searchVO.setSearchKeyword(searchKeyword);
	    		
		        List resultList = jnitcmsmbrService.selectJnitcmsmbrList(searchVO);
		        model.addAttribute("resultList", resultList);
		        
		        model.addAttribute("target", target);
		        model.addAttribute("type", type);
		        
    		}else{
    			
    			JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
	    		searchVO.setSearchCondition(searchCondition);
	    		searchVO.setSearchKeyword(searchKeyword);
	    		searchVO.setFirstIndex(0);
	    		searchVO.setLastIndex(100);
	    		searchVO.setRecordCountPerPage(100);
	    		
		        List resultList = jnitcmsmbrService.selectJnitcmsmbrList(searchVO);
		        model.addAttribute("resultList", resultList);
		        
		        model.addAttribute("target", target);
		        model.addAttribute("type", type);
		        
    		}
    		
    		model.addAttribute("searchCondition", searchCondition);
    		model.addAttribute("searchKeyword", searchKeyword);
    		
	        
	        return "/jnit/cms/mbrpackage/Ajax";
	        
    	}else if(target.equals("org")){
    		
    		JnitcmsorgDefaultVO searchVO = new JnitcmsorgDefaultVO();
    		searchVO.setSearchCondition(searchCondition);
    		searchVO.setSearchKeyword(searchKeyword);
    		searchVO.setFirstIndex(0);
    		searchVO.setLastIndex(100);
    		searchVO.setRecordCountPerPage(100);
    		
	        List resultList = jnitcmsorgService.selectcmsorgList(searchVO);
	        model.addAttribute("resultList", resultList);
	        
	        model.addAttribute("target", target);
	        model.addAttribute("type", type);
		        
    		model.addAttribute("searchCondition", searchCondition);
    		model.addAttribute("searchKeyword", searchKeyword);
    		
	        
    		return "/jnit/cms/mbrpackage/Ajax";
    		
    	}else if(target.equals("pos")){
    		
    		JnitcmsposDefaultVO searchVO = new JnitcmsposDefaultVO();
    		searchVO.setSearchCondition(searchCondition);
    		searchVO.setSearchKeyword(searchKeyword);
    		searchVO.setFirstIndex(0);
    		searchVO.setLastIndex(100);
    		searchVO.setRecordCountPerPage(100);
    		
	        List resultList = jnitcmsposService.selectJnitcmsposList(searchVO);
	        model.addAttribute("resultList", resultList);
	        
	        model.addAttribute("target", target);
	        model.addAttribute("type", type);
    		
    		model.addAttribute("searchCondition", searchCondition);
    		model.addAttribute("searchKeyword", searchKeyword);
    		
	        
    		return "/jnit/cms/mbrpackage/Ajax";
    		
    	}else if(target.equals("type")){
    		
        		
    		JnitcmsmbrtypeDefaultVO searchVO = new JnitcmsmbrtypeDefaultVO();
    		searchVO.setSearchCondition(searchCondition);
    		searchVO.setSearchKeyword(searchKeyword);
    		searchVO.setFirstIndex(0);
    		searchVO.setLastIndex(100);
    		searchVO.setRecordCountPerPage(100);
    		
	        List resultList = jnitcmsmbrtypeService.selectJnitcmsmbrtypeList(searchVO);
	        model.addAttribute("resultList", resultList);
	        
	        model.addAttribute("target", target);
	        model.addAttribute("type", type);
		        
    		
    		model.addAttribute("searchCondition", searchCondition);
    		model.addAttribute("searchKeyword", searchKeyword);
    		
	        
    		return "/jnit/cms/mbrpackage/Ajax";
    		
    	}
    	
    	return "/jnit/cms/mbrpackage/Ajax";
        
    }
    
    @SuppressWarnings("unchecked")
    private JSONObject getMbrPosMap(){
		
    	JSONObject map = new JSONObject();
		List<EgovMap> resultList = new ArrayList<EgovMap>();
		
		JnitcmsposDefaultVO searchVO = new JnitcmsposDefaultVO();
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(500);
		searchVO.setRecordCountPerPage(500);
		
		try {
			resultList = jnitcmsposService.selectJnitcmsposList(searchVO);
			
			for(int i=0; i<resultList.size(); i++){
				EgovMap egovMap = (EgovMap)resultList.get(i);
				String key = (String)egovMap.get("posId");
				String value = (String)egovMap.get("posNm");
				map.put(key, value);
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			map = new JSONObject();
		} catch (Exception e) {
			log.error(e.getMessage());
			map = new JSONObject();
		}		
		return map;
	}
    
    @SuppressWarnings("unchecked")
    private JSONObject getMbrOrgMap(){
		
    	JSONObject map = new JSONObject();
		List<EgovMap> resultList = new ArrayList<EgovMap>();
		
		JnitcmsorgDefaultVO searchVO = new JnitcmsorgDefaultVO();
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(500);
		searchVO.setRecordCountPerPage(500);
		
		try {
			resultList = jnitcmsorgService.selectJnitcmsorgList(searchVO);
			
			for(int i=0; i<resultList.size(); i++){
				EgovMap egovMap = (EgovMap)resultList.get(i);
				String key = (String)egovMap.get("orgId");
				String value = (String)egovMap.get("orgNm");
				map.put(key, value);
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			map = new JSONObject();
		} catch (Exception e) {
			log.error(e.getMessage());
			map = new JSONObject();
		}		
		return map;
	}
    
    @SuppressWarnings("unchecked")
	private JSONObject getMbrTypeMap(){
		
    	JSONObject map = new JSONObject();
		List<EgovMap> resultList = new ArrayList<EgovMap>();
		
		
		JnitcmsmbrtypeDefaultVO searchVO = new JnitcmsmbrtypeDefaultVO();
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(500);
		searchVO.setRecordCountPerPage(500);
		
		try {
			resultList = jnitcmsmbrtypeService.selectJnitcmsmbrtypeList(searchVO);
			
			for(int i=0; i<resultList.size(); i++){
				EgovMap egovMap = (EgovMap)resultList.get(i);
				String key = (String)egovMap.get("typeId");
				String value = (String)egovMap.get("typeNm");
				map.put(key, value);
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			map = new JSONObject();
		} catch (Exception e) {
			log.error(e.getMessage());
			map = new JSONObject();
		}		
		return map;
	}
}
