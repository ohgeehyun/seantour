/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.menutree.JnitcmsmenutreeService;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.util.PathUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.jsoup.nodes.Document;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;


/**
 * JNITCMS Admin에 관한 Util Class 
 * @version : 1.0
 * @author  : Dael (dael@daelity.com)
 */
public class AdminUtil{
	
	public static Log log = LogFactory.getLog(AdminUtil.class);
	
    @Resource(name = "jnitcmsmbrService")
    public static final String SEPERATOR = File.separator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    
    public static String getJSON(){
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) request.getAttribute("loginVO");
    	if(loginVO == null){
    		loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	}
		/*
    	String jsonData = "";
    	try{
    		String jsonFile = "";
    		if(!loginVO.getTypeId().equals("")){
    			jsonFile = PathUtil.getRealPath(request) + "/WEB-INF/config/jnit/"+NullUtil.nullString(loginVO.getTypeId())+".json";
    			jsonData = CmsHandler.readFile(jsonFile);
    		}else{
    			jsonFile = "";
    			jsonData = "";
    		}
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
	    return jsonData;*/
		return loginVO.getCmsMenutree();
    }
    
    public static String getJSONList() throws IOException{
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) request.getAttribute("loginVO");
    	if(loginVO == null){
    		loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	}
    	String jsonData = "";
    	try{
			String jsonFile = PathUtil.getRealPath(request)+ "/WEB-INF/config/jnit/"+NullUtil.nullString(loginVO.getTypeId())+".json";
		    	jsonData = CmsHandler.readFile(jsonFile);
    	} catch (IOException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
	    return jsonData;
    }
    
    /**
     * request Attribute에 gnb를 셋팅한다.
     */
    public static void setGnb(){
		JSONObject data = null;
		try {
			data = (JSONObject) new JSONParser().parse(AdminUtil.getJSON());
		} catch (ParseException e) {
			log.error(e.getMessage());
		}
		
		ArrayList depth1key = new ArrayList();
		TreeMap depth1 = new TreeMap();
		Set set = data.keySet();
		if(set == null) set = new HashSet();
		Iterator itr = set.iterator();
		while(itr.hasNext()){
			String key = (String) itr.next();
			depth1key.add(key);
		}
		Collections.sort(depth1key);
		for(int i = 0;i<depth1key.size();i++){
			depth1.put(depth1key.get(i),data.get(depth1key.get(i)));
		}
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		request.setAttribute("gnb",depth1);

    }
    public static void setGnbList(){
		JSONObject data = null;
		try {
			data = (JSONObject) new JSONParser().parse(AdminUtil.CmsMenuTree("")/*getJSONList()*/);
		} catch (ParseException e) {
			log.error(e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		
		ArrayList depth1key = new ArrayList();
		TreeMap depth1 = new TreeMap();
		Set set = data.keySet();
		if(set == null) set = new HashSet();
		Iterator itr = set.iterator();
		while(itr.hasNext()){
			String key = (String) itr.next();
			depth1key.add(key);
		}
		Collections.sort(depth1key);
		for(int i = 0;i<depth1key.size();i++){
			depth1.put(depth1key.get(i),data.get(depth1key.get(i)));
		}
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		request.setAttribute("gnb",depth1);

    }
    public static TreeMap getGnb() throws IOException{
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) request.getAttribute("loginVO");
    	TreeMap depth1 = new TreeMap();
    	try{
			JSONObject data = (JSONObject) new JSONParser().parse(getJSON());
			
			ArrayList depth1key = new ArrayList();
			depth1 = new TreeMap();
			Set set = data.keySet();
			if(set == null) set = new HashSet();
			Iterator itr = set.iterator();
			while(itr.hasNext()){
				String key = (String) itr.next();
				depth1key.add(key);
			}
			Collections.sort(depth1key);
			for(int i = 0;i<depth1key.size();i++){
				depth1.put(depth1key.get(i),data.get(depth1key.get(i)));
			}
			if(loginVO.getTypeId().equals("30020")){
				String jsonFile = PathUtil.getRealPath(request)
				+ "/WEB-INF/config/jnit/adminMenuTree_"+loginVO.getTypeVO().getTypeLv()+".json";
			    	String jsonData = CmsHandler.readFile(jsonFile);
			}else{
				String jsonFile = PathUtil.getRealPath(request)
				+ "/WEB-INF/config/jnit/"+loginVO.getTypeId()+".json";
			    	String jsonData = CmsHandler.readFile(jsonFile);
			}
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}

	    return depth1;
    }
    /**
     * request Attribute에 menuId를 셋팅한다.<br />
     * setting된 menuId를 참조하여 현재페이지를 알 수 있다.
     * @param menuId - 해당메뉴의 menuId ex) m06040204
     */
    public static void setMenuId(String menuId){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		request.setAttribute("menuId",menuId);
		request.getSession().setAttribute("menuId", menuId);

    }
    /**
     * request Attribute의 menuId를 가져온다.<br />
     * setting된 menuId를 참조하여 현재페이지를 알 수 있다.
     * @return menuId - 해당메뉴의 menuId ex) m06040204
     */
    public static String getMenuId(){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String menuId = NullUtil.nullString((String) request.getAttribute("menuId"));
		menuId = (String) ("".equals(menuId) ? request.getSession().getAttribute("menuId") : menuId);
		return menuId;

    }
    /**
     * menuId의 name을 가져온다.
     * @param menuId - 불러올 메뉴의 MenuId
     * @return name - 해당메뉴의 name
     */
    public static String getMenuName(String menuId){
    	String menuName = "";
    	try{
    		JSONObject data = (JSONObject) new JSONParser().parse(getJSON());
    		TreeMap<String, JSONObject> dataMap = new TreeMap<String, JSONObject>();
    		jobj2map(dataMap, data);
    		menuName = String.valueOf(dataMap.get(menuId).get("name"));
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
		return menuName;

    }
    /**
     * menuId의 Attribute들을 가져온다.
     * @param menuId - 불러올 메뉴의 MenuId
     * @return JSONObject - 해당메뉴의 Attributes
     */
    public static JSONObject getMenuAttr(String menuId){
    	JSONObject jObj = new JSONObject();
    	try{
    		JSONObject data = (JSONObject) new JSONParser().parse(getJSON());
    		TreeMap<String, JSONObject> dataMap = new TreeMap<String, JSONObject>();
    		jobj2map(dataMap, data);
    		jObj = dataMap.get(menuId);
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}
		return jObj;

    }
    
    public static TreeMap<String, JSONObject> map2treemap(TreeMap<String, JSONObject> dataMap, TreeMap<String, JSONObject> treeMap) {
    	
    	Iterator keys = dataMap.keySet().iterator();
    	String[] parentData = {"", "", ""};
    	while(keys.hasNext()) {
    		String key = (String) keys.next();
			JSONObject cData = (JSONObject)dataMap.get(key);
			
			if(key.substring(3).equals("000000")) {
				//1
				parentData[0] = key;
				treeMap.put(key, (JSONObject)cData.clone());
			}else if(key.substring(5).equals("0000")) {
				//2
				parentData[1] = key;
				
				TreeMap<String, JSONObject> parentChildObj;
				if(NullUtil.isEmpty((TreeMap<String, JSONObject>) treeMap.get(parentData[0]).get("child"))) {
					parentChildObj = new TreeMap<String, JSONObject>();
					((JSONObject) treeMap.get(parentData[0])).put("child", parentChildObj);
				}else {
					parentChildObj = (TreeMap<String, JSONObject>) treeMap.get(parentData[0]).get("child");
				}
				
				//log.debug(parentChildObj);
				parentChildObj.put(key, (JSONObject)cData.clone());
			}else if(key.substring(7).equals("00")) {
				//3
				parentData[2] = key;
				
				TreeMap<String, JSONObject> parentChildObj;
				if(NullUtil.isEmpty( ((TreeMap<String, JSONObject>)((TreeMap<String, JSONObject>) treeMap.get(parentData[0]).get("child"))).get(parentData[1]).get("child") )) {
					parentChildObj = new TreeMap<String, JSONObject>();
					((TreeMap<String, JSONObject>)((TreeMap<String, JSONObject>) treeMap.get(parentData[0]).get("child"))).get(parentData[1]).put("child", parentChildObj);
				}else {
					parentChildObj = (TreeMap<String, JSONObject>)((TreeMap<String, JSONObject>) treeMap.get(parentData[0]).get("child")).get(parentData[1]).get("child");
				}
				
				//log.debug(parentChildObj);
				parentChildObj.put(key, (JSONObject)cData.clone());
			}else {
				//4
				TreeMap<String, JSONObject> parentChildObj;
				if(NullUtil.isEmpty( (TreeMap<String, JSONObject>)((TreeMap<String, JSONObject>)((TreeMap<String, JSONObject>) treeMap.get(parentData[0]).get("child")).get(parentData[1]).get("child")).get(parentData[2]).get("child") )) {
					parentChildObj = new TreeMap<String, JSONObject>();
					((TreeMap<String, JSONObject>)((TreeMap<String, JSONObject>) treeMap.get(parentData[0]).get("child")).get(parentData[1]).get("child")).get(parentData[2]).put("child", parentChildObj);
				}else {
					parentChildObj = (TreeMap<String, JSONObject>)((TreeMap<String, JSONObject>)((TreeMap<String, JSONObject>) treeMap.get(parentData[0]).get("child")).get(parentData[1]).get("child")).get(parentData[2]).get("child");
				}
				
				//log.debug(parentChildObj);
				parentChildObj.put(key, (JSONObject)cData.clone());
			}
    	}
    	
    	return treeMap;
    }
    public static TreeMap<String, JSONObject> jobj2map(TreeMap<String, JSONObject> dataMap, JSONObject jData) {
    	Set set = jData.keySet();
		if(set == null) set = new HashSet();
		Iterator keys = set.iterator();
		
    	while(keys.hasNext()) {
			String key = (String) keys.next();
			JSONObject cData = (JSONObject)jData.get(key);
			//log.debug( key );
			
			JSONObject pData = (JSONObject)cData.clone();
			pData.remove("child");
			dataMap.put(key, pData);
			
			if( !NullUtil.isEmpty(cData.get("child")) && !((JSONObject)cData.get("child")).isEmpty() ) {
				//log.debug( key + " " + (JSONObject)cData.get("child") );
				dataMap = jobj2map(dataMap, (JSONObject)cData.get("child"));
			}
    	}
    	return dataMap;
    }
    public static TreeMap<String, Object> menuId2Map(TreeMap<String, JSONObject> dataMap, String menuId) {
    	TreeMap<String, Object> menuMap = new TreeMap<String, Object>();
    	
    	int depth = 4;
    	if(menuId.substring(7, 9).equals("00")) {
    		depth--;
    	}else {
    		String depthMenuId = "m"+menuId.substring(1, 3)+menuId.substring(3, 5)+menuId.substring(5, 7)+menuId.substring(7, 9);
    		JSONObject depth4obj = dataMap.get(depthMenuId);
    		menuMap.put("depth4", depth4obj);
    	}
    	
    	if(menuId.substring(5, 7).equals("00")) {
    		depth--;
    	}else {
    		String depthMenuId = "m"+menuId.substring(1, 3)+menuId.substring(3, 5)+menuId.substring(5, 7)+"00";
    		JSONObject depth3obj = dataMap.get(depthMenuId);
    		menuMap.put("depth3", depth3obj);
    	}
    	
    	if(menuId.substring(3, 5).equals("00")) {
    		depth--;
    	}else {
    		String depthMenuId = "m"+menuId.substring(1, 3)+menuId.substring(3, 5)+"0000";
    		JSONObject depth2obj = dataMap.get(depthMenuId);
    		menuMap.put("depth2", depth2obj);
    	}
    	
    	if(menuId.substring(1, 3).equals("00")) {
    		depth--;
    	}else {
    		String depthMenuId = "m"+menuId.substring(1, 3)+"000000";
    		JSONObject depth1obj = dataMap.get(depthMenuId);
    		menuMap.put("depth1", depth1obj);
    	}
    	
    	if(depth == 0) {
    		return menuMap;
    	}
    	
    	menuMap.put("depth", depth);
    	
    	return menuMap;
    }
    
    public static List typeMenuListGet(String typeId) throws IOException{
    	
    	List menuList = new ArrayList();
    	
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String jsonStr = "";
    	try {
			jsonStr = CmsMenuTree(typeId);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
    	
    	
		/*
    	String typePath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/"+typeId+".json";
    	
    	File path = new File(typePath);
    	String jsonStr = FileUtils.readFileToString(path, "UTF-8");*/
    	net.sf.json.JSONObject jsonObj = net.sf.json.JSONObject.fromObject(jsonStr);
    	
    	try{
	    	Iterator itr1 = jsonObj.keys();
	    	//1depth
	    	while(itr1.hasNext()){
	    		String depKey1 = (String) itr1.next();
	    		menuList.add(depKey1);
	    		//2depth
	    		net.sf.json.JSONObject itrGet2 = (net.sf.json.JSONObject) jsonObj.get(depKey1);
	    		if(itrGet2.containsKey("child") && !itrGet2.get("child").equals(null)){
		    		net.sf.json.JSONObject itrChild2 = (net.sf.json.JSONObject) itrGet2.get("child");
			    	Iterator itr2 = itrChild2.keys();
			    	while(itr2.hasNext()){
			    		String depKey2 = (String) itr2.next();
			    		menuList.add(depKey2);
			    		//3depth
			    		net.sf.json.JSONObject itrGet3 = (net.sf.json.JSONObject) itrChild2.get(depKey2);
			    		if(itrGet3.containsKey("child") && !itrGet3.get("child").equals(null)){
				    		net.sf.json.JSONObject itrChild3 = (net.sf.json.JSONObject) itrGet3.get("child");
					    	Iterator itr3 = itrChild3.keys();
					    	while(itr3.hasNext()){
					    		String depKey3 = (String) itr3.next();
					    		menuList.add(depKey3);
					    		//4depth
					    		net.sf.json.JSONObject itrGet4 = (net.sf.json.JSONObject) itrChild3.get(depKey3);
					    		if(itrGet4.containsKey("child") && !itrGet4.get("child").equals(null)){
						    		net.sf.json.JSONObject itrChild4 = (net.sf.json.JSONObject) itrGet4.get("child");
							    	Iterator itr4 = itrChild4.keys();
							    	while(itr4.hasNext()){
							    		String depKey4 = (String) itr4.next();
							    		menuList.add(depKey4);
							    	}
						    	}
					    	}
				    	}
			    	}
		    	}
	    	}
    	} catch (NullPointerException e){
    		log.error(e.getMessage());
    		menuList = null;
    	}catch(Exception e){
    		log.error(e.getMessage());
    		menuList = null;
    	}
    	
    	return menuList;
    }
    
    public static boolean menuCheck(){
    	
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	String menuId = NullUtil.nullString(AdminUtil.getMenuId());
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) request.getAttribute("loginVO");
    	String Uri = NullUtil.nullString(request.getRequestURI());
    	boolean check = false;
    	
    	if(loginVO == null){
    		loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	}
    	String typeId = NullUtil.nullString(loginVO.getTypeId());
    	List menuList = null;
    	if(typeId.equals("30020")){
    		check = true;
    	}else if(!typeId.equals("30020") && Uri.equals("/cms/mgrCtl.do")){
    		check = true;
    	}else{
			try {
				menuList = AdminUtil.typeMenuListGet(typeId);
	    	
				if(StringUtil.isExistInList(menuList, menuId) || menuId.equals("false")){
					check = true;
				}else{
					AdminUtil.setMenuId("false");
					check = false;
				}
			} catch (IOException e) {
				//log.error(e.getMessage());
				AdminUtil.setMenuId("false");
				check = false;
			} catch (Exception e) {
				//log.error(e.getMessage());
				AdminUtil.setMenuId("false");
				check = false;
				//2014-05-22 by.나성재 수정 무한루프 수정 loginVO 세션 제거
				if(!check) request.getSession().setAttribute("loginVO", null);
			}
    	}    	
		return check;
    }
    
    public static JnitcmssiteVO getSiteVO(HttpServletRequest request){
    	
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    	JnitcmssiteService jnitcmssiteService = (JnitcmssiteService)wContext.getBean("jnitcmssiteService");
    	
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	
    	String siteId = "";
		try {
			siteId = NullUtil.nullString(CmsHelper.getSessionSiteId(request));
			
			if(siteId.equals("")){
				return null;
			}
			
			JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();    		
			jnitcmssiteVO.setSiteId(siteId);
			siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);
			
			if(siteVO == null){
				return null;
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			if("true".equals(deDug)) log.debug("Err. getSiteVO TryCatch");
			return null;
		} catch (Exception e) {
			log.error(e.getMessage());
			if("true".equals(deDug)) log.debug("Err. getSiteVO TryCatch");
			return null;
		}
    	
		return siteVO;
    }
    
    public static java.lang.String getSitePath (HttpServletRequest request){
    	String[] url = request.getRequestURI().split("/");
    	return url[1];
    }
    
    public static String getAdmLevelProp(){
    	
    	return EgovProperties.getProperty(EgovProperties.getProperty("Webadm.Properties"), "Webadm.Levels");
    }
    /**
	 * SMTP로 메일전송을 한다.
	 * @param sname-보내는 사람 이름,
	 * semail-보내는 사람 주소,
	 * remail-받는 사람 메일,
	 * dir-이메일 템플릿 이름(email1.html,email2.html....),
	 * title-이메일 제목
	 * request-HttpServletRequest
	 * @exception Exception
	 */
    public static void sendMail(String rename,String reid,String remail,String dir,String title,
    		HttpServletRequest request) throws Exception {
    	try{
    		
    		Properties prop = new Properties();
        	String apiKeyPath = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/apiKey.prop";
        	
        	InputStreamReader isr = null;
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(apiKeyPath);
				isr = new InputStreamReader(fis,"UTF-8");
				try {
					prop.load(isr);
				} catch (IOException e) {
					log.error(e.getMessage());
				}
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} finally {
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
			
			String semail = prop.getProperty("gsmtpuser");
			String sname = prop.getProperty("gsmtpname");
			
	    	HtmlEmail he = new HtmlEmail();
	    	he.setCharset("UTF-8");
	    	he.setHostName(
	    			prop.getProperty("gsmtphost")
	    	);
	    	he.setAuthentication(
	    			prop.getProperty("gsmtpuser"),prop.getProperty("gsmtppass")
	    	);
	    	
	    	he.setTLS(true);
	    	he.setSmtpPort(
	    			Integer.parseInt(prop.getProperty("gsmtpport"))
	    	);
	    	
	    	
	    	if("true".equals(deDug)) log.debug(prop.getProperty("gsmtpname")+ " " + sname+" "+semail);
	    	he.setFrom(semail, sname, "UTF-8");
	    	he.addTo(remail);
	    	
	    	he.setSubject(title);
	    	
	        // TPL File 로딩
	        String tplDir = PathUtil.getRealPath(request);
	
	        String tplFile = tplDir + "/WEB-INF/jsp/jnit/cms/email/"+dir;
	        BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(new File(tplFile)), "UTF-8"));
	
	        String readLineStr = "";
	        String mailTemplate = "";
	        while((readLineStr = in.readLine()) != null) {
	        	mailTemplate += readLineStr;
	        }
	        in.close();
	        
	        mailTemplate = mailTemplate.replaceAll("\\{\\-NAME\\-\\}", rename);
	        mailTemplate = mailTemplate.replaceAll("\\{\\-ID\\-\\}", reid);
	        Date dt = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        
	      
	        String url = request.getRequestURL().toString();
			url = url.substring(0,url.indexOf("/", 8));
	        //mailTemplate = mailTemplate.replaceAll("\\{\\-DATE\\-\\}", sdf.format(dt).toString());
	        //mailTemplate = mailTemplate.replaceAll("\\{\\-LINK\\-\\}", url + "/board/board.do?boardId="+boardId+"&mode=view&cntId=" + cntId);
	        //mailTemplate = mailTemplate.replaceAll("\\{\\-BOARD_TITLE\\-\\}", dbVO.getTitle());
	        //mailTemplate = mailTemplate.replaceAll("\\{\\-CONTENT\\-\\}", dbVO.getContent());
	    	he.setHtmlMsg(mailTemplate);
    	
    		he.send();
    	}catch(EmailException e){    		
    		if("true".equals(deDug)) log.debug(e.getMessage());
    	}    	
    }
    
    
    public static void sendMailWebOrder(String sname,String semail,String rename,String remail,String title, Document source,
    		HttpServletRequest request) throws Exception {
    	try{
	    	semail = NullUtil.nullString(semail);
			sname = NullUtil.nullString(sname);
	    	HtmlEmail he = new HtmlEmail();
	    	he.setCharset("UTF-8");
	    	he.setHostName(
	    			EgovProperties.getProperty("Globals.SMTP.hostname").trim()
	    	);
	    	he.setAuthentication(
	    			EgovProperties.getProperty("Globals.SMTP.user").trim(),
	    			EgovProperties.getProperty("Globals.SMTP.password").trim()
	    	);
	    	
	    	he.setTLS(true);
	    	he.setSmtpPort(
	    		Integer.parseInt( EgovProperties.getProperty("Globals.SMTP.port") )
	    	);
	    	
	    	
	    	if("true".equals(deDug)) log.debug(EgovProperties.getProperty("Globals.SMTP.hostname")+ " " + sname+" "+semail);
	    	he.setFrom(semail, sname, "UTF-8");
	    	he.addTo(remail);
	    	
	    	he.setSubject(title);
	    	
	        String mailTemplate = source.toString();
	        
	        Date dt = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        
	      
	        String url = request.getRequestURL().toString();
			url = url.substring(0,url.indexOf("/", 8));
	        //mailTemplate = mailTemplate.replaceAll("\\{\\-DATE\\-\\}", sdf.format(dt).toString());
	        //mailTemplate = mailTemplate.replaceAll("\\{\\-LINK\\-\\}", url + "/board/board.do?boardId="+boardId+"&mode=view&cntId=" + cntId);
	        //mailTemplate = mailTemplate.replaceAll("\\{\\-BOARD_TITLE\\-\\}", dbVO.getTitle());
	        //mailTemplate = mailTemplate.replaceAll("\\{\\-CONTENT\\-\\}", dbVO.getContent());
	    	he.setHtmlMsg(mailTemplate);
    	
    		he.send();
    	}catch(EmailException e){    		
    		if("true".equals(deDug)) log.debug(e.getMessage());
    	}    	
    }
    
    public static String CmsMenuTree(String typeId)throws Exception{
    	
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
	    ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    	JnitcmsmenutreeService jnitcmsmenutreeService = (JnitcmsmenutreeService) wContext.getBean("jnitcmsmenutreeService");
    	

    	return jnitcmsmenutreeService.selectListAllActiveToJson(typeId);
    	
    	/*
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
    		if(DbType.equals("oracle")){
    			query = "select * from jnitcmsmenutree where menu_id LIKE '%' || '000000' AND ISDEL = 0 AND MENU_ACTIVE = 1";
    		}else{
    			query = "select * from jnitcmsmenutree where menu_id LIKE CONCAT ('%','000000')  AND ISDEL = 0 AND MENU_ACTIVE = 1";
    		}
    	}else{
    		if(DbType.equals("oracle")){
    			query = "select * from jnitcmsmenutree where menu_id LIKE '%' || '000000' AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1";
    		}else{
    			query = "select * from jnitcmsmenutree where menu_id LIKE CONCAT ('%','000000') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1";
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
	    		if(DbType.equals("oracle")){
	    			query = "select * from jnitcmsmenutree where menu_id LIKE '"+menuId.substring(0,3)+"' || '%' || '0000' AND MENU_CODE_ID NOT IN('"+menuId+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1";
	    		}else{
	    			query = "select * from jnitcmsmenutree where menu_id LIKE CONCAT ('"+menuId.substring(0,3)+"','%','0000') AND MENU_CODE_ID NOT IN('"+menuId+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1";
	    		}
	    	}else{
	    		if(DbType.equals("oracle")){
	    			query = "select * from jnitcmsmenutree where menu_id LIKE '"+menuId.substring(0,3)+"'||'%'||'0000' AND MENU_CODE_ID NOT IN('"+menuId+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1";
	    		}else{
	    			query = "select * from jnitcmsmenutree where menu_id LIKE CONCAT ('"+menuId.substring(0,3)+"','%','0000') AND MENU_CODE_ID NOT IN('"+menuId+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1";
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
	    	    		if(DbType.equals("oracle")){
	    	    			query = "select * from jnitcmsmenutree where menu_id LIKE '"+subMenuId1.substring(0,5)+"'||'%'||'00' AND MENU_CODE_ID NOT IN('"+subMenuId1+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1";
	    	    		}else{
	    	    			query = "select * from jnitcmsmenutree where menu_id LIKE CONCAT ('"+subMenuId1.substring(0,5)+"','%','00') AND MENU_CODE_ID NOT IN('"+subMenuId1+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1";
	    	    		}
	    	    	}else{	
	    	    		if(DbType.equals("oracle")){
	    	    			query = "select * from jnitcmsmenutree where menu_id LIKE '"+subMenuId1.substring(0,5)+"'||'%'||'00' AND MENU_CODE_ID NOT IN('"+subMenuId1+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1";
	    	    		}else{
	    	    			query = "select * from jnitcmsmenutree where menu_id LIKE CONCAT ('"+subMenuId1.substring(0,5)+"','%','00') AND MENU_CODE_ID NOT IN('"+subMenuId1+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1";
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
			    	    			query = "select * from jnitcmsmenutree where menu_id LIKE '"+subMenuId2.substring(0,7)+"'||'%' AND MENU_CODE_ID NOT IN('"+subMenuId2+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1";
			    	    		}else{
			    	    			query = "select * from jnitcmsmenutree where menu_id LIKE CONCAT ('"+subMenuId2.substring(0,7)+"','%') AND MENU_CODE_ID NOT IN('"+subMenuId2+"')  AND ISDEL = 0 AND MENU_ACTIVE = 1";
			    	    		}
			    	    	}else{	
			    	    		if(DbType.equals("oracle")){
			    	    			query = "select * from jnitcmsmenutree where menu_id LIKE '"+subMenuId2.substring(0,7)+"'||'%' AND MENU_CODE_ID NOT IN('"+subMenuId2+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1";
			    	    		}else{
			    	    			query = "select * from jnitcmsmenutree where menu_id LIKE CONCAT ('"+subMenuId2.substring(0,7)+"','%') AND MENU_CODE_ID NOT IN('"+subMenuId2+"') AND MENU_CODE_ID IN("+menurow+")  AND ISDEL = 0 AND MENU_ACTIVE = 1";
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
    	
    	//model.addAttribute("json",depth1);
    	//return "/jnit/util/json";
		return depth1.toJSONString();
		
		*/
    	
    }

    /**
     * CMS 접근권한 설정을 통한 관리자페이지 접근권한 여부
     */
    @SuppressWarnings("deprecation")
	public static boolean isLoginPagePass(HttpServletRequest request){
    	
    	String sp = NullUtil.nullString(request.getParameter("sp"));		//super pass
    	if("y".equals(sp.trim().toLowerCase())) return true;
    	
    	boolean isPass = false;
		String securePath = request.getRealPath("/")+"WEB-INF/config/jnit/secureProp.prop";
		Properties secureProp = new Properties();
		File currentSecurePropFile = new File(securePath);
		InputStreamReader isr = null;
		FileInputStream fis = null;
		
		if(currentSecurePropFile.exists()){
			try {
				fis = new FileInputStream(currentSecurePropFile);
				isr = new InputStreamReader(fis, "UTF-8");
				secureProp.load(isr);
			} catch (UnsupportedEncodingException e) {
				log.error(e.getMessage());
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			} finally {
				try {
					isr.close();
					fis.close();
				} catch (IOException e) {
					log.error(e.getMessage());
				}
			}
			String thisIp = NullUtil.nullString(request.getRemoteAddr());												//접속자 IP
			String ipFilterType = NullUtil.nullString(secureProp.getProperty("ipFilterType")).trim();		//IP 접근설정 Type
			String ipList = NullUtil.nullString(secureProp.getProperty("ipList")).trim();								//IP 리스트
			String[] ipSplit = ipList.split("//");
			
			if("".equals(ipFilterType) || "no".equals(ipFilterType)){		//IP 접근 설정을 사용하지 않거나, 설정값이 없으면 true 반환
				isPass = true;
			}else{
				if("blackList".equals(ipFilterType)){						//IP 접근설정 Type값이 "blackList"면 
					for(String str : ipSplit){
						if(str.trim().equals(thisIp)){
							isPass = false;
							break;
						}
					}
				}else if("whiteList".equals(ipFilterType)){					//IP 접근설정 Type값이 "whiteList"면
					for(String str : ipSplit){
						if(str.trim().equals(thisIp)){
							isPass = true;
							break;
						}
					}
				}
			}
		}else{
			isPass =  true;																//보안설정에서 저장을 누르지 않으면 파일이 생성되지 않기때문에 파일이 없으면 기본적으로 접근이 가능하도록 허용
		}
		return isPass;
    }
}