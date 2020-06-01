/**
 * @version 3.2.0.1
 */
package jnit.cms.tplhist;

import java.text.SimpleDateFormat;
import java.util.Date;
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

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.cms.tpl.tplUtil;
import net.sf.json.JSONObject;

/**
 * @Class Name : JnitcmstplhistController.java
 * @Description : Jnitcmstplhist Controller class
 * @Modification Information
 *
 * @author JNITCMSTPLHIST
 * @since 2014.05.02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmstplhistVO.class)
public class JnitcmstplhistController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmstplhistService")
    private JnitcmstplhistService jnitcmstplhistService;
    
    @Resource(name = "jnitcmstplService")
    private JnitcmstplService jnitcmstplService;
    
    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
    @Resource(name = "jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * JNITCMSTPLHIST 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmstplhistDefaultVO
	 * @return "/jnit/cms/jnitcmstplhist/JnitcmstplhistList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/tpl/hist/list.do")
    public String selectJnitcmstplhistList(@ModelAttribute("searchVO") JnitcmstplhistDefaultVO searchVO, 
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
		
        List jnitcmstplhistList = jnitcmstplhistService.selectJnitcmstplhistList(searchVO);
        model.addAttribute("resultList", jnitcmstplhistList);
        
        int totCnt = jnitcmstplhistService.selectJnitcmstplhistListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/hist/tpl/tplhistList";
    } 
    
    @RequestMapping("/cms/tpl/hist/add.do")
    public String addJnitcmstplhistView(
            @ModelAttribute("searchVO") JnitcmstplhistDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmstplhistService.getLastIdJnitcmstplhist());
        model.addAttribute("jnitcmstplhistVO", new JnitcmstplhistVO());
        return "/jnit/cms/hist/tpl/tplhistEdit";
    }
    
    @RequestMapping("/cms/tpl/hist/addProc.do")
    public String addJnitcmstplhist(
            @ModelAttribute("searchVO") JnitcmstplhistDefaultVO searchVO,
	    @ModelAttribute("jnitcmstplhistVO") JnitcmstplhistVO jnitcmstplhistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmstplhistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmstplhist/JnitcmstplhistRegister";
	// }

        jnitcmstplhistService.insertJnitcmstplhist(jnitcmstplhistVO);
        status.setComplete();
        return "forward:/cms/tpl/hist/list.do";
    }
    
    @RequestMapping("/cms/tpl/hist/edit.do")
    public String updateJnitcmstplhistView(
            @RequestParam("histId") java.lang.String histId ,
            @ModelAttribute("searchVO") JnitcmstplhistDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmstplhistVO jnitcmstplhistVO = new JnitcmstplhistVO();
        jnitcmstplhistVO.setHistId(histId);
        // 변수명은 CoC 에 따라 jnitcmstplhistVO
        model.addAttribute(selectJnitcmstplhist(jnitcmstplhistVO, searchVO));
        return "/jnit/cms/hist/tpl/tplhistEdit";
    }

    @RequestMapping("/jnitcmstplhist/selectJnitcmstplhist.do")
    public @ModelAttribute("jnitcmstplhistVO")
    JnitcmstplhistVO selectJnitcmstplhist(
            JnitcmstplhistVO jnitcmstplhistVO,
            @ModelAttribute("searchVO") JnitcmstplhistDefaultVO searchVO) throws Exception {
        return jnitcmstplhistService.selectJnitcmstplhist(jnitcmstplhistVO);
    }

    @RequestMapping("/cms/tpl/hist/editProc.do")
    public String updateJnitcmstplhist(
            @ModelAttribute("searchVO") JnitcmstplhistDefaultVO searchVO,
	    @ModelAttribute("jnitcmstplhistVO") JnitcmstplhistVO jnitcmstplhistVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmstplhistVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/jnitcmstplhist/JnitcmstplhistRegister";
	// }

        jnitcmstplhistService.updateJnitcmstplhist(jnitcmstplhistVO);
        status.setComplete();
        return "forward:/cms/tpl/hist/list.do";
    }
    
    @RequestMapping("/tpl/hist/deleteProc.do")
    public String deleteJnitcmstplhist(
            JnitcmstplhistVO jnitcmstplhistVO,
            @ModelAttribute("searchVO") JnitcmstplhistDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmstplhistService.deleteJnitcmstplhist(jnitcmstplhistVO);
        status.setComplete();
        return "forward:/cms/tpl/hist/list.do";
    }
    
    @RequestMapping("/cms/ajax/tpl/hist/list.do")
    public String ajaxtplHist(@ModelAttribute("searchVO") JnitcmstplhistDefaultVO searchVO    		
    		,HttpServletRequest request, ModelMap model)throws Exception{
    	String tplId = NullUtil.nullString(request.getParameter("tplId"));    	
    	String siteId = CmsHelper.getSessionSiteId(request);
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(5); //propertiesService.getInt("pageUnit")
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(NullUtil.nullInt(request.getParameter("pageIndex")) == 0 ? 1 : NullUtil.nullInt(request.getParameter("pageIndex"))); //searchVO.getPageIndex()
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setTplId(tplId);
		searchVO.setSiteId(siteId);
		
    	List tplHistList = jnitcmstplhistService.selectJnitcmstplhistList(searchVO);
    	
    	Iterator tplHistIterator = tplHistList.iterator();
    	
    	HashMap<String, String> mbrNmMap = new HashMap<String, String>();
    	HashMap<String, Date> dateMap = new HashMap<String, Date>();
    	
    	for(int i=0; i<tplHistList.size(); i++){
    		EgovMap tplHistEgovMap = (EgovMap) tplHistIterator.next();
    		String actMbr = String.valueOf(tplHistEgovMap.get("actMbr"));
    		String histId = String.valueOf(tplHistEgovMap.get("histId"));
    		JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    		mbrVO.setMbrId(actMbr);
    		try {
    			mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
    			mbrNmMap.put(histId, mbrVO.getMbrNm());
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());				
			}
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");			
			String created = NullUtil.nullString(String.valueOf(tplHistEgovMap.get("created")));
			if(!"".equals(created)) dateMap.put(histId, dateFormat.parse(created));
    	}    	
    	
        int totCnt = jnitcmstplhistService.selectJnitcmstplhistListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		model.addAttribute("dateMap", dateMap);
		model.addAttribute("tplId", tplId);
		model.addAttribute("mbrNmMap", mbrNmMap);
		model.addAttribute("resultList", tplHistList);
        model.addAttribute("paginationInfo", paginationInfo);
    	
    	return "/jnit/cms/hist/tpl/tplhistList"; 
    }
    
    @RequestMapping("/cms/ajax/tpl/hist.do")
    public String ajaxTplHist(HttpServletRequest request, ModelMap model)throws Exception{
    	String histId = NullUtil.nullString(request.getParameter("histId"));
    	
    	JSONObject JSON = new JSONObject();
    	try {
    		JnitcmstplhistVO tplHistVO = new JnitcmstplhistVO();
        	tplHistVO.setHistId(histId);
        	tplHistVO = jnitcmstplhistService.selectJnitcmstplhist(tplHistVO);
        	Boolean isdel = false;
        	/*if(!"".equals(NullUtil.nullString(tplHistVO.getTplDesc()))){
        		JnitcmstplVO subTplVO = new JnitcmstplVO();
        		subTplVO.setTplId(tplHistVO.getTplDesc());
        		subTplVO.setSelectCondition("1");
        		subTplVO = jnitcmstplService.selectJnitcmstpl(subTplVO);
        		if(subTplVO.getIsdel() == 1) isdel = true;
        	}*/
        	
        	JnitcmstplVO tplVO = new JnitcmstplVO();
        	tplVO.setTplId(tplHistVO.getTplId());
        	tplVO = jnitcmstplService.selectJnitcmstpl(tplVO);
        	
        	tplVO.setTplDesc(isdel == true ? null : tplHistVO.getTplDesc());
        	tplVO.setTplSrc(tplHistVO.getTplSrc());
        	jnitcmstplService.updateJnitcmstpl(tplVO);
        	
        	JnitcmssiteVO siteVO = new JnitcmssiteVO();
        	siteVO.setSiteId(tplHistVO.getSiteId());
        	siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        	
        	//TPL File 저장
        	tplUtil.tplWrite(request, tplVO, siteVO);        	
        	
        	String ctxRoot = request.getContextPath();        	
        	if("B".equals(tplVO.getTplType())){
        		JSON = JSON.fromObject(tplVO);
        		JSON.put("ctxRoot", ctxRoot);        		
        		if(JSON.get("path") == null) JSON.put("path", ctxRoot+"/cms/sub4/010201upview.do?screenMode=up&tplId="+tplVO.getTplId());
        	}
        	JSON.put("status", "success");
    	} catch (NullPointerException e){
    		log.error(e.getMessage());
			JSON.put("status", "error");
		} catch (Exception e) {
			log.error(e.getMessage());
			JSON.put("status", "error");
		}
		model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }

}
