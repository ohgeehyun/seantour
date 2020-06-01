/**
 * @version 3.2.0.1
 */
package jnit.rsc.page;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jnit.board.db.JnitboarddbService;
import jnit.board.db.JnitboarddbVO;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.handler.CmsClientProperty;
import jnit.cms.handler.CmsHandler;
import jnit.cms.handler.CmsProperty;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.menu.JnitmenuService;
import jnit.rsc.page.data.JnitrscpagedataService;
import jnit.rsc.page.data.JnitrscpagedataVO;
import jnit.util.PathUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.terracotta.agent.repkg.de.schlichtherle.io.FileInputStream;

import com.ibm.icu.text.SimpleDateFormat;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.FileUtil;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.WebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitrscpageController.java
 * @Description : Jnitrscpage Controller class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitrscpageVO.class)
public class JnitrscpageController {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitrscpageService")
    private JnitrscpageService jnitrscpageService;

    @Resource(name = "jnitrscpagedataService")
    private JnitrscpagedataService jnitrscpagedataService;

    @Resource(name = "jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    @Resource(name = "jnitmenuService")
    private JnitmenuService jnitmenuService;

    @Resource(name = "cmsProperty")
    private CmsProperty cmsProperty;

    @Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;

    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /* 파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");

    private final String SEPARATOR = File.separator;

    private final String[] taglibCms = {"<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>",
 		   "<%@ taglib prefix=\"validator\" uri=\"http://www.springmodules.org/tags/commons-validator\" %>",
 		   "<%@ include file=\"/_common/header.jsp\" %>"

    };

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

    @RequestMapping(value="/cms/rsc/jspPage.do")
    public String jnitrscJspPageView(@ModelAttribute("searchVO") JnitrscpageDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

	    	if(CmsHelper.getSessionSiteId(request).equals("")){
				return "jnit/cms/sub4_msg-nosite";
			}

	    	String bindType = NullUtil.nullString(request.getParameter("bindType"));
			String siteId = CmsHelper.getSessionSiteId(request);
			JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
			jnitcmssiteVO.setSiteId(siteId);
			JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

			//String docRoot = request.getRealPath("");
			String docRoot = PathUtil.getRealPath(request);
			String mkFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/";
			String filePath = "";
			String codefilePath = "";

			createdFile(request,siteVO);

			if(bindType.equals("addPage")){
				AdminUtil.setMenuId("m04020202");
				codefilePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage_code.jsp";
			}else if(bindType.equals("upPage")){
				AdminUtil.setMenuId("m04020203");
				codefilePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage_code.jsp";
			}
			final HashMap<String, Object> onceFile = new HashMap<String, Object>();
	    	final File f = new File(codefilePath);

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
	    		}
	    		catch (Exception e) {
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

	    	if(bindType.equals("addPage")){
	    		for(int i=0; i<taglibCms.length; i++) {
		        	fileString = fileString.replaceAll(taglibCms[i], "");
		        }
			}else if(bindType.equals("upPage")){
				for(int i=0; i<taglib.length; i++) {
		        	fileString = fileString.replaceAll(taglib[i], "");
		        }
			}


    		JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();

    		jnitcmstplVO.setTplSrc(fileString);
    		model.addAttribute("jnitcmstplVO", jnitcmstplVO);
	    	model.addAttribute("bindType",bindType);

        	return "/jnit/rsc/jspPageview";
    }
    @RequestMapping(value="/cms/rsc/save.do")
    public String fileSave(
    		 @ModelAttribute("jnitcmstplVO") JnitcmstplVO jnitcmstplVO,
    		 @RequestParam("bindType") java.lang.String bindType,
             HttpServletRequest request,
             ModelMap model)
             throws Exception {

    	String docRoot = PathUtil.getRealPath(request);
    	String contextPath = request.getContextPath();


    	String filePath = "";
    	String codefilePath = "";
		if(CmsHelper.getSessionSiteId(request).equals("")){
			return "jnit/cms/sub4_msg-nosite";
		}

		String siteId = CmsHelper.getSessionSiteId(request);

		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
		jnitcmssiteVO.setSiteId(siteId);
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

		String mkFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/";

		createdFile(request,siteVO);


		if(bindType.equals("addPage")){
			AdminUtil.setMenuId("m04020202");
			filePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage.jsp";
			codefilePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage_code.jsp";
		}else if(bindType.equals("upPage")){
			AdminUtil.setMenuId("m04020203");
			filePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage.jsp";
			codefilePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage_code.jsp";
		}

		 String[] FILTER_WORDS = { "<%", "%>","<c:","${" };

	        // 필터링 문자의 갯수만큼 반복을 하여 요청 매개변수의 값에 문자가 포함되어 있는지 확인한다.
	        for(int i=0; i<FILTER_WORDS.length; i++) {
	            if(NullUtil.nullString(jnitcmstplVO.getTplSrc()).indexOf(FILTER_WORDS[i]) != -1) {
	                // 필터링 문자가 발견 되었을시 처리.
	            	String msg = "<script type='text/javascript' src='../../resources/js/jquery.min.js'></script><script type='text/javascript'>alert('<% %>,c 태그,${} 는 사용하실 수 없습니다.'); $(document).ready(function(){parent.location.href='"+contextPath+"/cms/rsc/jspPage.do';}); </script>";
	            	model.addAttribute("msg",msg);

	            	return "jnit/msg";
	            }
	        }

	        String fileString = NullUtil.nullString(jnitcmstplVO.getTplSrc());
	        if(bindType.equals("addPage")){
	        	for(int i=0; i<taglibCms.length; i++) {
		        	fileString = taglibCms[i] + fileString;
		        }
			}else if(bindType.equals("upPage")){
				for(int i=0; i<taglib.length; i++) {
		        	fileString = taglib[i] + fileString;
		        }
			}


	    	CmsHandler.writeFile(codefilePath, fileString);

	    	HashMap<String, String> changeCode = changeCode();

	    	Iterator fileItr = changeCode.keySet().iterator();
			while(fileItr.hasNext()){
				String key = (String)fileItr.next();
				fileString = fileString.replace(key,changeCode.get(key));
			}
			//치환된 데이터를 원본 파일에 저장
			CmsHandler.writeFile(filePath, fileString);
    	String msg = "<script type='text/javascript' src='../../resources/js/jquery.min.js'></script><script type='text/javascript'> $(document).ready(function(){parent.location.href='"+contextPath+"/cms/rsc/jspPage.do?bindType="+bindType+"';}); </script>";
    	model.addAttribute("msg",msg);

    	return "jnit/msg";
    }
    /**
	 * jnitrscpage 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitrscpageDefaultVO
	 * @return "/jnit/tpl-temp/jnitrscpage/JnitrscpageList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/rsc/page.do")
    public String selectJnitrscpageList(@ModelAttribute("searchVO") JnitrscpageDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	if(CmsHelper.getSessionSiteId(request).equals("")){
			return "jnit/cms/sub4_msg-nosite";
		}
    	AdminUtil.setMenuId("m04020201");
    	String sitePath = request.getParameter("sitepath");
    	String siteId = CmsHelper.getSessionSiteId(request);
		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
		jnitcmssiteVO.setSiteId(siteId);
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

		JnitrscpageVO pageVO = new JnitrscpageVO();
		pageVO.setSearchKeyword(NullUtil.nullString(siteVO.getSitePath()));


    	ComDefaultCodeVO vo = new ComDefaultCodeVO();

    	// 사이트정보조회
    	vo.setHaveDetailCondition("Y");
    	vo.setDetailCondition("1");

    	// 사이트전담관리자면
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	if(loginVO.getTypeVO().getTypeLv().equals("C")) {
    		vo.setLimitAdmMbrId(loginVO.getMbrId());
    	}

    	List siteId_result = jnitcmssiteService.selectSiteIdDetail(vo);
    	TreeMap<Integer, HashMap> siteId_result_hm = new TreeMap();
    	if(siteId_result.size() > 0) {
    		siteId_result_hm.clear();
    		for(int i=0; i<siteId_result.size(); i++) {
    			HashMap<String, String> onceMap = new HashMap<String, String>();
    			onceMap.put("cd", ((CmmnDetailCode)siteId_result.get(i)).getCode());
    			onceMap.put("nm", ((CmmnDetailCode)siteId_result.get(i)).getCodeNm());

    			siteId_result_hm.put(i, onceMap);
    		}
    	}
        model.addAttribute("siteCd_result", siteId_result_hm);


        if(!loginVO.getTypeVO().getTypeLv().equals("A")) {
        	return "/jnit/rsc/page";
        }

    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(100);
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	if(sitePath != null) {
    		searchVO.setPrefixPageUrl("/"+sitePath);
    	}
    	searchVO.setSearchCondition("2");
    	searchVO.setSearchKeyword(NullUtil.nullString(siteVO.getSiteId()));
        List jnitrscpageList = jnitrscpageService.selectJnitrscpageList(searchVO);
        model.addAttribute("resultList", jnitrscpageList);

        int totCnt = jnitrscpageService.selectJnitrscpageListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "/jnit/rsc/page";
    }

    /**
	 * jnitrscpage 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitrscpageDefaultVO
	 * @return "/jnit/tpl-temp/jnitrscpage/JnitrscpageList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/rsc/pageview.do")
    public String selectJnitrscpageViewList(@ModelAttribute("searchVO") JnitrscpageDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m05010100");

    	if(CmsHelper.getSessionSiteId(request).equals("")){
			return "jnit/cms/sub4_msg-nosite";
		}

    	String sitePath = request.getParameter("sitepath");
    	String siteId = CmsHelper.getSessionSiteId(request);
		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
		jnitcmssiteVO.setSiteId(siteId);
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);


    	ComDefaultCodeVO vo = new ComDefaultCodeVO();

    	// 사이트정보조회
    	vo.setHaveDetailCondition("Y");
    	vo.setDetailCondition("1");

    	// 사이트전담관리자면
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	if(loginVO.getTypeVO().getTypeLv().equals("C")) {
    		vo.setLimitAdmMbrId(loginVO.getMbrId());
    	}

    	List siteId_result = jnitcmssiteService.selectSiteIdDetail(vo);
    	TreeMap<Integer, HashMap> siteId_result_hm = new TreeMap();
    	if(siteId_result.size() > 0) {
    		siteId_result_hm.clear();
    		for(int i=0; i<siteId_result.size(); i++) {
    			HashMap<String, String> onceMap = new HashMap<String, String>();
    			onceMap.put("cd", ((CmmnDetailCode)siteId_result.get(i)).getCode());
    			onceMap.put("nm", ((CmmnDetailCode)siteId_result.get(i)).getCodeNm());

    			siteId_result_hm.put(i, onceMap);
    		}
    	}
        model.addAttribute("siteCd_result", siteId_result_hm);


        if(!loginVO.getTypeVO().getTypeLv().equals("A")) {
        	return "/jnit/rsc/pageview";
        }

    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(100);
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setSearchCondition("2");
    	searchVO.setSearchKeyword(NullUtil.nullString(siteVO.getSiteId()));

    	if(sitePath != null) {
    		searchVO.setPrefixPageUrl("/"+sitePath);
    	}

    	searchVO.setOrdBy(2); // 페이지 뷰 많은 순

        List jnitrscpageList = jnitrscpageService.selectJnitrscpageList(searchVO);
        model.addAttribute("resultList", jnitrscpageList);

        int totCnt = jnitrscpageService.selectJnitrscpageListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "/jnit/rsc/pageview";
    }

    @RequestMapping("/user/rsc/addpageView.do")
    public String addJnitrscpageView(HttpServletRequest request, Model model)throws Exception {

    	CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
		String CtxRoot = request.getSession().getServletContext().getContextPath();
		String uri = request.getRequestURI();

		String siteId = "";
		String siteNm = "";
		String pagePath = "";

		if(request.getParameter("uri") != null ) uri = request.getParameter("uri");

		uri = uri.replace(CtxRoot, ""); // Ctx Clear
		siteNm = uri.substring(1, uri.indexOf("/",1));
		pagePath = uri.replace(".demo", "");
		pagePath = pagePath.replace("index.jsp", "");

		if(pagePath.indexOf(";jsessionid") > 0){
			pagePath = pagePath.substring(0,pagePath.indexOf(";jsessionid"));

		}

		JnitrscpageVO jnitrscpageVO = new JnitrscpageVO();
		jnitrscpageVO.setPageUrl(pagePath);
		jnitrscpageVO.setSiteId(NullUtil.nullString(cmsClientProperty.siteId));
		jnitrscpageVO.setMenuId(NullUtil.nullString(cmsClientProperty.menuId));

    	//boolean isDuplicate = false;
    	jnitrscpageVO.setPageView(1);

    	jnitrscpageVO = jnitrscpageService.selectJnitrscpageByUrl(jnitrscpageVO);
    	if(jnitrscpageVO == null){
    		try {
    			jnitrscpageVO = new JnitrscpageVO();
    			jnitrscpageVO.setPageUrl(pagePath);
    			jnitrscpageVO.setSiteId(NullUtil.nullString(cmsClientProperty.siteId));
    			jnitrscpageVO.setMenuId(NullUtil.nullString(cmsClientProperty.menuId));
    	    	jnitrscpageVO.setPageView(1);

        		jnitrscpageService.insertJnitrscpage(jnitrscpageVO);
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
        	}catch(Exception e) {
        		log.error(e.getMessage());
        	}
    	}else{
    		jnitrscpageVO.setPageView(jnitrscpageVO.getPageView() + 1);
    		jnitrscpageService.updateJnitrscpage(jnitrscpageVO);
    	}

    	String menuId = NullUtil.nullString(cmsClientProperty.menuId);
    	siteId = NullUtil.nullString(cmsClientProperty.siteId);

    	String admId = NullUtil.nullString(cmsClientProperty.admId);
    	String admNm = NullUtil.nullString(cmsClientProperty.admNm);
    	String admTel = NullUtil.nullString(cmsClientProperty.admTel);

    	String admId2 = NullUtil.nullString(cmsClientProperty.admId2);
    	String admNm2 = NullUtil.nullString(cmsClientProperty.admNm2);
    	String admTel2 = NullUtil.nullString(cmsClientProperty.admTel2);

    	String cntModified = NullUtil.nullString(cmsClientProperty.cntModified);

    	if(!admId.equals("")){
    		model.addAttribute("admId", admId);
    	}
    	if(!admNm.equals("")){
    		model.addAttribute("admNm", admNm);
    	}
    	if(!admTel.equals("")){
    		model.addAttribute("admTel", admTel);
    	}

    	if(!admId2.equals("")){
    		model.addAttribute("admId2", admId2);
    	}
    	if(!admNm2.equals("")){
    		model.addAttribute("admNm2", admNm2);
    	}
    	if(!admTel2.equals("")){
    		model.addAttribute("admTel2", admTel2);
    	}

    	if(!cntModified.equals("")){
    		model.addAttribute("cntModified", cntModified);
    	}

    	model.addAttribute("pagePath", pagePath);
    	model.addAttribute("jnitrscpageVO", jnitrscpageVO);
		String[] sitePath = pagePath.split("/");

		return "/jnit/rsc/" + sitePath[1] + "_Uaddpage";
    }
    @RequestMapping("/user/res/pagePopup.do")
    public String pagePopup(HttpServletRequest request, ModelMap model)throws Exception{

    	CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
		String CtxRoot = request.getSession().getServletContext().getContextPath();
		String uri = request.getRequestURI();
		String siteNm = "";
		String pagePath = "";

		if(request.getParameter("uri") != null ) uri = request.getParameter("uri");

		uri = uri.replace(CtxRoot, ""); // Ctx Clear
		siteNm = uri.substring(1, uri.indexOf("/",1));
		pagePath = uri.replace(".demo", "");
		pagePath = pagePath.replace("index.jsp", "");

		/* 2014-12-08 by.나성재 수정 만족도결과보기 팝업 페이지 넘김과 파라미터 틀림
		 * if(pagePath.lastIndexOf("/") == pagePath.length()-1) {
			pagePath = pagePath.substring(0, pagePath.length()-1);
		}*/

		String[] pagePaths = pagePath.split("/");
		String getSite = pagePaths[1];

		JnitrscpageVO jnitrscpageVO = new JnitrscpageVO();
		jnitrscpageVO.setPageUrl(pagePath);
		jnitrscpageVO.setSiteId(cmsClientProperty.siteId);
		jnitrscpageVO.setMenuId(cmsClientProperty.menuId);
		jnitrscpageVO.setPageView(1);
    	jnitrscpageVO = jnitrscpageService.selectJnitrscpageByUrl(jnitrscpageVO);

    	String data01 = NullUtil.nullString(request.getParameter("date01"));
    	String data02 = NullUtil.nullString(request.getParameter("date02"));

    	if(!data01.equals("") && data02.equals("") ){
    		model.addAttribute("alert", "종료일을 선택해주시기 바랍니다.");
    		model.addAttribute("path","/user/res/pagePopup.do?uri="+uri);
    		return "/jnit/util/alertMove";
    	}else if(data01.equals("") && !data02.equals("") ){
    		model.addAttribute("alert", "시작을 선택해주시기 바랍니다.");
    		model.addAttribute("path","/user/res/pagePopup.do?uri="+uri);
    		return "/jnit/util/alertMove";
    	}

    	JnitrscpagedataVO pagedataVO = new JnitrscpagedataVO();
    	pagedataVO.setSearchCondition("2");

    	if(!data01.equals("") || !data02.equals("") ){
    		pagedataVO.setSearchCondition("3");

    		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        	Date date01 = dateFormat.parse(data01);
        	Date date02 = dateFormat.parse(data02);

        	if(date01.getTime() > date02.getTime()){
        		model.addAttribute("alert","시작일이 종료일보다 빠른순 없습니다.");
        		return "/jnit/util/alertBack";
        	}
        	pagedataVO.setDate01(date01);
        	pagedataVO.setDate02(date02);
    	}

    	pagedataVO.setPageYn("N");
    	pagedataVO.setSearchKeyword(jnitrscpageVO.getRscpId());

    	List pagedataList = jnitrscpagedataService.selectJnitrscpagedataList(pagedataVO);

    	if(!data01.equals("") || !data02.equals("") ){
    		int rscMaxPeople = pagedataList.size();
        	int maxHit1 = 0;
        	int maxHit2 = 0;
        	int maxHit3 = 0;
        	int maxHit4 = 0;
        	int maxHit5 = 0;

        	Iterator pageDataIterator = pagedataList.iterator();
        	for(int i=0; i<pagedataList.size(); i++){
        		EgovMap pageDataEgovMap = (EgovMap) pageDataIterator.next();
        		int hit1 = Integer.parseInt(String.valueOf(pageDataEgovMap.get("hit1")));
        		int hit2 = Integer.parseInt(String.valueOf(pageDataEgovMap.get("hit2")));
        		int hit3 = Integer.parseInt(String.valueOf(pageDataEgovMap.get("hit3")));
        		int hit4 = Integer.parseInt(String.valueOf(pageDataEgovMap.get("hit4")));
        		int hit5 = Integer.parseInt(String.valueOf(pageDataEgovMap.get("hit5")));

        		maxHit1 += hit1;
        		maxHit2 += hit2;
        		maxHit3 += hit3;
        		maxHit4 += hit4;
        		maxHit5 += hit5;
        	}

        	String srcMaxHitStr = "";
        	int rscMaxHit = 0;
        	if(maxHit1 > 0 ) rscMaxHit = maxHit1; srcMaxHitStr="매우불만족";
        	if(rscMaxHit < maxHit2){
        		rscMaxHit = maxHit2; srcMaxHitStr="불만족";
        	}
        	if(rscMaxHit < maxHit3){
        		rscMaxHit = maxHit3; srcMaxHitStr="보통";
        	}
        	if(rscMaxHit < maxHit4){
        		rscMaxHit = maxHit4; srcMaxHitStr="만족";
        	}
        	if(rscMaxHit < maxHit5){
        		rscMaxHit = maxHit5; srcMaxHitStr="매우만족";
        	}

        	model.addAttribute("condition", "search");
        	model.addAttribute("maxHit1", maxHit1);
        	model.addAttribute("maxHit2", maxHit2);
        	model.addAttribute("maxHit3", maxHit3);
        	model.addAttribute("maxHit4", maxHit4);
        	model.addAttribute("maxHit5", maxHit5);
        	model.addAttribute("rscMaxPeople", rscMaxPeople);
        	model.addAttribute("rscMaxHit", rscMaxHit);
        	model.addAttribute("srcMaxHitStr", srcMaxHitStr);
    	}

    	model.addAttribute("date01", data01);
    	model.addAttribute("date02", data02);
    	model.addAttribute("getSite", getSite);
		model.addAttribute("pagePath", pagePath);
    	model.addAttribute("pagedataList", pagedataList);
    	model.addAttribute("jnitrscpageVO", jnitrscpageVO);

    	return "/jnit/rsc/"+getSite+"_upPage";
    }


