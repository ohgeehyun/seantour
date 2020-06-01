/**
 * @version 3.2.0.1
 */
package jnit.cms;

/**
 * 사이트관리
 */
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.TreeMap;
import java.util.WeakHashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.menu.menuUtil;
import jnit.cms.mgmt.mgmtUtil;
import jnit.cms.org.JnitcmsorgService;
import jnit.cms.org.JnitcmsorgVO;
import jnit.cms.pos.JnitcmsposService;
import jnit.cms.pos.JnitcmsposVO;
import jnit.cms.rank.JnitcmsrankService;
import jnit.cms.rank.JnitcmsrankVO;
import jnit.cms.site.JnitcmssiteDefaultVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.cms.tpl.tplUtil;
import jnit.com.util.FileCopy;
import jnit.db.JnitDbUtil;
import jnit.util.FileListUtil;
import jnit.util.PathUtil;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

@Controller
@SessionAttributes(types=JnitcmssiteVO.class)
public class CmsManageSub3Controller {
	
	private Log log = LogFactory.getLog(getClass());
	
    public static final String SEPERATOR = File.separator;
    public static final int BUFFER_SIZE = 8192;
    
    @Resource(name = "jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    @Resource(name = "jnitcmstplService")
    private JnitcmstplService jnitcmstplService;
        
    @Resource(name="jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
    @Resource(name = "jnitcmsorgService")
    private JnitcmsorgService jnitcmsorgService;
    
    @Resource(name = "jnitcmsposService")
    private JnitcmsposService jnitcmsposService;
    
    @Resource(name = "jnitcmsrankService")
    private JnitcmsrankService jnitcmsrankService;
    
    @Autowired
	private DefaultBeanValidator beanValidator;
    
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    
    // 사이트관리 > 사이트리스트
    @RequestMapping(value="/cms/sub3/0101.do")
    public String selectJnitcmssiteList(@ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	AdminUtil.setMenuId("m01040000");
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
		
        List jnitcmssiteList = jnitcmssiteService.selectJnitcmssiteList(searchVO);
        model.addAttribute("resultList", jnitcmssiteList);
        
        int totCnt = jnitcmssiteService.selectJnitcmssiteListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "jnit/cms/sub3_1-1";
    } 
    
    // 사이트관리 > Ajax 사이트리스트
    @RequestMapping(value="/cms/sub3/0101ajax.do")
    public String ajaxJnitcmssiteList(@ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO, 
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	
    	// 사이트정보조회
    	vo.setHaveDetailCondition("Y");
    	vo.setDetailCondition("1");
    	
    	// 사이트전담관리자면
    	/*
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	if(loginVO.getTypeVO().getTypeLv().equals("C")) {
    		vo.setLimitAdmMbrId(loginVO.getMbrId());
    	}
    	*/
    	
    	List siteId_result = jnitcmssiteService.selectSiteIdDetail(vo);
    	TreeMap<Integer, WeakHashMap> siteId_result_hm = new TreeMap();
    	if(siteId_result.size() > 0) {
    		siteId_result_hm.clear();
    		for(int i=0; i<siteId_result.size(); i++) {
    			WeakHashMap<String, String> onceMap = new WeakHashMap<String, String>();
    			onceMap.put("id", ((CmmnDetailCode)siteId_result.get(i)).getCodeDc());
    			onceMap.put("nm", ((CmmnDetailCode)siteId_result.get(i)).getCodeNm());

    			siteId_result_hm.put(i, onceMap);
    		}
    	}
        model.addAttribute("siteId_result", siteId_result_hm);
        siteId_result_hm = null;
    	return "jnit/cms/sub3_1-1-ajax";
    }
    
    // 사이트관리 > 사이트등록 > 폼
    @RequestMapping("/cms/sub3/0102.do")
    public String addJnitcmssiteView(
            @ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO, Model model)
            throws Exception {

    	AdminUtil.setMenuId("m01040000");
        model.addAttribute("nid",  jnitcmssiteService.getLastIdJnitcmssite());
        JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
        jnitcmssiteVO.setSiteOrd(jnitcmssiteService.getNextOrdJnitcmssite());
        
        model.addAttribute("jnitcmssiteVO", jnitcmssiteVO);
        
        return "jnit/cms/sub3_1-2";
    }
    
    @RequestMapping("/cms/sub3/0102add.do")
    public synchronized String addJnitcmssite(
            @ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO,
            @ModelAttribute("jnitcmssiteVO") JnitcmssiteVO jnitcmssiteVO,
            BindingResult bindingResult,
            HttpServletRequest request,
            HttpServletResponse response,
            SessionStatus status,
            Model model)
            throws Exception {
    	
    	beanValidator.validate(jnitcmssiteVO, bindingResult); //validation 수행
		if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
			model.addAttribute("alert","validation 에러가 발생하여 사이트 생성에 실패했습니다.");
        	model.addAttribute("path","/cms/");
        	return "/jnit/util/alertMove";
		}
		
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		String root = PathUtil.getRealPath(request);
		
        // TPL File 저장
        String tplDir = root+ jnitcmssiteVO.getSitePath();
        File f = new File(tplDir);
        if(f.exists()) {
        	model.addAttribute("alert","해당 파일의 경로가 존재합니다.");
        	model.addAttribute("path","/cms/");
        	return "/jnit/util/alertMove";
        }		
		String siteId = jnitcmssiteService.insertJnitcmssite(jnitcmssiteVO);		
		
        f.mkdirs();
        String tplFile;
		tplFile = root + "/default/index.jsp";
		JnitcmstplVO tplVO = new JnitcmstplVO();
		
		//메인템플릿
		tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, tplFile, null, "A", "메인템플릿");
		
		//프린트템플릿
		tplFile = root + "/default/print.jsp";
		tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, tplFile, null, "O", "프린트템플릿");
		
        //File Read		
        String subTplDir = root + "/default/tpl_/subTpl.jsp";
        String subTplContent = CmsHandler.readFile(subTplDir);
        subTplContent = subTplContent.replace("{-SITEPATH-}", jnitcmssiteVO.getSitePath());
        //End of Read
		
