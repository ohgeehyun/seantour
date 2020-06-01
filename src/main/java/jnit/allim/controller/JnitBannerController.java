/**
 * @version 3.2.0.1
 */
package jnit.allim.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.allim.group.JnitallimGroupDefaultVO;
import jnit.allim.group.JnitallimGroupService;
import jnit.allim.item.JnitallimItemService;
import jnit.com.util.DBType;
import oracle.sql.CLOB;

@Controller
public class JnitBannerController {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitallimItemService")
    private JnitallimItemService jnitallimItemService;
    
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;
	
    /*group service*/
    @Resource(name = "jnitallimGroupService")
    private JnitallimGroupService jnitallimGroupService;
	
	@RequestMapping(value="/jnitallim/bannerRolling.do")	
	public String bannerRolling(@ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO,
		HttpServletRequest request,
		ModelMap model)
	    throws Exception {
				
		String groupId = request.getParameter("groupId");
		String bannerMorePath = NullUtil.nullString(request.getParameter("bannerMorePath"));
		String bannerType = NullUtil.nullString(request.getParameter("bannerType"));
		String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
		
		searchVO.setSearchCondition("0");
		searchVO.setSearchKeyword(groupId);
		List groupList = jnitallimGroupService.selectGroupList(searchVO);		
		int itemsize = groupList.size();
		
		Iterator list = (Iterator) groupList.iterator();
		HashMap<String, String> bannerAltMap = new HashMap<String, String>();
		while(list.hasNext()){
			EgovMap List = (EgovMap)list.next();
			int Direction = Integer.parseInt(String.valueOf(List.get("groupDirection")));
			int ShowItems = Integer.parseInt(String.valueOf(List.get("groupShowitems")));
			int TimerDelay = Integer.parseInt(String.valueOf(List.get("groupTimerdelay")));
			int AnimationDelay = Integer.parseInt(String.valueOf(List.get("groupAnimationdelay")));
			int Auto = Integer.parseInt(String.valueOf(List.get("groupAuto")) );
			int ImgWidth = Integer.parseInt(String.valueOf(List.get("groupWidth")) );
			int ImgHeight = Integer.parseInt(String.valueOf(List.get("groupHeight")) );
			String itemId = String.valueOf(List.get("itemId"));
			
			model.addAttribute("ImgWidth", ImgWidth);
			model.addAttribute("ImgHeight", ImgHeight);
			model.addAttribute("Direction", Direction);
			model.addAttribute("ShowItems", ShowItems);
			model.addAttribute("TimerDelay", TimerDelay);
			model.addAttribute("AnimationDelay", AnimationDelay);
			model.addAttribute("Auto", Auto);
			
			if(DBType.getDbTypeBoolean("oracle")){
				
				CLOB bannerAlt = (CLOB) List.get("itemAlt");				
				if(bannerAlt != null){
					StringBuffer sb = new StringBuffer();
					try {
						Reader reader = bannerAlt.getCharacterStream();
						BufferedReader br = new BufferedReader(reader);
						String line = "";
						while ((line = br.readLine()) != null) {
							sb.append(line+"\r\n"); 
						}
						br.close();
					} catch (IOException e){
     					log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}					
					bannerAltMap.put(itemId, sb.toString());
				}				
			}else if(DBType.getDbTypeBoolean("tibero")){
				com.tmax.tibero.jdbc.TbClob bannerAlt = (com.tmax.tibero.jdbc.TbClob) List.get("itemAlt");				
				if(bannerAlt != null){
					StringBuffer sb = new StringBuffer();
					try {
						Reader reader = bannerAlt.getCharacterStream();
						BufferedReader br = new BufferedReader(reader);
						String line = "";
						while ((line = br.readLine()) != null) {
							sb.append(line+"\r\n"); 
						}
						br.close();
					} catch (IOException e){
     					log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}					
					bannerAltMap.put(itemId, sb.toString());
				}		
			}
		}
		model.addAttribute("DBType", DBType.getDbTypeString());
		model.addAttribute("bannerAltMap", bannerAltMap);
		model.addAttribute("bannerMorePath", bannerMorePath);
		model.addAttribute("groupId", groupId);
		model.addAttribute("groupList", groupList);
		model.addAttribute("itemsize", itemsize);
		
		if(!"".equals(groupCategory)){
			return "/jnit/allim/skin/banner/"+groupCategory;
		}else{
			return "/jnit/allim/skin/banner/bannerRolling";
		}
	}
	@RequestMapping(value="/jnitallim/bannerMore.do")	
	public String bannerMore(@ModelAttribute("searchVO") JnitallimGroupDefaultVO searchVO,
		HttpServletRequest request,
		ModelMap model)
	    throws Exception {
		
		String groupId = NullUtil.nullString(request.getParameter("groupId"));
		String mode = NullUtil.nullString(request.getParameter("mode"));
		String groupCategory = NullUtil.nullString(request.getParameter("groupCategory"));
		
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
				
		searchVO.setSearchCondition("0");
		searchVO.setSearchKeyword(groupId);		
		List moreList = jnitallimGroupService.selectMoreList(searchVO);
		
		if(DBType.getDbTypeBoolean("oracle")){
			HashMap<String, String> itemAltMap = new HashMap<String, String>();
			Iterator moreIterator = moreList.iterator();
			for(int i=0; i<moreList.size(); i++){
				EgovMap moreEgovMap = (EgovMap) moreIterator.next();
				String itemId = String.valueOf(moreEgovMap.get("itemId"));
				CLOB itemAlt = (CLOB) moreEgovMap.get("itemAlt");
				if(itemAlt != null){
					StringBuffer sb = new StringBuffer();
					try {								
						
						Reader reader = itemAlt.getCharacterStream();
						BufferedReader br = new BufferedReader(reader);
						String line = "";
						while ((line = br.readLine()) != null) {
							sb.append(line+"\r\n");
						}
						br.close();
					} catch (IOException e){
     					log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					itemAltMap.put(itemId, sb.toString());					
				}				
			}			
			model.addAttribute("itemAltMap", itemAltMap);
		}else if(DBType.getDbTypeBoolean("tibero")){
			HashMap<String, String> itemAltMap = new HashMap<String, String>();
			Iterator moreIterator = moreList.iterator();
			for(int i=0; i<moreList.size(); i++){
				EgovMap moreEgovMap = (EgovMap) moreIterator.next();
				String itemId = String.valueOf(moreEgovMap.get("itemId"));
				com.tmax.tibero.jdbc.TbClob itemAlt = (com.tmax.tibero.jdbc.TbClob) moreEgovMap.get("itemAlt");
				if(itemAlt != null){
					StringBuffer sb = new StringBuffer();
					try {								
						
						Reader reader = itemAlt.getCharacterStream();
						BufferedReader br = new BufferedReader(reader);
						String line = "";
						while ((line = br.readLine()) != null) {
							sb.append(line+"\r\n");
						}
						br.close();
					} catch (IOException e){
     					log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					itemAltMap.put(itemId, sb.toString());					
				}				
			}			
			model.addAttribute("itemAltMap", itemAltMap);
		}
		
        int totCnt = jnitallimGroupService.selectGroupListTotCnt(searchVO);        
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("DBType", DBType.getDbTypeString());
        model.addAttribute("moreList", moreList);
        model.addAttribute("paginationInfo", paginationInfo);
        
        if(!"".equals(groupCategory)){
        	return "/jnit/allim/skin/banner/"+groupCategory;
        }else{
        	return "/jnit/allim/skin/banner/bannerMore";
        }		
	}	
}
