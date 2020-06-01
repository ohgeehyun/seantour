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
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.WeakHashMap;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.cntvt.JnitcmscntvtDefaultVO;
import jnit.cms.cntvt.JnitcmscntvtService;
import jnit.cms.cntvt.JnitcmscntvtVO;
import jnit.cms.disseminate.JnitcmsdisseminateDefaultVO;
import jnit.cms.disseminate.JnitcmsdisseminateService;
import jnit.cms.disseminate.JnitcmsdisseminateVO;
import jnit.cms.disseminatehisotry.JnitcmsdisseminatehistoryService;
import jnit.cms.disseminatehisotry.JnitcmsdisseminatehistoryVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.hist.JnitcmshistService;
import jnit.cms.hist.JnitcmshistVO;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;
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
import jnit.cms.tpl.tplUtil;
import jnit.com.util.FileCopy;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.surem.message.SuremSMS;
import jnit.util.PathUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.WebUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

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
public class CmsManageSub11Controller {

	public static Log log = LogFactory.getLog(CmsManageSub11Controller.class);
	
	@Resource(name = "jnitcmsdisseminateService")
    private JnitcmsdisseminateService jnitcmsdisseminateService;

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

    @Resource(name="jnitcmsmbrtypeService")
    private JnitcmsmbrtypeService jnitcmsmbrtypeService;

    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;

    @Resource(name = "jnitcmsdisseminatehistoryService")
    private JnitcmsdisseminatehistoryService jnitcmsdisseminatehistoryService;

    @Resource(name = "jnitcmsorgService")
    private JnitcmsorgService jnitcmsorgService;

    @Resource(name = "jnitcmsrankService")
    private JnitcmsrankService jnitcmsrankService;

    @Resource(name = "jnitcmsposService")
    private JnitcmsposService jnitcmsposService;

    public static final String realPath = EgovProperties.getProperty("Globals.REAL.PATH");

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
	@RequestMapping(value="/cms/sub11/0101.do")
    public String selectJnitcmscntList(@ModelAttribute("searchVO") JnitcmscntvtDefaultVO searchVO,
    		HttpServletRequest request,
		    		ModelMap model)
		    throws Exception {

		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/disseminate/sub10_msg-nosite";
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
		WeakHashMap<String, String> menuPathMap = new WeakHashMap<String, String>();
		WeakHashMap<String, String> menuNameMap = new WeakHashMap<String, String>();

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

        return "/jnit/cms/disseminate/sub11_1-1";
    }

    @RequestMapping("/cms/sub11/0101upview.do")
    public String updateJnitcmscntView(
            @RequestParam("cntId") java.lang.String cntId,
            HttpServletRequest request,
            ModelMap model)
            throws Exception {

    	if(request.getParameter("siteId") != null) {
        	CmsSessionVO vo = (CmsSessionVO)request.getSession().getAttribute("cmsSessionVO");
        	if(vo == null) vo = new CmsSessionVO();

       		vo.setSiteId(request.getParameter("siteId"));
       		request.getSession().setAttribute("cmsSessionVO", vo);
        	model.addAttribute("siteId", vo.getSiteId());
    	}
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/disseminate/sub11_msg-nosite";
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

        model.addAttribute("menuDirs", (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) );
        String menuNames = (String)jnitcmsmenuService.makeMenuNames(menuVO, siteVO.getSiteNm());
        model.addAttribute("menuNames", WebUtil.removeTag(menuNames) );
		model.addAttribute("customTitle", WebUtil.removeTag(menuNames) + " 수정");


		//배포시스템 로딩
		JnitcmsdisseminateVO jnitcmsdisseminateVO = new JnitcmsdisseminateVO();
		jnitcmsdisseminateVO.setSearchKeyword(cntId);
		jnitcmsdisseminateVO.setSearchCondition("2");
		jnitcmsdisseminateVO.setPageYn("N");
		List disseminate = jnitcmsdisseminateService.selectJnitcmsdisseminateList(jnitcmsdisseminateVO);

		Iterator disseminateItor = disseminate.iterator();
		String disseminateType = "";
		String disseminateDay = "";
		String contentConfirm = "";

		while (disseminateItor.hasNext()) {
			EgovMap disseminateMap = (EgovMap) disseminateItor.next();
			disseminateType = String.valueOf(disseminateMap.get("disseminateType"));
			disseminateDay = NullUtil.nullString(String.valueOf(disseminateMap.get("disseminateDay")));
			contentConfirm = String.valueOf(disseminateMap.get("contentConfirm"));

		}

		model.addAttribute("contentConfirm", contentConfirm);
		if(!disseminateType.equals("")){
			model.addAttribute("disseminateType", disseminateType);
		}
		if(disseminateType.equals("1")){
			if(!disseminateDay.equals("null")){
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				DateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
				Date date = format.parse(disseminateDay);
				model.addAttribute("disseminateDay", format2.parse(format2.format(date)));
			}
		}

		if(disseminateType.equals("2")){
			HashMap<String, String> historyMap = new HashMap<String, String>();

			String getHistoryId = jnitcmsdisseminatehistoryService.getLastIdJnitcmsdisseminatehistory();
			int idSize = getHistoryId.length();
			String historyId = "HISTORY_"+String.format("%0"+idSize+"d", Integer.parseInt(getHistoryId)-1);

			//disseminateHistory List
			JnitcmsdisseminatehistoryVO setHistroyVO = new JnitcmsdisseminatehistoryVO();
			setHistroyVO.setSearchKeyword(historyId);
			setHistroyVO.setSearchCondition("0");
			setHistroyVO.setFirstIndex(0);
			setHistroyVO.setRecordCountPerPage(10);
			List historyList = jnitcmsdisseminatehistoryService.selectLeftJoinhistoryList(setHistroyVO);
			Iterator historyIterator = historyList.iterator();
			String historyMbrId = "";
			for(int j=0; j<historyList.size(); j++){
				EgovMap historyEgovMap = (EgovMap) historyIterator.next();
				historyMbrId = String.valueOf(historyEgovMap.get("mbrId"));
				String historyMbrNm = String.valueOf(historyEgovMap.get("mbrNm"));
				String historyMemo = String.valueOf(historyEgovMap.get("historyMemo"));
				String[] Memos = historyMemo.split(",");
				String memo = Memos[0];
				historyMap.put("historyMemo", memo);
				historyMap.put("historyMbrNm", historyMbrNm);

			}
			model.addAttribute("historyList", historyList);

			//disseminate List
			List disseminateList = jnitcmsdisseminateService.selectdisseminateList(jnitcmsdisseminateVO);
			model.addAttribute("disseminateList", disseminateList);
			Iterator disseminateIterator = disseminateList.iterator();
			int k=0;
			for(int i=0; i<disseminateList.size(); i++){
				EgovMap disseminateEgovMap = (EgovMap) disseminateIterator.next();
				String mbrId = String.valueOf(disseminateEgovMap.get("mbrId"));
				if(mbrId.equals(historyMbrId)){
					k++;
				}
			}
			if(k == 0){
				model.addAttribute("historyMap", historyMap);
			}

		}
		// end 배포시스템 로딩


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
		byte[] bip = md.digest( jnitcmscntvtVO.getCntId().getBytes() );
		for(int i=0; i<bip.length; i++) {
			pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
		}
		model.addAttribute("pageCode", pageIdHash);

    	String cntDir = jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());
    	String encodeDir = EgovFileScrty.encode(cntDir);

    	Properties props = new Properties();
		String propsDir = PathUtil.getRealPath(request)+
		jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp.prop";

		File propsFile = new File(propsDir);
		if(propsFile.exists()){
			InputStreamReader isr = null;
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(propsFile);
				isr = new InputStreamReader(fis,"UTF-8");
				props.load(isr);
			} catch (IOException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			try {
				String indexGet = props.getProperty("indexGet");
				if(indexGet.equals("Y")) encodeDir = "index";
			}catch (NullPointerException e) {
				log.error(e.getMessage());
				encodeDir = "index";
			}catch (Exception e) {
				log.error(e.getMessage());
			} finally{
				if(isr != null){
					isr.close();
				}
				if(fis != null){
					fis.close();
				}
			}
		}