		tplVO = new JnitcmstplVO();
			tplVO.setSiteId(siteId);
			tplVO.setTplType("B");
			tplVO.setTplNm("서브템플릿 Sample");
			tplVO.setTplSrc(subTplContent); //Sample Header\n\n{-CONTENT-}\n\nSample Footer
		String tplId = jnitcmstplService.insertJnitcmstpl(tplVO);

        // TPL File 저장
        String f1Path = tplDir + "/_tpls/" + tplVO.getTplType();
		File f1 = new File(f1Path);
		f1.mkdirs();
		
		//서브템플릿 히스토리
		tplUtil.tplHistWrite(request, tplVO, siteId);
		
		//서브템플릿 TPL
		tplVO.setTplId(tplId);
		tplUtil.tplWrite(request, tplVO, jnitcmssiteVO);
        
        //서브템플릿 img 생성
        mgmtUtil.mgmtWrite(request, jnitcmssiteVO, "img", loginVO.getMbrId(), "tpl/B");
        
		//File Read
        tplFile = root + "/default/login.jsp";
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, tplFile, tplId, "C", "로그인템플릿");
        
        // sign Tpl
        String mbrTplDir = root + "/default/mbr/_tpl";
        String mbrDir = root + jnitcmssiteVO.getSitePath()+"/mbr";
        File mbrDirFile = new File(mbrDir);
        if(!mbrDirFile.exists()){
        	mbrDirFile.mkdirs();
        }
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/sign.jsp", tplId,"K", "회원양식절차");
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/signup.jsp", tplId, "D", "회원약관동의");
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/signupAdd.jsp", tplId, "E", "회원가입항목입력");
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/signupSuccess.jsp", tplId, "F", "회원가입완료");
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/myPage.jsp", tplId, "G", "마이페이지");
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/memberCancel.jsp", tplId, "H", "회원탈퇴");
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/idFind.jsp", tplId, "I", "아이디찾기");
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/pwFind.jsp", tplId, "J", "패스워드찾기");
        //tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/signupKid.jsp", tplId, "signupKid.jsp", "L", "만 14세미만 회원가입");
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/noSetpIdFind.jsp", tplId, "M", "아이디 찾기"); //비인증 
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/noSetpPwFind.jsp", tplId,"N", "패스워드찾기"); //비인증
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/noSetpIdResult.jsp", tplId,"M1", "아이디 찾기 결과"); //비인증
        tplUtil.makeTplVO(request, tplVO, jnitcmssiteVO, mbrTplDir+"/noSetpPwResult.jsp", tplId,"N1", "패스워드 찾기 결과"); //비인증
        
        //allim img 생성
		mgmtUtil.mgmtWrite(request, jnitcmssiteVO, "img", loginVO.getMbrId(), "allim");
        
        //board ui img 생성
        mgmtUtil.mgmtWrite(request, jnitcmssiteVO, "img", loginVO.getMbrId(), "board/ui_images");
        
        //파일관리 css,js 카테고리 관리 생성
        mgmtUtil.insertSiteCategory(request, jnitcmssiteVO, tplId);
        
        //사이트 기반의 파일
        sitePathFiles(root,jnitcmssiteVO);
        
        //css 파일생성
        mgmtUtil.mgmtWrite(request, jnitcmssiteVO, "css", loginVO.getMbrId(), "");
        
        //js 파일생성
        mgmtUtil.mgmtWrite(request, jnitcmssiteVO, "js", loginVO.getMbrId(), "");
        
        //css 순서 업데이트 
        mgmtUtil.updateMgmtSort(request, siteId, "css");        
        
        //js 순서 업데이트
        mgmtUtil.updateMgmtSort(request, siteId, "js");
        
        //파일 핸들링
        mgmtUtil.writeFile("사이트생성", "2", "3", jnitcmssiteVO);
        
        //메타태그 핸들링 파일생성
        menuUtil.makeMeta(request, jnitcmssiteVO, "사이트생성");
        
        //사이트 테이블 컬럼 추가
        try {
        	JnitDbUtil.alterTable("ADD","jnitsitestate",jnitcmssiteVO.getSitePath(),"VARCHAR","20","'0'");
        } catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
			//DuplicateKeyException success
		}
        status.setComplete();
        return "redirect:/cms/sub3/0101.do";
    }

	@RequestMapping("/cms/sub3/0102upview.do")
    public String updateJnitcmssiteView(
            @RequestParam("siteId") java.lang.String siteId ,
            @ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO,
            Model model)
            throws Exception {
    	
    	AdminUtil.setMenuId("m01040000");
        JnitcmssiteVO jnitcmssiteVO = new JnitcmssiteVO();
        jnitcmssiteVO.setSiteId(siteId);        
        // 변수명은 CoC 에 따라 jnitcmssiteVO
        jnitcmssiteVO = selectJnitcmssite(jnitcmssiteVO, searchVO);
        model.addAttribute("jnitcmssiteVO", jnitcmssiteVO);
        
    	// MBR정보조회 (ADM_MBR_ID)
        ComDefaultCodeVO comVO = new ComDefaultCodeVO();
    	comVO.setHaveDetailCondition("Y");
    	String admMbrId = "";
    	try {
    		 admMbrId = jnitcmssiteVO.getAdmMbrId().toString();
    		 if(admMbrId.equals("null")) admMbrId = "";
    		 if(admMbrId.trim().isEmpty()) admMbrId = "";
    	} catch (NullPointerException e){
    		admMbrId = "";
    	}catch(Exception e) {
    		admMbrId = "";
    	}
    	HashMap<String, String> admMap = new HashMap<String, String>(); 
    	
    	if(admMbrId.trim() != "") {    	   		
	    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
	    	mbrVO.setMbrId(jnitcmssiteVO.getAdmMbrId());	    	
				
			try {
				mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
			if(mbrVO.getMbrId() != null){
				String mbrNm = NullUtil.nullString(mbrVO.getMbrNm());
				String orgNm = "";
				String posNm = "";
				String rankNm = "";
				String adm01 = "";
				
				//부서
				String orgId = NullUtil.nullString(mbrVO.getOrgId());					
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
				String rankId = NullUtil.nullString(mbrVO.getRankId());
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
				String posId = NullUtil.nullString(mbrVO.getPosId());
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
			model.addAttribute("admMap", admMap);		
    	}
        
        return "jnit/cms/sub3_1-2";
    }

    @RequestMapping("/cms/sub3/0102view.do")
    public @ModelAttribute("jnitcmssiteVO")
    JnitcmssiteVO selectJnitcmssite(
            JnitcmssiteVO jnitcmssiteVO,
            @ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO) throws Exception {
        return jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);
    }

    @RequestMapping("/cms/sub3/0102up.do")
    public String updateJnitcmssite(
            @ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO,
            @ModelAttribute("jnitcmssiteVO") JnitcmssiteVO jnitcmssiteVO,
            BindingResult bindingResult,
            HttpServletRequest request,
            SessionStatus status,
            Model model)
            throws Exception {
    	
    	beanValidator.validate(jnitcmssiteVO, bindingResult); //validation 수행
		if (bindingResult.hasErrors()) { //만일 validation 에러가 있으면...
			return "jnit/cms/sub3_1-2";
		}

		JnitcmssiteVO bVO = jnitcmssiteService.selectJnitcmssite(jnitcmssiteVO);
		
        String newDir = PathUtil.getRealPath(request)
		+ "/" + jnitcmssiteVO.getSitePath();
        String beforeDir = PathUtil.getRealPath(request)
		+ "/" + bVO.getSitePath();
        
        if(!newDir.equals(beforeDir)) {
			File f = new File(newDir);
			if(f.exists()) {
				model.addAttribute("errormsg", "이미 존재하는 경로입니다.");
				return "jnit/cms/sub3_1-2";
			}else {
				File bf = new File(beforeDir);
				bf.renameTo(f);
			}

        }else {
        	jnitcmssiteVO.setSitePath(bVO.getSitePath());
        }

        if(bVO.getSiteId().equals(CmsHelper.getSessionSiteId(request))){
        	CmsSessionVO siteVO = (CmsSessionVO) request.getSession().getAttribute("cmsSessionVO");
        	request.getSession().setAttribute("cmsSessionVO", siteVO);
        }
        
        jnitcmssiteService.updateJnitcmssite(jnitcmssiteVO);
        status.setComplete();
        return "forward:/cms/sub3/0101.do";
    }
    
    @RequestMapping("/cms/sub3/0102del.do")
    public String deleteJnitcmssite(
            JnitcmssiteVO jnitcmssiteVO,
            @ModelAttribute("searchVO") JnitcmssiteDefaultVO searchVO, SessionStatus status)
            throws Exception {
    	
        jnitcmssiteService.deleteJnitcmssite(jnitcmssiteVO);
        
		JnitcmstplVO tplVO = new JnitcmstplVO();
			tplVO.setSiteId(jnitcmssiteVO.getSiteId());
		jnitcmstplService.deleteJnitcmssitetpl(tplVO);
	
        status.setComplete();
        return "forward:/cms/sub3/0101.do";
    }
    
    @RequestMapping("/cms/sub3/backup.do")
    public String backupSite(
    		@RequestParam("sitePath") java.lang.String sitePath,
    		@RequestParam("siteIdx") java.lang.String siteIdx,
            HttpServletRequest request,
            ModelMap model) throws Exception {
    	
    	StringBuffer sb = new StringBuffer();
    	
    	String site = StringUtil.replaceAllRegExp(NullUtil.nullString(sitePath), "", "\\.\\.|\\/|\\\\|\\.\\/|\\.\\\\");
    	String ctxDir = PathUtil.getRealPath(request);
    	String siteDir = ctxDir + SEPERATOR + site;
    	File siteDirFile = new File(siteDir);
    	if("true".equals(deDug)) log.debug("siteDir :"+ siteDir);
    	if(siteDirFile.exists() == false) {
    		
    		model.addAttribute("msg", "E01");
    		return "jnit/msg";
    	}
    	
    	String backupDir = ctxDir + "WEB-INF" + SEPERATOR + "_backup";
    	File backupDirFile = new File(backupDir);
    	if("true".equals(deDug)) log.debug("backupDir :" +backupDir);
    	if(backupDirFile.exists() == false) {
    		backupDirFile.mkdirs();
    	}
    	
    	int errcode = 0;
    	try {
			// Initiate ZipFile object with the path/name of the zip file.
			File oldZipFile = new File(backupDir + SEPERATOR + site + ".zip");
			if(oldZipFile.exists()) {
				boolean delOld = oldZipFile.delete();
				//log.debug(delOld);
			}						
			
			ZipFile zipFile = new ZipFile(oldZipFile.getPath());
			ZipParameters parameters = new ZipParameters();
			parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);
			parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
			parameters.setEncryptFiles(true);
			parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_AES);
			parameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);
			
			// Set password
			parameters.setPassword(EgovProperties.getProperty("Globals.BACKUP.passwd"));
			
			
			String programbackupDir = sb.append(backupDir).append(File.separator).append("tmp").toString();
			//백업에 필요한 파일은 List에 담아서  특정 폴더에 파일 복사 
			List<String> programPageList = this.getProgramPageList(sitePath, siteIdx);
			Iterator<String> programPageListItr = programPageList.iterator();
			String isPath = "";
			while(programPageListItr.hasNext()){
				isPath = programPageListItr.next();
				if(FileListUtil.getFileExists(ctxDir+File.separator+isPath)){		//백업할 폴더 및 파일이 유효하면
					if(new File(ctxDir+File.separator+isPath).isFile()){			//파일 복사
						this.programPageCopy(isPath, programbackupDir, ctxDir);
					}else if(new File(ctxDir+File.separator+isPath).isDirectory()){	//폴더 하위 파일 복사
						FileCopy.copyDirectory(new File(ctxDir+File.separator+isPath), new File(programbackupDir+File.separator+isPath));
					}
				}else{																//백업할 폴더 및 파일이 유효하지 않으면
					
				}
			}
			
			List<String> backupChildrenDirectoryList = FileListUtil.DirectoryList(programbackupDir);
			Iterator<String> backupChildrenDirectoryListItr = backupChildrenDirectoryList.iterator();
			String isBackupChildrenDirectory = "";
			while(backupChildrenDirectoryListItr.hasNext()){
				isBackupChildrenDirectory = backupChildrenDirectoryListItr.next();
				zipFile.addFolder(programbackupDir+File.separator+isBackupChildrenDirectory, parameters);
			}
			zipFile.addFolder(siteDir, parameters);		// ContextPath+site 폴더 통째로 압축에 포함
			FileListUtil.deleteAllFiles(programbackupDir);
	    				
		} catch (ZipException e) {
			errcode = 3;
			log.error(e.getMessage());
		}
		if("true".equals(deDug)) log.debug("errcode : "+errcode);
		if(errcode != 0) {			
			model.addAttribute("msg", "E02"+errcode);
		}else {
			model.addAttribute("msg", "OK");
		}
    	
    	return "jnit/msg";
    }
    
    @RequestMapping("/cms/sub3/backupDownload.do")
    public void backupSiteDownload(
    		@RequestParam("sitePath") java.lang.String sitePath,
            HttpServletRequest request,
            HttpServletResponse response,
            ModelMap model) throws Exception {
    	
    	String site = StringUtil.replaceAllRegExp(NullUtil.nullString(sitePath), "", "\\.\\.|\\/|\\\\|\\.\\/|\\.\\\\");
    	String ctxDir = PathUtil.getRealPath(request);
   	   	String backupDir = ctxDir + SEPERATOR + "WEB-INF" + SEPERATOR + "_backup";
    	File backupFile = new File(backupDir + SEPERATOR + site + ".dat");
    	if(backupFile.exists() == false) {
    		throw new FileNotFoundException("다운로드할 파일 없음.");
    	}
    	downloadFileExec(request, response, backupFile.getPath());
    }
    
    public void downloadFileExec(HttpServletRequest request, HttpServletResponse response, String filePath) throws Exception {
    	File file = new File(EgovWebUtil.filePathBlackList(filePath));

    	if (!file.exists()) {
    	    throw new FileNotFoundException(filePath);
    	}

    	if (!file.isFile()) {
    	    throw new FileNotFoundException(filePath);
    	}

    	byte[] b = new byte[BUFFER_SIZE];

    	String original = file.getName();
    	if(request.getHeader("User-Agent").contains("MSIE")) { 

    		original =  java.net.URLDecoder.decode(original, "8859_1");
    		original =  java.net.URLEncoder.encode(original, "UTF-8");
    		//original = new String(original.getBytes("UTF-8"), "ISO-8859-1");
    		//original = URLEncoder.encode(original, "UTF-8");
    		//original = new String(original.getBytes("MS949"), "ISO-8859-1");
    		original = original.replaceAll("\\+", " "); 
    	} else if(request.getHeader("User-Agent").contains("Mozilla")) {
    		original = new String(original.getBytes("UTF-8"), "ISO-8859-1"); 
    	} 
    	
    	response.setContentType("application/octet-stream;");
    	response.setHeader("Content-Disposition", "attachment; filename=\"" + original + "\";");
    	response.setHeader("Content-Transfer-Encoding", "binary");
    	response.setHeader("Pragma", "no-cache");
    	response.setHeader("Expires", "0");

    	BufferedInputStream fin = null;
    	BufferedOutputStream outs = null;
    	FileInputStream fis = null;
	    	try {
	    		fis = new FileInputStream(file);
	    	    fin = new BufferedInputStream(fis);
	    	    outs = new BufferedOutputStream(response.getOutputStream());
	
	    	    int read = 0;
	
	    	    while ((read = fin.read(b)) != -1) {
		    		outs.write(b, 0, read);
	    	    }
	    	} finally {
	    	    if (outs != null) {
	    	    	outs.close();
	    	    }
	
	    	    if (fin != null) {
	    	    	fin.close();
	    	    }
				if(fis != null){
					fis.close();
				}
	    	}

    }
    public void sitePathFiles(String root,JnitcmssiteVO jnitcmssiteVO) throws Exception {
	  //setting menuTree sub    	
	    String setMenuSubDir = root+"WEB-INF/jsp/jnit/cms/menu/sub.jsp";
	    String setMenuSubSrc = CmsHandler.readFile(setMenuSubDir);	    
	    String mkrMenuSubDir = root+"WEB-INF/jsp/jnit/cms/menu/sitemenu";
	    String cmsmenuDir = root + "WEB-INF/jsp/jnit/cms/menu";
	    String rootSite = root+jnitcmssiteVO.getSitePath();
	    String baseCommon = root+"/default/common";
	    String setSearchJSONDir = root+"WEB-INF/jsp/jnit/cms/search/JSON"; 
	    
	    File menuTreeFile = new File(mkrMenuSubDir);
	    if(!menuTreeFile.exists()){
	    	menuTreeFile.mkdir();
	    }
	    String setmkrMenuSubDir = mkrMenuSubDir + "/"+jnitcmssiteVO.getSitePath()+"_sub.jsp";             
	    CmsHandler.writeFile(setmkrMenuSubDir, setMenuSubSrc);
	    //End of setting menuTree sub
	    
	    //setting menuTree sub_code
	    String setMenuSubCodeDir = root+"WEB-INF/jsp/jnit/cms/menu/sub_code.jsp";
	    String setMenuSubCodeSrc = CmsHandler.readFile(setMenuSubCodeDir);
	    
	    String setmkrMenuSubCodeDir = mkrMenuSubDir + "/"+jnitcmssiteVO.getSitePath()+"_sub_code.jsp";
	    CmsHandler.writeFile(setmkrMenuSubCodeDir, setMenuSubCodeSrc);
	    //End setting menuTree sub_code
	    
	    //setting menuTree original_sub_code
	    String setMenuOriginSubCodeDir = root+"WEB-INF/jsp/jnit/cms/menu/original_sub_code.jsp";
	    String setMenuOriginSubCodeSrc = CmsHandler.readFile(setMenuOriginSubCodeDir);
	    
	    String setmkrMenuOriginSubCodeDir = mkrMenuSubDir + "/" + jnitcmssiteVO.getSitePath()+"_original_sub_code.jsp";
	    CmsHandler.writeFile(setmkrMenuOriginSubCodeDir, setMenuOriginSubCodeSrc);
	    //setting menuTree original_sub_code
	    
	    //setting CntAmin 
	    String setCntAminDir = root+"cms/import/content_admin.jsp";
	    String setCntAminSrc = CmsHandler.readFile(setCntAminDir);
	    String setmkrCntAminDir =root+"cms/import/"+jnitcmssiteVO.getSitePath()+"_content_admin.jsp";             
	    CmsHandler.writeFile(setmkrCntAminDir, setCntAminSrc);
	    
	    String setCntAminCodeDir = root+"cms/import/content_admin_code.jsp";
	    String setCntAminCodeSrc = CmsHandler.readFile(setCntAminCodeDir);
	    String setCntAminSubCodeDir = root+"cms/import/"+jnitcmssiteVO.getSitePath()+"_content_admin_code.jsp";
	    CmsHandler.writeFile(setCntAminSubCodeDir, setCntAminCodeSrc);
	    
	    String setUpdateBtnDir = root+"cms/import/updateButton.jsp";
	    String setUpdateBtnSrc = CmsHandler.readFile(setUpdateBtnDir);
	    String setmkrUpdateBtnDir =root+"cms/import/"+jnitcmssiteVO.getSitePath()+"_updateButton.jsp";             
	    CmsHandler.writeFile(setmkrUpdateBtnDir, setUpdateBtnSrc);
	    
	    String setUpdateBtnCodeDir = root+"cms/import/updateButton_code.jsp";
	    String setUpdateBtnCodeSrc = CmsHandler.readFile(setUpdateBtnCodeDir);
	    String setUpdateBtnSubCodeDir = root+"cms/import/"+jnitcmssiteVO.getSitePath()+"_updateButton_code.jsp";
	    CmsHandler.writeFile(setUpdateBtnSubCodeDir, setUpdateBtnCodeSrc);
	    
	    //알리미 생성
	    String baseAllimDir = root+"WEB-INF/jsp/jnit/allim/default/allim";
	    String copyAllimDir = root+"WEB-INF/jsp/jnit/allim/skin/allim";	    
	    FileCopy.type = "exists";	    
	    File baseAllim = new File(baseAllimDir);	    
	    File copyAllim = new File(copyAllimDir);
	    if(!copyAllim.exists()) copyAllim.mkdirs();
	    FileCopy.copyDirectory(baseAllim, copyAllim);
	    
	    //배너생성
 	    String baseBannerDir = root+"WEB-INF/jsp/jnit/allim/default/banner";
	    String copyBannerDir = root+"WEB-INF/jsp/jnit/allim/skin/banner";	    
	    File baseBanner = new File(baseBannerDir);
	    File copyBanner = new File(copyBannerDir);
	    if(!copyBanner.exists()) copyBanner.mkdirs();
	    FileCopy.copyDirectory(baseBanner, copyBanner);
	    FileCopy.type = null;
	    
	    //팝업생성
 	    String basePopupDir = root+"WEB-INF/jsp/jnit/allim/default/popup";
	    String copyPopupDir = root+"WEB-INF/jsp/jnit/allim/skin/popup";	    
	    File basePopup = new File(basePopupDir);
	    File copyPopup = new File(copyPopupDir);
	    if(!copyPopup.exists()) copyPopup.mkdirs();
	    FileCopy.copyDirectory(basePopup, copyPopup);
	    FileCopy.type = null;
	    
	    String setRshListProgDir = root+"WEB-INF/jsp/jnit/research/userview/listProgress.jsp";
	    String setRshListProgSrc = CmsHandler.readFile(setRshListProgDir);
	    String setmkrRshListProgDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_listProgress.jsp";             
	    CmsHandler.writeFile(setmkrRshListProgDir, setRshListProgSrc);
	    
	    String setRshListProgCodeDir = root+"WEB-INF/jsp/jnit/research/userview/listProgress_code.jsp";
	    String setRshListProgCodeSrc = CmsHandler.readFile(setRshListProgCodeDir);
	    String setmkrRshListProgCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_listProgress_code.jsp";             
	    CmsHandler.writeFile(setmkrRshListProgCodeDir, setRshListProgCodeSrc);
	    
	    String setOriRshListProgCodeDir = root+"WEB-INF/jsp/jnit/research/userview/original_listProgress_code.jsp";
	    String setOriRshListProgCodeSrc = CmsHandler.readFile(setOriRshListProgCodeDir);
	    String setmkrOriRshListProgCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_original_listProgress_code.jsp";             
	    CmsHandler.writeFile(setmkrOriRshListProgCodeDir, setOriRshListProgCodeSrc);
	    
	    String setRshListEndDir = root+"WEB-INF/jsp/jnit/research/userview/listEnd.jsp";
	    String setRshListEndSrc = CmsHandler.readFile(setRshListEndDir);
	    String setmkrRshListEndDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_listEnd.jsp";             
	    CmsHandler.writeFile(setmkrRshListEndDir, setRshListEndSrc);
	    
	    String setRshListEndCodeDir = root+"WEB-INF/jsp/jnit/research/userview/listEnd_code.jsp";
	    String setRshListEndCodeSrc = CmsHandler.readFile(setRshListEndCodeDir);
	    String setmkrRshListEndCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_listEnd_code.jsp";             
	    CmsHandler.writeFile(setmkrRshListEndCodeDir, setRshListEndCodeSrc);
	    
	    String setOriRshListEndCodeDir = root+"WEB-INF/jsp/jnit/research/userview/original_listEnd_code.jsp";
	    String setOriRshListEndCodeSrc = CmsHandler.readFile(setOriRshListEndCodeDir);
	    String setmkrOriRshListEndCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_original_listEnd_code.jsp";             
	    CmsHandler.writeFile(setmkrOriRshListEndCodeDir, setOriRshListEndCodeSrc);
	    
	    String setRshRespondentRegisterDir = root+"WEB-INF/jsp/jnit/research/userview/respondentRegister.jsp";
	    String setRshRespondentRegisterSrc = CmsHandler.readFile(setRshRespondentRegisterDir);
	    String setmkrRshRespondentRegisterDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_respondentRegister.jsp";             
	    CmsHandler.writeFile(setmkrRshRespondentRegisterDir, setRshRespondentRegisterSrc);
	    
	    String setRshRespondentRegisterCodeDir = root+"WEB-INF/jsp/jnit/research/userview/respondentRegister_code.jsp";
	    String setRshRespondentRegisterCodeSrc = CmsHandler.readFile(setRshRespondentRegisterCodeDir);
	    String setmkrRshRespondentRegisterCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_respondentRegister_code.jsp";             
	    CmsHandler.writeFile(setmkrRshRespondentRegisterCodeDir, setRshRespondentRegisterCodeSrc);
	    
	    String setOriRshRespondentRegisterCodeDir = root+"WEB-INF/jsp/jnit/research/userview/original_respondentRegister_code.jsp";
	    String setOriRshRespondentRegisterCodeSrc = CmsHandler.readFile(setOriRshRespondentRegisterCodeDir);
	    String setmkrOriRshRespondentRegisterCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_original_respondentRegister_code.jsp";             
	    CmsHandler.writeFile(setmkrOriRshRespondentRegisterCodeDir, setOriRshRespondentRegisterCodeSrc);
	    
	    String setRshstatsUserViewDir = root+"WEB-INF/jsp/jnit/research/userview/statsUserView.jsp";
	    String setRshstatsUserViewSrc = CmsHandler.readFile(setRshstatsUserViewDir);
	    String setmkrRshstatsUserViewDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_statsUserView.jsp";             
	    CmsHandler.writeFile(setmkrRshstatsUserViewDir, setRshstatsUserViewSrc);
	    
	    String setRshstatsUserViewCodeDir = root+"WEB-INF/jsp/jnit/research/userview/statsUserView_code.jsp";
	    String setRshstatsUserViewCodeSrc = CmsHandler.readFile(setRshstatsUserViewCodeDir);
	    String setmkrRshstatsUserViewCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_statsUserView_code.jsp";             
	    CmsHandler.writeFile(setmkrRshstatsUserViewCodeDir, setRshstatsUserViewCodeSrc);
	    
	    String setOriRshstatsUserViewCodeDir = root+"WEB-INF/jsp/jnit/research/userview/original_statsUserView_code.jsp";
	    String setOriRshstatsUserViewCodeSrc = CmsHandler.readFile(setOriRshstatsUserViewCodeDir);
	    String setmkrOriRshstatsUserViewCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_original_statsUserView_code.jsp";             
	    CmsHandler.writeFile(setmkrOriRshstatsUserViewCodeDir, setOriRshstatsUserViewCodeSrc);
	    
	    String setRshresearchImportDir = root+"WEB-INF/jsp/jnit/research/userview/researchImport.jsp";
	    String setRshresearchImportSrc = CmsHandler.readFile(setRshresearchImportDir);
	    String setmkrRshresearchImportDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_researchImport.jsp";             
	    CmsHandler.writeFile(setmkrRshresearchImportDir, setRshresearchImportSrc);
	    
	    String setRshresearchImportCodeDir = root+"WEB-INF/jsp/jnit/research/userview/researchImport_code.jsp";
	    String setRshresearchImportCodeSrc = CmsHandler.readFile(setRshresearchImportCodeDir);
	    String setmkrRshresearchImportCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_researchImport_code.jsp";             
	    CmsHandler.writeFile(setmkrRshresearchImportCodeDir, setRshresearchImportCodeSrc);
	    
	    String setOriRshresearchImportCodeDir = root+"WEB-INF/jsp/jnit/research/userview/original_researchImport_code.jsp";
	    String setOriRshresearchImportCodeSrc = CmsHandler.readFile(setOriRshresearchImportCodeDir);
	    String setmkrOriRshresearchImportCodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_original_researchImport_code.jsp";             
	    CmsHandler.writeFile(setmkrOriRshresearchImportCodeDir, setOriRshresearchImportCodeSrc);
	    
	    String setRshresearchprocDir = root+"WEB-INF/jsp/jnit/research/userview/researchproc.jsp";
	    String setRshresearchprocSrc = CmsHandler.readFile(setRshresearchprocDir);
	    String setmkrRshresearchprocDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_researchproc.jsp";             
	    CmsHandler.writeFile(setmkrRshresearchprocDir, setRshresearchprocSrc);

	    String setanswerPopupDir = root+"WEB-INF/jsp/jnit/research/userview/answerPopup.jsp";
	    String setanswerPopupSrc = CmsHandler.readFile(setanswerPopupDir);
	    String setmkranswerPopupDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_answerPopup.jsp";             
	    CmsHandler.writeFile(setmkranswerPopupDir, setanswerPopupSrc);
	    
	    String setanswerPopupcodeDir = root+"WEB-INF/jsp/jnit/research/userview/answerPopup_code.jsp";
	    String setanswerPopupcodeSrc = CmsHandler.readFile(setanswerPopupcodeDir);
	    String setmkranswerPopupcodeDir =root+"WEB-INF/jsp/jnit/research/userview/"+jnitcmssiteVO.getSitePath()+"_answerPopup_code.jsp";             
	    CmsHandler.writeFile(setmkranswerPopupcodeDir, setanswerPopupcodeSrc);
	    
	    String setRscDir = root+"WEB-INF/jsp/jnit/rsc/Uaddpage.jsp";
	    String setRscSrc = CmsHandler.readFile(setRscDir);
	    String setmkrRscDir =root+"WEB-INF/jsp/jnit/rsc/"+jnitcmssiteVO.getSitePath()+"_Uaddpage.jsp";             
	    CmsHandler.writeFile(setmkrRscDir, setRscSrc);
	    
	    String setRscCodeDir = root+"WEB-INF/jsp/jnit/rsc/Uaddpage_code.jsp";
	    String setRscCodeSrc = CmsHandler.readFile(setRscCodeDir);
	    String setmkrRscCodeDir =root+"WEB-INF/jsp/jnit/rsc/"+jnitcmssiteVO.getSitePath()+"_Uaddpage_code.jsp";             
	    CmsHandler.writeFile(setmkrRscCodeDir, setRscCodeSrc);
	    
	    String setRscUpDir = root+"WEB-INF/jsp/jnit/rsc/upPage.jsp";
	    String setRscUpSrc = CmsHandler.readFile(setRscUpDir);
	    String setmkrRscUpDir =root+"WEB-INF/jsp/jnit/rsc/"+jnitcmssiteVO.getSitePath()+"_upPage.jsp";             
	    CmsHandler.writeFile(setmkrRscUpDir, setRscUpSrc);
	    
	    String setRscUpCodeDir = root+"WEB-INF/jsp/jnit/rsc/upPage_code.jsp";
	    String setRscUpCodeSrc = CmsHandler.readFile(setRscUpCodeDir);
	    String setmkrRscUpCodeDir =root+"WEB-INF/jsp/jnit/rsc/"+jnitcmssiteVO.getSitePath()+"_upPage_code.jsp";             
	    CmsHandler.writeFile(setmkrRscUpCodeDir, setRscUpCodeSrc);
	    
	    String mkeSiateFolder = cmsmenuDir + "/sitemap";
	    File siteFolder = new File(mkeSiateFolder);
	    if(!siteFolder.exists()) siteFolder.mkdirs();
	    
	    String setSiteMapCodeDir = cmsmenuDir+"/sitemap_code.jsp";
	    String setSiteMapCodeSrc = CmsHandler.readFile(setSiteMapCodeDir);
	    String setmkrStieMapCode = cmsmenuDir+"/sitemap/"+jnitcmssiteVO.getSitePath()+"_sitemap_code.jsp";
	    CmsHandler.writeFile(setmkrStieMapCode, setSiteMapCodeSrc);
	    
	    String setSiteMapDir = cmsmenuDir+"/sitemap.jsp";
	    String setSiteMapSrc = CmsHandler.readFile(setSiteMapDir);
	    String setmkrStieMap = cmsmenuDir+"/sitemap/"+jnitcmssiteVO.getSitePath()+"_sitemap.jsp";
	    CmsHandler.writeFile(setmkrStieMap, setSiteMapSrc);
	    
	    
	    //	mbrInfo_siteId.prop create / 기본설정 - 가입항목설정
	    String itemConfigDir = root+"WEB-INF/config/jnit";
	    String mbrInfoDir = itemConfigDir + "/mbrInfo";
	    String itemConfigFile = mbrInfoDir +"/mbrInfo_"+jnitcmssiteVO.getSiteId()+".prop";        
	    
	    File itemConfig = new File(itemConfigDir); // /WEB-INF/config/jnit
	    if(!itemConfig.exists()){
	    	itemConfig.mkdirs(); 
	    }
	    
	    File mbrInfo = new File(mbrInfoDir); // /WEB-INF/config/jnit/mbrInfo
	    if(!mbrInfo.exists()){
	    	mbrInfo.mkdirs();
	    }
	    
	    Properties itemConfigProp = new Properties();
	    
	    // Sample Properties 
	    
	    //기본정보
	    itemConfigProp.setProperty("tel", "1"); 							//전화번호
	    itemConfigProp.setProperty("phone", "1");							//휴대폰
	    itemConfigProp.setProperty("email", "1");							//이메일
	    itemConfigProp.setProperty("post", "1");							//우편번호
	    itemConfigProp.setProperty("addr", "1");							//주소
	    itemConfigProp.setProperty("emailRecv", "1");						//메일 수신 동의
	    itemConfigProp.setProperty("smsRecv", "1");							//sms 수신 동의
	    
	    //단체 회원 가입
	    itemConfigProp.setProperty("personal", "1");						//개인사업자
	    itemConfigProp.setProperty("profit", "1");							//영리법인 
	    itemConfigProp.setProperty("nonprofit", "1");						//비영리 법인
	    itemConfigProp.setProperty("organization", "1");					//공식단체
	    itemConfigProp.setProperty("mutual", "1");							//상호
	    itemConfigProp.setProperty("corporateName", "1");					//법인명
	    itemConfigProp.setProperty("groupName", "1");						//대표자명
	    itemConfigProp.setProperty("businessPlace", "1");					//사업장 소재지
	    itemConfigProp.setProperty("businessAddr", "1");					//사업장 주소
	    itemConfigProp.setProperty("groupKind", "1");						//대표 종목
	    itemConfigProp.setProperty("groupTel", "1");						//대표 전화번호
	    itemConfigProp.setProperty("groupPax", "1");						//대표 팩스
	    itemConfigProp.setProperty("groupTitle", "1");						//회사명
	    itemConfigProp.setProperty("gradeNm", "1");							//직책
	    
	    
	    //추가입력
	    itemConfigProp.setProperty("ex01", "여분필드1");
	    itemConfigProp.setProperty("ex01Add", "0");
	    itemConfigProp.setProperty("ex01Type", "0");
	    itemConfigProp.setProperty("ex01TypeFields", "");
	    
	    itemConfigProp.setProperty("ex02", "여분필드2");
	    itemConfigProp.setProperty("ex02Add", "0");
	    itemConfigProp.setProperty("ex02Type", "0");
	    itemConfigProp.setProperty("ex02TypeFields", "");
	    
	    itemConfigProp.setProperty("ex03", "여분필드3");
	    itemConfigProp.setProperty("ex03Add", "0");
	    itemConfigProp.setProperty("ex03Type", "0");
	    itemConfigProp.setProperty("ex03TypeFields", "");
	    
	    itemConfigProp.setProperty("captcha", "0");
		FileOutputStream fos = new FileOutputStream(itemConfigFile);
		itemConfigProp.store(fos, "(by Jnitcms 3.5)");
		if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
	    // End of mbrInfo.stieId.prop
	    
	    //기본설정-일반설정 생성 prop
	    String defaultDir = root + "WEB-INF/config/jnit";
	    File defaultDirFile = new File(defaultDir);
	    if(!defaultDirFile.exists()){
	    	defaultDirFile.mkdirs();
	    }
	    String defaultFileDir = defaultDir+"/defaultProp.prop";
	    Properties defaultProp = new Properties();
	    File defaultFile = new File(defaultFileDir);
	    if(!defaultFile.exists()){
	    	 defaultProp.setProperty("siauth", "0");		//실명인증
	         defaultProp.setProperty("gpinauth", "0");		//G-PIN
	         defaultProp.setProperty("pkiauth", "0");		//GPKI
	         defaultProp.setProperty("ssl", "0");			//SSL
	         defaultProp.setProperty("sso", "1");			//SSO
	         defaultProp.setProperty("overlap", "0");		//중복로그인
	         defaultProp.setProperty("redirectPath", ""); 	//redirect경로
			 fos = new FileOutputStream(defaultFileDir);
			 defaultProp.store(fos, "(by Jnitcms 3.5)");
			 if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
	    }
	    //END 기본설정-일반설정 prop
	    
	    //보안설정
	    String secureDir = root+"WEB-INF/config/jnit";
	    String securePath = root+"WEB-INF/config/jnit/secureProp.prop";
	    Properties secureProps = new Properties();
		File secureFile = new File(secureDir);
		if(!secureFile.exists()){
			secureFile.mkdir();
		}
		
		File securePathFile = new File(securePath);
		if(!securePathFile.exists()){
			secureProps.setProperty("secpw", "sha-256");
	    	secureProps.setProperty("ipFilterType", "no");
	    	
	    	fos = new FileOutputStream(securePath);
			secureProps.store(fos, "(by Jnitcms 3.5)");
			if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
		}
		//END 보안설정
		
		//fonts
		String basefontsDir = baseCommon+"/fonts";
		String fontsDir = rootSite+"/common/fonts";
		File basefonts = new File(basefontsDir);
		File fonts = new File(fontsDir);
		FileCopy.copyDirectory(basefonts, fonts);
		
		//통합검색 JSON
		/*
		File searchJSON = new File(setSearchJSONDir);
		if(!searchJSON.exists()) searchJSON.mkdirs();
		JnitcmssearchVO jnitcmssearchVO = new JnitcmssearchVO();
		CmsHandler.writeFile(setSearchJSONDir+"/"+jnitcmssiteVO.getSitePath()+"_search.json", new JSONObject().fromObject(jnitcmssearchVO).toString());
		*/
	}
    
    private static List<String> getProgramPageList(String sitePath, String siteIdx){
    	
    	List<String> programPageList = new ArrayList<String>();
    	
    	programPageList.add("/cms/import/"+sitePath+"_content_admin_code.jsp");
    	programPageList.add("/cms/import/"+sitePath+"_content_admin.jsp");
    	programPageList.add("/cms/import/"+sitePath+"_updateButton_code.jsp");
    	programPageList.add("/cms/import/"+sitePath+"_updateButton.jsp");
    	programPageList.add("/WEB-INF/config/jnit/mbrInfo/mbrInfo_"+siteIdx+".prop");
    	programPageList.add("/WEB-INF/jsp/jnit/cms/menu/sitemap/"+sitePath+"_sitemap_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/cms/menu/sitemap/"+sitePath+"_sitemap.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/cms/menu/sitemenu/"+sitePath+"_sub.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/cms/menu/sitemenu/"+sitePath+"_sub_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/cms/menu/sitemenu/"+sitePath+"_original_sub_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/cms/menu/topmenu/");
    	programPageList.add("/WEB-INF/jsp/jnit/cms/search/JSON/"+sitePath+"_search.json");
    	programPageList.add("/WEB-INF/jsp/jnit/rsc/"+sitePath+"_Uaddpage_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/rsc/"+sitePath+"_Uaddpage.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/rsc/"+sitePath+"_upPage_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/rsc/"+sitePath+"_upPage.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/board/latest/skin/"+siteIdx);
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_answerPopup_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_answerPopup.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_listEnd_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_listEnd.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_listProgress_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_listProgress.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_original_listEnd_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_original_listProgress_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_original_researchImport_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_original_respondentRegister_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_original_statsUserView_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_researchImport_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_researchImport.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_researchproc.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_respondentRegister_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_respondentRegister.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_statsUserView_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/research/userview/"+sitePath+"_statsUserView.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/allim/default/banner/"+sitePath+"_bannerMore_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/allim/default/banner/"+sitePath+"_bannerMore.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/allim/default/banner/"+sitePath+"_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/allim/default/banner/"+sitePath+".jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/allim/skin/banner/"+sitePath+"_bannerMore_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/allim/skin/banner/"+sitePath+"_bannerMore.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/allim/skin/banner/"+sitePath+"_code.jsp");
    	programPageList.add("/WEB-INF/jsp/jnit/allim/skin/banner/"+sitePath+".jsp");
    	
    	return programPageList;
    }
    
    private void programPageCopy(String sourcelocation , String targetlocation, String base) throws IOException{
    	
		targetlocation = targetlocation + File.separator + sourcelocation;
		sourcelocation = base + File.separator + sourcelocation;
		File isFile = new File(targetlocation);
		File isDirectory = new File(isFile.getParent());
		
		if(!isDirectory.isDirectory()){
			if(isDirectory.exists()){
				
			}else{
				isDirectory.mkdirs();
			}
		}else{
			
		}
		
		InputStream in = new FileInputStream(sourcelocation);
	    OutputStream out = new FileOutputStream(targetlocation);
	    
	    // Copy the bits from instream to outstream
		byte[] buf = new byte[1024];
		int len;				
    	while ((len = in.read(buf)) > 0) {
            out.write(buf, 0, len);
        }
    	 if(in != null){
        	in.close();
    	 }
    	 if(out != null){
        	out.close();
    	 }
	}
}