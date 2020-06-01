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

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.menu.JnitcmsmenuChMethodVO;
import jnit.cms.menu.JnitcmsmenuDefaultVO;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.util.PathUtil;

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
public class CmsManageSub6Controller {

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

    /** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");

    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)

    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    @RequestMapping(value="/cms/sub6/0101.do")
    public String menuIndex(
            HttpServletRequest request,
            Model model)
            throws Exception {
    	AdminUtil.setMenuId("m02020000");
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		model.addAttribute("siteVO", siteVO);

        return "jnit/cms/sub6_1-1";
    }

    @SuppressWarnings("unchecked")
	@RequestMapping(value="/cms/sub6/0101getJson.do")
    public String getJson(
    	@ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO,
    	HttpServletRequest request,
		ModelMap model)
        throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		model.addAttribute("siteVO", siteVO);

		searchVO.setSiteId(siteVO.getSiteId());

	    List<EgovMap> jnitcmsmenuList = jnitcmsmenuService.selectJnitcmsmenuListAll(searchVO);
	    model.addAttribute("resultList", jnitcmsmenuList);

	    //System.out.println("menu==>"+jnitcmsmenuList);

	    if(jnitcmsmenuList.size() > 0) {
		    EgovMap menuVO;
		    //System.out.println(jnitcmsmenuList.size());

		    HashMap<String, JSONArray> childList = new HashMap<String, JSONArray>();

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

		    	JSONObject obj = new JSONObject();
			    obj.put("title", menuVO.get("menuNm"));
			    obj.put("menuid", menuVO.get("menuId"));
			    obj.put("menudepth", menuVO.get("depth"));
			    obj.put("menumethod", menuVO.get("method"));
			    obj.put("menuislink", menuVO.get("islink"));
			    obj.put("menulinkurl", menuVO.get("linkurl"));
			    obj.put("menulinktgt", menuVO.get("linktgt"));
			    obj.put("menutplid", menuVO.get("tplId"));
			    obj.put("menuadmid", menuVO.get("admMbrId"));
			    if(request.getParameter("rebuild") != null) obj.put("menupath", jnitcmsmenuService.makeMenuDirectoryName(getMenuVO, siteVO.getSitePath()) );
			    obj.put("defaultmenu", NullUtil.nullString(""+menuVO.get("defMenu")) );
			    if(request.getParameter("rebuild") != null) obj.put("defaultmenu", jnitcmsmenuService.getDefMenuPath(getMenuVO, menuVO.get("defMenu")) );
			    obj.put("key", menuVO.get("menuId"));
			    obj.put("expand", true);

			    int iscnt = Integer.parseInt(menuVO.get("iscnt").toString());
			    if(iscnt == 0) { //2013-12-20 by.수정 내용 menuVO.get("iscnt").equals(0)
			    	obj.put("isFolder", true);
			    	if(request.getParameter("rebuild") != null) {
				    	if(menuVO.get("isdel").equals(0)) {
				    		String fileDir = PathUtil.getRealPath(request) + "/" + obj.get("menupath");
				    		File fileDirFS = new File(fileDir);
				    		if(fileDirFS.exists() == false) {
				    			fileDirFS.mkdirs();
				    		}

				    		if(menuVO.get("islink").equals(1)) {
				    			CmsHandler.writeFile(fileDir + "/index.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><% response.sendRedirect(\""+obj.get("menulinkurl")+"\"); %>");
				    		}else {
				    			CmsHandler.writeFile(fileDir + "/index.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><% response.sendRedirect(\""+obj.get("defaultmenu")+"\"); %>");
				    		}
				    	}
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
		    }


	    	Set<String> keySet = childList.keySet();
	    	Object[] keys = keySet.toArray();
		    int scanDepth = maxDepth - 1;
		    while(scanDepth > -1) {
		    	//System.out.println("==== Begin scanDepth "+ scanDepth +" ==== ");

		    	for(int i=0; i<keys.length; i++) {
		    		JSONArray cObjs = (JSONArray)childList.get(keys[i]);
		    		for(int i2=0; i2<cObjs.size(); i2++) {
		    			JSONObject cObj = (JSONObject)cObjs.get(i2);
		    			if(Integer.parseInt( cObj.get("menudepth").toString() ) == scanDepth) {
			    			if(childList.get(cObj.get("menuid").toString()) != null) {
			    				//System.out.println(cObj.get("menuid").toString() + " equals key");
			    				cObj.put("children", childList.get(cObj.get("menuid").toString()).clone());
			    				JSONArray cObjs2 = (JSONArray) childList.get(cObj.get("menuid").toString());
			    				cObjs2.clear();
			    			}
		    			}
		    		}
		    		//System.out.println(i + " " +keys[i]);
		    	}
		    	//System.out.println("==== End scanDepth "+ scanDepth +" ==== ");
		    	scanDepth--;
		    }

		    for(int i=0; i<keys.length; i++) {
		    	JSONArray cObjs = (JSONArray)childList.get(keys[i]);
		    	if(cObjs.size() == 0) childList.remove(keys[i]);
		    }

		    //System.out.println("maxdepth => " + maxDepth);
		    //System.out.println("child => " + childList.get("ROOT"));
		    model.addAttribute("resultJson", childList.get("ROOT").toJSONString());

		    String etcDir = PathUtil.getRealPath(request) + "/" + siteVO.getSitePath() + "/_etc";
		    File etcDirF = new File(etcDir);
		    if(etcDirF.exists() == false) {
		    	etcDirF.mkdirs();
		    }

		    if(request.getParameter("rebuild") != null) CmsHandler.writeFile(etcDir+"/menu.json", childList.get("ROOT").toJSONString());
	    }else {
	    	model.addAttribute("resultJson", null);
	    }

	    if(request.getParameter("rebuild") != null) {
	    	model.addAttribute("msg", "OK");
	    	return "jnit/msg";
	    }

        return "jnit/cms/sub6_1-1-json";
    }

    //컨텐츠 복사용 TREE(폴더만 보여줌)
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/cms/sub6/0101getModalJson.do")
    public String getModalJson(
    	@ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO,
    	HttpServletRequest request,
		ModelMap model)
        throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		model.addAttribute("siteVO", siteVO);

		searchVO.setSiteId(siteVO.getSiteId());
		searchVO.setSearchCondition("3");
	    List<EgovMap> jnitcmsmenuList = jnitcmsmenuService.selectJnitcmsmenuListAll(searchVO);
	    model.addAttribute("resultList", jnitcmsmenuList);

	    //System.out.println("menu==>"+jnitcmsmenuList);

	    if(jnitcmsmenuList.size() > 0) {
		    EgovMap menuVO;
		    //System.out.println(jnitcmsmenuList.size());

		    HashMap<String, JSONArray> childList = new HashMap<String, JSONArray>();

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

		    	JSONObject obj = new JSONObject();
			    obj.put("title", menuVO.get("menuNm"));
			    obj.put("menuid", menuVO.get("menuId"));
			    obj.put("menudepth", menuVO.get("depth"));
			    obj.put("menumethod", menuVO.get("method"));
			    obj.put("menuislink", menuVO.get("islink"));
			    obj.put("menulinkurl", menuVO.get("linkurl"));
			    obj.put("menulinktgt", menuVO.get("linktgt"));
			    obj.put("menutplid", menuVO.get("tplId"));
			    obj.put("menuadmid", menuVO.get("admMbrId"));
			    if(request.getParameter("rebuild") != null) obj.put("menupath", jnitcmsmenuService.makeMenuDirectoryName(getMenuVO, siteVO.getSitePath()) );
			    obj.put("defaultmenu", NullUtil.nullString(""+menuVO.get("defMenu")) );
			    if(request.getParameter("rebuild") != null) obj.put("defaultmenu", jnitcmsmenuService.getDefMenuPath(getMenuVO, menuVO.get("defMenu")) );
			    obj.put("key", menuVO.get("menuId"));
			    obj.put("expand", true);
			    //System.out.println( menuVO.get("iscnt").toString() );
			    if(menuVO.get("iscnt").equals(0)) {
			    	obj.put("isFolder", true);

			    	if(request.getParameter("rebuild") != null) {
				    	if(menuVO.get("isdel").equals(false)) {
				    		String fileDir = PathUtil.getRealPath(request) + "/" + obj.get("menupath");
				    		File fileDirFS = new File(fileDir);
				    		if(fileDirFS.exists() == false) {
				    			fileDirFS.mkdirs();
				    		}

				    		if(menuVO.get("islink").equals(true)) {
				    			CmsHandler.writeFile(fileDir + "/index.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><% response.sendRedirect(\""+obj.get("menulinkurl")+"\"); %>");
				    		}else {
				    			CmsHandler.writeFile(fileDir + "/index.jsp", "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%><% response.sendRedirect(\""+obj.get("defaultmenu")+"\"); %>");
				    		}
				    	}
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
		    }


	    	Set<String> keySet = childList.keySet();
	    	Object[] keys = keySet.toArray();
		    int scanDepth = maxDepth - 1;
		    while(scanDepth > -1) {
		    	//System.out.println("==== Begin scanDepth "+ scanDepth +" ==== ");

		    	for(int i=0; i<keys.length; i++) {
		    		JSONArray cObjs = (JSONArray)childList.get(keys[i]);
		    		for(int i2=0; i2<cObjs.size(); i2++) {
		    			JSONObject cObj = (JSONObject)cObjs.get(i2);
		    			if(Integer.parseInt( cObj.get("menudepth").toString() ) == scanDepth) {
			    			if(childList.get(cObj.get("menuid").toString()) != null) {
			    				//System.out.println(cObj.get("menuid").toString() + " equals key");
			    				cObj.put("children", childList.get(cObj.get("menuid").toString()).clone());
			    				JSONArray cObjs2 = (JSONArray) childList.get(cObj.get("menuid").toString());
			    				cObjs2.clear();
			    			}
		    			}
		    		}

		    		//System.out.println(i + " " +keys[i]);
		    	}
		    	//System.out.println("==== End scanDepth "+ scanDepth +" ==== ");
		    	scanDepth--;
		    }

		    for(int i=0; i<keys.length; i++) {
		    	JSONArray cObjs = (JSONArray)childList.get(keys[i]);
		    	if(cObjs.size() == 0) childList.remove(keys[i]);
		    }

		    //System.out.println("maxdepth => " + maxDepth);
		    //System.out.println("child => " + childList.get("ROOT"));
		    model.addAttribute("resultJson", childList.get("ROOT").toJSONString());

		    String etcDir = PathUtil.getRealPath(request) + "/" + siteVO.getSitePath() + "/_etc";
		    File etcDirF = new File(etcDir);
		    if(etcDirF.exists() == false) {
		    	etcDirF.mkdirs();
		    }

		    if(request.getParameter("rebuild") != null) CmsHandler.writeFile(etcDir+"/menu.json", childList.get("ROOT").toJSONString());
	    }else {
	    	model.addAttribute("resultJson", null);
	    }

	    if(request.getParameter("rebuild") != null) {
	    	model.addAttribute("msg", "OK");
	    	return "jnit/msg";
	    }
        return "jnit/cms/sub6_1-1-json";
    }

    @RequestMapping(value="/cms/sub6/0101add.do")
    public String addMenu(
            HttpServletRequest request,
            Model model)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
		menuVO.setSiteId(siteVO.getSiteId());
		menuVO.setPid(request.getParameter("pid"));
		menuVO.setTplId(request.getParameter("tplid"));
		menuVO.setAdmMbrId(request.getParameter("admid"));

		int newDepth = Integer.parseInt(request.getParameter("depth"));
		menuVO.setDepth(newDepth);
		int newMethod = 0;
		if(request.getParameter("pid") == null) {
			newMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(menuVO)+1;
		}else {
			newMethod = Integer.parseInt(request.getParameter("method"))+1;
		}
		if("true".equals(deDug)) System.out.println("newMethod: "+ newMethod);
		menuVO.setMethod(newMethod);

		//System.out.println("nDepth:" + newDepth);
		//System.out.println("nMethod:" + newMethod);
		menuVO.setMenuNm(request.getParameter("menuNm"));
		if(NullUtil.nullString(request.getParameter("iscnt")).toString().equals("1")) {
			menuVO.setIscnt(1);
			menuVO.setCcl("100");
		}

		jnitcmsmenuService.updateJnitcmsmenuMethod(menuVO);

		String menuId = jnitcmsmenuService.insertJnitcmsmenu(menuVO);

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
        return "jnit/cms/sub6_1-1-res";
    }

    @RequestMapping(value="/cms/sub6/0101del.do")
    public String delMenu(
            HttpServletRequest request,
            Model model)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);


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

	    if(!bkrf.exists()) bkrf.mkdirs();

        if(bf.exists() && !bkf.exists()) {
        	//System.out.println("rename");
        	if(!bf.renameTo(bkf)) {
        		//System.out.println("rename fail!");
        		model.addAttribute("backurl", "/cms/sub6/0101editForm.do?menuId=" + vo.getMenuId());
        		model.addAttribute("msg", "경로를 변경할 수 없습니다.");

	        	bFail = true;
        	}
        }else {
        	//System.out.println("rename fail! backup exists or dir not exists");
        	model.addAttribute("backurl", "/cms/sub6/0101editForm.do?menuId=" + vo.getMenuId());
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
			model.addAttribute("resultJson", null);

			return "jnit/cms/sub6_1-1-res";
    	}else {
    		return "jnit/cms/sub6_msg-error";
    	}
    }

    @RequestMapping(value="/cms/sub6/0101edit.do")
    public String editMenu(
            HttpServletRequest request,
            Model model)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

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
        	if("true".equals(deDug)) System.out.println("isDefault");
       		isDefaultPage = true;
        }

		if( menuVO.getIscnt() == 1) {
			Properties props = new Properties();
	        // File.props 로딩
	        String propsFile = PathUtil.getRealPath(request)
			+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) + "/index.jsp.prop";
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

		    	// 페이지 네비 타이틀
				String menuNavTitle = "";
				CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");

				if(isDefaultPage == true) {
					menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(parentVO, vo.getSiteNm(), siteVO.getSitePath());
				}else {
					menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(menuVO, vo.getSiteNm(), siteVO.getSitePath());
				}
		    	props.setProperty("pageNavTitle", menuNavTitle);

				// 페이지 CNT_ID 를 Hash로 제공
				String pageIdHash = "";
				MessageDigest md = MessageDigest.getInstance("SHA-256");
				byte[] bip = md.digest( menuVO.getCntId().getBytes() );
				for(int i=0; i<bip.length; i++) {
					pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
				}
		    	props.setProperty("pageCode", pageIdHash);

		    	// File.props 저장
		        FileOutputStream fos = new FileOutputStream(propsFile);
		        props.store(fos, "(by Jnitcms 3.5)");
		        if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
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

		return "jnit/cms/sub6_1-1-res";
    }

    @RequestMapping(value="/cms/sub6/0101editMethod.do")
    public String editMethod(
            HttpServletRequest request,
            Model model)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		String srcId = request.getParameter("srcId");
		String dstId = request.getParameter("dstId");

		JnitcmsmenuVO searchVO = new JnitcmsmenuVO();
		searchVO.setSiteId(siteVO.getSiteId());

		searchVO.setMenuId(srcId);
		JnitcmsmenuVO srcVO = jnitcmsmenuService.selectJnitcmsmenu(searchVO);
		//System.out.println("src: "+ srcId + " obj: "+ srcVO);

		searchVO.setMenuId(dstId);
		JnitcmsmenuVO dstVO = jnitcmsmenuService.selectJnitcmsmenu(searchVO);
		//System.out.println("dst: "+ dstId + " obj: "+ dstVO);


		int srcMethod = 0;
		try {
			srcMethod = jnitcmsmenuService.selectJnitcmsmenuNextMethod(srcVO);
		} catch (NullPointerException e){
			srcMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(srcVO)+1;
		}catch(Exception e) {
			srcMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(srcVO)+1;
		}
		//System.out.println("sMethod:"+ srcVO.getMethod() + "~" + (srcMethod-1));


		int dstMethod = 0;
		try {
			dstMethod = jnitcmsmenuService.selectJnitcmsmenuNextMethod(dstVO);
		} catch (NullPointerException e){
			dstMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(dstVO)+1;
		}catch(Exception e) {
			dstMethod = jnitcmsmenuService.selectJnitcmsmenuMaxMethod(dstVO)+1;
		}
		//System.out.println("dMethod:"+ dstVO.getMethod() + "~" + (dstMethod-1));


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

		return "jnit/cms/sub6_1-1-res";
    }

    @RequestMapping("/cms/sub6/0101editForm.do")
    public String updateJnitcmsmenuView(
            @RequestParam("menuId") java.lang.String menuId,
            @ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO,
            HttpServletRequest request,
            Model model)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

        JnitcmsmenuVO jnitcmsmenuVO = new JnitcmsmenuVO();
        jnitcmsmenuVO.setSiteId(siteVO.getSiteId());

        if(menuId.equals("")) {
        	jnitcmsmenuVO.setMenuId(request.getParameter("menu"));
        }else {
        	jnitcmsmenuVO.setMenuId(menuId);
        }
        if("true".equals(deDug)){
        	System.out.println(request.getParameter("menu"));
        	System.out.println(request.getParameter("menuId"));
        	System.out.println(jnitcmsmenuVO);
        }

        // 변수명은 CoC 에 따라 jnitcmsmenuVO
        JnitcmsmenuVO vo = selectJnitcmsmenu(jnitcmsmenuVO, searchVO);
        model.addAttribute("jnitcmsmenuVO", vo);
        model.addAttribute("menuPath", jnitcmsmenuService.makeMenuDirectory(vo, siteVO.getSitePath(), request));
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
    	if("true".equals(deDug)) System.out.println("mbr_id :" + vo.getAdmMbrId() + " " + admMbrId.trim().isEmpty());
    	if(admMbrId.trim() != "") {
	    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
	    	mbrVO.setSearchKeyword(vo.getAdmMbrId());
	    	mbrVO.setSearchCondition("0");
	    	mbrVO.setPageYn("N");
	    	List mbrList = jnitcmsmbrService.selectLeftJoinmbrList(mbrVO);

	    	if(mbrList.size() > 0){
	    		Iterator mbrIterator = mbrList.iterator();
	    		String admMbrText = "";
	    		for(int i=0; i<mbrList.size(); i++){
	    			EgovMap mbrEgovMap = (EgovMap) mbrIterator.next();
	    			String orgNm = String.valueOf(mbrEgovMap.get("orgNm"));
	    			String posNm = String.valueOf(mbrEgovMap.get("posNm"));
	    			String rankNm = String.valueOf(mbrEgovMap.get("rankName"));
	    			String mbrNm = String.valueOf(mbrEgovMap.get("mbrNm"));

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
	    		}
	    		model.addAttribute("admMbrText", admMbrText);
	    	}
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

        return "jnit/cms/sub6_1-1-menuform";
    }

    @RequestMapping(value="/cms/sub6/0101editDetail.do")
    public String editJnitcmsmenu(
            @ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO,
    	    @ModelAttribute("jnitcmsmenuVO") JnitcmsmenuVO jnitcmsmenuVO,
    	    BindingResult bindingResult,
    	    HttpServletRequest request,
    	    SessionStatus status,
    	    Model model)
            throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}
		if("true".equals(deDug)) System.out.println("editDetail:" + request);


		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		jnitcmsmenuVO.setSiteId(siteVO.getSiteId());

		JnitcmsmenuVO vo = selectJnitcmsmenu(jnitcmsmenuVO, searchVO);

        Boolean bFail = false;
		if(!vo.getMenuPath().equals(NullUtil.nullString(jnitcmsmenuVO.getMenuPath()))) {
			String beforePath = jnitcmsmenuService.makeMenuDirectoryName(vo, siteVO.getSitePath());
			String afterPath = jnitcmsmenuService.makeMenuDirectoryName(jnitcmsmenuVO, siteVO.getSitePath());
			if("true".equals(deDug)) System.out.println("before:" + beforePath + " after:" + afterPath);

	        String beforeDir = PathUtil.getRealPath(request)+ beforePath;
	        String afterDir = PathUtil.getRealPath(request)+ afterPath;
	        File bf = new File(beforeDir);
	        File af = new File(afterDir);

	        if(!af.exists()) {
	        	if("true".equals(deDug)) System.out.println("rename");
	        	if(!bf.renameTo(af)) {
	        		if("true".equals(deDug))System.out.println("rename fail!");
	        		model.addAttribute("backurl", "/cms/sub6/0101editForm.do?menuId=" + jnitcmsmenuVO.getMenuId());
	        		model.addAttribute("msg", "경로를 변경할 수 없습니다.");

		        	bFail = true;
	        	}
	        }else {
	        	if("true".equals(deDug)) System.out.println("rename fail! exists name");
	        	model.addAttribute("backurl", "/cms/sub6/0101editForm.do?menuId=" + jnitcmsmenuVO.getMenuId());
	        	model.addAttribute("msg", "해당 경로가 이미 존재합니다.");

	        	bFail = true;
	        }
		}

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
		        	if("true".equals(deDug)) System.out.println("isDefault");
		        	if(request.getParameter("isDefaultPage").equals("1")) {
		        		//System.out.println(" : ok");
		        		parentVO.setCntId(jnitcmsmenuVO.getCntId());
		        		jnitcmsmenuService.updateJnitcmsmenu(parentVO);
		        		isDefaultPage = true;
		        	}else {
		        		//System.out.println(" : no");
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

				HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);
				if(list.get("menuImg") != null) {
		    		EgovFormBasedFileVo fvo = list.get("menuImg");

		    	    String url = "/cms/getFile.do?"
		    	    + "path=" + fvo.getServerSubPath()
		    	    + "&file=" + fvo.getPhysicalName()
		    	    + "&orgname=" + fvo.getFileName();

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

				String admNm = NullUtil.nullString(request.getParameter("admNm"));
				String admTel = NullUtil.nullString(request.getParameter("admTel"));

				if(admNm.equals("")){
					JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
					mbrVO.setSearchCondition("0");
					mbrVO.setSearchKeyword(NullUtil.nullString(jnitcmsmenuVO.getAdmMbrId()));
					mbrVO.setPageYn("N");
					List mbrList = jnitcmsmbrService.selectLeftJoinmbrList(mbrVO);

					if(mbrList.size() > 0){
			    		Iterator mbrIterator = mbrList.iterator();
			    		for(int i=0; i<mbrList.size(); i++){
			    			EgovMap mbrEgovMap = (EgovMap) mbrIterator.next();
			    			String orgNm = String.valueOf(mbrEgovMap.get("orgNm"));
			    			String posNm = String.valueOf(mbrEgovMap.get("posNm"));
			    			String rankNm = String.valueOf(mbrEgovMap.get("rankName"));
			    			String mbrNm = String.valueOf(mbrEgovMap.get("mbrNm"));
			    			admTel = String.valueOf(mbrEgovMap.get("tel"));
			    			if(admTel.equals("null")) admTel = "";

			    			if(!orgNm.equals("null") && !posNm.equals("null") && !rankNm.equals("null")){
			    				admNm = orgNm+": "+mbrNm+"("+rankNm+"/"+posNm+")";
			    			}else if(orgNm.equals("null") && !posNm.equals("null") && !rankNm.equals("null")){
			    				admNm = mbrNm+"("+rankNm+"/"+posNm+")";
			    			}else if(orgNm.equals("null") && !posNm.equals("null") && rankNm.equals("null")){
			    				admNm = mbrNm+"("+posNm+")";
			    			}else if(!orgNm.equals("null") && !posNm.equals("null") && rankNm.equals("null")){
			    				admNm = orgNm+": "+mbrNm+"("+posNm+")";
			    			}else if(!orgNm.equals("null") && posNm.equals("null") && !rankNm.equals("null")){
			    				admNm = orgNm+": "+mbrNm+"("+rankNm+")";
			    			}else if(!orgNm.equals("null") && posNm.equals("null") && rankNm.equals("null")){
			    				admNm = orgNm+": "+mbrNm;
			    			}else{
			    				admNm = mbrNm;
			    			}
			    		}
			    	}
				}



				Properties props = new Properties();
		        // File.props 로딩
		        String propsFile = PathUtil.getRealPath(request)
				+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(jnitcmsmenuVO, siteVO.getSitePath()) + "/index.jsp.prop";

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
			    	props.setProperty("menuPath", jnitcmsmenuService.makeMenuDirectoryName(jnitcmsmenuVO, siteVO.getSitePath()));
			    	props.setProperty("admNm", admNm);
			    	props.setProperty("admTel", admTel);

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

			    	// 페이지 네비 타이틀
					String menuNavTitle = "";
					CmsSessionVO sessionvo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");

					if(isDefaultPage == true) {
						menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(parentVO, sessionvo.getSiteNm(), siteVO.getSitePath());
					}else {
						menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(jnitcmsmenuVO, sessionvo.getSiteNm(), siteVO.getSitePath());
					}
			    	props.setProperty("pageNavTitle", menuNavTitle);

					// 페이지 CNT_ID 를 Hash로 제공
					String pageIdHash = "";
					MessageDigest md = MessageDigest.getInstance("SHA-256");
					byte[] bip = md.digest( jnitcmsmenuVO.getCntId().getBytes() );
					for(int i=0; i<bip.length; i++) {
						pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
					}
			    	props.setProperty("pageCode", pageIdHash);

			    	// File.props 저장
			        FileOutputStream fos = new FileOutputStream(propsFile);
			        props.store(fos, jnitcmsmenuVO.getMenuId()+" (by Jnitcms 3.5)");
			        if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}

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
			return "redirect:/cms/sub6/0101editForm.do?success=true&menuId=" + jnitcmsmenuVO.getMenuId();
    	}else {
    		return "jnit/cms/sub6_msg-error";
    	}
    }

    @RequestMapping("/cms/sub6/0101view.do")
    public @ModelAttribute("jnitcmsmenuVO")
    JnitcmsmenuVO selectJnitcmsmenu(
            JnitcmsmenuVO jnitcmsmenuVO,
            @ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO) throws Exception {
        return jnitcmsmenuService.selectJnitcmsmenu(jnitcmsmenuVO);
    }

    @RequestMapping("/cms/sub6/adm/cancel.do")
    public String admCancel(@ModelAttribute("searchVO") JnitcmsmenuDefaultVO searchVO
    		, @ModelAttribute("jnitcmsmenuVO") JnitcmsmenuVO jnitcmsmenuVO
    		, HttpServletRequest request
    		, ModelMap model)throws Exception{

    	if(!NullUtil.nullString(jnitcmsmenuVO.getAdmMbrId()).equals("")){
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
						isr = new InputStreamReader(fis,"UTF-8");
						props.load(isr);
    				} catch (NullPointerException e){
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
					props.setProperty("admNm", "");
			    	props.setProperty("admTel", "");

					FileOutputStream fos = new FileOutputStream(propFile);
					props.store(fos, jnitcmsmenuVO.getMenuId()+" (by Jnitcms 3.5)");
					if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
    			}
    		}
    	}
    	return "redirect:/cms/sub6/0101editForm.do?success=true&menuId=" + jnitcmsmenuVO.getMenuId();
    }
}
