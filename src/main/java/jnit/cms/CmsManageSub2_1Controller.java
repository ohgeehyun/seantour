/**
 * @version 3.2.0.1
 */
package jnit.cms;

/**
 * 회원관리
 */
import java.util.HashMap;
import java.util.Iterator;
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

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.config.ConfigUtil;
import jnit.cms.mbr.CmsSignupController;
import jnit.cms.mbr.JnitcmsmbrDefaultVO;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbr.MbrUtil;
import jnit.cms.mbrlog.JnitcmsmbrlogService;
import jnit.cms.mbrlog.JnitcmsmbrlogVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;
import jnit.cms.org.JnitcmsorgService;
import jnit.cms.org.JnitcmsorgVO;
import jnit.cms.rank.JnitcmsrankDefaultVO;
import jnit.cms.rank.JnitcmsrankService;
import jnit.cms.rank.JnitcmsrankVO;
import jnit.com.util.DBType;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@SessionAttributes(types=JnitcmsmbrVO.class)
public class CmsManageSub2_1Controller {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitcmsorgService")
	private JnitcmsorgService jnitcmsorgService;
	
    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
    @Resource(name = "jnitcmsrankService")
    private JnitcmsrankService jnitcmsrankService;
    
    @Resource(name = "jnitcmsmbrlogService")
    private JnitcmsmbrlogService jnitcmsmbrlogService;
    
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
	 * JNITCMSMBR 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsmbrDefaultVO
	 * @return "jnit/cms/sub2_1-1"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/sub2/0101.do")
    public String selectJnitcmsmbrList(@ModelAttribute("searchVO") JnitcmsmbrDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	
    	String contentEdit = NullUtil.nullString(request.getParameter("contentEdit"));
    	String retTypeId = NullUtil.nullString(request.getParameter("retTypeId"));
    	String excel = NullUtil.nullString(request.getParameter("excel"));
    	String orgId = NullUtil.nullString(request.getParameter("orgId"));
    	model.addAllAttributes(AdminJson(request, model)); 	
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());

		if(request.getParameter("ajax") != null) {
			if(request.getParameter("ajax").equals("Y")) {
				paginationInfo.setRecordCountPerPage(5);
	        }else {
	        	paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
	        }
		}else {
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		}		
		
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		if(!orgId.equals("")){
			searchVO.setOrgIdYn("Y");
			searchVO.setOrgId(orgId);
		}
		
		if(!contentEdit.equals("")){
			searchVO.setTypeIdCondition("0");//메뉴 콘텐츠 담당자 ajax			
		}
		
		if(!retTypeId.equals("")){
			if(retTypeId.equals("member")){ //회원관리				
				searchVO.setTypeIdCondition("0");				
			}
			
			if(retTypeId.equals("company")){ //업체인증관리
				searchVO.setGrpConfirmYn("Y");
				searchVO.setGrpConfirm("N");
				searchVO.setTypeIdCondition("1");
				searchVO.setTypeIdKeyword("30006");  //업체회원,단체회원
				
				
				if(request.getParameterValues("confirmList") != null){
					String confirmList[] = request.getParameterValues("confirmList");					
					for(int i=0; i<confirmList.length; i++){
						try {
							JnitcmsmbrVO mbrConfrimVO = new JnitcmsmbrVO();
							mbrConfrimVO.setGrpConfirm("Y");
							mbrConfrimVO.setMbrId(confirmList[i]);
							mbrConfrimVO.setUpdateCondition("5");
							jnitcmsmbrService.updateJnitcmsmbr(mbrConfrimVO);
							
							mbrConfrimVO = jnitcmsmbrService.selectJnitcmsmbr(mbrConfrimVO);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							if("true".equals(deDug)) log.debug(e.getMessage());
						}
					}
				}
			}
			
			if(retTypeId.equals("lock")){ //lock회원 관리
				searchVO.setTypeIdCondition("2"); //비밀번호 5회이상틀린 회원
			}
		}
		
