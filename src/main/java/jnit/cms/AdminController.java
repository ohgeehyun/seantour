/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.TreeMap;
import java.util.WeakHashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.analytics.HelloAnalyticsApi;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.util.PathUtil;
import jnit.visit.count.JnitvisitcountService;
import jnit.visit.count.visitUtil;
import jnit.visit.log.JnitvisitlogService;
import net.sf.json.JSONObject;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.NullUtil;

@Controller
public class AdminController {
    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    @Resource(name = "jnitvisitcountService")
    private JnitvisitcountService jnitvisitcountService;
    
    @Resource(name = "jnitvisitlogService")
    private JnitvisitlogService jnitvisitlogService;
    
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_INFO_PATH = "board" + SEPERATOR + "_info" + SEPERATOR;
    
    
    @RequestMapping("/cms/mgrCtl.do")
    public String cmsMain(HttpServletRequest request, ModelMap model) throws Exception {

    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
	    
    	if(loginVO.getMbrId() == null){
    		return "redirect:/cms/login.do";
    	}
	    JSONObject jsonObjGet = visitUtil.visitStats();
	    
	    WeakHashMap<String, Integer> totalMap = visitUtil.totalMap(model);
	    	    
	    //메인 페이지로 접속할땐 setMenuId 값을 false로 초기화. 값이 없으면 메인페이지 접근했다가 다시 뒤로 팅겨내기 때문에 초기 값인 false를 넣어줌. 
	    AdminUtil.setMenuId("false");
	    
		model.addAttribute("loginVO", loginVO);
		
		model.addAttribute("totalMap", totalMap);
		
		model.addAttribute("visitStats", jsonObjGet);
		
		String analyticsPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/defaultProp.prop";
		
		Properties cmsmainProp = new Properties();
		File currentDefaultPropFile = new File(analyticsPath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		if(currentDefaultPropFile.exists()){
			try {
				fis = new FileInputStream(currentDefaultPropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				cmsmainProp.load(isr);
			} catch (UnsupportedEncodingException e) {
				
			} catch (FileNotFoundException e) {
				
			} finally {
				isr.close();
				fis.close();
			}
			
		}
		String cmsmain = (String) cmsmainProp.get("cmsmain");
		if(NullUtil.nullString(cmsmain).equals("0")||NullUtil.nullString(cmsmain).equals("")){
			return "/jnit/sysinfo/main";
		}
		
		model.addAllAttributes(HelloAnalyticsApi.realTime(model, request));
		model.addAttribute("isFilegoActive", Globals.FILEGO_ACTIVE.toLowerCase().equals("on"));
		
		return "jnit/cms/main";
    }
    
    @RequestMapping("/cms/sample.do")
    public String cmsSample(HttpServletRequest request, ModelMap model) throws Exception {
    	AdminUtil.setMenuId("m06040204");

		return "jnit/cms/sample";
    }

    @RequestMapping("/cms/helper/cmsMenu.do")
    public String cmsMenu(HttpServletRequest request,
    		@RequestParam("menuId") java.lang.String menuId,
    		ModelMap model) throws Exception {
    	
    	String topMenuId = menuId.substring(0,3) + "000000";
    	
    	org.json.simple.JSONObject data = new org.json.simple.JSONObject();
    	
    	try{
    		data = (org.json.simple.JSONObject) new JSONParser().parse(AdminUtil.getJSON());
    	}catch(ParseException e){
    		model.addAttribute("path", "/");
    		model.addAttribute("alert", "로그인 세션이 종료되었습니다.");
    		return "/jnit/util/alertMove";
    	}
    	//JSONObject menuData = (JSONObject) data.get(topMenuId);
    	
    	
    	TreeMap<String, org.json.simple.JSONObject> dataMap = new TreeMap<String, org.json.simple.JSONObject>();
    	TreeMap<String, org.json.simple.JSONObject> treeMap = new TreeMap<String, org.json.simple.JSONObject>();

    	dataMap = AdminUtil.jobj2map(dataMap, data);
    	treeMap = AdminUtil.map2treemap(dataMap, treeMap);
    	
    	model.addAttribute("treeMap", treeMap.get(topMenuId));
    	model.addAttribute("menuId", AdminUtil.getMenuId());
    	dataMap = null;
    	treeMap = null;
		return "jnit/_common/leftMenu";
    }
    /*
    @RequestMapping("/cms/helper/cmsMenuNav.do")
    public String cmsMenuNav(HttpServletRequest request,
    		@RequestParam("menuId") java.lang.String menuId,
    		ModelMap model) throws Exception {
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
		model.addAttribute("loginVO", loginVO);
				
    	JSONObject data = (JSONObject) new JSONParser().parse(AdminUtil.getJSON());
    	JSONObject menuData = (JSONObject) data.get(menuId);
    	
    	
    	TreeMap<String, JSONObject> dataMap = new TreeMap<String, JSONObject>();
    	TreeMap<String, JSONObject> treeMap = new TreeMap<String, JSONObject>();

    	dataMap = AdminUtil.jobj2map(dataMap, data);
    	System.out.println("dataMap:"+ dataMap);    	

		TreeMap<String, Object> menuMap = AdminUtil.menuId2Map(dataMap, menuId);
		System.out.println("menuMap:"+ menuMap);		
    	
    	//String cMenuStr = treeMap.get(menuId).toJSONString();
    	//model.addAttribute("json", cMenuStr);
		model.addAttribute("menuMap", menuMap);
		
		return "jnit/_common/menuNav";
    }
    */
    
    /**
	 * Board Info Path 절대경로를 리턴한다.
	 * @param request - HttpServletRequest
	 * @return String Board Info Path
	 * @exception Exception
	 */
    public static String getBoardInfoPath(HttpServletRequest request){
    	
    	//String boardInfoPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + BOARD_INFO_PATH;
    	String visitInfoPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + BOARD_INFO_PATH;
    	return visitInfoPath;
    }
}