		// 콘텐츠 페이지 파일 Reverse 로딩
		String cntFile = PathUtil.getRealPath(request)
		+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) + "/"+encodeDir+".jsp";

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
    	model.addAttribute("cntId", cntId);

    	//콘텐츠 페이지의 서브템플릿 inculde 확인
    	model.addAllAttributes(isInculdeSubTpl(request, model, siteVO, menuVO, jnitcmscntvtVO.getTplId(), jnitcmscntvtVO.getCntId()));
    	if(model.get("alert") != null){
    		jnitcmscntvtVO.setTplId(" ");
    	}
    	model.addAttribute("jnitcmscntvtVO", jnitcmscntvtVO);
        return "/jnit/cms/disseminate/sub11_1-1-editform";
    }

    @RequestMapping("/cms/sub11/0101up.do")
    public String updateJnitcmscnt(
	    @ModelAttribute("jnitcmscntvtVO") JnitcmscntvtVO jnitcmscntvtVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    SessionStatus status,
        ModelMap model)
            throws Exception {

  	// beanValidator.validate(jnitcmscntVO, bindingResult); //validation 수행
	// if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
	//	return "/jnit/tpl-temp/jnitcmscnt/JnitcmscntRegister";
	// }

    	String root = PathUtil.getRealPath(request);
    	String siteId = CmsHelper.getSessionSiteId(request);

    	if(siteId.equals("")) {
    		return "jnit/cms/disseminate/sub11_msg-nosite";
		}
    	Properties props = new Properties();

    	JnitcmscntVO jnitcmscntVO = new JnitcmscntVO();
    	jnitcmscntVO.setSearchCondition("1");
    	jnitcmscntVO.setCntId(jnitcmscntvtVO.getCntId());
    	jnitcmscntVO = jnitcmscntService.selectJnitcmscnt(jnitcmscntVO);

    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
    	siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

    	// 히스토리 기록
    	JnitcmshistVO jnitcmshistVO = new JnitcmshistVO();
    	jnitcmshistVO.setSiteId(jnitcmscntVO.getSiteId());
    	jnitcmshistVO.setMenuId(jnitcmscntVO.getMenuId());
    	jnitcmshistVO.setCntId(jnitcmscntVO.getCntId());
    	jnitcmshistVO.setCntDesc(jnitcmscntVO.getCntDesc());
    	jnitcmshistVO.setCntSrc(jnitcmscntVO.getCntSrc());
    	jnitcmshistVO.setTplId(jnitcmscntVO.getTplId());
    	//jnitcmshistService.insertJnitcmshist(jnitcmshistVO);

    	String tplId = jnitcmscntvtVO.getTplId();
    	jnitcmscntVO.setCntDesc(jnitcmscntvtVO.getCntDesc());
    	jnitcmscntVO.setCntSrc(jnitcmscntvtVO.getCntSrc());
    	jnitcmscntVO.setTplId(jnitcmscntvtVO.getTplId());
    	if("".equals(NullUtil.nullString(jnitcmscntvtVO.getTplId()))) tplId = " ";
    	jnitcmscntVO.setTplId(tplId);
        //jnitcmscntService.updateJnitcmscnt(jnitcmscntVO);

        JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
        menuVO.setSiteId(jnitcmscntvtVO.getSiteId());
        menuVO.setMenuId(jnitcmscntvtVO.getMenuId());
        menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);
        menuVO.setTplId(jnitcmscntvtVO.getTplId());

        model.addAllAttributes(isInculdeSubTpl(request, model, siteVO, menuVO, jnitcmscntVO.getTplId(), jnitcmscntvtVO.getCntId()));
        if(model.get("alert") != null){
        	jnitcmscntvtVO.setTplId(" ");
        	jnitcmshistVO.setTplId(" ");
        }
        //jnitcmsmenuService.updateJnitcmsmenu(menuVO);

        JnitcmsmenuVO pmenuVO = new JnitcmsmenuVO();
        pmenuVO.setSiteId(jnitcmscntvtVO.getSiteId());
        pmenuVO.setMenuId(menuVO.getPid());
        pmenuVO = jnitcmsmenuService.selectJnitcmsmenu(pmenuVO);

        /***********************************************************************************************
         * 콘텐츠 배포 시스템
         * contentConfirm = 0:진행중 1:완료 2:반려 3:완료(즉시배포) 4:재설정 5:강제승인 6:강제반려
         * disseminateConfirm = 0:대기중 1:승인 2:반려 3:완료(즉시배포) 4:재설정 5:강제승인 6:강제반려
         *
         * 2013.11.21 By.나성재 배포등록
         * 강제승인 강제반려는 회원등급 최고레벨 일경우 로 바꾸도록 설정해야됨.
         * 승인절차 재설정은 승인절차가 어느 한명이라도 진행이 되었을시 최고 관리자가 재설정 할수있도록 권한
         * 되어있도록 설정을 해야됨.
         ***********************************************************************************************/
        String temporary = NullUtil.nullString(request.getParameter("temporary"));
        String disseminateType = NullUtil.nullString(request.getParameter("disseminateType"));

        JnitcmsdisseminateVO jnitcmsdisseminateVO = new JnitcmsdisseminateVO();
        jnitcmsdisseminateVO.setSearchKeyword(jnitcmscntvtVO.getCntId());
        jnitcmsdisseminateVO.setPageYn("N");
        jnitcmsdisseminateVO.setSearchCondition("2");
        List disseminate = jnitcmsdisseminateService.selectJnitcmsdisseminateList(jnitcmsdisseminateVO);

        String contentPath = (String)jnitcmsmenuService.makeMenuNames(menuVO, siteVO.getSiteNm());

        //회원 load
        JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
        loginVO.setMbrId(loginVO.getMbrId());
        loginVO = jnitcmsmbrService.selectJnitcmsmbr(loginVO);
        JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();



        String memo = NullUtil.nullString(request.getParameter("anMemo"));
        if(memo.equals("")) memo = "null";
		jnitcmsdisseminateVO.setDisseminateMemo(memo);
		jnitcmsdisseminateVO.setContentPath(WebUtil.removeTag(contentPath));
		jnitcmsdisseminateVO.setSiteId(siteVO.getSiteId());
		jnitcmsdisseminateVO.setMenuId(menuVO.getMenuId());
		jnitcmsdisseminateVO.setCntId(jnitcmscntvtVO.getCntId());
		jnitcmsdisseminateVO.setDisseminateType(disseminateType);

		//history
		JnitcmsdisseminatehistoryVO jnitcmsdisseminatehistoryVO = new JnitcmsdisseminatehistoryVO();
		jnitcmsdisseminatehistoryVO.setSiteId(siteVO.getSiteId());
    	jnitcmsdisseminatehistoryVO.setMenuId(menuVO.getMenuId());
    	jnitcmsdisseminatehistoryVO.setCntId(jnitcmscntvtVO.getCntId());
    	jnitcmsdisseminatehistoryVO.setContentPath(WebUtil.removeTag(contentPath));
    	jnitcmsdisseminatehistoryVO.setDisseminateType(disseminateType);
    	jnitcmsdisseminatehistoryVO.setMbrId(loginVO.getMbrId());
    	jnitcmsdisseminatehistoryVO.setDisseminateConfirm(0);
    	jnitcmsdisseminatehistoryVO.setHistoryMemo(memo);

    	if(jnitcmsdisseminateVO.getContentPath().getBytes("UTF-8").length>=255){
    		model.addAttribute("alert","콘텐츠 경로는 255자를 넘길 수 없습니다.");
    		return "/jnit/util/alertBack";
    	};

		String disseminateIdList = "";
		if(disseminate.size() == 0){
			if(disseminateType.equals("0")){ //즉시
				jnitcmsdisseminateVO.setContentConfirm(3);
				if(memo.equals("null")) memo = null;
        		jnitcmsdisseminateVO.setDisseminateMemo(memo);


	        	jnitcmsdisseminateService.insertJnitcmsdisseminate(jnitcmsdisseminateVO);
	        	//history
        		jnitcmsdisseminatehistoryVO.setDisseminateConfirm(3);
        		jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("3");

        		//암호화 파일 생성
        		if(cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "Y" , null)){

        			//암호화 파일 load
        			String dirName = jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());
        			String encodeDirName = EgovFileScrty.encode(dirName);
        			String ctxRoot = PathUtil.getRealPath(request)+
        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/"+encodeDirName+".jsp";

        			String str = CmsHandler.readFile(ctxRoot);

        			//index File create
        			String CtxRoot = PathUtil.getRealPath(request)+
        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";
        			CmsHandler.writeFile(CtxRoot, str);
        		};

	        }
	        if(disseminateType.equals("1")){ //예약
	        	String disseminateDay = NullUtil.nullString(request.getParameter("disseminateDay"));
	            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	            Date disseminateDate = (Date)dateFormat.parse(disseminateDay);

	        	jnitcmsdisseminateVO.setDisseminateDay(disseminateDate);
	        	jnitcmsdisseminateVO.setContentConfirm(0);
	        	if(memo.equals("null")) memo = null;
        		jnitcmsdisseminateVO.setDisseminateMemo(memo);
	        	jnitcmsdisseminateService.insertJnitcmsdisseminate(jnitcmsdisseminateVO);
	        	//history
	        	jnitcmsdisseminatehistoryVO.setDisseminateDay(disseminateDate);
	        	jnitcmsdisseminatehistoryVO.setDisseminateConfirm(0);
	        	jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("0");

	        	//암호화 파일 생성
	        	cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "N", null);
	        }
	        int k=1;

	        if(disseminateType.equals("2")){ //승인절차
	        	String[] disseminateMbrList = request.getParameterValues("mbrList");
	        	String setMemo = "";
	            for(int i=0; i<disseminateMbrList.length; i++){
	            	jnitcmsdisseminateVO.setMbrId(disseminateMbrList[i]);
            		jnitcmsdisseminateVO.setContentConfirm(0);
            		jnitcmsdisseminateVO.setDisseminateNum(Integer.toString(k));
            		jnitcmsdisseminateVO.setDisseminateStand(1);
            		jnitcmsdisseminateVO.setDisseminateMemo(null);
                	String id = jnitcmsdisseminateService.insertJnitcmsdisseminate(jnitcmsdisseminateVO);
                	k++;
                	if(disseminateIdList.equals("")){
                		disseminateIdList = id;
                	}else{
                		disseminateIdList = disseminateIdList+","+id;
                	}
                	if(setMemo.equals("")){
                		setMemo = ",null";
                	}else{
                		setMemo = setMemo+",null";
                	}
	            }
	            //history
	            jnitcmsdisseminatehistoryVO.setDisseminateLine(disseminateIdList);
                jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("0");
                jnitcmsdisseminatehistoryVO.setDisseminateConfirm(0);
                jnitcmsdisseminatehistoryVO.setHistoryMemo(memo+setMemo);

                //암호화 파일 생성
                cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "N", null);

                //첫번째 등록자 SMS 설정
                JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
                mbrVO.setMbrId(disseminateMbrList[0]);
                try {
					mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
					if(mbrVO.getMbrId() != null){
						SuremSMS.suremSendMessage(mbrVO.getMbrNm(), "DEFAULT", mbrVO.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포 승인대기중입니다.", "AUTO", null);
					}
                } catch (NullPointerException e){
        			log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
	        }
		}else{
			Iterator disseminateItor = disseminate.iterator();
			String disseminatelist = "";
			String disseminateDbType = "";
			String mbrlist = "";
			String cancel  = NullUtil.nullString(request.getParameter("cancel"));
			String setMemo="";
			String newMemo="";
		    String getMemo="";
		    String ctnfirmDB = "";
		    String standDB = "";
			while (disseminateItor.hasNext()) {
				EgovMap disseminateMap = (EgovMap) disseminateItor.next();
				ctnfirmDB = String.valueOf(disseminateMap.get("contentConfirm"));
				disseminateDbType = String.valueOf(disseminateMap.get("disseminateType"));
				standDB = String.valueOf(disseminateMap.get("disseminateStand"));
				if(disseminatelist.equals("")){
					disseminatelist = String.valueOf(disseminateMap.get("disseminateId"));
				}else{
					disseminatelist = disseminatelist + "," + String.valueOf(disseminateMap.get("disseminateId"));
				}
				if(mbrlist.equals("")){
					mbrlist = NullUtil.nullString(String.valueOf(disseminateMap.get("mbrId")));
				}else{
					mbrlist = mbrlist +","+ NullUtil.nullString(String.valueOf(disseminateMap.get("mbrId")));
				}
			}
			String[] disseminatelists = disseminatelist.split(",");
			String[] mbrlists = mbrlist.split(",");
			if(disseminateType.equals("0")){ //즉시
				for(int i=0; i<disseminatelists.length; i++){
					jnitcmsdisseminateVO.setDisseminateId(disseminatelists[i]);
					jnitcmsdisseminateVO.setContentConfirm(3);
					if(memo.equals("null")) memo = null;
	        		jnitcmsdisseminateVO.setDisseminateMemo(memo);
					jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);
					//history
	        		jnitcmsdisseminatehistoryVO.setDisseminateConfirm(3);
	        		jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("3");

	        		//암호화 파일 생성
	        		if(cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request,"Y", null)){

	        			//암호화 파일 load
	        			String dirName = jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());
	        			String encodeDirName = EgovFileScrty.encode(dirName);
	        			String ctxRoot = PathUtil.getRealPath(request)+
	        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/"+encodeDirName+".jsp";

	        			String str = CmsHandler.readFile(ctxRoot);

	        			//index File write
	        			String CtxRoot = PathUtil.getRealPath(request)+
	        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";
	        			CmsHandler.writeFile(CtxRoot, str);
	        		};
				}
	        }
	        if(disseminateType.equals("1")){ //예약
	        	for(int i=0; i<disseminatelists.length; i++){
	        		jnitcmsdisseminateVO.setDisseminateId(disseminatelists[i]);
	        		if(disseminateDbType.equals("0")){
	        			JnitcmsdisseminateVO setMemoVO = new JnitcmsdisseminateVO();
	        			setMemoVO.setDisseminateId(disseminatelists[i]);
	        			JnitcmsdisseminateVO getMemoVO = jnitcmsdisseminateService.selectJnitcmsdisseminate(setMemoVO);
	        			getMemo = NullUtil.nullString(getMemoVO.getDisseminateMemo());
	        			jnitcmsdisseminateVO.setDisseminateMemo(getMemo);

		        		jnitcmsdisseminateVO.setIsdel(1);
		        		jnitcmsdisseminateVO.setContentConfirm(3);
		        		jnitcmsdisseminateVO.setDisseminateType(disseminateDbType);
		        		if(memo.equals("null")) memo = null;
		        		jnitcmsdisseminateVO.setDisseminateMemo(memo);
		        		jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);

		        		//history - 즉시배포 삭제
		        		jnitcmsdisseminatehistoryVO.setDisseminateConfirm(2);
		        		jnitcmsdisseminatehistoryVO.setDisseminateType("0");
		        		jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("2");
		        		jnitcmsdisseminatehistoryVO.setHistoryMemo(getMemo);

		        		jnitcmsdisseminatehistoryService.insertJnitcmsdisseminatehistory(jnitcmsdisseminatehistoryVO);


			        	String disseminateDay = NullUtil.nullString(request.getParameter("disseminateDay"));
			            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			            Date disseminateDate = (Date)dateFormat.parse(disseminateDay);

			        	jnitcmsdisseminateVO.setDisseminateDay(disseminateDate);
			        	jnitcmsdisseminateVO.setContentConfirm(0);
			        	jnitcmsdisseminateVO.setIsdel(0);
			        	jnitcmsdisseminateVO.setDisseminateType(disseminateType);
			        	jnitcmsdisseminateVO.setDisseminateMemo(memo);
			        	jnitcmsdisseminateService.insertJnitcmsdisseminate(jnitcmsdisseminateVO);

			        	//history
			        	jnitcmsdisseminatehistoryVO.setHistoryMemo(memo);
			        	jnitcmsdisseminatehistoryVO.setDisseminateDay(disseminateDate);
			        	jnitcmsdisseminatehistoryVO.setDisseminateConfirm(0);
			        	jnitcmsdisseminatehistoryVO.setDisseminateType("1");
			        	jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("0");

			        	//암호화 파일 생성
			        	cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "N", null);


	        		}else if(cancel.equals("")){
		        		String disseminateDay = NullUtil.nullString(request.getParameter("disseminateDay"));
			            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			            Date disseminateDate = (Date)dateFormat.parse(disseminateDay);
			            jnitcmsdisseminateVO.setContentConfirm(0);
			        	jnitcmsdisseminateVO.setDisseminateDay(disseminateDate);
			        	if(memo.equals("null")) memo = null;
		        		jnitcmsdisseminateVO.setDisseminateMemo(memo);
		        		jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);

	        			//history
			        	jnitcmsdisseminatehistoryVO.setDisseminateDay(disseminateDate);
		        		jnitcmsdisseminatehistoryVO.setDisseminateConfirm(0);
		        		jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("0");

			        	//암호화 파일 생성
			        	cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "N", null);

	        		}else if(cancel.equals("daycancel")){
	        			if(!typeLv(typeVO, loginVO, request)){
	    					model.addAttribute("alert", "예약 취소는 최고 관리자 권한이 있어야합니다.");
	    					return "jnit/util/alertBack";
	    				}

	        			String disseminateDay = NullUtil.nullString(request.getParameter("disseminateDay"));
			            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			            Date disseminateDate = (Date)dateFormat.parse(disseminateDay);

	        			jnitcmsdisseminateVO.setIsdel(1);
	        			jnitcmsdisseminateVO.setContentConfirm(2);
	        			if(memo.equals("null")) memo = null;
	            		jnitcmsdisseminateVO.setDisseminateMemo(memo);
	        			jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);

	        			//history
	        			jnitcmsdisseminatehistoryVO.setDisseminateDay(disseminateDate);
	        			jnitcmsdisseminatehistoryVO.setDisseminateConfirm(2);
	        			jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("2");

	        			//암호화 파일 생성
	        			if(cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "Y" , null)){
	        				String ctxDir = PathUtil.getRealPath(request)+
		        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";

		        			CmsHandler cmsHdr = new CmsHandler(ctxDir, jnitcmscntvtVO.getTplId());
		        			cmsHdr.addPatchCode("SITEID", "<%=cmsClientProperty.siteId%>");
		        	    	cmsHdr.addPatchCode("MENUID", "<%=cmsClientProperty.menuId%>");
		        	    	cmsHdr.addPatchCode("CNTID", "<%=cmsClientProperty.cntId%>");
		        	    	cmsHdr.addPatchCode("TPLID", "<%=cmsClientProperty.tplId%>");

		        	        cmsHdr.addPatchCode("PAGETITLE", "<%=cmsClientProperty.pageTitle%>");
		        			cmsHdr.addPatchCode("PAGEIMGTITLE", "<%=cmsClientProperty.pageImgTitle%>");
		        			cmsHdr.addPatchCode("PAGENAV", "<%=cmsClientProperty.pageNav%>");
		        			cmsHdr.addPatchCode("PAGELINKNAV", "<%=cmsClientProperty.pageLinkNav%>");
		        			cmsHdr.addPatchCode("PAGECODE", "<%=cmsClientProperty.pageCode%>");

		        	        cmsHdr.setContentHeader("<% \\/\\*<!\\-\\- \\[-CONTENT-\\] \\-\\->\\*\\/ %>");
		        	        cmsHdr.setContentFooter("<% \\/\\*<!\\-\\- \\/\\[-CONTENT-\\] \\-\\->\\*\\/ %>");
		        	        String reverseCntSrc = "";
		        	        boolean loadRes = cmsHdr.loadContent();
		        		    if(loadRes == true) {
		        		        reverseCntSrc = cmsHdr.getReverseContent();
		        		    	jnitcmscntVO.setCntSrc(reverseCntSrc);
		        		        jnitcmscntService.updateJnitcmscnt(jnitcmscntVO);
		        			}
	        			}
	        		}
	        	}
	        }

	        if(disseminateType.equals("2")){ // 승인절차
	        	for(int i=0; i<disseminatelists.length; i++){
	        		JnitcmsdisseminateVO setMemoVO = new JnitcmsdisseminateVO();
        			setMemoVO.setDisseminateId(disseminatelists[i]);
        			JnitcmsdisseminateVO getMemoVO = jnitcmsdisseminateService.selectJnitcmsdisseminate(setMemoVO);
        			getMemo = NullUtil.nullString(getMemoVO.getDisseminateMemo());
        			jnitcmsdisseminateVO.setDisseminateMemo(getMemo);
        			if(getMemo.equals("")) getMemo = "null";
        			if(setMemo.equals("")){
        				setMemo = ","+getMemo;
        			}else{
        				setMemo = setMemo+","+getMemo;
        			}
	        		jnitcmsdisseminateVO.setDisseminateId(disseminatelists[i]);

	        		if(disseminateDbType.equals("0")){
		        		jnitcmsdisseminateVO.setIsdel(1);
		        		jnitcmsdisseminateVO.setContentConfirm(3);
		        		jnitcmsdisseminateVO.setDisseminateType(disseminateDbType);
		        		if(memo.equals("null")) memo = null;
		        		jnitcmsdisseminateVO.setDisseminateMemo(memo);
		        		jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);

		        		//history - 즉시배포 삭제
		        		jnitcmsdisseminatehistoryVO.setDisseminateConfirm(2);
		        		jnitcmsdisseminatehistoryVO.setDisseminateType("0");
		        		jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("2");
		        		jnitcmsdisseminatehistoryVO.setHistoryMemo(getMemo);
		        		jnitcmsdisseminatehistoryService.insertJnitcmsdisseminatehistory(jnitcmsdisseminatehistoryVO);

		        		int e=1;
		        		String[] disseminateMbrList = request.getParameterValues("mbrList");
			            for(int j=0; j<disseminateMbrList.length; j++){
			            	jnitcmsdisseminateVO.setMbrId(disseminateMbrList[j]);
		            		jnitcmsdisseminateVO.setContentConfirm(0);
		            		jnitcmsdisseminateVO.setDisseminateNum(Integer.toString(e));
		            		jnitcmsdisseminateVO.setDisseminateType(disseminateType);
		            		jnitcmsdisseminateVO.setIsdel(0);
		            		jnitcmsdisseminateVO.setDisseminateMemo(null);
		            		jnitcmsdisseminateVO.setDisseminateStand(1);
		                	String id =jnitcmsdisseminateService.insertJnitcmsdisseminate(jnitcmsdisseminateVO);

		                	if(disseminateIdList.equals("")){
		                		disseminateIdList = id;
		                	}else{
		                		disseminateIdList = disseminateIdList+","+id;
		                	}
		                	if(newMemo.equals("")){
		                		newMemo = ",null";
		                	}else{
		                		newMemo = newMemo+",null";
		                	}
		                	e++;
			            }
			            //history
			            jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("0");
			            jnitcmsdisseminatehistoryVO.setDisseminateConfirm(0);
			            jnitcmsdisseminatehistoryVO.setDisseminateType("2");
			            jnitcmsdisseminatehistoryVO.setDisseminateLine(disseminateIdList);
			            jnitcmsdisseminatehistoryVO.setHistoryMemo(memo+newMemo);

			            //암호화 파일 생성
			            cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "N", null);

			            //첫번째 등록자 SMS 설정
		                JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
		                mbrVO.setMbrId(disseminateMbrList[0]);
		                try {
							mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
							if(mbrVO.getMbrId() != null){
								SuremSMS.suremSendMessage(mbrVO.getMbrNm(), "DEFAULT", mbrVO.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포 승인대기중입니다.", "AUTO", null);
							}
		                } catch (NullPointerException ee){
		        			log.error(ee.getMessage());
						} catch (Exception ee) {
							log.error(ee.getMessage());
						}

		        	}else if(cancel.equals("")){ //강제승인
		        		if(!typeLv(typeVO, loginVO, request)){
	    					model.addAttribute("alert", "강제 승인는 최고 관리자 권한이 있어야합니다.");
	    					return "jnit/util/alertBack";
	    				}
		        		if(temporary.equals("")){ //임시저장
		        			jnitcmsdisseminateVO.setDisseminateConfirm(1);
		        			jnitcmsdisseminateVO.setContentConfirm(5);
		        			jnitcmsdisseminateVO.setMbrId(mbrlists[i]);
		        			jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);

		        			//history
		        			jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("5");
		        			jnitcmsdisseminatehistoryVO.setDisseminateConfirm(5);
		        			jnitcmsdisseminatehistoryVO.setDisseminateLine(disseminatelist);
		        			jnitcmsdisseminatehistoryVO.setHistoryMemo(memo+setMemo);
		        		}

	        			//암호화 파일 생성
	        			if(cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "Y", null)){

	        				if(temporary.equals("")){ //임시저장
	        					//암호화 파일 load
		        				String dirName = jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());
		            			String encodeDirName = EgovFileScrty.encode(dirName);
		            			String ctxRoot = PathUtil.getRealPath(request)+
		            			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/"+encodeDirName+".jsp";

		            			File ctxFile = new File(ctxRoot);
		            			if(ctxFile.exists()){
		            				String str = CmsHandler.readFile(ctxRoot);

			            			//index File write
			            			String CtxRoot = PathUtil.getRealPath(request)+
			            			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";
			            			CmsHandler.writeFile(CtxRoot, str);
		            			}else{
		            				model.addAttribute("alert", "임시 파일이 없습니다.\\nFileName : "+encodeDirName);
		            				return "jnit/util/alertBack";
		            			}

	        					//index_백업 파일 생성
		        				String indexCtxRoot = PathUtil.getRealPath(request)+
		        				jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";

		        				File indexFile = new File(indexCtxRoot);
		        				if(indexFile.exists()){
		        					String bak_str = CmsHandler.readFile(indexCtxRoot);

			        				String makeBakDir = PathUtil.getRealPath(request)+
			        				jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/bak";

			        				File bakFile = new File(makeBakDir);
			        				if(!bakFile.exists()){
			        					bakFile.mkdirs();
			        				}
			        				String makBakFileDir = makeBakDir + "/index_bak.jsp";
			        				CmsHandler.writeFile(makBakFileDir, bak_str);
		        				}else{
		        					model.addAttribute("alert", "index 파일이 없읍니다.");
		        					return "jnit/util/alertBack";
		        				}
	        				}
	        			};
	        		}else if(cancel.equals("disseminatecancel")){ //강제반려
	        			if(!typeLv(typeVO, loginVO, request)){
	    					model.addAttribute("alert", "결제승인 강제취소는 최고 관리자 권한이 있어야합니다.");
	    					return "jnit/util/alertBack";
	    				}
	        			jnitcmsdisseminateVO.setDisseminateConfirm(2);
	        			jnitcmsdisseminateVO.setContentConfirm(6);
	        			jnitcmsdisseminateVO.setMbrId(mbrlists[i]);
	        			jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);

	        			//history
	        			jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("6");
		        		jnitcmsdisseminatehistoryVO.setDisseminateConfirm(6);
		        		jnitcmsdisseminatehistoryVO.setDisseminateLine(disseminatelist);
		        		jnitcmsdisseminatehistoryVO.setHistoryMemo(memo+setMemo);

		        		//암호화 파일 생성
		        		if(cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "N", "disseminatecancel")){
		        			//index 파일 복원
			        		if(ctnfirmDB.equals("5") || ctnfirmDB.equals("1")){
			        			String bakRoot = PathUtil.getRealPath(request)+
			        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/bak/index_bak.jsp";

			        			File bakFile = new File(bakRoot);
			        			if(bakFile.exists()){
			        				String bak_str = CmsHandler.readFile(bakRoot);

				        			String ctxRoot =  PathUtil.getRealPath(request)+
				        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";

				        			CmsHandler.writeFile(ctxRoot, bak_str);
			        			}else{
			        				model.addAttribute("alert", "index 백업 파일이 없습니다.");
			        				return "jnit/util/alertBack";
			        			}
			        		}
		        		}

	        		}else if(cancel.equals("redisseminate")){ //재설정
	        			if(!standDB.equals("1")){
	        				if(!typeLv(typeVO, loginVO, request)){
		    					model.addAttribute("alert", "승인절차가 진행중이므로 최고 관리자 권한이 있어야합니다.");
		    					return "jnit/util/alertBack";
		    				}
	        			}
	        			//log.debug("mbrlists[i] : "+mbrlists[i]);
	        			jnitcmsdisseminateVO.setDisseminateConfirm(0);
	        			jnitcmsdisseminateVO.setContentConfirm(4);
	        			jnitcmsdisseminateVO.setMbrId(mbrlists[i]);
	        			jnitcmsdisseminateVO.setIsdel(1);
	        			jnitcmsdisseminateService.updateJnitcmsdisseminate(jnitcmsdisseminateVO);

	        			//history
		        		jnitcmsdisseminatehistoryVO.setDisseminateConfirm(4);
		        		jnitcmsdisseminatehistoryVO.setDisseminateLine(disseminatelist);
		        		jnitcmsdisseminatehistoryVO.setDiseminateUserconfirm("4");
		        		jnitcmsdisseminatehistoryVO.setHistoryMemo(memo+setMemo);

		        		//암호화 파일 생성
		        		if(cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "Y", "redisseminate")){
		        			String ctxDir = PathUtil.getRealPath(request)+
		        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";

			        		CmsHandler cmsHdr = new CmsHandler(ctxDir, jnitcmscntvtVO.getTplId());
		        			cmsHdr.addPatchCode("SITEID", "<%=cmsClientProperty.siteId%>");
		        	    	cmsHdr.addPatchCode("MENUID", "<%=cmsClientProperty.menuId%>");
		        	    	cmsHdr.addPatchCode("CNTID", "<%=cmsClientProperty.cntId%>");
		        	    	cmsHdr.addPatchCode("TPLID", "<%=cmsClientProperty.tplId%>");

		        	        cmsHdr.addPatchCode("PAGETITLE", "<%=cmsClientProperty.pageTitle%>");
		        			cmsHdr.addPatchCode("PAGEIMGTITLE", "<%=cmsClientProperty.pageImgTitle%>");
		        			cmsHdr.addPatchCode("PAGENAV", "<%=cmsClientProperty.pageNav%>");
		        			cmsHdr.addPatchCode("PAGELINKNAV", "<%=cmsClientProperty.pageLinkNav%>");
		        			cmsHdr.addPatchCode("PAGECODE", "<%=cmsClientProperty.pageCode%>");

		        	        cmsHdr.setContentHeader("<% \\/\\*<!\\-\\- \\[-CONTENT-\\] \\-\\->\\*\\/ %>");
		        	        cmsHdr.setContentFooter("<% \\/\\*<!\\-\\- \\/\\[-CONTENT-\\] \\-\\->\\*\\/ %>");
		        	        String reverseCntSrc = "";
		        	        boolean loadRes = cmsHdr.loadContent();
		        		    if(loadRes == true) {
		        		        reverseCntSrc = cmsHdr.getReverseContent();
		        		    	jnitcmscntVO.setCntSrc(reverseCntSrc);
		        		        jnitcmscntService.updateJnitcmscnt(jnitcmscntVO);
		        			}
		        		}


	        		}
	        	}
	        }
		}

		if(temporary.equals("")){
			jnitcmsdisseminatehistoryService.insertJnitcmsdisseminatehistory(jnitcmsdisseminatehistoryVO);
		}
		//웹표준/접근성 초기화
		JnitcmscntVO cntVO = new JnitcmscntVO();
		cntVO.setCntId(jnitcmscntvtVO.getCntId());
		cntVO.setUpdateCondition("1");
		cntVO.setCntWebStandardCss(0);
		cntVO.setCntWebStandard(0);
		cntVO.setCntWebAccess(0);
		jnitcmscntService.updateJnitcmscnt(cntVO);

		jnitcmshistService.insertJnitcmshist(jnitcmshistVO);
        jnitcmsmenuService.updateJnitcmsmenu(menuVO);
        jnitcmscntService.updateJnitcmscnt(jnitcmscntVO);
        // end 배포시스템

        status.setComplete();
        if(model.get("alert") != null){
        	return "/jnit/util/alertMove";
        }else{
        	return "redirect:/cms/sub11/0101upview.do?cntId="+jnitcmscntvtVO.getCntId();
        }
    }

    public static boolean typeLv(JnitcmsmbrtypeVO typeVO, JnitcmsmbrVO loginVO, HttpServletRequest request)throws Exception{
    	request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    	JnitcmsmbrtypeService jnitcmsmbrtypeService = (JnitcmsmbrtypeService) wContext.getBean("jnitcmsmbrtypeService");

    	typeVO.setTypeId(loginVO.getTypeId());
        typeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(typeVO);

        String typeLv = NullUtil.nullString(typeVO.getTypeLv());

        if(!typeLv.equals("")){
        	if(!typeLv.equals("A")){
        		return false;
        	}
        }
    	return true;
    }

    public static boolean cntWrite(Properties props, JnitcmscntvtVO jnitcmscntvtVO, JnitcmssiteVO siteVO, JnitcmsmenuVO pmenuVO,JnitcmsmenuVO menuVO, HttpServletRequest request, String indexGet, String type )throws Exception{

    	request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
		JnitcmsmenuService jnitcmsmenuService  = (JnitcmsmenuService) wContext.getBean("jnitcmsmenuService");
		JnitcmsmbrService jnitcmsmbrService = (JnitcmsmbrService) wContext.getBean("jnitcmsmbrService");

		JnitcmsorgService jnitcmsorgService = (JnitcmsorgService) wContext.getBean("jnitcmsorgService");
		JnitcmsrankService jnitcmsrankService = (JnitcmsrankService) wContext.getBean("jnitcmsrankService");
		JnitcmsposService jnitcmsposService = (JnitcmsposService) wContext.getBean("jnitcmsposService");

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
        String makDir = PathUtil.getRealPath(request)+
        (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());

        File makDirFile = new File(makDir);
        if(!makDirFile.exists()){
        	makDirFile.mkdirs();
        }

        String dirName = jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());
        String encodeDirName = EgovFileScrty.encode(dirName);

		String cntFile = PathUtil.getRealPath(request)
		+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) +"/"+encodeDirName+".jsp";

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
				//2012.07.19 By.남영강 콘텐츠 내용
				//.replace의 두번째 인자값에 $가 존재 할 경우 오류 발생하여 수정.
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




		String admMbrId = NullUtil.nullString(menuVO.getAdmMbrId());
		HashMap<String, String> admMbrIdMap = new HashMap<String, String>();
		HashMap<String, String> admMap = new HashMap<String, String>();
		HashMap<String, String> admTelMap = new HashMap<String, String>();

		if(!admMbrId.equals("")) {
    		String[] admId = admMbrId.split(",");
    		for(int i=0; i<admId.length; i++){
    			admMbrIdMap.put(Integer.toString(i), admId[i]);
    		}


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
					String mbrTel = NullUtil.nullString(mbrVO1.getTel());
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

					if(!orgNm.equals("")){
	    				adm01 = orgNm+" "+mbrNm;
	    			}else{
	    				adm01 = mbrNm;
	    			}

					admMap.put("0", adm01);
					admTelMap.put("0", mbrTel);

					try {
						if(type.equals("redisseminate")){ //재설정
							SuremSMS.suremSendMessage(mbrVO1.getMbrNm(), "DEFAULT", mbrVO1.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포가 재설정 되었습니다.", "AUTO", null);
						}else if(type.equals("disseminatecancel")){//강제 반려
							SuremSMS.suremSendMessage(mbrVO1.getMbrNm(), "DEFAULT", mbrVO1.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포가 강제반려 되었습니다.", "AUTO", null);
						}
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}

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
					String mbrTel = NullUtil.nullString(mbrVO2.getTel());
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

					if(!orgNm.equals("")){
	    				adm02 = orgNm+" "+mbrNm;
	    			}else{
	    				adm02 = mbrNm;
	    			}

					admMap.put("1", adm02);
					admTelMap.put("1", mbrTel);

					try {
						if(type.equals("redisseminate")){ //재설정
							SuremSMS.suremSendMessage(mbrVO1.getMbrNm(), "DEFAULT", mbrVO1.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포가 재설정 되었습니다.", "AUTO", null);
						}else if(type.equals("disseminatecancel")){//강제 반려
							SuremSMS.suremSendMessage(mbrVO1.getMbrNm(), "DEFAULT", mbrVO1.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포가 강제반려 되었습니다.", "AUTO", null);
						}
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
				}
			}
    	}

		//수정일
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String cntModified = format.format(menuVO.getModified());
		Date date = new Date();
		cntModified = format.format(date);
		//로봇검색여부
		int robotYn = menuVO.getRobotYn();

		// 페이지 Property 세팅
    	props.setProperty("siteId", jnitcmscntvtVO.getSiteId());
    	props.setProperty("menuId", jnitcmscntvtVO.getMenuId());
    	props.setProperty("cntId", jnitcmscntvtVO.getCntId());
    	props.setProperty("tplId", jnitcmscntvtVO.getTplId());
    	/*props.setProperty("admNm", admNm);
    	props.setProperty("admTel", admTel);
    	props.setProperty("admId", admId);*/

    	//담당자1
    	props.setProperty("admId", admMbrIdMap.get("0") == null ? "" : admMbrIdMap.get("0"));
    	props.setProperty("admNm", admMap.get("0") == null ? "" : admMap.get("0"));
    	props.setProperty("admTel", admTelMap.get("0") == null ? "" : admTelMap.get("0"));

    	//담당자2
    	props.setProperty("admId2", admMbrIdMap.get("1") == null ? "" : admMbrIdMap.get("1"));
    	props.setProperty("admNm2", admMap.get("1") == null ? "" : admMap.get("1"));
    	props.setProperty("admTel2", admTelMap.get("1") == null ? "" : admTelMap.get("1"));

    	//수정일
    	props.setProperty("cntModified", cntModified);

    	//로봇검색 여부
    	props.setProperty("robotYn", Integer.toString(robotYn));

    	//부제목
    	props.setProperty("subTitle", jnitcmscntvtVO.getCntDesc());

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
		tempContent = tempContent.replaceAll("\\{\\-PAGETITLE\\-\\}", pageTitleKeyword);
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
		byte[] bip = md.digest( jnitcmscntvtVO.getCntId().getBytes() );
		for(int i=0; i<bip.length; i++) {
			pageIdHash += Integer.toHexString((int) bip[i] & 0x000000ff);
		}
		props.setProperty("pageCode", pageIdHash);
		//tempContent = tempContent.replaceAll("\\{\\-PAGECODE\\-\\}", pageIdHash);
		cmsHdr.addPatchCode("PAGECODE", "<%=cmsClientProperty.pageCode%>");

		// index get 유무
		if(!indexGet.equals("")){
			props.setProperty("indexGet", indexGet);
		}

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

        try {
        	FileOutputStream outStream = new FileOutputStream(propsFile);
        	props.store(outStream,jnitcmscntvtVO.getMenuId()+" (by Jnitcms 3.5)");
        	JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, propsFile);		//Filego 배포
        	if(outStream != null){
        		outStream.close();
        	}
        } catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e.getMessage());
			return false;
		}
    	return true;
    }

    /*cntWrite2*/



    @RequestMapping("/cms/sub11/cntCopy.do")
    public String cntCopy(HttpServletRequest request) throws Exception{
    	//MENU INSERT SELECT
    	JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		String siteId = siteVO.getSiteId();
		String originMenu = NullUtil.nullString(request.getParameter("originMenu"));
		String copyPid = NullUtil.nullString(request.getParameter("copyMenu"));
		String copyNm = NullUtil.nullString(request.getParameter("copyNm"));
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
    	FileOutputStream fos = null;
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
	    	fos = new FileOutputStream(copyPropPath);
	    	props.store(fos, copyMenuVO.getMenuId()+" (by Jnitcms 2.5)");
    	} catch (IOException e){
			log.error(e.getMessage());
    	}catch(Exception e){
    		log.error(e.getMessage());
    	}finally{
    		if(isr != null){
    			isr.close();
    		}
    		if(fis != null){
    			fis.close();
    		}
    		if(fos != null){
    			fos.close();
    		}
    	}
    	return "redirect:/cms/sub10/0101.do";
    }

    @RequestMapping("/disseminate/workspace.do")
    public String workspace(@ModelAttribute("searchVO") JnitcmsdisseminateDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model
    		)throws Exception{

    	String category = NullUtil.nullString(request.getParameter("ancategory"));
    	String contentPath = NullUtil.nullString(request.getParameter("contentPath"));
    	String mode = NullUtil.nullString(request.getParameter("mode"));
    	String sitePath = NullUtil.nullString(request.getParameter("sitePath"));

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

    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	String loginmbrId = loginVO.getMbrId();


    	searchVO.setSearchCondition("3");
    	searchVO.setSearchKeyword(loginmbrId);
    	searchVO.setSearchKeyword2("2");
    	searchVO.setSearchKeyword3(category);
    	List disseminatelist = jnitcmsdisseminateService.selectdisseminateList(searchVO);

    	int totCnt = jnitcmsdisseminateService.selectdisseminateListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	model.addAttribute("pageIndex", searchVO.getPageIndex());
    	model.addAttribute("category", category);
    	Iterator disseminatelistItor = disseminatelist.iterator();
    	String cntId = "";

    	int cntNum = 0;
    	HashMap<String, String> dethPathmap = new HashMap<String, String>(); //결제라인 map
    	HashMap<String, String> dethConfirmMap = new HashMap<String, String>(); //관리 map
    	HashMap<String, String> dethStandMap = new HashMap<String, String>(); //결제 대기자 map

    	String disseminateNum = "";
    	String disseminateConfirm ="";
    	JnitcmsdisseminateVO cntVO = null;

    	// jnitcmsdisseminateVO =  loginVO.get mbrId load
    	for(int i=0; i<disseminatelist.size(); i++) {
			EgovMap disseminatelistMap = (EgovMap) disseminatelistItor.next();
			cntId = NullUtil.nullString(String.valueOf(disseminatelistMap.get("cntId")));
			String disseminateId = NullUtil.nullString(String.valueOf(disseminatelistMap.get("disseminateId")));
			cntVO = new JnitcmsdisseminateVO();
			cntVO.setSearchKeyword(cntId);
			cntVO.setSearchCondition("2");
			cntVO.setPageYn("N");
			List cntIdList = jnitcmsdisseminateService.selectdisseminateList(cntVO);
			cntNum = cntIdList.size();

			// dethPath load = HashMap<String,String> dethPathmap[key+i]
			int k=1;
			String dethPath = "";
			for(Iterator cntIdListItor = cntIdList.iterator(); cntIdListItor.hasNext();) {
		    	String sumNm = "";
		    	String firstB = "";
		    	String lastB = "";

		    	EgovMap cntIdListMap = (EgovMap) cntIdListItor.next();
		    	String posNm = String.valueOf(cntIdListMap.get("posNm"));
		    	String orgNm = String.valueOf(cntIdListMap.get("orgNm"));
		    	String dbmbrId = NullUtil.nullString(String.valueOf(cntIdListMap.get("mbrId")));

		        if(!posNm.equals("null") && !orgNm.equals("null")){
		        	sumNm = posNm +"/"+orgNm;
				}else if(posNm.equals("null") && !orgNm.equals("null")){
					sumNm = orgNm;
				}else if(!posNm.equals("null") && orgNm.equals("null")){
					sumNm = posNm;
				}

		        if(loginmbrId.equals(NullUtil.nullString(dbmbrId))){
					firstB = "<b>";
					lastB = "</b>";
				}

				if(dethPath.equals("")){
					if(sumNm.equals("")){
						dethPath = firstB+NullUtil.nullString(String.valueOf(cntIdListMap.get("mbrNm")))+lastB+" → ";
						if(k == cntNum) dethPath = dethPath.replace(" → ", "");
					}else{
						dethPath = firstB+NullUtil.nullString(String.valueOf(cntIdListMap.get("mbrNm")))+"("+sumNm+")"+lastB+" → ";
						if(k == cntNum) dethPath = dethPath.replace(" → ", "");
					}
				}else if(k < cntNum){
					if(sumNm.equals("")){
						dethPath = dethPath + firstB +NullUtil.nullString(String.valueOf(cntIdListMap.get("mbrNm")))+lastB+" → ";
					}else{
						dethPath = dethPath + firstB +NullUtil.nullString(String.valueOf(cntIdListMap.get("mbrNm")))+"("+sumNm+")"+lastB+" → ";
					}

		        }else if(k == cntNum){
		        	if(sumNm.equals("")){
		        		dethPath = dethPath + firstB + NullUtil.nullString(String.valueOf(cntIdListMap.get("mbrNm")))+lastB;
		        	}else{
		        		dethPath = dethPath + firstB + NullUtil.nullString(String.valueOf(cntIdListMap.get("mbrNm")))+"("+sumNm+")"+lastB;
		        	}
		        }
				k++;
			}
			dethPathmap.put(disseminateId, dethPath);
			// End of dethPath load =  HashMap<String,String> dethPathmap[key+i]


			String stepMbrNm = "";
			disseminateConfirm = NullUtil.nullString(String.valueOf(disseminatelistMap.get("disseminateConfirm")));

			//dethConfirm load = HashMap<String, String> dethConfirmMap[confirm+e]
			if(disseminateConfirm.equals("0")){
				disseminateNum = NullUtil.nullString(String.valueOf(disseminatelistMap.get("disseminateNum")));
				if(disseminateNum.equals("1")){
					dethConfirmMap.put(disseminateId, "<a href='javascript:fn_egov_confirmPass(\""+disseminateId+"\",\""+cntId+"\",\""+disseminateNum+"\");'><span class=\"green_btn\">승인</span></a><a href='javascript:fn_egov_cancel(\""+disseminateId+"\",\""+cntId+"\",\""+disseminateNum+"\");'><span class=\"red_btn\">반려</span></a>");
					String firstSumNm = "";
					String firstOrgNm = NullUtil.nullString(String.valueOf(disseminatelistMap.get("orgNm")));
					String firstPosNm = NullUtil.nullString(String.valueOf(disseminatelistMap.get("posNm")));

					if(!firstPosNm.equals("null") && !firstOrgNm.equals("null")){
						firstSumNm = firstPosNm +"/"+firstOrgNm;
					}else if(firstPosNm.equals("null") && !firstOrgNm.equals("null")){
						firstSumNm = firstOrgNm;
					}else if(!firstPosNm.equals("null") && firstOrgNm.equals("null")){
						firstSumNm = firstPosNm;
					}

					if(firstSumNm.equals("")){
						stepMbrNm = NullUtil.nullString(String.valueOf(disseminatelistMap.get("mbrNm")));
					}else{
						stepMbrNm = NullUtil.nullString(String.valueOf(disseminatelistMap.get("mbrNm")))+"("+firstSumNm+")";
					}
				}else{
					JnitcmsdisseminateVO disseminateNumVO = new JnitcmsdisseminateVO();
					disseminateNumVO.setCntId(cntId);
					int disseminateNums = Integer.parseInt(disseminateNum)-1;
					disseminateNumVO.setDisseminateNum(Integer.toString(disseminateNums));
					JnitcmsdisseminateVO disseminateVO = jnitcmsdisseminateService.selectdisseminate(disseminateNumVO);
					int dethConfirm = disseminateVO.getDisseminateConfirm();
					if(dethConfirm == 0 || dethConfirm == 2){
						dethConfirmMap.put(disseminateId, "<span class=\"orange_btn\">대기중</span>");
					}else{
						dethConfirmMap.put(disseminateId, "<a href='javascript:fn_egov_confirmPass(\""+disseminateId+"\",\""+cntId+"\",\""+disseminateNum+"\");'><span class=\"green_btn\">승인</span></a><a href='javascript:fn_egov_cancel(\""+disseminateId+"\",\""+cntId+"\",\""+disseminateNum+"\");'><span class=\"red_btn\">반려</span></a>");
					}
				}
			}else if(disseminateConfirm.equals("1")){
				dethConfirmMap.put(disseminateId, "<span class=\"green_btn\">승인</span>");
			}else if(disseminateConfirm.equals("2")){
				dethConfirmMap.put(disseminateId, "<span class=\"red_btn\">반려</span>");
			}

			//stepMbrNm load = HashMap<String, String> dethStandMap[stand+e]
			String disseminateStand = NullUtil.nullString(String.valueOf(disseminatelistMap.get("disseminateStand")));
			JnitcmsdisseminateVO disseminateStandVO = new JnitcmsdisseminateVO();
			disseminateStandVO.setCntId(cntId);
			disseminateStandVO.setDisseminateNum(disseminateStand);
			JnitcmsdisseminateVO standVO = jnitcmsdisseminateService.selectdisseminate(disseminateStandVO);

			JnitcmsdisseminateVO setStandVO = new JnitcmsdisseminateVO();
			setStandVO.setSearchCondition("5");
			setStandVO.setSearchKeyword(cntId);
			setStandVO.setSearchKeyword2(standVO.getMbrId());
			setStandVO.setPageYn("N");
			List standList = jnitcmsdisseminateService.selectdisseminateList(setStandVO);
			Iterator standListItor = standList.iterator();

			for(int j=0; j<standList.size(); j++){
				String standSumNm = "";
				EgovMap standListEgovMap = (EgovMap) standListItor.next();
				String standOrgNm = String.valueOf(standListEgovMap.get("orgNm"));
				String standPosNm = String.valueOf(standListEgovMap.get("posNm"));
				String standMbrNm = NullUtil.nullString(String.valueOf(standListEgovMap.get("mbrNm")));
				String standConfirm = NullUtil.nullString(String.valueOf(standListEgovMap.get("disseminateConfirm")));

				if(!standPosNm.equals("null") && !standOrgNm.equals("null")){
					standSumNm = standPosNm +"/"+standOrgNm;
				}else if(standPosNm.equals("null") && !standOrgNm.equals("null")){
					standSumNm = standOrgNm;
				}else if(!standPosNm.equals("null") && standOrgNm.equals("null")){
					standSumNm = standPosNm;
				}

				if(standSumNm.equals("")){
					stepMbrNm = standMbrNm;
				}else{
					stepMbrNm = standMbrNm+"("+standSumNm+")";
				}
			}
			//End of stepMbrNm load = HashMap<String, String> dethStandMap[stand+e]
			dethStandMap.put(disseminateId, stepMbrNm);
			//End of dethConfirm load = HashMap<String, String> dethConfirmMap[confirm+e]
		}
    	//end  jnitcmsdisseminateVO = loginVO.get mbrId load

    	model.addAttribute("mode", mode);
    	model.addAttribute("sitePath", sitePath);
    	model.addAttribute("contentPath", contentPath);
    	model.addAttribute("dethStandMap", dethStandMap);
    	model.addAttribute("dethConfirmMap", dethConfirmMap);
    	model.addAttribute("dethPathmap", dethPathmap);
    	model.addAttribute("resultlist", disseminatelist);
    	return "jnit/cms/disseminate/sub11_workspace";
    }

    @RequestMapping("/cms/disseminate/confirm.do")
    public String confirmPass(HttpServletRequest request, ModelMap model)throws Exception{
    	String anDisseminateId = NullUtil.nullString(request.getParameter("anDisseminateId"));
    	String anCntId= NullUtil.nullString(request.getParameter("anCntId"));
    	String anMemo = NullUtil.nullString(request.getParameter("anMemo"));
    	int anConfirm = NullUtil.nullInt(request.getParameter("anConfirm"));
    	String anNum = NullUtil.nullString(request.getParameter("anNum"));
    	String mode = NullUtil.nullString(request.getParameter("mode"));

    	//session loginVO mbrId load
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	String mbrId = loginVO.getMbrId();
    	//End session loginVO mbrId load

    	String getId = jnitcmsdisseminatehistoryService.getLastIdJnitcmsdisseminatehistory();
    	int setSize = getId.length();
    	String historyId = "HISTORY_"+String.format("%0"+setSize+"d", Integer.parseInt(getId)-1);
    	JnitcmsdisseminatehistoryVO setHistoryVO = new JnitcmsdisseminatehistoryVO();
    	setHistoryVO.setHistoryId(historyId);
    	JnitcmsdisseminatehistoryVO getHistoryVO = jnitcmsdisseminatehistoryService.selectJnitcmsdisseminatehistory(setHistoryVO);
    	String getMemo = getHistoryVO.getHistoryMemo();
    	String[] getMemos = getMemo.split(",");
    	String memo1 = getMemos[0];

    	///setting data history
    	String dethId = "";
    	String siteId = "";
    	String menuId = "";
    	String disseminateType = "";
    	String contentPath = "";
    	JnitcmsdisseminateVO jnitcmsdisseminateVO = new JnitcmsdisseminateVO();
    	jnitcmsdisseminateVO.setSearchKeyword(anCntId);
    	jnitcmsdisseminateVO.setSearchCondition("2");
    	jnitcmsdisseminateVO.setPageYn("N");
    	List cntList = jnitcmsdisseminateService.selectdisseminateList(jnitcmsdisseminateVO);
    	String memo = memo1;
    	if(cntList.size() > 0){
    		Iterator cntIterator = cntList.iterator();
    		for(int i=0; i<cntList.size(); i++){
    			EgovMap cntEogvMap = (EgovMap) cntIterator.next();

    			String disseminateId  = String.valueOf(cntEogvMap.get("disseminateId"));
    			String setMemo = String.valueOf(cntEogvMap.get("disseminateMemo"));
    			String getMbrId = String.valueOf(cntEogvMap.get("mbrId"));

    			siteId = String.valueOf(cntEogvMap.get("siteId"));
    			menuId = String.valueOf(cntEogvMap.get("menuId"));
    			disseminateType = String.valueOf(cntEogvMap.get("disseminateType"));
    			contentPath = String.valueOf(cntEogvMap.get("contentPath"));

    			if(dethId.equals("")){
    				dethId = disseminateId;
    			}else{
    				dethId = dethId+","+disseminateId;
    			}
    			if(mbrId.equals(NullUtil.nullString(getMbrId))){
    				memo += "," + anMemo;
    			}else{
    				memo += ","+ setMemo;
    			}
    		}
    	}

    	Properties props = new Properties();

		JnitcmssiteVO siteVO = new JnitcmssiteVO();
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		JnitcmscntvtVO jnitcmscntvtVO = new JnitcmscntvtVO();
        jnitcmscntvtVO.setSiteId(siteVO.getSiteId());
        jnitcmscntvtVO.setCntId(anCntId);
        jnitcmscntvtVO = jnitcmscntvtService.selectJnitcmscntvt(jnitcmscntvtVO);

		JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
		menuVO.setMenuId(menuId);
		menuVO.setSiteId(siteId);
		menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);

		JnitcmsmenuVO pmenuVO = new JnitcmsmenuVO();
        pmenuVO.setSiteId(jnitcmscntvtVO.getSiteId());
        pmenuVO.setMenuId(menuVO.getPid());
        pmenuVO = jnitcmsmenuService.selectJnitcmsmenu(pmenuVO);

    	JnitcmsdisseminatehistoryVO historyVO = new JnitcmsdisseminatehistoryVO();
    	historyVO.setSiteId(siteId);
    	historyVO.setMenuId(menuId);
    	historyVO.setCntId(anCntId);
    	historyVO.setContentPath(contentPath);
    	historyVO.setDisseminateType(disseminateType);
    	historyVO.setDisseminateLine(dethId);
    	historyVO.setMbrId(mbrId);
    	historyVO.setDiseminateUserconfirm(Integer.toString(anConfirm)); //회원승인여부
    	historyVO.setHistoryMemo(memo);
    	//End of setting data history

    	//resultDisseminateVO = disseminateId select load
    	JnitcmsdisseminateVO disseminateVO = new JnitcmsdisseminateVO();
    	disseminateVO.setDisseminateId(anDisseminateId);
    	JnitcmsdisseminateVO resultDisseminateVO = jnitcmsdisseminateService.selectJnitcmsdisseminate(disseminateVO);
    	//resultDisseminateVO = disseminateId select load

    	//disseminateId status update = disseminateId
    	resultDisseminateVO.setDisseminateId(anDisseminateId);
    	resultDisseminateVO.setMbrId(mbrId);
    	resultDisseminateVO.setDisseminateMemo(anMemo);
    	resultDisseminateVO.setDisseminateConfirm(anConfirm);
    	jnitcmsdisseminateService.updateJnitcmsdisseminate(resultDisseminateVO);
    	//End disseminateId status update

    	if(anConfirm == 1){
    		//disseminateStand status update = cntId
    		JnitcmsdisseminateVO dissemniateNumVO = new JnitcmsdisseminateVO();
    		dissemniateNumVO.setCntId(anCntId);
    		int maxNum = jnitcmsdisseminateService.maxTotCnt(dissemniateNumVO);

        	resultDisseminateVO.setCntId(anCntId);
        	if(Integer.parseInt(anNum) == maxNum){
        		resultDisseminateVO.setContentConfirm(1);
        		resultDisseminateVO.setDisseminateStand(Integer.parseInt(anNum));
        		//history
        		historyVO.setDisseminateConfirm(1);

        		if(cntWrite(props, jnitcmscntvtVO, siteVO, pmenuVO, menuVO, request, "Y" , null)){
        			//암호화 파일 load
    				String dirName = jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());
        			String encodeDirName = EgovFileScrty.encode(dirName);
        			String ctxRoot = PathUtil.getRealPath(request)+
        			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/"+encodeDirName+".jsp";

        			File ctxFile = new File(ctxRoot);
        			if(ctxFile.exists()){
        				String str = CmsHandler.readFile(ctxRoot);

            			//index File write
            			String CtxRoot = PathUtil.getRealPath(request)+
            			jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";
            			CmsHandler.writeFile(CtxRoot, str);
        			}else{
        				model.addAttribute("alert", "임시 파일이 없습니다.\\nFileName : "+encodeDirName);
        				return "jnit/util/alertBack";
        			}

					//index_백업 파일 생성
    				String indexCtxRoot = PathUtil.getRealPath(request)+
    				jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/index.jsp";

    				File indexFile = new File(indexCtxRoot);
    				if(indexFile.exists()){
    					String bak_str = CmsHandler.readFile(indexCtxRoot);

        				String makeBakDir = PathUtil.getRealPath(request)+
        				jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath())+"/bak";

        				File bakFile = new File(makeBakDir);
        				if(!bakFile.exists()){
        					bakFile.mkdirs();
        				}
        				String makBakFileDir = makeBakDir + "/index_bak.jsp";
        				CmsHandler.writeFile(makBakFileDir, bak_str);
    				}else{
    					model.addAttribute("alert", "index 파일이 없읍니다.");
    					return "jnit/util/alertBack";
    				}
        		}
        		jnitcmsdisseminateService.updateNextdisseminate(resultDisseminateVO);
        	}else{
        		resultDisseminateVO.setContentConfirm(0);
        		resultDisseminateVO.setDisseminateStand(Integer.parseInt(anNum) + 1);
        		//history
        		historyVO.setDisseminateConfirm(0);
        		jnitcmsdisseminateService.updateNextdisseminate(resultDisseminateVO);
        		//다음 승인자 SMS 설정
            	JnitcmsdisseminateVO smsDisseminateVO = new JnitcmsdisseminateVO();
            	smsDisseminateVO.setCntId(anCntId);
            	smsDisseminateVO.setDisseminateNum(Integer.toString(Integer.parseInt(anNum) + 1));

            	try {
					smsDisseminateVO = jnitcmsdisseminateService.selectdisseminate(smsDisseminateVO);

	                JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
	                mbrVO.setMbrId(smsDisseminateVO.getMbrId());

					mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
					if(mbrVO.getMbrId() != null){
						SuremSMS.suremSendMessage(mbrVO.getMbrNm(), "DEFAULT", mbrVO.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포 승인대기중입니다.", "AUTO", null);
					}
            	} catch (NullPointerException e){
        			log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				//End of SMS 설정
        	}
        	//End disseminateStand status update
    	}else if(anConfirm == 2){
    		resultDisseminateVO.setCntId(anCntId);
        	resultDisseminateVO.setContentConfirm(2);
        	resultDisseminateVO.setDisseminateStand(Integer.parseInt(anNum));
        	jnitcmsdisseminateService.updateNextdisseminate(resultDisseminateVO);
        	//history
        	historyVO.setDisseminateConfirm(2);

        	//담당자 SMS 전송설정
        	String admMbrId = NullUtil.nullString(menuVO.getAdmMbrId());
    		HashMap<String, String> admMbrIdMap = new HashMap<String, String>();


    		if(!admMbrId.equals("")) {
        		String[] admId = admMbrId.split(",");
        		for(int i=0; i<admId.length; i++){
        			admMbrIdMap.put(Integer.toString(i), admId[i]);
        		}


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
    					SuremSMS.suremSendMessage(mbrVO1.getMbrNm(), "DEFAULT", mbrVO1.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포가 반려되었습니다.", "AUTO", null);
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
    					SuremSMS.suremSendMessage(mbrVO2.getMbrNm(), "DEFAULT", mbrVO2.getMobile(), "DEFAULT", "", menuVO.getMenuNm()+" 관련하여 콘텐츠 배포가 반려되었습니다.", "AUTO", null);
    				}
    			}
        	}
    		//END 담당자 SMS 전송설정

    	}
    	//history
    	jnitcmsdisseminatehistoryService.insertJnitcmsdisseminatehistory(historyVO);

    	JSONObject json = new JSONObject();
    	json.put("message", "정상처리되었습니다.");
    	model.addAttribute("alert", "정상처리되었습니다.");
    	model.addAttribute("path", "/cms/disseminate/workspace.do");
    	model.addAttribute("json", json.toJSONString());

    	if(mode.equals("edit")){
    		return  "jnit/util/json";
    	}else{
    		return  "jnit/util/alertMove";
    	}
    }

    @RequestMapping("/disseminate/memo.do")
	public String memoDo(@ModelAttribute("jnitcmsdisseminateVO") JnitcmsdisseminateVO jnitcmsdisseminateVO
			, HttpServletRequest request, ModelMap model)throws Exception{

		String disseminateId = NullUtil.nullString(request.getParameter("disseminateId"));
		String cntId = NullUtil.nullString(request.getParameter("cntId"));
		String anNum = NullUtil.nullString(request.getParameter("Num"));
		String anConfirm = NullUtil.nullString(request.getParameter("anConfirm"));
		String mode = NullUtil.nullString(request.getParameter("mode"));
		String confirmStr = anConfirm.equals("1") ? "승인" : "반려";

		model.addAttribute("confirmStr", confirmStr);
		model.addAttribute("anConfirm", anConfirm);
		model.addAttribute("anNum", anNum);
		model.addAttribute("cntId", cntId);
		model.addAttribute("disseminateId", disseminateId);

		model.addAttribute("mode", mode);
		return "/jnit/cms/disseminate/history/contentHistory_memo";
	}

    @RequestMapping("/cms/sub11/temp.do")
    public String temp(@ModelAttribute("jnitcmscntvtVO") JnitcmscntvtVO jnitcmscntvtVO
    		, HttpServletRequest request
    		, ModelMap model)throws Exception{

    	if(CmsHelper.getSessionSiteId(request).equals("")) {
    		return "jnit/cms/disseminate/sub11_msg-nosite";
		}

    	//log.debug("jnitcmscntvtVO : "+jnitcmscntvtVO.equals(""));

    	JnitcmscntVO jnitcmscntVO = new JnitcmscntVO();
    	jnitcmscntVO.setSearchCondition("1");
    	jnitcmscntVO.setCntId(jnitcmscntvtVO.getCntId());
    	jnitcmscntVO = jnitcmscntService.selectJnitcmscnt(jnitcmscntVO);

        JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
        menuVO.setSiteId(jnitcmscntvtVO.getSiteId());
        menuVO.setMenuId(jnitcmscntvtVO.getMenuId());
        menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);
        menuVO.setTplId(jnitcmscntvtVO.getTplId());

        JnitcmssiteVO siteVO = new JnitcmssiteVO();
        siteVO.setSiteId(CmsHelper.getSessionSiteId(request));
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

        String makDir = PathUtil.getRealPath(request)+
        (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath());

        //log.debug("makDir : "+makDir);

        File makDirFile = new File(makDir);
        if(!makDirFile.exists()){
        	makDirFile.mkdirs();
        }

		String cntFile = PathUtil.getRealPath(request)
		+ "/" + (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) +"/temp.jsp";

		//log.debug("cntFile : "+cntFile);

    	CmsHandler cmsHdr = new CmsHandler(cntFile, jnitcmscntvtVO.getTplId());
    	cmsHdr.setSiteDir("/"+ siteVO.getSitePath());

        // File 저장
        cmsHdr.setFileHeader("<% response.setHeader(\"Cache-Control\",\"no-store\"); response.setHeader(\"Pragma\",\"no-cache\"); response.setDateHeader(\"Expires\",0); if (request.getProtocol().equals(\"HTTP/1.1\")) { response.setHeader(\"Cache-Control\", \"no-cache\"); } %><%@ page contentType=\"text/html; charset=utf-8\" %><%@ include file='/_common/header.jsp' %>");
        cmsHdr.setContentHeader("<% /*<!-- [-CONTENT-] -->*/ %>");
        cmsHdr.setContentFooter("<% /*<!-- /[-CONTENT-] -->*/ %>");
        cmsHdr.setContent(jnitcmscntvtVO.getCntSrc());
        cmsHdr.saveContent();
        //log.debug("jnitcmscntvtVO.getCntSrc : "+jnitcmscntvtVO.getCntSrc());
    	return null;
    }

    public ModelMap isInculdeSubTpl(HttpServletRequest request
    		, ModelMap model
    		, JnitcmssiteVO siteVO
    		, JnitcmsmenuVO menuVO
    		, String tplId
    		, String cntId )throws Exception{

    	String root = PathUtil.getRealPath(request);
    	String TPL_S_Dir = root+"/"+siteVO.getSitePath()+"/_tpls/B/"+tplId+"_S.jsp";
    	String TPL_E_Dir = root+"/"+siteVO.getSitePath()+"/_tpls/B/"+tplId+"_E.jsp";

    	String makeMenuDirectory = jnitcmsmenuService.makeMenuDirectory(menuVO, siteVO.getSitePath(), request);

    	File TPL_S = new File(TPL_S_Dir);
    	if(TPL_S.exists()){
    		String TPL_S_STR = NullUtil.nullString(CmsHandler.readFile(TPL_S_Dir));
    		if(!"".equals(TPL_S_STR)){
    			if(tplUtil.isSubTplExists(TPL_S_STR, makeMenuDirectory+"/index.jsp")){
    				model.addAttribute("alert","선택하신 서브템플릿은 현재 서브템플릿의 include 문이 선언되어 사용할 수 없습므로 사용안함으로 강제 설정되었습니다.");
    				model.addAttribute("path", "/cms/sub11/0101upview.do?cntId="+cntId);

    			}
    		}
    	}
    	File TPL_E = new File(TPL_E_Dir);
    	if(TPL_E.exists()){
    		String TPL_E_ETR = NullUtil.nullString(CmsHandler.readFile(TPL_E_Dir));
    		if(!"".equals(TPL_E_ETR)){
    			if(tplUtil.isSubTplExists(TPL_E_ETR, makeMenuDirectory+"/index.jsp")){
    				model.addAttribute("alert","선택하신 서브템플릿은 현재 서브템플릿의 include 문이 선언되어 사용할 수 없습므로 사용안함으로 강제 설정되었습니다.");
    				model.addAttribute("path", "/cms/sub11/0101upview.do?cntId="+cntId);
    			}
    		}
    	}
    	if(model.get("alert") != null){
    		menuVO.setTplId(" ");
    		menuVO.setUpdateCondition("1");
    		jnitcmsmenuService.updateJnitcmsmenu(menuVO);

    		JnitcmscntVO cntVO = new JnitcmscntVO();
    		cntVO.setCntId(cntId);
    		cntVO.setTplId(" ");
    		cntVO.setUpdateCondition("2");
    		jnitcmscntService.updateJnitcmscnt(cntVO);
    	}
    	return model;
    }
    @RequestMapping("/cms/help.do")
    public String cmsHelp()throws Exception{
    	return "/jnit/cms/disseminate/help";
    }


}