		if("all".equals(excel)){
			searchVO.setSearchKeyword("");
			searchVO.setPageYn("N");
		}
        List jnitcmsmbrList = jnitcmsmbrService.selectLeftJoinmbrList(searchVO);
        
        Iterator mbrIterator = jnitcmsmbrList.iterator();
        String admMbrText="";
        
        HashMap<String, String> resultMap = new HashMap<String, String>();
        for(int i=0; i<jnitcmsmbrList.size(); i++){
        	EgovMap mbrEgovMap = (EgovMap) mbrIterator.next();
        	String orgNm = String.valueOf(mbrEgovMap.get("orgNm"));
			String posNm = String.valueOf(mbrEgovMap.get("posNm"));
			String rankNm = String.valueOf(mbrEgovMap.get("rankName"));
			String mbrNm = String.valueOf(mbrEgovMap.get("mbrNm"));		
			String mbrId = String.valueOf(mbrEgovMap.get("mbrId"));			
						
			if(!orgNm.equals("null") && !posNm.equals("null") && !rankNm.equals("null")){
				admMbrText = orgNm+": "+mbrNm+"("+rankNm+"/"+posNm+")";
			}else if(orgNm.equals("null") && !posNm.equals("null") && !rankNm.equals("null")){
				admMbrText = mbrNm+"("+rankNm+"/"+posNm+")";
			}else if(orgNm.equals("null") && !posNm.equals("null") && rankNm.equals("null")){
				admMbrText = mbrNm+"("+posNm+")";
			}else if(!orgNm.equals("null") && !posNm.equals("null") && rankNm.equals("null")){
				admMbrText = orgNm+": "+mbrNm+"("+posNm+")";
			}else if(!orgNm.equals("null") && posNm.equals("null") && !rankNm.equals("null")){
				admMbrText = orgNm+": "+mbrNm+"("+rankNm+")";
			}else if(!orgNm.equals("null") && posNm.equals("null") && rankNm.equals("null")){
				admMbrText = orgNm+": "+mbrNm;
			}else{
				admMbrText = mbrNm;
			}
			resultMap.put(mbrId, admMbrText);
        }        
        int totCnt = jnitcmsmbrService.selectLeftJoinmbrListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		JnitcmsorgVO orgVO = new JnitcmsorgVO();
		List orgList = jnitcmsorgService.selectcmsorgList(orgVO);
		
