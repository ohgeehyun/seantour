/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
import jnit.cms.config.ConfigUtil;
import jnit.cms.handler.CmsHandler;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.menu.menuUtil;
import jnit.cms.mgmt.mgmtUtil;
import jnit.cms.mgmtitem.JnitcmsmgmtitemService;
import jnit.cms.mgmtitem.JnitcmsmgmtitemVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplDefaultVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.cms.tpl.tplUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

//템플릿관리 > 서브템플릿

@Controller
@SessionAttributes(types=JnitcmstplVO.class)
public class CmsManageSub4_2Controller {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmstplService")
    private JnitcmstplService jnitcmstplService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;    
    
    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;
    
    @Resource(name = "jnitcmsmgmtitemService")
    private JnitcmsmgmtitemService jnitcmsmgmtitemService;
    
    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    
    /**
	 * JNITCMSTPL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmstplDefaultVO
	 * @return "/jnit/tpl-temp/jnitcmstpl/JnitcmstplList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/sub4/0102.do")
    public String selectJnitcmstplList(
    		@ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO, 
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m04010200");
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
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
		
		searchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		searchVO.setTplType("B");
		
        List jnitcmstplList = jnitcmstplService.selectJnitcmstplList(searchVO);
        model.addAttribute("resultList", jnitcmstplList);
        
        int totCnt = jnitcmstplService.selectJnitcmstplListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "jnit/cms/sub4_1-2";
    } 
    //등록페이지
    @RequestMapping("/cms/sub4/010201.do")
    public String addJnitcmstplView(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
            HttpServletRequest request,
            Model model)
            throws Exception {
    	AdminUtil.setMenuId("m04010200");
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		String siteId = CmsHelper.getSessionSiteId(request);
		JnitcmssiteVO siteVO = new JnitcmssiteVO();
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
		
		searchVO.setSiteId(siteId);
		searchVO.setTplType("B");
		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
		searchVO.setSitePath( vo.getSitePath() );
		
        model.addAttribute("nid",  jnitcmstplService.getLastIdJnitcmstpl());

        
        JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
        jnitcmstplVO.setTplSrc("{-CONFIG_SET-}Sample Header\n\n{-CONFIG_CSS-}{-CONFIG_JS-}\n\n{-CONTENT-}\n\nSample Footer");
	    
	    String root = PathUtil.getRealPath(request);
	    String defaultTplDir = root+"/default/tpl_/subTpl.jsp";
	    String tplSrc = CmsHandler.readFile(defaultTplDir);
	    tplSrc = tplSrc.replace("{-SITEPATH-}", siteVO.getSitePath());
	    //default Setting
	    if(!"".equals(NullUtil.nullString(tplSrc))) jnitcmstplVO.setTplSrc(tplSrc);
	    
	    //적용되지않는 리스트
	    String codeList = NullUtil.nullString(request.getParameter("codeList"));	    
	    if(!"".equals(codeList)) model.addAttribute("codeList", codeList);
	    
	    model.addAttribute("jnitcmstplVO", jnitcmstplVO);
	    
        return "jnit/cms/sub4_1-2-1";
    }
    
    @RequestMapping("/cms/sub4/010201addview.do")
    public String addJnitcmstplView1(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
            HttpServletRequest request,
            Model model)
            throws Exception {
    	AdminUtil.setMenuId("m04010200");
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
		searchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
		searchVO.setTplType("B");
		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
		searchVO.setSitePath( vo.getSitePath() );
		
        model.addAttribute("nid",  jnitcmstplService.getLastIdJnitcmstpl());
        
        JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
        jnitcmstplVO.setTplSrc("Sample Header \n\n{-CONTENT-}\n\nSample Footer");
        
        model.addAttribute("jnitcmstplVO", jnitcmstplVO);
        return "jnit/cms/sub4_1-2-1";
    }
    
    //등록
    @RequestMapping("/cms/sub4/010201add.do")
    public String addJnitcmstpl(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
	    @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    ModelMap model,
	    SessionStatus status)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		//프로세스 막기
		if("".equals(NullUtil.nullString(jnitcmstplVO.getTplNm()))){
			model.addAttribute("alert", "제목을 입력해 주시기 바랍니다.");
			model.addAttribute("path", "/cms/sub4/010201.do");
			return "/jnit/util/alertMove";
		}
		
  	// beanValidator.validate(jnitcmstplVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitcmstpl/JnitcmstplRegister";
	// }
		
		searchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
		searchVO.setTplType("B");
		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
		searchVO.setSitePath( vo.getSitePath() );
		
		jnitcmstplVO.setSiteId(searchVO.getSiteId());
		jnitcmstplVO.setTplType(searchVO.getTplType());
		
		//필수값 무결성 검사
		HashMap<Integer, String> essentialMap = ConfigUtil.getEssentialCode(searchVO.getTplType());
		String codeList = "";
		
		for(int i=0; i<essentialMap.size(); i++){
			if(NullUtil.nullString(jnitcmstplVO.getTplSrc()).indexOf(essentialMap.get(i)) == -1){
				codeList += " "+essentialMap.get(i);
			}
		}
		if(!"".equals(codeList)){
			model.addAttribute("alert", "필수 치환코드 : "+codeList+"가 누락되어 서버적용에 되지않았습니다.");
			model.addAttribute("path", "/cms/sub4/010201.do?codeList="+codeList);
			
			String recodeList = NullUtil.nullString(request.getParameter("codeList"));			
			if(!"".equals(recodeList)){
				if(!codeList.equals(recodeList)){					
					model.addAttribute("path", "/cms/sub4/010201.do?codeList="+recodeList);
				}
			}			
			return "/jnit/util/alertMove";
		}		
		//End 필수값 무결성 검사
		
        String id = jnitcmstplService.insertJnitcmstpl(jnitcmstplVO);        
       
        
        String siteId = CmsHelper.getSessionSiteId(request);
        JnitcmssiteVO siteVO = new JnitcmssiteVO();
        siteVO.setSiteId(siteId);
        siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        
        //파일관리 표시설정 등록
        JnitcmsmgmtitemVO itemVO = new JnitcmsmgmtitemVO();
        itemVO.setMgmtCategoryId(mgmtUtil.selectJnitcmsmgmtCatetoryId(request, siteId));
        try {
        	itemVO.setCountCondition("1");
			itemVO.setCategorySort(jnitcmsmgmtitemService.selectJnitcmsmgmtitemListTotCnt(itemVO)+1);
        } catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		itemVO.setCategoryVal(id);
		itemVO.setCategoryNm(jnitcmstplVO.getTplNm());
		itemVO.setCategorySource("tpl");
		itemVO.setModifiYn(1);
		jnitcmsmgmtitemService.insertJnitcmsmgmtitem(itemVO);
        
        //파일 핸들링
        mgmtUtil.writeFile("서브템플릿","2", "3", null);               
        
        //히스토리
        tplUtil.tplHistWrite(request, jnitcmstplVO, siteId);       
        
        // TPL File 저장
    	tplUtil.tplWrite(request, jnitcmstplVO, siteVO);    	

        status.setComplete();
        
        return "redirect:/cms/sub4/0102.do";
    }
    
    
    //수정페이지
    @RequestMapping("/cms/sub4/010201upview.do")
    public String updateJnitcmstplView(
            @RequestParam("tplId") java.lang.String tplId ,
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
            HttpServletRequest request,
            Model model)
            throws Exception {
    	AdminUtil.setMenuId("m04010200");
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
		searchVO.setSiteId( CmsHelper.getSessionSiteId(request) );
		searchVO.setTplType("B");
		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO vo = jnitcmssiteService.selectJnitcmssite(siteSearchVO);
		searchVO.setSitePath( vo.getSitePath() );
		
        JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
        jnitcmstplVO.setTplId(tplId);        
        // 변수명은 CoC 에 따라 jnitcmstplVO
        
        jnitcmstplVO = selectJnitcmstpl(jnitcmstplVO, searchVO);
        
		// 콘텐츠 페이지 파일 Reverse 로딩
        String tplDir = PathUtil.getRealPath(request)
					+ "/" + vo.getSitePath() + "/_tpls/" + jnitcmstplVO.getTplType();
        File f = new File(tplDir);
        f.mkdirs();
        
        CmsHandler cmsHdr = new CmsHandler(tplDir+"/", jnitcmstplVO.getTplId());
		cmsHdr.setFileHeader("<%@ page contentType=\"text/html; charset=utf-8\" %>"
							+"<%@ include file='/_common/_header.jsp' %><%@ page import=\"jnit.cms.handler.[*]\" %>"
							+"<%@ page import=\"jnit.com.util.CclUtil\" %>"
							+"<%@ page import=\"jnit.cms.menu.JnitcmsmenuController\" %>"
							+"<c:set var=\"handingType\" value=\""+jnitcmstplVO.getTplId()+"\" />");
		
		String siteId = CmsHelper.getSessionSiteId(request);
	    JnitcmssiteVO siteVO = new JnitcmssiteVO();
	    siteVO.setSiteId(siteId);
	    siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
		
		boolean loadRes = cmsHdr.loadSplitContent("CONTENT");
		
		if(loadRes == true) {
	        //cmsHdr.viewReport();
	        String reverseCntSrc = cmsHdr.getReverseContent();
	        
	        //File load 역치환	        
	        reverseCntSrc = tplUtil.replaceAllTpl(siteVO.getSitePath(), jnitcmstplVO, reverseCntSrc, "return");
	        
	        if(!NullUtil.nullString(reverseCntSrc).trim().equals(NullUtil.nullString(jnitcmstplVO.getTplSrc()).trim())) { 	
	        	jnitcmstplVO.setTplSrc(cmsHdr.getReverseContent().trim());	        	
	        	
	        	model.addAttribute("newFileCnt", "Y");
	        }else {
	        	model.addAttribute("newFileCnt", "N");
	        }
	        model.addAttribute("notFileCnt", "N");
		}else {
			model.addAttribute("notFileCnt", "Y");
		}  
		//jnitcmstplVO.getTplSrc 역치환
	    jnitcmstplVO.setTplSrc(tplUtil.replaceAllTpl(siteVO.getSitePath(), jnitcmstplVO, jnitcmstplVO.getTplSrc(), "return"));
	    jnitcmstplVO.setTplSrc(NullUtil.nullString(jnitcmstplVO.getTplSrc()).replace("{-SITEPATH-}", siteVO.getSitePath()));
        model.addAttribute("jnitcmstplVO", jnitcmstplVO);
        
        //적용되지않는 리스트
	    String codeList = NullUtil.nullString(request.getParameter("codeList"));	    
	    if(!"".equals(codeList)) model.addAttribute("codeList", codeList);
	    
	    //콘텐츠 페이지가 서브템플릿을 참조 확인
	    String includeErrorList = tplUtil.isSubTplIncludeFileExists(vo, jnitcmstplVO.getTplSrc(), tplId);	   
        if(!"".equals(includeErrorList)){        	
        	model.addAttribute("includeError", "include하신 "+includeErrorList+"은\\n\\n"+jnitcmstplVO.getTplNm()+" 을 참조 할 수 없음으로 강제 사용안함으로 설정되었습니다.\\n\\n서브템플릿을 참조시키지 말거나\\n메뉴/콘텐츠에서 변경해주시기 바랍니다.");
        	model.addAttribute("includeErrorList", includeErrorList.replace("'", "\""));
        }      
	    
        return "jnit/cms/sub4_1-2-1";
    }

    @RequestMapping("/cms/sub4/010201view.do")
    public @ModelAttribute("jnitcmstplVO")
    JnitcmstplVO selectJnitcmstpl(
            JnitcmstplVO jnitcmstplVO,
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO) throws Exception {
        return jnitcmstplService.selectJnitcmstpl(jnitcmstplVO);
    }
    //수정
    @RequestMapping("/cms/sub4/010201up.do")
    public String updateJnitcmstpl(
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
	    @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    ModelMap model,
	    SessionStatus status)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
  	// beanValidator.validate(jnitcmstplVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitcmstpl/JnitcmstplRegister";
	// }
		
		String siteId = CmsHelper.getSessionSiteId(request);
        JnitcmssiteVO siteVO = new JnitcmssiteVO();
        siteVO.setSiteId(siteId);
        siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        
		String returnUrl = "/cms/sub4/010201upview.do?screenMode=up&tplId="+jnitcmstplVO.getTplId();
		
		//프로세스 막기
		if("".equals(NullUtil.nullString(jnitcmstplVO.getTplNm()))){
			model.addAttribute("alert", "제목을 입력해 주시기 바랍니다.");
			model.addAttribute("path", returnUrl);
			return "/jnit/util/alertMove";
		}
		
		//필수값 무결성 검사
		HashMap<Integer, String> essentialMap = ConfigUtil.getEssentialCode("B");
		String codeList = "";
		
		for(int i=0; i<essentialMap.size(); i++){
			if(NullUtil.nullString(jnitcmstplVO.getTplSrc()).indexOf(essentialMap.get(i)) == -1){
				codeList += " "+essentialMap.get(i);
			}
		}		
		if(!"".equals(codeList)){
			model.addAttribute("alert", "필수 치환코드 : "+codeList+"가 누락되어 서버적용에 되지않았습니다.");			
			model.addAttribute("path", returnUrl+"&codeList="+codeList);
			
			String recodeList = NullUtil.nullString(request.getParameter("codeList"));			
			if(!"".equals(recodeList)){
				if(!codeList.equals(recodeList)){					
					model.addAttribute("path", returnUrl+"&codeList="+recodeList);
				}
			}			
			return "/jnit/util/alertMove";
		}
		//End 필수값 무결성 검사
		jnitcmstplVO.setTplSrc(jnitcmstplVO.getTplSrc().replace("{-SITEPATH-}", siteVO.getSitePath()));
        jnitcmstplService.updateJnitcmstpl(jnitcmstplVO);
        
        //표출설정 이름 변경
        JnitcmsmgmtitemVO itemVO = new JnitcmsmgmtitemVO();
        itemVO.setMgmtCategoryId(mgmtUtil.selectJnitcmsmgmtCatetoryId(request, siteId));
        itemVO.setCategoryNm(jnitcmstplVO.getTplNm());
        itemVO.setCategoryVal(jnitcmstplVO.getTplId());
        itemVO.setUpdateCondition("1");
        jnitcmsmgmtitemService.updateJnitcmsmgmtitem(itemVO);        
        try {
        	itemVO.setSelectCondition("1");        	        	
			itemVO = jnitcmsmgmtitemService.selectJnitcmsmgmtitem(itemVO);
        } catch (NullPointerException e){
        	log.error(e.getMessage());
			if("true".equals(deDug)) log.debug(e.getMessage());
			itemVO.setCategorySource("tpl");
			itemVO.setModifiYn(1);
			itemVO.setCountCondition("1");
			itemVO.setCategorySort(jnitcmsmgmtitemService.selectJnitcmsmgmtitemListTotCnt(itemVO)+1);
			jnitcmsmgmtitemService.insertJnitcmsmgmtitem(itemVO);
		} catch (Exception e) {
			log.error(e.getMessage());
			if("true".equals(deDug)) log.debug(e.getMessage());
			itemVO.setCategorySource("tpl");
			itemVO.setModifiYn(1);
			itemVO.setCountCondition("1");
			itemVO.setCategorySort(jnitcmsmgmtitemService.selectJnitcmsmgmtitemListTotCnt(itemVO)+1);
			jnitcmsmgmtitemService.insertJnitcmsmgmtitem(itemVO);
		}        
        
		//mata 핸들링
		menuUtil.makeMeta(request, siteVO, "서브템플릿");
		
        //파일 핸들링
        mgmtUtil.writeFile("서브템플릿","2", "3",null);
        //End 파일 핸들링
        
        //히스토리
        tplUtil.tplHistWrite(request, jnitcmstplVO, siteId);
        
    	// TPL File 저장
    	tplUtil.tplWrite(request, jnitcmstplVO, siteVO);   	
	    
        status.setComplete();
        model.addAttribute("path", "/cms/sub4/010201upview.do?screenMode=up&tplId="+jnitcmstplVO.getTplId());
    	return "/jnit/util/alertMove";
    }
    
    @RequestMapping("/cms/sub4/010201del.do")
    public String deleteJnitcmstpl(
            JnitcmstplVO jnitcmstplVO,
            @ModelAttribute("searchVO") JnitcmstplDefaultVO searchVO,
            HttpServletRequest request,
            SessionStatus status)
            throws Exception {
    	
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub4_msg-nosite";
		}
		
        jnitcmstplService.deleteJnitcmstpl(jnitcmstplVO);
        status.setComplete();
        return "redirect:/cms/sub4/0102.do";
    }
    
    @RequestMapping("/sub4/ajax/delete.do")
    public String sub4AjaxDelete(@ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO
    		, HttpServletRequest request
    		, ModelMap model)throws Exception{
    	
    	JSONObject JSON = new JSONObject();
    	
    	if("".equals(NullUtil.nullString(jnitcmstplVO.getTplId()))){
    		JSON.put("status", "error");
    		JSON.put("code", "FAIL 1");
    		model.addAttribute("json", JSON.toString());
    		return "/jnit/util/json";
    	}
    	
    	Boolean isUseBln = false;
    	
    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
    	siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
    	
    	JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
    	menuVO.setSiteId(siteId);
    	menuVO.setSearchKeyword(jnitcmstplVO.getTplId());
    	menuVO.setSearchCondition("0");
    	menuVO.setLeftYn("Y");    	
    	int isUse = jnitcmsmenuService.selectJnitcmsmenuListTotCnt(menuVO);
    	
    	if(isUse > 0){
    		JSON.put("status", "error");
    		JSON.put("code", "FAIL 2");
    		isUseBln = true;
    		model.addAttribute("json", JSON.toString());
    		return "/jnit/util/json";
    	}
    	
    	JnitcmstplVO tplVO = new JnitcmstplVO();
    	tplVO.setSiteId(siteId);
    	tplVO.setTplTypeYn("N");
    	tplVO.setSearchCondition("4");
    	tplVO.setSearchKeyword(jnitcmstplVO.getTplId());
    	isUse = jnitcmstplService.selectJnitcmstplListTotCnt(tplVO);
    	
    	if(isUse > 0){
    		JSON.put("status", "error");
    		JSON.put("code", "FAIL 3");
    		isUseBln = true;
    		model.addAttribute("json", JSON.toString());
    		return "/jnit/util/json";
    	}
    	
    	if(!isUseBln){
    		try {
    			jnitcmstplService.deleteJnitcmstpl(jnitcmstplVO);
    		} catch (NullPointerException e){
    			JSON.put("status", "error");
	    		JSON.put("code", "FAIL 4");
	    		model.addAttribute("json", JSON.toString());
	    		return "/jnit/util/json";
			} catch (Exception e) {
				JSON.put("status", "error");
	    		JSON.put("code", "FAIL 4");
	    		model.addAttribute("json", JSON.toString());
	    		return "/jnit/util/json";
			}
    	}
    	
    	JSON.put("status", "success");
    	model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }
}