/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.menu.JnitcmsmenuChMethodVO;
import jnit.cms.menu.JnitcmsmenuDefaultVO;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.org.JnitcmsorgService;
import jnit.cms.org.JnitcmsorgVO;
import jnit.cms.pos.JnitcmsposService;
import jnit.cms.pos.JnitcmsposVO;
import jnit.cms.rank.JnitcmsrankService;
import jnit.cms.rank.JnitcmsrankVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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

import com.ibm.icu.text.SimpleDateFormat;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
/**
 * 메뉴관리
 *
 * @Class Name : JnitcmsmenuController.java
 * @Description : Jnitcmsmenu Controller class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsmenuVO.class)
public class CmsManageSub10Controller {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    @Resource(name="jnitcmstplService")
    private JnitcmstplService jnitcmstplService;

    @Resource(name="jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "jnitcmscntService")
    private JnitcmscntService jnitcmscntService;

    @Resource(name = "jnitcmsorgService")
    private JnitcmsorgService jnitcmsorgService;

    @Resource(name = "jnitcmsposService")
    private JnitcmsposService jnitcmsposService;

    @Resource(name = "jnitcmsrankService")
    private JnitcmsrankService jnitcmsrankService;


    /** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");

    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)

    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    @RequestMapping(value="/cms/sub10/0101.do")
    public String menuIndex(
            HttpServletRequest request,
            Model model)
            throws Exception {
    	AdminUtil.setMenuId("m05010000"); //m03090000
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		model.addAttribute("siteVO", siteVO);

        return "jnit/cms/disseminate/sub10_1-1";
    }

    @SuppressWarnings("unchecked")
	@RequestMapping(value="/cms/sub10/0101getJson.do")
    public String getJson(
    	@ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO,
    	HttpServletRequest request,
		ModelMap model)
        throws Exception {

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();

		if("".equals(siteId)) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
		}
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		model.addAttribute("siteVO", siteVO);
		searchVO.setSiteId(siteVO.getSiteId());
	    List<EgovMap> jnitcmsmenuList = jnitcmsmenuService.selectJnitcmsmenuListAll(searchVO);
	    model.addAttribute("resultList", jnitcmsmenuList);

	    HashMap<String, JSONArray> childList = new HashMap<String, JSONArray>();

	    String etcDir = PathUtil.getRealPath(request) + "/" + siteVO.getSitePath() + "/_etc";
	    File etcDirF = new File(etcDir);
	    if(etcDirF.exists() == false) {
	    	etcDirF.mkdirs();
	    }
	    if(jnitcmsmenuList.size() > 0) {
		    EgovMap menuVO;

		    int maxDepth = 0;

		    for(int i=0; i<jnitcmsmenuList.size(); i++) {
		    	menuVO = (EgovMap)jnitcmsmenuList.get(i);
		    	int cDepth = Integer.parseInt( menuVO.get("depth").toString() );
		    	if(maxDepth < cDepth) maxDepth = cDepth;

		    	JnitcmsmenuVO getMenuVO = new JnitcmsmenuVO();
		    	getMenuVO.setMenuId(menuVO.get("menuId").toString());
		    	getMenuVO.setDepth(Integer.valueOf(menuVO.get("depth").toString()));
		    	getMenuVO.setPid(NullUtil.nullString(""+menuVO.get("pid"))); //NullPointer 처리
		    	getMenuVO.setSiteId(menuVO.get("siteId").toString());
		    	getMenuVO.setMenuPath(menuVO.get("menuPath").toString());
		    	try {
		    		getMenuVO.setAdmMbrId(menuVO.get("admMbrId").toString());
		    	} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
		    	String linkurl = (String) menuVO.get("linkurl");
		    	String linktgt = (String) menuVO.get("linktgt");
		    	if(NullUtil.nullString(linkurl).equals("null")){
			    	linkurl = "";
			    }
		    	if(NullUtil.nullString(linktgt).equals("null")){
		    		linktgt = "";
			    }

		    	JSONObject obj = new JSONObject();
		    	/* 2015-09-17 by.나성재 수정 폴더메뉴 담당자 지정 필요할시 주석 제거
		    	if("Y".equals(jnitcmsmenuService.isMenuExistsData(getMenuVO, "admMbrId", loginVO.getMbrId())) //담당자
			    			//|| MbrpackageUtil.getMbrpackageExist("PACK_00001", loginVO.getTypeId())
		    				|| "30020".equals(loginVO.getTypeId())
			    			|| request.getParameter("rebuild") != null){  //빌드
		    	*/
		    		obj.put("title", menuVO.get("menuNm"));
				    obj.put("menuid", menuVO.get("menuId"));
				    obj.put("menudepth", menuVO.get("depth"));
				    obj.put("menumethod", menuVO.get("method"));
				    obj.put("menuislink", menuVO.get("islink"));
				    obj.put("menulinkurl", linkurl);
				    obj.put("menulinktgt", linktgt);
				    obj.put("menutplid", menuVO.get("tplId"));
				    obj.put("menuadmid", menuVO.get("admMbrId"));
				    obj.put("hDel", menuVO.get("hDel"));
				    obj.put("lDel", menuVO.get("lDel"));
				    obj.put("sDel", menuVO.get("sDel"));
				    if(request.getParameter("rebuild") != null){
				    	String menupath = jnitcmsmenuService.makeMenuDirectoryName(getMenuVO, siteVO.getSitePath());
				    	if(NullUtil.nullString(menupath).equals("null")||NullUtil.nullString(menupath).equals("")){
				    		menupath = "";
				    	}
				    	obj.put("menupath", menupath);
				    }
				    String defMenu = NullUtil.nullString(""+menuVO.get("defMenu"));

			    	if(NullUtil.nullString(defMenu).equals("null")){
			    		defMenu = "";
			    	}
				    obj.put("defaultmenu", defMenu);

				    /* 2014-05-20 by.나성재수정 컨텐츠 숨김처리로 변경하여 메뉴폴더 method 첫번째 - > redirect 경로 수정
						  if(request.getParameter("rebuild") != null){
							String defaultmenu = jnitcmsmenuService.getDefMenuPath(getMenuVO, menuVO.get("defMenu"));
							if(NullUtil.nullString(defaultmenu).equals("null")){
								defaultmenu = "";
							}
							obj.put("defaultmenu", defaultmenu);
						}
				     */
				    obj.put("key", menuVO.get("menuId"));
				    obj.put("expand", true);
				    int iscnt = Integer.parseInt(menuVO.get("iscnt").toString());

				    if(iscnt == 0) {//menuVO.get("iscnt").equals(0)
				    	obj.put("isFolder", true);

				    	if(request.getParameter("rebuild") != null) {
				    		int isdel = Integer.parseInt(menuVO.get("isdel").toString());
					    	if(isdel == 0) {  // menuVO.get("isdel")..equals(0)
					    		String fileDir = PathUtil.getRealPath(request) + "/" + obj.get("menupath");

					    		File fileDirFS = new File(fileDir);
					    		if(fileDirFS.exists() == false) {
					    			fileDirFS.mkdirs();
					    		}
					    		int islink = Integer.parseInt(menuVO.get("islink").toString());

					    		if(islink == 1) { // menuVO.get("islink")..equals(1)
					    			CmsHandler.writeFile(fileDir + "/index.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><% response.sendRedirect(\""+obj.get("menulinkurl")+"\"); %>");
					    		}else {
					    			String menuPath = "";
					    			if("".equals(NullUtil.nullString(String.valueOf(menuVO.get("redirectUrl"))))){
					    				JnitcmsmenuVO menuVo2 = new JnitcmsmenuVO();
					    				menuVo2.setSiteId(siteVO.getSiteId());
					    				menuVo2.setMenuId(menuVO.get("menuId").toString());
					    				menuVo2 = jnitcmsmenuService.selectJnitcmsmenu(menuVo2);
				    					menuPath = jnitcmsmenuService.makeMenuRedirect(menuVo2, siteVO.getSitePath(), request);

					    				if("noindex.jsp".equals(menuPath)){
					    					String message = "해당 메뉴 하부에 등록된 콘텐츠 페이지가 존재하지 않거나,\\n\\n모든 하부콘텐츠가 메뉴 메뉴설정에 비노출설정이 되어\\n\\n있어 페이지를 정상적으로 호출할수 없습니다.\\n\\n관리자모드에 메뉴/콘텐츠관리를 확인해 주시기 바랍니다.";
					    					CmsHandler.writeFile(fileDir + "/noindex.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><script type=\"text/javascript\">alert(\""+message+"\");</script>");
					    				}
					    			}else{
					    				String contextPath = request.getSession().getServletContext().getContextPath();
					    				menuPath = (StringUtil.isExistString(request.getRequestURL().toString(), "local") == true ? contextPath : "") + menuVO.get("redirectUrl").toString();
					    			}
					    			obj.put("redirect", menuPath);
				    				CmsHandler.writeFile(fileDir + "/index.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><% response.sendRedirect(\""+obj.get("redirect")+"\"); %>");
					    		}
					    	}
				    	}
				    }else if(iscnt == 1){
				    	if(request.getParameter("rebuild") != null) {
				    		JnitcmsmenuVO pageMenuVO = new JnitcmsmenuVO();
					    	pageMenuVO.setSiteId(siteVO.getSiteId());
					    	pageMenuVO.setMenuId(String.valueOf(menuVO.get("menuId")));
					    	pageMenuVO = jnitcmsmenuService.selectJnitcmsmenu(pageMenuVO);
					    	String menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(pageMenuVO, "Home", siteVO.getSitePath());
					    	String menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(pageMenuVO, siteVO.getSiteNm(), siteVO.getSitePath());
					    	String menuPid = (String)jnitcmsmenuService.makeMenuPid(pageMenuVO, siteVO.getSiteNm(), siteVO.getSitePath(), "return", request);

					    	obj.put("pageLinkNav", menuLinkNames);
					    	obj.put("pageNavTitle", menuNavTitle);
					    	obj.put("pid", menuPid);
				    	}
				    }
			    	//if(cDepth == 0) {
			    	//	list.add(obj);
			    	//}

				    String pid = (String)menuVO.get("pid");
					pid = (pid == null || pid.equals("") ? "ROOT" : pid);

		    		JSONArray cList = (JSONArray)childList.get(pid);
		    		if(cList == null) {
		    			cList = new JSONArray();
		    			childList.put(pid, cList);
		    		}
		    		cList.add(obj);
		    	//} 2015-09-17 by.나성재 수정 폴더메뉴 담당자 지정 필요할시 주석 제거
		    }

		    if(!childList.toString().contains("ROOT")){
		    	JSONArray rootList = new JSONArray();
		    	childList.put("ROOT", rootList);
		    }

	    	Set<String> keySet = childList.keySet();
	    	Object[] keys = keySet.toArray();
		    int scanDepth = maxDepth - 1;
		    while(scanDepth > -1) {
		    	for(int i=0; i<keys.length; i++) {
		    		JSONArray cObjs = (JSONArray)childList.get(keys[i]);
		    		for(int i2=0; i2<cObjs.size(); i2++) {
		    			JSONObject cObj = (JSONObject)cObjs.get(i2);
		    			if(Integer.parseInt( cObj.get("menudepth").toString() ) == scanDepth) {
			    			if(childList.get(cObj.get("menuid").toString()) != null) {
			    				cObj.put("children", childList.get(cObj.get("menuid").toString()).clone());
			    				JSONArray cObjs2 = (JSONArray) childList.get(cObj.get("menuid").toString());
			    				cObjs2.clear();
			    			}
		    			}
		    		}
		    	}
		    	scanDepth--;
		    }
	    	Boolean isOnDrop = true;
	    	for(int i=0; i<keys.length; i++) {
	    		JSONArray cObjs2 = (JSONArray)childList.get(keys[i]);
	    		if(!"ROOT".equals(keys[i])){
	    			if(!childList.toString().contains("\"menuid\":\""+keys[i]+"\"")){
	    				for(int i3=0; i3<cObjs2.size(); i3++){
			    			JSONObject cObj2 = (JSONObject)cObjs2.get(i3);
			    			JSONArray ROOT = (JSONArray)childList.get("ROOT");
		    				ROOT.add(cObj2);
		    				isOnDrop = false;
			    		}
	    			};
	    		}
	    	}
	    	if(!isOnDrop){
	    		JSONArray ROOT = (JSONArray)childList.get("ROOT");
		    	for(int i=0; i<ROOT.size(); i++){
		    		JSONObject cObj3 = (JSONObject)ROOT.get(i);
		    		cObj3.put("onDrop", "N");
		    	}
	    	}
		    /* 2015-09-14 by.나성재 수정 관리자가아닌 회원이 올경우 관리폴더 없을시 ROOT 사이즈 0 제거 주석처리
		    for(int i=0; i<keys.length; i++) {
		    	JSONArray cObjs = (JSONArray)childList.get(keys[i]);
		    	if(cObjs.size() == 0) childList.remove(keys[i]);
		    }
		    */
		    model.addAttribute("resultJson", childList.get("ROOT").toJSONString());
		    try {//menuJSON 로그인, 회원가입템플릿 추가
		    	childList = childListHashMap(siteVO, childList);
		    } catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		    if(request.getParameter("rebuild") != null) CmsHandler.writeFile(etcDir+"/menu.json", childList.get("ROOT").toJSONString());
	    }else {
	    	try {//menuJSON 로그인, 회원가입템플릿 추가
	    		JSONArray jSONArray = new JSONArray();
	    		childList.put("ROOT", jSONArray);
		    	childList = childListHashMap(siteVO, childList);
	    	} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		    if(request.getParameter("rebuild") != null) CmsHandler.writeFile(etcDir+"/menu.json", childList.get("ROOT").toJSONString());

	    	model.addAttribute("resultJson", null);
	    }

	    if(request.getParameter("rebuild") != null) {
	    	model.addAttribute("msg", "OK");
	    	return "jnit/msg";
	    }
        return "jnit/cms/disseminate/sub10_1-1-json";
    }

    //컨텐츠 복사용 TREE(폴더만 보여줌)
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/cms/sub10/0101getModalJson.do")
    public String getModalJson(
    	@ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO,
    	HttpServletRequest request,
		ModelMap model)
        throws Exception {

    	if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
		}

		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		model.addAttribute("siteVO", siteVO);
		searchVO.setSiteId(siteVO.getSiteId());
		searchVO.setSearchCondition("3");
	    List<EgovMap> jnitcmsmenuList = jnitcmsmenuService.selectJnitcmsmenuListAll(searchVO);
	    model.addAttribute("resultList", jnitcmsmenuList);

	    HashMap<String, JSONArray> childList = new HashMap<String, JSONArray>();

	    String etcDir = PathUtil.getRealPath(request) + "/" + siteVO.getSitePath() + "/_etc";
	    File etcDirF = new File(etcDir);
	    if(etcDirF.exists() == false) {
	    	etcDirF.mkdirs();
	    }
	    if(jnitcmsmenuList.size() > 0) {
		    EgovMap menuVO;

		    int maxDepth = 0;

		    for(int i=0; i<jnitcmsmenuList.size(); i++) {
		    	menuVO = (EgovMap)jnitcmsmenuList.get(i);
		    	int cDepth = Integer.parseInt( menuVO.get("depth").toString() );
		    	if(maxDepth < cDepth) maxDepth = cDepth;

		    	JnitcmsmenuVO getMenuVO = new JnitcmsmenuVO();
		    	getMenuVO.setMenuId(menuVO.get("menuId").toString());
		    	getMenuVO.setDepth(Integer.valueOf(menuVO.get("depth").toString()));
		    	getMenuVO.setPid(NullUtil.nullString(""+menuVO.get("pid"))); //NullPointer 처리
		    	getMenuVO.setSiteId(menuVO.get("siteId").toString());
		    	getMenuVO.setMenuPath(menuVO.get("menuPath").toString());
		    	try {
		    		getMenuVO.setAdmMbrId(menuVO.get("admMbrId").toString());
		    	} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
		    	String linkurl = (String) menuVO.get("linkurl");
		    	String linktgt = (String) menuVO.get("linktgt");
		    	if(NullUtil.nullString(linkurl).equals("null")){
			    	linkurl = "";
			    }
		    	if(NullUtil.nullString(linktgt).equals("null")){
		    		linktgt = "";
			    }

		    	JSONObject obj = new JSONObject();
		    	/* 2015-09-17 by.나성재 수정 폴더메뉴 담당자 지정 필요할시 주석 제거
		    	if("Y".equals(jnitcmsmenuService.isMenuExistsData(getMenuVO, "admMbrId", loginVO.getMbrId())) //담당자
			    			//|| MbrpackageUtil.getMbrpackageExist("PACK_00001", loginVO.getTypeId())
		    				|| "30020".equals(loginVO.getTypeId())
			    			|| request.getParameter("rebuild") != null){  //빌드
			    */
		    		int iscnt = Integer.parseInt(menuVO.get("iscnt").toString());
		    		if(iscnt == 0) {//menuVO.get("iscnt").equals(0)
		    		obj.put("title", menuVO.get("menuNm"));
				    obj.put("menuid", menuVO.get("menuId"));
				    obj.put("menudepth", menuVO.get("depth"));
				    obj.put("menumethod", menuVO.get("method"));
				    obj.put("menuislink", menuVO.get("islink"));
				    obj.put("menulinkurl", linkurl);
				    obj.put("menulinktgt", linktgt);
				    obj.put("menutplid", menuVO.get("tplId"));
				    obj.put("menuadmid", menuVO.get("admMbrId"));
				    obj.put("hDel", menuVO.get("hDel"));
				    obj.put("lDel", menuVO.get("lDel"));
				    obj.put("sDel", menuVO.get("sDel"));
				    String defMenu = NullUtil.nullString(""+menuVO.get("defMenu"));

			    	if(NullUtil.nullString(defMenu).equals("null")){
			    		defMenu = "";
			    	}
				    obj.put("defaultmenu", defMenu);

				    /* 2014-05-20 by.나성재수정 컨텐츠 숨김처리로 변경하여 메뉴폴더 method 첫번째 - > redirect 경로 수정
						  if(request.getParameter("rebuild") != null){
							String defaultmenu = jnitcmsmenuService.getDefMenuPath(getMenuVO, menuVO.get("defMenu"));
							if(NullUtil.nullString(defaultmenu).equals("null")){
								defaultmenu = "";
							}
							obj.put("defaultmenu", defaultmenu);
						}
				     */
				    obj.put("key", menuVO.get("menuId"));
				    obj.put("expand", true);

				    obj.put("isFolder", true);

			    	//if(cDepth == 0) {
			    	//	list.add(obj);
			    	//}

				    String pid = (String)menuVO.get("pid");
					pid = (pid == null || pid.equals("") ? "ROOT" : pid);

		    		JSONArray cList = (JSONArray)childList.get(pid);
		    		if(cList == null) {
		    			cList = new JSONArray();
		    			childList.put(pid, cList);
		    		}
		    		cList.add(obj);
		    		}
		    	//}  2015-09-17 by.나성재 수정 폴더메뉴 담당자 지정 필요할시 주석 제거
		    }

		    if(!childList.toString().contains("ROOT")){
		    	JSONArray rootList = new JSONArray();
		    	childList.put("ROOT", rootList);
		    }

	    	Set<String> keySet = childList.keySet();
	    	Object[] keys = keySet.toArray();
		    int scanDepth = maxDepth - 1;
		    while(scanDepth > -1) {
		    	for(int i=0; i<keys.length; i++) {
		    		JSONArray cObjs = (JSONArray)childList.get(keys[i]);
		    		for(int i2=0; i2<cObjs.size(); i2++) {
		    			JSONObject cObj = (JSONObject)cObjs.get(i2);
		    			if(Integer.parseInt( cObj.get("menudepth").toString() ) == scanDepth) {
			    			if(childList.get(cObj.get("menuid").toString()) != null) {
			    				cObj.put("children", childList.get(cObj.get("menuid").toString()).clone());
			    				JSONArray cObjs2 = (JSONArray) childList.get(cObj.get("menuid").toString());
			    				cObjs2.clear();
			    			}
		    			}
		    		}
		    	}
		    	scanDepth--;
		    }
	    	Boolean isOnDrop = true;
	    	for(int i=0; i<keys.length; i++) {
	    		JSONArray cObjs2 = (JSONArray)childList.get(keys[i]);
	    		if(!"ROOT".equals(keys[i])){
	    			if(!childList.toString().contains("\"menuid\":\""+keys[i]+"\"")){
	    				for(int i3=0; i3<cObjs2.size(); i3++){
			    			JSONObject cObj2 = (JSONObject)cObjs2.get(i3);
			    			JSONArray ROOT = (JSONArray)childList.get("ROOT");
		    				ROOT.add(cObj2);
		    				isOnDrop = false;
			    		}
	    			};
	    		}
	    	}
	    	if(!isOnDrop){
	    		JSONArray ROOT = (JSONArray)childList.get("ROOT");
		    	for(int i=0; i<ROOT.size(); i++){
		    		JSONObject cObj3 = (JSONObject)ROOT.get(i);
		    		cObj3.put("onDrop", "N");
		    	}
	    	}
		    /* 2015-09-14 by.나성재 수정 관리자가아닌 회원이 올경우 관리폴더 없을시 ROOT 사이즈 0 제거 주석처리
		    for(int i=0; i<keys.length; i++) {
		    	JSONArray cObjs = (JSONArray)childList.get(keys[i]);
		    	if(cObjs.size() == 0) childList.remove(keys[i]);
		    }
		    */
		    model.addAttribute("resultJson", childList.get("ROOT").toJSONString());
		    try {//menuJSON 로그인, 회원가입템플릿 추가
		    	childList = childListHashMap(siteVO, childList);
		    } catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		    if(request.getParameter("rebuild") != null) CmsHandler.writeFile(etcDir+"/menu.json", childList.get("ROOT").toJSONString());
	    }else {
	    	model.addAttribute("resultJson", null);
	    }

	    if(request.getParameter("rebuild") != null) {
	    	model.addAttribute("msg", "OK");
	    	return "jnit/msg";
	    }
        return "jnit/cms/disseminate/sub10_1-1-json";
    }

    @RequestMapping(value="/cms/sub10/0101add.do")
    public String addMenu(
            HttpServletRequest request,
            Model model)
            throws Exception {

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();

		if("".equals(siteId)) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
		}
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		if("1".equals(jnitcmsmenuService.menuPremJSON(request, siteId, "menuAll", "1", null))){
			JSONObject JSON = new JSONObject();
			JSON.put("message", "FAIL 1");
			model.addAttribute("resultJson", JSON.toJSONString());
			return "jnit/cms/disseminate/sub10_1-1-res";
		};
		JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
		menuVO.setSiteId(NullUtil.nullString(siteVO.getSiteId()));
		menuVO.setPid(NullUtil.nullString(request.getParameter("pid")));
		menuVO.setTplId(NullUtil.nullString(request.getParameter("tplid")));
		menuVO.setAdmMbrId(("".equals(NullUtil.nullString(request.getParameter("admid")).trim()) &&  request.getParameter("pid") == null) ? loginVO.getMbrId() : request.getParameter("admid"));

		int newDepth = Integer.parseInt(NullUtil.nullString(request.getParameter("depth")));
		menuVO.setDepth(newDepth);
		int newMethod = 0;
		if(request.getParameter("pid") == null) {
			newMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(menuVO)+1;
		}else {
			newMethod = Integer.parseInt(NullUtil.nullString(request.getParameter("method")))+1;
		}
		menuVO.setMethod(newMethod);

		menuVO.setMenuNm(NullUtil.nullString(request.getParameter("menuNm")));
		if(NullUtil.nullString(request.getParameter("iscnt")).toString().equals("1")) {
			menuVO.setIscnt(1);
			menuVO.setCcl("100");
		}
		menuVO.sethDel("Y");
		menuVO.setlDel("Y");
		menuVO.setsDel("Y");

		jnitcmsmenuService.updateJnitcmsmenuMethod(menuVO);
		String menuId = jnitcmsmenuService.insertJnitcmsmenu(menuVO,siteVO.getSitePath(),request);

		if(menuVO.getIscnt() == 1) {
			JnitcmscntVO cntVO = new JnitcmscntVO();
			cntVO.setSiteId(menuVO.getSiteId());
			cntVO.setMenuId(menuVO.getMenuId());
			cntVO.setTplId(menuVO.getTplId());
			String cntId = jnitcmscntService.insertJnitcmscnt(cntVO);

			menuVO.setCntId(cntId);
			jnitcmsmenuService.updateJnitcmsmenu(menuVO);

		}

    	JSONObject obj = new JSONObject();
	    obj.put("title", menuVO.getMenuNm());
	    obj.put("menuid", menuVO.getMenuId());
	    obj.put("menudepth", menuVO.getDepth());
	    obj.put("menumethod", menuVO.getMethod());
	    obj.put("key", menuVO.getMenuId());
	    obj.put("expand", true);
	    if(menuVO.getIscnt() ==  0) {
	    	obj.put("isFolder", true);
	    }

		model.addAttribute("siteVO", siteVO);
		model.addAttribute("menuId", menuId);
		model.addAttribute("resultJson", obj.toJSONString());
        return "jnit/cms/disseminate/sub10_1-1-res";
    }

    @RequestMapping(value="/cms/sub10/0101del.do")
    public String delMenu(
            HttpServletRequest request,
            Model model)
            throws Exception {

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();

		if("".equals(siteId)) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
		}
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		if("1".equals(jnitcmsmenuService.menuPremJSON(request, siteId, "menuAll", "1", null))){
			JSONObject JSON = new JSONObject();
			JSON.put("message", "FAIL 1");
			model.addAttribute("resultJson", JSON.toJSONString());
			return "jnit/cms/disseminate/sub10_1-1-res";
		};

		JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
		JnitcmsmenuDefaultVO searchVO = new JnitcmsmenuDefaultVO();
		menuVO.setSiteId(siteVO.getSiteId());
		menuVO.setMenuId(request.getParameter("menuId"));
		searchVO.setSiteId(siteVO.getSiteId());

		JnitcmsmenuVO vo = selectJnitcmsmenu(menuVO, searchVO);

        Boolean bFail = false;
		String beforePath = jnitcmsmenuService.makeMenuDirectoryName(vo, siteVO.getSitePath());
        String beforeDir = PathUtil.getRealPath(request)+ beforePath;
        String backupRootDir = PathUtil.getRealPath(request)+ "_menu_backup";
        String backupDir = PathUtil.getRealPath(request)+ "_menu_backup/" + vo.getMenuId();

        File bf = new File(beforeDir);
	    File bkf = new File(backupDir);
	    File bkrf = new File(backupRootDir);

	    if(!bkrf.exists()){
	    	bkrf.mkdirs();
	    }

        if(bf.exists() && !bkf.exists()) {
        	//log.debug("rename");
        	if(!bf.renameTo(bkf)) {
        		//log.debug("rename fail!");
        		model.addAttribute("backurl", "/cms/sub10/0101editForm.do?menuId=" + vo.getMenuId());
        		model.addAttribute("msg", "경로를 변경할 수 없습니다.");

	        	bFail = true;
        	}
        }else {
        	//log.debug("rename fail! backup exists or dir not exists");
        	model.addAttribute("backurl", "/cms/sub10/0101editForm.do?menuId=" + vo.getMenuId());
        	model.addAttribute("msg", "해당 경로가 이미 존재합니다.");

        	bFail = true;
        }

		if(bFail.booleanValue() == false) {
			if(vo.getIscnt() == 1) {
				JnitcmscntVO cntVO = new JnitcmscntVO();
				cntVO.setCntId(vo.getCntId());
				jnitcmscntService.deleteJnitcmscnt(cntVO);
			}

			jnitcmsmenuService.deleteJnitcmsmenu(menuVO);
			model.addAttribute("resultJson", new JSONObject());

			return "jnit/cms/disseminate/sub10_1-1-res";
    	}else {
    		return "jnit/cms/disseminate/sub10_msg-error";
    	}
    }

    @RequestMapping(value="/cms/sub10/0101edit.do")
    public String editMenu(
            HttpServletRequest request,
            Model model)
            throws Exception {

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();

		if("".equals(siteId)) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
		}
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		if("1".equals(jnitcmsmenuService.menuPremJSON(request, siteId, "menuAll", "1", null))){
			JSONObject JSON = new JSONObject();
			JSON.put("message", "FAIL 1");
			model.addAttribute("resultJson", JSON.toJSONString());
			return "jnit/cms/disseminate/sub10_1-1-res";
		};

		JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
		menuVO.setSiteId(siteVO.getSiteId());
		menuVO.setMenuId(request.getParameter("menuId"));
		menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);
		menuVO.setMenuNm(request.getParameter("menuNm"));

    	// 기본페이지인지 확인
        JnitcmsmenuVO parentVO = new JnitcmsmenuVO();
        parentVO.setSiteId(siteVO.getSiteId());
        parentVO.setMenuId(menuVO.getPid());
        parentVO = jnitcmsmenuService.selectJnitcmsmenu(parentVO);

        boolean isDefaultPage = false;
        if(NullUtil.nullString(parentVO.getCntId()).equals(menuVO.getCntId())) {
        	//log.debug("isDefault");
       		isDefaultPage = true;
        }

		if( menuVO.getIscnt() == 1) {
			Properties props = new Properties();
	        // File.props 로딩
	        String propsFile = PathUtil.getRealPath(request)
			+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) + "/index.jsp.prop";
	        File f = new File(propsFile);
	        if(f.exists()) {
	        	FileInputStream fis = null;
	        	try {
	        		fis = new FileInputStream(propsFile);
	        		props.load(fis);
	        		JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, propsFile);		//Filego 배포
	        	} catch (IOException e){
	    			log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				} finally {
					if(fis != null){
						fis.close();
					}
				}

				// 페이지 Property 세팅
		    	props.setProperty("siteId", siteVO.getSiteId());
		    	props.setProperty("menuId", menuVO.getMenuId());
		    	props.setProperty("cntId", menuVO.getCntId());
		    	props.setProperty("tplId", menuVO.getTplId());
		    	props.setProperty("menuPath", jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()));

				// 페이지 타이틀 키워드 치환
				String pageTitleKeyword = "";
				if(isDefaultPage == true) {
					pageTitleKeyword = parentVO.getMenuNm();
				}else {
					pageTitleKeyword = menuVO.getMenuNm();
				}
		    	props.setProperty("pageTitle", pageTitleKeyword);

				// 페이지 이미지 타이틀 치환
				if(menuVO.getMenuImgUrl() != null && !menuVO.getMenuImgUrl().equals("")) {
					// 이미지 타이틀
					pageTitleKeyword = "<img src='"+request.getSession().getServletContext().getContextPath()+menuVO.getMenuImgUrl()+"' border='0' alt='"+menuVO.getMenuNm()+"' />";
				}
		    	props.setProperty("pageImgTitle", pageTitleKeyword);

				// 페이지 네비
				String menuNames = "";
				if(isDefaultPage == true) {
					menuNames = (String)jnitcmsmenuService.makeMenuNames(parentVO, "Home");
				}else {
					menuNames = (String)jnitcmsmenuService.makeMenuNames(menuVO, "Home");
				}
		    	props.setProperty("pageNav", menuNames);

				// 페이지 링크 네비
				String menuLinkNames = "";
				if(isDefaultPage == true) {
					menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(parentVO, "Home", siteVO.getSitePath());
				}else {
					menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(menuVO, "Home", siteVO.getSitePath());
				}
		    	props.setProperty("pageLinkNav", menuLinkNames);

				// 페이지 CNT_ID 를 Hash로 제공
				String pageIdHash = "";
				MessageDigest md = MessageDigest.getInstance("SHA-256");
				byte[] bip = md.digest( menuVO.getCntId().getBytes() );
				for(int i=0; i<bip.length; i++) {
					pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
				}
		    	props.setProperty("pageCode", pageIdHash);

		    	FileOutputStream outStream = null;
		    	try {
		    		outStream =  new FileOutputStream(propsFile);
		    		props.store(outStream,menuVO.getMenuId()+" (by Jnitcms 3.5)"
				        );
		    		JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, propsFile);		//Filego 배포
		    	} catch (IOException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				} finally {
			        outStream.close();
				}
		    	// File.props 저장

		        // CCL
		        String cclValue = NullUtil.nullString(request.getParameter("cclYn"));
		        if(cclValue.equals("0")){
		        	menuVO.setCcl(cclValue);
		        }else{
		        	cclValue = "";
		        	cclValue = NullUtil.nullString(request.getParameter("cclYn"))
		        			   + NullUtil.nullString(request.getParameter("cclChange"))
		        			   + NullUtil.nullString(request.getParameter("cclProfit"));
		        	menuVO.setCcl(cclValue);
		        }

	        }
		}

		jnitcmsmenuService.updateJnitcmsmenuTitle(menuVO);

		model.addAttribute("resultJson", null);

		return "jnit/cms/disseminate/sub10_1-1-res";
    }

    @RequestMapping(value="/cms/sub10/0101editMethod.do")
    public synchronized String editMethod(
            HttpServletRequest request,
            Model model)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		String srcId = NullUtil.nullString(request.getParameter("srcId"));
		String dstId = NullUtil.nullString(request.getParameter("dstId"));
		JnitcmsmenuVO searchVO = new JnitcmsmenuVO();
		searchVO.setSiteId(siteVO.getSiteId());

		searchVO.setMenuId(srcId);
		JnitcmsmenuVO srcVO = jnitcmsmenuService.selectJnitcmsmenu(searchVO);
		//log.debug("src: "+ srcId + " obj: "+ srcVO);

		searchVO.setMenuId(dstId);
		JnitcmsmenuVO dstVO = jnitcmsmenuService.selectJnitcmsmenu(searchVO);
		//log.debug("dst: "+ dstId + " obj: "+ dstVO);


		int srcMethod = 0;
		try {
			srcMethod = jnitcmsmenuService.selectJnitcmsmenuNextMethod(srcVO);
		} catch (NullPointerException e){
			srcMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(srcVO)+1;
		}catch(Exception e) {
			srcMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(srcVO)+1;
		}
		//log.debug("sMethod:"+ srcVO.getMethod() + "~" + (srcMethod-1));


		int dstMethod = 0;
		try {
			dstMethod = jnitcmsmenuService.selectJnitcmsmenuNextMethod(dstVO);
		} catch (NullPointerException e){
			dstMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(dstVO)+1;
		}catch(Exception e) {
			dstMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(dstVO)+1;
		}
		//log.debug("dMethod:"+ dstVO.getMethod() + "~" + (dstMethod-1));


		JnitcmsmenuChMethodVO chmethodVO = new JnitcmsmenuChMethodVO();

		chmethodVO.setSiteId(siteVO.getSiteId());

		chmethodVO.setSrcSMethod(srcVO.getMethod());
		chmethodVO.setSrcEMethod((srcMethod-1));
		chmethodVO.setSrcMenuId(srcVO.getMenuId());

		chmethodVO.setDstSMethod(dstVO.getMethod());
		chmethodVO.setDstEMethod((dstMethod-1));
		chmethodVO.setDstMenuId(dstVO.getMenuId());

		if(srcVO.getMethod() > dstVO.getMethod()) {
			// up
			chmethodVO.setMoveMode("up");
		}

		if(srcVO.getMethod() < dstVO.getMethod()) {
			// down
			chmethodVO.setMoveMode("down");
		}

		jnitcmsmenuService.updateJnitcmsmenuChMethod(chmethodVO);

		//jnitcmsmenuService.updateJnitcmsmenuMethod(menuVO);
		/*
		JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
		menuVO.setSiteId(siteVO.getSiteId());
		menuVO.setMenuId(request.getParameter("menuId"));
		menuVO.setMenuNm(request.getParameter("srcMethod"));

		jnitcmsmenuService.updateJnitcmsmenuChMethod(menuVO);
		*/
		model.addAttribute("resultJson", null);

		return "jnit/cms/disseminate/sub10_1-1-res";
    }

    @RequestMapping("/cms/sub10/0101editForm.do")
    public String updateJnitcmsmenuView(
            @RequestParam("menuId") java.lang.String menuId,
            @ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO,
            HttpServletRequest request,
            Model model)
            throws Exception {

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();

		if("".equals(siteId)) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
		}
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		model.addAttribute("siteVO", siteVO);

        JnitcmsmenuVO jnitcmsmenuVO = new JnitcmsmenuVO();
        jnitcmsmenuVO.setSiteId(siteVO.getSiteId());

        if(menuId.equals("")) {
        	jnitcmsmenuVO.setMenuId(request.getParameter("menu"));
        }else {
        	jnitcmsmenuVO.setMenuId(menuId);
        }

        // 변수명은 CoC 에 따라 jnitcmsmenuVO
        JnitcmsmenuVO vo = selectJnitcmsmenu(jnitcmsmenuVO, searchVO);
        String menuPath = (String) jnitcmsmenuService.makeMenuDirectory(vo, siteVO.getSitePath(), request);
        model.addAttribute("jnitcmsmenuVO", vo);
        model.addAttribute("menuPath", menuPath);
        model.addAttribute("success", request.getParameter("success"));

        List<String> islinkItem = new ArrayList<String>();
        islinkItem.add("사용안함");
        islinkItem.add("사용");
        model.addAttribute("islinkItem", islinkItem);

       	ComDefaultCodeVO comVO = new ComDefaultCodeVO();

    	// TPL정보조회
       	comVO.setCode("B");
       	comVO.setHaveDetailCondition("Y");
       	comVO.setDetailCondition(siteVO.getSiteId());
    	List<CmmnDetailCode> tplId_result = jnitcmstplService.selectTplIdDetail(comVO);
    	model.addAttribute("tplId_result", tplId_result);

    	// MBR정보조회 (ADM_MBR_ID)
    	String admMbrId = "";
    	try {
    		 admMbrId = vo.getAdmMbrId().toString();
    		 if(admMbrId.equals("null")) admMbrId = "";
    		 if(admMbrId.trim().isEmpty()) admMbrId = "";
    	} catch (NullPointerException e){
    		admMbrId = "";
    	}catch(Exception e) {
    		admMbrId = "";
    	}
    	//log.debug("mbr_id :" + vo.getAdmMbrId() + " " + admMbrId.trim().isEmpty());


    	if(admMbrId.trim() != "") {
    		HashMap<String, String> admMbrIdMap = new HashMap<String, String>();
    		HashMap<String, String> admMap = new HashMap<String, String>();

    		String[] admId = admMbrId.split(",");
    		for(int i=0; i<admId.length; i++){
    			admMbrIdMap.put(Integer.toString(i), admId[i]);
    		}
    		model.addAttribute("admMbrIdMap", admMbrIdMap);

    		//담당자 1지정
			JnitcmsmbrVO mbrVO1 = new JnitcmsmbrVO();
			if(admMbrIdMap.get("0") != null){
				mbrVO1.setMbrId(admMbrIdMap.get("0"));
				try {
					mbrVO1 = jnitcmsmbrService.selectJnitcmsmbr(mbrVO1);
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				if(mbrVO1.getMbrId() != null){
					String mbrNm = NullUtil.nullString(mbrVO1.getMbrNm());
					String orgNm = "";
					String posNm = "";
					String rankNm = "";
					String adm01 = "";

					//부서
					String orgId = NullUtil.nullString(mbrVO1.getOrgId());
					JnitcmsorgVO orgVO = new JnitcmsorgVO();
					orgVO.setOrgId(orgId);
					try {
						orgVO = jnitcmsorgService.selectJnitcmsorg(orgVO);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(orgVO.getOrgId() != null){
						orgNm = NullUtil.nullString(orgVO.getOrgNm());
					}

					//팀
					String rankId = NullUtil.nullString(mbrVO1.getRankId());
					JnitcmsrankVO rankVO = new JnitcmsrankVO();
					rankVO.setRankId(rankId);
					try {
						rankVO = jnitcmsrankService.selectJnitcmsrank(rankVO);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(rankVO.getRankId() != null){
						rankNm = NullUtil.nullString(rankVO.getRankName());
					}

					//직급
					String posId = NullUtil.nullString(mbrVO1.getPosId());
					JnitcmsposVO posVO = new JnitcmsposVO();
					posVO.setPosId(posId);
					try {
						posVO = jnitcmsposService.selectJnitcmspos(posVO);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(posVO.getPosId() != null){
						posNm = NullUtil.nullString(posVO.getPosNm());
					}

					if(!orgNm.equals("") && !posNm.equals("") && !rankNm.equals("")){
						adm01 = orgNm+": "+mbrNm+"("+rankNm+"/"+posNm+")";
	    			}else if(orgNm.equals("") && !posNm.equals("") && !rankNm.equals("")){
	    				adm01 = mbrNm+"("+rankNm+"/"+posNm+")";
	    			}else if(orgNm.equals("") && !posNm.equals("") && rankNm.equals("")){
	    				adm01 = mbrNm+"("+posNm+")";
	    			}else if(orgNm.equals("") && posNm.equals("") && !rankNm.equals("")){
	    				adm01 = mbrNm+"("+rankNm+")";
	    			}else if(!orgNm.equals("") && !posNm.equals("") && rankNm.equals("")){
	    				adm01 = orgNm+": "+mbrNm+"("+posNm+")";
	    			}else if(!orgNm.equals("") && posNm.equals("") && !rankNm.equals("")){
	    				adm01 = orgNm+": "+mbrNm+"("+rankNm+")";
	    			}else if(!orgNm.equals("") && posNm.equals("") && rankNm.equals("")){
	    				adm01 = orgNm+": "+mbrNm;
	    			}else{
	    				adm01 = mbrNm;
	    			}
					admMap.put("0", adm01);
				}
			}

			//담당자 2지정
			JnitcmsmbrVO mbrVO2 = new JnitcmsmbrVO();
			if(admMbrIdMap.get("1") != null){
				mbrVO2.setMbrId(admMbrIdMap.get("1"));
				try {
					mbrVO2 = jnitcmsmbrService.selectJnitcmsmbr(mbrVO2);
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				if(mbrVO2.getMbrId() != null){
					String mbrNm = NullUtil.nullString(mbrVO2.getMbrNm());
					String orgNm = "";
					String posNm = "";
					String rankNm = "";
					String adm02 = "";

					//부서
					String orgId = NullUtil.nullString(mbrVO2.getOrgId());
					JnitcmsorgVO orgVO = new JnitcmsorgVO();
					orgVO.setOrgId(orgId);
					try {
						orgVO = jnitcmsorgService.selectJnitcmsorg(orgVO);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(orgVO.getOrgId() != null){
						orgNm = NullUtil.nullString(orgVO.getOrgNm());
					}

					//팀
					String rankId = NullUtil.nullString(mbrVO2.getRankId());
					JnitcmsrankVO rankVO = new JnitcmsrankVO();
					rankVO.setRankId(rankId);
					try {
						rankVO = jnitcmsrankService.selectJnitcmsrank(rankVO);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(rankVO.getRankId() != null){
						rankNm = NullUtil.nullString(rankVO.getRankName());
					}

					//직급
					String posId = NullUtil.nullString(mbrVO2.getPosId());
					JnitcmsposVO posVO = new JnitcmsposVO();
					posVO.setPosId(posId);
					try {
						posVO = jnitcmsposService.selectJnitcmspos(posVO);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(posVO.getPosId() != null){
						posNm = NullUtil.nullString(posVO.getPosNm());
					}

					if(!orgNm.equals("") && !posNm.equals("") && !rankNm.equals("")){
						adm02 = orgNm+": "+mbrNm+"("+rankNm+"/"+posNm+")";
	    			}else if(orgNm.equals("") && !posNm.equals("") && !rankNm.equals("")){
	    				adm02 = mbrNm+"("+rankNm+"/"+posNm+")";
	    			}else if(orgNm.equals("") && !posNm.equals("") && rankNm.equals("")){
	    				adm02 = mbrNm+"("+posNm+")";
	    			}else if(orgNm.equals("") && posNm.equals("") && !rankNm.equals("")){
	    				adm02 = mbrNm+"("+rankNm+")";
	    			}else if(!orgNm.equals("") && !posNm.equals("") && rankNm.equals("")){
	    				adm02 = orgNm+": "+mbrNm+"("+posNm+")";
	    			}else if(!orgNm.equals("") && posNm.equals("") && !rankNm.equals("")){
	    				adm02 = orgNm+": "+mbrNm+"("+rankNm+")";
	    			}else if(!orgNm.equals("") && posNm.equals("") && rankNm.equals("")){
	    				adm02 = orgNm+": "+mbrNm;
	    			}else{
	    				adm02 = mbrNm;
	    			}
					admMap.put("1", adm02);
				}
			}
	    	model.addAttribute("admMap", admMap);
    	}

    	// 기본페이지인지 확인
    	if(vo.getIscnt() == 1) {
    		boolean isDefaultPage = false;

	        JnitcmsmenuVO parentVO = new JnitcmsmenuVO();
	        parentVO.setSiteId(siteVO.getSiteId());
	        parentVO.setMenuId(vo.getPid());
	        parentVO = selectJnitcmsmenu(parentVO, searchVO);

	        String pCid = "";
	        String vCid = "";
	        if(parentVO.getCntId() != null) {
	        	pCid = parentVO.getCntId();
	        }

	        if(vo.getCntId() != null) {
	        	vCid = vo.getCntId();
	        }

	        if(pCid.equals(vCid)) {
	        	isDefaultPage = true;
	        }

	        model.addAttribute("isDefaultPage", isDefaultPage);
	        model.addAttribute("cclVal", vo.getCcl());
    	}

    	// 페이지 미리보기 URL
    	String previewUrl = jnitcmsmenuService.makeMenuDirectoryName(vo, siteVO.getSitePath());
    	model.addAttribute("previewUrl", previewUrl);
    	//<c:out value="${orgId_result[result.orgId]}"/> : <c:out value="${result.mbrNm}"/> (<c:out value="${posId_result[result.posId]}"/>)
    	if(vo.getIscnt() == 1){
    		JnitcmscntVO cntVO = new JnitcmscntVO();
    		cntVO.setCntId(vo.getCntId());
    		cntVO.setSearchCondition("1");
    		cntVO = jnitcmscntService.selectJnitcmscnt(cntVO);

    		model.addAttribute("cntModified", new SimpleDateFormat("yyyy.MM.dd").format(cntVO.getModified()));
    		model.addAttribute("directoryName", menuPath);
    		model.addAttribute("cntVO", cntVO);
    	}
        return "jnit/cms/disseminate/sub10_1-1-menuform";
    }

    @RequestMapping(value="/cms/sub10/0101editDetail.do")
    public String editJnitcmsmenu(
            @ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO,
    	    @ModelAttribute("jnitcmsmenuVO") JnitcmsmenuVO jnitcmsmenuVO,
    	    BindingResult bindingResult,
    	    HttpServletRequest request,
    	    SessionStatus status,
    	    Model model)
            throws Exception {

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	JSONObject json = new JSONObject();

		if("".equals(siteId)) {
			//return "jnit/cms/disseminate/sub10_msg-nosite";
		}
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		jnitcmsmenuVO.setSiteId(siteVO.getSiteId());

		JnitcmsmenuVO vo = selectJnitcmsmenu(jnitcmsmenuVO, searchVO);
		String menuPath = (String)jnitcmsmenuService.makeMenuDirectoryName(jnitcmsmenuVO, siteVO.getSitePath());

        Boolean bFail = false;
		if(!vo.getMenuPath().equals(jnitcmsmenuVO.getMenuPath())) {
			String beforePath = jnitcmsmenuService.makeMenuDirectoryName(vo, siteVO.getSitePath());
			String afterPath = jnitcmsmenuService.makeMenuDirectoryName(jnitcmsmenuVO, siteVO.getSitePath());
			//log.debug("before:" + beforePath + " after:" + afterPath);

	        String beforeDir = PathUtil.getRealPath(request)+ beforePath;
	        String afterDir = PathUtil.getRealPath(request)+ afterPath;
	        File bf = new File(beforeDir);
	        File af = new File(afterDir);

	        if(!af.exists()) {
	        	if("true".equals(deDug)) log.debug("rename");
	        	if(!bf.renameTo(af)) {
	        		if("true".equals(deDug)) log.debug("rename fail!");
	        		model.addAttribute("backurl", "/cms/sub10/0101editForm.do?menuId=" + jnitcmsmenuVO.getMenuId());
	        		model.addAttribute("msg", "경로를 변경할 수 없습니다.");
	        		json.put("msg", "경로를 변경할 수 없습니다.");
		        	bFail = true;
	        	}
	        }else {
	        	if("true".equals(deDug)) log.debug("rename fail! exists name");
	        	model.addAttribute("backurl", "/cms/sub10/0101editForm.do?menuId=" + jnitcmsmenuVO.getMenuId());
	        	model.addAttribute("msg", "해당 경로가 이미 존재합니다.");
	        	json.put("msg", "해당 경로가 이미 존재합니다.");
	        	bFail = true;
	        }
		}

		//담당자 지정
		String admTel = "";
		String admNm = "";
		String admMbrId1 = NullUtil.nullString(request.getParameter("admMbrId1")).trim();
		String admMbrId2 = NullUtil.nullString(request.getParameter("admMbrId2")).trim();
		String admMbrId = "";
		admMbrId = admMbrId1 + (admMbrId1.equals("") || admMbrId2.equals("")  ? "" : ",")+admMbrId2;
		jnitcmsmenuVO.setAdmMbrId(admMbrId);
		if(bFail.booleanValue() == false) {
			if(jnitcmsmenuVO.getAdmMbrId() == "") {
				jnitcmsmenuVO.setAdmMbrId(null);
			}

			if(jnitcmsmenuVO.getIscnt() == 1) {
				JnitcmscntVO cntVO = new JnitcmscntVO();
				cntVO.setCntId(jnitcmsmenuVO.getCntId());
				cntVO.setTplId(jnitcmsmenuVO.getTplId());
				jnitcmscntService.updateJnitcmscntOpt(cntVO);

		    	// 기본페이지인지 확인
		        JnitcmsmenuVO parentVO = new JnitcmsmenuVO();
		        parentVO.setSiteId(siteVO.getSiteId());
		        parentVO.setMenuId(jnitcmsmenuVO.getPid());
		        parentVO = selectJnitcmsmenu(parentVO, searchVO);

		        boolean isDefaultPage = false;
		        if(request.getParameter("isDefaultPage") != null) {
		        	if("true".equals(deDug)) log.debug("isDefault");
		        	if(request.getParameter("isDefaultPage").equals("1")) {
		        		//log.debug(" : ok");
		        		parentVO.setCntId(jnitcmsmenuVO.getCntId());
		        		jnitcmsmenuService.updateJnitcmsmenu(parentVO);
		        		isDefaultPage = true;
		        	}else {
		        		//log.debug(" : no");
		    	        String pCid = "";
		    	        String vCid = "";
		    	        if(parentVO.getCntId() != null) {
		    	        	pCid = parentVO.getCntId();
		    	        }

		    	        if(jnitcmsmenuVO.getCntId() != null) {
		    	        	vCid = jnitcmsmenuVO.getCntId();
		    	        }

		    	        if(pCid.equals(vCid)) {
		        			parentVO.setCntId("");
		        			jnitcmsmenuService.updateJnitcmsmenu(parentVO);
		        		}
		        	}
		        }
		        String root = PathUtil.getRealPath(request);
		        String fileDir = root + "/"+siteVO.getSitePath()+"/common/titleImg";
				HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, fileDir, maxFileSize);
				if(list.get("menuImg") != null) {
		    		EgovFormBasedFileVo fvo = list.get("menuImg");
		    		String filePathDir = siteVO.getSitePath()+"/common/titleImg/";
		    	    String url = "/cms/getFile.do?"
		    	    + "path=" + fvo.getServerSubPath()
		    	    + "&amp;file=" + fvo.getPhysicalName()
		    	    + "&amp;orgname=" + fvo.getFileName()
		    	    + "&filePath="+filePathDir;

		    	    String realpath = uploadDir + fvo.getServerSubPath() + "/" + fvo.getPhysicalName();

		    	    if(!jnitcmsmenuVO.getMenuImgFile().equals("")) {
		    	    	String oldPath = uploadDir + jnitcmsmenuVO.getMenuImgPath() + "/" + jnitcmsmenuVO.getMenuImgFile();
		    	    	File oldFile = new File(oldPath);
		    	    	if(oldFile.exists()) oldFile.delete();
		    	    }
		    	    jnitcmsmenuVO.setMenuImgFile(fvo.getPhysicalName());
		    	    jnitcmsmenuVO.setMenuImgPath(fvo.getServerSubPath());
		    	    jnitcmsmenuVO.setMenuImgOnm(fvo.getFileName());
		    	    jnitcmsmenuVO.setMenuImgUrl(url);
				}
				if(NullUtil.nullString(request.getParameter("imgDel")).equals("true")){
					jnitcmsmenuVO.setMenuImgFile("");
		    	    jnitcmsmenuVO.setMenuImgPath("");
		    	    jnitcmsmenuVO.setMenuImgOnm("");
		    	    jnitcmsmenuVO.setMenuImgUrl("");
				}
				HashMap<String, String> admMbrIdMap = new HashMap<String, String>();
				if(!admMbrId.equals("")){
					String[] admId = admMbrId.split(",");
		    		for(int i=0; i<admId.length; i++){
		    			admMbrIdMap.put(Integer.toString(i), admId[i]);
		    		}
				}

				HashMap<Integer, String> admNmMap = new HashMap<Integer, String>();
				HashMap<Integer, String> admTelMap = new HashMap<Integer, String>();

				//담당자 1지정
				JnitcmsmbrVO mbrVO1 = new JnitcmsmbrVO();
				if(admMbrIdMap.get("0") != null){
					mbrVO1.setMbrId(admMbrIdMap.get("0"));
					try {
						mbrVO1 = jnitcmsmbrService.selectJnitcmsmbr(mbrVO1);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(mbrVO1.getMbrId() != null){
						String mbrNm = NullUtil.nullString(mbrVO1.getMbrNm());
						admTel = NullUtil.nullString(mbrVO1.getTel());
						//부서
						String orgId = NullUtil.nullString(mbrVO1.getOrgId());
						String orgNm = "";

						JnitcmsorgVO orgVO = new JnitcmsorgVO();
						orgVO.setOrgId(orgId);
						try {
							orgVO = jnitcmsorgService.selectJnitcmsorg(orgVO);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						if(orgVO.getOrgId() != null){
							orgNm = NullUtil.nullString(orgVO.getOrgNm());
						}

						if(!orgNm.equals("null")){
		    				admNm = orgNm+" "+mbrNm;
		    			}else{
		    				admNm = mbrNm;
		    			}
						admNmMap.put(0, admNm);
						admTelMap.put(0, admTel);
					}
				}

				//담당자 2지정
				JnitcmsmbrVO mbrVO2 = new JnitcmsmbrVO();
				if(admMbrIdMap.get("1") != null){
					mbrVO2.setMbrId(admMbrIdMap.get("1"));
					try {
						mbrVO2 = jnitcmsmbrService.selectJnitcmsmbr(mbrVO2);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(mbrVO2.getMbrId() != null){
						String mbrNm = NullUtil.nullString(mbrVO2.getMbrNm());
						admTel = NullUtil.nullString(mbrVO2.getTel());

						//부서
						String orgId = NullUtil.nullString(mbrVO2.getOrgId());
						String orgNm = "";

						JnitcmsorgVO orgVO = new JnitcmsorgVO();
						orgVO.setOrgId(orgId);
						try {
							orgVO = jnitcmsorgService.selectJnitcmsorg(orgVO);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						if(orgVO.getOrgId() != null){
							orgNm = NullUtil.nullString(orgVO.getOrgNm());
						}

						if(!orgNm.equals("")){
		    				admNm = orgNm+" "+mbrNm;
		    			}else{
		    				admNm = mbrNm;
		    			}
						admNmMap.put(1, admNm);
						admTelMap.put(1, admTel);
					}
				}


				//로봇검색 허용여부
				String robotYn = NullUtil.nullString(request.getParameter("robotYn"));

				Properties props = new Properties();
		        // File.props 로딩
		        String propsFile = PathUtil.getRealPath(request)
				+ "/" + menuPath + "/index.jsp.prop";

		        File f = new File(propsFile);
		        FileInputStream fis = null;
		        if(f.exists()) {
		        	try {
		        		fis = new FileInputStream(propsFile);
		        		props.load(fis);
		        	} catch (IOException e){
		    			log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					} finally {
						if(fis != null){
							fis.close();
						}
					}

					// 페이지 Property 세팅
			    	props.setProperty("siteId", siteVO.getSiteId());
			    	props.setProperty("menuId", jnitcmsmenuVO.getMenuId());
			    	props.setProperty("cntId", cntVO.getCntId());
			    	props.setProperty("tplId", cntVO.getTplId());
			    	props.setProperty("menuPath", menuPath);

			    	//담당자1
			    	props.setProperty("admId", admMbrIdMap.get("0") == null ? "" : admMbrIdMap.get("0"));
			    	props.setProperty("admNm", admNmMap.get(0) == null ? "" : admNmMap.get(0));
			    	props.setProperty("admTel", admTelMap.get(0) == null ? "" : admTelMap.get(0));

			    	//담당자2
			    	props.setProperty("admId2", admMbrIdMap.get("1") == null ? "" : admMbrIdMap.get("1"));
			    	props.setProperty("admNm2", admNmMap.get(1) == null ? "" : admNmMap.get(1));
			    	props.setProperty("admTel2", admTelMap.get(1) == null ? "" : admTelMap.get(1));

			    	//로봇검색 허용여부 0 허용 , 1 차단
			    	props.setProperty("robotYn", robotYn);

			    	//meta 설정
					props.setProperty("metaTitle",  jnitcmsmenuVO.getMetaTitle());
					props.setProperty("metaSubject",  jnitcmsmenuVO.getMetaSubject());
					props.setProperty("metaKeyword",  jnitcmsmenuVO.getMetaKeyword());
					props.setProperty("metaDescription",  jnitcmsmenuVO.getMetaDescription());
					props.setProperty("metaClassification",  jnitcmsmenuVO.getMetaClassification());
					props.setProperty("metaReply",  jnitcmsmenuVO.getMetaRePly());
					props.setProperty("metaLanguage",  jnitcmsmenuVO.getMetaLanguage());
					props.setProperty("metaBuild",  jnitcmsmenuVO.getMetaBuild());

					// 페이지 타이틀 키워드 치환
					String pageTitleKeyword = "";
					if(isDefaultPage == true) {
						pageTitleKeyword = parentVO.getMenuNm();
					}else {
						pageTitleKeyword = jnitcmsmenuVO.getMenuNm();
					}
			    	props.setProperty("pageTitle", pageTitleKeyword);

			    	// 페이지 CCL
					String pageCcl = "";
					if(isDefaultPage == true) {
						pageCcl = NullUtil.nullString(request.getParameter("cclYn"));
				        if(pageCcl.equals("0")){
				        	jnitcmsmenuVO.setCcl(pageCcl);
				        }else{
				        	pageCcl = NullUtil.nullString(request.getParameter("cclYn"))
				        			   + NullUtil.nullString(request.getParameter("cclChange"))
				        			   + NullUtil.nullString(request.getParameter("cclProfit"));
				        	jnitcmsmenuVO.setCcl(pageCcl);
				        }
						pageCcl = jnitcmsmenuVO.getCcl();
					}else {
						pageCcl = NullUtil.nullString(request.getParameter("cclYn"));
				        if(pageCcl.equals("0")){
				        	jnitcmsmenuVO.setCcl(pageCcl);
				        }else{
				        	pageCcl = NullUtil.nullString(request.getParameter("cclYn"))
				        			   + NullUtil.nullString(request.getParameter("cclChange"))
				        			   + NullUtil.nullString(request.getParameter("cclProfit"));
				        	jnitcmsmenuVO.setCcl(pageCcl);
				        }
						pageCcl = jnitcmsmenuVO.getCcl();
					}
					props.setProperty("pageCcl", pageCcl);

					// 페이지 이미지 타이틀 치환
					if(jnitcmsmenuVO.getMenuImgUrl() != null && !jnitcmsmenuVO.getMenuImgUrl().equals("")) {
						// 이미지 타이틀
						pageTitleKeyword = "<img src='"+request.getSession().getServletContext().getContextPath()+jnitcmsmenuVO.getMenuImgUrl()+"' border='0' alt='"+jnitcmsmenuVO.getMenuNm()+"' />";
					}
			    	props.setProperty("pageImgTitle", pageTitleKeyword);

					// 페이지 네비
					String menuNames = "";
					if(isDefaultPage == true) {
						menuNames = (String)jnitcmsmenuService.makeMenuNames(parentVO, "Home");
					}else {
						menuNames = (String)jnitcmsmenuService.makeMenuNames(jnitcmsmenuVO, "Home");
					}
			    	props.setProperty("pageNav", menuNames);

					// 페이지 링크 네비
					String menuLinkNames = "";
					if(isDefaultPage == true) {
						menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(parentVO, "Home", siteVO.getSitePath());
					}else {
						menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(jnitcmsmenuVO, "Home", siteVO.getSitePath());
					}
			    	props.setProperty("pageLinkNav", menuLinkNames);

					// 페이지 CNT_ID 를 Hash로 제공
					String pageIdHash = "";
					MessageDigest md = MessageDigest.getInstance("SHA-256");
					byte[] bip = md.digest( jnitcmsmenuVO.getCntId().getBytes() );
					for(int i=0; i<bip.length; i++) {
						pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
					}
			    	props.setProperty("pageCode", pageIdHash);

			    	// File.props 저장
			    	FileOutputStream outStream = new FileOutputStream(propsFile);
			    	try {
			    		outStream = new FileOutputStream(propsFile);
			    		props.store(outStream,jnitcmsmenuVO.getMenuId()+" (by Jnitcms 3.5)"
				        );
			    		JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, propsFile);		//Filego 배포
			    	} catch (IOException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					} finally {
				        outStream.close();
					}
		        }
		        String cclValue = NullUtil.nullString(request.getParameter("cclYn"));
		        if(cclValue.equals("0") || cclValue.equals("")){
		        	jnitcmsmenuVO.setCcl(cclValue);
		        }else{
		        	cclValue = NullUtil.nullString(request.getParameter("cclYn"))
		        			   + NullUtil.nullString(request.getParameter("cclChange"))
		        			   + NullUtil.nullString(request.getParameter("cclProfit"));
		        	jnitcmsmenuVO.setCcl(cclValue);
		        }
			}

			jnitcmsmenuService.updateJnitcmsmenu(jnitcmsmenuVO);
    		status.setComplete();

    		json.put("process", "true");
    		model.addAttribute("json",json);
			//return "redirect:/cms/sub10/0101editForm.do?success=true&menuId=" + jnitcmsmenuVO.getMenuId();
    		return "jnit/util/json";
    	}else {
    		//return "jnit/cms/disseminate/sub10_msg-error";
    		json.put("process", "false");
    		model.addAttribute("json",json);
    		return "jnit/util/json";
    	}
    }

    @RequestMapping("/cms/sub10/0101view.do")
    public @ModelAttribute("jnitcmsmenuVO")
    JnitcmsmenuVO selectJnitcmsmenu(
            JnitcmsmenuVO jnitcmsmenuVO,
            @ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO) throws Exception {
        return jnitcmsmenuService.selectJnitcmsmenu(jnitcmsmenuVO);
    }

    @RequestMapping("/cms/sub10/adm/cancel.do")
    public String admCancel(@ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO
    		, @ModelAttribute("jnitcmsmenuVO") JnitcmsmenuVO jnitcmsmenuVO
    		, HttpServletRequest request
    		, ModelMap model)throws Exception{

    	if(!"".equals(NullUtil.nullString(jnitcmsmenuVO.getAdmMbrId()))){
    		JnitcmssiteVO siteVO = new JnitcmssiteVO();
    		siteVO.setSiteId(jnitcmsmenuVO.getSiteId());
    		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

    		JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
    		menuVO.setMenuId(jnitcmsmenuVO.getMenuId());
    		menuVO.setSiteId(jnitcmsmenuVO.getSiteId());
    		menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);

    		menuVO.setAdmMbrId(null);
    		jnitcmsmenuService.updateJnitcmsmenu(menuVO);

    		String fileDir = PathUtil.getRealPath(request)
    		+jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());

    		File file = new File(fileDir);
    		if(file.exists()){
    			String propDir = fileDir+"/index.jsp.prop";

    			Properties props = new Properties();
    			InputStreamReader isr = null;
    			FileInputStream fis = null;
    			File propFile = new File(propDir);
    			if(propFile.exists()){
    				try {
    					fis = new FileInputStream(propFile);
						isr = new InputStreamReader(new FileInputStream(propFile),"UTF-8");
						props.load(isr);
    				} catch (IOException e){
    					log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}finally {
						if(isr != null){
							isr.close();
						}
						if(fis != null){
							fis.close();
						}
					}

					props.setProperty("admId", "");
					props.setProperty("admNm", "");
			    	props.setProperty("admTel", "");

			    	props.setProperty("admId2", "");
					props.setProperty("admNm2", "");
			    	props.setProperty("admTel2", "");
			    	FileOutputStream outStream = new FileOutputStream(propFile);
					props.store(outStream, jnitcmsmenuVO.getMenuId()+" (by Jnitcms 3.5)");
					if(outStream != null){
						outStream.close();
					}
    			}
    		}
    	}
    	return "redirect:/cms/sub10/0101.do";
    }

    @RequestMapping("/cms/sub10/duplicationChk.do")
    public String menuNmDuplicationChk(@ModelAttribute("jnitcmsmenuVO") JnitcmsmenuVO jnitcmsmenuVO, Model model) throws Exception{

    	boolean duplication = false;
    	int duplicationCount = 0;		//0이면 중복 없음 or 0 이상이면 중복 존재
    	try{
    		duplicationCount = jnitcmsmenuService.getDuplicationCount(jnitcmsmenuVO);
    	} catch (NullPointerException e){
    		duplicationCount = 1;		//중간에 에러가 발생하면 중복으로 간주하고 컨텐츠 생성 할 수 없음.
    	}catch(Exception e){
    		duplicationCount = 1;		//중간에 에러가 발생하면 중복으로 간주하고 컨텐츠 생성 할 수 없음.
    	}

    	if(duplicationCount > 0){
    		duplication = true;
    	}

    	model.addAttribute("json", duplication);
    	return "/jnit/util/json";
    }

    /**
     * 완성된 menuJSON에서 로그인, 회원템플릿 값을 추가한다.
     * @param siteVO
     * @param childList - menuJSON
     * @return HashMap
     * @throws Exception
     * {@link CmsManageSub10Controller#getJson}
     * {@link CmsManageSub10Controller#getModalJson} //컨텐츠 복사
     */
    @SuppressWarnings("unchecked")
	private HashMap<String, JSONArray> childListHashMap(JnitcmssiteVO siteVO, HashMap<String, JSONArray> childList)throws Exception{
    	JSONArray jsonArray = childList.get("ROOT");
	    JSONObject JSON;
	    HashMap<String, String> tplListMap = new HashMap<String, String>();
	    tplListMap.put("/login.jsp", "로그인");
	    tplListMap.put("/mbr/sign.jsp", "회원양식절차");
	    tplListMap.put("/mbr/signup.jsp", "회원약관동의");
	    tplListMap.put("/mbr/signupAdd.jsp", "회원가입항목입력");
	    tplListMap.put("/mbr/signupSuccess.jsp", "회원가입완료");
	    tplListMap.put("/mbr/myPage.jsp", "마이페이지");
	    tplListMap.put("/mbr/memberCancel.jsp", "회원탈퇴");
	    tplListMap.put("/mbr/idFind.jsp", "아이디찾기");
	    tplListMap.put("/mbr/pwFind.jsp", "패스워드찾기");
	    tplListMap.put("/mbr/noSetpIdFind.jsp", "아이디 찾기"); //비인증
	    tplListMap.put("/mbr/noSetpPwFind.jsp", "패스워드 찾기"); //비인증
	    tplListMap.put("/mbr/noSetpIdResult.jsp", "아이디 찾기 결과"); //비인증
	    tplListMap.put("/mbr/noSetpPwResult.jsp", "패스워드 찾기 결과"); //비인증
	    String sitePath = siteVO.getSitePath();

	    Iterator tplListIterator = tplListMap.keySet().iterator();
	    while(tplListIterator.hasNext()){
	    	JSON = new JSONObject();
	    	String key = (String) tplListIterator.next();
	    	JSON.put("title", tplListMap.get(key));
	    	JSON.put("menupath", "/"+sitePath+key);
	    	JSON.put("defaultmenu", "");
	    	JSON.put("menuislink", 0);
	    	JSON.put("lDel", "N");
	    	JSON.put("pageLinkNav", "<span id='pageLinkNav'><a href='/"+sitePath+"' class='menu-home'><span>Home</span></a> <span class='gt'> &gt; </span> <span class='menu-active'>"+tplListMap.get(key)+"</span></span>");
		    JSON.put("pageNavTitle", tplListMap.get(key)+"&lt; "+siteVO.getSiteNm());
		    JSON.put("menulinkurl", "");
		    JSON.put("menulinktgt", "");
		    JSON.put("menuadmid", "");
		    JSON.put("menudepth", 0);
		    JSON.put("menuid", "");
		    JSON.put("menutplid", "");
		    JSON.put("menumethod", 0);
		    JSON.put("sDel", "");
		    JSON.put("isFolder", "");
		    JSON.put("expand", "");
		    JSON.put("key", "");
		    JSON.put("hDel", "");
		    jsonArray.add(JSON);
	    }
	    childList.put("ROOT", jsonArray);

    	return childList;
    }

    @RequestMapping("/cms/sub10/menuCopy/proc.do")
    public String cmsSub10MenuCopyTest(HttpServletRequest request, ModelMap model)throws Exception{
    	String siteId = CmsHelper.getSessionSiteId(request);
    	String menuId = NullUtil.nullString(request.getParameter("menuId"));
    	int isDepth = NullUtil.nullInt(request.getParameter("isDepth"));
    	String targetMenuId = NullUtil.nullString(request.getParameter("targetMenu"));
    	String targetDepth = NullUtil.nullString(request.getParameter("targetDepth"));
    	String targetNm = NullUtil.nullString(request.getParameter("targetNm"));
    	net.sf.json.JSONObject codeJSON = new net.sf.json.JSONObject();
    	net.sf.json.JSONObject JSON = new net.sf.json.JSONObject();

    	codeJSON = jnitcmsmenuService.makeMenuFileCopy(request, siteId, menuId, targetMenuId, targetNm);
    	if(codeJSON.isEmpty()){
    		int addDepth = 0;
        	try {
        		addDepth = (Integer.parseInt(targetDepth) - isDepth)+1;
        	} catch (NullPointerException e){
        		addDepth = 0;
    		} catch (Exception e) {
    			addDepth = 0;
    		}
        	JSON.put(menuId, targetMenuId);
        	JSON.put("targetNm", targetNm);
        	jnitcmsmenuService.makeMenuCopy(siteId, isDepth, addDepth, JSON);
        	jnitcmsmenuService.menuPremJSON(request, siteId, "menuAll", "0", "true");
        	codeJSON.put("status", "success");
    	}
    	model.addAttribute("json", codeJSON);
    	return "/jnit/util/json";
    }

    @RequestMapping("/work/sub10/workspace.do")
    public String workSub10Workspace(HttpServletRequest request, ModelMap model)throws Exception{
    	String sitePath = NullUtil.nullString(request.getParameter("sitePath"));
    	CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");
    	if(vo == null) vo = new CmsSessionVO();
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
		try {
			siteVO.setSitePath(sitePath);
			siteVO.setSelectCondition("1");
			siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
			vo.setSiteId(siteVO.getSiteId());
			vo.setSiteNm(siteVO.getSiteNm());
	   		vo.setLang(siteVO.getLang());
	   		request.getSession().setAttribute("cmsSessionVO", vo);
		} catch (NullPointerException e){
			model.addAttribute("menuContentError", "FAIL 1");
		} catch (Exception e) {
			model.addAttribute("menuContentError", "FAIL 1");
		}
		/* 2015-09-17 by.나성재 수정 폴더메뉴 담당자 지정 필요할시 주석 제거
    	return "/jnit/cms/disseminate/work/sub10_workspace";
    	*/
    	return null;
    }
}