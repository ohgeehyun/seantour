package jnit.cms.menutree;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.AdminUtil;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;
import jnit.cms.menutree.JnitcmsmenutreeDefaultVO;
import jnit.cms.menutree.JnitcmsmenutreeService;
import jnit.cms.menutree.JnitcmsmenutreeVO;
import jnit.db.JnitdbService;
import jnit.db.JnitdbVO;

/**
 * @Class Name : JnitcmsmenutreeController.java
 * @Description : Jnitcmsmenutree Controller class
 * @Modification Information
 *
 * @author jnitcmsmenutree
 * @since 2018.01.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsmenutreeVO.class)
public class JnitcmsmenutreeController {

    @Resource(name = "jnitcmsmenutreeService")
    private JnitcmsmenutreeService jnitcmsmenutreeService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
   
    @RequestMapping(value="/cms/menutree/menuChangeSave.do")
    public String cmsmenutreeChangeSave(HttpServletRequest request,
            SessionStatus status,ModelMap model)
            throws Exception {
    	JnitcmsmenutreeDefaultVO searchVO = new JnitcmsmenutreeDefaultVO();
    	JnitcmsmenutreeVO jnitcmsmenutreeVO = new JnitcmsmenutreeVO();
    	searchVO.setFirstIndex(0);
    	searchVO.setRecordCountPerPage(100000);
    	List<?> jnitcmsmenutreeList = jnitcmsmenutreeService.selectJnitcmsmenutreeList(searchVO);
    	Iterator menuIterator = jnitcmsmenutreeList.iterator();
    	for(int j=0; j<jnitcmsmenutreeList.size(); j++){//m01010000,m02010000
    		EgovMap egovMap = (EgovMap) menuIterator.next();
    		jnitcmsmenutreeVO = new JnitcmsmenutreeVO();
    		String menuCodeId = String.valueOf(egovMap.get("menuCodeId")); 
    		String menuId = String.valueOf(egovMap.get("menuId")); 
    		String menuName = String.valueOf(egovMap.get("menuName")); 
    		String menuLink = String.valueOf(egovMap.get("menuLink")); 
    		String menuDepth = String.valueOf(egovMap.get("menuDepth")); 
    		String menuIcon = String.valueOf(egovMap.get("menuIcon")); 
    		String menuActive = String.valueOf(egovMap.get("menuActive")); 
    		String menuParent = String.valueOf(egovMap.get("menuParent")); 
    		String menuChild = String.valueOf(egovMap.get("menuChild")); 
    		
    		jnitcmsmenutreeVO.setMenuName(menuName);
    		jnitcmsmenutreeVO.setMenuLink(menuLink);
    		jnitcmsmenutreeVO.setMenuDepth(Integer.parseInt(menuDepth));
    		jnitcmsmenutreeVO.setMenuIcon(menuIcon);
    		jnitcmsmenutreeVO.setMenuActive(Integer.parseInt(menuActive));
    		jnitcmsmenutreeVO.setMenuParent(menuParent);
    		jnitcmsmenutreeVO.setMenuChild(Integer.parseInt(menuChild));
    		String reqMenuValue = NullUtil.nullString(request.getParameter(menuCodeId));
    		/*
    		System.out.println("menuCodeId : "+menuCodeId);
    		System.out.println("menuId : "+menuId);
    		System.out.println("reqMenuValue : "+reqMenuValue);
    		*/
    		jnitcmsmenutreeVO.setMenuCodeId(menuCodeId);
    		jnitcmsmenutreeVO.setMenuId(reqMenuValue);
    		jnitcmsmenutreeService.updateJnitcmsmenutree(jnitcmsmenutreeVO);
    	}
    	
    	model.addAttribute("resultList", jnitcmsmenutreeList);
    	JnitcmsmbrVO resVO = new JnitcmsmbrVO();	
    	resVO = (JnitcmsmbrVO) request.getSession().getAttribute("loginVO");
    	resVO.setCmsMenutree(AdminUtil.CmsMenuTree(resVO.getTypeId()));
		request.getSession().setAttribute("loginVO", resVO);
        
        status.setComplete();
        return "redirect:/cms/";
    }
       @RequestMapping(value="/menutree/dynamic.do")
       public String cmsmenutreeList(@ModelAttribute("searchVO") JnitcmsmenutreeDefaultVO searchVO, 
       		ModelMap model)
               throws Exception {
    	   		String typeId = "30020";
    	   		/*
    	   		
    	    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	    	HttpSession session = request.getSession();
    		    ServletContext context = session.getServletContext();
    	    	WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    	    	JnitcmsmbrtypeService jnitcmsmbrtypeService = (JnitcmsmbrtypeService) wContext.getBean("jnitcmsmbrtypeService");
    			
    	    	String DbType = EgovProperties.getProperty("Globals.DbType");
    	    	
    	    	String searchtypeId = "";
    	    	String menuactive ="";
    	    	if(!NullUtil.nullString(typeId).equals("")){
    	    		searchtypeId = typeId;

    	        	JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();
    	        	typeVO.setTypeId(searchtypeId);
    	        	JnitcmsmbrtypeVO typeresult = jnitcmsmbrtypeService.selectJnitcmsmbrtype(typeVO);
    	        	
    	        	if(!typeId.equals("30020") && NullUtil.nullString(typeresult.getMenuActive()).equals("")){
    	        		menuactive = "nodata";
    	        	}else{
    	        		menuactive = typeresult.getMenuActive();
    	        	}
    	        	
    	    	}
    	    	
    	    	String query = "";
    	    	
    	    	String menuIdrow = NullUtil.nullString(menuactive);
    			String menurow = "";
    			String Idrow[] = menuIdrow.split(",");
    			
    			for(int i=0;i<Idrow.length;i++){
    				if(i==0){
    					menurow = menurow+"'"+Idrow[i]+"'";
    				}else{
    					menurow = menurow+",'"+Idrow[i]+"'";
    				}
    			}
    			
    	    	if(NullUtil.nullString(menuactive).equals("")){
    	    		if(DbType.equals("oracle")||DbType.equals("Tibero")){
    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE '%' || '000000' AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    	    		}else{
    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE CONCAT ('%','000000') AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    	    		}
    	    	}else{
    	    		if(DbType.equals("oracle")||DbType.equals("Tibero")){
    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE '%' || '000000' AND MENU_CODE_ID IN("+menurow+") AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    	    		}else{
    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE CONCAT ('%','000000') AND MENU_CODE_ID IN("+menurow+") AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    	    		}
    	    	}
    	    	
    			JnitdbVO vo = new JnitdbVO();
    	    	vo.setQuery(query);
    	    	//vo.setQuery("select * from jnitcmsmenutree where menu_id LIKE CONCAT ('%','m02000000')");
    	    	
    			org.json.simple.JSONObject depth1 = new org.json.simple.JSONObject();
    	    	org.json.simple.JSONObject depth2 = new org.json.simple.JSONObject();
    	    	org.json.simple.JSONObject depth3 = new org.json.simple.JSONObject();
    	    	org.json.simple.JSONObject depth4 = new org.json.simple.JSONObject();
    	    	org.json.simple.JSONObject menuObject = new org.json.simple.JSONObject();

    	    	JnitdbService jnitdbService = (JnitdbService) wContext.getBean("jnitdbService");
    			
    	    	
    			List result = jnitdbService.selectList(vo);
    	    	
    			Iterator resultIterator = result.iterator();
    			for(int i=0; i<result.size(); i++){//m01000000,m02000000
    				EgovMap resultEgovMap = (EgovMap) resultIterator.next();
    				
    				String menuId = String.valueOf(resultEgovMap.get("menuId")); 

    		    	if(NullUtil.nullString(menuactive).equals("")){
    		    		if(DbType.equals("oracle")||DbType.equals("Tibero")){
    		    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE '"+menuId.substring(0,3)+"' || '%' || '0000' AND menu_id NOT IN('"+menuId+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    		    		}else{
    		    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE CONCAT ('"+menuId.substring(0,3)+"','%','0000') AND menu_id NOT IN('"+menuId+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    		    		}
    		    	}else{
    		    		if(DbType.equals("oracle")||DbType.equals("Tibero")){
    		    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE '"+menuId.substring(0,3)+"'||'%'||'0000' AND menu_id NOT IN('"+menuId+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    		    		}else{
    		    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE CONCAT ('"+menuId.substring(0,3)+"','%','0000') AND menu_id NOT IN('"+menuId+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    		    		}
    		    	}
    		    	
    		    	vo.setQuery(query);
    		    	List subMenu1List = jnitdbService.selectList(vo);
    		    	
    		    	Iterator subMenu1Iterator = subMenu1List.iterator();
    		    	for(int j=0; j<subMenu1List.size(); j++){//m01010000,m02010000
    		    		EgovMap subMenuId1EgovMap = (EgovMap) subMenu1Iterator.next();
    		    		String subMenuId1 = String.valueOf(subMenuId1EgovMap.get("menuId")); 
    		    		if(!subMenuId1.equals(menuId)){

    		    	    	if(NullUtil.nullString(menuactive).equals("")){
    		    	    		if(DbType.equals("oracle")||DbType.equals("Tibero")){
    		    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE '"+subMenuId1.substring(0,5)+"'||'%'||'00' AND menu_id NOT IN('"+subMenuId1+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    		    	    		}else{
    		    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE CONCAT ('"+subMenuId1.substring(0,5)+"','%','00') AND menu_id NOT IN('"+subMenuId1+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    		    	    		}
    		    	    	}else{	
    		    	    		if(DbType.equals("oracle")||DbType.equals("Tibero")){
    		    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE '"+subMenuId1.substring(0,5)+"'||'%'||'00' AND menu_id NOT IN('"+subMenuId1+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    		    	    		}else{
    		    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE CONCAT ('"+subMenuId1.substring(0,5)+"','%','00') AND menu_id NOT IN('"+subMenuId1+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    		    	    		}
    		    	    	}
    		    	    	
    		    			vo.setQuery(query);
    			    		List subMenu2List = jnitdbService.selectList(vo);
    			    		Iterator subMenu2Iterator = subMenu2List.iterator();
    			    		for(int k=0; k<subMenu2List.size(); k++){//m01010100,m02010100
    			    			EgovMap subMenuId2EgovMap = (EgovMap) subMenu2Iterator.next();
    				    		String subMenuId2 = String.valueOf(subMenuId2EgovMap.get("menuId"));  
    				    		if(!subMenuId2.equals(subMenuId1)){
    				    			
    				    			if(NullUtil.nullString(menuactive).equals("")){
    				    	    		if(DbType.equals("oracle")){
    				    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE '"+subMenuId2.substring(0,7)+"'||'%' AND menu_id NOT IN('"+subMenuId2+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    				    	    		}else{
    				    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE CONCAT ('"+subMenuId2.substring(0,7)+"','%') AND menu_id NOT IN('"+subMenuId2+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    				    	    		}
    				    	    	}else{	
    				    	    		if(DbType.equals("oracle")){
    				    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE '"+subMenuId2.substring(0,7)+"'||'%' AND menu_id NOT IN('"+subMenuId2+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    				    	    		}else{
    				    	    			query = "select *,'File' from jnitcmsmenutree where menu_id LIKE CONCAT ('"+subMenuId2.substring(0,7)+"','%') AND menu_id NOT IN('"+subMenuId2+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1 ORDER BY  MENU_ID ASC";
    				    	    		}
    				    	    		}
    				    			
    				    			vo.setQuery(query);
    				    			List subMenu3List = jnitdbService.selectList(vo);
    				    			Iterator subMenu3Iterator = subMenu3List.iterator();
    					    		for(int l=0; l<subMenu3List.size(); l++){//m01010101,m02010101
    					    			EgovMap subMenuId3EgovMap = (EgovMap) subMenu3Iterator.next();
    						    		String subMenuId3 = String.valueOf(subMenuId3EgovMap.get("menuId"));  
    						    		if(!subMenuId2.equals(subMenuId3)){
    						    			menuObject = new org.json.simple.JSONObject();
    						    			menuObject.put("icon", String.valueOf(subMenuId3EgovMap.get("menuIcon")));
    						    			menuObject.put("link", String.valueOf(subMenuId3EgovMap.get("menuLink")));
    						    			menuObject.put("name", String.valueOf(subMenuId3EgovMap.get("menuName")));
    						    			menuObject.put("active", String.valueOf(subMenuId3EgovMap.get("menuActive")));
    						    			menuObject.put("codeId", String.valueOf(subMenuId3EgovMap.get("menuCodeId")));
    						    			menuObject.put("child", null);
    						    			depth4.put(subMenuId3,menuObject);
    						    		}
    					    		}
    					    		menuObject = new org.json.simple.JSONObject();
    				    			menuObject.put("icon", String.valueOf(subMenuId2EgovMap.get("menuIcon")));
    				    			menuObject.put("link", String.valueOf(subMenuId2EgovMap.get("menuLink")));
    				    			menuObject.put("name", String.valueOf(subMenuId2EgovMap.get("menuName")));
    				    			menuObject.put("active", String.valueOf(subMenuId2EgovMap.get("menuActive")));
    				    			menuObject.put("codeId", String.valueOf(subMenuId2EgovMap.get("menuCodeId")));
    				    			if(!depth4.isEmpty())menuObject.put("child", depth4);
    				    			
    				    			depth3.put(subMenuId2, menuObject);
    				    			depth4 = new org.json.simple.JSONObject();
    				    			subMenuId2EgovMap.put("child", subMenu3List);
    				    		}
    			    		}
    			    		menuObject = new org.json.simple.JSONObject();
    		    			menuObject.put("icon", String.valueOf(subMenuId1EgovMap.get("menuIcon")));
    		    			menuObject.put("link", String.valueOf(subMenuId1EgovMap.get("menuLink")));
    		    			menuObject.put("name", String.valueOf(subMenuId1EgovMap.get("menuName")));
    		    			menuObject.put("active", String.valueOf(subMenuId1EgovMap.get("menuActive")));
    		    			menuObject.put("codeId", String.valueOf(subMenuId1EgovMap.get("menuCodeId")));
    		    			if(!depth3.isEmpty())menuObject.put("child", depth3);
    		    			depth2.put(subMenuId1, menuObject);
    		    			depth3 = new org.json.simple.JSONObject();
    			    		subMenuId1EgovMap.put("child", subMenu2List);
    		    		}
    		    	}
    		    	menuObject = new org.json.simple.JSONObject();
    				menuObject.put("icon", String.valueOf(resultEgovMap.get("menuIcon")));
    				menuObject.put("link", String.valueOf(resultEgovMap.get("menuLink")));
    				menuObject.put("name", String.valueOf(resultEgovMap.get("menuName")));
    				menuObject.put("active", String.valueOf(resultEgovMap.get("menuActive")));
    				menuObject.put("codeId", String.valueOf(resultEgovMap.get("menuCodeId")));
    				if(!depth2.isEmpty())menuObject.put("child", depth2);
    				depth1.put(menuId, menuObject);
    				depth2 = new org.json.simple.JSONObject();
    		    	resultEgovMap.put("child", subMenu1List);
    		    	
    			}
    			GsonBuilder gsonBuilder = new GsonBuilder();
    		    Gson gson = gsonBuilder.create();
    	    	model.addAttribute("menuJson",gson.toJson(result));
    	    	*/
    	    	
    	    	

    			GsonBuilder gsonBuilder = new GsonBuilder();
    		    Gson gson = gsonBuilder.create();
    	    	model.addAttribute("menuJson",gson.toJson(jnitcmsmenutreeService.selectListAllActive(typeId)));
    	    	return "/jnit/cms/menutree/dynamic";
       } 
    
    /**
	 * jnitcmsmenutree 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsmenutreeDefaultVO
	 * @return "/jnitcmsmenutree/JnitcmsmenutreeList"
	 * @exception Exception
	 */
    @RequestMapping(value="/jnitcmsmenutree/List.do")
    public String selectJnitcmsmenutreeList(@ModelAttribute("searchVO") JnitcmsmenutreeDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
    	AdminUtil.setMenuId("m01050000");
    	
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
		
        List<?> jnitcmsmenutreeList = jnitcmsmenutreeService.selectJnitcmsmenutreeList(searchVO);
        model.addAttribute("resultList", jnitcmsmenutreeList);
        
        int totCnt = jnitcmsmenutreeService.selectJnitcmsmenutreeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/jnit/cms/menutree/menutreeList";
    } 
    
    @RequestMapping("/jnitcmsmenutree/add.do")
    public String addJnitcmsmenutreeView(
            @ModelAttribute("searchVO") JnitcmsmenutreeDefaultVO searchVO, Model model)
            throws Exception {
    	
    	AdminUtil.setMenuId("m01050000");
    	
        model.addAttribute("jnitcmsmenutreeVO", new JnitcmsmenutreeVO());
        return "/jnit/cms/menutree/menutreeEdit";
    }
    
    @RequestMapping("/jnitcmsmenutree/addproc.do")
    public String addJnitcmsmenutree(
            JnitcmsmenutreeVO jnitcmsmenutreeVO, HttpServletRequest request,
            @ModelAttribute("searchVO") JnitcmsmenutreeDefaultVO searchVO, SessionStatus status)
            throws Exception {
    	
    	String menuId = "";
		String depth1 = NullUtil.nullString(request.getParameter("depth1"));
		String depth2 = NullUtil.nullString(request.getParameter("depth2"));
		String depth3 = NullUtil.nullString(request.getParameter("depth3"));
				
		String searchStr = "";
		int num = 0;
		
			if(!depth3.equals("0")){
				
				searchStr = depth3.substring(0,7);
				jnitcmsmenutreeVO.setSearchKeyword(searchStr);
				jnitcmsmenutreeVO.setSearchCondition("4");
				num = jnitcmsmenutreeService.getlastId(jnitcmsmenutreeVO);
				num++;
				menuId = depth3.substring(0,7)+String.format("%02d", num);
				
				jnitcmsmenutreeVO.setMenuId(menuId);
				jnitcmsmenutreeVO.setMenuDepth(4);
				jnitcmsmenutreeVO.setMenuParent(depth3);
				
			}else if(!depth2.equals("0")){
				
				searchStr = depth2.substring(0,5);
				jnitcmsmenutreeVO.setSearchKeyword(searchStr);
				jnitcmsmenutreeVO.setSearchCondition("3");
				num = jnitcmsmenutreeService.getlastId(jnitcmsmenutreeVO);
				num++;
				menuId = depth2.substring(0,5)+String.format("%02d", num)+"00";
				
				jnitcmsmenutreeVO.setMenuId(menuId);
				jnitcmsmenutreeVO.setMenuDepth(3);
				jnitcmsmenutreeVO.setMenuParent(depth2);
				
			}else if(!depth1.equals("0")){
				
				searchStr = depth1.substring(0,3);
				jnitcmsmenutreeVO.setSearchKeyword(searchStr);
				jnitcmsmenutreeVO.setSearchCondition("2");
				num = jnitcmsmenutreeService.getlastId(jnitcmsmenutreeVO);
				num++;
				menuId = depth1.substring(0,3)+String.format("%02d", num)+"0000";
				
				jnitcmsmenutreeVO.setMenuId(menuId);
				jnitcmsmenutreeVO.setMenuDepth(2);
				jnitcmsmenutreeVO.setMenuParent(depth1);
				
			}else{
				
				searchStr = "000000";
				jnitcmsmenutreeVO.setSearchKeyword(searchStr);
				jnitcmsmenutreeVO.setSearchCondition("1");
				num = jnitcmsmenutreeService.getlastId(jnitcmsmenutreeVO);
				num++;
				menuId = "m"+String.format("%02d", num)+"000000";
				
				jnitcmsmenutreeVO.setMenuId(menuId);
				jnitcmsmenutreeVO.setMenuDepth(1);
				jnitcmsmenutreeVO.setMenuParent("null");
				
			}
        jnitcmsmenutreeService.insertJnitcmsmenutree(jnitcmsmenutreeVO);
        status.setComplete();
        return "forward:/jnitcmsmenutree/List.do";
    }
    
    @RequestMapping("/jnitcmsmenutree/Edit.do")
    public String updateJnitcmsmenutreeView(
            @RequestParam("menuCodeId") java.lang.String menuCodeId ,
            @ModelAttribute("searchVO") JnitcmsmenutreeDefaultVO searchVO, Model model)
            throws Exception {
    	
    	AdminUtil.setMenuId("m01050000");
    	
        JnitcmsmenutreeVO jnitcmsmenutreeVO = new JnitcmsmenutreeVO();
        jnitcmsmenutreeVO.setMenuCodeId(menuCodeId);        
        // 변수명은 CoC 에 따라 jnitcmsmenutreeVO
        model.addAttribute("jnitcmsmenutreeVO",selectJnitcmsmenutree(jnitcmsmenutreeVO, searchVO));
        return "/jnit/cms/menutree/menutreeEdit";
    }

    @RequestMapping("/jnitcmsmenutree/selectJnitcmsmenutree.do")
    public @ModelAttribute("jnitcmsmenutreeVO")
    JnitcmsmenutreeVO selectJnitcmsmenutree(
            JnitcmsmenutreeVO jnitcmsmenutreeVO,
            @ModelAttribute("searchVO") JnitcmsmenutreeDefaultVO searchVO) throws Exception {
        return jnitcmsmenutreeService.selectJnitcmsmenutree(jnitcmsmenutreeVO);
    }

    @RequestMapping("/jnitcmsmenutree/Editproc.do")
    public String updateJnitcmsmenutree(
            JnitcmsmenutreeVO jnitcmsmenutreeVO, HttpServletRequest request,
            @ModelAttribute("searchVO") JnitcmsmenutreeDefaultVO searchVO, SessionStatus status)
            throws Exception {
    	String menuId = NullUtil.nullString(request.getParameter("menuId"));
		String depth1 = NullUtil.nullString(request.getParameter("depth1"));
		String depth2 = NullUtil.nullString(request.getParameter("depth2"));
		String depth3 = NullUtil.nullString(request.getParameter("depth3"));
		String searchStr = "";
		int num = 0;
		
		if(menuId.equals(menuId.substring(0,7)+"00")){//menu가 3depth일때
			//3depth는 기존의 2depth가 아닌 다른 2depth 밑으로 이동 불가능) m01010100이 m01020100이 될수 없다는 이야기
			//3depth는 다른 3depth밑에 4depth가 될수 없음) m01010100이 m01010201이 될수 없다는 이야기
			//3depth메뉴가 1depth나 2depth메뉴가 될수 없음) m01010100이 m02000000 혹은 m01020000이 될수 없다는 이야기
			if(!depth3.equals("0") && depth3.equals(menuId)){//메뉴 depth에 대한 수정이 없을 경우
				
			}else{
				
			}
			
		}else if(menuId.equals(menuId.substring(0,5)+"0000")){//menu가 2depth일때
			//2depth는 기존의 1depth가 아닌 다른 1depth 밑으로 이동 가능) m01010000이 m02010000이 될수 있다는 이야기
			//2depth는 3depth나 4depth가 될수 없음) m01010000이 m01020100 혹은 m01020101이 될수 없다는 이야기
			//2depth메뉴는 1depth메뉴가 될수 있음) m01010000이 m02000000이 될수 있다는 이야기
			
			
		}else if(menuId.equals(menuId.substring(0,3)+"000000")){//menu가 1depth일때
			//1depth는 2depth나 3depth, 4depth가 될수 없음) m01000000이 m02010000혹은 m02010100, m02010101이 될수 없다는 이야기
			
			
		}else{//menu가 4depth일때
			//4depth는 기존의 3depth가 아닌 다른 3depth 밑으로 이동 불가능) m01010101이 m01010201이 될수 없다는 이야기
			//4depth는 1depth, 2depth, 3depth가 될수 없음) m01010101이 m02000000, m01020000, m01010200이 될수 없다는 이야기
			
			
		}
		
		
			if(!depth3.equals("0")&&!depth3.equals("")){
				
				if(!depth3.equals(menuId.substring(0,7)+"00")){
					searchStr = depth3.substring(0,7);
					jnitcmsmenutreeVO.setSearchKeyword(searchStr);
					jnitcmsmenutreeVO.setSearchCondition("4");
					num = jnitcmsmenutreeService.getlastId(jnitcmsmenutreeVO);
					num++;
					menuId = depth3.substring(0,7)+String.format("%02d", num);

					jnitcmsmenutreeVO.setMenuDepth(4);
					jnitcmsmenutreeVO.setMenuParent(depth3);
					
				}else if(depth3.equals(menuId.substring(0,7)+"00")){
					
				}else if(depth3.equals(menuId)){
					
				}
				
				jnitcmsmenutreeVO.setMenuId(menuId);
				
			}else if(!depth2.equals("0")&&!depth2.equals("")){
				if(!depth2.equals(menuId.substring(0,5)+"0000")){
					searchStr = depth2.substring(0,5);
					jnitcmsmenutreeVO.setSearchKeyword(searchStr);
					jnitcmsmenutreeVO.setSearchCondition("3");
					
					num = jnitcmsmenutreeService.getlastId(jnitcmsmenutreeVO);
					num++;
					menuId = depth2.substring(0,5)+String.format("%02d", num)+"00";	
					
					jnitcmsmenutreeVO.setMenuDepth(3);
					jnitcmsmenutreeVO.setMenuParent(depth2);
					
				}
				
				jnitcmsmenutreeVO.setMenuId(menuId);
				
			}else if(!depth1.equals("0")&&!depth1.equals("")){
				if(!depth1.equals(menuId.substring(0,3)+"000000")){
					searchStr = depth1.substring(0,3);
					jnitcmsmenutreeVO.setSearchKeyword(searchStr);
					jnitcmsmenutreeVO.setSearchCondition("2");
					num = jnitcmsmenutreeService.getlastId(jnitcmsmenutreeVO);
					num++;
					menuId = depth1.substring(0,3)+String.format("%02d", num)+"0000";

					jnitcmsmenutreeVO.setMenuDepth(2);
					jnitcmsmenutreeVO.setMenuParent(depth1);
				}
				
				jnitcmsmenutreeVO.setMenuId(menuId);
				
			}else{
				jnitcmsmenutreeVO.setMenuId(menuId);
				
			}
		
        jnitcmsmenutreeService.updateJnitcmsmenutree(jnitcmsmenutreeVO);
        status.setComplete();
        return "forward:/jnitcmsmenutree/List.do";
    }
    
    @RequestMapping("/jnitcmsmenutree/delete.do")
    public String deleteJnitcmsmenutree(
            JnitcmsmenutreeVO jnitcmsmenutreeVO,
            @ModelAttribute("searchVO") JnitcmsmenutreeDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitcmsmenutreeService.deleteJnitcmsmenutree(jnitcmsmenutreeVO);
        status.setComplete();
        return "forward:/jnitcmsmenutree/List.do";
    }

	/**
	 * 뎁스에 대한 메뉴 Select
	 */
	@RequestMapping(value="/cms/menutree/subset.do")
	public String subSet(@RequestParam(value="menuId") String menuCode, ModelMap model)throws Exception{
		
		String codeValue = NullUtil.nullString(menuCode);
		model.addAttribute("json",jnitcmsmenutreeService.subset(codeValue));		
		
		return "/jnit/util/json";
	}
	
}