    @RequestMapping("/user/rsc/addpage.do")
    public String addJnitrscpage( HttpServletRequest request, ModelMap model)throws Exception {

    	boolean isDuplicate = false;
    	String pageUrl = NullUtil.nullString(request.getParameter("pageUrl"));

    	//pageUrl = pageUrl.substring(0, pageUrl.length()-1);

    	JnitrscpageVO jnitrscpageVO = new JnitrscpageVO();
    	jnitrscpageVO.setSiteId(request.getParameter("siteId"));
    	jnitrscpageVO.setMenuId(request.getParameter("menuId"));
    	jnitrscpageVO.setPageUrl(pageUrl);
    	String id = "";
    	if(pageUrl.equals("")){
    		model.addAttribute("msg", "FAIL1");
    		return "/jnit/msg";
    	}
    	jnitrscpageVO = jnitrscpageService.selectJnitrscpageByUrl(jnitrscpageVO);
    	if(jnitrscpageVO == null){
    		jnitrscpageVO = new JnitrscpageVO();
    		jnitrscpageVO.setSiteId(request.getParameter("siteId"));
        	jnitrscpageVO.setMenuId(request.getParameter("menuId"));
        	jnitrscpageVO.setPageUrl(pageUrl);

        	if(NullUtil.nullString(request.getParameter("hit")).equals("1")) {
        		jnitrscpageVO.setHit1(1);
        	}
        	if(NullUtil.nullString(request.getParameter("hit")).equals("2")) {
        		jnitrscpageVO.setHit2(1);
        	}
        	if(NullUtil.nullString(request.getParameter("hit")).equals("3")) {
        		jnitrscpageVO.setHit3(1);
        	}
        	if(NullUtil.nullString(request.getParameter("hit")).equals("4")) {
        		jnitrscpageVO.setHit4(1);
        	}
        	if(NullUtil.nullString(request.getParameter("hit")).equals("5")) {
        		jnitrscpageVO.setHit5(1);
        	}

    		id = jnitrscpageService.insertJnitrscpage(jnitrscpageVO);
    	}else{
    		isDuplicate = true;
    	}

    	boolean isAlready = false;
    	JnitrscpagedataVO jnitrscpagedataVO = new JnitrscpagedataVO();
    	jnitrscpagedataVO.setRscpId(jnitrscpageVO.getRscpId());
    	jnitrscpagedataVO.setMemo(request.getParameter("memo"));

    	//mbrId
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	if(loginVO.getMbrId() != null){
    		jnitrscpagedataVO.setRemoteAddr(NullUtil.nullString(loginVO.getMbrId()));
    	}else{
    		jnitrscpagedataVO.setRemoteAddr(request.getRemoteAddr());
    	}

    	try {
        	if(NullUtil.nullString(request.getParameter("hit")).equals("1")) {
        		jnitrscpageVO.setHit1(jnitrscpageVO.getHit1() + 1);
        		jnitrscpagedataVO.setHit1(1);
        	}
        	if(NullUtil.nullString(request.getParameter("hit")).equals("2")) {
        		jnitrscpageVO.setHit2(jnitrscpageVO.getHit2() + 1);
        		jnitrscpagedataVO.setHit2(1);
        	}
        	if(NullUtil.nullString(request.getParameter("hit")).equals("3")) {
        		jnitrscpageVO.setHit3(jnitrscpageVO.getHit3() + 1);
        		jnitrscpagedataVO.setHit3(1);
        	}
        	if(NullUtil.nullString(request.getParameter("hit")).equals("4")) {
        		jnitrscpageVO.setHit4(jnitrscpageVO.getHit4() + 1);
        		jnitrscpagedataVO.setHit4(1);
        	}
        	if(NullUtil.nullString(request.getParameter("hit")).equals("5")) {
        		jnitrscpageVO.setHit5(jnitrscpageVO.getHit5() + 1);
        		jnitrscpagedataVO.setHit5(1);
        	}

    		jnitrscpagedataVO.setSearchCondition("4");
    		if(isDuplicate == true){
    			jnitrscpagedataVO.setRscpId(jnitrscpageVO.getRscpId());
    		}else{
    			jnitrscpagedataVO.setRscpId(id);
    		}

        	int isUser = jnitrscpagedataService.selectJnitrscpagedataListTotCnt(jnitrscpagedataVO);
        	if(isUser == 0){
        		jnitrscpagedataService.insertJnitrscpagedata(jnitrscpagedataVO);
        		if(isDuplicate == true) jnitrscpageService.updateJnitrscpage(jnitrscpageVO);
        		model.addAttribute("msg", "OK");
        	}else{
        		model.addAttribute("msg", "FAIL1");
        	}
    	} catch (NullPointerException e){
			log.error(e.getMessage());
    	}catch(Exception e) { //DuplicateKeyException and . remote_addr unique 제거
    		//isAlready = true;
    		log.error(e.getMessage());
    	}
        return "/jnit/msg";
    }

