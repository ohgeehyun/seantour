/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmt;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jnit.board.data.JnitBoardDataService;
import jnit.board.data.JnitBoardDataVO;
import jnit.board.info.JnitboardinfoService;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.boardhist.JnitcmsboardhistDefaultVO;
import jnit.cms.boardhist.JnitcmsboardhistService;
import jnit.cms.boardhist.JnitcmsboardhistVO;
import jnit.cms.csshist.JnitcmscsshistDefaultVO;
import jnit.cms.csshist.JnitcmscsshistService;
import jnit.cms.csshist.JnitcmscsshistVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.scripthist.JnitcmsscripthistDefaultVO;
import jnit.cms.scripthist.JnitcmsscripthistService;
import jnit.cms.scripthist.JnitcmsscripthistVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : JnitcmsmgmtController.java
 * @Description : Jnitcmsmgmt Controller class
 * @Modification Information
 *
 * @author JNITCMSMGMT
 * @since 2014.04.16
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitcmsmgmtVO.class)
public class JnitcmsmgmtController {

	public static Log log = LogFactory.getLog(JnitcmsmgmtController.class);
	
    @Resource(name = "jnitcmsmgmtService")
    private JnitcmsmgmtService jnitcmsmgmtService;

    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name = "jnitcmscsshistService")
    private JnitcmscsshistService jnitcmscsshistService;

    @Resource(name = "jnitcmsscripthistService")
    private JnitcmsscripthistService jnitcmsscripthistService;

    @Resource(name = "jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    @Resource(name = "jnitcmsboardhistService")
    private JnitcmsboardhistService jnitcmsboardhistService;

    @Resource(name = "jnitboardinfoService")
    private JnitboardinfoService jnitboardinfoService;

    @Resource(name = "jnitBoardDataService")
	private JnitBoardDataService jnitBoardDataService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    private static final long maxFileSize = 1024 * 1024 * 100;
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");

    /**
	 * JNITCMSMGMT 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitcmsmgmtDefaultVO
	 * @return "/jnit/cms/mgmt/jnitcmsmgmt/JnitcmsmgmtList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/mgmt/list.do")
    public String selectJnitcmsmgmtList(@ModelAttribute("searchVO") JnitcmsmgmtDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

    	String mgmtId = NullUtil.nullString(request.getParameter("mgmtId"));
    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));

    	String sessionSite = "";
    	sessionSite = returnSite(request);
    	if(!"".equals(sessionSite)) return sessionSite;

    	//JSON
    	model.addAllAttributes(AdminJson(request, model));

    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit("img".equals(mgmtType) ? 12 : propertiesService.getInt("pageUnit"));//propertiesService.getInt("pageUnit")
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		//siteId
		searchVO.setSiteIdYn("Y");
		searchVO.setSiteId(CmsHelper.getSessionSiteId(request));

		//mgmtType
		searchVO.setMgmtTypeYn("Y");
		searchVO.setMgmtType(mgmtType);

		//orderby
		if("css".equals(mgmtType) || "js".equals(mgmtType)) searchVO.setOrderbyCondition("1");

        List jnitcmsmgmtList = jnitcmsmgmtService.selectJnitcmsmgmtList(searchVO);

        HashMap<String, Object> fileSizeMap = new HashMap<String, Object>();
        String root = PathUtil.getRealPath(request);
        //파일 실제 크기
        if("img".equals(mgmtType) ||"video".equals(mgmtType)){
        	Iterator mgmtIterator = jnitcmsmgmtList.iterator();
        	for(int i=0; i<jnitcmsmgmtList.size(); i++){
        		EgovMap mgmtEgovMap = (EgovMap) mgmtIterator.next();
        		String id = String.valueOf(mgmtEgovMap.get("mgmtId"));
        		String filePathUrl = String.valueOf(mgmtEgovMap.get("mgmtFilePathUrl"));
        		if(!"null".equals(filePathUrl)){
        			File file = new File(root+filePathUrl);
        			if(file.exists()){
        				double bytes = file.length();
            			double kilobytes = (bytes / 1024);
            			double megabytes = (kilobytes / 1024);
        				fileSizeMap.put(id, String.format("%.2f", megabytes));
        			}
        		}
        	}
        }

        int totCnt = jnitcmsmgmtService.selectJnitcmsmgmtListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("fileSizeMap",fileSizeMap);
		model.addAttribute("mgmtId", mgmtId);
		model.addAttribute("resultList", jnitcmsmgmtList);
        model.addAttribute("paginationInfo", paginationInfo);

        if(isSkinList(mgmtType)){
        	return "/jnit/cms/mgmt/skin/"+mgmtType+"List";
        }else{
        	return "/jnit/cms/mgmt/mgmtList";
        }
    }

    @RequestMapping("/cms/mgmt/add.do")
    public String addJnitcmsmgmtView(
            @ModelAttribute("searchVO") JnitcmsmgmtDefaultVO searchVO,
            HttpServletRequest request,
            ModelMap model)
            throws Exception {
    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));
    	String root = PathUtil.getRealPath(request);
    	String whiteFile = EgovProperties.getProperty("Globals.FILE.EXT");

    	//JSON
    	model.addAllAttributes(AdminJson(request, model));

    	//White File List
    	model.addAttribute("whiteFile", whiteFile);

    	String sessionSite = "";
    	sessionSite = returnSite(request);
    	if(!"".equals(sessionSite)) return sessionSite;

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
    	try {
    		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
    		model.addAttribute("siteVO", siteVO);
    	} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		JnitcmsmgmtVO mgmtVO = new JnitcmsmgmtVO();
		mgmtVO.setSiteId(siteId);
		mgmtVO.setSearchKeyword(mgmtType);
		mgmtVO.setSearchCondition("0");
		try {
			int sortMax = jnitcmsmgmtService.selectMaxTotCnt(mgmtVO);
			mgmtVO.setMgmtSort(sortMax+1);
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		//기본 Sample main.jsp
		if("boardLatest".equals(mgmtType)){
			String boardLatestDir = root + "default/common/board/latest";
			try {
				mgmtVO.setMgmtContent(CmsHandler.readFile(boardLatestDir+"/main.jsp"));
			} catch (IOException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}

		model.addAttribute("siteVO", siteVO);
		model.addAllAttributes(mgmtUtil.categoryList(request, model, siteVO, mgmtType, null)); //categoryList
		model.addAllAttributes(setBoardIdList(request, model, mgmtType)); //boardIdList
		model.addAllAttributes(setBoardLatestList(request, model)); //boardlastList
        model.addAttribute("nid",  jnitcmsmgmtService.getLastIdJnitcmsmgmt());
        model.addAttribute("jnitcmsmgmtVO", mgmtVO);

        if(isSkinList(mgmtType)){
        	return "/jnit/cms/mgmt/skin/"+mgmtType+"Edit";
        }else{
        	return "/jnit/cms/mgmt/mgmtEdit";
        }
    }

    @RequestMapping("/cms/mgmt/addProc.do")
    public String addJnitcmsmgmt(
            @ModelAttribute("searchVO") JnitcmsmgmtDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmgmtVO") JnitcmsmgmtVO jnitcmsmgmtVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    ModelMap model,
	    SessionStatus status)
            throws Exception {

    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));

    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	jnitcmsmgmtVO.setMgmtActId(loginVO.getMbrId());

    	String siteId = CmsHelper.getSessionSiteId(request);
    	jnitcmsmgmtVO.setSiteId(siteId);

    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
        siteVO.setSiteId(siteId);
        siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

        //프로세스 파일 생성 막기
        if("".equals(NullUtil.nullString(jnitcmsmgmtVO.getMgmtNm())) && !"img".equals(mgmtType) && !"file".equals(mgmtType) && !"video".equals(mgmtType)){
        	model.addAttribute("alert", "파일을 생성 할 수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
        }
    	if(!isExists(jnitcmsmgmtVO, jnitcmsmgmtVO.getMgmtNm(), mgmtType, siteId)){
    		model.addAttribute("alert", "파일을 생성 할 수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
    	}
        //end 프로세스 파일 생성막기

    	//파일 업로드 각 확장자는 1차 jsp 제어
    	//대용량 파일에대한 조치는 후속조치 필요
    	String root = PathUtil.getRealPath(request);

    	String fileDir = root + "/"+siteVO.getSitePath()+"/common/"+mgmtType;
    	if("boardLatest".equals(mgmtType)) fileDir = root + "WEB-INF/jsp/jnit/board/latest/skin/"+siteVO.getSiteId();

    	HashMap<String, EgovFormBasedFileVo> list = null;
    	if("img".equals(mgmtType) || "video".equals(mgmtType) || "file".equals(mgmtType)){
    		EgovFileUploadUtil.type = "noSubPath";
        	list = EgovFileUploadUtil.uploadFormFiles(request, fileDir, maxFileSize);
            if(list.get("upfile") != null){
            	EgovFormBasedFileVo vo = list.get("upfile");
            	//상대경로
            	String filePathUrl = "/"+siteVO.getSitePath()+"/common/"+mgmtType+"/"+vo.getPhysicalName();

            	if("img".equals(mgmtType)) jnitcmsmgmtVO.setMgmtNm(vo.getPhysicalName());
            	jnitcmsmgmtVO.setMgmtFilePathUrl(filePathUrl);
            	jnitcmsmgmtVO.setMgmtFileNm(vo.getPhysicalName());
            	jnitcmsmgmtVO.setMgmtNm("file".equals(mgmtType) ? vo.getFileName() : vo.getPhysicalName());
            	//jnitcmsmgmtVO.setMgmtFilePath(vo.getServerSubPath());
            	jnitcmsmgmtVO.setMgmtFileOrigin(vo.getFileName());
            }else{
            	model.addAttribute("alert", "업로드 파일을 올려주시기 바랍니다.");
            	model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
            	return "/jnit/util/alertMove";
            }
            EgovFileUploadUtil.type = null;
        }
        String id = jnitcmsmgmtService.insertJnitcmsmgmt(jnitcmsmgmtVO);

        if("img".equals(mgmtType) || "video".equals(mgmtType) || "file".equals(mgmtType)){
        	if(list.get("upfile") != null){
        		EgovFormBasedFileVo vo = list.get("upfile");
        		String filePathDir = siteVO.getSitePath()+"/common/"+mgmtType+"/";
            	String fileUrl  = "/cms/getFile.do?"
            	+ "file="+vo.getPhysicalName()
            	+ "&orgname="+vo.getFileName()
            	+ "&mgmtId="+id
            	+ "&siteId="+siteVO.getSiteId()
            	+ "&filePath="+filePathDir;

        		jnitcmsmgmtVO.setMgmtFileUrl(fileUrl);
        		jnitcmsmgmtVO.setMgmtId(id);
        		jnitcmsmgmtService.updateJnitcmsmgmt(jnitcmsmgmtVO);
        	}
        }

        //히스토리
        insertHsit(request, mgmtType, id, siteId, jnitcmsmgmtVO);

        //미니게시판 JSON 핸들링
    	if(!mgmtUtil.boardLatestJSON(request, jnitcmsmgmtVO)){
        	model.addAttribute("alert", "파일을 생성 할 수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
        }
        //파일관리
        try {
            File f = new File(fileDir);
            if(!f.exists()){
            	f.mkdirs();
            }
            String makeFile = fileDir+"/"+jnitcmsmgmtVO.getMgmtNm()+"."+mgmtType;
            if("boardLatest".equals(mgmtType)) makeFile = fileDir+"/"+jnitcmsmgmtVO.getMgmtNm()+".jsp";

            if(!"img".equals(mgmtType) && !"video".equals(mgmtType) && !"file".equals(mgmtType)){
            	//치환
            	jnitcmsmgmtVO.setMgmtContent(mgmtUtil.replaceMgmtSrc(jnitcmsmgmtVO.getMgmtContent(), mgmtType, jnitcmsmgmtVO.getBoardSkin(), null));
            	//CmsHandler.writeFile(makeFile, mgmtUtil.setMgmtFileHeader(mgmtType, jnitcmsmgmtVO.getBoardSkin())+jnitcmsmgmtVO.getMgmtContent());
            	if("boardLatest".equals(mgmtType)){
            		CmsHandler.writeFile(makeFile, mgmtUtil.setMgmtBoardFileHeader(mgmtType, jnitcmsmgmtVO.getBoardSkin(), jnitcmsmgmtVO.getBoardId())+jnitcmsmgmtVO.getMgmtContent());
            	}else{
	           		CmsHandler.writeFile(makeFile, mgmtUtil.setMgmtFileHeader(mgmtType, jnitcmsmgmtVO.getBoardSkin())+jnitcmsmgmtVO.getMgmtContent());

	           	}

            }
        } catch (IOException e){
        	log.error(e.getMessage());
			model.addAttribute("alert", "파일을 생성 할 수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
		}catch (Exception e) {
			log.error(e.getMessage());
			model.addAttribute("alert", "파일을 생성 할 수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
		}

		String message = "";
		//파일 핸들링
		if("css".equals(mgmtType) || "js".equals(mgmtType)){
			if(!mgmtUtil.makeCategoryJSON(request, siteVO, jnitcmsmgmtVO)){
				message = jnitcmsmgmtVO.getMgmtNm()+"JSON 파일에 오류가 생겨 작업을 마치지 못했습니다.";
			}
			if(!mgmtUtil.writeFile("파일관리","2", "3",null)){
				message = " Handing 파일에 오류가 생겨 작업을 마치지 못했습니다.";
			}
		}
        model.addAttribute("alert", "저장되었습니다"+message);
        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
        status.setComplete();
        return "/jnit/util/alertMove";
    }

    @RequestMapping("/cms/mgmt/edit.do")
    public String updateJnitcmsmgmtView(
            @RequestParam("mgmtId") java.lang.String mgmtId ,
            @ModelAttribute("searchVO") JnitcmsmgmtDefaultVO searchVO,
            HttpServletRequest request,
            ModelMap model)
            throws Exception {

    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));

    	String sessionSite = "";
    	sessionSite = returnSite(request);
    	if(!"".equals(sessionSite)) return sessionSite;

    	//JSON
    	model.addAllAttributes(AdminJson(request, model));

    	//Brower
    	model.addAllAttributes(getBrower(request, model));

        JnitcmsmgmtVO jnitcmsmgmtVO = new JnitcmsmgmtVO();
        jnitcmsmgmtVO.setMgmtId(mgmtId);
        jnitcmsmgmtVO = jnitcmsmgmtService.selectJnitcmsmgmt(jnitcmsmgmtVO);

        //MGMT_CONTENT NULL CHECK
        if(!"".equals(NullUtil.nullString(jnitcmsmgmtVO.getMgmtContent()))) model.addAttribute("mgmtContentNullYn", "Y");

        if(jnitcmsmgmtVO.getMgmtActId() != null){
        	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
        	mbrVO.setMbrId(jnitcmsmgmtVO.getMgmtActId());
        	try {
        		mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
        	} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			if(mbrVO.getMbrId() != null){
				model.addAttribute("mbrNm", mbrVO.getMbrNm());
			}
        }

        String siteId = CmsHelper.getSessionSiteId(request);
        JnitcmssiteVO siteVO = new JnitcmssiteVO();
        siteVO.setSiteId(siteId);
        siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        model.addAttribute("siteVO", siteVO);


        //파일 이름 중복체크(DB)
        int isExistsTot = isExistsTot(jnitcmsmgmtVO, jnitcmsmgmtVO.getMgmtNm(), mgmtType, siteId);
        if(isExistsTot > 1) model.addAttribute("isExistsNm", "Y");

        String root = PathUtil.getRealPath(request);

        if("css".equals(mgmtType) || "js".equals(mgmtType) || "boardLatest".equals(mgmtType)){
        	//css, js 파일 실제값
        	String fileDir = root + "/"+siteVO.getSitePath()+"/common/"+mgmtType+"/"+jnitcmsmgmtVO.getMgmtNm()+"."+mgmtType;
        	if("boardLatest".equals(mgmtType)) fileDir = root + "WEB-INF/jsp/jnit/board/latest/skin/"+siteVO.getSiteId()+"/"+jnitcmsmgmtVO.getMgmtNm()+".jsp";

        	File file = new File(fileDir);
        	if(file.exists()){
        		//파일 size
        		model.addAllAttributes(fileSize("kilobytes", fileDir, model));
        		String fileContent = CmsHandler.readFile(fileDir);

        		//역치환
        		fileContent = mgmtUtil.replaceMgmtSrc(fileContent, mgmtType, jnitcmsmgmtVO.getBoardSkin(), "return");
        		fileContent = mgmtUtil.mgmtContentFillter(mgmtType, jnitcmsmgmtVO.getBoardSkin(), fileContent);

        		if(!fileContent.trim().equals(NullUtil.nullString(jnitcmsmgmtVO.getMgmtContent()).trim())){
        			model.addAttribute("newFile", "Y");
        			model.addAttribute("fileContent", fileContent.trim());
        		}
        	}else {
        		model.addAttribute("notFile", "Y");
        	}
        }else{
        	//img, video 파일 실제값
        	if(!"".equals(NullUtil.nullString(jnitcmsmgmtVO.getMgmtFileUrl()))){
        		String filePathUrl = root + NullUtil.nullString(jnitcmsmgmtVO.getMgmtFilePathUrl());

        		File fileSize = new File(filePathUrl);

        		if(fileSize.exists()){
        			model.addAllAttributes(fileSize("img".equals(mgmtType) ? "kilobytes" : "megabytes", filePathUrl, model));
        			//이미지 가로 세로 셋팅

                	model.addAttribute("fileUrl", jnitcmsmgmtVO.getMgmtFileUrl().replace("\\", "\\\\"));
        			if(isImg(jnitcmsmgmtVO.getMgmtFileNm())){
            			BufferedImage bimg = ImageIO.read(new File(filePathUrl));
            			model.addAttribute("fileWidth", bimg.getWidth());
            			model.addAttribute("fileHeight", bimg.getHeight());
            			model.addAttribute("imgYn", "Y");
            		}
        		}else{
        			model.addAttribute("notFile", "Y");
        		}
        	}
        }

        model.addAttribute("siteVO", siteVO);
        model.addAllAttributes(mgmtUtil.categoryList(request, model, siteVO, mgmtType, jnitcmsmgmtVO.getMgmtNm())); //categoryList
        model.addAllAttributes(setBoardIdList(request, model, mgmtType)); //boardIdList
		model.addAllAttributes(setBoardLatestList(request, model)); //boardlastList
		model.addAttribute("jnitcmsmgmtVO", jnitcmsmgmtVO);
		//model.addAttribute(selectJnitcmsmgmt(jnitcmsmgmtVO, searchVO));
        if(isSkinList(mgmtType)){
        	return "/jnit/cms/mgmt/skin/"+mgmtType+"Edit";
        }else{
        	return "/jnit/cms/mgmt/mgmtEdit";
        }
    }

    @RequestMapping("/jnitcmsmgmt/selectJnitcmsmgmt.do")
    public @ModelAttribute("jnitcmsmgmtVO")
    JnitcmsmgmtVO selectJnitcmsmgmt(
            JnitcmsmgmtVO jnitcmsmgmtVO,
            @ModelAttribute("searchVO") JnitcmsmgmtDefaultVO searchVO) throws Exception {
        return jnitcmsmgmtService.selectJnitcmsmgmt(jnitcmsmgmtVO);
    }

    @RequestMapping("/cms/mgmt/editProc.do")
    public String updateJnitcmsmgmt(
            @ModelAttribute("searchVO") JnitcmsmgmtDefaultVO searchVO,
	    @ModelAttribute("jnitcmsmgmtVO") JnitcmsmgmtVO jnitcmsmgmtVO,
	    BindingResult bindingResult,
	    HttpServletRequest request,
	    ModelMap model,
	    SessionStatus status)
            throws Exception {

    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));

    	String siteId = CmsHelper.getSessionSiteId(request);
    	jnitcmsmgmtVO.setSiteId(siteId);

    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
        siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

        //프로세스 저장 막기
        if("".equals(NullUtil.nullString(jnitcmsmgmtVO.getMgmtNm()))){
        	model.addAttribute("alert", "파일을 저장 할 수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
        }
        //파일 업로드 각 확장자는 1차 jsp 제어
    	//대용량 파일에대한 조치는 후속조치 필요
    	String root = PathUtil.getRealPath(request);

    	String fileDir = root + "/"+siteVO.getSitePath()+"/common/"+mgmtType;
    	if("boardLatest".equals(mgmtType)) fileDir = root + "WEB-INF/jsp/jnit/board/latest/skin/"+siteVO.getSiteId();

    	if("img".equals(mgmtType) || "video".equals(mgmtType) || "file".equals(mgmtType)){
    		EgovFileUploadUtil.type = "noSubPath";
    		EgovFileUploadUtil.orginFileNm = jnitcmsmgmtVO.getMgmtFileNm().substring(0, jnitcmsmgmtVO.getMgmtFileNm().lastIndexOf("."));

        	HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, fileDir, maxFileSize);

            if(list.get("upfile") != null){
            	EgovFormBasedFileVo vo = list.get("upfile");
            	String filePathDir = siteVO.getSitePath()+"/common/"+mgmtType+"/";
            	//상대경로
            	String filePathUrl = "/"+siteVO.getSitePath()+"/common/"+mgmtType+"/"+vo.getPhysicalName();
            	String fileUrl  = "/cms/getFile.do?"
                	+ "file="+vo.getPhysicalName()
                	+ "&orgname="+vo.getFileName()
                	+ "&mgmtId="+jnitcmsmgmtVO.getMgmtId()
                	+ "&siteId="+siteVO.getSiteId()
                	+ "&filePath="+filePathDir;

            	//수정건은 파일 지움
            	if(!vo.getPhysicalName().equals(jnitcmsmgmtVO.getMgmtFileNm())){
            		String dummyFileDir = root+filePathDir + jnitcmsmgmtVO.getMgmtFileNm();
            		File dummyFile = new File(dummyFileDir);
            		if(dummyFile.exists()){
            			dummyFile.delete();
            			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, dummyFile);		//Filego 배포
            		}
            	}

            	if("img".equals(mgmtType) || "file".equals(mgmtType)) jnitcmsmgmtVO.setMgmtNm("file".equals(mgmtType) ? vo.getFileName() : vo.getPhysicalName());
            	jnitcmsmgmtVO.setMgmtFilePathUrl(filePathUrl);
            	jnitcmsmgmtVO.setMgmtFileNm(vo.getPhysicalName());
            	//jnitcmsmgmtVO.setMgmtFilePath(vo.getServerSubPath());
            	jnitcmsmgmtVO.setMgmtFileOrigin(vo.getFileName());
            	jnitcmsmgmtVO.setMgmtFileUrl(fileUrl);
            }
            /*
            if(list.get("fileExtensionError") != null){
            	model.addAttribute("alert", "확장자 "+fileExp(list.get("fileExtensionError").getPhysicalName())+"은 업로드 할 수 없습니다.");
            	model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType+"&mgmtId="+jnitcmsmgmtVO.getMgmtId());
            	return "/jnit/util/alertMove";
            }
            */
            EgovFileUploadUtil.type = null;
            EgovFileUploadUtil.orginFileNm = null;
        }else{
        	JnitcmsmgmtVO mgmtVO = new JnitcmsmgmtVO();
        	mgmtVO.setMgmtId(jnitcmsmgmtVO.getMgmtId());
        	mgmtVO = jnitcmsmgmtService.selectJnitcmsmgmt(mgmtVO);
        	//수정건은 파일 지움
        	if(!NullUtil.nullString(mgmtVO.getMgmtNm()).equals(NullUtil.nullString(jnitcmsmgmtVO.getMgmtNm()))){
        		String dummyFileDir = fileDir+"/"+mgmtVO.getMgmtNm()+"."+mgmtType;
        		File dummyFile = new File(dummyFileDir);
        		if(dummyFile.exists()){
        			dummyFile.delete();
        			JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, dummyFile);		//Filego 배포
        		}
        	}
        }
        jnitcmsmgmtService.updateJnitcmsmgmt(jnitcmsmgmtVO);

        //히스토리
        insertHsit(request, mgmtType, jnitcmsmgmtVO.getMgmtId(), siteId, jnitcmsmgmtVO);

        //미니게시판 JSON 핸들링
    	if(!mgmtUtil.boardLatestJSON(request, jnitcmsmgmtVO)){
        	model.addAttribute("alert", "파일을 생성 할 수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
        }

        //파일관리
        try {
            File f = new File(fileDir);
            if(!f.exists()){
            	f.mkdirs();
            }
            String makeFile = fileDir+"/"+jnitcmsmgmtVO.getMgmtNm()+"."+mgmtType;
            if("boardLatest".equals(mgmtType)) makeFile = fileDir+"/"+jnitcmsmgmtVO.getMgmtNm()+".jsp";

            if(!"img".equals(mgmtType) && !"video".equals(mgmtType) && !"file".equals(mgmtType)){
            	//치환
            	jnitcmsmgmtVO.setMgmtContent(mgmtUtil.replaceMgmtSrc(jnitcmsmgmtVO.getMgmtContent(), mgmtType, jnitcmsmgmtVO.getBoardSkin(), null));
            	 if("boardLatest".equals(mgmtType)){
            		 CmsHandler.writeFile(makeFile, mgmtUtil.setMgmtBoardFileHeader(mgmtType, jnitcmsmgmtVO.getBoardSkin(), jnitcmsmgmtVO.getBoardId())+jnitcmsmgmtVO.getMgmtContent());
            	 }else{
            		 CmsHandler.writeFile(makeFile, mgmtUtil.setMgmtFileHeader(mgmtType, jnitcmsmgmtVO.getBoardSkin())+jnitcmsmgmtVO.getMgmtContent());
            	 }

            }
        } catch (IOException e){
        	model.addAttribute("alert", "파일을 생성 할수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
		} catch (Exception e) {
			model.addAttribute("alert", "파일을 생성 할수 없습니다.");
	        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType);
	        return "/jnit/util/alertMove";
		}

        String message = "";
        if("css".equals(mgmtType) || "js".equals(mgmtType)){
			if(!mgmtUtil.makeCategoryJSON(request, siteVO, jnitcmsmgmtVO)){
				message = jnitcmsmgmtVO.getMgmtNm()+"JSON 파일에 오류가 생겨 작업을 마치지 못했습니다.";
			}
			if(!mgmtUtil.writeFile("파일관리","2", "3",null)){
				message = " Handing 파일에 오류가 생겨 작업을 마치지 못했습니다.";
			}
		}

		model.addAttribute("alert", "수정되었습니다"+message);
        model.addAttribute("path", "/cms/mgmt/list.do?mgmtType="+mgmtType+"&mgmtId="+jnitcmsmgmtVO.getMgmtId());
        status.setComplete();
        return "/jnit/util/alertMove";
    }

    @RequestMapping("/mgmt/deleteProc.do")
    public String deleteJnitcmsmgmt(
            JnitcmsmgmtVO jnitcmsmgmtVO,
            @ModelAttribute("searchVO") JnitcmsmgmtDefaultVO searchVO
            , HttpServletRequest request
            , ModelMap model
            , SessionStatus status)
            throws Exception {

    	if(jnitcmsmgmtVO.getMgmtId() == null){
    		jnitcmsmgmtVO.setMgmtId(NullUtil.nullString(request.getParameter("mgmtType")));
    		jnitcmsmgmtVO = jnitcmsmgmtService.selectJnitcmsmgmt(jnitcmsmgmtVO);
    	}

    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
    	siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

    	String root = PathUtil.getRealPath(request);
    	String fileDir = root + siteVO.getSitePath() + "/common/"+ mgmtType;
    	String configDir = root + siteVO.getSitePath() + "/common/config";
    	String deleteFileDir = "";
    	String deleteJSONFileDir = "";
    	JSONObject JSON = new JSONObject();
    	JSON.put("status","");

    	try {
    		if("css".equals(mgmtType) || "js".equals(mgmtType)){
        		deleteFileDir = fileDir + "/" + jnitcmsmgmtVO.getMgmtNm()+"."+mgmtType;
        		deleteJSONFileDir =  configDir+"/handing/"+mgmtType+"/"+ jnitcmsmgmtVO.getMgmtNm()+".json";
        	}else if("img".equals(mgmtType) || "video".equals(mgmtType)){
        		deleteFileDir = fileDir + "/" + jnitcmsmgmtVO.getMgmtFileNm();
        	}else if("boardLatest".equals(mgmtType)){
        		fileDir = root + "WEB-INF/jsp/jnit/board/latest/skin/"+siteVO.getSiteId();
        		deleteFileDir = fileDir + "/" + jnitcmsmgmtVO.getMgmtNm()+".jsp";
        	}
        	//원본파일 삭제
        	File file = new File(deleteFileDir);
        	if(file.exists()){
        		file.delete();
        		JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, file);		//Filego 배포
        	}
        	//각 설정파일 삭제
        	File jsonFile = new File(deleteJSONFileDir);
        	if(jsonFile.exists()){
        		jsonFile.delete();
        		JnitFilegoUtil.deleteFile(JnitFilegoFileType.CONTENT, jsonFile);		//Filego 배포
        	}
    	} catch (NullPointerException e){
    		log.error(e.getMessage());
			JSON.put("status", "error");
			JSON.put("code", "ERROR 1");
		} catch (Exception e) {
			log.error(e.getMessage());
			JSON.put("status", "error");
			JSON.put("code", "ERROR 1");
		}

		try {
			jnitcmsmgmtService.deleteJnitcmsmgmt(jnitcmsmgmtVO);
		} catch (NullPointerException e){
			JSON.put("status", "error");
			JSON.put("code", "ERROR 2");
		} catch (Exception e) {
			JSON.put("status", "error");
			JSON.put("code", "ERROR 2");
		}

		String ctxRoot = request.getSession().getServletContext().getContextPath();
		if(!"error".equals(JSON.get("status"))){
			JSON.put("status", "success");
			JSON.put("path", ctxRoot+"/cms/mgmt/list.do?mgmtType="+mgmtType);
		}
		model.addAttribute("json", JSON.toString());
        status.setComplete();
        return "/jnit/util/json";
    }

    static ModelMap getBrower(HttpServletRequest request, ModelMap model)throws Exception{
    	String brower = request.getHeader("User-Agent");
    	String browerlist[] = {"Chrome","Opera","Firefox","Safari"};

    	if(brower.indexOf("MISE") > -1){ //익스 8,9,10
    		brower = "MISE";
    	}else{
    		//현재 brower가 리스트에 속해있지 않으면 IE 통일
    		int k = 0;
    		for(int i=0; i<browerlist.length; i++){
    			if(brower.indexOf(browerlist[i]) > -1){
    				k++;
    			}
    		}
    		if(k == 0){
    			brower = "MISE";
    		}
    	}
    	model.addAttribute("brower", brower);
    	return model;
    }

    static ModelMap AdminJson(HttpServletRequest request
    		, ModelMap model)throws Exception{
    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));

    	if("css".equals(mgmtType)){
    		AdminUtil.setMenuId("m05030000");//m02050100
    	}else if("js".equals(mgmtType)){
    		AdminUtil.setMenuId("m05040000");//m02060100
    	}else if("img".equals(mgmtType)){
    		AdminUtil.setMenuId("m05050000");
    	}else if("video".equals(mgmtType)){
    		AdminUtil.setMenuId("m05060000");
    	}else if("file".equals(mgmtType)){
    		AdminUtil.setMenuId("m05070000");
    	}else if("boardLatest".equals(mgmtType)){
    		AdminUtil.setMenuId("m06010501");
    	}
    	model.addAttribute("mgmtType", mgmtType);
    	return model;
    }

    /**
     * 원하는 파일크기값 지정하여 리턴한다.
     * @param type - bytes, kilobytes, megabytes, gigabytes, terabytes, petabytes, exabytes, zettabytes, yottabytes
     * @param fileDir - 파일경로
     * @return model
     * @throws Exception
     */
    static ModelMap fileSize(String type, String fileDir, ModelMap model)throws Exception{
    	if(!"".equals(fileDir)){
    		File file = new File(fileDir);
    		if(file.exists()){
    			HashMap<String, Double> fileSizeMap = new HashMap<String, Double>();
    	    	HashMap<Integer, String> fileSortMap = new HashMap<Integer, String>();
    			double bytes = file.length();
    			double kilobytes = (bytes / 1024);
    			double megabytes = (kilobytes / 1024);
    			double gigabytes = (megabytes / 1024);
    			double terabytes = (gigabytes / 1024);
    			double petabytes = (terabytes / 1024);
    			double exabytes = (petabytes / 1024);
    			double zettabytes = (exabytes / 1024);
    			double yottabytes = (zettabytes / 1024);

    			fileSizeMap.put("bytes", bytes);
    			fileSizeMap.put("kilobytes", kilobytes);
    			fileSizeMap.put("megabytes", megabytes);
    			fileSizeMap.put("gigabytes", gigabytes);
    			fileSizeMap.put("terabytes", terabytes);
    			fileSizeMap.put("petabytes", petabytes);
    			fileSizeMap.put("exabytes", exabytes);
    			fileSizeMap.put("zettabytes", zettabytes);
    			fileSizeMap.put("yottabytes", yottabytes);

    			fileSortMap.put(0, "bytes");
    			fileSortMap.put(1, "kilobytes");
    			fileSortMap.put(2, "megabytes");
    			fileSortMap.put(3, "gigabytes");
    			fileSortMap.put(4, "terabytes");
    			fileSortMap.put(5, "petabytes");
    			fileSortMap.put(6, "exabytes");
    			fileSortMap.put(7, "zettabytes");
    			fileSortMap.put(8, "yottabytes");

    			for(int i=0; i<fileSizeMap.size(); i++){
	    			if(type.equals(fileSortMap.get(i))){
	    				model.addAttribute("fileSize", String.format("%.2f", fileSizeMap.get(type)));
	    			}
	    		}
    		}
    	}
    	return model;
    }

    static String returnSite(HttpServletRequest request)throws Exception{
    	String str = "";
    	if(CmsHelper.getSessionSiteId(request).equals("")) {
			str = "jnit/cms/mgmt/nosite";
		}
    	return str;
    }

    @RequestMapping("/cms/ajax/file/name.do")
    public String fileName(HttpServletRequest request, ModelMap model)throws Exception{
    	JnitcmsmgmtVO jnitcmsmgmtVO = new JnitcmsmgmtVO();
    	JSONObject JSON = new JSONObject();

    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));

    	String mgmtNm = NullUtil.nullString(request.getParameter("mgmtNm"));
    	String screenMode = NullUtil.nullString(request.getParameter("screenMode"));
    	String mgmtId = NullUtil.nullString(request.getParameter("mgmtId"));

    	jnitcmsmgmtVO.setMgmtNm(mgmtNm);

    	Boolean isFile = true;
    	if(!"".equals(screenMode)){
    		jnitcmsmgmtVO.setMgmtId(mgmtId);
    		try {
    			jnitcmsmgmtVO = jnitcmsmgmtService.selectJnitcmsmgmt(jnitcmsmgmtVO);

        		if(!jnitcmsmgmtVO.getMgmtNm().equals(mgmtNm)){
        			isFile = isFileName(jnitcmsmgmtVO, mgmtNm, mgmtType, screenMode);
        		}
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
				JSON.put("status", "error");
	    		JSON.put("code", "ERROR 2");
			} catch (Exception e) {
				log.error(e.getMessage());
				JSON.put("status", "error");
	    		JSON.put("code", "ERROR 2");
			}
    	}else{
    		isFile = isFileName(jnitcmsmgmtVO, mgmtNm, mgmtType, screenMode);
    	}

    	if(isFile){
    		JSON.put("status", "success");
    	}else{
    		JSON.put("status", "error");
    		if(!"".equals(screenMode)) JSON.put("code", "ERROR 1");
    	}

    	model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }

    /**
     * 같은 파일인지 아닌지 구분한다.
     * @param jnitcmsmgmtVO
     * @param mgmtNm = 파일이름
     * @param mgmtType = 타입
     * @param siteId = 사이트ID
     * @return Boolean
     * @throws Exception
     * {@link JnitcmsmgmtController#addJnitcmsmgmt}
     */
    static Boolean isExists(JnitcmsmgmtVO jnitcmsmgmtVO, String mgmtNm, String mgmtType, String siteId)throws Exception{
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext w = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

    	JnitcmsmgmtService jnitcmsmgmtService = (JnitcmsmgmtService) w.getBean("jnitcmsmgmtService");

    	if(!"".equals(mgmtNm)) jnitcmsmgmtVO.setMgmtNm(mgmtNm);
    	if(!"".equals(siteId)){
    		jnitcmsmgmtVO.setSiteIdYn("Y");
    		jnitcmsmgmtVO.setSiteId(siteId);
    	}
    	if(!"".equals(mgmtType)){
    		jnitcmsmgmtVO.setMgmtTypeYn("Y");
    		jnitcmsmgmtVO.setMgmtType(mgmtType);
    	}
		jnitcmsmgmtVO.setSearchCondition("2");
    	int isExists = jnitcmsmgmtService.selectJnitcmsmgmtListTotCnt(jnitcmsmgmtVO);
    	if(isExists > 0){
    		return false;
    	}
    	return true;
    }

    /**
     * 같은 파일 이름 갯수를 구한다
     * @param jnitcmsmgmtVO
     * @param mgmtNm = 파일이름
     * @param mgmtType = 타입
     * @param siteId = 사이트ID
     * @return int
     * @throws Exception
     */
    static int isExistsTot(JnitcmsmgmtVO jnitcmsmgmtVO, String mgmtNm, String mgmtType, String siteId)throws Exception{
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext w = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

    	JnitcmsmgmtService jnitcmsmgmtService = (JnitcmsmgmtService) w.getBean("jnitcmsmgmtService");

    	if(!"".equals(mgmtNm)) jnitcmsmgmtVO.setMgmtNm(mgmtNm);
    	if(!"".equals(siteId)){
    		jnitcmsmgmtVO.setSiteIdYn("Y");
    		jnitcmsmgmtVO.setSiteId(siteId);
    	}
    	if(!"".equals(mgmtType)){
    		jnitcmsmgmtVO.setMgmtTypeYn("Y");
    		jnitcmsmgmtVO.setMgmtType(mgmtType);
    	}
		jnitcmsmgmtVO.setSearchCondition("2");
    	int isExists = jnitcmsmgmtService.selectJnitcmsmgmtListTotCnt(jnitcmsmgmtVO);
    	return isExists;
    }

    /**
     * 저장될 이름에 대한 DB, 실제 경로상의 파일이름을 비교하여 같은파일이 있는지 반환한다.
     * @param jnitcmsmgmtVO
     * @param mgmtNm - 파일이름
     * @param mgmtType - 조건
     * @param screenMode - 수정 : 등록
     * @return Boolean
     * @throws Exception
     * {@link JnitcmsmgmtController#fileName}
     */
    static Boolean isFileName(JnitcmsmgmtVO jnitcmsmgmtVO, String mgmtNm, String mgmtType, String screenMode)throws Exception{
    	HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext w = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

    	JnitcmssiteService jnitcmssiteService = (JnitcmssiteService) w.getBean("jnitcmssiteService");
    	int isFileNameCount = 0;
    	String siteId = CmsHelper.getSessionSiteId(request);

    	//db 확인
    	if(!isExists(jnitcmsmgmtVO, mgmtNm, mgmtType, siteId)){
    		isFileNameCount++;
    		if("true".equals(deDug)) log.debug("======= isExists ======= ");
    	}

    	//root 확인
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
    	try {
    		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

        	String root = PathUtil.getRealPath(request);
        	String fileDir = root + "/"+siteVO.getSitePath()+"/common/"+mgmtType+"/"+jnitcmsmgmtVO.getMgmtNm()+"."+mgmtType;
        	if("boardLatest".equals(mgmtType)) fileDir = root + "WEB-INF/jsp/jnit/board/latest/skin/"+siteVO.getSiteId()+"/"+jnitcmsmgmtVO.getMgmtNm()+".jsp";

        	File file = new File(fileDir);
        	if(file.exists()){
    			isFileNameCount++;
    			if("true".equals(deDug)) log.debug("======= isFileExists ======= ");
        	}
    	} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		if(isFileNameCount > 0){
			return false;
    	}else{
			return true;
    	}
    }

    @RequestMapping("/cms/mgmt/hist/list.do")
    public String mgmtHist(HttpServletRequest request
    		,ModelMap model)throws Exception{
    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));
    	String mgmtId = NullUtil.nullString(request.getParameter("mgmtId"));
    	String siteId = CmsHelper.getSessionSiteId(request);

    	HashMap<String, String> mbrNmMap = new HashMap<String, String>();
    	HashMap<String, Date> dateMap = new HashMap<String, Date>();

    	if("css".equals(mgmtType)){
    		JnitcmscsshistDefaultVO searchVO = new JnitcmscsshistDefaultVO();

        	/** EgovPropertyService.sample */
        	searchVO.setPageUnit(5); //propertiesService.getInt("pageUnit")
        	searchVO.setPageSize(propertiesService.getInt("pageSize"));

        	/** pageing */
        	PaginationInfo paginationInfo = new PaginationInfo();

    		paginationInfo.setCurrentPageNo(NullUtil.nullInt(request.getParameter("pageIndex")) == 0 ? 1 : NullUtil.nullInt(request.getParameter("pageIndex")));//searchVO.getPageIndex()
    		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
    		paginationInfo.setPageSize(searchVO.getPageSize());

    		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
    		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    		searchVO.setSiteIdYn("Y");
    		searchVO.setSiteId(siteId);
    		searchVO.setMgmtIdYn("Y");
    		searchVO.setMgmtId(mgmtId);
    		List cssHistList = jnitcmscsshistService.selectJnitcmscsshistList(searchVO);

    		Iterator cssHistIterator = cssHistList.iterator();
    		for(int i=0; i<cssHistList.size(); i++){
    			EgovMap cssHistEgovMap = (EgovMap) cssHistIterator.next();
    			String histId = String.valueOf(cssHistEgovMap.get("histId"));
    			String mgmtActId = String.valueOf(cssHistEgovMap.get("mgmtActId"));

    			JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    			mbrVO.setMbrId(mgmtActId);
    			try {
    				mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
    				if(mbrVO.getMbrId() != null){
    					mbrNmMap.put(histId, mbrVO.getMbrNm());
    				}
    			} catch (NullPointerException e){
    				log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				String created = NullUtil.nullString(String.valueOf(cssHistEgovMap.get("created")));
				if(!"".equals(created)) dateMap.put(histId, dateFormat.parse(created));
    		}

    		int totCnt = jnitcmscsshistService.selectJnitcmscsshistListTotCnt(searchVO);
    		paginationInfo.setTotalRecordCount(totCnt);

    		model.addAttribute("resultList", cssHistList);
    		model.addAttribute("mbrNmMap", mbrNmMap);
    		model.addAttribute("paginationInfo", paginationInfo);
    		model.addAttribute("searchVO", searchVO);

    	}else if("js".equals(mgmtType)){
    		JnitcmsscripthistDefaultVO searchVO = new JnitcmsscripthistDefaultVO();

        	/** EgovPropertyService.sample */
        	searchVO.setPageUnit(5);//propertiesService.getInt("pageUnit")
        	searchVO.setPageSize(propertiesService.getInt("pageSize"));

        	/** pageing */
        	PaginationInfo paginationInfo = new PaginationInfo();
        	paginationInfo.setCurrentPageNo(NullUtil.nullInt(request.getParameter("pageIndex")) == 0 ? 1 : NullUtil.nullInt(request.getParameter("pageIndex")));//searchVO.getPageIndex()
    		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
    		paginationInfo.setPageSize(searchVO.getPageSize());

    		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
    		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    		searchVO.setSiteIdYn("Y");
    		searchVO.setSiteId(siteId);
    		searchVO.setMgmtIdYn("Y");
    		searchVO.setMgmtId(mgmtId);
    		List scriptHistList = jnitcmsscripthistService.selectJnitcmsscripthistList(searchVO);

    		Iterator scriptHistIterator = scriptHistList.iterator();
    		for(int i=0; i<scriptHistList.size(); i++){
    			EgovMap scriptHistEgovMap = (EgovMap) scriptHistIterator.next();
    			String histId = String.valueOf(scriptHistEgovMap.get("histId"));
    			String mgmtActId = String.valueOf(scriptHistEgovMap.get("mgmtActId"));

    			JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    			mbrVO.setMbrId(mgmtActId);
    			try {
    				mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
    				if(mbrVO.getMbrId() != null){
    					mbrNmMap.put(histId, mbrVO.getMbrNm());
    				}
    			} catch (NullPointerException e){
    				log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				String created = NullUtil.nullString(String.valueOf(scriptHistEgovMap.get("created")));
				if(!"".equals(created)) dateMap.put(histId, dateFormat.parse(created));
    		}
    		int totCnt = jnitcmsscripthistService.selectJnitcmsscripthistListTotCnt(searchVO);
    		paginationInfo.setTotalRecordCount(totCnt);

    		model.addAttribute("resultList", scriptHistList);
    		model.addAttribute("mbrNmMap", mbrNmMap);
    		model.addAttribute("paginationInfo", paginationInfo);
    		model.addAttribute("searchVO", searchVO);
    	} else if("boardLatest".equals(mgmtType)){
    		JnitcmsboardhistDefaultVO searchVO = new JnitcmsboardhistDefaultVO();

        	/** EgovPropertyService.sample */
        	searchVO.setPageUnit(5); //propertiesService.getInt("pageUnit")
        	searchVO.setPageSize(propertiesService.getInt("pageSize"));

        	/** pageing */
        	PaginationInfo paginationInfo = new PaginationInfo();

    		paginationInfo.setCurrentPageNo(NullUtil.nullInt(request.getParameter("pageIndex")) == 0 ? 1 : NullUtil.nullInt(request.getParameter("pageIndex")));//searchVO.getPageIndex()
    		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
    		paginationInfo.setPageSize(searchVO.getPageSize());

    		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
    		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    		searchVO.setSiteIdYn("Y");
    		searchVO.setSiteId(siteId);
    		searchVO.setMgmtIdYn("Y");
    		searchVO.setMgmtId(mgmtId);
    		List boardLatestHistList = jnitcmsboardhistService.selectJnitcmsboardhistList(searchVO);

    		Iterator boardLatestHistIterator = boardLatestHistList.iterator();
    		for(int i=0; i<boardLatestHistList.size(); i++){
    			EgovMap cssHistEgovMap = (EgovMap) boardLatestHistIterator.next();
    			String histId = String.valueOf(cssHistEgovMap.get("histId"));
    			String mgmtActId = String.valueOf(cssHistEgovMap.get("mgmtActId"));

    			JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    			mbrVO.setMbrId(mgmtActId);
    			try {
    				mbrVO = jnitcmsmbrService.selectJnitcmsmbr(mbrVO);
    				if(mbrVO.getMbrId() != null){
    					mbrNmMap.put(histId, mbrVO.getMbrNm());
    				}
    			} catch (NullPointerException e){
    				log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				String created = NullUtil.nullString(String.valueOf(cssHistEgovMap.get("created")));
				if(!"".equals(created)) dateMap.put(histId, dateFormat.parse(created));
    		}

    		int totCnt = jnitcmsboardhistService.selectJnitcmsboardhistListTotCnt(searchVO);
    		paginationInfo.setTotalRecordCount(totCnt);

    		model.addAttribute("resultList", boardLatestHistList);
    		model.addAttribute("mbrNmMap", mbrNmMap);
    		model.addAttribute("paginationInfo", paginationInfo);
    		model.addAttribute("searchVO", searchVO);
    	}
    	model.addAttribute("dateMap", dateMap);
    	return "/jnit/cms/hist/"+mgmtType+"/"+mgmtType+"histList";
    }

    @RequestMapping("/cms/mgmt/hist/recover.do")
    public String recoverHist(HttpServletRequest request, ModelMap model)throws Exception{
    	String root = PathUtil.getRealPath(request);
    	String contextPath = request.getSession().getServletContext().getContextPath();
    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));
    	String histId = NullUtil.nullString(request.getParameter("histId"));
    	String mgmtId = NullUtil.nullString(request.getParameter("mgmtId"));

    	JSONObject JSON = new JSONObject();

    	String siteId = CmsHelper.getSessionSiteId(request);
    	JnitcmssiteVO siteVO = new JnitcmssiteVO();
    	siteVO.setSiteId(siteId);
    	siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

    	JnitcmsmgmtVO mgmtVO  = new JnitcmsmgmtVO();
    	mgmtVO.setUpdateCondition("1");
    	mgmtVO.setMgmtId(mgmtId);
    	mgmtVO = jnitcmsmgmtService.selectJnitcmsmgmt(mgmtVO);

    	if("css".equals(mgmtType)){
    		JnitcmscsshistVO cssHistVO = new JnitcmscsshistVO();
    		cssHistVO.setHistId(histId);
    		try {
    			cssHistVO = jnitcmscsshistService.selectJnitcmscsshist(cssHistVO);
    			mgmtVO.setMgmtContent(cssHistVO.getContent());
    			jnitcmsmgmtService.updateJnitcmsmgmt(mgmtVO);

    			String cssFileDir = root + siteVO.getSitePath() + "/common/"+mgmtType+"/"+mgmtVO.getMgmtNm()+"."+mgmtType;
    			CmsHandler.writeFile(cssFileDir, mgmtVO.getMgmtContent());

    			JSON.put("status", "success");
    		} catch (IOException e){
    			log.error(e.getMessage());
				JSON.put("status", "error");
			} catch (Exception e) {
				log.error(e.getMessage());
				JSON.put("status", "error");
			}
    	}else if("js".equals(mgmtType)){
    		JnitcmsscripthistVO scriptHistVO = new JnitcmsscripthistVO();
    		scriptHistVO.setHistId(histId);
    		try {
				scriptHistVO = jnitcmsscripthistService.selectJnitcmsscripthist(scriptHistVO);
				mgmtVO.setMgmtContent(scriptHistVO.getContent());
    			jnitcmsmgmtService.updateJnitcmsmgmt(mgmtVO);

    			String jsFileDir = root + siteVO.getSitePath() + "/common/"+mgmtType+"/"+mgmtVO.getMgmtNm()+"."+mgmtType;
    			CmsHandler.writeFile(jsFileDir, mgmtVO.getMgmtContent());

    			JSON.put("status", "success");
    		} catch (IOException e){
    			log.error(e.getMessage());
				JSON.put("status", "error");
			} catch (Exception e) {
				log.error(e.getMessage());
				JSON.put("status", "error");
			}
    	}else if("boardLatest".equals(mgmtType)){
    		JnitcmsboardhistVO boardLatestHistVO = new JnitcmsboardhistVO();
    		boardLatestHistVO.setHistId(histId);
    		try {
    			JSON.put("status", "success");
    			boardLatestHistVO = jnitcmsboardhistService.selectJnitcmsboardhist(boardLatestHistVO);
				mgmtVO.setMgmtContent(boardLatestHistVO.getContent());
				mgmtVO.setBoardSkin(boardLatestHistVO.getBoardSkin());
    			jnitcmsmgmtService.updateJnitcmsmgmt(mgmtVO);

    			String boardLatestFileDir = root + "WEB-INF/jsp/jnit/board/latest/skin/"+siteVO.getSiteId()+"/"+mgmtVO.getMgmtNm()+".jsp";
    			mgmtVO.setMgmtContent(mgmtUtil.replaceMgmtSrc(mgmtVO.getMgmtContent(), mgmtType, mgmtVO.getBoardSkin(), null));
    			//미니게시판 JSON 핸들링
    			if(!mgmtUtil.boardLatestJSON(request, mgmtVO)){
    				JSON.put("status", "error");
    				JSON.put("path", contextPath+"/cms/mgmt/list.do?mgmtType="+mgmtType+"&mgmtId="+mgmtVO.getMgmtId());
    		    	model.addAttribute("json", JSON.toString());
    		    	return "/jnit/util/json";
    			}
    			CmsHandler.writeFile(boardLatestFileDir, mgmtUtil.setMgmtFileHeader(mgmtType, mgmtVO.getBoardSkin())+mgmtVO.getMgmtContent());
    		} catch (IOException e){
    			log.error(e.getMessage());
				JSON.put("status", "error");
			} catch (Exception e) {
				log.error(e.getMessage());
				JSON.put("status", "error");
			}
    	}
    	JSON.put("path", contextPath+"/cms/mgmt/list.do?mgmtType="+mgmtType+"&mgmtId="+mgmtVO.getMgmtId());
    	model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }

    @RequestMapping("/cms/ajax/mgmt/boardLatest.do")
    public String ajaxMgmtBoardLatest(HttpServletRequest request, ModelMap model)throws Exception{
    	String root = PathUtil.getRealPath(request);
    	String boardSkin = NullUtil.nullString(request.getParameter("boardSkin"));
    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));

    	JSONObject JSON = new JSONObject();
    	if(!"".equals(boardSkin)){
    		String boardLatestDir = root+"default/common/board/latest/"+boardSkin+".jsp";
    		try {
    			//역치환
    			JSON.put("mgmtContent", mgmtUtil.replaceMgmtSrc(CmsHandler.readFile(boardLatestDir), mgmtType, boardSkin, "return"));
    			model.addAttribute("json", JSON.toString());
    		} catch (IOException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
    	}
    	return "/jnit/util/json";
    }

    @RequestMapping("/cms/ajax/mgmt/boardLatest/skin.do")
    public String ajaxMgmtBoardLatestSkin(HttpServletRequest request, ModelMap model)throws Exception{
    	String root = PathUtil.getRealPath(request);
    	String boardSkin = NullUtil.nullString(request.getParameter("boardSkin"));
    	String boardSkinNm = NullUtil.nullString(request.getParameter("boardSkinNm"));
    	String boardSkinNmDir = root + "default/common/board/latest/"+boardSkinNm+".jsp";

    	JSONObject JSON = new JSONObject();

    	File boardSkinNmFile  = new File(boardSkinNmDir);
    	if(!boardSkinNmFile.exists()){
    		String boardSkinDir = root + "default/common/board/latest/"+boardSkin+".jsp";
    		try {
    			CmsHandler.writeFile(boardSkinNmDir, CmsHandler.readFile(boardSkinDir));
    			JSON.put("status", "success");
    		} catch (IOException e){
    			log.error(e.getMessage());
				JSON.put("status", "error");
				JSON.put("code", "FAIL 2");
			} catch (Exception e) {
				log.error(e.getMessage());
				JSON.put("status", "error");
				JSON.put("code", "FAIL 2");
			}
    	}else{
    		JSON.put("status", "error");
    		JSON.put("code", "FAIL 1");
    	}
    	model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }

    /**
     * 파일관리 시스템의 히스토리를 등록한다.
     * @param request
     * @param mgmtType
     * @param id
     * @param siteId
     * @param jnitcmsmgmtVO
     * @throws Exception
     */
    private void insertHsit(HttpServletRequest request, String mgmtType, String id, String siteId, JnitcmsmgmtVO jnitcmsmgmtVO)throws Exception{
    	if("css".equals(mgmtType)){
        	JnitcmscsshistVO csshistVO = new JnitcmscsshistVO();
            csshistVO.setSiteId(siteId);
            csshistVO.setMgmtId(id);
            csshistVO.setContent(jnitcmsmgmtVO.getMgmtContent());
            csshistVO.setMgmtActId(jnitcmsmgmtVO.getMgmtActId());
            csshistVO.setMgmtActIp(StringUtil.isExistString(request.getRequestURL().toString(),"local") == true ? "local" : request.getRemoteHost());
            jnitcmscsshistService.insertJnitcmscsshist(csshistVO);

        }else if("js".equals(mgmtType)){
        	JnitcmsscripthistVO scriptVO = new JnitcmsscripthistVO();
        	scriptVO.setSiteId(siteId);
        	scriptVO.setMgmtId(id);
        	scriptVO.setContent(jnitcmsmgmtVO.getMgmtContent());
        	scriptVO.setMgmtActId(jnitcmsmgmtVO.getMgmtActId());
        	scriptVO.setMgmtActIp(StringUtil.isExistString(request.getRequestURL().toString(),"local") == true ? "local" : request.getRemoteHost());
        	jnitcmsscripthistService.insertJnitcmsscripthist(scriptVO);
        }else if("boardLatest".equals(mgmtType)){
        	JnitcmsboardhistVO boardVO = new JnitcmsboardhistVO();
        	boardVO.setSiteId(siteId);
        	boardVO.setMgmtId(id);
        	boardVO.setContent(jnitcmsmgmtVO.getMgmtContent());
        	boardVO.setMgmtActId(jnitcmsmgmtVO.getMgmtActId());
        	boardVO.setMgmtActIp(StringUtil.isExistString(request.getRequestURL().toString(),"local") == true ? "local" : request.getRemoteHost());
        	boardVO.setBoardSkin(jnitcmsmgmtVO.getBoardSkin());
        	jnitcmsboardhistService.insertJnitcmsboardhist(boardVO);
        }
    }

    /**
     * 페이지 리턴 skin 폴더 유무
     * @param str
     * @return Boolean
     * @throws Exception
     */
    private Boolean isSkinList(String str)throws Exception{
    	str = NullUtil.nullString(str);
    	if(!"".equals(str)){
    		String[] skinList = {"img","video","file","boardLatest"};
    		if(StringUtil.isExistArray(skinList, str)) return true;
    	}
    	return false;
    }

    /**
     * 확장자가 이미지인지 확인 유무
     * @param str
     * @return Boolean
     * @throws Exception
     */
    private Boolean isImg(String str)throws Exception{
    	str = NullUtil.nullString(str);
    	if(!"".equals(str)){
    		str = str.substring(str.lastIndexOf(".")+1);
    		String[] skinList = {"bmp","jpg","gif","png","jpeg","tif", "img"};
    		if(StringUtil.isExistArray(skinList, str)) return true;
    	}
    	return false;
    }
    /**
     * 파일이름의 확장자를 리턴한다.
     * @param str
     * @return 확장자
     * @throws Exception
     */
    private String fileExp(String str)throws Exception{
    	str = NullUtil.nullString(str);
    	if(!"".equals(str)){
    		str = str.substring(str.lastIndexOf(".")+1);
    	}
    	return str;
    }

    /**
     * jnit/board/last 경로의 jsp 파일을 읽어온다.
     * @param request
     * @param model
     * @param mgmtVO
     * @return JnitcmsmgmtVO
     * @throws Exception
     */
    private ModelMap setBoardLatestList(HttpServletRequest request, ModelMap model)throws Exception{
    	String mgmtType = NullUtil.nullString(request.getParameter("mgmtType"));
    	String root = PathUtil.getRealPath(request);
    	if("boardLatest".equals(mgmtType)){
			String boardLatestDir = root + "default/common/board/latest";
			File boardLatest = new File(boardLatestDir);
			if(boardLatest.exists()){
				FilenameFilter filenameFilter = new FilenameFilter() {
					public boolean accept(File dir, String name) {
						if(!".svn".equals(name) && !"skin".equals(name)){
							return true;
						}else {
							return false;
						}
					}
				};
				String[] boardLatestList = boardLatest.list(filenameFilter);
				model.addAttribute("boardLatestList", boardLatestList);
			}
		}
    	return model;
    }

    private ModelMap setBoardIdList(HttpServletRequest request, ModelMap model, String mgmtType)throws Exception{
    	if("boardLatest".equals(mgmtType)){
    		JnitBoardDataVO searchVO = new JnitBoardDataVO();
    		searchVO.setRecordCountPerPage(0);
			List boardIdList = jnitBoardDataService.selectJnitBoardDataList(searchVO);
        	model.addAttribute("boardIdList", boardIdList);
    	}
    	return model;
    }
}