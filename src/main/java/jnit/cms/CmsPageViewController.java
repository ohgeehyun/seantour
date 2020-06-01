/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.allim.item.JnitallimItemService;
import jnit.cms.handler.CmsHandler;
import jnit.cms.menu.MenuReplacementCode;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.com.util.FileCopy;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONArray;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tika.Tika;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.com.utl.fcc.service.FileUtil;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;

//템플릿관리 > 메인템플릿

@Controller
@SessionAttributes(types=JnitcmstplVO.class)
public class CmsPageViewController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    @Resource(name = "jnitallimItemService")
    private JnitallimItemService jnitallimItemService;

    private final static String SEPARATOR = File.separator;

    private final String[] taglib = {"<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>",
    				   "<%@ taglib prefix=\"c\" uri=\"http://java.sun.com/jsp/jstl/core\" %>",
    	    		   "<%@ taglib prefix=\"ui\" uri=\"http://egovframework.gov/ctl/ui\"%>",
    	    		   "<%@ taglib prefix=\"fn\" uri=\"http://java.sun.com/jsp/jstl/functions\" %>",
    	    		   "<%@ taglib prefix=\"form\" uri=\"http://www.springframework.org/tags/form\" %>",
    	    		   "<%@ taglib prefix=\"fmt\" uri=\"http://java.sun.com/jsp/jstl/fmt\"%>",
    	    		   "<%@ taglib prefix=\"spring\" uri=\"http://www.springframework.org/tags\"%>",
    	    		   "<%@ taglib prefix=\"validator\" uri=\"http://www.springmodules.org/tags/commons-validator\" %>",
    	    		   "<%@ page import=\"java.util.Date\" %>",
    	    		   "<%@page import=\"org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include\"%>"

    };
    private final String[] taglibCms = {"<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>",
    		"<%@ taglib prefix=\"validator\" uri=\"http://www.springmodules.org/tags/commons-validator\" %>",
    		"<%@ include file=\"/_common/header.jsp\" %>"
     };


    /**
     * CMS > 템플릿관리 > 콘텐츠영역 템플릿 > 콘텐츠영역 바로가기
     **/
    @RequestMapping(value="/cms/page/templateShortCut.do")
    public String templateShortCut(HttpServletRequest request, ModelMap model){
    	
    	AdminUtil.setMenuId("m04020100");
    	
    	return "jnit/cms/page/templateShortCut";
    }

    @RequestMapping(value="/cms/page/view.do")
    public String fileView(
             HttpServletRequest request,
             ModelMap model)
             throws Exception {

    	String bindType = NullUtil.nullString(request.getParameter("bindType"));
    	//JSON
    	model.addAllAttributes(AdminJson(request, model));

    	if(isNoSitebln(bindType)){
    		if(CmsHelper.getSessionSiteId(request).equals("")){
    			return "jnit/cms/sub4_msg-nosite";
    		}
    	}
    	JnitcmssiteVO getSiteVO = AdminUtil.getSiteVO(request);

    	String docRoot = request.getSession().getServletContext().getRealPath("");
    	String realPath = PathUtil.getRealPath(request);



    	String filePath = "";
    	String webinfDir = docRoot+"/WEB-INF/jsp/jnit";
    	FileInputStream fis = null;

    	if(bindType.equals("bannerRolling")) {

    		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
    		skinNm  = ("".equals(skinNm) ? bindType : skinNm);
    		filePath = webinfDir+"/allim/skin/banner/"+skinNm+"_code.jsp";

    		model.addAllAttributes(allimSkinModelMap(request, model, webinfDir, "banner", skinNm, filePath, null));
    		model.addAttribute("codeMode",bindType);

    	}else if(bindType.equals("bannerMore")) {

    		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
    		skinNm  = ("".equals(skinNm) ? bindType : skinNm);
    		filePath = webinfDir+"/allim/skin/banner/"+skinNm+"_code.jsp";

    		model.addAllAttributes(allimSkinModelMap(request, model, webinfDir, "banner", skinNm, filePath, "1"));
    		model.addAttribute("codeMode",bindType);

    	}else if(bindType.equals("allimView")) {

    		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
    		skinNm  = ("".equals(skinNm) ? bindType : skinNm);
    		filePath = webinfDir+"/allim/skin/allim/"+skinNm+"_code.jsp";

    		model.addAllAttributes(allimSkinModelMap(request, model, webinfDir, "allim", skinNm, filePath, null));
    		model.addAttribute("codeMode",bindType);

    	}else if(bindType.equals("PopupView")) {

    		String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
    		skinNm  = ("".equals(skinNm) ? bindType : skinNm);
    		filePath = webinfDir+"/allim/skin/popup/"+skinNm+"_code.jsp";

    		model.addAllAttributes(allimSkinModelMap(request, model, webinfDir, "popup", skinNm, filePath, null));
    		model.addAttribute("codeMode",bindType);

    	}else if(bindType.equals("rechProgress")) {

    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_listProgress_code.jsp";
    		model.addAllAttributes(researchMap(model,filePath, getSiteVO.getSitePath()));
    		model.addAttribute("codeMode","listProgress");

    	}else if(bindType.equals("rechEnd")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_listEnd_code.jsp";
    		model.addAllAttributes(researchMap(model,filePath, getSiteVO.getSitePath()));
    		model.addAttribute("codeMode","listEnd");

    	}else if(bindType.equals("rechRegister")) {

    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_respondentRegister_code.jsp";
    		model.addAllAttributes(researchMap(model,filePath, getSiteVO.getSitePath()));
    		model.addAttribute("codeMode","respondentRegister");

    	}else if(bindType.equals("rechstats")) {

    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_statsUserView_code.jsp";
    		model.addAllAttributes(researchMap(model,filePath, getSiteVO.getSitePath()));
    		model.addAttribute("codeMode","statsUserView");

    	}else if(bindType.equals("rechImport")) {

    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_researchImport_code.jsp";
    		model.addAllAttributes(researchMap(model,filePath, getSiteVO.getSitePath()));
    		model.addAttribute("codeMode","researchImport");

    	}else if(bindType.equals("answerPopup")) {

    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_answerPopup_code.jsp";
    		model.addAllAttributes(researchMap(model,filePath, getSiteVO.getSitePath()));
    		model.addAttribute("codeMode","answerPopup");

    	}else if(bindType.equals("leftMenu")) {

    		if(CmsHelper.getSessionSiteId(request).equals("")){
    			return "jnit/cms/sub4_msg-nosite";
    		}
    		String siteId = CmsHelper.getSessionSiteId(request);
    		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
    		jnitcmssiteVO.setSiteId(siteId);
    		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

    		String mkFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sitemenu";
    		File FileDir = new File(mkFileDir);
    		if(!FileDir.exists()){
    			FileDir.mkdirs();
    		}

    		filePath = docRoot + "/WEB-INF/jsp/jnit/cms/menu/sitemenu/"+NullUtil.nullString(siteVO.getSitePath())+"_sub_code.jsp";
    		try {
				fis = new FileInputStream(new File(filePath));
    		} catch (IOException e){
    			String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub_code.jsp";
				String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

				String mkSubCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_sub_code.jsp";
				CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
			} catch (Exception e) {
				String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub_code.jsp";
				String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

				String mkSubCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_sub_code.jsp";
				CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
			} finally {
				if(fis != null){
					fis.close();
				}
			}
    		model.addAttribute("codeMode","sub_code");
    	}else if(bindType.equals("topMenu")){

    		HashMap resultMap = new HashMap();

    		String defaultPath = realPath + "WEB-INF/jsp/jnit/cms/menu";
    		String topmenuDir = defaultPath+"/topmenu";
			File topmenu = new File(topmenuDir);
			FilenameFilter filenameFilter = new FilenameFilter() {
				public boolean accept(File dir, String name) {
					if(!".svn".equals(name)){
						return true;
					}else{
						return false;
					}
				}
			};
			String[] targetLists = topmenu.list(filenameFilter);
			if(targetLists == null) targetLists = new String[0];

    		String target = NullUtil.nullString(request.getParameter("target"));
    		String depth = NullUtil.nullString(request.getParameter("depth"));

    		target = "".equals(target) ? (targetLists.length == 0 ? "sample": targetLists[0])  : target ;
			depth = "".equals(depth) ? "1" : depth;

    		String baseUrl = realPath + "WEB-INF/jsp/jnit/cms/menu/topmenu/";
    		String targetPath = baseUrl;
    	    String depthPath = baseUrl + SEPARATOR + target;

    	    //지정된 샘플파일 생성
    	    FileCopy.makeTopMenuSampleFile(defaultPath, target, depth);

    	    List<String> targetList = FileCopy.getDirectoryNm(targetPath);
    	    List<String> depthList = FileCopy.getDirectoryNm(depthPath);

    	    filePath = baseUrl + target + SEPARATOR + depth + SEPARATOR +target+"_topMenu_code.jsp";

    	    resultMap.put("target", target);
    	    resultMap.put("depth", depth);
    	    resultMap.put("targetList", targetList);
    	    resultMap.put("depthList", depthList);

    	    model.addAttribute("result", resultMap);
    	    model.addAttribute("codeMode","top_code");
    	}else if(bindType.equals("contentAdmin")) {
    		if(CmsHelper.getSessionSiteId(request).equals("")){
    			return "jnit/cms/sub4_msg-nosite";
    		}
			String siteId = CmsHelper.getSessionSiteId(request);
    		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
    		jnitcmssiteVO.setSiteId(siteId);
    		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

    		filePath = realPath + "cms/import/"+NullUtil.nullString(siteVO.getSitePath())+"_content_admin_code.jsp";

    		try {
				fis = new FileInputStream(new File(filePath));
    		} catch (IOException e){
    			String setSubCodeDir = realPath +"cms/import/content_admin_code.jsp";
				String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

				String mkSubCodeDir = realPath + "cms/import/"+NullUtil.nullString(siteVO.getSitePath())+"_content_admin_code.jsp";
				CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
			} catch (Exception e) {
				String setSubCodeDir = realPath +"cms/import/content_admin_code.jsp";
				String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

				String mkSubCodeDir = realPath + "cms/import/"+NullUtil.nullString(siteVO.getSitePath())+"_content_admin_code.jsp";
				CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
			} finally {
				if(fis != null){
					fis.close();
				}
			}

    		filePath = realPath +"cms/import/"+NullUtil.nullString(siteVO.getSitePath())+"_content_admin_code.jsp";
    		model.addAttribute("codeMode","contentAdmin");

    	}else if(bindType.equals("updateButton")) {
    		if(CmsHelper.getSessionSiteId(request).equals("")){
    			return "jnit/cms/sub4_msg-nosite";
    		}
    		String siteId = CmsHelper.getSessionSiteId(request);
    		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
    		jnitcmssiteVO.setSiteId(siteId);
    		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

    		filePath = realPath + "cms/import/"+NullUtil.nullString(siteVO.getSitePath())+"_updateButton_code.jsp";

    		try {
				fis = new FileInputStream(new File(filePath));
    		} catch (IOException e){
    			String setSubCodeDir = PathUtil.getRealPath(request)+"/cms/import/updateButton_code.jsp";
				String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

				String mkSubCodeDir = realPath + "cms/import/"+NullUtil.nullString(siteVO.getSitePath())+"_updateButton_code.jsp";
				CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
			} catch (Exception e) {

				String setSubCodeDir = PathUtil.getRealPath(request)+"/cms/import/updateButton_code.jsp";
				String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

				String mkSubCodeDir = realPath + "cms/import/"+NullUtil.nullString(siteVO.getSitePath())+"_updateButton_code.jsp";
				CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
			} finally {
				if(fis != null){
					fis.close();
				}

			}

    		filePath = realPath +"cms/import/"+NullUtil.nullString(siteVO.getSitePath())+"_updateButton_code.jsp";
    		model.addAttribute("codeMode","updateButton");

    	}else if(bindType.equals("sitemap")){
    		filePath = webinfDir + "/cms/menu/sitemap/"+getSiteVO.getSitePath()+"_sitemap_code.jsp";
    		String sitemapCodeSrc = CmsHandler.readFile(webinfDir+"/cms/menu/sitemap_code.jsp");
    		FileCopy.isFileExists(filePath, sitemapCodeSrc); //FILE 체크
    		model.addAttribute("codeMode", bindType);
    	}

    	final HashMap<String, Object> onceFile = new HashMap<String, Object>();
    	final File f = new File(filePath);

		String mimeType = null;
		String mimeHeader = null;
    	String viewPath = null;

    	if(f.exists()) {
    		onceFile.put("date", new Date(f.lastModified()));
    		onceFile.put("size", f.length() / 1000);

    		try {
    		    Tika tika = new Tika();
    		    mimeType = tika.detect(f);
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
    		} catch (Exception e) {
    		    log.error("오류: tika");
    		}
    		onceFile.put("mime", mimeType);


        	String[] mimeSplit = mimeType.split("/");
        	mimeHeader = mimeSplit[0];
    	}else {
    		mimeHeader = "unknown";
    	}

    	model.addAttribute("file", onceFile);
    	String fileString = FileUtil.getFileContent(f);
    	/*바인드타입에 따른 taglib 구분*/
    	if(bindType.equals("contentAdmin")){
    		for(int i=0; i<taglibCms.length; i++) {
            	fileString = fileString.replaceAll(taglibCms[i], "");

            }
    	}else if(bindType.equals("updateButton")){
    		for(int i=0; i<taglibCms.length; i++) {
            	fileString = fileString.replaceAll(taglibCms[i], "");

            }
    	}else if(bindType.equals("rechImport")){
    		for(int i=0; i<taglibCms.length; i++) {
            	fileString = fileString.replaceAll(taglibCms[i], "");

            }
    	}else{
    		for(int i=0; i<taglib.length; i++) {
            	fileString = fileString.replaceAll(taglib[i], "");

            }
    	}


    	//viewPath = "/jnit/cms/file/textview";
    		JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();

    		jnitcmstplVO.setTplSrc(fileString);

    		model.addAttribute("bindType",bindType);
    		model.addAttribute("jnitcmstplVO", jnitcmstplVO);
    		//@ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,

    	return "/jnit/cms/page/textview";
    }

    @RequestMapping(value="/cms/page/save.do")
    public String fileSave(
    		 @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {

    	String docRoot = request.getSession().getServletContext().getRealPath("");
    	String contextPath = request.getContextPath();

    	JnitcmssiteVO getSiteVO = AdminUtil.getSiteVO(request);

    	String filePath = "";
    	String codefilePath = "";
    	String webinfDir = docRoot + "/WEB-INF/jsp/jnit";
    	FileInputStream fis = null;
    	String bindType = NullUtil.nullString(request.getParameter("bindType"));
    	String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
    	skinNm  = ("".equals(skinNm) ? bindType : skinNm);

    	if(bindType.equals("bannerRolling")) {

    		filePath = webinfDir+"/allim/skin/banner/"+ skinNm +".jsp";
    		codefilePath = webinfDir+"/allim/skin/banner/"+ skinNm +"_code.jsp";
    		String allimDefaultSrc = CmsHandler.readFile(webinfDir + "/allim/default/banner/"+ skinNm +"_code.jsp");

    		FileCopy.isFileExists(codefilePath, allimDefaultSrc); //FILE 체크

    	}else if(bindType.equals("bannerMore")) {

    		filePath = webinfDir+"/allim/skin/banner/"+ skinNm +".jsp";
    		codefilePath = webinfDir+"/allim/skin/banner/"+ skinNm +"_code.jsp";
    		String allimDefaultSrc = CmsHandler.readFile(webinfDir + "/allim/default/banner/"+ skinNm +"_code.jsp");

    		FileCopy.isFileExists(codefilePath, allimDefaultSrc); //FILE 체크

    	}else if(bindType.equals("allimView")) {

    		filePath = webinfDir+"/allim/skin/allim/"+ skinNm +".jsp";
    		codefilePath = webinfDir+"/allim/skin/allim/"+ skinNm +"_code.jsp";
    		String allimDefaultSrc = CmsHandler.readFile(webinfDir + "/allim/default/allim/"+ skinNm +"_code.jsp");

    		FileCopy.isFileExists(codefilePath, allimDefaultSrc); //FILE 체크

    	}else if(bindType.equals("PopupView")) {

    		filePath = webinfDir+"/allim/skin/popup/"+ skinNm +".jsp";
    		codefilePath = webinfDir+"/allim/skin/popup/"+ skinNm +"_code.jsp";
    		String allimDefaultSrc = CmsHandler.readFile(webinfDir + "/allim/default/popup/"+ skinNm +"_code.jsp");

    		FileCopy.isFileExists(codefilePath, allimDefaultSrc); //FILE 체크

    	}else if(bindType.equals("rechProgress")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_listProgress.jsp";
    		codefilePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_listProgress_code.jsp";
    	}else if(bindType.equals("rechEnd")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_listEnd.jsp";
    		codefilePath = docRoot+"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_listEnd_code.jsp";
    	}else if(bindType.equals("rechRegister")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_respondentRegister.jsp";
    		codefilePath = docRoot+"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_respondentRegister_code.jsp";
    	}else if(bindType.equals("rechstats")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_statsUserView.jsp";
    		codefilePath = docRoot+"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_statsUserView_code.jsp";
    	}else if(bindType.equals("rechImport")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_researchImport.jsp";
    		codefilePath = docRoot+"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_researchImport_code.jsp";
    	}else if(bindType.equals("answerPopup")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_answerPopup.jsp";
    		codefilePath = docRoot+"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_answerPopup_code.jsp";
    	}else if(bindType.equals("leftMenu")) {
    		if(CmsHelper.getSessionSiteId(request).equals("")){
    			return "jnit/cms/sub4_msg-nosite";
    		}

    		String siteId = CmsHelper.getSessionSiteId(request);

    		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
    		jnitcmssiteVO.setSiteId(siteId);
    		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

    		String mkFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sitemenu";
    		File FileDir = new File(mkFileDir);
    		if(!FileDir.exists()){
    			FileDir.mkdirs();
    		}

    		filePath = docRoot + "/WEB-INF/jsp/jnit/cms/menu/sitemenu/"+NullUtil.nullString(siteVO.getSitePath())+"_sub.jsp";

    		try {
				fis = new FileInputStream(new File(filePath));
    		} catch (IOException e){
    			String setSubDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub.jsp";
				String setSubSrc = CmsHandler.readFile(setSubDir);

				String mkSubDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_sub.jsp";
				CmsHandler.writeFile(mkSubDir, setSubSrc);
			} catch (Exception e) {

				String setSubDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub.jsp";
				String setSubSrc = CmsHandler.readFile(setSubDir);

				String mkSubDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_sub.jsp";
				CmsHandler.writeFile(mkSubDir, setSubSrc);
			} finally {
				if(fis != null){
					fis.close();
				}
			}

			codefilePath = docRoot + "/WEB-INF/jsp/jnit/cms/menu/sitemenu/"+NullUtil.nullString(siteVO.getSitePath())+"_sub_code.jsp";

    		try {
				fis = new FileInputStream(new File(codefilePath));
    		} catch (IOException e){
    			String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub_code.jsp";
				String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

				String mkSubCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_sub_code.jsp";
				CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
			} catch (Exception e) {

				String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sub_code.jsp";
				String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

				String mkSubCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_sub_code.jsp";
				CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
			} finally {
				if(fis != null){
					fis.close();
				}
			}
    	}else if(bindType.equals("topMenu")){

    		HashMap resultMap = new HashMap();

    		List<String> targetList = new ArrayList<String>();
    	    List<String> depthList = new ArrayList<String>();

    		String target = NullUtil.nullString(request.getParameter("target"));
    		String depth = NullUtil.nullString(request.getParameter("depth"));

    		String defaultPath = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/";
    	    filePath = defaultPath + "topmenu" + SEPARATOR + target + SEPARATOR + depth + SEPARATOR + target + "_topMenu.jsp";
    	    codefilePath = defaultPath + "topmenu" + SEPARATOR + target + SEPARATOR + depth + SEPARATOR + target + "_topMenu_code.jsp";

    	    String realPath = PathUtil.getRealPath(request);
    	    String baseUrl = realPath + "WEB-INF/jsp/jnit/cms/menu/topmenu/";
    	    String targetPath = baseUrl;
    	    String depthPath = baseUrl + SEPARATOR + target;

    	    targetList = FileCopy.getFileNm(targetPath);
    		depthList = FileCopy.getFileNm(depthPath);

    		resultMap.put("target", target);
    	    resultMap.put("depth", depth);
    	    resultMap.put("targetList", targetList);
    	    resultMap.put("depthList", depthList);

    	    model.addAttribute("result", resultMap);

    	}else if(bindType.equals("contentAdmin")) {
    		filePath = docRoot +"/cms/import/"+getSiteVO.getSitePath()+"_content_admin.jsp";
    		codefilePath = docRoot + "/cms/import/"+getSiteVO.getSitePath()+"_content_admin_code.jsp";
    	}else if(bindType.equals("updateButton")) {
    		filePath = docRoot +"/cms/import/"+getSiteVO.getSitePath()+"_updateButton.jsp";
    		codefilePath = docRoot + "/cms/import/"+getSiteVO.getSitePath()+"_updateButton_code.jsp";
    	}else if(bindType.equals("sitemap")){
    		filePath = webinfDir + "/cms/menu/sitemap/"+getSiteVO.getSitePath()+"_sitemap.jsp";
    		String sitemapCodeSrc = CmsHandler.readFile(webinfDir+"/cms/menu/sitemap_code.jsp");
    		FileCopy.isFileExists(filePath, sitemapCodeSrc); //FILE 체크
    		codefilePath = webinfDir+"/cms/menu/sitemap/"+getSiteVO.getSitePath()+"_sitemap_code.jsp";
    	}

        String[] FILTER_WORDS = {/* "<%", "%>","<c:","${" */};

        // 필터링 문자의 갯수만큼 반복을 하여 요청 매개변수의 값에 문자가 포함되어 있는지 확인한다.
        for(int i=0; i<FILTER_WORDS.length; i++) {
            if(NullUtil.nullString(jnitcmstplVO.getTplSrc()).indexOf(FILTER_WORDS[i]) != -1) {
                // 필터링 문자가 발견 되었을시 처리.
            	String msg = "<script type='text/javascript' src='../../resources/js/jquery.min.js'></script><script type='text/javascript'>alert('<% %>,c 태그,${} 는 사용하실 수 없습니다.'); $(document).ready(function(){parent.location.href='"+contextPath+"/cms/page/view.do?bindType="+bindType+"';}); </script>";
            	model.addAttribute("msg",msg);

            	return "jnit/msg";
            }
        }

        String fileString = NullUtil.nullString(jnitcmstplVO.getTplSrc());

        if(bindType.equals("contentAdmin")){
        	for(int i=0; i<taglibCms.length; i++) {
            	fileString = taglibCms[i] + fileString;
            }
    	}else if(bindType.equals("updateButton")){
    		for(int i=0; i<taglibCms.length; i++) {
            	fileString = taglibCms[i] + fileString;
            }
    	}else if(bindType.equals("rechImport")){
    		for(int i=0; i<taglibCms.length; i++) {
            	fileString = taglibCms[i] + fileString;
            }
    	}else{
    		for(int i=0; i<taglib.length; i++) {
            	fileString = taglib[i] + fileString;
            }
    	}


    	CmsHandler.writeFile(codefilePath, fileString);

    	HashMap<String, String> changeCode = new HashMap<String, String>();

    	if(bindType.equals("topMenu")){
    		changeCode = MenuReplacementCode.TopMenuReplacementCode();
    		bindType = bindType + "&depth="+NullUtil.nullString(request.getParameter("depth"))+"&target="+NullUtil.nullString(request.getParameter("target"));
    	}else{
    		changeCode = changeCode();
    	}

    	Iterator fileItr = changeCode.keySet().iterator();
		while(fileItr.hasNext()){
			String key = (String)fileItr.next();
			fileString = fileString.replace(key,changeCode.get(key));
		}
		//치환된 데이터를 원본 파일에 저장
		CmsHandler.writeFile(filePath, fileString);
		model.addAttribute("alert", "저장하였습니다.");

    	if(model.get("path") != null) return "/jnit/util/alertMove";

    	//2014-06-12 by.나성재수정 return alertMove 로 수정
    	//model.addAttribute("msg", "<script src='<c:url value='/resources/js/jquery.min.js'/>'></script><script type='text/javascript'> $(document).ready(function(){ $(top.document).find('#ifmList').attr('src', $(top.document).find('#ifmList').attr('src')); $(top.document).find('#ifmContent').attr('src', '"+contextPath+"/cms/file/view.do?bindType="+bindType+"&dirType="+dirType+"&fileName="+fileNm+"'); }); </script>");
    	//String msg = "<script type='text/javascript' src='../../resources/js/jquery.min.js'></script><script type='text/javascript'> $(document).ready(function(){parent.location.href='"+contextPath+"/cms/page/view.do?bindType="+bindType+"';}); </script>";
    	//model.addAttribute("msg",msg);

    	model.addAttribute("path", "/cms/page/view.do?bindType="+bindType);
    	return "/jnit/util/alertMove"; //return "jnit/msg";
    }

    @RequestMapping(value="/cms/page/delete.do")
    public String fileDelete(
    		 @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {

    	String docRoot = request.getSession().getServletContext().getRealPath("");
    	String contextPath = request.getContextPath();

    	JnitcmssiteVO getSiteVO = AdminUtil.getSiteVO(request);

    	String filePath = "";
    	String codefilePath = "";
    	String DefaultfilePath = "";
    	String DefaultcodefilePath = "";
    	String webinfDir = docRoot + "/WEB-INF/jsp/jnit";
    	FileInputStream fis = null;
    	String bindType = NullUtil.nullString(request.getParameter("bindType"));
    	String skinNm = NullUtil.nullString(request.getParameter("skinNm"));
    	skinNm  = ("".equals(skinNm) ? bindType : skinNm);

    	if(bindType.equals("bannerRolling")) {

    		filePath = webinfDir+"/allim/skin/banner/"+ skinNm +".jsp";
    		codefilePath = webinfDir+"/allim/skin/banner/"+ skinNm +"_code.jsp";
    		DefaultfilePath = webinfDir+"/allim/default/banner/"+ skinNm +".jsp";
    		DefaultcodefilePath = webinfDir+"/allim/default/banner/"+ skinNm +"_code.jsp";
    		String allimDefaultSrc = CmsHandler.readFile(webinfDir + "/allim/default/banner/"+ skinNm +"_code.jsp");

    		FileCopy.isFileExists(codefilePath, allimDefaultSrc); //FILE 체크

    	}else if(bindType.equals("bannerMore")) {

    		filePath = webinfDir+"/allim/skin/banner/"+ skinNm +".jsp";
    		codefilePath = webinfDir+"/allim/skin/banner/"+ skinNm +"_code.jsp";
    		DefaultfilePath = webinfDir+"/allim/default/banner/"+ skinNm +".jsp";
    		DefaultcodefilePath = webinfDir+"/allim/default/banner/"+ skinNm +"_code.jsp";
    		String allimDefaultSrc = CmsHandler.readFile(webinfDir + "/allim/default/banner/"+ skinNm +"_code.jsp");

    		FileCopy.isFileExists(codefilePath, allimDefaultSrc); //FILE 체크

    	}else if(bindType.equals("allimView")) {

    		filePath = webinfDir+"/allim/skin/allim/"+ skinNm +".jsp";
    		codefilePath = webinfDir+"/allim/skin/allim/"+ skinNm +"_code.jsp";
    		DefaultfilePath = webinfDir+"/allim/default/allim/"+ skinNm +".jsp";
    		DefaultcodefilePath = webinfDir+"/allim/default/allim/"+ skinNm +"_code.jsp";
    		String allimDefaultSrc = CmsHandler.readFile(webinfDir + "/allim/default/allim/"+ skinNm +"_code.jsp");

    		FileCopy.isFileExists(codefilePath, allimDefaultSrc); //FILE 체크

    	}else if(bindType.equals("PopupView")) {

    		filePath = webinfDir+"/allim/skin/popup/"+ skinNm +".jsp";
    		codefilePath = webinfDir+"/allim/skin/popup/"+ skinNm +"_code.jsp";
    		DefaultfilePath = webinfDir+"/allim/default/popup/"+ skinNm +".jsp";
    		DefaultcodefilePath = webinfDir+"/allim/default/popup/"+ skinNm +"_code.jsp";
    		String allimDefaultSrc = CmsHandler.readFile(webinfDir + "/allim/default/popup/"+ skinNm +"_code.jsp");

    		FileCopy.isFileExists(codefilePath, allimDefaultSrc); //FILE 체크

    	}else if(bindType.equals("sitemap")){
    		filePath = webinfDir + "/cms/menu/sitemap/"+getSiteVO.getSitePath()+"_sitemap.jsp";
    		String sitemapCodeSrc = CmsHandler.readFile(webinfDir+"/cms/menu/sitemap_code.jsp");
    		FileCopy.isFileExists(filePath, sitemapCodeSrc); //FILE 체크
    		codefilePath = webinfDir+"/cms/menu/sitemap/"+getSiteVO.getSitePath()+"_sitemap_code.jsp";
    	}

        String fileString = NullUtil.nullString(jnitcmstplVO.getTplSrc());


    		for(int i=0; i<taglib.length; i++) {
            	fileString = taglib[i] + fileString;
            }

        //데이터 원본 파일 삭제
        File codefile = new File(codefilePath);

        if(codefile.exists()){
        	codefile.delete();
        	JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, codefile);		//Filego 배포
        }

        File Defaultcodefile = new File(DefaultcodefilePath);

        if(Defaultcodefile.exists()){
        	Defaultcodefile.delete();
        	JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, Defaultcodefile);		//Filego 배포
        }
        //치환된 데이터 원본 파일 삭제
  		File sourcefile = new File(filePath);

  		if(sourcefile.exists()){
  			sourcefile.delete();
  			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, sourcefile);		//Filego 배포
  		}

  		File Defaultsourcefile = new File(DefaultfilePath);

  		if(Defaultsourcefile.exists()){
  			Defaultsourcefile.delete();
  			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, Defaultsourcefile);		//Filego 배포
  		}


        if(bindType.equals("topMenu")){

    		HashMap resultMap = new HashMap();

    		List<String> targetList = new ArrayList<String>();
    	    List<String> depthList = new ArrayList<String>();

    		String target = NullUtil.nullString(request.getParameter("target"));
    		String depth = NullUtil.nullString(request.getParameter("depth"));

    		String defaultPath = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/";
    	    filePath = defaultPath + "topmenu" + SEPARATOR + target + SEPARATOR + depth + SEPARATOR + target + "_topMenu.jsp";
    	    codefilePath = defaultPath + "topmenu" + SEPARATOR + target + SEPARATOR + depth + SEPARATOR + target + "_topMenu_code.jsp";

    	    String realPath = PathUtil.getRealPath(request);
    	    String baseUrl = realPath + "WEB-INF/jsp/jnit/cms/menu/topmenu/";
    	    String targetPath = baseUrl;
    	    String depthPath = baseUrl + SEPARATOR + target;
    	  //데이터 원본 파일 삭제
            codefile = new File(codefilePath);

            if(codefile.exists()){
            	codefile.delete();
            	JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, codefile);		//Filego 배포
            }

            Defaultcodefile = new File(DefaultcodefilePath);

            if(Defaultcodefile.exists()){
            	Defaultcodefile.delete();
            	JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, Defaultcodefile);		//Filego 배포
            }
            //치환된 데이터 원본 파일 삭제
      		sourcefile = new File(filePath);

      		if(sourcefile.exists()){
      			sourcefile.delete();
      			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, sourcefile);		//Filego 배포
      		}

      		Defaultsourcefile = new File(DefaultfilePath);

      		if(Defaultsourcefile.exists()){
      			Defaultsourcefile.delete();
      			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, Defaultsourcefile);		//Filego 배포
      		}
    	  //삭제된 파일의 directory 삭제
      		String depthfolder = depthPath + SEPARATOR + depth;
      		File depthdirectory = new File(depthfolder);

      		File[] inDepthFile = depthdirectory.listFiles();
      		if(inDepthFile == null) inDepthFile = new File[0];
      		if(!(inDepthFile.length > 0)){
      			depthdirectory.delete();
      			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, depthdirectory);		//Filego 배포
      		}

      		String targetfolder = targetPath + SEPARATOR + target;
      		File targetdirectory = new File(targetfolder);

      		File[] intargetFile = targetdirectory.listFiles();
      		if(intargetFile == null) intargetFile = new File[0];
      		if(!(intargetFile.length > 0)){
      			targetdirectory.delete();
      			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, targetdirectory);		//Filego 배포
      		}

    	    targetList = FileCopy.getFileNm(targetPath);
    		depthList = FileCopy.getFileNm(depthPath);

    		resultMap.put("target", target);
    	    resultMap.put("depth", depth);
    	    resultMap.put("targetList", targetList);
    	    resultMap.put("depthList", depthList);

    	    model.addAttribute("result", resultMap);

    	}

		model.addAttribute("alert", "삭제하였습니다.");


		String addMsg = "";

    	if(model.get("path") != null) return "/jnit/util/alertMove";

    	model.addAttribute("path", "/cms/page/view.do?bindType="+bindType);
    	return "/jnit/util/alertMove"; //return "jnit/msg";
    }

    @RequestMapping(value="/cms/page/save/backup.do")
    public String fileSavebackup(
    		 @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
    		 @RequestParam("bindType") java.lang.String bindType,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {

    	String docRoot = request.getSession().getServletContext().getRealPath("");
    	String contextPath = request.getContextPath();
    	String contextUri = request.getRequestURI();
    	String localUri = request.getServletPath();

    	//String filePath = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir + "/" + fileNm;
    	String filePath = "";

    	JnitcmssiteVO getSiteVO = AdminUtil.getSiteVO(request);

    	if(getSiteVO == null){
    		model.addAttribute("alert", "사이트를 선택해주세요.");
    		return "/jnit/util/alertBack";
    	}
    	FileInputStream fis = null;
    	if(bindType.equals("bannerRoll")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/allim/banner/"+getSiteVO.getSitePath()+"_original_bannerRolling_code.jsp";
    		AdminUtil.setMenuId("m06030200");
    	}else if(bindType.equals("bannerMore")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/allim/banner/"+getSiteVO.getSitePath()+"_original_bannerMore_code.jsp";
    		AdminUtil.setMenuId("m06030200");
    	}else if(bindType.equals("Allim")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/allim/"+getSiteVO.getSitePath()+"_original_AllimView_code.jsp";
    		AdminUtil.setMenuId("m06040200");
    	}else if(bindType.equals("Popup")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/allim/"+getSiteVO.getSitePath()+"_original_PopupView_code.jsp";
    		AdminUtil.setMenuId("m06050200");
    	}else if(bindType.equals("rechProgress")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_original_listProgress_code.jsp";
    		AdminUtil.setMenuId("m06070201");
    	}else if(bindType.equals("rechEnd")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_original_listEnd_code.jsp";
    		AdminUtil.setMenuId("m06070202");
    	}else if(bindType.equals("rechRegister")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_original_respondentRegister_code.jsp";
    		AdminUtil.setMenuId("m06070203");
    	}else if(bindType.equals("rechstats")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_original_statsUserView_code.jsp";
    		AdminUtil.setMenuId("m06070204");
    	}else if(bindType.equals("EnvCult")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_cultEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030401");
    	}else if(bindType.equals("EnvFood")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_foodEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030402");
    	}else if(bindType.equals("EnvFstv")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_fstvEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030403");
    	}else if(bindType.equals("EnvShop")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_shopEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030404");
    	}else if(bindType.equals("EnvStay")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_stayEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030405");
    	}else if(bindType.equals("EnvDetail")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_viewDetail_code.jsp";
    		AdminUtil.setMenuId("m06030406");
    	}else if(bindType.equals("leftMenu")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/cms/menu/original_sub_code.jsp";
    		AdminUtil.setMenuId("m02060100");

    		if(CmsHelper.getSessionSiteId(request).equals("")){
    			return "jnit/cms/sub4_msg-nosite";
    		}

    		AdminUtil.setMenuId("m02060100");
    		String siteId = CmsHelper.getSessionSiteId(request);

    		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
    		jnitcmssiteVO.setSiteId(siteId);
    		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

    		String mkFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sitemenu";
    		File FileDir = new File(mkFileDir);
    		if(!FileDir.exists()){
    			FileDir.mkdirs();
    			JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, FileDir);		//Filego 배포
    		}

    		filePath = docRoot + "/WEB-INF/jsp/jnit/cms/menu/sitemenu/"+NullUtil.nullString(siteVO.getSitePath())+"_original_sub_code.jsp";

    		try {
				fis = new FileInputStream(new File(filePath));
    		} catch (IOException e){
    			String setSubOriginCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/_original_sub_code.jsp";
				String setSubOriginCodeSrc = CmsHandler.readFile(setSubOriginCodeDir);

				String mkSubOriginCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_original_sub_code.jsp";
				CmsHandler.writeFile(mkSubOriginCodeDir, setSubOriginCodeSrc);
			} catch (Exception e) {

				String setSubOriginCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/_original_sub_code.jsp";
				String setSubOriginCodeSrc = CmsHandler.readFile(setSubOriginCodeDir);

				String mkSubOriginCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_original_sub_code.jsp";
				CmsHandler.writeFile(mkSubOriginCodeDir, setSubOriginCodeSrc);
			} finally {
				if(fis != null){
					fis.close();
				}
			}
    	}

        String[] FILTER_WORDS = { "<%", "%>","<c:","${" };

        // 필터링 문자의 갯수만큼 반복을 하여 요청 매개변수의 값에 문자가 포함되어 있는지 확인한다.
        for(int i=0; i<FILTER_WORDS.length; i++) {
            if(NullUtil.nullString(jnitcmstplVO.getTplSrc()).indexOf(FILTER_WORDS[i]) != -1) {
                // 필터링 문자가 발견 되었을시 처리.
            	String msg = "<script type='text/javascript' src='../../../resources/js/jquery.min.js'></script><script type='text/javascript'>alert('<% %> 는 사용하실 수 없습니다.'); $(document).ready(function(){parent.location.href='"+contextPath+"/cms/page/view.do?bindType="+bindType+"';}); </script>";
            	model.addAttribute("msg",msg);

            	return "jnit/msg";
            }
        }

        String fileString = NullUtil.nullString(jnitcmstplVO.getTplSrc());

        for(int i=0; i<taglib.length; i++) {
        	fileString = taglib[i] + fileString;
        }

    	CmsHandler.writeFile(filePath, NullUtil.nullString(jnitcmstplVO.getTplSrc()));

    	//model.addAttribute("msg", "<script src='<c:url value='/resources/js/jquery.min.js'/>'></script><script type='text/javascript'> $(document).ready(function(){ $(top.document).find('#ifmList').attr('src', $(top.document).find('#ifmList').attr('src')); $(top.document).find('#ifmContent').attr('src', '"+contextPath+"/cms/file/view.do?bindType="+bindType+"&dirType="+dirType+"&fileName="+fileNm+"'); }); </script>");
    	String msg = "<script type='text/javascript' src='../../../resources/js/jquery.min.js'></script><script type='text/javascript'>alert('백업데이터로 저장 되었습니다'); $(document).ready(function(){parent.location.href='"+contextPath+"/cms/page/view.do?bindType="+bindType+"';}); </script>";
    	model.addAttribute("msg",msg);

    	return "jnit/msg";
    }
    @RequestMapping(value="/cms/page/load/backup.do")
    public String fileLoadBackup(
    		 @RequestParam("bindType") java.lang.String bindType,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {
    	String docRoot = request.getSession().getServletContext().getRealPath("");

    	//String filePath = docRoot + "/" + sitePath + (!sitePath.equals("") ? "/" : "") + bindDir + "/" + fileNm;
    	String filePath = "";

    	JnitcmssiteVO getSiteVO = AdminUtil.getSiteVO(request);

    	if(getSiteVO == null){
    		model.addAttribute("alert", "사이트를 선택해주세요.");
    		return "/jnit/util/alertBack";
    	}
    	FileInputStream fis = null;
    	if(bindType.equals("bannerRoll")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/allim/banner/"+getSiteVO.getSitePath()+"_original_bannerRolling_code.jsp";
    		AdminUtil.setMenuId("m06030200");
    	}else if(bindType.equals("bannerMore")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/allim/banner/"+getSiteVO.getSitePath()+"_original_bannerMore_code.jsp";
    		AdminUtil.setMenuId("m06030200");
    	}else if(bindType.equals("Allim")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/allim/"+getSiteVO.getSitePath()+"_original_AllimView_code.jsp";
    		AdminUtil.setMenuId("m06040200");
    	}else if(bindType.equals("Popup")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/allim/"+getSiteVO.getSitePath()+"_original_PopupView_code.jsp";
    		AdminUtil.setMenuId("m06040200");
    	}else if(bindType.equals("rechProgress")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_original_listProgress_code.jsp";
    		AdminUtil.setMenuId("m06070201");
    	}else if(bindType.equals("rechEnd")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_original_listEnd_code.jsp";
    		AdminUtil.setMenuId("m06070202");
    	}else if(bindType.equals("rechRegister")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_original_respondentRegister_code.jsp";
    		AdminUtil.setMenuId("m06070203");
    	}else if(bindType.equals("rechstats")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/research/userview/"+getSiteVO.getSitePath()+"_original_statsUserView_code.jsp";
    		AdminUtil.setMenuId("m06070204");
    	}else if(bindType.equals("EnvCult")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_cultEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030401");
    	}else if(bindType.equals("EnvFood")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_foodEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030402");
    	}else if(bindType.equals("EnvFstv")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_fstvEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030403");
    	}else if(bindType.equals("EnvShop")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_shopEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030404");
    	}else if(bindType.equals("EnvStay")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_stayEnvirons_code.jsp";
    		AdminUtil.setMenuId("m06030405");
    	}else if(bindType.equals("EnvDetail")) {
    		filePath = docRoot +"/WEB-INF/jsp/jnit/ct/view/original_viewDetail_code.jsp";
    		AdminUtil.setMenuId("m06030406");
    	}else if(bindType.equals("leftMenu")) {
    		// filePath = docRoot +"/WEB-INF/jsp/jnit/cms/menu/original_sub_code.jsp";


    		if(CmsHelper.getSessionSiteId(request).equals("")){
    			return "jnit/cms/sub4_msg-nosite";
    		}

    		AdminUtil.setMenuId("m02060100");
    		String siteId = CmsHelper.getSessionSiteId(request);

    		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
    		jnitcmssiteVO.setSiteId(siteId);
    		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

    		String mkFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/sitemenu";
    		File FileDir = new File(mkFileDir);
    		if(!FileDir.exists()){
    			FileDir.mkdirs();
    			JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, FileDir);		//Filego 배포
    		}

    		filePath = docRoot + "/WEB-INF/jsp/jnit/cms/menu/sitemenu/"+NullUtil.nullString(siteVO.getSitePath())+"_original_sub_code.jsp";

    		try {
				fis = new FileInputStream(new File(filePath));
    		} catch (IOException e){
    			String setSubOriginCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/_original_sub_code.jsp";
				String setSubOriginCodeSrc = CmsHandler.readFile(setSubOriginCodeDir);

				String mkSubOriginCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_original_sub_code.jsp";
				CmsHandler.writeFile(mkSubOriginCodeDir, setSubOriginCodeSrc);
			} catch (Exception e) {

				String setSubOriginCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/_original_sub_code.jsp";
				String setSubOriginCodeSrc = CmsHandler.readFile(setSubOriginCodeDir);

				String mkSubOriginCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_original_sub_code.jsp";
				CmsHandler.writeFile(mkSubOriginCodeDir, setSubOriginCodeSrc);
			} finally {
				if(fis != null){
					fis.close();
				}
			}

    	}

    	final HashMap<String, Object> onceFile = new HashMap<String, Object>();
    	final File f = new File(filePath);

		String mimeType = null;
		String mimeHeader = null;
    	String viewPath = null;
    	if(f.exists()) {
    		onceFile.put("date", new Date(f.lastModified()));
    		onceFile.put("size", f.length() / 1000);

    		try {
    		    Tika tika = new Tika();
    		    mimeType = tika.detect(f);
    		} catch (IOException e){
    			log.error(e.getMessage());
    		} catch (Exception e) {
    		    log.error("오류: tika");
    		}
    		onceFile.put("mime", mimeType);


        	String[] mimeSplit = mimeType.split("/");
        	mimeHeader = mimeSplit[0];
    	}else {
    		mimeHeader = "unknown";
    	}

    	model.addAttribute("file", onceFile);
    	String fileString = FileUtil.getFileContent(f);
        for(int i=0; i<taglib.length; i++) {
        	fileString = fileString.replaceAll(taglib[i], "");
        }

    	//viewPath = "/jnit/cms/file/textview";
    		JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();

    		jnitcmstplVO.setTplSrc(fileString);

    		model.addAttribute("bindType",bindType);
    		model.addAttribute("jnitcmstplVO", jnitcmstplVO);
    		//@ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,

    	return "/jnit/cms/page/textview";
    }

    @RequestMapping("/menu/topmenuJson.do")
    public String TopmenuAjax(HttpServletRequest request, Model model){

    	String target = NullUtil.nullString(request.getParameter("target"));

    	String defaultPath = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/cms/menu/";
    	String baseUrl = defaultPath + "topmenu" + SEPARATOR + target;
	    List result = FileCopy.getFileNm(baseUrl);
	    JSONArray json = JSONArray.fromObject(result);

    	model.addAttribute("json",json);
    	return "/jnit/util/json";
    }

    /**
     * 알리미 디자인에필요한 model addAttribute 셋팅한다.
     * @param request
     * @param model
     * @param where - 경로 root/WEB-INF/jsp/jnit
     * @param type - 타입
     * @param skinNm - 파일이름
     * @param filePath - 파일경로
     * @return model
     * @throws Exception
     * {@link CmsPageViewController#fileView}
     */
    private ModelMap allimSkinModelMap(HttpServletRequest request, ModelMap model, String where, String type, String skinNm, String filePath, String condition)throws Exception{
    	String allimDefaultSrc = CmsHandler.readFile(where + "/allim/default/"+type+"/"+skinNm+"_code.jsp");
    	File skinDir = new File(where+"/allim/skin/"+type);
    	if(!skinDir.exists()) skinDir.mkdirs();

		FileCopy.isFileExists(filePath, allimDefaultSrc); //FILE 체크
		String filelistDir = where+"/allim/default/allim";
		File fileList = new File(filelistDir);
		if(fileList.exists()){
			//ArrayList skinList = jnitallimItemService.allimFileNameList(request, type, condition);
			ArrayList skinList = jnitallimItemService.allimFileNameList(request, type, condition);
    		model.addAttribute("allimSkin", "Y");
			model.addAttribute("skinList", skinList);
			model.addAttribute("skinNm", skinNm);
		}
    	return model;
    }

    /**
     *
     * @param request
     * @param model
     * @param filePath
     * @param sitePath
     * @return
     * @throws Exception
     * {@link CmsPageViewController#fileView}
     */
    private ModelMap researchMap(ModelMap model, String filePath,String sitePath)throws Exception{
    	String researchfileDir = filePath.replace(sitePath+"_", "");
    	FileCopy.isFileExists(filePath, CmsHandler.readFile(researchfileDir));
    	return model;
    }

    /**
     * AdminUtil을 제어한다.
     * @param request
     * @param model
     * @return model
     * @throws Exception
     */
    private static ModelMap AdminJson(HttpServletRequest request,ModelMap model)throws Exception{
    	String bindType = NullUtil.nullString(request.getParameter("bindType"));
    	if(bindType.equals("bannerRolling")) {
    		AdminUtil.setMenuId("m06020201");
    	}else if(bindType.equals("bannerMore")) {
    		AdminUtil.setMenuId("m06020202");
    	}else if(bindType.equals("allimView")) {
    		AdminUtil.setMenuId("m06030200");
    	}else if(bindType.equals("PopupView")) {
    		AdminUtil.setMenuId("m06040200");
    	}else if(bindType.equals("rechProgress")) {
    		AdminUtil.setMenuId("m06060201");
    	}else if(bindType.equals("rechEnd")) {
    		AdminUtil.setMenuId("m06060202");
    	}else if(bindType.equals("rechRegister")) {
    		AdminUtil.setMenuId("m06060203");
    	}else if(bindType.equals("rechstats")) {
    		AdminUtil.setMenuId("m06060204");
    	}else if(bindType.equals("rechImport")) {
    		AdminUtil.setMenuId("m06060205");
    	}else if(bindType.equals("answerPopup")) {
    		AdminUtil.setMenuId("m06060206");
    	}else if(bindType.equals("EnvCult")) {
    		AdminUtil.setMenuId("m06030401");
    	}else if(bindType.equals("EnvFood")) {
    		AdminUtil.setMenuId("m06030402");
    	}else if(bindType.equals("EnvFstv")) {
    		AdminUtil.setMenuId("m06030403");
    	}else if(bindType.equals("EnvShop")) {
    		AdminUtil.setMenuId("m06030404");
    	}else if(bindType.equals("EnvStay")) {
    		AdminUtil.setMenuId("m06030405");
    	}else if(bindType.equals("EnvDetail")) {
    		AdminUtil.setMenuId("m06030406");
    	}else if(bindType.equals("leftMenu")) {
    		AdminUtil.setMenuId("m04020300");
    	}else if(bindType.equals("topMenu")){
    		AdminUtil.setMenuId("m04020400");
    	}else if(bindType.equals("contentAdmin")){
    		AdminUtil.setMenuId("m04020500");
    	}else if(bindType.equals("updateButton")){
    		AdminUtil.setMenuId("m04020600");
    	}else if(bindType.equals("sitemap")){
    		AdminUtil.setMenuId("m04020700");
    	}

    	return model;
    }

    /**
     * 사이트베이스인지 체크
     * @param bindType
     * @return Boolean
     * @throws Exception
     */
    private Boolean isNoSitebln(String bindType)throws Exception{
    	bindType = NullUtil.nullString(bindType);
    	if(!"".equals(bindType)){
    		String[] array = {"allimView","bannerRolling","bannerMore","PopupView","topMenu"};
    		if(StringUtil.isExistArray(array, bindType)) return false;
    	}
    	return true;
    }

    public static HashMap<String, String> changeCode (){
    	HashMap<String, String> changeCode = new HashMap<String, String>();
    	changeCode.put("{bannerRollingUrl_1}", "<script type=\"text/javascript\" src=\"${pageContext.request.contextPath }/resources/js/ap/js_bannerRolling.js\"></script>");
    	changeCode.put("{bannerRollingFunction_1}","${Direction}");
    	changeCode.put("{bannerRollingFunction_2}","${ShowItems}");
    	changeCode.put("{bannerRollingFunction_3}","${TimerDelay}");
    	changeCode.put("{bannerRollingFunction_4}","${AnimationDelay}");
    	changeCode.put("{bannerRollingFunction_5}","${Auto}");
    	changeCode.put("{bannerRollingFunction_6}","${ImgWidth}");
    	changeCode.put("{bannerRollingFunction_7}","${ImgHeight}");
    	changeCode.put("{bannerRollingFunction_8}","$(\"#bannerMorePath\").val() == '' ? '${bannerMorePath}' : $(\"#bannerMorePath\").val()");
    	changeCode.put("{bannerRollingFunction_9}","<c:out value=\"${bannerMorePath }?jnitallim/bannerMore.do?groupId=${groupId }\" />");
    	changeCode.put("{bannerRollingFunction_10}","${fn:escapeXml(resultList.itemLink) }");
    	changeCode.put("{bannerRollingFunction_11}","${resultList.itemTarget }");
    	changeCode.put("{bannerRollingFunction_12}","<c:out value='${pageContext.request.contextPath }' />${empty resultList.itemUrlPath ? fn:escapeXml(resultList.itemUrl) : resultList.itemUrlPath }");
    	/*changeCode.put("{bannerRollingFunction_13}","${resultList.itemAlt}");*/
    	changeCode.put("{bannerRollingFunction_13}","${DBType == 'ORACLE' || DBType == 'TIBERO' ? bannerAltMap[resultList.itemId] : resultList.itemAlt }");
    	changeCode.put("{bannerRollingFunction_14}","${resultList.groupWidth }");
    	changeCode.put("{bannerRollingFunction_15}","${resultList.groupHeight }");
    	changeCode.put("{bannerRollingFunction_16}","${pageContext.request.contextPath }");
    	changeCode.put("{bannerRollingFunction_17}","{Jnit_sitePath }");
    	changeCode.put("{bannerRollingForeach_1}","<c:forEach var=\"resultList\" items=\"${groupList}\" varStatus=\"status\" end=\"100\">");
    	changeCode.put("{bannerRollingForeach_end}","</c:forEach>");

    	/**************************************************************/
    	/*changeCode.put("{bannerMoreFunction_1}","<c:url value=\"${moreList.itemUrl }\" />");*/
    	changeCode.put("{bannerMoreFunction_1}","<c:out value='${pageContext.request.contextPath }' />${fn:escapeXml(moreList.itemUrl)}");
    	changeCode.put("{bannerMoreFunction_2}","<c:out value=\"${moreList.itemAlt }\" />");
    	changeCode.put("{bannerMoreFunction_3}","<c:out value=\"${DBType == 'ORACLE' || DBType == 'TIBERO' ? itemAltMap[moreList.itemId] : moreList.itemAlt }\"/>");
    	changeCode.put("{bannerMoreFunction_4}","<c:out value=\"${moreList.itemLink }\" />");
    	changeCode.put("{bannerMoreFunction_5}","<c:out value=\"${fn:substring(moreList.itemLink,0,40) }\" escapeXml=\"false\" />");
    	changeCode.put("{bannerMoreFunction_6}","<c:out value=\"${fn:length(moreList.itemLink) > 41 ? '...' : '' }\" />");

    	changeCode.put("{bannerMorePagination}","<ui:pagination paginationInfo = \"${paginationInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_link_page\" /> <form:hidden path=\"pageIndex\" />");
    	//changeCode.put("{bannerMorePagination}","<ui:pagination paginationInfo = \"${paginationInfo}\"   type=\"jnitDefault\"   jsFunction=\"jnitBoardPage\"   /> <form:hidden path=\"pageIndex\" />");

    	changeCode.put("{bannerMoreForeach_1}","<c:forEach var=\"moreList\" items=\"${moreList }\" varStatus=\"status\">");
    	changeCode.put("{bannerMoreForeach_end}","</c:forEach>");
    	/**************************************************************/
    	changeCode.put("{allimFunction_1}","${grpResultSize}");
    	changeCode.put("{allimFunction_2}","${grpValue.groupChangeTime}");
    	changeCode.put("{allimFunction_3}","${grpValue.groupClassName}");
    	changeCode.put("{allimFunction_4}","${status.count}");
    	changeCode.put("{allimFunction_5}","${allim.itemLink}");
    	changeCode.put("{allimFunction_6}","${allim.itemTarget}");
    	changeCode.put("{allimFunction_7}","${pageContext.request.contextPath}${empty allim.itemUrlPath ? fn:escapeXml(allim.itemUrl) : allim.itemUrlPath}");
    	changeCode.put("{allimFunction_8}","${DBType == 'ORACLE' || DBType == 'TIBERO' ? itemAltMap[allim.itemId]  : allim.itemAlt}");
    	changeCode.put("{allimFunction_9}","${allim.groupWidth}");
    	changeCode.put("{allimFunction_10}","${allim.groupHeight}");

    	changeCode.put("{allimFunction_11}","<c:out value=\"${fn:escapeXml(allim.itemLink)}\" escapeXml=\"true\" />");
    	changeCode.put("{allimFunction_13}","<c:out value=\"${itemAltMap[allim.itemId]}\" escapeXml=\"false\"/>");
    	changeCode.put("{allimFunction_14}","${getSite }");

    	changeCode.put("{allimFunction_15}","<c:set var=\"statusvisual\" value=\"${status.count == 1 ? 'on' : 'off'}\"/>");

    	changeCode.put("{allimFunction_16}","$(\"#\"+id1+\"\")");
    	changeCode.put("{allimFunction_17}","$(\"#\"+id2+\"\")");
    	changeCode.put("{allimFunction_18}","${pageContext.request.contextPath }/resources/js/ap/js_allimIconRolling.js");
    	changeCode.put("{allimFunction_19}","${allim.itemExt01 }");
    	changeCode.put("{allimFunction_20}","<c:out value=\"${fn:substring(allim.itemExt02,0,23)}\" escapeXml=\"false\" /><c:out value=\"${fn:length(allim.itemExt02) > 24 ? '...' : ''}\" />");
    	changeCode.put("{allimFunction_21}","<c:set var=\"statuspopbanner\" value=\"${status.count == 1 ? 'on' : 'off'}\"/>");
    	changeCode.put("{allimFunction_22}","${statuspopbanner }");

    	changeCode.put("{allimFunction_23}","$(\"#\"+aillmid1)");
    	changeCode.put("{allimFunction_24}","$(\"#\"+aillmid2)");
    	changeCode.put("{allimFunction_25}","<c:if test=\"${!empty itemHtmlcodeMap[result.itemId]}\">");
    	changeCode.put("{allimFunction_26}","${itemHtmlcodeMap[popup.itemId] }");
    	changeCode.put("{allimFunction_27}","<c:if test=\"${empty itemHtmlcodeMap[result.itemId]}\">");
    	changeCode.put("{allimFunction_28}","${popup.itemLink}");
    	changeCode.put("{allimFunction_29}","${popup.itemTarget }");
    	changeCode.put("{allimFunction_30}","${popup.itemTarget }");
    	changeCode.put("{allimFunction_31}","${pageContext.request.contextPath }");
    	changeCode.put("{allimFunction_32}","${pageContext.request.contextPath}${empty popup.itemUrlPath ? fn:escapeXml(popup.itemUrl) : popup.itemUrlPath }");
    	changeCode.put("{allimFunction_33}","${DBType == 'ORACLE' || DBType == 'TIBERO' ? itemAltMap[popup.itemId] : popup.itemAlt }");
    	changeCode.put("{allimFunction_34}","${popup.groupWidth }");
    	changeCode.put("{allimFunction_35}","${popup.groupHeight }");
    	changeCode.put("{allimFunction_36}","${groupId}");

    	changeCode.put("{allimFunction_37}","<c:url value=\"${Jnit_sitePath}/js/jquery-ui-1.9.0.custom.min.js\"/>");
    	changeCode.put("{allimFunction_38}","$(\"#allimActiveId\")");
    	changeCode.put("{allimFunction_39}","$(\"#\"+allimActiveId+\"_li\")");

    	changeCode.put("{allimFunction_40}","$(\"#allimAnimateVisual_ul li:last\")");
    	changeCode.put("{allimFunction_41}","$('#allimAnimateVisual_ul')");
    	changeCode.put("{allimFunction_42}","$(\"#allimAnimateVisual_ul li:first\")");
    	changeCode.put("{allimFunction_43}","${result.itemLink}");
    	changeCode.put("{allimFunction_44}","${result.itemTarget }");
    	changeCode.put("{allimFunction_45}","${pageContext.request.contextPath}${empty result.itemUrlPath ? fn:escapeXml(result.itemUrl) : result.itemUrlPath }");
    	changeCode.put("{allimFunction_46}","${DBType == 'ORACLE' || DBType == 'TIBERO' ? itemAltMap[result.itemId] : result.itemAlt}");
    	changeCode.put("{allimFunction_47}","${result.groupWidth }");
    	changeCode.put("{allimFunction_48}","${result.groupHeight }");
    	changeCode.put("{allimFunction_49}","{Jnit_sitePath }");
    	changeCode.put("{allimFunction_50}","${itemHtmlcodeMap[result.itemId] }");
    	changeCode.put("{allimFunction_51}","${result.itemId }");
    	changeCode.put("{allimFunction_52}","${result.itemExt05}");
    	changeCode.put("{allimFunction_53}","${result.itemExt06}");
    	changeCode.put("{allimFunction_54}","${result.itemExt07}");
    	changeCode.put("{allimFunction_55}","${result.itemExt08}");
    	changeCode.put("{allimFunction_56}","${result.itemExt09}");
    	changeCode.put("{allimFunction_57}","${result.itemExt10}");
    	changeCode.put("{allimFunction_58}","${result.itemExt11}");


    	changeCode.put("{allimCif_1}", "<c:if test=\"${allim.itemTarget == '_blank'}\">");
    	changeCode.put("{allimCif_2}", "<c:if test=\"${allim.itemTarget != '_blank'}\">");
    	changeCode.put("{allimCif_3}", "<c:if test=\"${startDate < today  && today < endDate}\">");


    	changeCode.put("{allimForeach_1}","<c:forEach var=\"allim\" items=\"${grpResult}\" varStatus=\"status\">");
    	changeCode.put("{allimForeach_2}","<c:forEach var=\"result\" items=\"${grpResult}\" varStatus=\"status\">");
    	changeCode.put("{allimForeach_3}","<c:forEach var=\"popup\" items=\"${grpResult}\" varStatus=\"status\">");

    	changeCode.put("{allimCifend}", "</c:if>");
    	changeCode.put("{allimForeach_end}","</c:forEach>");
    	/***************************************************************/
    	changeCode.put("{bannerFunction_1}", "${popup.itemExt01}");
    	changeCode.put("{bannerFunction_2}", "${popup.itemWidth}");
    	changeCode.put("{bannerFunction_3}", "${popup.itemHeight}");
    	changeCode.put("{bannerFunction_4}", "${popup.itemTop}");
    	changeCode.put("{bannerFunction_5}", "${popup.itemRight}");
    	changeCode.put("{bannerFunction_6}", "${popup.itemExt02}");
    	changeCode.put("{bannerFunction_7}", "${popup.itemMode}");
    	changeCode.put("{bannerFunction_8}", "${empty popup.itemUrlPath ? popup.itemUrl : popup.itemUrlPath }");
    	changeCode.put("{bannerFunction_9}", "${popup.itemId}");
    	changeCode.put("{bannerFunction_10}", "${pageContext.request.contextPath}${DBType == 'ORACLE' || DBType == 'TIBERO' ? itemHtmlcodeMap[popup.itemId] : popup.itemHtmlcode}");
    	changeCode.put("{bannerFunction_11}", "${pageContext.request.contextPath}");
    	changeCode.put("{bannerFunction_12}", "${popup.groupId}");
    	changeCode.put("{bannerForeach_1}", "<c:forEach var=\"popup\" items=\"${grpResult}\" varStatus=\"status\">");
    	changeCode.put("{bannerForeach_end}", "</c:forEach>");
    	/**************************************************************/
    	changeCode.put("{cultFunction_1}", "${cultInfoSize<0 ? '0' : cultInfoSize }");
    	changeCode.put("{cultFunction_2}", "<c:set var=\"cultInfoId\" value=\"${cultInfoList.cultId }\" />");
    	changeCode.put("{cultFunction_3}", "<c:set var=\"cultInfoTypeId\" value=\"${cultInfoList.typeId }\"/>");
    	changeCode.put("{cultFunction_4}", "<c:set var=\"cultInfoNm\" value=\"${cultInfoList.cultNm }\"/>");
    	changeCode.put("{cultFunction_5}", "<c:out value=\"${pageContext.request.contextPath }\" />");
    	changeCode.put("{cultFunction_6}", "${cultInfoList.fileUrl}");
    	changeCode.put("{cultFunction_7}", "<c:out value=\"${viewPath }\" /><c:out value=\"?mode=${mode }&cultId=${cultInfoId}&typeId=${cultInfoTypeId}\" />");
    	changeCode.put("{cultFunction_8}", "${cultInfoList.cultNm }");
    	changeCode.put("{cultFunction_9}", "${status.count}");
    	changeCode.put("{cultFunction_10}", "${cultInfoList.newAddr }");
    	changeCode.put("{cultFunction_11}", "${cultInfoList.phone }");
    	changeCode.put("{cultFunction_12}", "${lat}");
    	changeCode.put("{cultFunction_13}", "${lng}");
    	changeCode.put("{cultFunction_14}", "${cultInfoList.gridX}");
    	changeCode.put("{cultFunction_15}", "${cultInfoList.gridY}");
    	changeCode.put("{cultCif_1}", "<c:if test='${fn:length(cultInfoList) <= 1 }'>");
    	changeCode.put("{cultCif_2}", "<c:if test='${fn:length(cultInfoList) != 1 }'>");
    	changeCode.put("{cultCif_end}", "</c:if>");
    	changeCode.put("{cultForeach_1}", "<c:forEach var=\"cultInfoList\" items=\"${cultInfoList }\" begin=\"1\" varStatus=\"status\">");
    	changeCode.put("{cultForeach_end}", "</c:forEach>");
    	changeCode.put("{cultPagenavi}", "<ul><ui:pagination paginationInfo = \"${paginationInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_cultInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	/*******************************************************/
    	changeCode.put("{foodFunction_1}", "${foodInfoSize<0 ? '0' : foodInfoSize  }");
    	changeCode.put("{foodFunction_2}", "<c:set var=\"foodInfoId\" value=\"${foodInfoList.cultId }\" />");
    	changeCode.put("{foodFunction_3}", "<c:set var=\"foodInfoTypeId\" value=\"${foodInfoList.typeId }\"/>");
    	changeCode.put("{foodFunction_4}", "<c:set var=\"foodInfoNm\" value=\"${foodInfoList.cultNm }\"/>");
    	changeCode.put("{foodFunction_5}", "<c:out value=\"${pageContext.request.contextPath }\" />");
    	changeCode.put("{foodFunction_6}", "${foodInfoList.fileUrl}");
    	changeCode.put("{foodFunction_7}", "<c:out value=\"${viewPath }\" /><c:out value=\"?mode=${mode }&foodId=${foodInfoId}&typeId=${foodInfoTypeId}\" />");
    	changeCode.put("{foodFunction_8}", "${foodInfoList.cultNm }");
    	changeCode.put("{foodFunction_9}", "${status.count}");
    	changeCode.put("{foodFunction_10}", "${foodInfoList.newAddr }");
    	changeCode.put("{foodFunction_11}", "${foodInfoList.phone }");
    	changeCode.put("{foodFunction_12}", "${lat}");
    	changeCode.put("{foodFunction_13}", "${lng}");
    	changeCode.put("{foodFunction_14}", "${foodInfoList.gridX}");
    	changeCode.put("{foodFunction_15}", "${foodInfoList.gridY}");
    	changeCode.put("{foodCif_1}", "<c:if test='${fn:length(foodInfoList) <= 1 }'>");
    	changeCode.put("{foodCif_2}", "<c:if test='${fn:length(foodInfoList) != 1 }'>");
    	changeCode.put("{foodCif_end}", "</c:if>");
    	changeCode.put("{foodForeach_1}", "<c:forEach var=\"foodInfoList\" items=\"${foodInfoList }\" begin=\"1\" varStatus=\"status\">");
    	changeCode.put("{foodForeach_end}", "</c:forEach>");
    	changeCode.put("{foodPagenavi}", "<ul><ui:pagination paginationInfo = \"${paginationInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_foodInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	/********************************************************/
    	changeCode.put("{fstvFunction_1}", "${fstvInfoSize<0 ? '0' : fstvInfoSize  }");
    	changeCode.put("{fstvFunction_2}", "<c:set var=\"fstvInfoId\" value=\"${fstvInfoList.cultId }\" />");
    	changeCode.put("{fstvFunction_3}", "<c:set var=\"fstvInfoTypeId\" value=\"${fstvInfoList.typeId }\"/>");
    	changeCode.put("{fstvFunction_4}", "<c:set var=\"fstvInfoNm\" value=\"${fstvInfoList.cultNm }\"/>");
    	changeCode.put("{fstvFunction_5}", "<c:out value=\"${pageContext.request.contextPath }\" />");
    	changeCode.put("{fstvFunction_6}", "${fstvInfoList.fileUrl}");
    	changeCode.put("{fstvFunction_7}", "<c:out value=\"${viewPath }\" /><c:out value=\"?mode=${mode }&fstvId=${fstvInfoId}&typeId=${fstvInfoTypeId}\" />");
    	changeCode.put("{fstvFunction_8}", "${fstvInfoList.cultNm }");
    	changeCode.put("{fstvFunction_9}", "${status.count}");
    	changeCode.put("{fstvFunction_10}", "${fstvInfoList.newAddr }");
    	changeCode.put("{fstvFunction_11}", "${fstvInfoList.phone }");
    	changeCode.put("{fstvFunction_12}", "${lat}");
    	changeCode.put("{fstvFunction_13}", "${lng}");
    	changeCode.put("{fstvFunction_14}", "${fstvInfoList.gridX}");
    	changeCode.put("{fstvFunction_15}", "${fstvInfoList.gridY}");
    	changeCode.put("{fstvCif_1}", "<c:if test='${fn:length(fstvInfoList) <= 1 }'>");
    	changeCode.put("{fstvCif_2}", "<c:if test='${fn:length(fstvInfoList) != 1 }'>");
    	changeCode.put("{fstvCif_end}", "</c:if>");
    	changeCode.put("{fstvForeach_1}", "<c:forEach var=\"fstvInfoList\" items=\"${fstvInfoList }\" begin=\"1\" varStatus=\"status\">");
    	changeCode.put("{fstvForeach_end}", "</c:forEach>");
    	changeCode.put("{fstvPagenavi}", "<ul><ui:pagination paginationInfo = \"${paginationInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_fstvInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	/********************************************************/
    	changeCode.put("{shopFunction_1}", "${shopInfoSize<0 ? '0' : shopInfoSize  }");
    	changeCode.put("{shopFunction_2}", "<c:set var=\"shopInfoId\" value=\"${shopInfoList.cultId }\" />");
    	changeCode.put("{shopFunction_3}", "<c:set var=\"shopInfoTypeId\" value=\"${shopInfoList.typeId }\"/>");
    	changeCode.put("{shopFunction_4}", "<c:set var=\"shopInfoNm\" value=\"${shopInfoList.cultNm }\"/>");
    	changeCode.put("{shopFunction_5}", "<c:out value=\"${pageContext.request.contextPath }\" />");
    	changeCode.put("{shopFunction_6}", "${shopInfoList.fileUrl}");
    	changeCode.put("{shopFunction_7}", "<c:out value=\"${viewPath }\" /><c:out value=\"?mode=${mode }&shopId=${shopInfoId}&typeId=${shopInfoTypeId}\" />");
    	changeCode.put("{shopFunction_8}", "${shopInfoList.cultNm }");
    	changeCode.put("{shopFunction_9}", "${status.count}");
    	changeCode.put("{shopFunction_10}", "${shopInfoList.newAddr }");
    	changeCode.put("{shopFunction_11}", "${shopInfoList.phone }");
    	changeCode.put("{shopFunction_12}", "${lat}");
    	changeCode.put("{shopFunction_13}", "${lng}");
    	changeCode.put("{shopFunction_14}", "${shopInfoList.gridX}");
    	changeCode.put("{shopFunction_15}", "${shopInfoList.gridY}");
    	changeCode.put("{shopCif_1}", "<c:if test='${fn:length(shopInfoList) <= 1 }'>");
    	changeCode.put("{shopCif_2}", "<c:if test='${fn:length(shopInfoList) != 1 }'>");
    	changeCode.put("{shopCif_end}", "</c:if>");
    	changeCode.put("{shopForeach_1}", "<c:forEach var=\"shopInfoList\" items=\"${shopInfoList }\" begin=\"1\" varStatus=\"status\">");
    	changeCode.put("{shopForeach_end}", "</c:forEach>");
    	changeCode.put("{shopPagenavi}", "<ul><ui:pagination paginationInfo = \"${paginationInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_shopInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	/********************************************************/
    	changeCode.put("{stayFunction_1}", "${stayInfoSize<0 ? '0' : stayInfoSize  }");
    	changeCode.put("{stayFunction_2}", "<c:set var=\"stayInfoId\" value=\"${stayInfoList.cultId }\" />");
    	changeCode.put("{stayFunction_3}", "<c:set var=\"stayInfoTypeId\" value=\"${stayInfoList.typeId }\"/>");
    	changeCode.put("{stayFunction_4}", "<c:set var=\"stayInfoNm\" value=\"${stayInfoList.cultNm }\"/>");
    	changeCode.put("{stayFunction_5}", "<c:out value=\"${pageContext.request.contextPath }\" />");
    	changeCode.put("{stayFunction_6}", "${stayInfoList.fileUrl}");
    	changeCode.put("{stayFunction_7}", "<c:out value=\"${viewPath }\" /><c:out value=\"?mode=${mode }&stayId=${stayInfoId}&typeId=${stayInfoTypeId}\" />");
    	changeCode.put("{stayFunction_8}", "${stayInfoList.cultNm }");
    	changeCode.put("{stayFunction_9}", "${status.count}");
    	changeCode.put("{stayFunction_10}", "${stayInfoList.newAddr }");
    	changeCode.put("{stayFunction_11}", "${stayInfoList.phone }");
    	changeCode.put("{stayFunction_12}", "${lat}");
    	changeCode.put("{stayFunction_13}", "${lng}");
    	changeCode.put("{stayFunction_14}", "${stayInfoList.gridX}");
    	changeCode.put("{stayFunction_15}", "${stayInfoList.gridY}");
    	changeCode.put("{stayCif_1}", "<c:if test='${fn:length(stayInfoList) <= 1 }'>");
    	changeCode.put("{stayCif_2}", "<c:if test='${fn:length(stayInfoList) != 1 }'>");
    	changeCode.put("{stayCif_end}", "</c:if>");
    	changeCode.put("{stayForeach_1}", "<c:forEach var=\"stayInfoList\" items=\"${stayInfoList }\" begin=\"1\" varStatus=\"status\">");
    	changeCode.put("{stayForeach_end}", "</c:forEach>");
    	changeCode.put("{stayPagenavi}", "<ul><ui:pagination paginationInfo = \"${paginationInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_stayInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	/************************************************************/
    	changeCode.put("{ctDetailUrl_1}","<c:url value=\"/resources/js/geo.js\"/>");
    	changeCode.put("{ctDetailUrl_2}","<c:url value='/cms/ct/cultList.do'/>");
    	changeCode.put("{ctDetailUrl_3}", "<c:url value=\"/roadview/?addr=${oldAddr0} ${oldAddr1}\" />");
    	changeCode.put("{ctDetailFunction_1}","${distance}");
    	changeCode.put("{ctDetailFunction_2}","${cultId }");
    	changeCode.put("{ctDetailFunction_3}","{typeId }");
    	changeCode.put("{ctDetailFunction_4}","${mode }");
    	changeCode.put("{ctDetailFunction_5}","${cultMainList.cultNm }");
    	changeCode.put("{ctDetailFunction_6}","<c:out value='${pageContext.request.contextPath }' />${cultMainList.fileUrl}");
    	changeCode.put("{ctDetailFunction_7}","${status.index }");
    	changeCode.put("{ctDetailFunction_8}","<c:out value=\"${pageContext.request.contextPath }\" />${cultList.fileUrl}");
    	changeCode.put("{ctDetailFunction_9}","${status.count }");
    	changeCode.put("{ctDetailFunction_10}","${cultMainList.grp == null ? '-' : cultMainList.grp }");
    	changeCode.put("{ctDetailFunction_11}","${cultMainList.grp2 == null ? '-' : cultMainList.grp2 }");
    	changeCode.put("{ctDetailFunction_12}","${cultMainList.newAddr == null ? '-' : cultMainList.newAddr }");
    	changeCode.put("{ctDetailFunction_13}","${cultMainList.phone == null ? '-' : cultMainList.phone}");
    	changeCode.put("{ctDetailFunction_14}","${cultMainList.fax == null ? '-' : cultMainList.fax}");
    	changeCode.put("{ctDetailFunction_15}","${cultMainList.email == null ? '-' : cultMainList.email }");
    	changeCode.put("{ctDetailFunction_16}","${cultMainList.admNm == null ? '-' : cultMainList.admNm}");
    	changeCode.put("{ctDetailFunction_17}","${cultMainList.admPhone == null ? '-' : cultMainList.admPhone}");
    	changeCode.put("{ctDetailFunction_18}","${areaNm == null ? '-' : areaNm }");
    	changeCode.put("{ctDetailFunction_19}","${zoneNm == null ? '-' : zoneNm }");
    	changeCode.put("{ctDetailFunction_20}","${originNm == null ? '-' : originNm }");
    	changeCode.put("{ctDetailFunction_21}","${cultMainList.detailInfo == null ? '소개글이 없습니다' : cultMainList.detailInfo }");
    	changeCode.put("{ctDetailFunction_22}","${cultMainList.cultAppoint == null ? '-' : cultMainList.cultAppoint }");
    	changeCode.put("{ctDetailFunction_23}","${cultMainList.cultYear == null ? '-' : cultMainList.cultYear }");
    	changeCode.put("{ctDetailFunction_24}","${cultMainList.cultYear == null ? '-' : cultMainList.cultYear }");
    	changeCode.put("{ctDetailFunction_25}","${cultMainList.serviceTime == null ? '-' : cultMainList.serviceTime }");
    	changeCode.put("{ctDetailFunction_26}","${cultMainList.rsvPhone == null ? '-': cultMainList.rsvPhone }");
    	changeCode.put("{ctDetailFunction_27}","${cultMainList.rsvInternet == null ? '-' : cultMainList.rsvInternet }");
    	changeCode.put("{ctDetailFunction_28}","${cultMainList.disableInfo == null ? '-' : cultMainList.disableInfo }");
    	changeCode.put("{ctDetailFunction_29}","${cultMainList.toilet == null ? '-' : cultMainList.toilet  }");
    	changeCode.put("{ctDetailFunction_30}","${cultMainList.holiday == null ? '-' : cultMainList.holiday  }");
    	changeCode.put("{ctDetailFunction_31}","${cultMainList.languageInfo == null ? '-' : cultMainList.languageInfo }");
    	changeCode.put("{ctDetailFunction_32}","${cultMainList.chargePrice == null ? '-' : cultMainList.chargePrice }");
    	changeCode.put("{ctDetailFunction_33}","${cultMainList.openYear == null ? '-' : cultMainList.openYear }");
    	changeCode.put("{ctDetailFunction_34}","${cultMainList.roomCnt == null ? '-' : cultMainList.roomCnt }");
    	changeCode.put("{ctDetailFunction_35}","${cultMainList.summerPeck == null ? '-' : cultMainList.summerPeck }");
    	changeCode.put("{ctDetailFunction_36}","${cultMainList.winterPeck == null ? '-' : cultMainList.winterPeck}");
    	changeCode.put("{ctDetailFunction_37}","${cultMainList.weekPrice == null ? '-' : cultMainList.weekPrice }");
    	changeCode.put("{ctDetailFunction_38}","${cultMainList.addPeoplePrice == null ? '-' : cultMainList.addPeoplePrice }");
    	changeCode.put("{ctDetailFunction_39}","${cultMainList.seatCnt == null ? '-' : cultMainList.seatCnt }");
    	changeCode.put("{ctDetailFunction_40}","${cultMainList.fstvSupport == null ? '-' : cultMainList.fstvSupport }");
    	changeCode.put("{ctDetailFunction_41}","${cultMainList.fstvHost == null ? '-' : cultMainList.fstvHost }");
    	changeCode.put("{ctDetailFunction_42}","${cultMainList.fstvTerm == null ? '-' : cultMainList.fstvTerm }");
    	changeCode.put("{ctDetailFunction_43}","${cultMainList.fstvPlace == null ? '-' : cultMainList.fstvPlace  }");
    	changeCode.put("{ctDetailFunction_44}","${cultMainList.fstvSupervision == null ? '-' : cultMainList.fstvSupervision }");
    	changeCode.put("{ctDetailFunction_45}","${cultMainList.tourGuide == null ? '-' : cultMainList.tourGuide }");
    	changeCode.put("{ctDetailFunction_46}","${cultMainList.guideCar == null ? '-' : cultMainList.guideCar }");
    	changeCode.put("{ctDetailFunction_47}","${cultMainList.guidePublic == null ? '-' : cultMainList.guidePublic }");
    	changeCode.put("{ctDetailFunction_48}","<c:out value=\"${pageContext.request.contextPath }\" />${foodMenuList.fileUrl}");
    	changeCode.put("{ctDetailFunction_49}","${foodMenuList.foodNm == '' ? '-' : foodMenuList.foodNm }");
    	changeCode.put("{ctDetailFunction_50}","${foodMenuList.foodDiv == null ? '-' : foodMenuList.foodDiv }");
    	changeCode.put("{ctDetailFunction_51}","${foodMenuList.foodInfo == '' ? '-' : foodMenuList.foodInfo }");
    	changeCode.put("{ctDetailFunction_52}","<c:out value=\"${pageContext.request.contextPath }\" />${stayMenuList.fileUrl}");
    	changeCode.put("{ctDetailFunction_53}","${stayMenuList.stayNm == '' ? '-' : stayMenuList.stayNm }");
    	changeCode.put("{ctDetailFunction_54}","${stayMenuList.staySort == null ? '-' : stayMenuList.staySort }");
    	changeCode.put("{ctDetailFunction_55}","${stayMenuList.stayAvrpeople == '' ? '-' : stayMenuList.stayAvrpeople }");
    	changeCode.put("{ctDetailFunction_56}","${stayMenuList.stayMaxpeople == '' ? '-' : stayMenuList.stayMaxpeople }");
    	changeCode.put("{ctDetailFunction_57}","${stayMenuList.stayCnt == '' ? '-' : stayMenuList.stayCnt }");
    	changeCode.put("{ctDetailFunction_58}","${stayMenuList.stayComposition == '' ? '-' : stayMenuList.stayComposition }");
    	changeCode.put("{ctDetailFunction_59}","${stayMenuList.stayArea == '' ? '-' : stayMenuList.stayArea }");
    	changeCode.put("{ctDetailFunction_60}","${stayMenuList.stayPrice == '' ? '-' : stayMenuList.stayPrice }");
    	changeCode.put("{ctDetailFunction_61}","${stayMenuList.stayPreference == '' ? '-' : stayMenuList.stayPreference }");
    	changeCode.put("{ctDetailFunction_62}","${stayMenuList.stayFacilities == '' ? '-' : stayMenuList.stayFacilities }");
    	changeCode.put("{ctDetailFunction_63}","<c:out value=\"${pageContext.request.contextPath }\" />${shopMenuList.fileUrl}");
    	changeCode.put("{ctDetailFunction_64}","${shopMenuList.shopNm == '' ? '-' : shopMenuList.shopNm }");
    	changeCode.put("{ctDetailFunction_65}","${shopMenuList.shopPrice == '' ? '-' : shopMenuList.shopPrice }");
    	changeCode.put("{ctDetailFunction_66}","${shopMenuList.shopVolume == '' ? '-' : shopMenuList.shopVolume }");
    	changeCode.put("{ctDetailFunction_67}","${shopMenuList.shopOrtherinfo == '' ? '-' : shopMenuList.shopOrtherinfo }");
    	changeCode.put("{ctDetailFunction_68}","<c:out value=\"${pageContext.request.contextPath }\" />${fstvMenuList.fileUrl}");
    	changeCode.put("{ctDetailFunction_69}","${fstvMenuList.fstvNm == null ? '-' : fstvMenuList.fstvNm }");
    	changeCode.put("{ctDetailFunction_70}","${fstvMenuList.fstvInfo == null ? '-' : fstvMenuList.fstvInfo }");
    	changeCode.put("{ctDetailFunction_71}","<c:set var=\"cultInfoId\" value=\"${cultInfoList.cultId }\" />");
    	changeCode.put("{ctDetailFunction_72}","<c:set var=\"cultInfoTypeId\" value=\"${cultInfoList.typeId }\"/>");
    	changeCode.put("{ctDetailFunction_73}","<c:set var=\"cultInfoNm\" value=\"${cultInfoList.cultNm }\"/>");
    	changeCode.put("{ctDetailFunction_74}","<c:out value=\"${pageContext.request.contextPath }\" />${cultInfoList.fileUrl}");
    	changeCode.put("{ctDetailFunction_75}","<c:out value=\"${viewPath }\" /><c:out value=\"?mode=${mode }&cultId=${cultInfoId}&typeId=${cultInfoTypeId}\" />");
    	changeCode.put("{ctDetailFunction_76}","${lat}");
    	changeCode.put("{ctDetailFunction_77}","${lng}");
    	changeCode.put("{ctDetailFunction_78}","${cultInfoList.gridX}");
    	changeCode.put("{ctDetailFunction_79}","${cultInfoList.gridY}");


    	changeCode.put("{ctDetailCif_1}","<c:if test=\"${typeFields['cultAppoint'] == true}\">");
    	changeCode.put("{ctDetailCif_2}","<c:if test=\"${typeFields['cultYear'] == true}\">");
    	changeCode.put("{ctDetailCif_3}","<c:if test=\"${typeFields['storytelling'] == true}\">");
    	changeCode.put("{ctDetailCif_4}","<c:if test=\"${typeFields['serviceTime'] == true}\">");
    	changeCode.put("{ctDetailCif_5}","<c:if test=\"${typeFields['rsvPhone'] == true}\">");
    	changeCode.put("{ctDetailCif_6}","<c:if test=\"${typeFields['rsvInternet'] == true}\">");
    	changeCode.put("{ctDetailCif_7}","<c:if test=\"${typeFields['cardYn'] == true}\">");
    	changeCode.put("{ctDetailCif_8}","<c:if test=\"${typeFields['parkYn'] == true}\">");
    	changeCode.put("{ctDetailCif_9}","<c:if test=\"${typeFields['petYn'] == true}\">");
    	changeCode.put("{ctDetailCif_10}","<c:if test=\"${typeFields['disableYn'] == true}\">");
    	changeCode.put("{ctDetailCif_11}","<c:if test=\"${typeFields['disableInfo'] == true}\">");
    	changeCode.put("{ctDetailCif_12}","<c:if test=\"${typeFields['smokeYn'] == true}\">");
    	changeCode.put("{ctDetailCif_13}","<c:if test=\"${typeFields['toilet'] == true}\">");
    	changeCode.put("{ctDetailCif_14}","<c:if test=\"${typeFields['holiday'] == true}\">");
    	changeCode.put("{ctDetailCif_15}","<c:if test=\"${typeFields['baycarYn'] == true}\">");
    	changeCode.put("{ctDetailCif_16}","<c:if test=\"${typeFields['languageYn'] == true}\">");
    	changeCode.put("{ctDetailCif_17}","<c:if test=\"${typeFields['languageInfo'] == true}\">");
    	changeCode.put("{ctDetailCif_18}","<c:if test=\"${typeFields['TipYn'] == true}\">");
    	changeCode.put("{ctDetailCif_19}","<c:if test=\"${typeFields['chargePrice'] == true}\">");
    	changeCode.put("{ctDetailCif_20}","<c:if test=\"${typeFields['openYear'] == true}\">");
    	changeCode.put("{ctDetailCif_21}","<c:if test=\"${typeFields['roomCnt'] == true}\">");
    	changeCode.put("{ctDetailCif_22}","<c:if test=\"${typeFields['summerPeck'] == true}\">");
    	changeCode.put("{ctDetailCif_23}","<c:if test=\"${typeFields['winterPeck'] == true}\">");
    	changeCode.put("{ctDetailCif_24}","<c:if test=\"${typeFields['weekPrice'] == true}\">");
    	changeCode.put("{ctDetailCif_25}","<c:if test=\"${typeFields['addPeoplePrice'] == true}\">");
    	changeCode.put("{ctDetailCif_26}","<c:if test=\"${typeFields['stayBeakfastYn'] == true}\">");
    	changeCode.put("{ctDetailCif_27}","<c:if test=\"${typeFields['packYn'] == true}\">");
    	changeCode.put("{ctDetailCif_28}","<c:if test=\"${typeFields['companion'] == true}\">");
    	changeCode.put("{ctDetailCif_29}","<c:if test=\"${typeFields['mood'] == true}\">");
    	changeCode.put("{ctDetailCif_30}","<c:if test=\"${typeFields['seatCnt'] == true}\">");
    	changeCode.put("{ctDetailCif_31}","<c:if test=\"${typeFields['kidRoomYn'] == true}\">");
    	changeCode.put("{ctDetailCif_32}","<c:if test=\"${typeFields['fstvSupport'] == true}\">");
    	changeCode.put("{ctDetailCif_33}","<c:if test=\"${typeFields['fstvHost'] == true}\">");
    	changeCode.put("{ctDetailCif_34}","<c:if test=\"${typeFields['fstvTerm'] == true}\">");
    	changeCode.put("{ctDetailCif_35}","<c:if test=\"${typeFields['fstvPlace'] == true}\">");
    	changeCode.put("{ctDetailCif_36}","<c:if test=\"${typeFields['fstvSupervision'] == true}\">");
    	changeCode.put("{ctDetailCif_37}","<c:if test=\"${typeFields['tourGuide'] == true}\">");
    	changeCode.put("{ctDetailCif_38}","<c:if test=\"${typeFields['guideCar'] == true}\">");
    	changeCode.put("{ctDetailCif_39}","<c:if test=\"${typeFields['guidePublic'] == true}\">");
    	changeCode.put("{ctDetailCif_40}","<c:if test=\"${typeFields['noAdd'] == true}\">");
    	changeCode.put("{ctDetailCif_41}","<c:if test=\"${cultMainList.typeId != 'CULT' }\">");
    	changeCode.put("{ctDetailCif_42}","<c:if test=\"${cultMainList.typeId == 'FOOD' }\">");
    	changeCode.put("{ctDetailCif_43}","<c:if test=\"${cultMainList.typeId == 'STAY' }\">");
    	changeCode.put("{ctDetailCif_44}","<c:if test=\"${cultMainList.typeId == 'SHOP' }\">");
    	changeCode.put("{ctDetailCif_45}","<c:if test=\"${cultMainList.typeId == 'FSTV' }\">");
    	changeCode.put("{ctDetailCif_46}","<c:if test=\"${cultMainList.cardYn == 0 }\">");
    	changeCode.put("{ctDetailCif_47}","<c:if test=\"${cultMainList.cardYn == 1 }\">");
    	changeCode.put("{ctDetailCif_48}","<c:if test=\"${cultMainList.cardYn == 2 }\">");
    	changeCode.put("{ctDetailCif_49}","<c:if test=\"${cultMainList.parkYn == 0 }\">");
    	changeCode.put("{ctDetailCif_50}","<c:if test=\"${cultMainList.parkYn == 1 }\">");
    	changeCode.put("{ctDetailCif_51}","<c:if test=\"${cultMainList.parkYn == 2 }\">");
    	changeCode.put("{ctDetailCif_52}","<c:if test=\"${cultMainList.petYn == 0 }\">");
    	changeCode.put("{ctDetailCif_53}","<c:if test=\"${cultMainList.petYn == 1 }\">");
    	changeCode.put("{ctDetailCif_54}","<c:if test=\"${cultMainList.petYn == 2 }\">");
    	changeCode.put("{ctDetailCif_55}","<c:if test=\"${cultMainList.disableYn == 0 }\">");
    	changeCode.put("{ctDetailCif_56}","<c:if test=\"${cultMainList.disableYn == 1 }\">");
    	changeCode.put("{ctDetailCif_57}","<c:if test=\"${cultMainList.disableYn == 2 }\">");
    	changeCode.put("{ctDetailCif_58}","<c:if test=\"${cultMainList.smokeYn == 0 }\">");
    	changeCode.put("{ctDetailCif_59}","<c:if test=\"${cultMainList.smokeYn == 1 }\">");
    	changeCode.put("{ctDetailCif_60}","<c:if test=\"${cultMainList.smokeYn == 2 }\">");
    	changeCode.put("{ctDetailCif_61}","<c:if test=\"${cultMainList.baycarYn == 0 }\">");
    	changeCode.put("{ctDetailCif_62}","<c:if test=\"${cultMainList.baycarYn == 1 }\">");
    	changeCode.put("{ctDetailCif_63}","<c:if test=\"${cultMainList.baycarYn == 2 }\">");
    	changeCode.put("{ctDetailCif_64}","<c:if test=\"${cultMainList.languageYn == 0 }\">");
    	changeCode.put("{ctDetailCif_65}","<c:if test=\"${cultMainList.languageYn == 1 }\">");
    	changeCode.put("{ctDetailCif_66}","<c:if test=\"${cultMainList.languageYn == 2 }\">");
    	changeCode.put("{ctDetailCif_67}","<c:if test=\"${cultMainList.TipYn == 0 }\">");
    	changeCode.put("{ctDetailCif_68}","<c:if test=\"${cultMainList.TipYn == 1 }\">");
    	changeCode.put("{ctDetailCif_69}","<c:if test=\"${cultMainList.TipYn == 2 }\">");
    	changeCode.put("{ctDetailCif_70}","<c:if test=\"${cultMainList.stayBeakfastYn == 0 }\">");
    	changeCode.put("{ctDetailCif_71}","<c:if test=\"${cultMainList.stayBeakfastYn == 1 }\">");
    	changeCode.put("{ctDetailCif_72}","<c:if test=\"${cultMainList.stayBeakfastYn == 2 }\">");
    	changeCode.put("{ctDetailCif_73}","<c:if test=\"${cultMainList.packYn == 0 }\">");
    	changeCode.put("{ctDetailCif_74}","<c:if test=\"${cultMainList.packYn == 1 }\">");
    	changeCode.put("{ctDetailCif_75}","<c:if test=\"${cultMainList.packYn == 2 }\">");
    	changeCode.put("{ctDetailCif_76}","<c:if test=\"${cultMainList.companion == 0 }\">");
    	changeCode.put("{ctDetailCif_77}","<c:if test=\"${cultMainList.companion == 1 }\">");
    	changeCode.put("{ctDetailCif_78}","<c:if test=\"${cultMainList.companion == 2 }\">");
    	changeCode.put("{ctDetailCif_79}","<c:if test=\"${cultMainList.companion == 3 }\">");
    	changeCode.put("{ctDetailCif_80}","<c:if test=\"${cultMainList.companion == 4 }\">");
    	changeCode.put("{ctDetailCif_81}","<c:if test=\"${cultMainList.companion == 5 }\">");
    	changeCode.put("{ctDetailCif_82}","<c:if test=\"${cultMainList.companion == 6 }\">");
    	changeCode.put("{ctDetailCif_83}","<c:if test=\"${cultMainList.mood == 0 }\">");
    	changeCode.put("{ctDetailCif_84}","<c:if test=\"${cultMainList.mood == 1 }\">");
    	changeCode.put("{ctDetailCif_85}","<c:if test=\"${cultMainList.mood == 2 }\">");
    	changeCode.put("{ctDetailCif_86}","<c:if test=\"${cultMainList.mood == 3 }\">");
    	changeCode.put("{ctDetailCif_87}","<c:if test=\"${cultMainList.mood == 4 }\">");
    	changeCode.put("{ctDetailCif_88}","<c:if test=\"${cultMainList.mood == 5 }\">");
    	changeCode.put("{ctDetailCif_89}","<c:if test=\"${cultMainList.mood == 6 }\">");
    	changeCode.put("{ctDetailCif_90}","<c:if test=\"${cultMainList.kidRoomYn == 0 }\">");
    	changeCode.put("{ctDetailCif_91}","<c:if test=\"${cultMainList.kidRoomYn == 1 }\">");
    	changeCode.put("{ctDetailCif_92}","<c:if test=\"${cultMainList.kidRoomYn == 2 }\">");
    	changeCode.put("{ctDetailCif_93}","<c:if test=\"${foodMenuList.foodNm != null}\">");
    	changeCode.put("{ctDetailCif_94}","<c:if test=\"${foodMenuList.foodInfo != null}\">");
    	changeCode.put("{ctDetailCif_95}","<c:if test=\"${stayMenuList.stayNm != null}\">");
    	changeCode.put("{ctDetailCif_96}","<c:if test=\"${stayMenuList.stayAvrpeople != null}\">");
    	changeCode.put("{ctDetailCif_97}","<c:if test=\"${stayMenuList.stayMaxpeople != null}\">");
    	changeCode.put("{ctDetailCif_98}","<c:if test=\"${stayMenuList.stayCnt != null}\">");
    	changeCode.put("{ctDetailCif_99}","<c:if test=\"${stayMenuList.stayComposition != null}\">");
    	changeCode.put("{ctDetailCif_100}","<c:if test=\"${stayMenuList.stayArea != null}\">");
    	changeCode.put("{ctDetailCif_101}","<c:if test=\"${stayMenuList.stayPrice != null}\">");
    	changeCode.put("{ctDetailCif_102}","<c:if test=\"${stayMenuList.stayPreference != null}\">");
    	changeCode.put("{ctDetailCif_103}","<c:if test=\"${stayMenuList.stayFacilities != null}\">");
    	changeCode.put("{ctDetailCif_104}","<c:if test=\"${shopMenuList.shopNm != null}\">");
    	changeCode.put("{ctDetailCif_105}","<c:if test=\"${shopMenuList.shopPrice != null}\">");
    	changeCode.put("{ctDetailCif_106}","<c:if test=\"${shopMenuList.shopVolume != null}\">");
    	changeCode.put("{ctDetailCif_107}","<c:if test=\"${shopMenuList.shopOrtherinfo != null}\">");
    	changeCode.put("{ctDetailCif_108}","<c:if test='${fn:length(cultInfoList) <= 1 }'>");
    	changeCode.put("{ctDetailCif_109}","<c:if test='${fn:length(cultInfoList) != 1 }'>");
    	changeCode.put("{ctDetailCif_110}","${cultInfoSize<0 ? '0' : cultInfoSize }");
    	changeCode.put("{ctDetailCif_111}","${foodInfoSize<0 ? '0' : foodInfoSize  }");
    	changeCode.put("{ctDetailCif_112}","${stayInfoSize<0 ? '0' : stayInfoSize  }");
    	changeCode.put("{ctDetailCif_113}","${shopInfoSize<0 ? '0': shopInfoSize }");
    	changeCode.put("{ctDetailCif_114}","${fstvInfoSize<0 ? '0' : fstvInfoSize  }");


    	changeCode.put("{ctDetailCif_end}","</c:if>	");

    	changeCode.put("{ctDetailForeach_1}", "<c:forEach var=\"cultMainList\" items=\"${cultMainList }\" varStatus=\"status\">");
    	changeCode.put("{ctDetailForeach_2}", "<c:forEach var=\"cultList\" items=\"${cultList }\" varStatus=\"status\">");
    	changeCode.put("{ctDetailForeach_3}", "<c:forEach var=\"foodMenuList\" items=\"${foodMenuList }\">");
    	changeCode.put("{ctDetailForeach_4}", "<c:forEach var=\"stayMenuList\" items=\"${stayMenuList }\">");
    	changeCode.put("{ctDetailForeach_5}", "<c:forEach var=\"shopMenuList\" items=\"${shopMenuList }\">");
    	changeCode.put("{ctDetailForeach_6}", "<c:forEach var=\"fstvMenuList\" items=\"${fstvMenuList }\">");
    	changeCode.put("{ctDetailForeach_7}", "<c:forEach var=\"cultInfoList\" items=\"${cultInfoList }\" begin=\"1\" varStatus=\"status\">");
    	changeCode.put("{ctDetailForeach_end}", "</c:forEach>");


    	changeCode.put("{ctDetailPagenavi_1}", "<ul><ui:pagination paginationInfo = \"${cultInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_cultInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	changeCode.put("{ctDetailPagenavi_2}", "<ul><ui:pagination paginationInfo = \"${foodInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_foodInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	changeCode.put("{ctDetailPagenavi_3}", "<ul><ui:pagination paginationInfo = \"${stayInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_stayInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	changeCode.put("{ctDetailPagenavi_4}", "<ul><ui:pagination paginationInfo = \"${shopInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_shopInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	changeCode.put("{ctDetailPagenavi_5}", "<ul><ui:pagination paginationInfo = \"${fstvInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_fstvInfo\" /> <input type=\"hidden\" name=\"pageIndex\" id=\"pageIndex\" /> </ul>");
    	/********************************************************************/

    	changeCode.put("{ctViewListFunction_1}", "${typeId }");
    	changeCode.put("{ctViewListFunction_2}", "${grp }");
    	changeCode.put("{ctViewListFunction_3}", "${grp1 }");
    	changeCode.put("{ctViewListFunction_4}", "${grp2 }");
    	changeCode.put("{ctViewListFunction_5}", "${grpClass }");
    	changeCode.put("{ctViewListFunction_6}", "${grp1Class }");
    	changeCode.put("{ctViewListFunction_7}", "${grp2Class }");
    	changeCode.put("{ctViewListFunction_8}", "${searchInfo }");
    	changeCode.put("{ctViewListFunction_9}", "${mode }");
    	changeCode.put("{ctViewListFunction_10}", "<c:out value='${pageContext.request.contextPath }' />${result.fileUrl }");
    	changeCode.put("{ctViewListFunction_11}", "<c:out value='${viewPath }' /><c:out value=\"?mode=${mode }&typeId=CULT\" />");
    	changeCode.put("{ctViewListFunction_12}", "<c:out value='${viewPath }' /><c:out value=\"?mode=${mode }&typeId=FOOD\" />");
    	changeCode.put("{ctViewListFunction_13}", "<c:out value='${viewPath }' /><c:out value=\"?mode=${mode }&typeId=STAY\" />");
    	changeCode.put("{ctViewListFunction_14}", "<c:out value='${viewPath }' /><c:out value=\"?mode=${mode }&typeId=SHOP\" />");
    	changeCode.put("{ctViewListFunction_15}", "<c:out value='${viewPath }' /><c:out value=\"?mode=${mode }&typeId=FSTV\" />");

    	changeCode.put("{ctViewListFunction_17}", "<c:out value='${viewPath }' /><c:out value=\"?mode=${mode }&typeId=${typeId }&grp=${grpList.ctgrNm }&grpClass=${status.index }\" />");
    	changeCode.put("{ctViewListFunction_18}", "${grpList.ctgrNm}");

    	changeCode.put("{ctViewListFunction_19}", "<c:out value='${pageContext.request.contextPath }' /><c:out value=\"?mode=${mode }&typeId=${typeId }&grp2=${grp2List.ctgrNm }&grp1=${grp1}&grp=${grp}&grp2Class=${status.index}&grp1Class=${grp1Class}&grpClass=${grpClass}\" />");
    	changeCode.put("{ctViewListFunction_20}", "${grp2List.ctgrNm }");
    	changeCode.put("{ctViewListFunction_21}", "${typeName }");
    	changeCode.put("{ctViewListFunction_22}", "<c:out value='${viewPath }' /><c:out value=\"?mode=viewDetail&cultId=${result.cultId}&typeId=${typeId}\" />");
    	changeCode.put("{ctViewListFunction_23}", "${result.cultNm }");
    	changeCode.put("{ctViewListFunction_24}", "${result.grp }");
    	changeCode.put("{ctViewListFunction_25}", "${result.grp2 }");
    	changeCode.put("{ctViewListFunction_26}", "${result.newAddr }");
    	changeCode.put("{ctViewListFunction_27}", "<ui:pagination paginationInfo = \"${paginationInfo}\" type=\"jnitDefault\" jsFunction=\"fn_egov_link_page\" />");
    	changeCode.put("{ctViewListFunction_28}", "${searchInfo}");

    	changeCode.put("{ctViewListFunction_32}", "<c:set var=\"typeName\" value=\"관광지\"/>");
    	changeCode.put("{ctViewListFunction_33}", "<c:set var=\"typeName\" value=\"음식점\"/>");
    	changeCode.put("{ctViewListFunction_34}", "<c:set var=\"typeName\" value=\"숙박\"/>");
    	changeCode.put("{ctViewListFunction_35}", "<c:set var=\"typeName\" value=\"쇼핑\"/>");
    	changeCode.put("{ctViewListFunction_36}", "<c:set var=\"typeName\" value=\"축제\"/>");

    	changeCode.put("{ctViewListCif_1}", "<c:if test=\"${typeId == 'CULT'}\">");
    	changeCode.put("{ctViewListCif_2}", "<c:if test=\"${typeId == 'FOOD'}\">");
    	changeCode.put("{ctViewListCif_3}", "<c:if test=\"${typeId == 'STAY'}\">");
    	changeCode.put("{ctViewListCif_4}", "<c:if test=\"${typeId == 'SHOP'}\">");
    	changeCode.put("{ctViewListCif_5}", "<c:if test=\"${typeId == 'FSTV'}\">");

    	changeCode.put("{ctViewListCif_End}", "</c:if>");

    	changeCode.put("{ctViewListForeach_1}", "<c:forEach var=\"grpList\" items=\"${grpList }\" varStatus=\"status\">");
    	changeCode.put("{ctViewListForeach_2}", "<c:forEach var=\"grp2List\" items=\"${grp2List }\" varStatus=\"status\">");
    	changeCode.put("{ctViewListForeach_3}", "<c:forEach var=\"result\" items=\"${resultList }\">");
    	//changeCode.put("{ctViewListForeach_4}", "<c:forEach var="grp1List" items="${grp1List }" varStatus="status">");

    	changeCode.put("{ctViewListForeach_End}","</c:forEach>");

    	/*******************************************************************/
    	changeCode.put("{rechResponUrl_1}", "<c:url value=\"/resources/css/jnit.css\"/>");
    	changeCode.put("{rechResponUrl_2}", "<c:url value=\"/resources/css/select.css\"/>");
    	changeCode.put("{rechResponUrl_3}", "<c:url value=\"/resources/css/color_picker.css\"/>");
    	changeCode.put("{rechResponUrl_4}", "<c:url value=\"/resources/css/date_picker.css\"/>");
    	changeCode.put("{rechResponUrl_5}", "<c:url value=\"/resources/js/jquery.min.js\"/>");
    	changeCode.put("{rechResponFunction_1}", "${researchId}");
    	changeCode.put("{rechResponFunction_2}", "<c:out value=\"${jnitresearchVO.researchNm}\"/>");
    	changeCode.put("{rechResponFunction_3}", "${jnitresearchVO.introduce}");
    	changeCode.put("{rechResponFunction_4}", "<c:set var=\"Qnum\" value=\"0\" />");
    	changeCode.put("{rechResponFunction_5}", "<c:set var=\"Anum\" value=\"0\" />");
    	changeCode.put("{rechResponFunction_6}", "<c:set var=\"radioNum\" value=\"0\" />");
    	changeCode.put("{rechResponFunction_7}", "<c:set var=\"Qnum\" value=\"${Qnum +1}\" />");
    	changeCode.put("{rechResponFunction_8}", "${Qnum}");
    	changeCode.put("{rechResponFunction_9}", "<c:out value=\"${queResult.questionNm}\"/>");
    	changeCode.put("{rechResponFunction_10}", "<c:url value=\"${queResult.fileUrl}\"/>");
    	changeCode.put("{rechResponFunction_11}", "<c:set var=\"radioNum\" value=\"${radioNum +1}\" />");
    	changeCode.put("{rechResponFunction_12}", "${Anum}");
    	changeCode.put("{rechResponFunction_13}", "${queResult.questionId}");
    	changeCode.put("{rechResponFunction_14}", "${ansResult.answerId}");
    	changeCode.put("{rechResponFunction_15}", "${queResult.type}");
    	changeCode.put("{rechResponFunction_16}", "${radioNum}");
    	changeCode.put("{rechResponFunction_17}", "<c:out value=\"onclick=javascript:fnCheck('${orderAnswerId}');\"/>");
    	changeCode.put("{rechResponFunction_18}", "<c:out value=\"${ansResult.answerNm}\"/>");
    	changeCode.put("{rechResponFunction_19}", "<c:set var=\"orderAnswerId\" value=\"${ansResult.answerId}\" />");
    	changeCode.put("{rechResponFunction_20}", "${orderAnswerId}");
    	changeCode.put("{rechResponFunction_21}", "<c:out value='${searchVO.searchCondition}'/>");
    	changeCode.put("{rechResponFunction_22}", "<c:out value='${searchVO.searchKeyword}'/>");
    	changeCode.put("{rechResponFunction_23}", "<c:out value='${searchVO.pageIndex}'/>");
    	changeCode.put("{rechResponFunction_24}", "<c:url value=\"${ansResult.fileUrl}\"/>");
    	changeCode.put("{rechResponFunction_25}", "<c:set var=\"Anum\" value=\"${Anum +1}\" />");
    	changeCode.put("{rechResponFunction_26}", "<c:set var=\"orderAnswerId\" value=\"${ansResult.answerId}\" />");
    	changeCode.put("{rechResponFunction_27}", "<c:url value=\"${ansResult.fileUrl}\"/>");
    	changeCode.put("{rechResponFunction_28}", "<c:set var=\"AnswerCtAll\" value=\"0\" />");
    	changeCode.put("{rechResponFunction_29}", "<c:set var=\"AnswerCtAll\" value=\"${AnswerCtAll + answerCount[ansResult.answerId]}\" />");
    	changeCode.put("{rechResponFunction_30}", "${jnitresearchVO.entry - AnswerCtAll}");
    	changeCode.put("{rechResponFunction_31}", "${respondPath}");

    	changeCode.put("{rechResponCif_1}", "<c:if test=\"${queResult.fileUrl != null && queResult.fileUrl != ''}\">");
    	changeCode.put("{rechResponCif_2}", "<c:if test='${queResult.type == 0}'>");
    	changeCode.put("{rechResponCif_3}", "<c:if test='${fn:length(ansListResult) != 0 }'>");
    	changeCode.put("{rechResponCif_4}", "<c:if test='${queResult.questionId == ansResult.questionId }'>");
    	changeCode.put("{rechResponCif_5}", "<c:if test='${ansResult.type != 9}'>");
    	changeCode.put("{rechResponCif_6}", "<c:set var=\"Anum\" value=\"${Anum +1}\" />");
    	changeCode.put("{rechResponCif_7}", "<c:set var=\"orderAnswerId\" value=\"${ansResult.answerId}\" />");
    	changeCode.put("{rechResponCif_8}", "<c:if test=\"${ansResult.fileUrl != null && ansResult.fileUrl != ''}\">");
    	changeCode.put("{rechResponCif_9}", "<c:url value=\"${ansResult.fileUrl}\"/>");
    	changeCode.put("{rechResponCif_10}", "<c:if test='${queResult.ordercheck == 1}'>");
    	changeCode.put("{rechResponCif_11}", "<c:if test='${ansResult.type == 9}'>");
    	changeCode.put("{rechResponCif_12}", " <c:if test='${queResult.type == 1}'>");
    	changeCode.put("{rechResponCif_13}", "<c:if test='${fn:length(ansListResult) != 0 }'>");
    	changeCode.put("{rechResponCif_14}", "<c:if test='${queResult.type == 2}'>");
    	changeCode.put("{rechResponCif_15}", "<c:if test='${queResult.type != 2}'>");

    	changeCode.put("{rechResponCifEnd}", "</c:if>");
    	changeCode.put("{rechResponCif_1_End}", "</c:if>");
    	changeCode.put("{rechResponCif_2_End}", "</c:if>");
    	changeCode.put("{rechResponCif_3_End}", "</c:if>");
    	changeCode.put("{rechResponCif_4_End}", "</c:if>");
    	changeCode.put("{rechResponCif_5_End}", "</c:if>");
    	changeCode.put("{rechResponCif_6_End}", "</c:if>");
    	changeCode.put("{rechResponCif_7_End}", "</c:if>");
    	changeCode.put("{rechResponCif_8_End}", "</c:if>");
    	changeCode.put("{rechResponCif_9_End}", "</c:if>");
    	changeCode.put("{rechResponCif_10_End}", "</c:if>");
    	changeCode.put("{rechResponCif_11_End}", "</c:if>");
    	changeCode.put("{rechResponCif_12_End}", "</c:if>");
    	changeCode.put("{rechResponCif_13_End}", "</c:if>");
    	changeCode.put("{rechResponCif_14_End}", "</c:if>");


    	changeCode.put("{rechResponForeach_1}", "<c:forEach var=\"queResult\" items=\"${queListResult}\" varStatus=\"status\">");
    	changeCode.put("{rechResponForeach_2}", "<c:forEach var=\"ansResult\" items=\"${ansListResult}\" varStatus=\"status\"> ");

    	changeCode.put("{rechResponForeachEnd}", "</c:forEach>");
    	changeCode.put("{rechResponForeach_1_End}", "</c:forEach>");
    	changeCode.put("{rechResponForeach_2_End}", "</c:forEach>");

    	/**************************************************************/
    	changeCode.put("{rechStatFunction_1}","<c:url value=\"/resources/js/jquery.min.js\"/>");
    	changeCode.put("{rechStatFunction_2}","<c:url value='/answer/popup.do?answerId=\"+answerId+\"'/>");
    	changeCode.put("{rechStatFunction_3}","<c:set var=\"AnswerCt\" value=\"1\" />");
    	changeCode.put("{rechStatFunction_4}","<c:set var=\"Qnum\" value=\"0\" />");
    	changeCode.put("{rechStatFunction_5}","<c:set var=\"CountNum\" value=\"0\" />");
    	changeCode.put("{rechStatFunction_6}","<c:set var=\"Qnum\" value=\"${Qnum +1}\" />");
    	changeCode.put("{rechStatFunction_7}","<c:out value=\"${queResult.questionNm}\"/>");
    	changeCode.put("{rechStatFunction_8}","<c:url value=\"${queResult.fileUrl}\"/>");
    	changeCode.put("{rechStatFunction_9}","<c:set var=\"Anum\" value=\"${Anum +1}\" />");
    	changeCode.put("{rechStatFunction_10}","<c:set var=\"AnsId\" value=\"${ansResult.answerId}\"/>");
    	changeCode.put("{rechStatFunction_11}","${answerCount[ansResult.answerId]} / ${jnitresearchVO.entry}");
    	changeCode.put("{rechStatFunction_12}","<c:set var=\"AnswerCt\" value=\"${AnswerCt +1}\" />");
    	changeCode.put("{rechStatFunction_13}","<c:set var=\"CountNum\" value=\"${CountNum +1}\" />");
    	changeCode.put("{rechStatFunction_14}","<c:out value='${searchVO.searchCondition}'/>");
    	changeCode.put("{rechStatFunction_15}","<c:out value='${searchVO.searchKeyword}'/>");
    	changeCode.put("{rechStatFunction_16}","<c:out value='${searchVO.pageIndex}'/>");
    	changeCode.put("{rechStatFunction_17}","${100 * (answerCount[ansResult.answerId] / jnitresearchVO.entry)}");

    	changeCode.put("{rechStatCif_1}","<c:if test='${fn:length(queListResult) != 0 }'>");
    	changeCode.put("{rechStatCif_2}","<c:if test=\"${queResult.fileUrl != null && queResult.fileUrl != ''}\">");
    	changeCode.put("{rechStatCif_3}","<c:if test='${ansResult.type != 2}'>");
    	changeCode.put("{rechStatCif_4}","<c:if test=\"${empty resultList }\" >");
    	changeCode.put("{rechStatCif_5}","<c:if test=\"${!empty resultList }\" >");
    	changeCode.put("{rechStatCif_6}","<c:if test=\"${queResult.type == 0}\">");
    	changeCode.put("{rechStatCif_1_End}", "</c:if>");
    	changeCode.put("{rechStatCif_2_End}", "</c:if>");
    	changeCode.put("{rechStatCif_3_End}", "</c:if>");
    	changeCode.put("{rechStatCif_4_End}", "</c:if>");
    	changeCode.put("{rechStatCif_5_End}", "</c:if>");
    	changeCode.put("{rechStatCif_6_End}", "</c:if>");
    	changeCode.put("{rechStatForeach_1}"," <c:forEach var=\"queResult\" items=\"${queListResult}\" varStatus=\"status\">");
    	changeCode.put("{rechStatForeach_1_End}", "</c:forEach>");

    	/********************************************************************/
    	changeCode.put("{rechListFunction_1}", "<c:set var =\"today\" value = \"<%=new Date()%>\" />");
    	changeCode.put("{rechListFunction_2}", "<c:set var=\"cnt\" value=\"${empty cnt ? paginationInfo.totalRecordCount : cnt}\"/>");
    	changeCode.put("{rechListFunction_3}", "<c:out value=\"${result.researchNm}\"/>");
    	changeCode.put("{rechListFunction_4}", "<c:out value=\"${result.researchId}\"/>");
    	changeCode.put("{rechListFunction_5}", "<fmt:formatDate value=\"${result.starttime}\" pattern=\"yyyy-MM-dd\"/>"); //<c:out value=\"${result.starttime}\"/>
    	changeCode.put("{rechListFunction_6}", "<fmt:formatDate value=\"${result.endtime}\" pattern=\"yyyy-MM-dd\"/>");//<c:out value=\"${result.endtime}\"/>
    	changeCode.put("{rechListFunction_7}", "<c:out value=\"${result.entry}\"/>");
    	changeCode.put("{rechListFunction_8}", "<c:set var =\"cnt\" value = \"${cnt -1}\" />");
    	changeCode.put("{rechListFunction_9}", "${cnt}");
    	changeCode.put("{rechListFunction_10}", "${statsPath}");
    	changeCode.put("{rechListFunction_11}", "${entryPath}");
    	changeCode.put("{rechListFunction_12}", "${recontentPath}");
    	changeCode.put("{rechListFunction_13}", "<div class=\"span3 listbtn\"><a class=\"btn\" href=\"/cms/research/List.do\">등록</a></div>");
    	changeCode.put("{rechListFunction_14}", "<c:set var=\"firstNum\" value=\"0\" />");
    	changeCode.put("{rechListFunction_15}", "<c:set var=\"firstNum\" value=\"${firstNum + 1}\" />");
    	changeCode.put("{rechListFunction_16}", "${firstNum == 1 ? 'checked=\"checked\"' : ''}");

    	changeCode.put("{rechListCif_1}", "<c:if test = \"${(result.state == 0) && (today < result.starttime)}\">");
    	changeCode.put("{rechListCif_2}", "<c:if test = \"${(result.state == 0) && (today > result.starttime) && (result.endtime > today)}\">");
    	changeCode.put("{rechListCif_3}", "<c:if test = \"${(result.state == 0) && (result.endtime < today)}\">");
    	changeCode.put("{rechListCif_4}", "<c:if test = \"${result.state == 1}\">");
    	changeCode.put("{rechListCif_5}", "<c:if test = \"${result.block == 0}\">");
    	changeCode.put("{rechListCif_6}", "<c:if test = \"${result.block == 1}\">");
    	changeCode.put("{rechListCif_7}", "<c:if test = \"${admin == 'true'}\">");
    	changeCode.put("{rechListCifEnd}","</c:if>");

    	changeCode.put("{rechListForeach_1}", "<c:forEach var=\"result\" items=\"${resultList}\" varStatus=\"status\">");
    	changeCode.put("{rechListForeachEnd}","</c:forEach>");

    	changeCode.put("{rechListPaginavi}","<div class=\"span6 offset3\"> <ui:pagination paginationInfo = \"${paginationInfo}\"   type=\"jnitDefault\"   jsFunction=\"fn_egov_link_page\"   /> </div>");
    	/********************************************************/
    	changeCode.put("{rechImportCif1}","<c:if test=\"${not empty error}\">");
    	changeCode.put("{rechImportCifEnd1}", "</c:if>");
    	changeCode.put("{rechImportFunction1}", "<%=request.getRequestURI()%>");
    	changeCode.put("{rechImportFunction2}", "${page}");
    	changeCode.put("{rechImportFunction3}", "<c:out value=\"${error}\"/>");

    	changeCode.put("{rechPageIdx}","<input type=\"hidden\" name=\"searchCondition\" value=\"<c:out value='${searchVO.searchCondition}'/>\"/><input type=\"hidden\" name=\"searchKeyword\" value=\"<c:out value='${searchVO.searchKeyword}'/>\"/> <input type=\"hidden\" name=\"pageIndex\" value=\"<c:out value='${searchVO.pageIndex}'/>\"/>  ");
    	/************************************************************/

    	//changeCode.put("{leftMenuFunction_1}", "<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>");
    	changeCode.put("{leftMenuFunction_2}", "<%@ include file='/_common/header.jsp' %>");
    	changeCode.put("{leftMenuFunction_3}", "<% { %>");
    	changeCode.put("{leftMenuFunction_4}", "${menu.title}");
    	changeCode.put("{leftMenuFunction_5}", "<fmt:formatNumber pattern=\"00\" value=\"${status2.index+1}\"  />");
    	changeCode.put("{leftMenuFunction_6}", "<c:out value=\"${child.over}\" />");
    	changeCode.put("{leftMenuFunction_7}", "<c:url value=\"${child.link}${!empty child.defaultmenu ? '/' : ''}${child.defaultmenu}\"/>");
    	changeCode.put("{leftMenuFunction_8}", "${child.title}");
    	changeCode.put("{leftMenuFunction_9}", "<c:url value=\"${child.exlink}\"/>");
    	changeCode.put("{leftMenuFunction_10}", "${child.extgt == 'self' ? '_self' : '_blank'}");


    	changeCode.put("{leftMenuFunction_11}", "${child.extgt}");
    	changeCode.put("{leftMenuFunction_12}", "<fmt:formatNumber pattern=\"00\" value=\"${status2.index+1}\"  />");
    	changeCode.put("{leftMenuFunction_13}", "<fmt:formatNumber pattern=\"00\" value=\"${status3.index+1}\"  /><fmt:formatNumber pattern=\"00\" value=\"${status3.index+1}\"  />");
    	changeCode.put("{leftMenuFunction_14}", "<c:out value=\"${child2.over}\" />");
    	changeCode.put("{leftMenuFunction_15}", "<c:url value=\"${child2.link}${!empty child2.defaultmenu ? '/' : ''}${child2.defaultmenu}\"/>");
    	changeCode.put("{leftMenuFunction_16}", "${child2.title}");
    	changeCode.put("{leftMenuFunction_17}", "<c:url value=\"${child2.exlink}\"/>");
    	changeCode.put("{leftMenuFunction_18}", "${child2.extgt == 'self' ? '_self' : '_blank'}");
    	changeCode.put("{leftMenuFunction_19}", "${child2.extgt}");
    	changeCode.put("{leftMenuFunction_20}", "<fmt:formatNumber pattern=\"00\" value=\"${status3.index+1}\"  />");
    	changeCode.put("{leftMenuFunction_21}", "<fmt:formatNumber pattern=\"00\" value=\"${status4.index+1}\"  /><fmt:formatNumber pattern=\"00\" value=\"${status4.index+1}\"  />");
    	changeCode.put("{leftMenuFunction_22}", "<c:out value=\"${child3.over}\" />");
    	changeCode.put("{leftMenuFunction_23}", "<c:url value=\"${child3.link}${!empty child3.defaultmenu ? '/' : ''}${child3.defaultmenu}\"/>");
    	changeCode.put("{leftMenuFunction_24}", "${child3.title}");
    	changeCode.put("{leftMenuFunction_25}", "<c:url value=\"${child3.exlink}\"/>");
    	changeCode.put("{leftMenuFunction_26}", "${child3.extgt == 'self' ? '_self' : '_blank'}");
    	changeCode.put("{leftMenuFunction_27}", "${child3.extgt}");
    	changeCode.put("{leftMenuFunction_28}", "<fmt:formatNumber pattern=\"00\" value=\"${status4.index+1}\"  />");

    	changeCode.put("{leftMenuFunction_30}", "<fmt:formatNumber pattern=\"00\" value=\"${status5.index+1}\"  /><fmt:formatNumber pattern=\"00\" value=\"${status5.index+1}\"  />");
    	changeCode.put("{leftMenuFunction_31}", "<c:out value=\"${child4.over}\" />");
    	changeCode.put("{leftMenuFunction_32}", "<c:url value=\"${child4.link}${!empty child4.defaultmenu ? '/' : ''}${child4.defaultmenu}\"/>");
    	changeCode.put("{leftMenuFunction_33}", "${child4.title}");
    	changeCode.put("{leftMenuFunction_34}", "<c:url value=\"${child4.exlink}\"/>");
    	changeCode.put("{leftMenuFunction_35}", "${child3.extgt == 'self' ? '_self' : '_blank'}");
    	changeCode.put("{leftMenuFunction_36}", "${child4.extgt}");
    	changeCode.put("{leftMenuFunction_37}", "<c:url value=\"/js/jquery-1.8.2.min.js\"/>");
    	changeCode.put("{leftMenuFunction_38}", "<% } %>");

    	changeCode.put("{leftMenuFunction_39}", "<fmt:formatNumber pattern=\"00\" value=\"${status4.index+1}\"  />");
    	changeCode.put("{leftMenuFunction_40}", "<fmt:formatNumber pattern=\"00\" value=\"${status6.index+1}\"  /><fmt:formatNumber pattern=\"00\" value=\"${status6.index+1}\"  />");
    	changeCode.put("{leftMenuFunction_41}", "<c:out value=\"${child5.over}\" />");
    	changeCode.put("{leftMenuFunction_42}", "<c:url value=\"${child5.link}${!empty child5.defaultmenu ? '/' : ''}${child5.defaultmenu}\"/>");
    	changeCode.put("{leftMenuFunction_43}", "${child5.title}");
    	changeCode.put("{leftMenuFunction_44}", "<c:url value=\"${child5.exlink}\"/>");
    	changeCode.put("{leftMenuFunction_45}", "${child3.extgt == 'self' ? '_self' : '_blank'}");
    	changeCode.put("{leftMenuFunction_46}", "${child5.extgt}");
    	changeCode.put("{leftMenuFunction_47}", "${pageNavTitle}");
    	changeCode.put("{leftMenuFunction_48}", "${pageLinkNav}");
    	changeCode.put("{leftMenuFunction_49}", "${msg}");

    	changeCode.put("{leftMenuForeach_1}","<c:forEach var=\"menu\" items=\"${menuTree}\" varStatus=\"status\">");
    	changeCode.put("{leftMenuForeach_2}","<c:forEach var=\"child\" items=\"${menu.childTree}\" varStatus=\"status2\">");
    	changeCode.put("{leftMenuForeach_3}","<c:forEach var=\"child2\" items=\"${child.childTree}\" varStatus=\"status3\">");
    	changeCode.put("{leftMenuForeach_4}","<c:forEach var=\"child3\" items=\"${child2.childTree}\" varStatus=\"status4\">");
    	changeCode.put("{leftMenuForeach_5}","<c:forEach var=\"child4\" items=\"${child3.childTree}\" varStatus=\"status5\">");
    	changeCode.put("{leftMenuForeach_6}","<c:forEach var=\"child5\" items=\"${child4.childTree}\" varStatus=\"status6\">");

    	changeCode.put("{leftMenuCif_1}", "<c:if test=\"${menu.childCount > 0}\">");
    	changeCode.put("{leftMenuCif_2}", "<c:if test=\"${child.isexlink == 0}\">");
    	changeCode.put("{leftMenuCif_3}", "<c:if test=\"${child.isexlink == 1}\">");
    	changeCode.put("{leftMenuCif_4}", "<c:if test=\"${child.extgt != 'self'}\">");
    	changeCode.put("{leftMenuCif_5}", "<c:if test=\"${child.over == 'on' && child.childCount > 0}\">");
    	changeCode.put("{leftMenuCif_6}", "<c:if test=\"${child2.isexlink == 0}\">");
    	changeCode.put("{leftMenuCif_7}", "<c:if test=\"${child2.isexlink == 1}\">");
    	changeCode.put("{leftMenuCif_8}", "<c:if test=\"${child2.extgt != 'self'}\">");
    	changeCode.put("{leftMenuCif_9}", "<c:if test=\"${child2.over == 'on' && child2.childCount > 0}\">");
    	changeCode.put("{leftMenuCif_10}", "<c:if test=\"${child3.isexlink == 0}\">");
    	changeCode.put("{leftMenuCif_11}", "<c:if test=\"${child3.isexlink == 1}\">");
    	changeCode.put("{leftMenuCif_12}", "<c:if test=\"${child3.extgt != 'self'}\">");
    	changeCode.put("{leftMenuCif_13}", "<c:if test=\"${child3.over == 'on' && child3.childCount > 0}\">");
    	changeCode.put("{leftMenuCif_14}", "<c:if test=\"${child4.isexlink == 0}\">");
    	changeCode.put("{leftMenuCif_15}", "<c:if test=\"${child4.isexlink == 1}\">");
    	changeCode.put("{leftMenuCif_16}", "<c:if test=\"${!empty param.embedJquery}\">");
    	changeCode.put("{leftMenuCif_17}", "<c:if test=\"${child4.extgt != 'self'}\">");
    	changeCode.put("{leftMenuCif_18}", "<c:if test=\"${child4.over == 'on' && child4.childCount > 0}\">");
    	changeCode.put("{leftMenuCif_19}", "<c:if test=\"${child5.isexlink == 0}\">");
    	changeCode.put("{leftMenuCif_20}", "<c:if test=\"${child5.isexlink == 1}\">");
    	changeCode.put("{leftMenuCif_21}", "<c:if test=\"${child5.extgt != 'self'}\">");
    	changeCode.put("{leftMenuCif_22}", "<c:if test='${!empty pageNavTitle}'>");
    	changeCode.put("{leftMenuCif_23}", "<c:if test='${!empty pageLinkNav}'>");
    	changeCode.put("{leftMenuCif_24}", "<c:if test=\"${!empty msg}\">");

    	changeCode.put("{leftMenuForeachEnd}","</c:forEach>");
    	changeCode.put("{leftMenuCifEnd}","</c:if>");

    	/****************************************************************************************************/
    	changeCode.put("{contentFunction1}","<%");
    	changeCode.put("{contentFunction2}","%>");
    	changeCode.put("{contentFunction3}","<c:set var=\"admNm2\" value=\"<%=amdNm2 %>\" />");
    	changeCode.put("{contentFunction4}","<c:set var=\"admTel2\" value=\"<%=amdTel2 %>\" />");
    	changeCode.put("{contentFunction5}","<c:set var=\"admNm\" value=\"<%=amdNm %>\" />");
    	changeCode.put("{contentFunction6}","<c:set var=\"admTel\" value=\"<%=amdTel %>\" />");
    	changeCode.put("{contentFunction7}","${admNm2}");
    	changeCode.put("{contentFunction8}","${admTel2}");
    	changeCode.put("{contentFunction9}","${admNm}");
    	changeCode.put("{contentFunction10}","${admTel}");
    	changeCode.put("{contentFunction11}","<% if(!CmsServletPathProperty.isTpl(servletPath)){ %>");
    	changeCode.put("{contentFunction12}","<% } %>");
    	changeCode.put("{contentFunction13}","<c:set var=\"cntModified\" value=\"<%=cntModified%>\" />");
    	changeCode.put("{contentFunction14}","${cntModified }");

    	changeCode.put("{contentCifFunction1}","<c:if test=\"${!empty admNm2}\">");
    	changeCode.put("{contentCifFunction2}","<c:if test=\"${empty admNm2}\">");
    	changeCode.put("{contentCifFunction3}","<c:if test=\"${empty admTel2}\">");
    	changeCode.put("{contentCifFunction4}","<c:if test=\"${empty admNm}\">");
    	changeCode.put("{contentCifFunction5}","<c:if test=\"${empty admTel}\">");
    	changeCode.put("{contentCifFunction6}","<c:if test=\"${!empty cntModified }\" >");


    	changeCode.put("{contentCifEnd1}","</c:if>");
    	changeCode.put("{contentCifEnd2}","</c:if>");
    	changeCode.put("{contentCifEnd3}","</c:if>");
    	changeCode.put("{contentCifEnd4}","</c:if>");
    	changeCode.put("{contentCifEnd5}","</c:if>");
    	changeCode.put("{contentCifEnd6}","</c:if>");
    	/***********************************************************/
    	changeCode.put("{upBtnFunction1}","<%");
    	changeCode.put("{upBtnFunction2}","%>");
    	changeCode.put("{upBtnFunction3}","<c:set var=\"cntCntId\" value=\"<%= cntId %>\"/>");
    	changeCode.put("{upBtnFunction4}","<c:set var=\"cntSiteId\" value=\"<%= siteId %>\"/>");
    	changeCode.put("{upBtnFunction5}","<c:url value=\"/cms/sub11/0101upview.do?cntId=${cntCntId}&siteId=${cntSiteId}\"/>");
    	changeCode.put("{upBtnFunction6}","<% if(!CmsServletPathProperty.isTpl(servletPath)){ %>");
    	changeCode.put("{upBtnFunction7}","<% } %>");
    	changeCode.put("{upBtnFunction8}","<% if(language1MenuId != \"\"){ %>");
    	changeCode.put("{upBtnFunction9}","<% } %>");
    	changeCode.put("{upBtnFunction10}","<c:set var=\"thisMenuId\" value=\"<%= thisMenuId %>\"/>");
    	changeCode.put("{upBtnFunction11}","<c:set var=\"language1MenuId\" value=\"<%= language1MenuId %>\"/>");
    	changeCode.put("{upBtnFunction12}","<c:set var=\"language2MenuId\" value=\"<%= language2MenuId %>\"/>");
    	changeCode.put("{upBtnFunction13}","<c:set var=\"language3MenuId\" value=\"<%= language3MenuId %>\"/>");
    	changeCode.put("{upBtnFunction14}","<c:set var=\"language4MenuId\" value=\"<%= language4MenuId %>\"/>");
    	changeCode.put("{upBtnFunction15}","<c:set var=\"language5MenuId\" value=\"<%= language5MenuId %>\"/>");
    	changeCode.put("{upBtnFunction16}","<c:url value='/cms/language/compareView.do' />?thisMenuId=${thisMenuId}&language1=${language1MenuId}&language2=${language2MenuId}&language3=${language3MenuId}&language4=${language4MenuId}&language5=${language5MenuId}");

    	changeCode.put("{upBtnCifFunction1}","<c:if test=\"${login.typeVO.typeLv == 'A' || (admId == login.mbrId) || (admId2 == login.mbrId) && login.mbrId != null && !empty admId && !empty admId2 }\">");
    	changeCode.put("{upBtnCifEnd1}","</c:if>");

    	/***********************************************************/
    	changeCode.put("{sitemapFunction1}", "<c:url value=\"${menu.link}\"/>");
    	changeCode.put("{sitemapFunction2}", "${menu.title}");
    	changeCode.put("{sitemapFunction3}", "<c:url value=\"${child.link}${!empty child.defaultmenu ? '/' : ''}${child.defaultmenu}\"/>");
    	changeCode.put("{sitemapFunction4}", "${child.title}");
    	changeCode.put("{sitemapFunction5}", "${child.extgt == 'self' ? '_self' : '_blank'}");
    	changeCode.put("{sitemapFunction6}", "${child.extgt}");
    	changeCode.put("{sitemapFunction7}", "${child.title}");
    	changeCode.put("{sitemapFunction8}", "<c:url value=\"${child.exlink}\"/>");
    	changeCode.put("{sitemapFunction9}", "<c:url value=\"${child2.link}${!empty child2.defaultmenu ? '/' : ''}${child2.defaultmenu}\"/>");
    	changeCode.put("{sitemapFunction10}", "${child2.title}");
    	changeCode.put("{sitemapFunction11}", "<c:url value=\"${child2.exlink}\"/>");
    	changeCode.put("{sitemapFunction12}", "${child2.extgt == 'self' ? '_self' : '_blank'}");
    	changeCode.put("{sitemapFunction13}", "${child2.extgt}");
    	changeCode.put("{sitemapFunction14}", "<c:url value=\"${child3.link}${!empty child3.defaultmenu ? '/' : ''}${child3.defaultmenu}\"/>");
    	changeCode.put("{sitemapFunction15}", "${child3.title}");
    	changeCode.put("{sitemapFunction16}", "${child3.extgt == 'self' ? '_self' : '_blank'}");
    	changeCode.put("{sitemapFunction17}", "${child3.extgt}");
    	changeCode.put("{sitemapFunction18}", "<c:url value=\"${child4.link}${!empty child4.defaultmenu ? '/' : ''}${child4.defaultmenu}\"/>");
    	changeCode.put("{sitemapFunction19}", "${child4.title}");
    	changeCode.put("{sitemapFunction20}", "<c:url value=\"${child4.exlink}\"/>");
    	changeCode.put("{sitemapFunction21}", "${child4.extgt == 'self' ? '_self' : '_blank'}");
    	changeCode.put("{sitemapFunction22}", "${child4.extgt}");
    	changeCode.put("{sitemapFunction23}", "${msg}");
    	changeCode.put("{sitemapFunction24}", "${status.count}");
    	changeCode.put("{sitemapFunction25}", "${status2.count}");
    	changeCode.put("{sitemapFunction26}", "${status3.count}");
    	changeCode.put("{sitemapFunction27}", "${status4.count}");
    	changeCode.put("{sitemapFunction28}", "${status5.count}");



    	changeCode.put("{sitemapCifFunction1}", "<c:if test=\"${menu.childCount > 0}\">");
    	changeCode.put("{sitemapCifFunction2}", "<c:if test=\"${not empty child}\">");
    	changeCode.put("{sitemapCifFunction3}", "<c:if test=\"${child.isexlink == 0}\">");
    	changeCode.put("{sitemapCifFunction4}", "<c:if test=\"${child.isexlink == 1}\">");
    	changeCode.put("{sitemapCifFunction5}", "<c:if test=\"${child.extgt != 'self'}\">");
    	changeCode.put("{sitemapCifFunction6}", "<c:if test=\"${child.childCount > 0}\">");
    	changeCode.put("{sitemapCifFunction7}", "<c:if test=\"${not empty child2}\">");
    	changeCode.put("{sitemapCifFunction8}", "<c:if test=\"${child2.isexlink == 0}\">");
    	changeCode.put("{sitemapCifFunction9}", "<c:if test=\"${child2.isexlink == 1}\">");
    	changeCode.put("{sitemapCifFunction10}", "<c:if test=\"${child2.extgt != 'self'}\">");
    	changeCode.put("{sitemapCifFunction11}", "<c:if test=\"${child2.childCount > 0}\">");
    	changeCode.put("{sitemapCifFunction12}", "<c:if test=\"${not empty child3}\">");
    	changeCode.put("{sitemapCifFunction13}", "<c:if test=\"${child3.isexlink == 0}\">");
    	changeCode.put("{sitemapCifFunction14}", "<c:if test=\"${child3.isexlink == 1}\">");
    	changeCode.put("{sitemapCifFunction15}", "<c:url value=\"${child3.exlink}\"/>");
    	changeCode.put("{sitemapCifFunction16}", "<c:if test=\"${child3.extgt != 'self'}\">");
    	changeCode.put("{sitemapCifFunction17}", "<c:if test=\"${child3.childCount > 0}\">");
    	changeCode.put("{sitemapCifFunction18}", "<c:if test=\"${not empty child4}\">");
    	changeCode.put("{sitemapCifFunction19}", " <c:if test=\"${child4.isexlink == 0}\">");
    	changeCode.put("{sitemapCifFunction20}", "<c:if test=\"${child4.isexlink == 1}\">");
    	changeCode.put("{sitemapCifFunction21}", "<c:if test=\"${child4.extgt != 'self'}\">");
    	changeCode.put("{sitemapCifFunction22}", "<c:if test=\"${!empty msg }\">");


    	changeCode.put("{sitemapForeach1}", "<c:forEach var=\"menu\" items=\"${menuTree}\" varStatus=\"status\">");
    	changeCode.put("{sitemapForeach2}", "<c:forEach var=\"child\" items=\"${menu.childTree}\" varStatus=\"status2\">");
    	changeCode.put("{sitemapForeach3}", "<c:forEach var=\"child2\" items=\"${child.childTree}\" varStatus=\"status3\">");
    	changeCode.put("{sitemapForeach4}", "<c:forEach var=\"child3\" items=\"${child2.childTree}\" varStatus=\"status4\">");
    	changeCode.put("{sitemapForeach5}", "<c:forEach var=\"child4\" items=\"${child3.childTree}\" varStatus=\"status5\">");

    	changeCode.put("{sitemapForeachEnd}", "</c:forEach>");
    	changeCode.put("{sitemapCifEnd}", "</c:if>");
    	return changeCode;
    }

}