    @RequestMapping("/cms/rsc/delpage.do")
    public String deleteJnitrscpage(
            JnitrscpageVO jnitrscpageVO,
            @ModelAttribute("searchVO") JnitrscpageDefaultVO searchVO, SessionStatus status)
            throws Exception {
        jnitrscpageService.deleteJnitrscpage(jnitrscpageVO);
        status.setComplete();
        return "forward:/cms/rsc/page.do";
    }

    @RequestMapping("/usr/selectBoardAjax.do")
    public String selectBoardAjax(HttpServletRequest request, Model model) throws Exception{

    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    	String modified = "";
    	String created = "";
    	String boardId = NullUtil.nullString(request.getParameter("boardId"));
    	if(!boardId.equals("")){
	    	JnitboarddbVO vo = new JnitboarddbVO();
	    		vo.setBoardId(boardId);
	    		vo.setExt20("modified");

	    	JnitboarddbVO result = new JnitboarddbVO();
	    	try{
	    		result = jnitboarddbService.selectAnonymous(vo);
	    		if(result.getModified() != null){
	    			modified = format.format(result.getModified());
	    			model.addAttribute("json", "modified,"+modified);
	    		}else if(result.getCreated() != null){
	    			created = format.format(result.getCreated());
	    			model.addAttribute("json", "created,"+created);
	    		}else{
	    			model.addAttribute("json", ",");
	    		}
	    	} catch (NullPointerException e){
	    		model.addAttribute("json", ",");
	    	}catch(Exception e){
	    		//log.error(e.getMessage());
	    		model.addAttribute("json", ",");
	    	}
    	}

        return "/jnit/util/json";

    }

