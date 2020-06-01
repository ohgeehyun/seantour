/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminatehisotry;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.disseminate.JnitcmsdisseminateDefaultVO;
import jnit.cms.disseminate.JnitcmsdisseminateService;
import jnit.cms.mbr.JnitcmsmbrService;

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

/**
 * @Class Name : JnitcmsdisseminatehistoryController.java
 * @Description : Jnitcmsdisseminatehistory Controller class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATEHISTORY
 * @since 2013.11.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsdisseminatehistoryVO.class)
public class JnitcmsdisseminatehistoryController {

    @Resource(name = "jnitcmsdisseminatehistoryService")
    private JnitcmsdisseminatehistoryService jnitcmsdisseminatehistoryService;
    
    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
    
    @Resource(name = "jnitcmsdisseminateService")
    private JnitcmsdisseminateService jnitcmsdisseminateService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitcmsdisseminatehistory 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsdisseminatehistoryDefaultVO
	 * @return "/jnit/cms/disseminate/jnitcmsdisseminatehistory/JnitcmsdisseminatehistoryList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/disseminate/history.do")
    public String selectJnitcmsdisseminatehistoryList(@ModelAttribute("searchVO") JnitcmsdisseminatehistoryDefaultVO searchVO, 
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
		
        List jnitcmsdisseminatehistoryList = jnitcmsdisseminatehistoryService.selectJnitcmsdisseminatehistoryList(searchVO);
        model.addAttribute("resultList", jnitcmsdisseminatehistoryList);
        
        int totCnt = jnitcmsdisseminatehistoryService.selectJnitcmsdisseminatehistoryListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/disseminate/history/historyList";
    } 
    
    @RequestMapping("/jnitcmsdisseminatehistory/addJnitcmsdisseminatehistoryView.do")
    public String addJnitcmsdisseminatehistoryView(
            @ModelAttribute("searchVO") JnitcmsdisseminatehistoryDefaultVO searchVO, Model model)
            throws Exception {

        model.addAttribute("nid",  jnitcmsdisseminatehistoryService.getLastIdJnitcmsdisseminatehistory());
        model.addAttribute("jnitcmsdisseminatehistoryVO", new JnitcmsdisseminatehistoryVO());
        return "/jnit/cms/disseminate/jnitcmsdisseminatehistory/JnitcmsdisseminatehistoryRegister";
    }
    
    @RequestMapping("/jnitcmsdisseminatehistory/addJnitcmsdisseminatehistory.do")
    public String addJnitcmsdisseminatehistory(
            @ModelAttribute("searchVO") JnitcmsdisseminatehistoryDefaultVO searchVO,
	    @ModelAttribute("jnitcmsdisseminatehistoryVO") JnitcmsdisseminatehistoryVO jnitcmsdisseminatehistoryVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsdisseminatehistoryVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/disseminate/jnitcmsdisseminatehistory/JnitcmsdisseminatehistoryRegister";
	// }

        jnitcmsdisseminatehistoryService.insertJnitcmsdisseminatehistory(jnitcmsdisseminatehistoryVO);
        status.setComplete();
        return "forward:/jnitcmsdisseminatehistory/JnitcmsdisseminatehistoryList.do";
    }
    
    @RequestMapping("/jnitcmsdisseminatehistory/updateJnitcmsdisseminatehistoryView.do")
    public String updateJnitcmsdisseminatehistoryView(
            @RequestParam("historyId") java.lang.String historyId ,
            @ModelAttribute("searchVO") JnitcmsdisseminatehistoryDefaultVO searchVO, Model model)
            throws Exception {
        JnitcmsdisseminatehistoryVO jnitcmsdisseminatehistoryVO = new JnitcmsdisseminatehistoryVO();
        jnitcmsdisseminatehistoryVO.setHistoryId(historyId);
        // 변수명은 CoC 에 따라 jnitcmsdisseminatehistoryVO
        model.addAttribute(selectJnitcmsdisseminatehistory(jnitcmsdisseminatehistoryVO, searchVO));
        return "/jnit/cms/disseminate/jnitcmsdisseminatehistory/JnitcmsdisseminatehistoryRegister";
    }

    @RequestMapping("/jnitcmsdisseminatehistory/selectJnitcmsdisseminatehistory.do")
    public @ModelAttribute("jnitcmsdisseminatehistoryVO")
    JnitcmsdisseminatehistoryVO selectJnitcmsdisseminatehistory(
            JnitcmsdisseminatehistoryVO jnitcmsdisseminatehistoryVO,
            @ModelAttribute("searchVO") JnitcmsdisseminatehistoryDefaultVO searchVO) throws Exception {
        return jnitcmsdisseminatehistoryService.selectJnitcmsdisseminatehistory(jnitcmsdisseminatehistoryVO);
    }

    @RequestMapping("/jnitcmsdisseminatehistory/updateJnitcmsdisseminatehistory.do")
    public String updateJnitcmsdisseminatehistory(
            @ModelAttribute("searchVO") JnitcmsdisseminatehistoryDefaultVO searchVO,
	    @ModelAttribute("jnitcmsdisseminatehistoryVO") JnitcmsdisseminatehistoryVO jnitcmsdisseminatehistoryVO,
	    BindingResult bindingResult,
	    SessionStatus status)
            throws Exception {

  	// beanValidator.validate(jnitcmsdisseminatehistoryVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/cms/disseminate/jnitcmsdisseminatehistory/JnitcmsdisseminatehistoryRegister";
	// }

        jnitcmsdisseminatehistoryService.updateJnitcmsdisseminatehistory(jnitcmsdisseminatehistoryVO);
        status.setComplete();
        return "forward:/jnitcmsdisseminatehistory/JnitcmsdisseminatehistoryList.do";
    }
    
    @RequestMapping("/jnitcmsdisseminatehistory/deleteJnitcmsdisseminatehistory.do")
    public String deleteJnitcmsdisseminatehistory(
            JnitcmsdisseminatehistoryVO jnitcmsdisseminatehistoryVO,
            @ModelAttribute("searchVO") JnitcmsdisseminatehistoryDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsdisseminatehistoryService.deleteJnitcmsdisseminatehistory(jnitcmsdisseminatehistoryVO);
        status.setComplete();
        return "forward:/jnitcmsdisseminatehistory/JnitcmsdisseminatehistoryList.do";
    }
    
    @RequestMapping(value="/disseminate/ajaxHistory.do")
    public String ajaxHistoryList(@ModelAttribute("searchVO") JnitcmsdisseminatehistoryDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	
    	String mode = NullUtil.nullString(request.getParameter("mode"));
    	String sitePath = NullUtil.nullString(request.getParameter("sitePath"));
    	
    	model.addAttribute("mode", mode);
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(5);//searchVO.getPageUnit()
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		HashMap<String, String> mbrLineMap = new HashMap<String, String>();
		//history = cntId
		String cntId = NullUtil.nullString(request.getParameter("cntId"));
		searchVO.setSearchKeyword(cntId);
		searchVO.setSearchCondition("2");
        List historyList = jnitcmsdisseminatehistoryService.selectLeftJoinhistoryList(searchVO);
        //End history = cntId
        Iterator historyIterator = historyList.iterator();
        int k=1; //set Key value mbrLineMap
        
        for(int i=0; i<historyList.size(); i++){
        	EgovMap historyEgovMap = (EgovMap) historyIterator.next();
        	String mbrList = String.valueOf(historyEgovMap.get("disseminateLine"));
        	String historyId = String.valueOf(historyEgovMap.get("historyId"));
        	String[] mbrLists = mbrList.split(",");
        	String mbrLine = "";
        	
        	//mbrId split List for
        	int n=1;
        	for(int j=0; j<mbrLists.length; j++){        		
        		String sumNm = "";
        		String mbrNm = "";
        		String orgNm = "";
        		String posNm = "";        		
        		//Jnitcmsmbr = mbrId
        		JnitcmsdisseminateDefaultVO disseminateDefaultVO = new JnitcmsdisseminateDefaultVO();
        		disseminateDefaultVO.setSearchKeyword(mbrLists[j]);
        		disseminateDefaultVO.setPageYn("N");
        		disseminateDefaultVO.setIsdelYn("N");
        		disseminateDefaultVO.setSearchCondition("6");
        		List cmsmbrList = jnitcmsdisseminateService.selectdisseminateList(disseminateDefaultVO);
        		//End Jnitcmsmbr = mbrId
        		
        		if(cmsmbrList.size() > 0){ //회원 데이터가 있을시
        			Iterator cmsmbrIterator = cmsmbrList.iterator();        			
            		for(int l=0; l<cmsmbrList.size(); l++){            			
            			EgovMap cmsmbrEgovMap = (EgovMap) cmsmbrIterator.next(); 
                		mbrNm = String.valueOf(cmsmbrEgovMap.get("mbrNm"));
                		orgNm = String.valueOf(cmsmbrEgovMap.get("orgNm"));
                		posNm = String.valueOf(cmsmbrEgovMap.get("posNm"));
                		if(!orgNm.equals("null") && !posNm.equals("null")) sumNm = orgNm + "/" + posNm;
                		if(!orgNm.equals("null") && posNm.equals("null")) sumNm = orgNm;
                		if(orgNm.equals("null") && !posNm.equals("null")) sumNm = posNm;         		
            		}
        		}        		
        		if(mbrLine.equals("")){
        			if(sumNm.equals("")){
        				mbrLine = mbrNm+"→";
        				if(n == mbrLists.length) mbrLine = mbrLine.replace("→", "");
        			}else{
        				mbrLine = mbrNm + "(" + sumNm + ")→";
        				if(n == mbrLists.length) mbrLine = mbrLine.replace("→", "");
        			}
        		}else if(n < mbrLists.length){
        			if(sumNm.equals("")){
        				mbrLine = mbrLine + mbrNm+"→";
        			}else{
        				mbrLine = mbrLine + mbrNm + "(" + sumNm + ")→";
        			}
        		}else if(n == mbrLists.length){
        			if(sumNm.equals("")){
        				mbrLine = mbrLine + mbrNm;
        			}else{
        				mbrLine = mbrLine + mbrNm + "(" + sumNm + ")";
        			}
        		}
        		n++;        		
        	}
        	//end mbrId split List for
        	mbrLineMap.put(historyId, mbrLine);
        	k++;
        }
        int totCnt = jnitcmsdisseminatehistoryService.selectLeftJoinListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		 
		String historyId = NullUtil.nullString(request.getParameter("historyId"));
		//System.out.println("historyId : "+historyId);
		HashMap<String, String> memoMap = null; 
		ArrayList memoList = new ArrayList();
		if(!historyId.equals("")){
			
			JnitcmsdisseminatehistoryVO historyVO = new JnitcmsdisseminatehistoryVO();			
			historyVO.setSearchKeyword(historyId);
			historyVO.setSearchCondition("0");
			historyVO.setPageYn("N");
			List HistoryList = jnitcmsdisseminatehistoryService.selectLeftJoinhistoryList(historyVO);
			
			Iterator HistoryIterator = HistoryList.iterator();
			for(int e=0; e<HistoryList.size(); e++){
				EgovMap HistoryEgovMap = (EgovMap) HistoryIterator.next();				
				String hisMbrLine = String.valueOf(HistoryEgovMap.get("disseminateLine"));
				String historymbrNm = String.valueOf(HistoryEgovMap.get("mbrNm"));
				String historyMemo = String.valueOf(HistoryEgovMap.get("historyMemo"));				
				String[] hisMbrLines = hisMbrLine.split(",");
				String[] hisMemos = historyMemo.split(",");
				if(!hisMbrLine.equals("null")){
					memoMap = new HashMap<String, String>();
					memoMap.put("mbrNm", historymbrNm);
					memoMap.put("memo", hisMemos[0]);
					memoMap.put("index", "1");						
					memoList.add(memoMap);					
					k=1;
					for(int i=0; i<hisMbrLines.length; i++){					
						JnitcmsdisseminateDefaultVO jnitcmsdisseminateDefaultVO = new JnitcmsdisseminateDefaultVO();
						jnitcmsdisseminateDefaultVO.setSearchKeyword(hisMbrLines[i]);
						jnitcmsdisseminateDefaultVO.setPageYn("N");
						jnitcmsdisseminateDefaultVO.setIsdelYn("N");
						jnitcmsdisseminateDefaultVO.setSearchCondition("6");				
						List disseminateList = jnitcmsdisseminateService.selectdisseminateList(jnitcmsdisseminateDefaultVO);						
						if(disseminateList.size() > 0){							
							Iterator dIterator = disseminateList.iterator();							
							for(int j=0; j<disseminateList.size(); j++){								
								EgovMap dEgovMap = (EgovMap) dIterator.next();
								String mbrNm = String.valueOf(dEgovMap.get("mbrNm"));
								String memo = String.valueOf(dEgovMap.get("disseminateMemo"));
								
								memoMap = new HashMap<String, String>();
								memoMap.put("mbrNm", mbrNm);
								memoMap.put("memo", hisMemos[k]);
								memoMap.put("index", Integer.toString(k+1));						
								memoList.add(memoMap);								
							}
						}
						k++;
					}				
				}else{				
					memoMap = new HashMap<String, String>();
					memoMap.put("mbrNm", historymbrNm);
					memoMap.put("memo", hisMemos[0]);
					memoMap.put("index", "1");						
					memoList.add(memoMap);								
				}					
			}
		}
		
		model.addAttribute("sitePath", sitePath);
		model.addAttribute("memoList", memoList);
		model.addAttribute("cntId", cntId);
		model.addAttribute("mbrLineMap", mbrLineMap);
		model.addAttribute("resultList", historyList);
        model.addAttribute("paginationInfo", paginationInfo);
        if(mode.equals("pop")){
        	return "/jnit/cms/disseminate/history/contentHistory_popAjax";
        }else{
        	return "/jnit/cms/disseminate/history/contentHistory_Ajax";
        }        
    }   
}
