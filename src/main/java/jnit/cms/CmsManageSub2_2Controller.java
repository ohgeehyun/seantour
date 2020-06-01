/**
 * @version 3.2.0.1
 */
package jnit.cms;

/**
 * 유형관리
 */
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.config.JnitmbrInfoVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeDefaultVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;
import jnit.util.PathUtil;

import org.apache.poi.hssf.record.TopMarginRecord;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
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
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@SessionAttributes(types=JnitcmsmbrtypeVO.class)
public class CmsManageSub2_2Controller {
    @Resource(name = "jnitcmsmbrtypeService")
    private JnitcmsmbrtypeService jnitcmsmbrtypeService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    // 유형관리 > 유형리스트
    @RequestMapping("/cms/sub2/0201.do")
    public String selectJnitcmsmbrtypeList(@ModelAttribute("searchVO") JnitcmsmbrtypeDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m02020500");
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
        List jnitcmsmbrtypeList = jnitcmsmbrtypeService.selectJnitcmsmbrtypeList(searchVO);
        model.addAttribute("resultList", jnitcmsmbrtypeList);
        
        int totCnt = jnitcmsmbrtypeService.selectJnitcmsmbrtypeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "jnit/cms/sub2_2-1";
    } 
  
    // 유형관리 > 유형등록
    @RequestMapping("/cms/sub2/0202.do")
    public String cmsManageSub2_0202(            
    		@ModelAttribute("searchVO") JnitcmsmbrtypeDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02020500");
        model.addAttribute("nid",  jnitcmsmbrtypeService.getLastIdJnitcmsmbrtype());
        model.addAttribute("jnitcmsmbrtypeVO", new JnitcmsmbrtypeVO());
        return "jnit/cms/sub2_2-2";
    }
    
    @RequestMapping("/cms/sub2/0202addview.do")
    public String addJnitcmsmbrtypeView(
            @ModelAttribute("searchVO") JnitcmsmbrtypeDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02020500");
        model.addAttribute("nid",  jnitcmsmbrtypeService.getLastIdJnitcmsmbrtype());
        model.addAttribute("jnitcmsmbrtypeVO", new JnitcmsmbrtypeVO());
        return "jnit/cms/sub2_2-2";
    }
    
    @RequestMapping("/cms/sub2/0202add.do")
    public String addJnitcmsmbrtype(
        @ModelAttribute("searchVO") JnitcmsmbrtypeDefaultVO searchVO,
    	@ModelAttribute("jnitcmsmbrtypeVO") JnitcmsmbrtypeVO jnitcmsmbrtypeVO,
	    BindingResult bindingResult, HttpServletRequest request,
	    SessionStatus status)
            throws Exception {

	  	 beanValidator.validate(jnitcmsmbrtypeVO, bindingResult); //validation 수행
		 if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
			return "jnit/cms/sub2_2-2";
		 }
		 
        jnitcmsmbrtypeService.insertJnitcmsmbrtype(jnitcmsmbrtypeVO);
        status.setComplete();
        
        String typeId = NullUtil.nullString(jnitcmsmbrtypeVO.getTypeId());
        String typeDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit";
    	String typePath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/"+typeId+".json";
    	String jsonFile = PathUtil.getRealPath(request)
    			+ "/WEB-INF/config/jnit/30020.json";
    	//30020
	    String jsonData = CmsHandler.readFile(jsonFile);
	    File confirm = new File(typeDir);
	    
	    if(!confirm.exists()){
	    	confirm.mkdir();
	    }
	    
	    org.json.simple.JSONObject depth1 = new org.json.simple.JSONObject();
    	org.json.simple.JSONObject depth2 = new org.json.simple.JSONObject();
        
    	String powerList = "m05020000";
	    String topMenuId = powerList.substring(0,3)+"000000";
    	String subMenuId1 = powerList.substring(0,5)+"0000";
	    
    	org.json.simple.JSONObject jsonTypeMenu = null;
        
        jsonTypeMenu = (org.json.simple.JSONObject) new JSONParser().parse(jsonData);
		jsonTypeMenu = (org.json.simple.JSONObject) jsonTypeMenu.get(topMenuId);
		jsonTypeMenu.remove("child");
		depth1.put(topMenuId, jsonTypeMenu);
		
		jsonTypeMenu = (org.json.simple.JSONObject) new JSONParser().parse(jsonData);
		jsonTypeMenu = (org.json.simple.JSONObject) jsonTypeMenu.get(topMenuId);
		jsonTypeMenu = (org.json.simple.JSONObject) jsonTypeMenu.get("child");
		jsonTypeMenu = (org.json.simple.JSONObject) jsonTypeMenu.get(subMenuId1);
		depth2.put(subMenuId1, jsonTypeMenu);
		