    @RequestMapping("/cms/rsc/excel/down.do")
    public String recExcel(HttpServletRequest request, HttpServletResponse response, ModelMap model)throws Exception{

    	String siteId = CmsHelper.getSessionSiteId(request);
		JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
		jnitcmssiteVO.setSiteId(siteId);
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);

		JnitrscpageVO pageVO = new JnitrscpageVO();
		pageVO.setSearchKeyword(NullUtil.nullString(siteVO.getSiteId()));
		pageVO.setSearchCondition("2");
		String data01 = NullUtil.nullString(request.getParameter("date01"));
    	String data02 = NullUtil.nullString(request.getParameter("date02"));

    	if(!data01.equals("") && data02.equals("") ){
    		model.addAttribute("alert", "종료일을 선택해주시기 바랍니다.");
    		return "/jnit/util/alertBack";
    	}else if(data01.equals("") && !data02.equals("") ){
    		model.addAttribute("alert", "시작을 선택해주시기 바랍니다.");
    		return "/jnit/util/alertBack";
    	}

    	model.addAttribute("date01", data01);
    	model.addAttribute("date02", data02);

    	if(!data01.equals("") || !data02.equals("") ){
    		pageVO.setLeftCondition("0");

    		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        	Date date01 = dateFormat.parse(data01);
        	Date date02 = dateFormat.parse(data02);

        	if(date01.getTime() > date02.getTime()){
        		model.addAttribute("alert","시작일이 종료일보다 빠른순 없습니다.");
        		return "/jnit/util/alertBack";
        	}
        	pageVO.setDate01(date01);
        	pageVO.setDate02(date02);
    	}
		List pageList = jnitrscpageService.selectJnitrscpageList(pageVO);

