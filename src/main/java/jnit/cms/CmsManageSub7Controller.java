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
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.WebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.cntvt.JnitcmscntvtDefaultVO;
import jnit.cms.cntvt.JnitcmscntvtService;
import jnit.cms.cntvt.JnitcmscntvtVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.hist.JnitcmshistService;
import jnit.cms.hist.JnitcmshistVO;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.com.util.FileCopy;
import jnit.util.PathUtil;

/**
 * 콘텐츠관리
 *
 * @Class Name : JnitcmscntController.java
 * @Description : Jnitcmscnt Controller class
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
@SessionAttributes(types=JnitcmscntVO.class)
public class CmsManageSub7Controller {

	private Log log = LogFactory.getLog(getClass());
	
    @Resource(name = "jnitcmscntService")
    private JnitcmscntService jnitcmscntService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "jnitcmscntvtService")
    private JnitcmscntvtService jnitcmscntvtService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    @Resource(name="jnitcmstplService")
    private JnitcmstplService jnitcmstplService;

    @Resource(name = "jnitcmshistService")
    private JnitcmshistService jnitcmshistService;

    @Resource(name="jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * JNITCMSCNT 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmscntDefaultVO
	 * @return "/jnit/tpl-temp/jnitcmscnt/JnitcmscntList"
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/cms/sub7/0101.do")
    public String selectJnitcmscntList(@ModelAttribute("searchVO") JnitcmscntvtDefaultVO searchVO,
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

		List jnitcmscntvtList = jnitcmscntvtService.selectJnitcmscntvtList(searchVO);
		model.addAttribute("resultList", jnitcmscntvtList);

		JnitcmsmenuVO menuVO;
		HashMap<String, String> menuPathMap = new HashMap<String, String>();
		HashMap<String, String> menuNameMap = new HashMap<String, String>();

		for(int i=0; i<jnitcmscntvtList.size(); i++) {
			menuVO = new JnitcmsmenuVO();
			menuVO.setSiteId(siteVO.getSiteId());
			menuVO.setMenuId((String)((EgovMap)jnitcmscntvtList.get(i)).get("menuId"));
			menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);

			menuPathMap.put(menuVO.getCntId(), (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) );
			menuNameMap.put(menuVO.getCntId(), (String)jnitcmsmenuService.makeMenuNames(menuVO, siteVO.getSiteNm()) );
		}

		model.addAttribute("menuPathMap", menuPathMap);
		model.addAttribute("menuNameMap", menuNameMap);

		int totCnt = jnitcmscntvtService.selectJnitcmscntvtListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

        return "/jnit/cms/sub7_1-1";
    }

    @RequestMapping("/cms/sub7/0101upview.do")
    public String updateJnitcmscntView(
            @RequestParam("cntId") java.lang.String cntId,
            HttpServletRequest request,
            Model model)
            throws Exception {
    	if(request.getParameter("siteId") != null) {
        	CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");
        	if(vo == null) vo = new CmsSessionVO();

       		vo.setSiteId(request.getParameter("siteId"));
       		request.getSession().setAttribute("cmsSessionVO", vo);
        	model.addAttribute("siteId", vo.getSiteId());
    	}
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub7_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		model.addAttribute("siteVO", siteVO);

		JnitcmscntvtVO jnitcmscntvtVO = new JnitcmscntvtVO();
        jnitcmscntvtVO.setSiteId(siteVO.getSiteId());
        jnitcmscntvtVO.setCntId(cntId);
        jnitcmscntvtVO = jnitcmscntvtService.selectJnitcmscntvt(jnitcmscntvtVO);

        JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
		menuVO.setSiteId(siteVO.getSiteId());
		menuVO.setMenuId(jnitcmscntvtVO.getMenuId());
		menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);

        model.addAttribute("jnitcmscntvtVO", jnitcmscntvtVO);
        model.addAttribute("menuDirs", (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) );
        String menuNames = (String)jnitcmsmenuService.makeMenuNames(menuVO, siteVO.getSiteNm());
        model.addAttribute("menuNames", WebUtil.removeTag(menuNames) );
		model.addAttribute("customTitle", WebUtil.removeTag(menuNames) + " 수정");

    	// TPL정보조회
		ComDefaultCodeVO comVO = new ComDefaultCodeVO();
       	comVO.setCode("B");
       	comVO.setHaveDetailCondition("Y");
       	comVO.setDetailCondition(siteVO.getSiteId());
    	List<CmmnDetailCode> tplId_result = jnitcmstplService.selectTplIdDetail(comVO);
    	model.addAttribute("tplId_result", tplId_result);

		// 페이지 CNT_ID 를 Hash로 제공
		String pageIdHash = "";
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] bip = md.digest( NullUtil.nullString(jnitcmscntvtVO.getCntId()).getBytes() );
		for(int i=0; i<bip.length; i++) {
			pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
		}
		model.addAttribute("pageCode", pageIdHash);

		// 콘텐츠 페이지 파일 Reverse 로딩
		String cntFile = PathUtil.getRealPath(request)
		+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) + "/index.jsp";

		CmsHandler cmsHdr = new CmsHandler(cntFile, jnitcmscntvtVO.getTplId());

    	cmsHdr.addPatchCode("SITEID", "<%=cmsClientProperty.siteId%>");
    	cmsHdr.addPatchCode("MENUID", "<%=cmsClientProperty.menuId%>");
    	cmsHdr.addPatchCode("CNTID", "<%=cmsClientProperty.cntId%>");
    	cmsHdr.addPatchCode("TPLID", "<%=cmsClientProperty.tplId%>");

        cmsHdr.addPatchCode("PAGETITLE", "<%=cmsClientProperty.pageTitle%>");
		cmsHdr.addPatchCode("PAGEIMGTITLE", "<%=cmsClientProperty.pageImgTitle%>");
		cmsHdr.addPatchCode("PAGENAV", "<%=cmsClientProperty.pageNav%>");
		cmsHdr.addPatchCode("PAGELINKNAV", "<%=cmsClientProperty.pageLinkNav%>");
		cmsHdr.addPatchCode("PAGECODE", "<%=cmsClientProperty.pageCode%>");
		cmsHdr.addPatchCode("PAGENAVTITLE","<%=cmsClientProperty.pageNavTitle%>");

        cmsHdr.setContentHeader("<% \\/\\*<!\\-\\- \\[-CONTENT-\\] \\-\\->\\*\\/ %>");
        cmsHdr.setContentFooter("<% \\/\\*<!\\-\\- \\/\\[-CONTENT-\\] \\-\\->\\*\\/ %>");

        boolean loadRes = cmsHdr.loadContent();
	    if(loadRes == true) {
	        //cmsHdr.viewReport();
	        String reverseCntSrc = cmsHdr.getReverseContent();

	        /*
	        log.debug("--- reversed content ---");
	        log.debug("/"+reverseCntSrc+"/"+cmsHdr.makeHash(reverseCntSrc.trim()));
	        log.debug("/"+jnitcmscntvtVO.getCntSrc()+"/"+cmsHdr.makeHash(NullUtil.nullString(jnitcmscntvtVO.getCntSrc()).trim()));
	        log.debug("--- //reversed content ---");
			*/

	        if(!reverseCntSrc.trim().equals(NullUtil.nullString(jnitcmscntvtVO.getCntSrc()).trim())) {
	        	jnitcmscntvtVO.setCntSrc(cmsHdr.getReverseContent());
	        	model.addAttribute("newFileCnt", "Y");
	        }else {
	        	model.addAttribute("newFileCnt", "N");
	        }
	        model.addAttribute("notFileCnt", "N");
		}else {
			model.addAttribute("notFileCnt", "Y");
		}

    	//final String DATE_FORMAT_YYYYMMDDHHMMSS = "%1$tY.%1$tm.%1$td %1$Tp %1$tT";
    	String modifiedDate = String.format(Locale.KOREA, "%1$tF %1$tT", jnitcmscntvtVO.getModified());
    	model.addAttribute("modifiedDate", modifiedDate);

        return "/jnit/cms/sub7_1-1-editform";
    }

    @RequestMapping("/cms/sub7/0101up.do")
    public String updateJnitcmscnt(
	    @ModelAttribute("jnitcmscntvtVO") JnitcmscntvtVO jnitcmscntvtVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    SessionStatus status,
        Model model)
            throws Exception {

  	// beanValidator.validate(jnitcmscntVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitcmscnt/JnitcmscntRegister";
	// }

    	Properties props = new Properties();

    	JnitcmscntVO jnitcmscntVO = new JnitcmscntVO();
    	jnitcmscntVO.setSearchCondition("1");
    	jnitcmscntVO.setCntId(jnitcmscntvtVO.getCntId());

    	jnitcmscntVO = jnitcmscntService.selectJnitcmscnt(jnitcmscntVO);

    	String tplId = jnitcmscntvtVO.getTplId();

    	// 히스토리 기록
    	JnitcmshistVO jnitcmshistVO = new JnitcmshistVO();
    	jnitcmshistVO.setSiteId(jnitcmscntVO.getSiteId());
    	jnitcmshistVO.setMenuId(jnitcmscntVO.getMenuId());
    	jnitcmshistVO.setCntId(jnitcmscntVO.getCntId());
    	jnitcmshistVO.setCntDesc(jnitcmscntVO.getCntDesc());
    	jnitcmshistVO.setCntSrc(jnitcmscntVO.getCntSrc());
    	jnitcmshistVO.setTplId(jnitcmscntVO.getTplId());
    	jnitcmshistService.insertJnitcmshist(jnitcmshistVO);

    	jnitcmscntVO.setCntDesc(jnitcmscntvtVO.getCntDesc());
    	jnitcmscntVO.setCntSrc(jnitcmscntvtVO.getCntSrc());
    	if(NullUtil.nullString(jnitcmscntvtVO.getTplId()).equals("")) tplId = " ";
    	jnitcmscntVO.setTplId(tplId);
        jnitcmscntService.updateJnitcmscnt(jnitcmscntVO);

        JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
        menuVO.setSiteId(jnitcmscntvtVO.getSiteId());
        menuVO.setMenuId(jnitcmscntvtVO.getMenuId());
        menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);
        menuVO.setTplId(jnitcmscntvtVO.getTplId());
        jnitcmsmenuService.updateJnitcmsmenu(menuVO);

        JnitcmsmenuVO pmenuVO = new JnitcmsmenuVO();
        pmenuVO.setSiteId(jnitcmscntvtVO.getSiteId());
        pmenuVO.setMenuId(menuVO.getPid());
        pmenuVO = jnitcmsmenuService.selectJnitcmsmenu(pmenuVO);

        String pCid = "";
        String vCid = "";

        if(pmenuVO.getCntId() != null) {
        	pCid = pmenuVO.getCntId();
        }

        if(menuVO.getCntId() != null) {
        	vCid = menuVO.getCntId();
        }

        boolean isDefaultPage = false;
        if(pCid.equals(vCid)) {
        	// 기본페이지
        	isDefaultPage = true;
        }

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub7_msg-nosite";
		}

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		String cntFile = PathUtil.getRealPath(request)
		+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) + "/index.jsp";

    	CmsHandler cmsHdr = new CmsHandler(cntFile, jnitcmscntvtVO.getTplId());
    	cmsHdr.setSiteDir("/"+ siteVO.getSitePath());
		String tempContent = "";
		/*
		if(jnitcmscntvtVO.getTplId() != "") {
			JnitcmstplVO jnitcmstplVO = new JnitcmstplVO();
			jnitcmstplVO.setTplId(jnitcmscntvtVO.getTplId());
			jnitcmstplVO = jnitcmstplService.selectJnitcmstpl(jnitcmstplVO);

			// 콘텐츠 키워드 치환
			tempContent = jnitcmstplVO.getTplSrc();
			//log.debug("tpl: "+ tempContent);
			if(tempContent == null) {
				tempContent = jnitcmscntvtVO.getCntSrc();
			}else {
//				2012.07.19 By.남영강 콘텐츠 내용
//				.replace의 두번째 인자값에 $가 존재 할 경우 오류 발생하여 수정.
				jnitcmscntvtVO.setCntSrc(jnitcmscntvtVO.getCntSrc().replaceAll("\\$", "\\\\\\$"));
				tempContent = tempContent.replaceFirst("\\{\\-CONTENT\\-\\}", jnitcmscntvtVO.getCntSrc());
			}
		}else {
			tempContent = jnitcmscntvtVO.getCntSrc();
			//log.debug("content: "+tempContent);
		}
		log.debug("tpl+content: "+tempContent);
		*/
		tempContent = jnitcmscntvtVO.getCntSrc();


		// 페이지 Property 세팅
    	props.setProperty("siteId", jnitcmscntvtVO.getSiteId());
    	props.setProperty("menuId", jnitcmscntvtVO.getMenuId());
    	props.setProperty("cntId", jnitcmscntvtVO.getCntId());
    	props.setProperty("tplId", jnitcmscntvtVO.getTplId());


    	cmsHdr.addPatchCode("SITEID", "<%=cmsClientProperty.siteId%>");
    	cmsHdr.addPatchCode("MENUID", "<%=cmsClientProperty.menuId%>");
    	cmsHdr.addPatchCode("CNTID", "<%=cmsClientProperty.cntId%>");
    	cmsHdr.addPatchCode("TPLID", "<%=cmsClientProperty.tplId%>");

		// 페이지 타이틀 키워드 치환
		String pageTitleKeyword = "";
		if(isDefaultPage == true) {
			pageTitleKeyword = pmenuVO.getMenuNm();
		}else {
			pageTitleKeyword = menuVO.getMenuNm();
		}
		props.setProperty("pageTitle", pageTitleKeyword);
		tempContent = NullUtil.nullString(tempContent).replaceAll("\\{\\-PAGETITLE\\-\\}", pageTitleKeyword);
		cmsHdr.addPatchCode("PAGETITLE", "<%=cmsClientProperty.pageTitle%>");

		// 페이지 CCL
		String pageCcl = "";
		if(isDefaultPage == true) {
			pageCcl = pmenuVO.getCcl();
		}else {
			pageCcl = menuVO.getCcl();
		}
		props.setProperty("pageCcl", pageCcl);
		cmsHdr.addPatchCode("PAGECCL", "<%=cmsClientProperty.pageCcl%>");

		// 페이지 이미지 타이틀 치환
		if(menuVO.getMenuImgUrl() != null && !menuVO.getMenuImgUrl().equals("")) {
			// 이미지 타이틀
			pageTitleKeyword = "<img src='"+request.getSession().getServletContext().getContextPath()+menuVO.getMenuImgUrl()+"' border='0' alt='"+menuVO.getMenuNm()+"' />";
		}
		props.setProperty("pageImgTitle", pageTitleKeyword);
		//tempContent = tempContent.replaceAll("\\{\\-PAGEIMGTITLE\\-\\}", pageTitleKeyword);
		cmsHdr.addPatchCode("PAGEIMGTITLE", "<%=cmsClientProperty.pageImgTitle%>");


		// 페이지 네비
		String menuNames = "";
		if(isDefaultPage == true) {
			menuNames = (String)jnitcmsmenuService.makeMenuNames(pmenuVO, "Home");
		}else {
			menuNames = (String)jnitcmsmenuService.makeMenuNames(menuVO, "Home");
		}
		props.setProperty("pageNav", menuNames);
		//tempContent = tempContent.replaceAll("\\{\\-PAGENAV\\-\\}", menuNames);
		cmsHdr.addPatchCode("PAGENAV", "<%=cmsClientProperty.pageNav%>");


		// 페이지 링크 네비
		String menuLinkNames = "";
		if(isDefaultPage == true) {
			menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(pmenuVO, "Home", siteVO.getSitePath());
		}else {
			menuLinkNames = (String)jnitcmsmenuService.makeMenuLinkNames(menuVO, "Home", siteVO.getSitePath());
		}
		props.setProperty("pageLinkNav", menuLinkNames);
		//tempContent = tempContent.replaceAll("\\{\\-PAGELINKNAV\\-\\}", menuLinkNames);
		cmsHdr.addPatchCode("PAGELINKNAV", "<%=cmsClientProperty.pageLinkNav%>");

		// 페이지 네비 타이틀
		String menuNavTitle = "";
		CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");

		if(isDefaultPage == true) {
			menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(pmenuVO, vo.getSiteNm(), siteVO.getSitePath());
		}else {
			menuNavTitle = (String)jnitcmsmenuService.makeMenuNavTitleNames(menuVO, vo.getSiteNm(), siteVO.getSitePath());
		}
    	props.setProperty("pageNavTitle", menuNavTitle);
    	tempContent = tempContent.replaceAll("\\{\\-PAGENAVTITLE\\-\\}", menuNavTitle);
    	cmsHdr.addPatchCode("PAGENAVTITLE","<%=cmsClientProperty.pageNavTitle%>");

		// 페이지 CNT_ID 를 Hash로 제공
		String pageIdHash = "";
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] bip = md.digest( NullUtil.nullString(jnitcmscntvtVO.getCntId()).getBytes() );
		for(int i=0; i<bip.length; i++) {
			pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
		}
		props.setProperty("pageCode", pageIdHash);
		//tempContent = tempContent.replaceAll("\\{\\-PAGECODE\\-\\}", pageIdHash);
		cmsHdr.addPatchCode("PAGECODE", "<%=cmsClientProperty.pageCode%>");


        // File 저장
        cmsHdr.setFileHeader("<% response.setHeader(\"Cache-Control\",\"no-store\"); response.setHeader(\"Pragma\",\"no-cache\"); response.setDateHeader(\"Expires\",0); if (request.getProtocol().equals(\"HTTP/1.1\")) { response.setHeader(\"Cache-Control\", \"no-cache\"); } %><%@ page contentType=\"text/html; charset=utf-8\" %><%@ include file='/_common/header.jsp' %>");
        cmsHdr.setContentHeader("<% /*<!-- [-CONTENT-] -->*/ %>");
        cmsHdr.setContentFooter("<% /*<!-- /[-CONTENT-] -->*/ %>");
        cmsHdr.setContent(jnitcmscntvtVO.getCntSrc());
        cmsHdr.saveContent();

        props.setProperty("pageHash", cmsHdr.getPageHash());
        // File.props 저장
        String propsFile = PathUtil.getRealPath(request)
		+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) + "/index.jsp.prop";

        FileOutputStream fos = new FileOutputStream(propsFile);
        props.store(fos, "(by Jnitcms 3.5)");
        if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}

        //웹표준 웹접근성 초기화
        JnitcmscntVO setCntVO  = new JnitcmscntVO();
        setCntVO.setCntId(jnitcmscntvtVO.getCntId());
        setCntVO.setCntWebStandard(0);
        setCntVO.setCntWebStandardCss(0);
        setCntVO.setCntWebAccess(0);
        jnitcmscntService.updateWebcnt(setCntVO);

        status.setComplete();
        model.addAttribute("alert", "저장되었습니다");
        model.addAttribute("path", "/cms/sub7/0101upview.do?cntId="+jnitcmscntvtVO.getCntId());
        return "jnit/util/alertMove";
    }

    @RequestMapping("/cms/sub7/cntCopy.do")
    public String cntCopy(HttpServletRequest request) throws Exception{
    	//MENU INSERT SELECT
    	JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		String siteId = siteVO.getSiteId();
		String originMenu = NullUtil.nullString(request.getParameter("originMenuCopy"));
		String copyPid = NullUtil.nullString(request.getParameter("copyMenuCopy"));
		String copyNm = NullUtil.nullString(request.getParameter("copyNmCopy"));
		String separator = File.separator;

		Properties props = new Properties();

		JnitcmsmenuVO originVO = new JnitcmsmenuVO();
			originVO.setSiteId(siteId);
			originVO.setMenuId(originMenu);

		JnitcmsmenuVO copyVO = new JnitcmsmenuVO();
			copyVO.setSiteId(siteId);
			copyVO.setMenuId(originMenu);

		JnitcmsmenuVO originMenuVO = jnitcmsmenuService.selectJnitcmsmenu(originVO);

		JnitcmsmenuVO copyMenuVO = jnitcmsmenuService.selectJnitcmsmenu(copyVO);
			copyMenuVO.setSearchKeyword(originMenu);
			copyMenuVO.setPid(copyPid);
			copyMenuVO.setMethod(jnitcmsmenuService.selectJnitcmsmenuMaxMethod(copyMenuVO)+1);
			if(!copyNm.equals("")){
				copyMenuVO.setMenuNm(copyNm);
			}

		String menuIdVal = jnitcmsmenuService.insertSelect(copyMenuVO);

		//CNT INSERT SELECT
		JnitcmscntVO cntVO = new JnitcmscntVO();
			cntVO.setSiteId(siteId);
			cntVO.setMenuId(originMenu);

		JnitcmscntVO resultCntVO = jnitcmscntService.selectJnitcmscnt(cntVO);
			resultCntVO.setSiteId(siteId);
			resultCntVO.setSearchMenuId(originMenu);
			resultCntVO.setMenuId(menuIdVal);

		String cntIdVal = jnitcmscntService.insertSelectJnitcmscnt(resultCntVO);

		JnitcmsmenuVO depthSelect = new JnitcmsmenuVO();
			depthSelect.setSiteId(siteId);
			depthSelect.setMenuId(copyPid);
		depthSelect = jnitcmsmenuService.selectJnitcmsmenu(depthSelect);

		copyMenuVO.setCntId(cntIdVal);
		copyMenuVO.setDepth((depthSelect.getDepth()+1));
		jnitcmsmenuService.updateJnitcmsmenu(copyMenuVO);

		resultCntVO.setCntId(cntIdVal);
		jnitcmscntService.updateJnitcmscnt(resultCntVO);

		String originPath = PathUtil.getRealPath(request) + (String)jnitcmsmenuService.makeMenuDirectoryName(originMenuVO, siteVO.getSitePath()) + separator;
		String copyPath = PathUtil.getRealPath(request) + (String)jnitcmsmenuService.makeMenuDirectoryName(copyMenuVO, siteVO.getSitePath()) + separator;

    	File origin = new File(originPath);
    	File copy = new File(copyPath);
    	FileCopy.copyDirectory(origin, copy);

    	String copyPropPath = PathUtil.getRealPath(request) + (String)jnitcmsmenuService.makeMenuDirectoryName(copyMenuVO, siteVO.getSitePath()) + separator + "index.jsp.prop";
    	InputStreamReader isr = null;
    	FileInputStream fis = null;
    	try{
    		fis = new FileInputStream(copyPropPath);
	    	isr = new InputStreamReader(fis, "UTF-8");
	    	props.load(isr);

	    	JnitcmscntvtVO jnitcmscntvtVO = new JnitcmscntvtVO();
	        jnitcmscntvtVO.setSiteId(siteVO.getSiteId());
	        jnitcmscntvtVO.setCntId(copyMenuVO.getCntId());
	        jnitcmscntvtVO = jnitcmscntvtService.selectJnitcmscntvt(jnitcmscntvtVO);

	    	String pageIdHash = "";
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] bip = md.digest( copyMenuVO.getCntId().getBytes() );
			for(int i=0; i<bip.length; i++) {
				pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
			}
	    	props.setProperty("pageCode", pageIdHash);

	    	FileOutputStream fos = new FileOutputStream(copyPropPath);
	    	props.store(fos, copyMenuVO.getMenuId()+" (by Jnitcms 3.5)");
	    	if(fos != null) try{fos.close();}catch(IOException e){}
    	} catch (IOException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	} finally {
    		if(isr != null){
    			isr.close();
    		}
    		if(fis != null){
    			fis.close();
    		}
    	}

    	return "redirect:"+request.getHeader("referer");
    }
}
