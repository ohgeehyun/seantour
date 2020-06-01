/**
 * @version 3.2.0.1
 */
package jnit.cms.tpl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jnit.cms.CmsHelper;
import jnit.cms.CmsManageSub3Controller;
import jnit.cms.CmsManageSub4_1Controller;
import jnit.cms.CmsManageSub4_2Controller;
import jnit.cms.CmsManageSub4_4Controller;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.config.ConfigUtil;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tplhist.JnitcmstplhistService;
import jnit.cms.tplhist.JnitcmstplhistVO;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;

public class tplUtil {
	
	public static Log log = LogFactory.getLog(tplUtil.class);
	
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	
	public static Boolean tplWrite(HttpServletRequest request, JnitcmstplVO tplVO, JnitcmssiteVO siteVO)throws Exception{
		
		//치환
		tplVO.setTplSrc(tplUtil.replaceAllTpl(siteVO.getSitePath(), tplVO, tplVO.getTplSrc(), null));		
		
    	// TPL File 저장
        String tplDir = PathUtil.getRealPath(request) +siteVO.getSitePath();
        String subTpl = "";
        String tplFile = "";
        String tplType = NullUtil.nullString(tplVO.getTplType());
        if(tplType.equals("A")){
        	tplFile = tplDir + "/index.jsp";
        }else if(tplType.equals("A_html")){
        	tplFile = tplDir + "/index_ori.jsp";
        }else if(tplType.equals("B")){
        	tplFile = tplDir + "/_tpls/" + tplType+"/";
        	subTpl = tplVO.getTplId();
        }else if(tplType.equals("C")){
        	tplFile = tplDir + "/login.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("D")){
        	tplFile = tplDir + "/mbr/signup.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("E")){
        	tplFile = tplDir + "/mbr/signupAdd.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("F")){
        	tplFile = tplDir + "/mbr/signupSuccess.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("G")){
        	tplFile = tplDir + "/mbr/myPage.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("H")){
        	tplFile = tplDir + "/mbr/memberCancel.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("I")){
        	tplFile = tplDir + "/mbr/idFind.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("J")){
        	tplFile = tplDir + "/mbr/pwFind.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("K")){
        	tplFile = tplDir + "/mbr/sign.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("L")){
        	tplFile = tplDir + "/mbr/signupKid.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("M")){
        	tplFile = tplDir + "/mbr/noSetpIdFind.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("N")){
        	tplFile = tplDir + "/mbr/noSetpPwFind.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("O")){
        	tplFile = tplDir + "/print.jsp";
        }else if(tplType.equals("M1")){
        	tplFile = tplDir + "/mbr/noSetpIdResult.jsp";
        	subTpl = tplVO.getTplDesc();
        }else if(tplType.equals("N1")){
        	tplFile = tplDir + "/mbr/noSetpPwResult.jsp";
        	subTpl = tplVO.getTplDesc();
        }
        
        File mbrFile = new File(tplDir+"/mbr");
        if(!mbrFile.exists()){
        	mbrFile.mkdirs();
        }
        
        String common = "<% response.setHeader(\"Cache-Control\",\"no-store\"); response.setHeader(\"Pragma\",\"no-cache\"); response.setDateHeader(\"Expires\",0); if (request.getProtocol().equals(\"HTTP/1.1\")) { response.setHeader(\"Cache-Control\", \"no-cache\"); } %><%@ page contentType=\"text/html; charset=utf-8\" %><%@ include file='/_common/header.jsp' %><c:set var=\"Jnit_sitePath\" value=\""+siteVO.getSitePath()+"\" />";
        
        CmsHandler cmsHdr = new CmsHandler(tplFile, subTpl);
        cmsHdr.setJnitcmstplVO(tplVO);
        cmsHdr.setSitePath(siteVO.getSitePath());
        
        if(tplType.equals("A")||tplType.equals("A_html")){
        	cmsHdr.setFileHeader("<% response.setHeader(\"Cache-Control\",\"no-store\"); response.setHeader(\"Pragma\",\"no-cache\"); response.setDateHeader(\"Expires\",0); if (request.getProtocol().equals(\"HTTP/1.1\")) { response.setHeader(\"Cache-Control\", \"no-cache\"); } %><%@ page contentType=\"text/html; charset=utf-8\" %><%@ include file='/_common/header.jsp' %>");
        	cmsHdr.setFileHeader(CmsHandler.FileHeader(cmsHdr.getFileHeader()));
        }else if(tplType.equals("B")){
        	cmsHdr.setContent(tplVO.getTplSrc());
    		cmsHdr.setFileHeader("<%@ include file='/_common/_header.jsp' %><%@ page import=\"jnit.cms.handler.*\" %><%@ page import=\"jnit.com.util.CclUtil\" %><%@ page import=\"jnit.cms.menu.JnitcmsmenuController\" %><c:set var=\"handingType\" value=\""+tplVO.getTplId()+"\" />");
            cmsHdr.saveSplitContent("CONTENT");      
        }else if(tplType.equals("C")){
        	//2014-05-12 by.나성재 수정 gpki 뺌
        	//<%@ page import=\"java.sql.*, java.io.*, java.net.*, java.util.*\" %><% String challenge = \"\"; %><c:catch var=\"err\"><%@ include file=\"/gpki/gpkisecureweb.jsp\" %><%@ page import=\"com.gpki.servlet.GPKIHttpServletResponse\" %><% challenge = gpkiresponse.getChallenge(); %></c:catch><c:if test=\"${not empty err}\"></c:if>
        	cmsHdr.setFileHeader(common+"<%@ page import=\"jnit.cms.mbr.MbrUtil\" %><%@ page import='jnit.cms.config.ConfigUtil' %><% String message = \"\"; if(request.getParameter(\"message\") != null){ String error =	request.getParameter(\"message\"); message = error; } %><% Boolean siauth = MbrUtil.siauth(); Boolean gpinauth = MbrUtil.gpinauth(); Boolean pkiauth = MbrUtil.pkiauth(); %><c:set var=\"Jnit_sitePath\" value=\""+siteVO.getSitePath()+"\" /><c:set var=\"siteId\" value=\""+siteVO.getSiteId()+"\" />");
        }else if(tplType.equals("E")){
        	cmsHdr.setFileHeader(common+"<%@ page import='java.util.Properties' %><%@ page import='net.sf.json.JSONObject' %><%@ page import='jnit.cms.config.ConfigUtil' %><%	String type = request.getParameter(\"type\"); JSONObject prop = new JSONObject(); try{prop = ConfigUtil.getProp(\""+siteVO.getSiteId()+"\"); /*필수 입력 siteId*/ }catch(Exception e){log.error(e.getMessage());} String error = (String)prop.get(\"error\"); String errorCode = ConfigUtil.getErrorCode(\""+siteVO.getSitePath()+"\",\"signupAdd\",\"E\",\""+siteVO.getSiteId()+"\"); String authDefaultYn = request.getParameter(\"authDefaultYn\"); %>"+
        		"<c:set var=\"siteId\" value=\""+siteVO.getSiteId()+"\" />");
        }else if(tplType.equals("G")){
        	cmsHdr.setFileHeader(common+"<%@ page import='java.util.Properties' %><%@ page import='net.sf.json.JSONObject' %><%@ page import='jnit.cms.config.ConfigUtil' %><%	JSONObject prop = new JSONObject(); try{prop = ConfigUtil.getProp(\""+siteVO.getSiteId()+"\"); /*필수 입력 siteId*/ }catch(Exception e){log.error(e.getMessage());} String error = (String)prop.get(\"error\"); %>"+
        		"<%@ page import=\"jnit.scrap.ScrapUtil\" %><%@ page import=\"jnit.login.log.loginlogUtil\" %><%@ page import=\"java.util.ArrayList\" %><%@ page import=\"egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo\" %><% String scrapPageNo = request.getParameter(\"scrapPageNo\");String logPageNo = request.getParameter(\"logPageNo\");String tabs = request.getParameter(\"tabs\");String tab = request.getParameter(\"tab\");int scrapStartNum = ScrapUtil.scrapStartNum(scrapPageNo);int logStartNum = loginlogUtil.listIPStartNum(logPageNo);ArrayList scrapList = new ArrayList<String>();scrapList = ScrapUtil.scrapList(scrapPageNo);PaginationInfo scrapPageNavi = new PaginationInfo();scrapPageNavi = ScrapUtil.scrapPageNavi(scrapPageNo);ArrayList loginLogList = new ArrayList<String>();loginLogList = loginlogUtil.listIP(logPageNo);PaginationInfo loginlogPageNavi = new PaginationInfo();loginlogPageNavi = loginlogUtil.pageNavi(logPageNo); String errorCode = ConfigUtil.getErrorCode(\""+siteVO.getSitePath()+"\",\"myPage\",\"G\",\""+siteVO.getSiteId()+"\");%>"
        		+"<%@ page import=\"jnit.com.util.DBType\" %>");
        }else if(tplType.equals("D") || tplType.equals("I") || tplType.equals("J") || tplType.equals("M") || tplType.equals("N") ){
        	//2014-06-06 by.나성재 수정 gpki 뺌
        	//<%@ page import=\"java.sql.*, java.io.*, java.net.*, java.util.*\" %><% String challenge = \"\"; %><c:catch var=\"err\"><%@ include file=\"/gpki/gpkisecureweb.jsp\" %><%@ page import=\"com.gpki.servlet.GPKIHttpServletResponse\" %><% challenge = gpkiresponse.getChallenge(); %></c:catch><c:if test=\"${not empty err}\"></c:if>
        	cmsHdr.setFileHeader(common+"<%@ page import=\"jnit.cms.mbr.MbrUtil\" %><% Boolean siauth = MbrUtil.siauth(); Boolean gpinauth = MbrUtil.gpinauth(); Boolean pkiauth = MbrUtil.pkiauth(); %><% String retType = request.getParameter(\"retType\"); %>");//<c:if test=\"${not empty err}\"><c:out value=\"${err}\" /></c:if>
        }else if(tplType.equals("O")){
        	cmsHdr.setFileHeader(common+"<%@ page import=\"jnit.cms.handler.*\" %><%@ page import=\"jnit.com.util.CclUtil\" %><%@ page import=\"jnit.cms.menu.JnitcmsmenuController\" %><c:set var=\"Jnit_sitePath\" value=\"${Jnit_sitePath}\" scope=\"request\"/>");
        	cmsHdr.setFileHeader(CmsHandler.FileHeader(cmsHdr.getFileHeader()));
        }else if(tplType.equals("M1") || tplType.equals("N1")){
        	cmsHdr.setFileHeader(common+"<% String result = \"\";if(request.getParameter(\"result\") != null){ if(\"Y\".equals(request.getParameter(\"localYn\"))){result = new String( request.getParameter(\"result\").getBytes(\"8859_1\"),\"UTF-8\"); }else{ result = request.getParameter(\"result\");} }%><c:set var=\"result\" value=\"<%= result%>\" />");
        }else{
        	cmsHdr.setFileHeader(common);
        }
        
        if(!tplType.equals("B")){        	
        	cmsHdr.setContentHeader("<% /*<!-- [-CONTENT-] -->*/ %>");
            cmsHdr.setContentFooter("<% /*<!-- /[-CONTENT-] -->*/ %>");
            cmsHdr.setContent(tplVO.getTplSrc());  //jnitcmstplVO.getTplSrc()
            cmsHdr.setSiteDir("/"+siteVO.getSitePath());
            cmsHdr.saveContent();
        }
        
        Properties tplprop = new Properties();
        tplprop.put("siteId", siteVO.getSiteId());
        tplprop.put("pageCcl", "100");
        tplprop.put("pageTitle", tplVO.getTplNm());
        tplprop.put("pageNav", "Home &gt; <span class='menu-home'>Home</span> <span class='gt'> &gt; </span> <span class='menu-active'>"+tplVO.getTplNm()+"</span>");        
        FileOutputStream fos = new FileOutputStream(tplFile+".prop");
        tplprop.store(fos, "(by Jnitcms 3.5)");
        if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
        JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, tplFile+".prop");		//Filego 배포
		return true;
	}
	
	/**
	 * 템플릿 히스토리
	 * @see {@link CmsManageSub3Controller#addJnitcmssite}
	 * {@link CmsManageSub4_1Controller#updateJnitcmstpl}
	 * {@link CmsManageSub4_2Controller#updateJnitcmstpl}	
	 * {@link CmsManageSub4_4Controller#updateJnitcmstpl}	
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean tplHistWrite(HttpServletRequest request, JnitcmstplVO jnitcmstplVO, String siteId)throws Exception{
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		
		JnitcmstplhistService jnitcmstplhistService = (JnitcmstplhistService) wContext.getBean("jnitcmstplhistService");
		if(jnitcmstplVO.getTplId() != null){
			JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
			if("".equals(NullUtil.nullString(siteId))) siteId = CmsHelper.getSessionSiteId(request);
			
	        JnitcmstplhistVO tplhistVO = new JnitcmstplhistVO();
	        tplhistVO.setSiteId(siteId);        
	        tplhistVO.setTplId(jnitcmstplVO.getTplId());
	        tplhistVO.setTplType(jnitcmstplVO.getTplType());
	        tplhistVO.setTplDesc(jnitcmstplVO.getTplDesc());
	        tplhistVO.setTplSrc(jnitcmstplVO.getTplSrc());
	        tplhistVO.setActMbr(loginVO.getMbrId());
	        tplhistVO.setActIp(StringUtil.isExistString(request.getRequestURL().toString(), "local") == true ? "local" : request.getRemoteHost());
	        jnitcmstplhistService.insertJnitcmstplhist(tplhistVO);
		}else{
			if("true".equals(deDug)) log.debug("====== jnitcmstplVO null ======");
			return false;
		}		
		return true;
	}
	
	/**
	 * 템플릿의 치환코드를 getSiteChange메소드 이용하여 치환한다.
	 * @param sitePath - 사이트경로
	 * @param jnitcmstplVO
	 * @param str - 바꿀문자열
	 * @param chageType - return 문자열 입력시 역치환 
	 * @return
	 * @throws Exception
	 */
	public static String replaceAllTpl(String sitePath, JnitcmstplVO jnitcmstplVO, String str, String chageType)throws Exception{
		str = NullUtil.nullString(str);
		
		//치환코드
		HashMap<String, String> getSiteChangeCode = ConfigUtil.getSiteChangeCode(sitePath, jnitcmstplVO.getTplType(), chageType);
		
	    Iterator getSiteChangeCodeIterator = getSiteChangeCode.keySet().iterator();
	    
	    while(getSiteChangeCodeIterator.hasNext()){
	    	String key = (String) getSiteChangeCodeIterator.next();
	    	str = str.replace(key, getSiteChangeCode.get(key));
	    }	    
		return str;
	}
	
	/**
	 * 템플릿의 치환코드를 changcode 메소드를 이용하여 치환한다.  
	 * @param sitePath - 사이트경로
	 * @param jnitcmstplVO
	 * @param str - 바꿀문자열
	 * @param chageType - return 문자열 입력시 역치환 
	 * @return
	 * @throws Exception
	 * {@link CmsManageSub4_4Controller#updateJnitcmstplView}
	 * {@link CmsManageSub4_4Controller#updateJnitcmstpl}
	 */
	public static String replaceMbrTpl(JnitcmstplVO jnitcmstplVO, String str, String chageType)throws Exception{
		str = NullUtil.nullString(str);
		
		//치환코드
		HashMap<String, String> getSiteChangeCode = ConfigUtil.changcode(jnitcmstplVO.getTplType(), chageType);
		
	    Iterator getSiteChangeCodeIterator = getSiteChangeCode.keySet().iterator();
	    
	    while(getSiteChangeCodeIterator.hasNext()){
	    	String key = (String) getSiteChangeCodeIterator.next();	    	
	    	str = str.replace(key, getSiteChangeCode.get(key));
	    }
		return str;
	}
	
	/**
	 * 템플릿을 생성한 후 JnitcmstplVO 정보를 반환한다.
	 * @param request
	 * @param tplVO
	 * @param jnitcmssiteVO
	 * @param tplDir - 복사할 경로
	 * @param tplId - 서브템플릿 id
	 * @param tplType - 타입
	 * @param tplNm - 파일이름
	 * @return JnitcmstplVO
	 * @throws Exception
	 */
	public static JnitcmstplVO makeTplVO(HttpServletRequest request    		
    		, JnitcmstplVO tplVO
    		, JnitcmssiteVO jnitcmssiteVO
    		, String tplDir    		
    		, String tplId    		
    		, String tplType
    		, String tplNm)throws Exception{
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
    	
    	JnitcmstplService jnitcmstplService = (JnitcmstplService) wContext.getBean("jnitcmstplService");
    	
    	//Tpl
        String TplFile = tplDir;
        String TplSrc = CmsHandler.readFile(TplFile);        
        TplSrc = TplSrc.replace("{-SITEPATH-}", jnitcmssiteVO.getSitePath());
    	tplVO = new JnitcmstplVO();
    		tplVO.setSiteId(jnitcmssiteVO.getSiteId());
    		tplVO.setTplType(tplType);
    		tplVO.setTplNm(tplNm);
    		tplVO.setTplSrc(TplSrc);
    		tplVO.setTplDesc(tplId);
    	jnitcmstplService.insertJnitcmstpl(tplVO);
        
    	//히스토리
		tplUtil.tplHistWrite(request, tplVO, jnitcmssiteVO.getSiteId());
		
		//TPL
        tplUtil.tplWrite(request, tplVO, jnitcmssiteVO);
        // End of Tpl
    	return tplVO;
    }
	
	/**
	 * include 시 지정된 문자열이 있는지 판별한다.
	 * @param str - 비교대상
	 * @param targetStr - 지정된 문자열
	 * @return Boolean
	 */
	public static Boolean isSubTplExists(String str, String targetStr){
    	str = NullUtil.nullString(str);
    	if(!"".equals(str)){    		
    		ArrayList array = new ArrayList();
    		try {
    			for(int i=0; i<100; i++){
    				array.add(str.substring(str.indexOf("<jsp:include page"), str.indexOf("</jsp:include>")+14));
    				str = str.replace(str.substring(str.indexOf("<jsp:include page"), str.indexOf("</jsp:include>")+14), "");
    			}
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
    		} catch (Exception e) {
    			log.error(e.getMessage());
    		}
    		if(array.size() > 0){
    			for(int i=0; i<array.size(); i++){
    				if(array.get(i).toString().indexOf(targetStr) > -1){
    					return true;
    				}
    			}
    		}
    	}
    	return false;
    }
	
	/**
	 * 서브템플릿의 include 문의 각 콘텐츠 DB 를 조사하여 서브템플릿 참조되는것들은 null 처리하여 리스트를 반환한다.
	 * @param siteVO
	 * @param str - 비교대상
	 * @param tplId
	 * @return String - null 처리가 된 include 리스트
	 * @throws IOException
	 */
	public static String isSubTplIncludeFileExists(JnitcmssiteVO siteVO, String str, String tplId) throws IOException{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		
		JnitcmscntService jnitcmscntService = (JnitcmscntService) wContext.getBean("jnitcmscntService");
		JnitcmsmenuService jnitcmsmenuService = (JnitcmsmenuService) wContext.getBean("jnitcmsmenuService");
		
		String root = PathUtil.getRealPath(request);
		
    	str = NullUtil.nullString(str);
    	tplId = NullUtil.nullString(tplId);
    	String includeList = "";
    	
    	if(!"".equals(str)){		
    		ArrayList array = new ArrayList();
    		try {
    			for(int i=0; i<100; i++){
    				String first = str.substring(str.indexOf("<jsp:include page=")+20);
    				String last = first.substring(0,(first.indexOf("\"") > first.indexOf("'")  ? (first.indexOf("'") > -1 ? first.indexOf("'") : first.indexOf("\"")) : (first.indexOf("\"") > -1 ? first.indexOf("\"") : first.indexOf("'"))));
    				if("true".equals(deDug)) log.debug("last ="+last);
    				array.add(last);
    				str = str.replace(str.substring(str.indexOf("<jsp:include page=\""), str.indexOf("\"></jsp:include>")+14), "");
    			}
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
    		} catch (Exception e) {
    			log.error(e.getMessage());
    		}
    		if("true".equals(deDug)) log.debug("array ="+array);
    		Properties prop = new Properties();
    		for(int i=0; i<array.size(); i++){
    			String propDir = root +array.get(i).toString()+".prop";
    			
    			File propFile = new File(propDir);
    			if(propFile.exists()){
    				FileInputStream fis = null;
    				InputStreamReader isr = null;
    				try {
    					fis = new FileInputStream(propFile);
        				isr = new InputStreamReader(fis);
        				prop.load(isr);
    				} catch (IOException e){
    					log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					} finally {
						if(isr != null){
							isr.close();
						}
						if(fis != null){
							fis.close();
						}
					}
					
					try {
						String menuId = prop.getProperty("menuId");
						
						Boolean isinclude = false;
						JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
						menuVO.setMenuId(menuId);
						menuVO.setSelectCondition("1");						
						menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);
						if(menuVO.getTplId() != null){
							if(tplId.equals(menuVO.getTplId())){
								menuVO.setTplId(" ");
								menuVO.setUpdateCondition("1");
								jnitcmsmenuService.updateJnitcmsmenu(menuVO);
								isinclude = true;
							}
						}
						
						JnitcmscntVO cntVO = new JnitcmscntVO();
						cntVO.setMenuId(menuId);		
						cntVO.setSelectCondition("1");						
						cntVO = jnitcmscntService.selectJnitcmscnt(cntVO);
						if(cntVO.getTplId() != null){
							if(tplId.equals(cntVO.getTplId())){
								cntVO.setTplId(" ");
								cntVO.setUpdateCondition("2");
								jnitcmscntService.updateJnitcmscnt(cntVO);
								isinclude = true;
							}
						}
						if(isinclude){							
							String cntDir = root +array.get(i).toString();
							CmsHandler cmsHdr = new CmsHandler(cntDir, null);
							cmsHdr.setFileHeader("<% response.setHeader(\"Cache-Control\",\"no-store\"); response.setHeader(\"Pragma\",\"no-cache\"); response.setDateHeader(\"Expires\",0); if (request.getProtocol().equals(\"HTTP/1.1\")) { response.setHeader(\"Cache-Control\", \"no-cache\"); } %><%@ page contentType=\"text/html; charset=utf-8\" %><%@ include file='/_common/header.jsp' %><c:set var=\"Jnit_sitePath\" value=\""+siteVO.getSitePath()+"\" />");
							cmsHdr.setContentHeader("<% /*<!-- [-CONTENT-] -->*/ %>");
					        cmsHdr.setContentFooter("<% /*<!-- /[-CONTENT-] -->*/ %>");
							cmsHdr.setContent(cntVO.getCntSrc() != null ? cntVO.getCntSrc() : "");
				            cmsHdr.setSiteDir("/"+siteVO.getSitePath());
				            cmsHdr.saveContent();
				            includeList += ("".equals(includeList) ? "" : ",") + "<jsp:include page='/"+array.get(i).toString()+"'></jsp:include>";
						}
						// TPL File 저장
					} catch (IOException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
    			}
    		}
    	}
    	if("true".equals(deDug)) log.debug("includeList ====="+includeList);
    	return includeList;
    }
	
}