		HashMap<String, String> dethMap0 = new HashMap<String, String>();
		HashMap<String, String> dethMap1 = new HashMap<String, String>();
		HashMap<String, String> dethMap2 = new HashMap<String, String>();
		HashMap<String, String> dethMap3 = new HashMap<String, String>();
		HashMap<String, String> dethMap4 = new HashMap<String, String>();
		HashMap<String, String> dethMap5 = new HashMap<String, String>();
		HashMap<String, String> dethMap6 = new HashMap<String, String>();
		HashMap<String, String> dethMap7 = new HashMap<String, String>();

		HashMap<String, List> pagedataMap = new HashMap<String, List>();
		HashMap<String, String> mbrNmMap = new HashMap<String, String>();

		Iterator pageIterator = pageList.iterator();
		for(int i=0; i<pageList.size(); i++){
			EgovMap pageEgovMap = (EgovMap) pageIterator.next();
			String rscpId = String.valueOf(pageEgovMap.get("rscpId"));
			String menuId = String.valueOf(pageEgovMap.get("menuId"));
			siteId = String.valueOf(pageEgovMap.get("siteId"));

			siteVO = new JnitcmssiteVO();
			siteVO.setSiteId(siteId);

			try {
				siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}

			JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
			menuVO.setSiteId(siteId);
			menuVO.setMenuId(menuId);

			try {
				menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}

			if(menuVO.getMenuId() != null){
				String menuNames = (String)jnitcmsmenuService.makeMenuNames(menuVO, siteVO.getSiteNm());
				String menuName = WebUtil.removeTag(menuNames);
				String[] menuNm = menuName.split(">");

				//0뎁스
				try {
					dethMap0.put(rscpId, menuNm[0].trim() == null ? "" : menuNm[0].trim());
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error(e.getMessage());
				}

				//1뎁스
				try {
					dethMap1.put(rscpId, menuNm[1].trim() == null ? "" : menuNm[1].trim());
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error(e.getMessage());
				}

				//2뎁스
				try {
					dethMap2.put(rscpId, menuNm[2].trim() == null ? "" : menuNm[2].trim());
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error(e.getMessage());
				}

				//3뎁스
				try {
					dethMap3.put(rscpId, menuNm[3].trim() == null ? "" : menuNm[3].trim());
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error(e.getMessage());
				}

				//4뎁스
				try {
					dethMap4.put(rscpId, menuNm[4].trim() == null ? "" : menuNm[4].trim());
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error(e.getMessage());
				}
				//5뎁스
				try {
					dethMap5.put(rscpId, menuNm[5].trim() == null ? "" : menuNm[5].trim());
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error(e.getMessage());
				}

				//6뎁스
				try {
					dethMap6.put(rscpId, menuNm[6].trim() == null ? "" : menuNm[6].trim());
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error(e.getMessage());
				}

				//7뎁스
				try {
					dethMap7.put(rscpId, menuNm[7].trim() == null ? "" : menuNm[7].trim());
				} catch (ArrayIndexOutOfBoundsException e) {
					log.error(e.getMessage());
				}
			}
			//End makeMenuName

			if(data01.equals("") && data02.equals("") ){
				JnitrscpagedataVO pagedataVO = new JnitrscpagedataVO();
				pagedataVO.setSearchCondition("2");
				pagedataVO.setSearchKeyword(rscpId);
				List pagedataList = jnitrscpagedataService.selectJnitrscpagedataList(pagedataVO);
				pagedataMap.put(rscpId, pagedataList);

				Iterator pagedataIterator = pagedataList.iterator();
				for(int j=0; j<pagedataList.size(); j++){
					EgovMap pagedataEgovMap = (EgovMap) pagedataIterator.next();
					String pdataId= String.valueOf(pagedataEgovMap.get("pdataId"));
					String mbrId = String.valueOf(pagedataEgovMap.get("remoteAddr"));
					JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
					mbrVO.setMbrId(mbrId);
					try {
						mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					if(mbrVO.getMbrId() != null){
						mbrNmMap.put(pdataId, mbrVO.getMbrNm());
					}

				}
			}

		}

		model.addAttribute("resultList", pageList);
		model.addAttribute("dethMap1", dethMap1);
		model.addAttribute("dethMap2", dethMap2);
		model.addAttribute("dethMap3", dethMap3);
		model.addAttribute("dethMap4", dethMap4);
		model.addAttribute("dethMap5", dethMap5);
		model.addAttribute("dethMap6", dethMap6);
		model.addAttribute("dethMap7", dethMap7);
		model.addAttribute("pagedataMap", pagedataMap);
		model.addAttribute("mbrNmMap", mbrNmMap);

		if(data01.equals("") && data02.equals("") ){
			return "/jnit/rsc/rsc_excel_page";
		}else{
			return "/jnit/rsc/rsc_excel_pageData";
		}

    }
    public static HashMap<String, String> changeCode (){
    	HashMap<String, String> changeCode = new HashMap<String, String>();
    	changeCode.put("{rscFunction1}", "<%String localUri = request.getServletPath();%>");
    	changeCode.put("{rscFunction2}","<c:set var=\"sitePath\" value=\"${fn:replace(pageContext.request.requestURI,pageContext.request.contextPath,'')}\"/>");
    	changeCode.put("{rscFunction3}", "<c:set var=\"getSite\" value=\"${token }\"/>");
    	changeCode.put("{rscFunction4}", "<%=CmsServletPathProperty.getProp(localUri,\"siteId\") %>");
    	changeCode.put("{rscFunction5}", "<%=CmsServletPathProperty.getProp(localUri,\"menuId\") %>");
    	changeCode.put("{rscFunction6}", "${getSite }");
    	changeCode.put("{rscFunction7}", "${pagePath }");
    	changeCode.put("{rscFunction8}", "<c:url value='/user/rsc/addpage.do'/>");

    	changeCode.put("{rscForToken}","<c:forTokens var=\"token\" items=\"${sitePath }\" delims=\"/\" varStatus=\"status\">");
    	changeCode.put("{rscForTokenEnd}","</c:forTokens>");

    	changeCode.put("{rscCif1}","<c:if test=\"${status.count == 1 }\">");
    	changeCode.put("{rscCif1End}","</c:if>");

    	changeCode.put("{rscUpFunction1}", "<c:url value='/user/res/pagePopup.do'/>");
    	changeCode.put("{rscUpFunction2}", "${pagePath }");
    	changeCode.put("{rscUpFunction3}", "${condition }");
    	changeCode.put("{rscUpFunction4}", "<c:set var=\"rscPeople\" value=\"${jnitrscpageVO.hit1+jnitrscpageVO.hit2+jnitrscpageVO.hit3+jnitrscpageVO.hit4+jnitrscpageVO.hit5}\" />");
    	changeCode.put("{rscUpFunction5}", "<c:set var=\"maxHit\" value=\"${jnitrscpageVO.hit1}\" /><c:set var=\"maxHitStr\" value=\"매우불만족\" />");
    	changeCode.put("{rscUpFunction6}", "<c:set var=\"maxHit\" value=\"${jnitrscpageVO.hit2}\" /><c:set var=\"maxHitStr\" value=\"불만족\" />");
    	changeCode.put("{rscUpFunction7}", "<c:set var=\"maxHit\" value=\"${jnitrscpageVO.hit3}\" /><c:set var=\"maxHitStr\" value=\"보통\" />");
    	changeCode.put("{rscUpFunction8}", "<c:set var=\"maxHit\" value=\"${jnitrscpageVO.hit4}\" /><c:set var=\"maxHitStr\" value=\"만족\" />");
    	changeCode.put("{rscUpFunction9}", "<c:set var=\"maxHit\" value=\"${jnitrscpageVO.hit5}\" /><c:set var=\"maxHitStr\" value=\"매우만족\" />");
    	changeCode.put("{rscUpFunction10}", "<c:set var=\"hit1\" value=\"${jnitrscpageVO.hit1 }\" />");
    	changeCode.put("{rscUpFunction11}", "<c:set var=\"hit2\" value=\"${jnitrscpageVO.hit2 }\" />");
    	changeCode.put("{rscUpFunction12}", "<c:set var=\"hit3\" value=\"${jnitrscpageVO.hit3 }\" />");
    	changeCode.put("{rscUpFunction13}", "<c:set var=\"hit4\" value=\"${jnitrscpageVO.hit4 }\" />");
    	changeCode.put("{rscUpFunction14}", "<c:set var=\"hit5\" value=\"${jnitrscpageVO.hit5 }\" />");
    	changeCode.put("{rscUpFunction15}", "<c:set var=\"hit1Per\" value=\"${(272 * (jnitrscpageVO.hit1 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit1 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction16}", "<c:set var=\"hit2Per\" value=\"${(272 * (jnitrscpageVO.hit2 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit2 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction17}", "<c:set var=\"hit3Per\" value=\"${(272 * (jnitrscpageVO.hit3 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit3 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction18}", "<c:set var=\"hit4Per\" value=\"${(272 * (jnitrscpageVO.hit4 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit4 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction19}", "<c:set var=\"hit5Per\" value=\"${(272 * (jnitrscpageVO.hit5 / rscPeople)) == 0 ? 1 : 272 * (jnitrscpageVO.hit5 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction20}", "<c:set var=\"rscPeople\" value=\"${rscMaxPeople}\" />");
    	changeCode.put("{rscUpFunction21}", "<c:set var=\"maxHit\" value=\"${rscMaxHit}\" />");
    	changeCode.put("{rscUpFunction22}", "<c:set var=\"maxHitStr\" value=\"${srcMaxHitStr }\" />");
    	changeCode.put("{rscUpFunction23}", "<c:set var=\"hit1\" value=\"${maxHit1 }\" />");
    	changeCode.put("{rscUpFunction24}", "<c:set var=\"hit2\" value=\"${maxHit2 }\" />");
    	changeCode.put("{rscUpFunction25}", "<c:set var=\"hit3\" value=\"${maxHit3 }\" />");
    	changeCode.put("{rscUpFunction26}", "<c:set var=\"hit4\" value=\"${maxHit4 }\" />");
    	changeCode.put("{rscUpFunction27}", "<c:set var=\"hit5\" value=\"${maxHit5 }\" />");
    	changeCode.put("{rscUpFunction28}", "<c:set var=\"hit1Per\" value=\"${maxHit1 == 0 ? 1 : 272 * (maxHit1 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction29}", "<c:set var=\"hit2Per\" value=\"${maxHit2 == 0 ? 1 : 272 * (maxHit2 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction30}", "<c:set var=\"hit3Per\" value=\"${maxHit3 == 0 ? 1 : 272 * (maxHit3 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction31}", "<c:set var=\"hit4Per\" value=\"${maxHit4 == 0 ? 1 : 272 * (maxHit4 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction32}", "<c:set var=\"hit5Per\" value=\"${maxHit5 == 0 ? 1 : 272 * (maxHit5 / rscPeople) }\" />");
    	changeCode.put("{rscUpFunction33}", "${rscPeople}");
    	changeCode.put("{rscUpFunction34}", "${date01 }");
    	changeCode.put("{rscUpFunction35}", "${date02 }");
    	changeCode.put("{rscUpFunction36}", "${hit1Per}");
    	changeCode.put("{rscUpFunction37}", "${hit2Per}");
    	changeCode.put("{rscUpFunction38}", "${hit3Per}");
    	changeCode.put("{rscUpFunction39}", "${hit4Per}");
    	changeCode.put("{rscUpFunction40}", "${hit5Per}");
    	changeCode.put("{rscUpFunction41}", "${hit1}");
    	changeCode.put("{rscUpFunction42}", "${hit2}");
    	changeCode.put("{rscUpFunction43}", "${hit3}");
    	changeCode.put("{rscUpFunction44}", "${hit4}");
    	changeCode.put("{rscUpFunction45}", "${hit5}");
    	changeCode.put("{rscUpFunction46}", "${result.memo }");
    	changeCode.put("{rscUpFunction47}", "${rscPeople}");
    	changeCode.put("{rscUpFunction48}", "${maxHitStr}");
    	changeCode.put("{rscUpFunction49}", "${maxHit}");
    	changeCode.put("{rscUpFunction50}", "<script type=\"text/javascript\" src=\"/resources/js/jquery.min.js\" ></script>");


    	changeCode.put("{rscUpForEach1}","<c:forEach var=\"result\" items=\"${pagedataList }\" varStatus=\"status\">");
    	changeCode.put("{rscUpForEach1End}", "</c:forEach>");

    	changeCode.put("{rscUpCif1}","<c:if test=\"${condition != 'search' }\">");
    	changeCode.put("{rscUpCif2}","<c:if test=\"${maxHit <= jnitrscpageVO.hit2}\">");
    	changeCode.put("{rscUpCif3}","<c:if test=\"${maxHit <= jnitrscpageVO.hit3}\">");
    	changeCode.put("{rscUpCif4}","<c:if test=\"${maxHit <= jnitrscpageVO.hit4}\">");
    	changeCode.put("{rscUpCif5}","<c:if test=\"${maxHit <= jnitrscpageVO.hit5}\">");
    	changeCode.put("{rscUpCif6}","<c:if test=\"${condition == 'search' }\">");
    	changeCode.put("{rscUpCif1End}","</c:if>");
    	changeCode.put("{rscUpCif2End}","</c:if>");
    	changeCode.put("{rscUpCif3End}","</c:if>");
    	changeCode.put("{rscUpCif4End}","</c:if>");
    	changeCode.put("{rscUpCif5End}","</c:if>");
    	changeCode.put("{rscUpCif6End}","</c:if>");

    	return changeCode;
    }
    public void createdFile (HttpServletRequest request,JnitcmssiteVO siteVO) throws Exception{
    	String filePath = "";
		String codefilePath = "";
		String docRoot = request.getSession().getServletContext().getRealPath("");
		String mkFileDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/";

		/*************Uaddpage.jsp*************/
		filePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage.jsp";
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(new File(filePath));
		} catch (IOException e){
			String setSubDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/Uaddpage.jsp";
			String setSubSrc = CmsHandler.readFile(setSubDir);

			String mkSubDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage.jsp";
			CmsHandler.writeFile(mkSubDir, setSubSrc);
		} catch (Exception e) {
			String setSubDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/Uaddpage.jsp";
			String setSubSrc = CmsHandler.readFile(setSubDir);

			String mkSubDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage.jsp";
			CmsHandler.writeFile(mkSubDir, setSubSrc);
		} finally {
			if(fis != null){
				fis.close();
			}
		}

		codefilePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage_code.jsp";

		try {
			fis = new FileInputStream(new File(codefilePath));
		} catch (IOException e){
			String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/Uaddpage_code.jsp";
			String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

			String mkSubCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage_code.jsp";
			CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
		} catch (Exception e) {
			String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/Uaddpage_code.jsp";
			String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

			String mkSubCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_Uaddpage_code.jsp";
			CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
		} finally {
			if(fis != null){
				fis.close();
			}
		}
		/*************upPage.jsp*************/
		filePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage.jsp";

		try {
			fis = new FileInputStream(new File(filePath));
		} catch (IOException e){
			String setSubDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/upPage.jsp";
			String setSubSrc = CmsHandler.readFile(setSubDir);

			String mkSubDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage.jsp";
			CmsHandler.writeFile(mkSubDir, setSubSrc);
		} catch (Exception e) {
			String setSubDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/upPage.jsp";
			String setSubSrc = CmsHandler.readFile(setSubDir);

			String mkSubDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage.jsp";
			CmsHandler.writeFile(mkSubDir, setSubSrc);
		} finally {
			if(fis != null){
				fis.close();
			}
		}

		codefilePath = docRoot + "/WEB-INF/jsp/jnit/rsc/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage_code.jsp";

		try {
			fis = new FileInputStream(new File(codefilePath));
		} catch (IOException e){
			String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/upPage_code.jsp";
			String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

			String mkSubCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage_code.jsp";
			CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
		} catch (Exception e) {
			String setSubCodeDir = PathUtil.getRealPath(request)+"WEB-INF/jsp/jnit/rsc/upPage_code.jsp";
			String setSubCodeSrc = CmsHandler.readFile(setSubCodeDir);

			String mkSubCodeDir = mkFileDir + "/"+NullUtil.nullString(siteVO.getSitePath())+"_upPage_code.jsp";
			CmsHandler.writeFile(mkSubCodeDir, setSubCodeSrc);
		} finally {
			if(fis != null){
				fis.close();
			}
		}

    }
}