		model.addAttribute("resultList", jnitcmsmbrList);
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("orgList", orgList);
		model.addAttribute("orgId", orgId);		
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("retTypeId", retTypeId);
        model.addAttribute("DBTypeInfo", DBType.getGlobalInfoString());
        if(request.getParameter("ajax") != null) {
	        if(request.getParameter("ajax").equals("Y")) {
	        	if(!contentEdit.equals("")){
	        		model.addAttribute("contentEdit", contentEdit);
	        	}
	        	return "jnit/cms/sub2_1-1-ajax";
	        }else {
	        	return "jnit/cms/sub2_1-1";
	        }
        }else if(!"".equals(excel)){        	
        	return "/jnit/cms/sub2_1-1_Excel";
        }else {
        	return "jnit/cms/sub2_1-1";
        }
    } 
    
    /**
	 * JNITCMSMBR 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsmbrDefaultVO
	 * @return "jnit/cms/sub2_1-1"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/sub2/mbrSearch.do")
    public String selectJnitcmsmbrSearch(@ModelAttribute("searchVO") JnitcmsmbrDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	String contentEdit = NullUtil.nullString(request.getParameter("contentEdit"));
    	String resultId = NullUtil.nullString(request.getParameter("resultId"));
    	String myjob = NullUtil.nullString(request.getParameter("myjob"));
    	String schTypeId = "30021";
    	
    	
    	if(myjob.equals("true")){
    		model.addAttribute("myjob","true");
    	}
    	model.addAttribute("resultId",resultId);
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(5);
		searchVO.setPageYn("Y");
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setTypeIdCondition("0");
		searchVO.setTypeIdKeyword("30021"); //직원
		searchVO.setTypeIdKeyword5("30020"); //최고관리자
        List jnitcmsmbrList = jnitcmsmbrService.selectLeftJoinmbrList(searchVO);
        model.addAttribute("resultList", jnitcmsmbrList);
        
        Iterator mbrIterator = jnitcmsmbrList.iterator();
        String admMbrText="";
        HashMap<String, String> resultMap = new HashMap<String, String>();
        for(int i=0; i<jnitcmsmbrList.size(); i++){
        	EgovMap mbrEgovMap = (EgovMap) mbrIterator.next();
        	String orgNm = String.valueOf(mbrEgovMap.get("orgNm"));
			String posNm = String.valueOf(mbrEgovMap.get("posNm"));
			String rankNm = String.valueOf(mbrEgovMap.get("rankName"));
			String mbrNm = String.valueOf(mbrEgovMap.get("mbrNm"));		
			String mbrId = String.valueOf(mbrEgovMap.get("mbrId"));
						
			if(!orgNm.equals("null") && !posNm.equals("null") && !rankNm.equals("null")){
				admMbrText = orgNm+": "+mbrNm+"("+rankNm+"/"+posNm+")";
			}else if(orgNm.equals("null") && !posNm.equals("null") && !rankNm.equals("null")){
				admMbrText = mbrNm+"("+rankNm+"/"+posNm+")";
			}else if(orgNm.equals("null") && !posNm.equals("null") && rankNm.equals("null")){
				admMbrText = mbrNm+"("+posNm+")";
			}else if(!orgNm.equals("null") && !posNm.equals("null") && rankNm.equals("null")){
				admMbrText = orgNm+": "+mbrNm+"("+posNm+")";
			}else if(!orgNm.equals("null") && posNm.equals("null") && !rankNm.equals("null")){
				admMbrText = orgNm+": "+mbrNm+"("+rankNm+")";
			}else if(!orgNm.equals("null") && posNm.equals("null") && rankNm.equals("null")){
				admMbrText = orgNm+": "+mbrNm;
			}else{
				admMbrText = mbrNm;
			}
			resultMap.put(mbrId, admMbrText);
        }        
        model.addAttribute("resultMap", resultMap);
        //getTriggerModel(model);
        
        int totCnt = jnitcmsmbrService.selectLeftJoinmbrListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "jnit/result/search_mbr";
        
    } 
    
    @RequestMapping("/cms/sub2/0102.do")
    public String cmsManageSub2_0202(
            @ModelAttribute("searchVO") JnitcmsmbrDefaultVO searchVO
            , HttpServletRequest request
            , ModelMap model)
            throws Exception {
    	String siteId = CmsHelper.getSessionSiteId(request);
    	String retTypeId = NullUtil.nullString(request.getParameter("retTypeId"));
    	
    	//JSON
    	model.addAllAttributes(AdminJson(request, model));   	
    	getTriggerModel(model);
    	model.addAttribute("retTypeId", retTypeId);    	
        model.addAttribute("nid", jnitcmsmbrService.getLastIdJnitcmsmbr());
        model.addAttribute("jnitcmsmbrVO", new JnitcmsmbrVO());
        model.addAllAttributes(mbrProperties(request, model, siteId));
        model.addAttribute("DBTypeInfo", DBType.getGlobalInfoString());
        return "jnit/cms/sub2_1-2";
    } 
    
    @RequestMapping("/cms/sub2/0102add.do")
    public String addJnitcmsmbr(
        @ModelAttribute("searchVO") JnitcmsmbrDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    SessionStatus status,
	    ModelMap model)
            throws Exception {
    	
    	String retTypeId = NullUtil.nullString(request.getParameter("retTypeId"));
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	
        String rankId = NullUtil.nullString(request.getParameter("rank"));
        jnitcmsmbrVO.setRankId(rankId);
		try {
			jnitcmsmbrVO = jnitcmsmbrfk(jnitcmsmbrVO);
			jnitcmsmbrVO.setPasswd(EgovFileScrty.encryptPassword(jnitcmsmbrVO.getPasswd()));			
			if(jnitcmsmbrService.insertJnitcmsmbr(jnitcmsmbrVO) == null) {
				throw new Exception("MBR_LOGIN");
			}
	    	status.setComplete();
	    	
	    	MbrUtil.insertMbrlog(request, jnitcmsmbrVO, loginVO, "가입", "cms", null);	    	
	    	if(retTypeId.equals("")){
	    		return "redirect:/cms/sub2/0101.do";
	    	}else{
	    		return "redirect:/cms/sub2/0101.do?retTypeId="+retTypeId;
	    	}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			if(e.getMessage().toString().indexOf("MBR_LOGIN") > -1) {
				model.addAttribute("mbrLoginMsg", "회원아이디 ["+jnitcmsmbrVO.getMbrLogin()+"]은(는) 이미 사용중입니다."); 
				getTriggerModel(model);
				if(!retTypeId.equals("")){
					model.addAttribute("retTypeId", retTypeId);					
				}
				return "jnit/cms/sub2_1-2";
			}else {
				if(retTypeId.equals("")){
					return "redirect:/cms/sub2/0101.do";
				}else{
					return "redirect:/cms/sub2/0101.do?retTypeId="+retTypeId;
				}					
			}
		}catch(Exception e) {
			if("true".equals(deDug)) log.debug(e.getMessage());
			//log.debug("mbr_login:" + e.getMessage().toString().indexOf("MBR_LOGIN1"));
			if(e.getMessage().toString().indexOf("MBR_LOGIN") > -1) {
				model.addAttribute("mbrLoginMsg", "회원아이디 ["+jnitcmsmbrVO.getMbrLogin()+"]은(는) 이미 사용중입니다."); 
				getTriggerModel(model);
				if(!retTypeId.equals("")){
					model.addAttribute("retTypeId", retTypeId);					
				}
				return "jnit/cms/sub2_1-2";
			}else {
				if(retTypeId.equals("")){
					return "redirect:/cms/sub2/0101.do";
				}else{
					return "redirect:/cms/sub2/0101.do?retTypeId="+retTypeId;
				}					
			}
		}
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/cms/sub2/0102add-getTrigger.do")
    private ModelMap getTriggerModel(ModelMap model) throws Exception {
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();

    	// 부서정보조회
    	List orgId_result = jnitcmsmbrService.selectOrgIdDetail(vo);
    	model.addAttribute("orgId_result", orgId_result);    	
    	
    	// 직급정보조회
    	List posId_result = jnitcmsmbrService.selectPosIdDetail(vo);
    	model.addAttribute("posId_result", posId_result);
    	
    	// 회원유형조회
    	List typeId_result = jnitcmsmbrService.selectTypeIdDetail(vo);
    	model.addAttribute("typeId_result", typeId_result);
    	
    	return model;
    }    
    
    @RequestMapping("/cms/sub2/0102upview.do")
    public String updateJnitcmsmbrView(
            @RequestParam("mbrId") java.lang.String mbrId ,
            @ModelAttribute("searchVO") JnitcmsmbrDefaultVO searchVO,
            HttpServletRequest request,
            ModelMap model)
            throws Exception {
    	String siteId = CmsHelper.getSessionSiteId(request);
    	String retTypeId = NullUtil.nullString(request.getParameter("retTypeId"));
    	
    	
    	//JSON
    	model.addAllAttributes(AdminJson(request, model));
    	
        JnitcmsmbrVO jnitcmsmbrVO = new JnitcmsmbrVO();
        jnitcmsmbrVO.setMbrId(mbrId);        
        // 변수명은 CoC 에 따라 jnitcmsmbrVO
        jnitcmsmbrVO = selectJnitcmsmbr(jnitcmsmbrVO, searchVO);
        String orgId = NullUtil.nullString(jnitcmsmbrVO.getOrgId());
        String rnakId = NullUtil.nullString(jnitcmsmbrVO.getRankId());
        
        JnitcmsrankVO rankVO = new JnitcmsrankVO();
        rankVO.setSearchKeyword(orgId);
        rankVO.setSearchCondition("4");
        rankVO.setPageYn("N");
    	List rankList = jnitcmsrankService.selectLeftJoinrankList(rankVO);    	
    	
    	model.addAttribute("rankList", rankList);
        model.addAttribute("rankId", rnakId);
        model.addAttribute("orgId", orgId);
        model.addAttribute(selectJnitcmsmbr(jnitcmsmbrVO, searchVO));
        model.addAttribute("result", selectJnitcmsmbr(jnitcmsmbrVO, searchVO));
        model.addAttribute("retTypeId", retTypeId);
        getTriggerModel(model);    	
        model.addAllAttributes(mbrProperties(request, model, siteId));
        model.addAttribute("DBTypeInfo", DBType.getGlobalInfoString());
        return "jnit/cms/sub2_1-2";
    }

    @RequestMapping("/cms/sub2/0102view.do")
    public @ModelAttribute("jnitcmsmbrVO")
    JnitcmsmbrVO selectJnitcmsmbr(
            JnitcmsmbrVO jnitcmsmbrVO,
            @ModelAttribute("searchVO") JnitcmsmbrDefaultVO searchVO) throws Exception {
        return jnitcmsmbrService.selectJnitcmsmbr(jnitcmsmbrVO);
    }

    @RequestMapping("/cms/sub2/0102up.do")
    public String updateJnitcmsmbr(
            @ModelAttribute("searchVO") JnitcmsmbrDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    SessionStatus status,
	    Model model)
            throws Exception {
    	
    	String retTypeId = NullUtil.nullString(request.getParameter("retTypeId"));
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	
    	 String rankId = NullUtil.nullString(request.getParameter("rank"));
         jnitcmsmbrVO.setRankId(rankId);
         
    	 	if(jnitcmsmbrVO.getEmailRecv() == null) {
    	 		jnitcmsmbrVO.setEmailRecv((byte)0);
    	 	}
    	 	
    	 	if(jnitcmsmbrVO.getSmsRecv() == null) {
    	 		jnitcmsmbrVO.setSmsRecv((byte)0);
    	 	}
    	 	
    		if(!NullUtil.nullString(jnitcmsmbrVO.getPasswd()).trim().equals("")) {
    			jnitcmsmbrVO.setPasswd(EgovFileScrty.encryptPassword(NullUtil.nullString(jnitcmsmbrVO.getPasswd()).trim()));
    		}
    		
    		//수정전 유형 데이터 정보로그
    		String typeNm = null;
    		JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    		mbrVO.setMbrId(jnitcmsmbrVO.getMbrId());
    		try {
				mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
				JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();
				typeVO.setTypeId(mbrVO.getTypeId());
				typeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(typeVO);
				typeNm = typeVO.getTypeNm();
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
    		
    		jnitcmsmbrVO = jnitcmsmbrfk(jnitcmsmbrVO); //
            jnitcmsmbrService.updateJnitcmsmbr(jnitcmsmbrVO);
            status.setComplete();
            
            MbrUtil.insertMbrlog(request, jnitcmsmbrVO, loginVO, "수정", "cms", typeNm);
	    	if(retTypeId.equals("")){
            	return "redirect:/cms/sub2/0101.do";
            }else{
            	return "redirect:/cms/sub2/0101.do?retTypeId="+retTypeId;
            }            
    }
    
    @RequestMapping("/cms/sub2/0102del.do")
    public String deleteJnitcmsmbr(
            JnitcmsmbrVO jnitcmsmbrVO,
            @ModelAttribute("searchVO") JnitcmsmbrDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsmbrService.deleteJnitcmsmbr(jnitcmsmbrVO);
        status.setComplete();
        return "forward:/cms/sub2/0101.do";
    }
    
    @RequestMapping("/cms/sub2/0102_Ajax.do")
    public String Ajax_0102(@ModelAttribute("searchVO") JnitcmsrankDefaultVO searchVO ,HttpServletRequest request
    		, ModelMap model)throws Exception{
    	String orgId = NullUtil.nullString(request.getParameter("orgId"));
    	searchVO.setSearchKeyword(orgId);
    	searchVO.setSearchCondition("4");
    	searchVO.setPageYn("N");
    	List rankList = jnitcmsrankService.selectLeftJoinrankList(searchVO);
    	
    	JSONArray json = new JSONArray();
    	json.add(rankList);
    	model.addAttribute("json", json.toString());
    	
    	return "jnit/util/json";
    }
    
    @RequestMapping("/cms/sub2/lock.do")
    public String lock(HttpServletRequest request, ModelMap model)throws Exception{
    	
    	String mbrId = NullUtil.nullString(request.getParameter("mbrId"));
    	String retTypeId = NullUtil.nullString(request.getParameter("retTypeId"));    	
    	
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    	mbrVO.setMbrId(mbrId);
    	mbrVO.setUpdateCondition("1");
    	mbrVO.setPwMiscnt(1);
    	jnitcmsmbrService.updateJnitcmsmbr(mbrVO);
    	
    	if(retTypeId.equals("")){
        	return "redirect:/cms/sub2/0101.do";
        }else{
        	return "redirect:/cms/sub2/0101.do?retTypeId="+retTypeId;
        }
    }
    
    /**
     * 
     * @param jnitcmsmbrVO
     * @param request
     * @param model
     * @return
     * @throws Exception     * 
     * {@link CmsSignupController #mbrLeaveOut(String, String, HttpServletRequest, ModelMap)} 회원가입 탈퇴
     */
    @RequestMapping("/cms/sub2/mbr/delete.do")
    public String mbrDelete(@ModelAttribute("jnitcmsmbrVO") JnitcmsmbrVO jnitcmsmbrVO
    		, HttpServletRequest request
    		, ModelMap model)throws Exception{
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	
    	String retTypeId = NullUtil.nullString(request.getParameter("retTypeId"));    
    	
    	//최고관리자 권한 체크 
    	String typeId = NullUtil.nullString(jnitcmsmbrVO.getTypeId());
    	if(!typeId.equals("")){
    		JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();
    		typeVO.setTypeId(typeId);
    		try {
				typeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(typeVO);
				if(typeVO.getTypeLv().equals("A")){
					model.addAttribute("alert", "최고관리자는 탈퇴할 수 없습니다.");
					model.addAttribute("path", "/cms/sub2/0102upview.do?mbrId="+jnitcmsmbrVO.getMbrId()+"&screenMode=up");
					return "/jnit/util/alertMove";
				}
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
    	}
    	
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();    	
    	//mbrVO.setOldId(mbrVO.getMbrLogin());    
    	mbrVO.setMbrId(jnitcmsmbrVO.getMbrId());
    	mbrVO.setMbrLogin(jnitcmsmbrVO.getMbrId());//MbrLogin으로 할 경우 한 사용자가 여러번 탈퇴할경우 제약조건 위배됨.
    	mbrVO.setOrgId(null);
    	mbrVO.setPosId(null);
    	mbrVO.setPasswd("#"+jnitcmsmbrVO.getMbrId());
    	//mbrVO.setMbrNm("#"+mbrVO.getMbrNm());
    	mbrVO.setMbrNm(jnitcmsmbrVO.getMbrId());
    	mbrVO.setTypeId("30016");//탈퇴회원
    	mbrVO.setTel("");
    	mbrVO.setMobile("");
    	mbrVO.setEmail("");
    	mbrVO.setHomepage("");
    	mbrVO.setPostcode("");
    	mbrVO.setAddress("");
    	mbrVO.setEmailRecv((byte)0);
    	mbrVO.setSmsRecv((byte)0);
    	mbrVO.setSn("");
    	mbrVO.setDp("");
    	
    	try {
    		jnitcmsmbrService.leaveJnitcmsmbr(mbrVO);
    	} catch (NullPointerException e){
    		log.error(e.getMessage());
			model.addAttribute("alert", "오류가 생겨 삭제처리가 실패하였습니다.");
			model.addAttribute("path", "/cms/sub2/0102upview.do?mbrId="+jnitcmsmbrVO.getMbrId()+"&screenMode=up");
			return "/jnit/util/alertMove";
		} catch (Exception e) {
			log.error(e.getMessage());
			model.addAttribute("alert", "오류가 생겨 삭제처리가 실패하였습니다.");
			model.addAttribute("path", "/cms/sub2/0102upview.do?mbrId="+jnitcmsmbrVO.getMbrId()+"&screenMode=up");
			return "/jnit/util/alertMove";
		}
		/** 2014-03-09 by.나성재 수정 항만 관련 내정보 등록 수정 탈퇴시 log정보 남김 */
    	JnitcmsmbrlogVO mbrlogVO = new JnitcmsmbrlogVO();
    	mbrlogVO.setMbrId(jnitcmsmbrVO.getMbrId());
    	mbrlogVO.setMbrLogin(jnitcmsmbrVO.getMbrLogin());
    	mbrlogVO.setMbrNm(jnitcmsmbrVO.getMbrNm());
    	mbrlogVO.setMbrlogContent("탈퇴");
    	mbrlogVO.setMbrIp(request.getRemoteAddr());
    	mbrlogVO.setActMbrLogin(loginVO.getMbrLogin());
    	mbrlogVO.setMbrlogPath("cms");
    	jnitcmsmbrlogService.insertJnitcmsmbrlog(mbrlogVO);
    	
		if(retTypeId.equals("")){
        	return "redirect:/cms/sub2/0101.do";
        }else{
        	return "redirect:/cms/sub2/0101.do?retTypeId="+retTypeId;
        }
    }
    
    public ModelMap AdminJson(HttpServletRequest request, ModelMap model)throws Exception{
    	
    	String retTypeId = NullUtil.nullString(request.getParameter("retTypeId"));
    	
    	if(retTypeId.equals("member")){
    		AdminUtil.setMenuId("m02020100");
    	}else if(retTypeId.equals("company")){
    		AdminUtil.setMenuId("m02020200");
    	}else if(retTypeId.equals("lock")){
    		AdminUtil.setMenuId("m02020400");
    	}else{
    		AdminUtil.setMenuId("m02020100");
    	}
    	return model;
    }
    
    private JnitcmsmbrVO jnitcmsmbrfk(JnitcmsmbrVO jnitcmsmbrVO)throws Exception{
    	if("".equals(NullUtil.nullString(jnitcmsmbrVO.getPosId()))) jnitcmsmbrVO.setPosId(null);
    	if("".equals(NullUtil.nullString(jnitcmsmbrVO.getOrgId()))) jnitcmsmbrVO.setOrgId(null);
    	return jnitcmsmbrVO;
    }
    
    private ModelMap mbrProperties(HttpServletRequest request, ModelMap model, String siteId)throws Exception{
    	JSONObject JSON = ConfigUtil.getProp(siteId);
    	model.addAttribute("mbrInfo", JSON);
    	return model;
    }
}