		jsonTypeMenu = (org.json.simple.JSONObject) depth1.get(topMenuId);
		jsonTypeMenu.put("child", depth2);
		depth1.put(topMenuId, jsonTypeMenu);
		
		FileWriter menuList = new FileWriter(typePath);
    	menuList.write(depth1.toString());
    	menuList.flush();
    	menuList.close();
        
        return "redirect:/cms/sub2/0201.do";
    }
    
    @RequestMapping("/cms/sub2/0202upview.do")
    public String updateJnitcmsmbrtypeView(
            @RequestParam("typeId") java.lang.String typeId ,
            @ModelAttribute("searchVO") JnitcmsmbrtypeDefaultVO searchVO, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02020500");
        JnitcmsmbrtypeVO jnitcmsmbrtypeVO = new JnitcmsmbrtypeVO();
        jnitcmsmbrtypeVO.setTypeId(typeId);        
        // 변수명은 CoC 에 따라 jnitcmsmbrtypeVO
        model.addAttribute(selectJnitcmsmbrtype(jnitcmsmbrtypeVO, searchVO));
        return "jnit/cms/sub2_2-2";
    }

    @RequestMapping("/cms/sub2/0202view.do")
    public @ModelAttribute("jnitcmsmbrtypeVO")
    JnitcmsmbrtypeVO selectJnitcmsmbrtype(
            JnitcmsmbrtypeVO jnitcmsmbrtypeVO,
            @ModelAttribute("searchVO") JnitcmsmbrtypeDefaultVO searchVO) throws Exception {
        return jnitcmsmbrtypeService.selectJnitcmsmbrtype(jnitcmsmbrtypeVO);
    }

    @RequestMapping("/cms/sub2/0202up.do")
    public String updateJnitcmsmbrtype(
    	@ModelAttribute("searchVO") JnitcmsmbrtypeDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmbrtypeVO") JnitcmsmbrtypeVO jnitcmsmbrtypeVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

	  	 beanValidator.validate(jnitcmsmbrtypeVO, bindingResult);
		 if (bindingResult.hasErrors()) {
			return "jnit/cms/sub2_2-2";
		 }

        jnitcmsmbrtypeService.updateJnitcmsmbrtype(jnitcmsmbrtypeVO);
        status.setComplete();
        return "redirect:/cms/sub2/0201.do";
    }
    
    @RequestMapping("/cms/sub2/0202del.do")
    public String deleteJnitcmsmbrtype(
            JnitcmsmbrtypeVO jnitcmsmbrtypeVO,
            @ModelAttribute("searchVO") JnitcmsmbrtypeDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsmbrtypeService.deleteJnitcmsmbrtype(jnitcmsmbrtypeVO);
        status.setComplete();
        return "forward:/cms/sub2/0201.do";
    }
    
    @RequestMapping("/cms/sub2/ajax/delete.do")
    public String sub2AjaxDelete(HttpServletRequest request, ModelMap model)throws Exception{
    	String typeId = NullUtil.nullString(request.getParameter("typeId"));
    	
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    	mbrVO.setSchTypeId(typeId);    	
    	List mbrList = jnitcmsmbrService.selectJnitcmsmbrList(mbrVO);
    	
    	JSONObject JSON = new JSONObject();    	
    	if(mbrList.size() == 0){    		
    		JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();
    		typeVO.setTypeId(typeId);
    		jnitcmsmbrtypeService.deleteJnitcmsmbrtype(typeVO);
    		JSON.put("status", "success");
    	}else{    		
    		JSON.put("status", "error");
    		JSON.put("count", mbrList.size());
    	}    	
    	model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }
    
    
    

    // 접근레벨관리 mark2
    @SuppressWarnings("deprecation")
	@RequestMapping("/cms/sub2/020101.do")
    public String cmsManageSub2_020101(            
    		HttpServletRequest request, Model model)
            throws Exception {
    	AdminUtil.setMenuId("m01030000");
    	
    	//타입 리스트 호출 --start--
    	JnitcmsmbrtypeDefaultVO defaultVO = new JnitcmsmbrtypeDefaultVO();
    		defaultVO.setPageUnit(100000);
    		defaultVO.setPageSize(1);
        	
        	/** pageing */
        	PaginationInfo paginationInfo = new PaginationInfo();
        	paginationInfo.setCurrentPageNo(1);
    		paginationInfo.setRecordCountPerPage(defaultVO.getPageUnit());
    		paginationInfo.setPageSize(defaultVO.getPageSize());
    		
    		defaultVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    		defaultVO.setLastIndex(paginationInfo.getLastRecordIndex());
    		defaultVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		
    	List typeNm = jnitcmsmbrtypeService.selectJnitcmsmbrtypeList(defaultVO);
    	
    	model.addAttribute("typeNm", typeNm);
    	//타입 리스트 호출 --end--
    	
        return "jnit/cms/sub2_2-1-1";
    }
    
    @RequestMapping("/cms/sub2/menuTreeGet.do")
    public String menuTreeOpen(HttpServletRequest request, Model model) throws Exception{
    	
    	String typeId = NullUtil.nullString(request.getParameter("typeId"));
    	List menuList = AdminUtil.typeMenuListGet(typeId);
    	String menuStr = "";
    	for(int i=0; i<menuList.size(); i++){
    		menuStr += ","+menuList.get(i);
    	}
    	menuStr = menuStr.replaceFirst(",", "");
    	model.addAttribute("json", menuStr);
    	
    	return "/jnit/util/json";
    }
    
    @RequestMapping("/cms/sub2/020101save.do")
    public String cmsManageSub2_save(HttpServletRequest request)throws Exception {
    	String typeId = NullUtil.nullString(request.getParameter("typeId"));
    	
    	String[] powerList = request.getParameterValues("powerList");
    	
    	String menuActive = "";
    	String menuCodeIds = "";
    	
    	String menuCodeid = "";
    	
    	for(int i=0; i<powerList.length; i++){

	    	String topMenuId = powerList[i].substring(0,3)+"000000";
	    	String subMenuId1 = powerList[i].substring(0,5)+"0000";
	    	String subMenuId2 = powerList[i].substring(0,7)+"00";
	    	String subMenuId3 = powerList[i].substring(0,9);
	    	
	    	if(powerList[i].substring(7, 9).equals("00")){
	    		if(!menuActive.contains(topMenuId)){
	    			menuCodeid = request.getParameter(topMenuId);
	    			if(menuActive.equals("")){
	    				menuActive = menuActive+topMenuId;
	    				menuCodeIds = menuCodeIds+menuCodeid;
	    			}else{
	    				menuActive = menuActive+","+topMenuId;
	    				menuCodeIds = menuCodeIds+","+menuCodeid;
	    			}
	    		}
	    		if(!menuActive.contains(subMenuId1)){
	    			menuCodeid = request.getParameter(subMenuId1);
	    			menuActive = menuActive+","+subMenuId1;
	    			menuCodeIds = menuCodeIds+","+menuCodeid;
	    		}	    		
	    		if(!menuActive.contains(subMenuId2)){
	    			menuCodeid = request.getParameter(subMenuId2);
	    			menuActive = menuActive+","+subMenuId2;
	    			menuCodeIds = menuCodeIds+","+menuCodeid;
	    		}
	    		
	    	}else if(!powerList[i].substring(3,9).equals("000000")){
	    		if(!menuActive.contains(topMenuId)){
	    			menuCodeid = request.getParameter(topMenuId);
	    			if(menuActive.equals("")){
	    				menuActive = menuActive+topMenuId;
	    				menuCodeIds = menuCodeIds+menuCodeid;
	    			}else{
	    				menuActive = menuActive+","+topMenuId;
	    				menuCodeIds = menuCodeIds+","+menuCodeid;
	    			}
	    		}
	    		if(!menuActive.contains(subMenuId1)){
	    			menuCodeid = request.getParameter(subMenuId1);
	    			menuActive = menuActive+","+subMenuId1;
	    			menuCodeIds = menuCodeIds+","+menuCodeid;
	    		}
	    		if(!menuActive.contains(subMenuId2)){
	    			menuCodeid = request.getParameter(subMenuId2);
	    			menuActive = menuActive+","+subMenuId2;
	    			menuCodeIds = menuCodeIds+","+menuCodeid;
	    		}
	    		if(!menuActive.contains(subMenuId3)){
	    			menuCodeid = request.getParameter(subMenuId3);
	    			menuActive = menuActive+","+subMenuId3;
	    			menuCodeIds = menuCodeIds+","+menuCodeid;
	    		}
	    	}
    	}
    	
    	System.out.println("menuCodeIds ::: "+menuCodeIds);
    	JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();
    	typeVO.setTypeId(typeId);
    	typeVO.setMenuActive(menuCodeIds);
    	jnitcmsmbrtypeService.updateJnitcmsmbrtypetree(typeVO);
    	
    	return "redirect:"+request.getHeader("referer");
    }
    
    
}