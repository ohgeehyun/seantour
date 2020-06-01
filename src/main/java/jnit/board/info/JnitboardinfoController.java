/**
 * @version 3.2.0.1
 */
package jnit.board.info;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.board.JnitboardController;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.site.JnitcmssiteDefaultVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
/**
 * @Class Name : JnitboardinfoController.java
 * @Description : Jnitboardinfo Controller class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.21
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=JnitboardinfoVO.class)
public class JnitboardinfoController {

	public static Log log = LogFactory.getLog(JnitboardinfoController.class);
	
    @Resource(name="egov.dataSource")
    private BasicDataSource dataSource;

    @Resource(name="txManager")
    private DataSourceTransactionManager txManager;

    public static final String SEPERATOR = File.separator;
    public static final String BOARD_PATH = "board" + SEPERATOR;
    public static final String BOARD_INFO_PATH = "board" + SEPERATOR + "_info" + SEPERATOR;

    public static final HashMap<String,String> skinTypeNm = new HashMap<String,String>();
    @Resource(name = "jnitboardinfoService")
    private JnitboardinfoService jnitboardinfoService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;

    @Resource(name="jnitcmssiteService")
    private JnitcmssiteService jnitcmssiteService;

    /** Validator */
    @Autowired
    private DefaultBeanValidator beanValidator;

    /**
	 * jnitboardinfo 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitboardinfoDefaultVO
	 * @return "/jnit/tpl-temp/jnitboardinfo/JnitboardinfoList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/board/list.do")
    public String selectJnitboardinfoList(@ModelAttribute("searchVO") JnitboardinfoDefaultVO searchVO,
    		ModelMap model,
    	    HttpServletRequest request)
            throws Exception {

    	AdminUtil.setMenuId("m06010100");
    	if("".equals(CmsHelper.getSessionSiteId(request))){
    		return "/jnit/cms/sub4_msg-nosite";
    	}

    	String siteId = CmsHelper.getSessionSiteId(request);

    	searchVO.setSearchKeyword(searchVO.getSearchKeyword());
    	searchVO.setSearchBoardGroup(searchVO.getSearchBoardGroup());

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

		searchVO.setSearchBoardGroup(siteId);
        List jnitboardinfoList = jnitboardinfoService.selectJnitboardinfoList(searchVO);
        model.addAttribute("resultList", jnitboardinfoList);

        int totCnt = jnitboardinfoService.selectJnitboardinfoListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		List boardGroupList = jnitboardinfoService.selectJnitboardinfoGroupList(searchVO);
		model.addAttribute("boardGroupList", boardGroupList);

        return "/jnit/cms/board/list";
    }

    @RequestMapping("/cms/jnit/board/boardcopy.do")
    public String boardcopy(
    		HttpServletRequest request,
    		ModelMap model) throws Exception{
    	String boardCopyId = NullUtil.nullString(request.getParameter("boardId"));

		if(!boardCopyId.equals("")){
			String boardcopyTitle = NullUtil.nullString(request.getParameter("boardcopyTitle"));
			//boardId load
	        JnitboardinfoVO boardVO = new JnitboardinfoVO();
	        boardVO.setBoardId(boardCopyId);
	        JnitboardinfoVO selectboardVO = jnitboardinfoService.selectJnitboardinfo(boardVO); //조회
	        //end boardId load

	        //board copy
	        selectboardVO.setBoardTitle(boardcopyTitle);

	        JnitboardinfoDefaultVO searchVO = new JnitboardinfoDefaultVO();

	        String alertStr = "";
	    	alertStr = "정상적으로 등록되었습니다";
	    	DefaultTransactionDefinition txDefinition = new DefaultTransactionDefinition();
	    	txDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
	    	TransactionStatus txStatus = txManager.getTransaction(txDefinition);
	    	String id;
	    	try{
	    		dataSource.setDefaultAutoCommit(false);//AutoCommit해제

    			id = jnitboardinfoService.insertJnitboardinfo(selectboardVO);
    			jnitboardinfoService.createNewBoard(selectboardVO.getBoardType(), id);
    			jnitboardinfoService.alterPrimaryKey(id);

	    		txManager.commit(txStatus); //커밋

	    		JSONObject infoJson = new JSONObject().fromObject(selectboardVO);
	    		File infoDir = new File(getBoardInfoPath(request));
	    		String infoPath =  getBoardInfoPath(request) + id.toUpperCase() + ".json";
	    		if(!infoDir.exists()){
	    			infoDir.mkdir();
	    		}
	    		FileWriter infoFileW = new FileWriter(infoPath);
	    		infoFileW.write(infoJson.toString());
	    		JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, infoPath);		//Filego 배포
	    		infoFileW.flush();
	    		infoFileW.close();
	    	} catch (NullPointerException e){
	    		txManager.rollback(txStatus); //롤백
	    		alertStr = "오류가 발생했습니다.\\n" + StringUtil.removeHtml(e.getLocalizedMessage()).replaceAll(";", "\\n");
	    		log.error(e.getMessage());
	    	}catch(Exception e){
	    		txManager.rollback(txStatus); //롤백
	    		alertStr = "오류가 발생했습니다.\\n" + StringUtil.removeHtml(e.getLocalizedMessage()).replaceAll(";", "\\n");
	    		log.error(e.getMessage());
	    	}finally {
	    		dataSource.setDefaultAutoCommit(true);
	    	}
	    	//end board copy
		}
    	return "jnit/cms/board/redirectboard";
    }


    @RequestMapping("/cms/board/step1.do")
    public String boardStep1(@ModelAttribute("searchVO") JnitboardinfoDefaultVO searchVO
    		, Model model
    		, HttpServletRequest request)throws Exception{
    	AdminUtil.setMenuId("m06010100");
    	if("".equals(CmsHelper.getSessionSiteId(request))){
    		return "/jnit/cms/sub4_msg-nosite";
    	}
    	String siteId = CmsHelper.getSessionSiteId(request);
    	searchVO.setSearchBoardGroup(siteId);

    	JnitboardinfoVO infoVO = new JnitboardinfoVO();
    	model.addAttribute("skinList",getSkinList(request));
    	model.addAttribute("skinTypeList",getSkinTypeList(request,"basic"));
    	model.addAttribute("mode","add");
    	model.addAttribute("modeStr","등록");
        model.addAttribute("searchVO", searchVO);
        model.addAttribute("jnitboardinfoVO", infoVO);
    	return "/jnit/cms/board/step1";
    }



    @RequestMapping("/cms/board/add.do")
    public String addJnitBoardInfoView(@ModelAttribute("searchVO") JnitboardinfoDefaultVO searchVO
            , @ModelAttribute("jnitboardinfoVO") JnitboardinfoVO jnitboardinfoVO
            , Model model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m06010100");
    	if("".equals(CmsHelper.getSessionSiteId(request))){
    		return "/jnit/cms/sub4_msg-nosite";
    	}
    	String siteId = CmsHelper.getSessionSiteId(request);
    	searchVO.setSearchBoardGroup(siteId);
    	model.addAttribute("skinList",getSkinList(request));

    	model.addAttribute("skinTypeList",getSkinTypeList(request,jnitboardinfoVO.getBoardSkin()));
    	model.addAttribute("mode","add");
    	model.addAttribute("modeStr","등록");
        model.addAttribute("searchVO", searchVO);
        return "/jnit/cms/board/add";
    }


    @RequestMapping("/cms/board/edit")
    public String updateJnitBoardInfoView(
    		@ModelAttribute("searchVO") JnitboardinfoDefaultVO searchVO,
            @RequestParam("boardId") String boardId , Model model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m06010100");
    	if("".equals(CmsHelper.getSessionSiteId(request))){
    		return "/jnit/cms/sub4_msg-nosite";
    	}
    	String siteId = CmsHelper.getSessionSiteId(request);
    	searchVO.setSearchBoardGroup(siteId);

    	JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
    	jnitboardinfoVO.setBoardId(boardId);
    	jnitboardinfoVO = jnitboardinfoService.selectJnitboardinfo(jnitboardinfoVO);

    	String[] admExt = NullUtil.nullString(jnitboardinfoVO.getAdmExt()).split(",");
    	JnitcmsmbrVO jnitcmsmbrVO = new JnitcmsmbrVO();
    	if(!"".equals(NullUtil.nullString(jnitboardinfoVO.getAdmExt()))) model.addAttribute("admCount",admExt.length);
    	HashMap<Integer, String> admNm = new HashMap<Integer, String>();
    	HashMap<Integer, String> admGd = new HashMap<Integer, String>();
  		if(admExt.length >0){
  			for(int i=0;i<admExt.length;i++){
  				jnitcmsmbrVO.setMbrId(admExt[i]);
  				try{
  					jnitcmsmbrVO = jnitcmsmbrService.selectJnitcmsmbr(jnitcmsmbrVO);
  					admNm.put(i, jnitcmsmbrVO.getMbrNm());
  				} catch (NullPointerException e){
  					log.error(e.getMessage());
  				}catch(Exception e){
  					log.error(e.getMessage());
  				}
  			}
  		}

  		model.addAttribute("admNm",admNm);
    	model.addAttribute("skinList",getSkinList(request));
    	model.addAttribute("skinTypeList",getSkinTypeList(request,jnitboardinfoVO.getBoardSkin()));
        model.addAttribute("mode","edit");
        model.addAttribute("modeStr","수정");
        model.addAttribute("searchVO", searchVO);
        model.addAttribute("jnitboardinfoVO", jnitboardinfoVO);
        model.addAttribute("getTmp1", jnitboardinfoService.isIconFileExists(request, boardId, new JSONObject().fromObject(jnitboardinfoVO.getTmp1())));

        return "/jnit/cms/board/add";
    }

    @RequestMapping("/cms/board/proc.do")
    public String procJnitBoardInfo(
    		@ModelAttribute("searchVO") JnitboardinfoDefaultVO searchVO,
    		@ModelAttribute("jnitboardinfoVO") JnitboardinfoVO jnitboardinfoVO,
    		BindingResult bindingResult,
    		SessionStatus status,
    		HttpServletRequest request,
    		@RequestParam("mode") String mode,
    		Model model)
    throws Exception {
    	String alertStr = "";
    	alertStr = mode.equals("edit") ? "정상적으로 수정되었습니다" : "정상적으로 등록되었습니다";
    	DefaultTransactionDefinition txDefinition = new DefaultTransactionDefinition();
    	txDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
    	TransactionStatus txStatus = txManager.getTransaction(txDefinition);
    	String id;
    	try{
    		dataSource.setDefaultAutoCommit(false);//AutoCommit해제

    		jnitboardinfoVO.setTmp1(jnitboardinfoService.makeIconJSON(request).toString());	//new 아이콘 설정
    		if(mode.equals("edit")){
    			id = jnitboardinfoVO.getBoardId();
    			jnitboardinfoService.updateJnitboardinfo(jnitboardinfoVO);
    		}else{
    			//TODO : MySQL 5.6 버전에서  ENFORCE_GTID_CONSISTENCY 옵션 관련 제약으로 인해 create table ** select 문을 수정해서 임시 사용함
    			id = jnitboardinfoService.insertJnitboardinfo(jnitboardinfoVO);
    			jnitboardinfoService.createNewBoard(jnitboardinfoVO.getBoardType(), id);
    			//jnitboardinfoService.alterPrimaryKey(id); //TODO : ENFORCE_GTID_CONSISTENCY 옵션 변경 가능 시 주석 해제
    		}
    		txManager.commit(txStatus); //커밋
    		jnitboardinfoService.uploadFormWorkFiles(request, id, null, jnitboardinfoService.makeIconJSON(request)); //upload _info/img

    		JSONObject infoJson = new JSONObject().fromObject(jnitboardinfoVO);
    		/* infoJson.put("tmp1", newIconJob1.toString()); */
    		File infoDir = new File(getBoardInfoPath(request));
    		String infoPath =  getBoardInfoPath(request) + id.toUpperCase() + ".json";
    		if(!infoDir.exists()){
    			infoDir.mkdir();
    		}
    		FileWriter infoFileW = new FileWriter(infoPath);
    		infoFileW.write(infoJson.toString());
    		JnitFilegoUtil.transferFile(JnitFilegoFileType.CONTENT, infoPath);		//Filego 배포
    		infoFileW.flush();
    		infoFileW.close();
    	} catch (NullPointerException e){
    		txManager.rollback(txStatus); //롤백
    		alertStr = "오류가 발생했습니다.\\n" + StringUtil.removeHtml(e.getLocalizedMessage()).replaceAll(";", "\\n");
    		log.error(e.getMessage());
    	}catch(Exception e){
    		txManager.rollback(txStatus); //롤백
    		alertStr = "오류가 발생했습니다.\\n" + StringUtil.removeHtml(e.getLocalizedMessage()).replaceAll(";", "\\n");
    		log.error(e.getMessage());
    	}finally {
    		status.setComplete();
    		dataSource.setDefaultAutoCommit(true);
    	}


    	model.addAttribute("alert",alertStr);
    	//model.addAttribute("listPath","");//
    	String schParam = "pageIndex="+searchVO.getPageIndex()
    	+"&searchCondition="+searchVO.getSearchCondition()
    	+"&searchKeyword="+URLEncoder.encode(searchVO.getSearchKeyword(),"UTF-8")
    	+"&searchBoardGroup="+URLEncoder.encode(searchVO.getSearchBoardGroup(),"UTF-8");
    	model.addAttribute("path","/cms/board/list.do?"+schParam);
    	model.addAttribute("searchVO", searchVO);
    	return "/jnit/util/alertMove";
    }


    @RequestMapping("/cms/board/_getSkinType.do")
    public String jsonJnitBoardSkinType(
            @RequestParam("skin") String skin, Model model, HttpServletRequest request)
            throws Exception {
    	AdminUtil.setMenuId("m06010100");
    	List skinTypeList = getSkinTypeList(request,skin);
    	JSONArray typeJSON = JSONArray.fromObject(skinTypeList);
    	model.addAttribute("json",typeJSON);
        return "/jnit/util/json";
    }

    /**
	 * Board Path 절대경로를 리턴한다.
	 * @param request - HttpServletRequest
	 * @return String Board Path
	 * @exception Exception
	 */
    public static String getBoardPath(HttpServletRequest request){
    	String boardPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + BOARD_PATH;
    	return boardPath;
    }

    /**
	 * Board Info Path 절대경로를 리턴한다.
	 * @param request - HttpServletRequest
	 * @return String Board Info Path
	 * @exception Exception
	 */
    public static String getBoardInfoPath(HttpServletRequest request){

    	//String boardInfoPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + BOARD_INFO_PATH;
    	String boardInfoPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + BOARD_INFO_PATH;
    	return boardInfoPath;
    }

    /**
	 * JnitboardinfoVO를 json파일에서 읽어 리턴한다.
	 * @param request - HttpServletRequest, boardId - BoardId값
	 * @return JnitboardinfoVO
	 * @exception Exception
	 */
    public static JnitboardinfoVO getBoardInfoVO(HttpServletRequest request, String boardId)
    throws Exception {
    	JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
    	String boardInfoPath = getBoardInfoPath(request) + boardId.toUpperCase() + ".json";
    	//log.debug("boardInfoPath :" + boardInfoPath);

    	JSONParser jsonParser = new JSONParser();
    	JSONObject infoJson = new JSONObject();

    		infoJson = new JSONObject().fromObject(jsonParser.parse(new FileReader(boardInfoPath)));

    		Class jnitboardinfoVOClass = new JnitboardinfoVO().getClass();
    	Field[] fields = jnitboardinfoVOClass.getDeclaredFields();

    	for(Field f : fields )
    	{
    		try{
    			String fName = f.getName().substring(0, 1).toUpperCase()+f.getName().substring(1, f.getName().length());
    			Method setMethod = jnitboardinfoVOClass.getMethod("set"+fName, f.getType());
    			setMethod.invoke(jnitboardinfoVO, infoJson.get(f.getName()));
    		}catch(NoSuchMethodException exception){
    			//log.error(exception.getMessage());
    		}

    	}
    	return jnitboardinfoVO;
    }

    @RequestMapping("/cms/board/searchAjax.do")
    public String mbrSearchBoardProc(
    		@ModelAttribute("searchVO") JnitboardinfoDefaultVO searchVO,
    		HttpServletRequest request,
    		ModelMap model) throws Exception {
    	String searchBoardGroup = NullUtil.nullString(request.getParameter("searchBoardGroup"));
    	String searchCondition = NullUtil.nullString(request.getParameter("searchCondition"));
    	String searchKeyword = NullUtil.nullString(request.getParameter("searchKeyword"));
    	String ajaxList = NullUtil.nullString(request.getParameter("ajaxList"));

    	if(!"".equals(searchBoardGroup))searchVO.setSearchBoardGroup(searchBoardGroup);
    	searchVO.setSearchCondition(searchCondition);
    	searchVO.setSearchKeyword(searchKeyword);
    	if("Y".equals(ajaxList)){
        	searchVO.setRecordCountPerPage(5);
        	PaginationInfo paginationInfo = new PaginationInfo();
    		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());

    		paginationInfo.setRecordCountPerPage(5);
    		paginationInfo.setPageSize(5);
    		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
    		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		paginationInfo.setTotalRecordCount(jnitboardinfoService.selectJnitboardinfoListTotCnt(searchVO));
    		model.addAttribute("paginationInfo", paginationInfo);
    	}else{
	    	searchVO.setFirstIndex(0);
	    	searchVO.setRecordCountPerPage(1000);
    	}
    	List schResult = jnitboardinfoService.selectJnitboardArticleList(searchVO);
		JSONArray jsonArr = new JSONArray().fromObject(schResult);
    	model.addAttribute("json",jsonArr);
    	if("Y".equals(ajaxList)){
    		model.addAttribute("resultList",schResult);
    		return "jnit/board/data/boardList";
    	}
    	return "jnit/util/json";
    }

    /**
	 * 필드의 정보가 담긴 맵을 리턴한다.
	 * @param jnitboardinfoVO - JnitboardinfoVO
	 * @return HashMap - 필드의 정보가 담긴 맵
	 * @exception Exception
	 */
    public static HashMap<String,Object> getFieldInfo(JnitboardinfoVO infoVO)
    throws Exception {

    	HashMap<String,Object> infoMap = new HashMap<String,Object>();
    	HashMap<String,Object> fieldMap = new HashMap<String,Object>();
    	String[] lbl = infoVO.getBoardLbl().split("\\|");
    	/** no */
    	fieldMap.put("lbl",getFieldLable(lbl[0]));
    	infoMap.put("no", fieldMap.clone());
    	/** title */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(lbl[1]));
    	infoMap.put("title", fieldMap.clone());
    	/** writer */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(lbl[2]));
    	infoMap.put("writer", fieldMap.clone());
    	/** created */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(lbl[3]));
    	infoMap.put("created", fieldMap.clone());
    	/** hit */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(lbl[4]));
    	infoMap.put("hit", fieldMap.clone());
    	/** content */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(lbl[5]));
    	infoMap.put("content", fieldMap.clone());
    	/** password */
    	fieldMap.clear();
    	fieldMap.put("lbl", "비밀번호");
    	infoMap.put("password", fieldMap.clone());
    	/** file */
    	fieldMap.clear();
    	fieldMap.put("lbl", "첨부");
    	infoMap.put("file", fieldMap.clone());
    	/** Field 01 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt01Lbl()));
    	fieldMap.put("type", infoVO.getExt01Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt01Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt01Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt01Lbl()));
    	}
    	if("check".equals(infoVO.getExt01Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt01Lbl()));
    	}
    	infoMap.put("ext01", fieldMap.clone());
    	/** Field 02 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt02Lbl()));
    	fieldMap.put("type", infoVO.getExt02Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt02Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt02Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt02Lbl()));
    	}
    	if("check".equals(infoVO.getExt02Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt02Lbl()));
    	}
    	infoMap.put("ext02", fieldMap.clone());
    	/** Field 03 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt03Lbl()));
    	fieldMap.put("type", infoVO.getExt03Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt03Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt03Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt03Lbl()));
    	}
    	if("check".equals(infoVO.getExt03Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt03Lbl()));
    	}
    	infoMap.put("ext03", fieldMap.clone());
    	/** Field 04 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt04Lbl()));
    	fieldMap.put("type", infoVO.getExt04Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt04Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt04Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt04Lbl()));
    	}
    	if("check".equals(infoVO.getExt04Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt04Lbl()));
    	}
    	infoMap.put("ext04", fieldMap.clone());
    	/** Field 05 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt05Lbl()));
    	fieldMap.put("type", infoVO.getExt05Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt05Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt05Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt05Lbl()));
    	}
    	if("check".equals(infoVO.getExt05Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt05Lbl()));
    	}
    	infoMap.put("ext05", fieldMap.clone());
    	/** Field 06 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt06Lbl()));
    	fieldMap.put("type", infoVO.getExt06Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt06Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt06Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt06Lbl()));
    	}
    	if("check".equals(infoVO.getExt06Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt06Lbl()));
    	}
    	infoMap.put("ext06", fieldMap.clone());
    	/** Field 07 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt07Lbl()));
    	fieldMap.put("type", infoVO.getExt07Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt07Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt07Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt07Lbl()));
    	}
    	if("check".equals(infoVO.getExt07Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt07Lbl()));
    	}
    	infoMap.put("ext07", fieldMap.clone());
    	/** Field 08 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt08Lbl()));
    	fieldMap.put("type", infoVO.getExt08Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt08Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt08Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt08Lbl()));
    	}
    	if("check".equals(infoVO.getExt08Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt08Lbl()));
    	}
    	infoMap.put("ext08", fieldMap.clone());
    	/** Field 09 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt09Lbl()));
    	fieldMap.put("type", infoVO.getExt09Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt09Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt09Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt09Lbl()));
    	}
    	if("check".equals(infoVO.getExt09Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt09Lbl()));
    	}
    	infoMap.put("ext09", fieldMap.clone());
    	/** Field 10 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt10Lbl()));
    	fieldMap.put("type", infoVO.getExt10Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt10Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt10Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt10Lbl()));
    	}
    	if("check".equals(infoVO.getExt10Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt10Lbl()));
    	}
    	infoMap.put("ext10", fieldMap.clone());
    	/** Field 11 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt11Lbl()));
    	fieldMap.put("type", infoVO.getExt11Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt11Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt11Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt11Lbl()));
    	}
    	if("check".equals(infoVO.getExt11Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt11Lbl()));
    	}
    	infoMap.put("ext11", fieldMap.clone());
    	/** Field 12 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt12Lbl()));
    	fieldMap.put("type", infoVO.getExt12Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt12Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt12Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt12Lbl()));
    	}
    	if("check".equals(infoVO.getExt12Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt12Lbl()));
    	}
    	infoMap.put("ext12", fieldMap.clone());
    	/** Field 13 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt13Lbl()));
    	fieldMap.put("type", infoVO.getExt13Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt13Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt13Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt13Lbl()));
    	}
    	if("check".equals(infoVO.getExt13Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt13Lbl()));
    	}
    	infoMap.put("ext13", fieldMap.clone());
    	/** Field 14 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt14Lbl()));
    	fieldMap.put("type", infoVO.getExt14Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt14Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt14Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt14Lbl()));
    	}
    	if("check".equals(infoVO.getExt14Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt14Lbl()));
    	}
    	infoMap.put("ext14", fieldMap.clone());
    	/** Field 15 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt15Lbl()));
    	fieldMap.put("type", infoVO.getExt15Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt15Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt15Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt15Lbl()));
    	}
    	if("check".equals(infoVO.getExt15Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt15Lbl()));
    	}
    	infoMap.put("ext15", fieldMap.clone());
    	/** Field 16 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt16Lbl()));
    	fieldMap.put("type", infoVO.getExt16Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt16Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt16Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt16Lbl()));
    	}
    	if("check".equals(infoVO.getExt16Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt16Lbl()));
    	}
    	infoMap.put("ext16", fieldMap.clone());
    	/** Field 17 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt17Lbl()));
    	fieldMap.put("type", infoVO.getExt17Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt17Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt17Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt17Lbl()));
    	}
    	if("check".equals(infoVO.getExt17Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt17Lbl()));
    	}
    	infoMap.put("ext17", fieldMap.clone());
    	/** Field 18 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt18Lbl()));
    	fieldMap.put("type", infoVO.getExt18Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt18Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt18Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt18Lbl()));
    	}
    	if("check".equals(infoVO.getExt18Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt18Lbl()));
    	}
    	infoMap.put("ext18", fieldMap.clone());
    	/** Field 19 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt19Lbl()));
    	fieldMap.put("type", infoVO.getExt19Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt19Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt19Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt19Lbl()));
    	}
    	if("check".equals(infoVO.getExt19Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt19Lbl()));
    	}
    	infoMap.put("ext19", fieldMap.clone());
    	/** Field 20 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getExt20Lbl()));
    	fieldMap.put("type", infoVO.getExt20Opt());
    	fieldMap.put("required", "*".equals(infoVO.getExt20Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getExt20Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt20Lbl()));
    	}
    	if("check".equals(infoVO.getExt20Opt())){
    		fieldMap.put("item", getListItems(infoVO.getExt20Lbl()));
    	}
    	infoMap.put("ext20", fieldMap.clone());
    	/** DATE 01 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getDate01Lbl()));
    	fieldMap.put("type", infoVO.getDate01Opt());
    	fieldMap.put("required", "*".equals(infoVO.getDate01Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getDate01Opt())){
    		fieldMap.put("item", getListItems(infoVO.getDate01Lbl()));
    	}
    	infoMap.put("date01", fieldMap.clone());
    	/** DATE 02 */
    	fieldMap.clear();
    	fieldMap.put("lbl", getFieldLable(infoVO.getDate02Lbl()));
    	fieldMap.put("type", infoVO.getDate02Opt());
    	fieldMap.put("required", "*".equals(infoVO.getDate02Lbl().substring(0, 1)) ? true : false);
    	if("select".equals(infoVO.getDate02Opt())){
    		fieldMap.put("item", getListItems(infoVO.getDate02Lbl()));
    	}
    	infoMap.put("date02", fieldMap.clone());

    	return infoMap;
    }
    /**
	 * 컴마로 구분된 스트링으로 linkedList를 만든다.
	 * @param itemString - String(컴마로 구분된)
	 * @return HashMap - 필드의 정보가 담긴 맵
	 * @exception Exception
	 */
    public static LinkedList<String> getListItems(String itemString)
    throws Exception {
    	LinkedList<String> itemList = new LinkedList<String>();
    	String[] items = itemString.split(",");
    	for(String v : items){
    		itemList.add(v);
    	}
    	itemList.removeFirst();
    	return itemList;
    }
    /**
	 * 레이블 필드에서 레이블 스트링만 가져온다
	 * @param lblString - String(컴마로 구분된)
	 * @return String - 필드의 레이블
	 * @exception Exception
	 */
    public static String getFieldLable(String lblString)
    throws Exception {
    	String[] lbls = lblString.split(",");
    	String lable = NullUtil.nullString(lbls[0].replaceAll("\\*", ""));

    	return lable;
    }
    /**
	 * 기본필드의 레이블정보가 담긴 맵을 리턴한다.
	 * @param jnitboardinfoVO - JnitboardinfoVO
	 * @return HashMap - 기본필드의 레이블 정보가 담긴 맵
	 * @exception Exception
	 */
    public static HashMap<String,String> getBoardLable(JnitboardinfoVO jnitboardinfoVO)
    throws Exception {
    	HashMap<String,String> lblMap = new HashMap<String,String>();
    	String[] lbl = jnitboardinfoVO.getBoardLbl().split("\\|");
    	lblMap.put("no", NullUtil.nullString(lbl[0]));
    	lblMap.put("title", NullUtil.nullString(lbl[1]));
    	lblMap.put("writer", NullUtil.nullString(lbl[2]));
    	lblMap.put("created", NullUtil.nullString(lbl[3]));
    	lblMap.put("hit", NullUtil.nullString(lbl[4]));
    	lblMap.put("content", NullUtil.nullString(lbl[5]));
		lblMap.put("password", JnitboardController.isLanguage("비밀번호", jnitboardinfoVO.getUseLanguage()));
    	lblMap.put("file", JnitboardController.isLanguage("첨부", jnitboardinfoVO.getUseLanguage()));
    	if(jnitboardinfoVO.getUseCategory() == 1){
    		lblMap.put("category", getFieldLable(jnitboardinfoVO.getCategory()));
    	}
    	if(jnitboardinfoVO.getUseExt01() > 0){
    		lblMap.put("ext01", getFieldLable(jnitboardinfoVO.getExt01Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt02() > 0){
    		lblMap.put("ext02", getFieldLable(jnitboardinfoVO.getExt02Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt03() > 0){
    		lblMap.put("ext03", getFieldLable(jnitboardinfoVO.getExt03Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt04() > 0){
    		lblMap.put("ext04", getFieldLable(jnitboardinfoVO.getExt04Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt05() > 0){
    		lblMap.put("ext05", getFieldLable(jnitboardinfoVO.getExt05Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt06() > 0){
    		lblMap.put("ext06", getFieldLable(jnitboardinfoVO.getExt06Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt07() > 0){
    		lblMap.put("ext07", getFieldLable(jnitboardinfoVO.getExt07Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt08() > 0){
    		lblMap.put("ext08", getFieldLable(jnitboardinfoVO.getExt08Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt09() > 0){
    		lblMap.put("ext09", getFieldLable(jnitboardinfoVO.getExt09Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt10() > 0){
    		lblMap.put("ext10", getFieldLable(jnitboardinfoVO.getExt10Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt11() > 0){
    		lblMap.put("ext11", getFieldLable(jnitboardinfoVO.getExt11Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt12() > 0){
    		lblMap.put("ext12", getFieldLable(jnitboardinfoVO.getExt12Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt13() > 0){
    		lblMap.put("ext13", getFieldLable(jnitboardinfoVO.getExt13Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt14() > 0){
    		lblMap.put("ext14", getFieldLable(jnitboardinfoVO.getExt14Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt14() > 0){
    		lblMap.put("ext14", getFieldLable(jnitboardinfoVO.getExt14Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt15() > 0){
    		lblMap.put("ext15", getFieldLable(jnitboardinfoVO.getExt15Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt16() > 0){
    		lblMap.put("ext16", getFieldLable(jnitboardinfoVO.getExt16Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt17() > 0){
    		lblMap.put("ext17", getFieldLable(jnitboardinfoVO.getExt17Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt18() > 0){
    		lblMap.put("ext18", getFieldLable(jnitboardinfoVO.getExt18Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt19() > 0){
    		lblMap.put("ext19", getFieldLable(jnitboardinfoVO.getExt19Lbl()));
    	}
    	if(jnitboardinfoVO.getUseExt20() > 0){
    		lblMap.put("ext20", getFieldLable(jnitboardinfoVO.getExt20Lbl()));
    	}
    	if(jnitboardinfoVO.getUseDate01() > 0){
    		lblMap.put("date01", getFieldLable(jnitboardinfoVO.getDate01Lbl()));
    	}
    	if(jnitboardinfoVO.getUseDate02() > 0){
    		lblMap.put("date02", getFieldLable(jnitboardinfoVO.getDate02Lbl()));
    	}
    	return lblMap;
    }

    /**
	 * 카테고리정보가 담긴 리스트을 리턴한다.
	 * @param jnitboardinfoVO - JnitboardinfoVO
	 * @return LinkedList - 카테고리정보가 담긴 링크드리스트
	 * @exception Exception
	 */
    public static List getCategoryList(JnitboardinfoVO jnitboardinfoVO)
    throws Exception {
    	LinkedList<String> categoryList = new LinkedList();

    	if(NullUtil.nullString(jnitboardinfoVO.getCategory()).equals("")){
    		return categoryList;
    	}else{
	    	String[] ctgy = jnitboardinfoVO.getCategory().split(",");
	    	for(String v : ctgy){
	    		categoryList.add(v.trim());
	    	}
	    	categoryList.removeFirst();
	    	return categoryList;
    	}
    }

    /**
	 * 리스트필드노출순서가 담긴 리스트을 리턴한다.
	 * @param jnitboardinfoVO - JnitboardinfoVO
	 * @return LinkedList - 필드노출순서가 담긴 링크드리스트
	 * @exception Exception
	 */
    public static List getFieldSortList(JnitboardinfoVO jnitboardinfoVO)
    throws Exception {
    	LinkedList<String> fieldList = new LinkedList();
    	String[] sorts = jnitboardinfoVO.getFieldSortList().split(",");
    	for(String v : sorts){
    		fieldList.add(v);
    	}
    	return fieldList;
    }
    /**
	 * 등록필드노출순서가 담긴 리스트을 리턴한다.
	 * @param jnitboardinfoVO - JnitboardinfoVO
	 * @return LinkedList - 필드노출순서가 담긴 링크드리스트
	 * @exception Exception
	 */
    public static List getFieldSortWrite(JnitboardinfoVO jnitboardinfoVO)
    throws Exception {
    	LinkedList<String> fieldList = new LinkedList();
    	String[] sorts = jnitboardinfoVO.getFieldSortWrite().split(",");
    	for(String v : sorts){
    		fieldList.add(v);
    	}
    	return fieldList;
    }
    /**
	 * 조회필드노출순서가 담긴 리스트을 리턴한다.
	 * @param jnitboardinfoVO - JnitboardinfoVO
	 * @return LinkedList - 조회노출순서가 담긴 링크드리스트
	 * @exception Exception
	 */
    public static List getFieldSortView(JnitboardinfoVO jnitboardinfoVO)
    throws Exception {
    	LinkedList<String> fieldList = new LinkedList();
    	String[] sorts = jnitboardinfoVO.getFieldSortView().split(",");
    	for(String v : sorts){
    		fieldList.add(v);
    	}
    	return fieldList;
    }

    /**
	 * 게시판 스킨 목록을 조회한다.
	 * @param void
	 * @return Skin LIST
	 * @exception
	 */
	public List<String> getSkinList(HttpServletRequest request) throws Exception{

		String boardPathStr = getBoardPath(request)+ SEPERATOR +"skin";
		File boardDirLst = new File(boardPathStr);
		FilenameFilter filter = new FilenameFilter() {

			public boolean accept(File f, String name) {
				if(f.isDirectory() && ! "_".equals(name.substring(0, 1)) && !".svn".equals(name) ){
					return true;
				}else{
					return false;
				}

			}
		};
		String[] dirList = boardDirLst.list(filter);
		if(dirList == null) dirList = new String[0];
		List<String> skinList = Arrays.asList(dirList);
		
		return skinList;
	}
    /**
	 * 게시판 스킨의 유형 목록을 조회한다.
	 * @param void
	 * @return Skin LIST
	 * @exception
	 */
	public List<String> getSkinTypeList(HttpServletRequest request,String skin) throws Exception{

		String boardSkinPathStr = getBoardPath(request) + SEPERATOR +"skin"+ SEPERATOR + skin;

		//log.debug("boardSkinPathStr : " + boardSkinPathStr);
		File boardSkinDirLst = new File(boardSkinPathStr);
		FilenameFilter filter = new FilenameFilter() {

			public boolean accept(File f, String name) {
				if(f.isDirectory() && "_".equals(name.substring(0, 1)) && !".svn".equals(name) && name.split("_").length < 3){
					return true;
				}else{
					return false;
				}

			}
		};
		String[] dirList = boardSkinDirLst.list(filter);
		if(dirList == null) dirList = new String[0];
		List<String> skinList = Arrays.asList(dirList);
		
		for(int i = 0; i<skinList.size();i++){
			skinList.set(i, skinList.get(i).replace("_", ""));
		}

		return skinList;
	}

	@RequestMapping("/cms/board/procDel.do")
	public String boardDelete(
			@ModelAttribute("jnitboardinfoVO") JnitboardinfoVO jnitboardinfoVO
			, HttpServletRequest request
			) throws Exception{

		String boardId = jnitboardinfoVO.getBoardId();
		//log.debug("boardId : " + boardId);

		JnitboardinfoVO vo = new JnitboardinfoVO();
			vo.setBoardId(boardId);
			vo.setIsdel(1);

		jnitboardinfoService.deleteJnitboardinfoIsdel(vo);
		return "redirect:/cms/board/list.do";
	}

	@RequestMapping("/cms/board/ajax/importCode.do")
	public String boardAjaxImportCode(HttpServletRequest request, ModelMap model)throws Exception{
		String boardId = NullUtil.nullString(request.getParameter("boardId"));
		model.addAttribute("boardId", boardId);
		return "/jnit/cms/board/importCode";
	}

	@RequestMapping("/cms/board/info/ajax/iconUploadfile.do")
	public String boardInfoAjaxUploadFile(@ModelAttribute("jnitboardinfoVO") JnitboardinfoVO jnitboardinfoVO
			,HttpServletRequest request, ModelMap model)throws Exception{
		String name = NullUtil.nullString(request.getParameter("name"));
		String imgType = NullUtil.nullString(request.getParameter("imgType"));
		JSONObject JSON = new JSONObject();
		try {
			jnitboardinfoService.uploadFormWorkFiles(request, jnitboardinfoVO.getBoardId(), null, jnitboardinfoService.makeIconJSON(request));
			JSON.put("status", "success");
			JSON.put("name", name);
			JSON.put("imgType", imgType);
		} catch (NullPointerException e){
			JSON.put("status", "error");
		} catch (Exception e) {
			JSON.put("status", "error");
		}
		model.addAttribute("json", JSON.toString());
		return "/jnit/util/json";
	}

	/**
   	 * AP센터 - 게시판 - 게시글 관리 리스트페이지
   	 */
	@RequestMapping(value="/cms/mgmt/board/list.do")
	public String selectMgmtboardinfoList(@ModelAttribute("searchVO") JnitboardinfoDefaultVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {

		AdminUtil.setMenuId("m06010400");
		JnitcmsmbrVO loginVO = new JnitcmsmbrVO();
		loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);

		JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteVO();
		siteSearchVO.setFirstIndex(0);
		siteSearchVO.setRecordCountPerPage(1000);
		List siteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);
		model.addAttribute("siteList", siteList);

		if(loginVO == null){
			model.addAttribute("alert","로그인 하셔야 합니다.");
			return "/jnit/util/alertBack";
		}

		return "/jnit/cms/board/manage/List";
	}

	/**
   	 * AP센터 - 게시판 - 게시글 관리 데이터 테이블
   	 */
	@RequestMapping(value="/cms/mgmt/board/data.do")
	public String selectMgmtboardData(@ModelAttribute("searchVO") JnitboardinfoDefaultVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {

		AdminUtil.setMenuId("m06010400");
		JnitcmsmbrVO loginVO = new JnitcmsmbrVO();
		loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);

		if(loginVO == null){
			model.addAttribute("alert","로그인 하셔야 합니다.");
			return "/jnit/util/alertBack";
		}

		String searchBoardName = NullUtil.nullString(request.getParameter("searchBoardName"));
		String searchSiteId = NullUtil.nullString(request.getParameter("searchSiteId"));
		String orderByCondition = NullUtil.nullString(request.getParameter("orderByCondition"));

		if(orderByCondition.equals("up")){
			orderByCondition = "up";
		}else if(orderByCondition.equals("down")){
			orderByCondition = "down";
		}else{
			orderByCondition = "";
		}

		searchVO.setSearchKeyword(searchVO.getSearchKeyword());
		searchVO.setSearchBoardGroup(searchVO.getSearchBoardGroup());

		searchVO.setPageYn("N");									//페이지 네비게이션 사용 안함.
		searchVO.setSearchCondition("mgmt");
		searchVO.setSearchKeyword(loginVO.getTypeVO().getTypeLv());
		searchVO.setSearchKeyword2(loginVO.getMbrId());
		searchVO.setSearchKeyword3((searchBoardName.equals("") ? null : searchBoardName));
		searchVO.setSearchKeyword4((searchSiteId.equals("") ? null : searchSiteId));
		searchVO.setOrderByCondition((orderByCondition.equals("") ? null : orderByCondition));

		List jnitboardinfoList = jnitboardinfoService.selectJnitboardinfoList(searchVO);
		model.addAttribute("resultList", jnitboardinfoList);

		JnitcmssiteDefaultVO siteSearchVO = new JnitcmssiteVO();
		siteSearchVO.setFirstIndex(0);
		siteSearchVO.setRecordCountPerPage(1000);
		List siteList = jnitcmssiteService.selectJnitcmssiteList(siteSearchVO);

		String key = "";
   		String value = "";
   		JSONObject siteResult = new JSONObject();
   		for(int i=0; i<siteList.size(); i++){
   			EgovMap map = (EgovMap) siteList.get(i);
   			key = (String)map.get("siteId");
   			value = (String)map.get("siteNm");
   			siteResult.put(key, value);
   		}

		model.addAttribute("siteList", siteList);
		model.addAttribute("siteResult", siteResult);

		return "/jnit/cms/board/manage/AjaxTable";
	}
}
