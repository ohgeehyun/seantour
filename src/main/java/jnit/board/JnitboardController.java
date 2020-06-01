/**
 * @version 3.2.0.1
 */
package jnit.board;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;
import javax.imageio.IIOException;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import jnit.board.cmt.JnitboardcmtDefaultVO;
import jnit.board.cmt.JnitboardcmtService;
import jnit.board.cmt.JnitboardcmtVO;
import jnit.board.data.JnitBoardDataService;
import jnit.board.db.JnitboarddbDefaultVO;
import jnit.board.db.JnitboarddbService;
import jnit.board.db.JnitboarddbVO;
import jnit.board.file.JnitboardfileDefaultVO;
import jnit.board.file.JnitboardfileService;
import jnit.board.file.JnitboardfileVO;
import jnit.board.good.JnitboardgoodDefaultVO;
import jnit.board.good.JnitboardgoodService;
import jnit.board.info.JnitboardinfoController;
import jnit.board.info.JnitboardinfoService;
import jnit.board.info.JnitboardinfoVO;
import jnit.cms.CmsHelper;
import jnit.cms.handler.CmsClientProperty;
import jnit.cms.handler.CmsProperty;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.com.util.DBType;
import jnit.db.JnitdbService;
import jnit.db.JnitdbVO;
import jnit.surem.message.SuremSMS;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;
import oracle.sql.CLOB;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.util.Base64;
import org.owasp.validator.html.AntiSamy;
import org.owasp.validator.html.CleanResults;
import org.owasp.validator.html.Policy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sun.star.ucb.Error;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.com.utl.fcc.service.ThumbnailUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class JnitboardController {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService infoService;

	@Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

	@Resource(name = "jnitboardcmtService")
	private JnitboardcmtService jnitboardcmtService;

	@Resource(name = "jnitboardfileService")
	private JnitboardfileService fileService;

	@Resource(name = "jnitdbService")
	private JnitdbService dbService;

	@Resource(name = "jnitboardgoodService")
	private JnitboardgoodService jnitboardgoodService;

	@Resource(name = "jnitcmssiteService")
	private JnitcmssiteService jnitcmssiteService;

	@Resource(name = "jnitBoardDataService")
	private JnitBoardDataService jnitBoardDataService;

	@Resource(name = "cmsProperty")
    private CmsProperty cmsProperty;

	@Resource(name = "jnitboardfileService")
	private JnitboardfileService jnitboardfileService;

	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_INFO_PATH = "board" + SEPERATOR + "_info" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;

    private static final String mediaExHost = EgovProperties.getProperty("MediaEx.hostIp");
    public static final String MEDIA_UPLOAD_PATH = uploadDir + SEPERATOR + "media" + SEPERATOR;

    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    public static final String debug = EgovProperties.getProperty("Globals.Debug");

    public static String lang;
    public static void uselang(String language){
    	lang = language;
    }

	@RequestMapping(value = "/board/board.do")
	public String board(
			@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest oriRequest,
			ModelMap model)
	throws Exception {

		CmsClientProperty cmsClientProperty = cmsProperty.getClientProperty();
		try{
			if(debug.equals("true")) log.debug("=================================== Board Debug ============================");
			if(debug.equals("true")) log.debug("sess id : "+ oriRequest.getRequestedSessionId() );
			if(debug.equals("true")) log.debug("cmsClientProperty : "+ cmsClientProperty );
			if(debug.equals("true")) log.debug("cmsClientProperty Title : "+ cmsClientProperty.pageTitle );
			if(debug.equals("true")) log.debug("org request : "+ oriRequest );
			if(debug.equals("true")) log.debug("session cmsClientProperty : "+ oriRequest.getSession().getAttribute("cmsClientProperty") );
			//if(debug.equals("true")) log.debug("sess id multipart : "+ cmsClientProperty.multipartRequest.get(oriRequest.getRequestedSessionId()) );
			if(debug.equals("true")) log.debug("sess id multipartsingle : "+ (HttpServletRequest)oriRequest.getSession().getAttribute("multipart") );
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
		}
		HttpServletRequest request = (oriRequest.getSession().getAttribute("multipart") != null ? (HttpServletRequest)oriRequest.getSession().getAttribute("multipart") : oriRequest);
		if(debug.equals("true")) log.debug("result request :" + request);
		if(debug.equals("true")) {
			log.debug("result request params :" + request.getParameterMap());
			 /*while(daa.nextElement()) {
				 request.getParameterNames().nextElement()
			 }*/
		}

		String mode = NullUtil.nullString(request.getParameter("mode"));

		String[] modeList = {"cmt","edit","list","proc","view","write","excel","pw","pwProc"};
		if(Arrays.asList(modeList).contains(mode)){

		}else{
			mode = "list";
		}
		String fixedCategory = "";
		Boolean useSkeleton = false;
		String customCss = "";

		if(mode.equals("proc")){		//게시글 작성할때 session을 받아와서 처리함
			JnitBoardSessionVO boardSessionVO = BoardSession.getBoardSession(request);
			try{
				fixedCategory = NullUtil.nullString(boardSessionVO.getFixedCategory());
				useSkeleton = "true".equals(NullUtil.nullString(boardSessionVO.getUseSkeleton()));
				customCss = NullUtil.nullString(boardSessionVO.getCustomCss());
			}catch(java.lang.NullPointerException e){
				fixedCategory = NullUtil.nullString(request.getParameter("fixedCategory"));
				useSkeleton = "true".equals(NullUtil.nullString(request.getParameter("useSkeleton")));
				customCss = NullUtil.nullString(request.getParameter("customCss"));
			}

		}else{
			fixedCategory = NullUtil.nullString(request.getParameter("fixedCategory"));
			useSkeleton = "true".equals(NullUtil.nullString(request.getParameter("useSkeleton")));
			customCss = NullUtil.nullString(request.getParameter("customCss"));
		}


		LocalVO localVO = new LocalVO();
		String error = "";
		String[] boardIds = boardId.split(",");
		boardId = boardIds[0];
		try{
			localVO.setBoardinfoVO(JnitboardinfoController.getBoardInfoVO(oriRequest, boardId));
		}catch(FileNotFoundException e){
			JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
			jnitboardinfoVO.setBoardId(boardId);
			try{
				jnitboardinfoVO = infoService.selectJnitboardinfo(jnitboardinfoVO);
			}catch(EgovBizException eg){
				model.addAttribute("alert", "존재하지 않는 게시판 입니다.");
				return "/jnit/util/alertBack";
			}
			localVO.setBoardinfoVO(jnitboardinfoVO);
    		JSONObject infoJson = new JSONObject().fromObject(jnitboardinfoVO);
    		File infoDir = new File(JnitboardinfoController.getBoardInfoPath(oriRequest));
    		String infoPath =  JnitboardinfoController.getBoardInfoPath(oriRequest) + boardId.toUpperCase() + ".json";
    		if(!infoDir.exists()){
    			infoDir.mkdir();
    		}
    		FileWriter infoFileW = new FileWriter(infoPath);
    		infoFileW.write(infoJson.toString());
    		infoFileW.flush();
    		infoFileW.close();
		}catch(NullPointerException e){
			log.error(e.getMessage());
			JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
			jnitboardinfoVO.setBoardId(boardId);
			jnitboardinfoVO = infoService.selectJnitboardinfo(jnitboardinfoVO);
			localVO.setBoardinfoVO(jnitboardinfoVO);
		}catch(Exception e){
			log.error(e.getMessage());
		}
		if(localVO.getBoardinfoVO().getUseInternal() == 1 && useSkeleton){//내외부망 설정시 쓰기,수정 접근불가
			if(mode.equals("write")||mode.equals("edit")){
				model.addAttribute("path","/404.jsp");
				return "/jnit/util/alertMove";
			}
		}

		localVO.setLoginVO((JnitcmsmbrVO)CmsHelper.getAuthMbr(oriRequest));


		Boolean mobileMode = "true".equals(NullUtil.nullString(request.getParameter("isMobile"))) ? true : false;
		boardstaticVO.setIsMobile(mobileMode);
		model.addAttribute("mobileMode", mobileMode);

		model.addAttribute("hideCategory", !NullUtil.nullString(request.getParameter("hideCategory")).equals(""));
		model.addAttribute("linkPath", NullUtil.nullString(request.getParameter("linkPath")));



		String modeStr = "";

		model.addAttribute("fixedCategory",fixedCategory);
		model.addAttribute("useSkeleton", useSkeleton);
		model.addAttribute("customCss",customCss);

		model.addAttribute("boardId",boardId);
		model.addAttribute("mode", mode);
		model.addAttribute("loginVO", localVO.getLoginVO());
		model.addAttribute("boardinfoVO", localVO.getBoardinfoVO()); uselang(localVO.getBoardinfoVO().getUseLanguage());
		model.addAttribute("lbl",JnitboardinfoController.getBoardLable(localVO.getBoardinfoVO()));
		model.addAttribute("categoryList",JnitboardinfoController.getCategoryList(localVO.getBoardinfoVO()));
		model.addAttribute("f",JnitboardinfoController.getFieldInfo(localVO.getBoardinfoVO()));
		model.addAttribute("getTmp1", new JSONObject().fromObject(localVO.getBoardinfoVO().getTmp1()));

		JnitcmssiteVO siteVO = new JnitcmssiteVO();
		siteVO.setSiteId(NullUtil.nullString(localVO.getBoardinfoVO().getBoardGroup()));
		try {
			siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
			model.addAttribute("siteVO", siteVO);
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		if(debug.equals("true")){
			log.debug("=============================================================");
			for (Enumeration e = request.getParameterNames(); e.hasMoreElements();)
			       log.debug(e.nextElement());
			log.debug("mode Parameter : " + request.getParameter("mode"));
			log.debug("Board ID : " + boardId);
			log.debug("Board Mode : " + mode);
			log.debug("useSkeleton : " + useSkeleton);
			log.debug("fixedCategory : " + fixedCategory);
			log.debug("=============================================================");
		}

		String[] adminLVs = localVO.getBoardinfoVO().getAdmList().toUpperCase().replaceAll("'", "").split(",");
		String adminLV = "";
		for (int i = 0; i < adminLVs.length; i++) {
			if (!adminLVs[i].isEmpty()) {
				adminLV = adminLV + "," + "'" + adminLVs[i].toString()+ "'";
			}
		}
		adminLV = adminLV.replaceFirst(",", "");
		//게시판 권한설정
		localVO = boardAccess(request, model, localVO, adminLV);

		//달력처리
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		String searchDateStr = NullUtil.nullString(request.getParameter("searchDate"));

		Calendar cal = Calendar.getInstance();
		try{
			if(!searchDateStr.equals("")) cal.setTime(sdfDate.parse(searchDateStr));
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
		}

		String[] weeks = new String[]{"일","월","화","수","목","금","토"};
		//언어 설정
		if("eng".equals(lang)){
			weeks = new String[]{"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
		}else if("chi".equals(lang)){
			weeks = new String[]{"日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"};
		}else if("japan".equals(lang)){
			weeks = new String[]{"星期天","星期一","星期二","星期三","星期四","星期五","星期六"};
		}

		int calLastDay = cal.getActualMaximum(Calendar.DATE);
		int calCurrentYear = cal.get(Calendar.YEAR);
		int calCurrentMonth = cal.get(Calendar.MONTH)+1;
		int calCurrentDate = cal.get(Calendar.DATE);
		String calCurrentStr = sdfDate.format(cal.getTime());
		//요일
		String calCurrentDay = weeks[cal.get(Calendar.DAY_OF_WEEK)-1];
		//몇째주
		String calCurrentWeek = String.valueOf(cal.get(Calendar.WEEK_OF_MONTH));
		//이전달
		cal.add(Calendar.MONTH, -1);
		String calPrevMonthStr = sdfDate.format(cal.getTime());
		//다음달
		cal.add(Calendar.MONTH, 2);
		String calNextMonthStr = sdfDate.format(cal.getTime());
		//오늘
		cal.add(Calendar.MONTH, -1);

		cal.set(Calendar.DATE, 1);
		int calDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		/*
		//어제
		cal.add(Calendar.DATE, -1);
		String calPrevDateStr = sdfDate.format(cal.getTime());
		//내일
		cal.add(Calendar.DATE, 2);
		String calNextDateStr = sdfDate.format(cal.getTime());
		*/

		model.addAttribute("calPrevMonth", calPrevMonthStr);
		model.addAttribute("calNextMonth", calNextMonthStr);
		/*
		model.addAttribute("calPrevDate", calPrevDateStr);
		model.addAttribute("calNextDate", calNextDateStr);
		*/
		model.addAttribute("calLastDay", calLastDay);
		model.addAttribute("calCurrentDay", calCurrentDay);
		model.addAttribute("calCurrentWeek", calCurrentWeek);
		model.addAttribute("calCurrentStr", calCurrentStr);
		model.addAttribute("calCurrentYear", calCurrentYear);
		model.addAttribute("calCurrentMonth", calCurrentMonth);
		model.addAttribute("calCurrentDate", calCurrentDate);
		model.addAttribute("calDayOfWeek", calDayOfWeek);
		//End of 달력처리

		boardId = localVO.getBoardinfoVO().getBoardId();
		if("list".equals(mode)){
			modeStr = isLanguage("목록", lang);
			if(localVO.getPermList()){
				model.addAllAttributes(list(boardId, request, model, localVO));
			}else{
				error = isLanguage("권한이 없습니다.", lang);
			}
		}
		if("xml".equals(mode)){
			modeStr = isLanguage("XML", lang);
			if(localVO.getPermList()){
				localVO.getBoardinfoVO().setPageIndex(1);
				localVO.getBoardinfoVO().setRowCnt(65535);
				model.addAllAttributes(list(boardId, request, model, localVO));
			}else{
				error = isLanguage("권한이 없습니다.", lang);
			}
		}
		if("write".equals(mode)){
			String cntId = NullUtil.nullString(request.getParameter("cntId"));
			if("".equals(cntId)){//글쓰기
				modeStr = isLanguage("등록", lang);
				if(localVO.getPermWrite()){
					model.addAllAttributes(write(boardId, request, model, localVO));
				}else{
					error = isLanguage("권한이 없습니다.", lang);
				}
			}else{//답변글쓰기
				modeStr = isLanguage("답변글 등록", lang);
				if(localVO.getPermReply()){
					model.addAllAttributes(write(boardId, request, model, localVO));
				}else{
					error = isLanguage("권한이 없습니다.", lang);
				}
			}
		}
		if("edit".equals(mode)){
			modeStr = isLanguage("수정", lang);
			if(localVO.getPermWrite()){
				model.addAllAttributes(edit(boardId, request, model, localVO));

				String move = NullUtil.nullString((String)model.get("move"));
				request.getSession().removeAttribute("uid");
				if(!move.equals("")){
					return "/jnit/util/alertMove";
				}

			}else{
				error = isLanguage("권한이 없습니다.", lang);
			}
		}

		//패스워드 확인
		if("pw".equals(mode)){
			model.addAllAttributes(pwAnonymous(boardId, request, model, localVO));
			if(model.get("move") != null){
				return "/jnit/util/alertMove";
			}
		}
		//패스워드 확인 프로세스
		if("pwProc".equals(mode)){
			model.addAllAttributes(pwAnonymousProc(boardId, request, model, localVO));
			if(model.get("alert") != null){
				return "/jnit/util/alertBack";
			}
			if(model.get("move") != null){
				return "/jnit/util/alertMove";
			}
		}

		if("view".equals(mode)){
			String proc = NullUtil.nullString(request.getParameter("proc"));
			if(proc.equals("")){
				modeStr = isLanguage("조회", lang);
				model.addAllAttributes(view(boardId, request, model, localVO));

				String move = NullUtil.nullString((String)model.get("move"));
				request.getSession().removeAttribute("uid");
				if(!move.equals("")){
					return "/jnit/util/alertMove";
				}
			}
		}

		if("proc".equals(mode)){
			String proc = request.getParameter("proc") == null ? "error" : request.getParameter("proc");
			String pid = NullUtil.nullString(request.getParameter("pid"));
			if("write".equals(proc)){
				if("".equals(pid)){//글쓰기
					modeStr = isLanguage("등록이", lang);
					if(localVO.getPermWrite()){
						model.addAllAttributes(proc(boardId, proc, request, model, localVO));

					}else{
						error = isLanguage("권한이 없습니다.", lang);
					}

				}else{
					modeStr = isLanguage("답변글 등록", lang);
					if(localVO.getPermReply()){
						model.addAllAttributes(proc(boardId, proc, request, model, localVO));

					}else{
						error = isLanguage("권한이 없습니다.", lang);
					}
				}

			}
			if("edit".equals(proc)){
				modeStr = isLanguage("수정이", lang);
				if(localVO.getPermWrite()){
					model.addAllAttributes(proc(boardId, proc, request, model, localVO));
				}else{
					error = isLanguage("권한이 없습니다.", lang);
				}
			}
			if("delete".equals(proc)){
				modeStr = isLanguage("삭제가", lang);
				model.addAllAttributes(proc(boardId, proc, request, model, localVO));
				String isSecret = NullUtil.nullString((String)model.get("isSecret"));
				if(isSecret.equals("true")){
					log.debug("비밀글 삭제 이프");
					model.addAllAttributes(delete(boardId, request, model, localVO));

					String move = NullUtil.nullString((String)model.get("move"));
					request.getSession().removeAttribute("uid");
					if(!move.equals("")){
						return "/jnit/util/alertMove";
					}
				}
			}
			if("recovery".equals(proc)){
				modeStr = isLanguage("복구가", lang);
				model.addAllAttributes(proc(boardId, proc, request, model, localVO));
			}
			if("allDelete".equals(proc)){
				modeStr = isLanguage("영구삭제가", lang);
				model.addAllAttributes(proc(boardId, proc, request, model, localVO));
			}
		}
		if("delete".equals(mode)){
			model.addAllAttributes(delete(boardId, request, model, localVO));

			String move = NullUtil.nullString((String)model.get("move"));
			request.getSession().removeAttribute("uid");
			if(!move.equals("")){
				return "/jnit/util/alertMove";
			}

		}
		if("excel".equals(mode)){
			model.addAllAttributes(excel(boardId, request, model, localVO));
			return "jnit/cms/board/excel";
		}
		model.addAttribute("modeStr", modeStr);
		if(!error.equals("")){
			model.addAttribute("error", error);
		}
		try{
			oriRequest.getSession().removeAttribute("multipart");
		}catch(NullPointerException e){
			log.error(e.getMessage());
		}
		if(cmsClientProperty != null){
			cmsClientProperty.multipartRequest.remove(oriRequest.getRequestedSessionId());
		}

		/** 사용 DBMS 종류 **/
		String dbmsType = "mysql";
		dbmsType = EgovProperties.getProperty("Globals.DbType").toLowerCase();

		model.addAttribute("dbmsType",dbmsType); //DBMS종류
		if(localVO.getBoardinfoVO().getUseInternal() == 1 && useSkeleton){
			model.addAttribute("permList", localVO.getPermList()); //목록접근권한
			model.addAttribute("permView", localVO.getPermView()); //보기접근권한
			model.addAttribute("permWrite", false); //쓰기접근권한
			model.addAttribute("permCmt", localVO.getPermCmt()); //댓글쓰기접근권한
			model.addAttribute("permReply", false); //답글쓰기접근권한
			model.addAttribute("isAdmin", false); //관리자
			model.addAttribute("isMine",false);
			model.addAttribute("adminLV", ""); //관리자권한
		}else{
			model.addAttribute("permList", localVO.getPermList()); //목록접근권한
			model.addAttribute("permView", localVO.getPermView()); //보기접근권한
			model.addAttribute("permWrite", localVO.getPermWrite()); //쓰기접근권한
			model.addAttribute("permCmt", localVO.getPermCmt()); //댓글쓰기접근권한
			model.addAttribute("permReply", localVO.getPermReply()); //답글쓰기접근권한
			model.addAttribute("isAdmin", localVO.getIsAdmin()); //관리자
			model.addAttribute("adminLV", adminLV); //관리자권한
		}

		BoardSession.initBoardSession();		//BoardSession초기화

		if("xml".equals(mode)) {
			return "jnit/board/board_xml";
		}
		return "jnit/board/board";
	}
	private ModelMap excel(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO) throws Exception{

		List sIdx = JnitboardinfoController.getFieldSortView(localVO.getBoardinfoVO());
		model.addAttribute("sIdx", sIdx);

		JnitboarddbDefaultVO searchVO = new JnitboarddbDefaultVO();
		if(!model.get("fixedCategory").equals("")){
			searchVO.setSearchCategory(String.valueOf(model.get("fixedCategory")));
		}else{
			searchVO.setSearchCategory(NullUtil.nullString(request.getParameter("category")));
		}
		searchVO.setSearchParents(NullUtil.nullString(String.valueOf(localVO.getBoardinfoVO().getUseListReply())));


		String searchExt05 = NullUtil.nullString(request.getParameter("searchExt05"));
		if(!"".equals(searchExt05))searchVO.setSearchExt05(searchExt05);


		searchVO.setWithContent("1");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String searchDateStr = NullUtil.nullString(request.getParameter("searchDate"));
		Date searchDate = (searchDateStr.equals(""))? Calendar.getInstance().getTime() : sdf.parse(searchDateStr);

		int pageIdx = NullUtil.nullInt(request.getParameter("pageIdx"));
		pageIdx = pageIdx==0?1:pageIdx;
		searchVO.setPageIdx(pageIdx);
		searchVO.setIsAdmin(localVO.getIsAdmin());
		searchVO.setBoardId(boardId);


    	searchVO.setPageUnit(localVO.getBoardinfoVO().getPageUnit());
    	searchVO.setPageSize(localVO.getBoardinfoVO().getPageSize());

    	/** pageing */
    	int totCnt = jnitboarddbService.selectListTotCnt(searchVO);
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(1);
		paginationInfo.setRecordCountPerPage(totCnt);
		paginationInfo.setPageSize(1);
		paginationInfo.setTotalRecordCount(totCnt);
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		String createdStartDate = NullUtil.nullString(request.getParameter("createdStartDate"));
		String createdEndDate = NullUtil.nullString(request.getParameter("createdEndDate"));
		if(createdStartDate.equals("")){
			createdStartDate = sdf.format(0);
		}
		if(createdEndDate.equals("")){
			createdEndDate = sdf.format(Calendar.getInstance().getTime());
		}
		searchVO.setCreatedStartDate(sdf.parse(createdStartDate));
		searchVO.setCreatedEndDate(sdf.parse(createdEndDate));
		searchVO.setSearchCondition("excel");

		int startNum = totCnt - ( ( paginationInfo.getCurrentPageNo() -1 ) * paginationInfo.getRecordCountPerPage());
		model.addAttribute("startNum", startNum);

		List resultList = jnitboarddbService.selectList(searchVO);
		if(DBType.getDbTypeBoolean("oracle")){
			HashMap<BigDecimal, String> contentMap = new HashMap<BigDecimal, String>();
				Iterator resultIterator = resultList.iterator();
				for(int i=0; i<resultList.size(); i++){
					EgovMap resultEgovMap = (EgovMap) resultIterator.next();

					//DB : Number, vo : int 값이지만 어째서인지 jsp에서 result.id 타입값은 BigDecimal 받고있음
					String strId = String.valueOf(resultEgovMap.get("id"));
					BigDecimal id =  new BigDecimal(strId);
					CLOB content = (CLOB) resultEgovMap.get("content");
					if(content != null){
						StringBuffer sb = new StringBuffer();
						try {
							Reader reader = content.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);

							String line = "";
							while ((line = br.readLine()) != null) {
								sb.append(line+"\r\n");
							}
							br.close();
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						contentMap.put(id, sb.toString());
					}
				}
				model.addAttribute("contentMap", contentMap);
			//End of CLOB contentMap 처리
		}else if(DBType.getDbTypeBoolean("tibero")){
			HashMap<BigDecimal, String> contentMap = new HashMap<BigDecimal, String>();
				Iterator resultIterator = resultList.iterator();
				for(int i=0; i<resultList.size(); i++){
					EgovMap resultEgovMap = (EgovMap) resultIterator.next();

					//DB : Number, vo : int 값이지만 어째서인지 jsp에서 result.id 타입값은 BigDecimal 받고있음
					String strId = String.valueOf(resultEgovMap.get("id"));
					BigDecimal id =  new BigDecimal(strId);
					com.tmax.tibero.jdbc.TbClob content = (com.tmax.tibero.jdbc.TbClob) resultEgovMap.get("content");
					if(content != null){
						StringBuffer sb = new StringBuffer();
						try {
							Reader reader = content.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);

							String line = "";
							while ((line = br.readLine()) != null) {
								sb.append(line+"\r\n");
							}
							br.close();
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						contentMap.put(id, sb.toString());
					}
				}
				model.addAttribute("contentMap", contentMap);
			//End of CLOB contentMap 처리
		}else{
			HashMap<Integer, String> contentMap = new HashMap<Integer, String>();
			Iterator resultIterator = resultList.iterator();
			for(int i=0; i<resultList.size(); i++){
				EgovMap resultEgovMap = (EgovMap) resultIterator.next();

				int id = (Integer)resultEgovMap.get("id");
				String content = (String) resultEgovMap.get("content");
				contentMap.put(id, content);
			}
			model.addAttribute("contentMap", contentMap);
		}

		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		return model;
	}

	private ModelMap list(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO) throws Exception{

		List sIdx = JnitboardinfoController.getFieldSortList(localVO.getBoardinfoVO());
		model.addAttribute("sIdx", sIdx);

		JnitboarddbDefaultVO searchVO = new JnitboarddbDefaultVO();
		if(!model.get("fixedCategory").equals("")){
			searchVO.setSearchCategory(String.valueOf(model.get("fixedCategory")));
		}else{
			searchVO.setSearchCategory(NullUtil.nullString(request.getParameter("category")));
		}

		//searchVO.setSearchParents(NullUtil.nullString(String.valueOf(localVO.getBoardinfoVO().getUseListReply())));

		String searchCondition = NullUtil.nullString(request.getParameter("searchCondition"));
		String searchKeyword = NullUtil.nullString(request.getParameter("searchKeyword"));
		//String searchKeyword =  new String(request.getParameter("searchKeyword").getBytes("8859_1"),"UTF-8");
		//searchKeyword = NullUtil.nullString(request.getParameter("searchKeyword"));
		if(!searchCondition.equals("") && !searchKeyword.equals("")){
			searchVO.setSearchCondition(searchCondition);
			searchVO.setSearchKeyword(searchKeyword);
		}

		String mbrYn = NullUtil.nullString(request.getParameter("mbrYn"));
		if(!mbrYn.equals("")){
			searchVO.setMbrYn("Y");
			searchVO.setSearchMbrId(mbrYn);
		}
		//게시물 정렬 설정
		searchVO.setOrderbyCondition(localVO.getBoardinfoVO().getBoardSort());
		if("2".equals(localVO.getBoardinfoVO().getBoardSort())){
			searchVO.setIdxCondition("0");
		}
		//ExtColumn Search
		String searchExt01 = NullUtil.nullString(request.getParameter("searchext01"));
		if(!"".equals(searchExt01))searchVO.setSearchExt01(searchExt01);
		String searchExt02 = NullUtil.nullString(request.getParameter("searchext02"));
		if(!"".equals(searchExt02))searchVO.setSearchExt02(searchExt02);
		String searchExt03 = NullUtil.nullString(request.getParameter("searchext03"));
		if(!"".equals(searchExt03))searchVO.setSearchExt03(searchExt03);
		String searchExt04 = NullUtil.nullString(request.getParameter("searchext04"));
		if(!"".equals(searchExt04))searchVO.setSearchExt04(searchExt04);
		String searchExt05 = NullUtil.nullString(request.getParameter("searchext05"));
		if(!"".equals(searchExt05))searchVO.setSearchExt05(searchExt05);
		String searchExt06 = NullUtil.nullString(request.getParameter("searchext06"));
		if(!"".equals(searchExt06))searchVO.setSearchExt06(searchExt06);
		String searchExt07 = NullUtil.nullString(request.getParameter("searchext07"));
		if(!"".equals(searchExt07))searchVO.setSearchExt07(searchExt07);
		String searchExt08 = NullUtil.nullString(request.getParameter("searchext08"));
		if(!"".equals(searchExt08))searchVO.setSearchExt08(searchExt08);
		String searchExt09 = NullUtil.nullString(request.getParameter("searchext09"));
		if(!"".equals(searchExt09))searchVO.setSearchExt09(searchExt09);
		String searchExt10 = NullUtil.nullString(request.getParameter("searchext10"));
		if(!"".equals(searchExt10))searchVO.setSearchExt10(searchExt10);
		String searchExt11 = NullUtil.nullString(request.getParameter("searchext11"));
		if(!"".equals(searchExt11))searchVO.setSearchExt11(searchExt11);
		String searchExt12 = NullUtil.nullString(request.getParameter("searchext12"));
		if(!"".equals(searchExt12))searchVO.setSearchExt12(searchExt12);
		String searchExt13 = NullUtil.nullString(request.getParameter("searchext13"));
		if(!"".equals(searchExt13))searchVO.setSearchExt13(searchExt13);
		String searchExt14 = NullUtil.nullString(request.getParameter("searchext14"));
		if(!"".equals(searchExt14))searchVO.setSearchExt14(searchExt14);
		String searchExt15 = NullUtil.nullString(request.getParameter("searchext15"));
		if(!"".equals(searchExt15))searchVO.setSearchExt15(searchExt15);
		String searchExt16 = NullUtil.nullString(request.getParameter("searchext16"));
		if(!"".equals(searchExt16))searchVO.setSearchExt16(searchExt16);
		String searchExt17 = NullUtil.nullString(request.getParameter("searchext17"));
		if(!"".equals(searchExt17))searchVO.setSearchExt17(searchExt17);
		String searchExt18 = NullUtil.nullString(request.getParameter("searchext18"));
		if(!"".equals(searchExt18))searchVO.setSearchExt18(searchExt18);
		String searchExt19 = NullUtil.nullString(request.getParameter("searchext19"));
		if(!"".equals(searchExt19))searchVO.setSearchExt19(searchExt19);
		String searchExt20 = NullUtil.nullString(request.getParameter("searchext20"));
		if(!"".equals(searchExt20))searchVO.setSearchExt20(searchExt20);

		if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
				|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")
				|| localVO.getBoardinfoVO().getBoardType().contains("movie")
				|| localVO.getBoardinfoVO().getBoardType().contains("faq")){
			searchVO.setWithFile("1");
			searchVO.setWithContent("1");
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String searchDateStr = NullUtil.nullString(request.getParameter("searchDate"));
		Date searchDate = (searchDateStr.equals(""))? Calendar.getInstance().getTime() : sdf.parse(searchDateStr);

		if(localVO.getBoardinfoVO().getBoardType().contains("schedule")){
			searchVO.setSearchDate(searchDate);
		}
		if(localVO.getBoardinfoVO().getBoardType().contains("calendar")){
			searchVO.setSearchMonth(searchDate);
			//log.debug("Board Type : " + localVO.getBoardinfoVO().getBoardType());
		}
		int pageIdx = NullUtil.nullInt(request.getParameter("pageIdx"));

		pageIdx = pageIdx==0?1:pageIdx;
		searchVO.setPageIdx(pageIdx);
		searchVO.setIsAdmin(localVO.getIsAdmin());
		searchVO.setBoardId(boardId);
		searchVO.setWithFile("1");

    	searchVO.setPageUnit(localVO.getBoardinfoVO().getPageUnit());
    	searchVO.setPageSize(localVO.getBoardinfoVO().getPageSize());

    	if(localVO.getBoardinfoVO().getBoardType().contains("scheduleList")){
			searchVO.setSearchMonth(searchDate);
			List resultBoardList = jnitboarddbService.selectList(searchVO);
			model.addAttribute("resultBoardList", resultBoardList);
			searchVO.setSearchDate(searchDate);
		}
    	if(localVO.getBoardinfoVO().getBoardType().contains("inquiry")){
			searchVO.setSearchParents("1");
			//관리자 체크해서 아니면 내글만
			if(localVO.getIsAdmin()){

			}else{
				searchVO.setMyBoardList(localVO.getLoginVO().getMbrId());
			}
		}
    	if(localVO.getBoardinfoVO().getBoardType().contains("nomalDate")){
			searchVO.setSearchDate(searchDate);
		}
    	/** pageing */
    	searchVO.setSearchUseYn("NotNotice");
    	int totCnt = jnitboarddbService.selectListTotCnt(searchVO);
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIdx());
		paginationInfo.setRecordCountPerPage(localVO.getBoardinfoVO().getRowCnt());
		paginationInfo.setPageSize(searchVO.getPageSize());
		paginationInfo.setTotalRecordCount(totCnt);

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		int startNum = totCnt - ( ( paginationInfo.getCurrentPageNo() -1 ) * paginationInfo.getRecordCountPerPage());
		model.addAttribute("startNum", startNum);

		searchVO.setSearchUseYn("NotNotice");
		List resultList = jnitboarddbService.selectList(searchVO);
		/*2014-03-04
		 * 공지사항 리스트를 검색한다.
		 * is_notice = 1
		 *
		 * */
		searchVO.setSearchUseYn("notice");
		searchVO.setFirstIndex(0);
		searchVO.setLastIndex(10000);
		List noticeList = jnitboarddbService.selectList(searchVO);

		//첨부파일 체크
		JnitboardfileVO boardfileVO = new JnitboardfileVO();
		boardfileVO.setSearchCondition("2");
		boardfileVO.setMainFileYn("N");
		HashMap<String, String> boardFileType =  new HashMap<String, String>();
		if(DBType.getDbTypeBoolean("oracle")){
			HashMap<BigDecimal, List> boardFileMap = new HashMap<BigDecimal, List>();
			Iterator fileitr = resultList.iterator();
			while(fileitr.hasNext()){
				EgovMap resultMap = (EgovMap)fileitr.next();
				BigDecimal id = new BigDecimal(String.valueOf(resultMap.get("id")));
				boardfileVO.setBoardId(boardId);
				boardfileVO.setBoardCntId(id.intValue());
				List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //jnitboardfileService.selectFileList(boardId, id.intValue());
				boardFileMap.put(id, fileList);
				Iterator fileItr = fileList.iterator();
				while (fileItr.hasNext()) {
					EgovMap articleMap = (EgovMap)fileItr.next();
					if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
						String fileNm = String.valueOf(articleMap.get("fileNm"));
						try{
							String[] fileType = fileNm.split("\\.");
							boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						}catch(Exception e){
							if("true".equals(debug)) log.debug(e.getMessage());
						}
					}
				}
			}
			fileitr = noticeList.iterator();
			while(fileitr.hasNext()){
				EgovMap resultMap = (EgovMap)fileitr.next();
				BigDecimal id = new BigDecimal(String.valueOf(resultMap.get("id")));
				boardfileVO.setBoardId(boardId);
				boardfileVO.setBoardCntId(id.intValue());
				List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //jnitboardfileService.selectFileList(boardId, id.intValue());
				boardFileMap.put(id, fileList);
				Iterator fileItr = fileList.iterator();
				while (fileItr.hasNext()) {
					EgovMap articleMap = (EgovMap)fileItr.next();
					if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
						String fileNm = String.valueOf(articleMap.get("fileNm"));
						try{
							String[] fileType = fileNm.split("\\.");
							boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						}catch(Exception e){
							if("true".equals(debug)) log.debug(e.getMessage());
						}
					}
				}
			}
			model.addAttribute("boardFileMap", boardFileMap);
		}else if(DBType.getDbTypeBoolean("tibero")){
			HashMap<BigDecimal, List> boardFileMap = new HashMap<BigDecimal, List>();
			Iterator fileitr = resultList.iterator();
			while(fileitr.hasNext()){
				EgovMap resultMap = (EgovMap)fileitr.next();
				BigDecimal id = new BigDecimal(String.valueOf(resultMap.get("id")));
				boardfileVO.setBoardId(boardId);
				boardfileVO.setBoardCntId(id.intValue());
				List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //jnitboardfileService.selectFileList(boardId, id.intValue());
				boardFileMap.put(id, fileList);
				Iterator fileItr = fileList.iterator();
				while (fileItr.hasNext()) {
					EgovMap articleMap = (EgovMap)fileItr.next();
					if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
						String fileNm = String.valueOf(articleMap.get("fileNm"));
						try{
							String[] fileType = fileNm.split("\\.");
							boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						}catch(Exception e){
							if("true".equals(debug)) log.debug(e.getMessage());
						}
					}
				}
			}
			fileitr = noticeList.iterator();
			while(fileitr.hasNext()){
				EgovMap resultMap = (EgovMap)fileitr.next();
				BigDecimal id = new BigDecimal(String.valueOf(resultMap.get("id")));
				boardfileVO.setBoardId(boardId);
				boardfileVO.setBoardCntId(id.intValue());
				List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //jnitboardfileService.selectFileList(boardId, id.intValue());
				boardFileMap.put(id, fileList);
				Iterator fileItr = fileList.iterator();
				while (fileItr.hasNext()) {
					EgovMap articleMap = (EgovMap)fileItr.next();
					if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
						String fileNm = String.valueOf(articleMap.get("fileNm"));
						try{
							String[] fileType = fileNm.split("\\.");
							boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						}catch(Exception e){
							if("true".equals(debug)) log.debug(e.getMessage());
						}
					}
				}
			}
			model.addAttribute("boardFileMap", boardFileMap);
		}else{
			HashMap<Integer, List> boardFileMap = new HashMap<Integer, List>();
			Iterator fileitr = resultList.iterator();
			while(fileitr.hasNext()){
				EgovMap resultMap = (EgovMap)fileitr.next();
				String id = String.valueOf(resultMap.get("id"));
				boardfileVO.setBoardId(boardId);
				boardfileVO.setBoardCntId(Integer.parseInt(id));
				List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //List fileList = jnitboardfileService.selectFileList(boardId, Integer.parseInt(id));
				boardFileMap.put(Integer.parseInt(id), fileList);
				Iterator fileItr = fileList.iterator();
				while (fileItr.hasNext()) {
					EgovMap articleMap = (EgovMap)fileItr.next();
					if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
						String fileNm = String.valueOf(articleMap.get("fileNm"));
						try{
							String[] fileType = fileNm.split("\\.");
							boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						}catch(Exception e){
							if("true".equals(debug)) log.debug(e.getMessage());
						}
					}
				}
			}
			fileitr = noticeList.iterator();
			while(fileitr.hasNext()){
				EgovMap resultMap = (EgovMap)fileitr.next();
				String id = String.valueOf(resultMap.get("id"));
				boardfileVO.setBoardId(boardId);
				boardfileVO.setBoardCntId(Integer.parseInt(id));
				List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //List fileList = jnitboardfileService.selectFileList(boardId, Integer.parseInt(id));
				boardFileMap.put(Integer.parseInt(id), fileList);
				Iterator fileItr = fileList.iterator();
				while (fileItr.hasNext()) {
					EgovMap articleMap = (EgovMap)fileItr.next();
					if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
						String fileNm = String.valueOf(articleMap.get("fileNm"));
						try{
							String[] fileType = fileNm.split("\\.");
							boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						}catch(Exception e){
							if("true".equals(debug)) log.debug(e.getMessage());
						}
					}
				}
			}
			model.addAttribute("boardFileMap", boardFileMap);
		}

		//oracle
		if(DBType.getDbTypeBoolean("oracle")){
			/* CLOB contentMap 처리
			 * 2014-01-17 by.나성재 내용 oracle 버전 CLOB타입 문제로 인하여
			 * list에서 content 컬럼이 조회되는 스킨은 contentMap을 이용하도록한다.
			 */
			HashMap<BigDecimal, String> contentMap = new HashMap<BigDecimal, String>();
			if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
					|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")
					|| localVO.getBoardinfoVO().getBoardType().contains("movie")
					|| localVO.getBoardinfoVO().getBoardType().contains("faq")){
				Iterator resultIterator = resultList.iterator();
				for(int i=0; i<resultList.size(); i++){
					EgovMap resultEgovMap = (EgovMap) resultIterator.next();

					//DB : Number, vo : int 값이지만 어째서인지 jsp에서 result.id 타입값은 BigDecimal 받고있음
					String strId = String.valueOf(resultEgovMap.get("id"));
					BigDecimal id =  new BigDecimal(strId);
					CLOB content = (CLOB) resultEgovMap.get("content");
					if(content != null){
						StringBuffer sb = new StringBuffer();
						try {
							Reader reader = content.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);

							String line = "";
							while ((line = br.readLine()) != null) {
								sb.append(line+"\r\n");
							}
							br.close();
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						contentMap.put(id, sb.toString());
					}
				}
				model.addAttribute("contentMap", contentMap);
			}
			//End of CLOB contentMap 처리
		}else if(DBType.getDbTypeBoolean("tibero")){
			HashMap<BigDecimal, String> contentMap = new HashMap<BigDecimal, String>();
			if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
					|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")
					|| localVO.getBoardinfoVO().getBoardType().contains("movie")
					|| localVO.getBoardinfoVO().getBoardType().contains("faq")){
				Iterator resultIterator = resultList.iterator();
				for(int i=0; i<resultList.size(); i++){
					EgovMap resultEgovMap = (EgovMap) resultIterator.next();

					//DB : Number, vo : int 값이지만 어째서인지 jsp에서 result.id 타입값은 BigDecimal 받고있음
					String strId = String.valueOf(resultEgovMap.get("id"));
					BigDecimal id =  new BigDecimal(strId);
					com.tmax.tibero.jdbc.TbClob content = (com.tmax.tibero.jdbc.TbClob) resultEgovMap.get("content");
					if(content != null){
						StringBuffer sb = new StringBuffer();
						try {
							Reader reader = content.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);

							String line = "";
							while ((line = br.readLine()) != null) {
								sb.append(line+"\r\n");
							}
							br.close();
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						contentMap.put(id, sb.toString());
					}
				}
				model.addAttribute("contentMap", contentMap);
			}
			//End of CLOB contentMap 처리
		}else{
			HashMap<Integer, String> contentMap = new HashMap<Integer, String>();
			if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
					|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")
					|| localVO.getBoardinfoVO().getBoardType().contains("movie")
					|| localVO.getBoardinfoVO().getBoardType().contains("faq")){
				Iterator resultIterator = resultList.iterator();
				for(int i=0; i<resultList.size(); i++){
					EgovMap resultEgovMap = (EgovMap) resultIterator.next();

					//DB : Number, vo : int 값이지만 어째서인지 jsp에서 result.id 타입값은 BigDecimal 받고있음
					int id = (Integer)resultEgovMap.get("id");
					String content = (String) resultEgovMap.get("content");
					contentMap.put(id, content);
				}
				model.addAttribute("contentMap", contentMap);
			}
		}


		if(localVO.getBoardinfoVO().getBoardType().contains("calendar")
			|| localVO.getBoardinfoVO().getBoardType().contains("schedule")
			|| localVO.getBoardinfoVO().getBoardType().contains("scheduleList")){
			HashMap<Long, List> calRst = new HashMap<Long, List>();
			Iterator itr = resultList.iterator();
			while(itr.hasNext()){
				EgovMap articleMap = (EgovMap)itr.next();
				if(articleMap.get("isdel").toString().equals("0") && articleMap.get("date01") != null){
					Calendar sCal = null;
					Calendar eCal = null;
					if(articleMap.get("date01") != null){
						Object calDate = (articleMap.get("date01"));
						String startDate01String = "";
						if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
							startDate01String = sdf.format(sdf.parse(calDate.toString()));

						}else{
							startDate01String = sdf.format(calDate);
						}
						String[] startDate = startDate01String.split("-");
						String searchDateArrReady = sdf.format(searchDate);
						String[] searchDateArr = ((String) searchDateArrReady).split("-");


						if(Integer.parseInt(startDate[1]) == Integer.parseInt(searchDateArr[1])){
							sCal = Calendar.getInstance();
							if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
								sCal.setTime((Date)sdf.parse(articleMap.get("date01").toString()));

							}else{
								sCal.setTime((Date)articleMap.get("date01"));
							}
						}else if(Integer.parseInt(startDate[1])<Integer.parseInt(searchDateArr[1])){
							sCal = Calendar.getInstance();
							sCal.set(Integer.parseInt(searchDateArr[0]), Integer.parseInt(searchDateArr[1])-1, 1);
						}
					}
					if(articleMap.get("date02") != null){
						Object calDate = (articleMap.get("date02"));
						String afterDate02String = "";
						if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
							afterDate02String = sdf.format(sdf.parse(calDate.toString()));

						}else{
							afterDate02String = sdf.format(calDate);
						}
						String[] afterDate = afterDate02String.split("-");
						String searchDateArrReady = sdf.format(searchDate);
						String[] searchDateArr = ((String) searchDateArrReady).split("-");

						if(Integer.parseInt(afterDate[1]) == Integer.parseInt(searchDateArr[1])){
							eCal = Calendar.getInstance();
							//eCal.setTime((Date)articleMap.get("date02"));
							eCal.set(Integer.parseInt(afterDate[0]), Integer.parseInt(afterDate[1])-1,Integer.parseInt(afterDate[2]));
						}else if(Integer.parseInt(afterDate[1])>Integer.parseInt(searchDateArr[1])){
							eCal = Calendar.getInstance();
							Calendar searchCal = Calendar.getInstance();
							searchCal.set(Integer.parseInt(searchDateArr[0]), Integer.parseInt(searchDateArr[1])-1, 1);
							eCal.set(Integer.parseInt(searchDateArr[0]), Integer.parseInt(searchDateArr[1])-1, searchCal.getActualMaximum(Calendar.DAY_OF_MONTH));
						}
					}
					for(Calendar iCal = (Calendar) sCal.clone(); iCal.getTimeInMillis() <= (eCal == null ? sCal.getTimeInMillis() : eCal.getTimeInMillis() ); iCal.add(Calendar.DATE, +1)){
						List<EgovMap> articles = (calRst.get(Long.valueOf(String.valueOf(iCal.get(Calendar.DATE)))) == null) ? new ArrayList<EgovMap>() : (ArrayList<EgovMap>) calRst.get(Long.valueOf(String.valueOf(iCal.get(Calendar.DATE))));
						articles.add(articleMap);
						calRst.put(Long.valueOf(String.valueOf(iCal.get(Calendar.DATE))), articles);
					}
				}
			}
			model.addAttribute("calList", calRst);
		}
		model.addAttribute("totCnt",totCnt);
		model.addAttribute("lastPage",paginationInfo.getLastPageNo());
		model.addAttribute("boardFileType", boardFileType);
		model.addAttribute("resultList", resultList);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		return model;
	}



	private  ModelMap write(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO) throws Exception{
		if(request.getParameter("cntId") != null){
			int pid = NullUtil.nullInt(request.getParameter("cntId"));
			model.addAttribute("pid", pid);
		}
		List sIdx = JnitboardinfoController.getFieldSortWrite(localVO.getBoardinfoVO());
		model.addAttribute("sIdx", sIdx);
		return model;
	}

	private ModelMap pwAnonymous(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO)throws Exception{

		int cntId = NullUtil.nullInt(request.getParameter("cntId"));
		String category = NullUtil.nullString(request.getParameter("category"));
		String pageIdx = NullUtil.nullString(request.getParameter("pageIdx"));
		String retUrl = NullUtil.nullString(request.getParameter("retUrl"));

		JnitboarddbVO dbVO = new JnitboarddbVO();
		dbVO.setBoardId(boardId);
		dbVO.setId(NullUtil.nullInt(request.getParameter("cntId")));
		dbVO = jnitboarddbService.selectAnonymous(dbVO);

		// 권한설정
		if(!NullUtil.nullString(localVO.getLoginVO().getMbrId()).equals("")){
			//관리자
			if(localVO.getIsAdmin()){
				model.addAttribute("move", "move");
				model.addAttribute("path", retUrl+"?boardId="+boardId+"&mode=view&cntId="+cntId+"&category="+category+"&pageIdx="+pageIdx);
				return model;
			}
			//글쓴이
			if(localVO.getLoginVO().getMbrId().equals(dbVO.getMbrId())){
				model.addAttribute("move", "move");
				model.addAttribute("path", retUrl+"?boardId="+boardId+"&mode=view&cntId="+cntId+"&category="+category+"&pageIdx="+pageIdx);
				return model;
			}
		}
		return model;
	}

	private ModelMap pwAnonymousProc(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO)throws Exception{

		String password = NullUtil.nullString(request.getParameter("password"));
		int cntId = NullUtil.nullInt(request.getParameter("cntId"));
		String category = NullUtil.nullString(request.getParameter("category"));
		String pageIdx = NullUtil.nullString(request.getParameter("pageIdx"));
		String retUrl = NullUtil.nullString(request.getParameter("retUrl"));

		if("".equals(password)){
			String mssage = isLanguage("패스워드가 올바르지 않습니다.", lang);
			model.addAttribute("alert", mssage);
			return model;
		}

		JnitboarddbVO dbVO = new JnitboarddbVO();
		dbVO.setBoardId(boardId);
		dbVO.setId(NullUtil.nullInt(request.getParameter("cntId")));
		dbVO = jnitboarddbService.selectAnonymous(dbVO);

		password = EgovFileScrty.encryptPassword(password);
		if(password.equals(dbVO.getPassword())){
			model.addAttribute("move", "move");
			model.addAttribute("path", request.getSession().getAttribute("passUrl"));
			request.getSession().setAttribute("uid", request.getSession().getId());
//			model.addAttribute("path", retUrl+"?boardId="+boardId+"&mode=view&cntId="+cntId+"&category="+category+"&pageIdx="+pageIdx+"&anonymous=true");
			return model;
		}else{
			String mssage = isLanguage("패스워드가 올바르지 않습니다.", lang);
			model.addAttribute("alert", mssage);
			return model;
		}
	}

	private ModelMap isSecretCheck(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model)throws Exception{

		int cntId = NullUtil.nullInt(request.getParameter("cntId"));
		String category = NullUtil.nullString(request.getParameter("category"));
		String pageIdx = NullUtil.nullString(request.getParameter("pageIdx"));
		String retUrl = NullUtil.nullString(request.getParameter("retUrl"));
		String mode = NullUtil.nullString(request.getParameter("mode"));
		String proc = NullUtil.nullString(request.getParameter("proc"));

		model.addAttribute("move", "move");
		model.addAttribute("path", retUrl+"?boardId="+boardId+"&mode=pw&cntId="+cntId+"&category="+category+"&pageIdx="+pageIdx);
		request.getSession().setAttribute("passUrl", retUrl+"?boardId="+boardId+"&mode="+mode+"&proc="+proc+"&cntId="+cntId+"&category="+category+"&pageIdx="+pageIdx);
		model.addAttribute("mode","pw");
		log.debug("isSecretCheck!!");
		return model;
	}

	private ModelMap isDeleteSuccess(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model)throws Exception{

		int cntId = NullUtil.nullInt(request.getParameter("cntId"));
		String category = NullUtil.nullString(request.getParameter("category"));
		String pageIdx = NullUtil.nullString(request.getParameter("pageIdx"));
		String retUrl = NullUtil.nullString(request.getParameter("retUrl"));

		model.addAttribute("move", "move");
		model.addAttribute("alert", "삭제 되었습니다.");
		model.addAttribute("path", retUrl+"?boardId="+boardId+"&mode=list&cntId="+cntId+"&category="+category+"&pageIdx="+pageIdx);

		return model;
	}

	private ModelMap isDeleteCheck(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model)throws Exception{

		String category = NullUtil.nullString(request.getParameter("category"));
		String pageIdx = NullUtil.nullString(request.getParameter("pageIdx"));
		String retUrl = NullUtil.nullString(request.getParameter("retUrl"));

		model.addAttribute("move", "move");
		model.addAttribute("alert", "삭제된 게시물 입니다.");
		model.addAttribute("path", retUrl+"?boardId="+boardId+"&mode=list&category="+category+"&pageIdx="+pageIdx);

		return model;
	}

	private ModelMap isExistCheck(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model)throws Exception{

		String category = NullUtil.nullString(request.getParameter("category"));
		String pageIdx = NullUtil.nullString(request.getParameter("pageIdx"));
		String retUrl = NullUtil.nullString(request.getParameter("retUrl"));

		model.addAttribute("move", "move");
		model.addAttribute("alert", "존재하지 않는 게시물 입니다.");
		model.addAttribute("path", retUrl+"?boardId="+boardId+"&mode=list&category="+category+"&pageIdx="+pageIdx);

		return model;
	}

	private  ModelMap view(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO) throws Exception{

		int cntId =  NullUtil.nullInt(request.getParameter("cntId"));
		JnitboarddbVO dbVO = new JnitboarddbVO();
		dbVO.setBoardId(boardId);
		dbVO.setId(cntId);

		try{
			dbVO = jnitboarddbService.selectAnonymous(dbVO);
		}catch(EgovBizException e){
			this.isExistCheck(boardId, request, model);
			return model;
		}

		if(dbVO.getIdx() != null){
			//답변글의 수정권한 관리자만 수정가능
			model.addAttribute("isMine",false);
		}else if(NullUtil.nullString(dbVO.getMbrId()).equals("")){
			/*ID가 없는 익명의 사용자이면 dbVO를 현재 가지고 있는것으로 쓴다*/
			model.addAttribute("isMine",true);
		}else if("true".equals(NullUtil.nullString(request.getParameter("anonymous")))){
			//비밀번호 검증 통과된자
			model.addAttribute("isMine",true);
		}else{
			dbVO = jnitboarddbService.select(dbVO);
			model.addAttribute("isMine",dbVO.getMbrId().equals(localVO.getLoginVO().getMbrId()));
		}

		//권한체크
		if("2".equals(localVO.getBoardinfoVO().getBoardSort())){ //게시물정렬 날짜형(내림차순)
			localVO.getBoardinfoVO().setHideWrite(1);
			model.addAttribute("boardinfoVO", localVO.getBoardinfoVO());
			model.addAttribute("permWrite", false);
		}
		if(localVO.getBoardinfoVO().getAnonPermView() != 1 && NullUtil.nullString(localVO.getLoginVO().getMbrId()).equals("")){
			model.addAttribute("error", isLanguage("조회할 수 있는 권한이 없습니다.", lang));
		}else if(!localVO.getPermView() && (!localVO.getIsAdmin() && !dbVO.getMbrId().equals(localVO.getLoginVO().getMbrId())) ){
			model.addAttribute("error", isLanguage("조회할 수 있는 권한이 없습니다.", lang));
		}else{
			//조회수 업데이트
			if(!localVO.getIsAdmin() && !NullUtil.nullString(localVO.getLoginVO().getMbrId()).equals(dbVO.getMbrId())){
				jnitboarddbService.hit(dbVO);
				//2015-05-24 by.나성재 수정
				JnitboarddbVO dbVO2 = new JnitboarddbVO();
				dbVO2.setBoardId("bbs_1000000000000000");
				dbVO2.setTmp1(boardId);
				dbVO2.setId(cntId);
				dbVO2.setUpdateCondition("1");
				jnitboarddbService.hit(dbVO2);

			}
			model.addAttribute("result", dbVO);

			List sIdx = JnitboardinfoController.getFieldSortView(localVO.getBoardinfoVO());
			//log.debug("sIdx : " + sIdx);
			model.addAttribute("sIdx", sIdx);

			JnitboardfileVO fileVO = new JnitboardfileVO();
			/*if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
				|| localVO.getBoardinfoVO().getBoardType().contains("movie")
				|| localVO.getBoardinfoVO().getBoardType().contains("movieLink")
				|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")){
				fileVO.setMainFileYn("N");
			}*/
			fileVO.setMainFileYn("N");
			fileVO.setBoardIdYn("Y");
			fileVO.setBoardId(boardId);
			fileVO.setBoardCntIdYn("Y");
			fileVO.setBoardCntId(cntId);
			if(localVO.getBoardinfoVO().getUseFile()!=0){
				List fileList = fileService.selectJnitboardfileList(fileVO);
				model.addAttribute("fileList", fileList);
			}
			if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
				|| localVO.getBoardinfoVO().getBoardType().contains("movie")
				|| localVO.getBoardinfoVO().getBoardType().contains("movieLink")
				|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")){
				try {
					fileVO = fileService.selectJnitboardfileMain(fileVO);
					model.addAttribute("mainFileVO", fileVO);
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					if("true".equals(debug)) log.debug(e.getMessage());
				}
			}
		}
		if(localVO.getBoardinfoVO().getBoardType().contains("inquiry")){
			JnitboarddbDefaultVO searchVO = new JnitboarddbDefaultVO();
			searchVO.setWithFile("1");
			searchVO.setWithContent("1");
			searchVO.setPageIdx(1);
			searchVO.setIsAdmin(localVO.getIsAdmin());
			searchVO.setBoardId(boardId);
			searchVO.setWithFile("1");
			searchVO.setSearchUseYn("NotNotice");
			searchVO.setGrp(cntId);
			/** pageing */
	    	int totCnt = jnitboarddbService.selectListTotCnt(searchVO);
	    	PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(searchVO.getPageIdx());
			paginationInfo.setRecordCountPerPage(1000);
			paginationInfo.setPageSize(searchVO.getPageSize());
			paginationInfo.setTotalRecordCount(totCnt);

			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			List inquiryList = jnitboarddbService.selectList(searchVO);
			model.addAttribute("inquiryList",inquiryList);
			if(DBType.getDbTypeBoolean("oracle")){
				/* CLOB contentMap 처리
				 * 2014-01-17 by.나성재 내용 oracle 버전 CLOB타입 문제로 인하여
				 * list에서 content 컬럼이 조회되는 스킨은 contentMap을 이용하도록한다.
				 */
				HashMap<BigDecimal, String> contentMap = new HashMap<BigDecimal, String>();
					Iterator resultIterator = inquiryList.iterator();
					for(int i=0; i<inquiryList.size(); i++){
						EgovMap resultEgovMap = (EgovMap) resultIterator.next();

						//DB : Number, vo : int 값이지만 어째서인지 jsp에서 result.id 타입값은 BigDecimal 받고있음
						String strId = String.valueOf(resultEgovMap.get("id"));
						BigDecimal id =  new BigDecimal(strId);
						CLOB content = (CLOB) resultEgovMap.get("content");
						if(content != null){
							StringBuffer sb = new StringBuffer();
							try {
								Reader reader = content.getCharacterStream();
								BufferedReader br = new BufferedReader(reader);

								String line = "";
								while ((line = br.readLine()) != null) {
									sb.append(line+"\r\n");
								}
								br.close();
							} catch (NullPointerException e){
								log.error(e.getMessage());
							} catch (Exception e) {
								log.error(e.getMessage());
							}
							contentMap.put(id, sb.toString());
						}
					}
					model.addAttribute("contentMap", contentMap);
				//End of CLOB contentMap 처리
			}else if(DBType.getDbTypeBoolean("tibero")){
				HashMap<BigDecimal, String> contentMap = new HashMap<BigDecimal, String>();
					Iterator resultIterator = inquiryList.iterator();
					for(int i=0; i<inquiryList.size(); i++){
						EgovMap resultEgovMap = (EgovMap) resultIterator.next();

						//DB : Number, vo : int 값이지만 어째서인지 jsp에서 result.id 타입값은 BigDecimal 받고있음
						String strId = String.valueOf(resultEgovMap.get("id"));
						BigDecimal id =  new BigDecimal(strId);
						com.tmax.tibero.jdbc.TbClob content = (com.tmax.tibero.jdbc.TbClob) resultEgovMap.get("content");
						if(content != null){
							StringBuffer sb = new StringBuffer();
							try {
								Reader reader = content.getCharacterStream();
								BufferedReader br = new BufferedReader(reader);

								String line = "";
								while ((line = br.readLine()) != null) {
									sb.append(line+"\r\n");
								}
								br.close();
							} catch (NullPointerException e){
								log.error(e.getMessage());
							} catch (Exception e) {
								log.error(e.getMessage());
							}
							contentMap.put(id, sb.toString());
						}
					}
					model.addAttribute("contentMap", contentMap);
				//End of CLOB contentMap 처리
			}else{
				HashMap<Integer, String> contentMap = new HashMap<Integer, String>();
				Iterator resultIterator = inquiryList.iterator();
				for(int i=0; i<inquiryList.size(); i++){
					EgovMap resultEgovMap = (EgovMap) resultIterator.next();

					int id = (Integer)resultEgovMap.get("id");
					String content = (String) resultEgovMap.get("content");
					contentMap.put(id, content);
				}
				model.addAttribute("contentMap", contentMap);
			}
			//첨부파일 체크
			JnitboardfileVO boardfileVO = new JnitboardfileVO();
			boardfileVO.setSearchCondition("2");
			boardfileVO.setMainFileYn("N");
			HashMap<String, String> boardFileType =  new HashMap<String, String>();
			if(DBType.getDbTypeBoolean("oracle")){
				HashMap<BigDecimal, List> boardFileMap = new HashMap<BigDecimal, List>();
				Iterator fileitr = inquiryList.iterator();
				while(fileitr.hasNext()){
					EgovMap resultMap = (EgovMap)fileitr.next();
					BigDecimal id = new BigDecimal(String.valueOf(resultMap.get("id")));
					boardfileVO.setBoardId(boardId);
					boardfileVO.setBoardCntId(id.intValue());
					List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //jnitboardfileService.selectFileList(boardId, id.intValue());
					boardFileMap.put(id, fileList);
					Iterator fileItr = fileList.iterator();
					while (fileItr.hasNext()) {
						EgovMap articleMap = (EgovMap)fileItr.next();
						if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
							String fileNm = String.valueOf(articleMap.get("fileNm"));
							try{
								String[] fileType = fileNm.split("\\.");
								boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
							} catch (NullPointerException e){
								log.error(e.getMessage());
							}catch(Exception e){
								if("true".equals(debug)) log.debug(e.getMessage());
							}
						}
					}
				}
				model.addAttribute("boardFileMap", boardFileMap);
				model.addAttribute("boardFileType",boardFileType);
			}else if(DBType.getDbTypeBoolean("tibero")){
				HashMap<BigDecimal, List> boardFileMap = new HashMap<BigDecimal, List>();
				Iterator fileitr = inquiryList.iterator();
				while(fileitr.hasNext()){
					EgovMap resultMap = (EgovMap)fileitr.next();
					BigDecimal id = new BigDecimal(String.valueOf(resultMap.get("id")));
					boardfileVO.setBoardId(boardId);
					boardfileVO.setBoardCntId(id.intValue());
					List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //jnitboardfileService.selectFileList(boardId, id.intValue());
					boardFileMap.put(id, fileList);
					Iterator fileItr = fileList.iterator();
					while (fileItr.hasNext()) {
						EgovMap articleMap = (EgovMap)fileItr.next();
						if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
							String fileNm = String.valueOf(articleMap.get("fileNm"));
							try{
								String[] fileType = fileNm.split("\\.");
								boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
							} catch (NullPointerException e){
								log.error(e.getMessage());
							}catch(Exception e){
								if("true".equals(debug)) log.debug(e.getMessage());
							}
						}
					}
				}
				model.addAttribute("boardFileMap", boardFileMap);
				model.addAttribute("boardFileType",boardFileType);
			}else{
				HashMap<Integer, List> boardFileMap = new HashMap<Integer, List>();
				Iterator fileitr = inquiryList.iterator();
				while(fileitr.hasNext()){
					EgovMap resultMap = (EgovMap)fileitr.next();
					String id = String.valueOf(resultMap.get("id"));
					boardfileVO.setBoardId(boardId);
					boardfileVO.setBoardCntId(Integer.parseInt(id));
					List fileList = jnitboardfileService.selectJnitboardfileList(boardfileVO); //List fileList = jnitboardfileService.selectFileList(boardId, Integer.parseInt(id));
					boardFileMap.put(Integer.parseInt(id), fileList);
					Iterator fileItr = fileList.iterator();
					while (fileItr.hasNext()) {
						EgovMap articleMap = (EgovMap)fileItr.next();
						if(!NullUtil.nullString(String.valueOf(articleMap.get("fileNm"))).equals("")){
							String fileNm = String.valueOf(articleMap.get("fileNm"));
							try{
								String[] fileType = fileNm.split("\\.");
								boardFileType.put(String.valueOf(articleMap.get("fileId")), fileType[fileType.length-1]);
							} catch (NullPointerException e){
								log.error(e.getMessage());
							}catch(Exception e){
								if("true".equals(debug)) log.debug(e.getMessage());
							}
						}
					}
				}
				model.addAttribute("boardFileMap", boardFileMap);
				model.addAttribute("boardFileType",boardFileType);
			}
		}

		JnitboarddbDefaultVO replyVO = new JnitboarddbDefaultVO();
		replyVO.setFirstIndex(0);
		replyVO.setBoardId(boardId);
		replyVO.setWithContent("1");
		replyVO.setGrp(NullUtil.nullInt(request.getParameter("cntId")));
		if(jnitboarddbService.selectListTotCnt(replyVO) > 0){
			List replyList = jnitboarddbService.selectList(replyVO);
			model.addAttribute("replyList" , replyList);
		}

		JnitboardcmtDefaultVO cmtDefaultVO = new JnitboardcmtDefaultVO();
		cmtDefaultVO.setCmtBoardId(boardId);
		cmtDefaultVO.setCmtBoardCntId(NullUtil.nullInt(request.getParameter("cntId")));
		cmtDefaultVO.setSearchCondition("2");
		if(jnitboardcmtService.selectJnitboardcmtListTotCnt(cmtDefaultVO) >0){
			List cmtList = jnitboardcmtService.selectJnitboardcmtList(cmtDefaultVO);
			model.addAttribute("cmtList", cmtList);
			if(DBType.getDbTypeBoolean("oracle")){

				HashMap<String, String> cmtMap = new HashMap<String, String>();
					Iterator resultIterator = cmtList.iterator();
					for(int i=0; i<cmtList.size(); i++){
						EgovMap resultEgovMap = (EgovMap) resultIterator.next();

						String strId = String.valueOf(resultEgovMap.get("cmtId"));
						CLOB content = (CLOB) resultEgovMap.get("cmtText");
						if(content != null){
							StringBuffer sb = new StringBuffer();
							try {
								Reader reader = content.getCharacterStream();
								BufferedReader br = new BufferedReader(reader);

								String line = "";
								while ((line = br.readLine()) != null) {
									sb.append(line+"\r\n");
								}
								br.close();
							} catch (NullPointerException e){
								log.error(e.getMessage());
							} catch (Exception e) {
								log.error(e.getMessage());
							}
							cmtMap.put(strId, sb.toString());
						}
					}
					model.addAttribute("cmtMap", cmtMap);
			}else if(DBType.getDbTypeBoolean("tibero")){

				HashMap<String, String> cmtMap = new HashMap<String, String>();
					Iterator resultIterator = cmtList.iterator();
					for(int i=0; i<cmtList.size(); i++){
						EgovMap resultEgovMap = (EgovMap) resultIterator.next();

						String strId = String.valueOf(resultEgovMap.get("cmtId"));
						com.tmax.tibero.jdbc.TbClob content = (com.tmax.tibero.jdbc.TbClob) resultEgovMap.get("cmtText");
						if(content != null){
							StringBuffer sb = new StringBuffer();
							try {
								Reader reader = content.getCharacterStream();
								BufferedReader br = new BufferedReader(reader);

								String line = "";
								while ((line = br.readLine()) != null) {
									sb.append(line+"\r\n");
								}
								br.close();
							} catch (NullPointerException e){
								log.error(e.getMessage());
							} catch (Exception e) {
								log.error(e.getMessage());
							}
							cmtMap.put(strId, sb.toString());
						}
					}
					model.addAttribute("cmtMap", cmtMap);
			}

		}
		JnitboardgoodDefaultVO goodsearchVO = new JnitboardgoodDefaultVO();
		goodsearchVO.setSearchCondition("2");
		goodsearchVO.setSearchBoardId(boardId);
		goodsearchVO.setSearchBoardCntId(NullUtil.nullString(request.getParameter("cntId")));
		int goodCnt = jnitboardgoodService.selectJnitboardgoodListTotCnt(goodsearchVO);
		model.addAttribute("goodCnt",goodCnt);

		JnitboarddbDefaultVO searchVO = new JnitboarddbDefaultVO();
		searchVO.setIsAdmin(localVO.getIsAdmin());
		searchVO.setSearchKeyword(String.valueOf(dbVO.getGrp()));
		searchVO.setBoardId(boardId);
		searchVO.setOrderbyCondition(localVO.getBoardinfoVO().getBoardSort());
		searchVO.setSearchCondition("prev");
		List prevList = jnitboarddbService.selectPNList(searchVO);
		searchVO.setSearchCondition("next");
		List nextList = jnitboarddbService.selectPNList(searchVO);
		searchVO.setSearchCondition("now");
		List nowList = jnitboarddbService.selectPNList(searchVO);
		model.addAttribute("prevList",prevList);
		model.addAttribute("nextList",nextList);
		model.addAttribute("nowList",nowList);
		List sIdxPN = JnitboardinfoController.getFieldSortList(localVO.getBoardinfoVO());
		model.addAttribute("sIdxPN", sIdxPN);

		String uid = NullUtil.nullString((String)request.getSession().getAttribute("uid"));
		if(dbVO.getIsdel() == 1 && !localVO.getIsAdmin()){
			this.isDeleteCheck(boardId, request, model);
		}else if(dbVO.getIsSecret() == 1 && !uid.equals(request.getSession().getId()) && !localVO.getIsAdmin()){
			this.isSecretCheck(boardId, request, model);
		}

		return model;
	}
	private  ModelMap edit(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO) throws Exception{

		int cntId =  NullUtil.nullInt(request.getParameter("cntId"));
		JnitboarddbVO dbVO = new JnitboarddbVO();
		dbVO.setBoardId(boardId);
		dbVO.setId(cntId);
		dbVO = jnitboarddbService.selectAnonymous(dbVO);

		if(NullUtil.nullString(dbVO.getMbrId()).equals("")){
			/*ID가 없는 익명의 사용자이면 dbVO를 현재 가지고 있는것으로 쓴다*/
			model.addAttribute("result", dbVO);
		}else{
			dbVO = jnitboarddbService.select(dbVO);
			if(!localVO.getIsAdmin() && !dbVO.getMbrId().equals(localVO.getLoginVO().getMbrId())){
				model.addAttribute("error", isLanguage("수정할 수 있는 권한이 없습니다.", lang));
			}else{
				model.addAttribute("isMine",dbVO.getMbrId().equals(localVO.getLoginVO().getMbrId()));
				model.addAttribute("result", dbVO);
			}
		}

		if(localVO.getBoardinfoVO().getUseFile()==1){
			JnitboardfileVO fileVO = new JnitboardfileVO();
			fileVO.setBoardId(boardId);
			fileVO.setBoardCntId(dbVO.getId());
			/*if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
				|| localVO.getBoardinfoVO().getBoardType().contains("movie")
				|| localVO.getBoardinfoVO().getBoardType().contains("movieLink")
				|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")){
				fileVO.setMainFileYn("N");
			}*/
			fileVO.setMainFileYn("N");
			fileVO.setBoardIdYn("Y");
			fileVO.setBoardCntIdYn("Y");
			List fileList = fileService.selectJnitboardfileList(fileVO);
			model.addAttribute("fileList", fileList);
		}

		List sIdx = JnitboardinfoController.getFieldSortWrite(localVO.getBoardinfoVO());
		model.addAttribute("sIdx", sIdx);

		if(localVO.getBoardinfoVO().getBoardType().contains("gallery")
			|| localVO.getBoardinfoVO().getBoardType().contains("movie")
			|| localVO.getBoardinfoVO().getBoardType().contains("movieLink")
			|| localVO.getBoardinfoVO().getBoardType().contains("thumbnail")){
			JnitboardfileVO mainfileVO = new JnitboardfileVO();
			mainfileVO.setBoardId(boardId);
			mainfileVO.setBoardCntId(cntId);
			try {
				mainfileVO = jnitboardfileService.selectJnitboardfileMain(mainfileVO);
				model.addAttribute("mainfileVO", mainfileVO);
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				if("true".equals(debug)) log.debug(e.getMessage());
			}
		}
		model.addAttribute("boardTmp4", new JSONObject().fromObject(dbVO.getTmp4()));

		String uid = NullUtil.nullString((String)request.getSession().getAttribute("uid"));
		if(dbVO.getIsdel() == 1 && !localVO.getIsAdmin()){
			this.isDeleteCheck(boardId, request, model);
		}else if(dbVO.getIsSecret() == 1 && !uid.equals(request.getSession().getId()) && !localVO.getIsAdmin()){
			this.isSecretCheck(boardId, request, model);
		}

		return model;
	}

	private ModelMap delete(@RequestParam("boardId") java.lang.String boardId,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO) throws Exception{

		JnitboarddbVO dbVO = new JnitboarddbVO();
		dbVO.setBoardId(boardId);
		dbVO.setId(NullUtil.nullInt(request.getParameter("cntId")));
		dbVO = jnitboarddbService.selectAnonymous(dbVO);
		//bbs_1000000000000000 게시판

		String uid = NullUtil.nullString((String)request.getSession().getAttribute("uid"));
		if(dbVO.getIsdel() == 1 && !localVO.getIsAdmin()){
			this.isDeleteCheck(boardId, request, model);
			return model;
		}else if(dbVO.getIsSecret() == 1 && !uid.equals(request.getSession().getId()) && !localVO.getIsAdmin()){
			this.isSecretCheck(boardId, request, model);
			return model;
		}

		if(NullUtil.nullString(dbVO.getMbrId()).equals("") && !localVO.getIsAdmin()){
			jnitboarddbService.delete(dbVO);
			//bbs_1000000000000000 게시판
			JnitboarddbVO latestVO = dbVO;
			latestVO.setTmp1(dbVO.getBoardId());
			latestVO.setTmp2(Integer.toString(dbVO.getId()));
			latestVO.setTmp3(dbVO.getTmp3());
			latestVO.setBoardId("bbs_1000000000000000");
			latestVO.setDeleteCondition("1");
			jnitboarddbService.delete(latestVO);
			this.isDeleteSuccess(boardId, request, model);

		}else{
			//삭제
			if(localVO.getIsAdmin() || NullUtil.nullString(localVO.getLoginVO().getMbrId()).equals(dbVO.getMbrId())){
				jnitboarddbService.delete(dbVO);
				//bbs_1000000000000000 게시판
				JnitboarddbVO latestVO = dbVO;
				latestVO.setTmp1(dbVO.getBoardId());
				latestVO.setTmp2(Integer.toString(dbVO.getId()));
				latestVO.setTmp3(dbVO.getTmp3());
				latestVO.setBoardId("bbs_1000000000000000");
				latestVO.setDeleteCondition("1");
				jnitboarddbService.delete(latestVO);

				JnitboardfileVO fileVO = new JnitboardfileVO();
				fileVO.setBoardId(boardId);
				fileVO.setBoardCntId(dbVO.getId());
				fileService.deleteJnitboardfileWyswyg(fileVO);
				this.isDeleteSuccess(boardId, request, model);
			}else{
				model.addAttribute("NoPasswd", isLanguage("권한이 없습니다.", lang));
			}

		}
		return model;

	}

	private  ModelMap proc(@RequestParam("boardId") java.lang.String boardId,
			String proc,
			HttpServletRequest request,
			ModelMap model,
			LocalVO localVO) throws Exception{
		if(debug.equals("true")) log.debug("Proc : " + proc);
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
		jnitboardinfoVO.setBoardId(boardId);
		jnitboardinfoVO = infoService.selectJnitboardinfo(jnitboardinfoVO);
		//String antisamyTinymce = request.getSession().getServletContext().getRealPath("") + SEPERATOR + "WEB-INF/classes/antisamy-tinymce-1.4.4.xml";
		String antisamyTinymce = request.getSession().getServletContext().getRealPath("") + SEPERATOR + "WEB-INF/classes/antisamy-anythinggoes-1.4.4.xml";

		Policy policy = Policy.getInstance(antisamyTinymce);
		AntiSamy as = new AntiSamy(); // Create AntiSamy object


		JnitboarddbVO pVO = new JnitboarddbVO();
		JnitboarddbVO boarddbVO = new JnitboarddbVO();

		int pid = NullUtil.nullInt(request.getParameter("pid"));
		if(pid != 0){
			pVO.setBoardId(boardId);
			pVO.setId(pid);
			pVO.setSelectCondition("1");
			pVO = jnitboarddbService.select(pVO);
			if(localVO.getBoardinfoVO().getBoardType().equals("inquiry")){
				pVO.setExt20("완료");
				jnitboarddbService.update(pVO);
			}
			pVO.setSelectCondition("1");
			pVO.setBoardId(boardId);
			pVO.setIdx(NullUtil.nullString(pVO.getIdx()));
			String nextIdx = jnitboarddbService.getNextIdx(pVO);
			boarddbVO.setGrp(pVO.getGrp());
			boarddbVO.setIdx(nextIdx);
			model.addAttribute("pid",pid);
		}

		if("write".equals(proc)){
			
			Calendar beforeBoardWriteTime = Calendar.getInstance();
			Calendar afterBoardWriteTime = Calendar.getInstance();
			boolean timeChk = true;
			
			if(request.getSession().getAttribute("boardWriteTime") != null){
				beforeBoardWriteTime.setTime((Date) request.getSession().getAttribute("boardWriteTime"));
				long timeTerm = afterBoardWriteTime.getTimeInMillis() - beforeBoardWriteTime.getTimeInMillis();
				if(TimeUnit.MILLISECONDS.toSeconds(timeTerm) < 3){
					model.addAttribute("error", "게시글을 등록한지 얼마 지나지 않았습니다. 잠시후 다시 등록해주세요");
					timeChk = false;
				}
			}
			
			if(timeChk){
				request.getSession().setAttribute("boardWriteTime", Calendar.getInstance().getTime());			//등록된 시점으로부터 시간 체크
				
				boarddbVO.setBoardId(boardId);
				boarddbVO.setIsSecret(NullUtil.nullInt(request.getParameter("isSecret")));
				boarddbVO.setIsNotice(NullUtil.nullInt(request.getParameter("isNotice")));
				boarddbVO.setIsHtml(localVO.getBoardinfoVO().getUseWyswyg()==1?1:0);
	
				if(!model.get("fixedCategory").equals("")){
					boarddbVO.setCategory(String.valueOf(model.get("fixedCategory")));
				}else{
					boarddbVO.setCategory(NullUtil.nullString(request.getParameter("category")));
				}
				String password = (EgovFileScrty.encryptPassword(NullUtil.nullString(request.getParameter("password"))));
				if("1".equals(pVO.getSelectCondition())) password = pVO.getPassword();
	
				boarddbVO.setTitle(NullUtil.nullString(request.getParameter("title")));
				boarddbVO.setPassword(password);
				boarddbVO.setExt01(NullUtil.nullString(request.getParameter("ext01")));
				boarddbVO.setExt02(NullUtil.nullString(request.getParameter("ext02")));
				boarddbVO.setExt03(NullUtil.nullString(request.getParameter("ext03")));
				boarddbVO.setExt04(NullUtil.nullString(request.getParameter("ext04")));
				boarddbVO.setExt05(NullUtil.nullString(request.getParameter("ext05")));
				boarddbVO.setExt06(NullUtil.nullString(request.getParameter("ext06")));
				boarddbVO.setExt07(NullUtil.nullString(request.getParameter("ext07")));
				boarddbVO.setExt08(NullUtil.nullString(request.getParameter("ext08")));
				boarddbVO.setExt09(NullUtil.nullString(request.getParameter("ext09")));
				boarddbVO.setExt10(NullUtil.nullString(request.getParameter("ext10")));
				boarddbVO.setExt11(NullUtil.nullString(request.getParameter("ext11")));
				boarddbVO.setExt12(NullUtil.nullString(request.getParameter("ext12")));
				boarddbVO.setExt13(NullUtil.nullString(request.getParameter("ext13")));
				boarddbVO.setExt14(NullUtil.nullString(request.getParameter("ext14")));
				boarddbVO.setExt15(NullUtil.nullString(request.getParameter("ext15")));
				boarddbVO.setExt16(NullUtil.nullString(request.getParameter("ext16")));
				boarddbVO.setExt17(NullUtil.nullString(request.getParameter("ext17")));
				boarddbVO.setExt18(NullUtil.nullString(request.getParameter("ext18")));
				boarddbVO.setExt19(NullUtil.nullString(request.getParameter("ext19")));
				boarddbVO.setExt20(NullUtil.nullString(request.getParameter("ext20")));
				boarddbVO.setTmp3(NullUtil.nullInt(request.getParameter("tmp3"))); //최근게시물 표시
				boarddbVO.setTmp4(infoService.makeTmp4JSON(request, jnitboardinfoVO).toString()); //icon 강제 노출
	
				if(jnitboardinfoVO.getUseWyswyg() == 1){
					String xssContent = NullUtil.nullString(request.getParameter("origin_content"));
					if(xssContent.equals("")){
						xssContent = NullUtil.nullString(request.getParameter("content"));
					}
					//관리자면 필터를 통과 (2019.04.15 웹취약점으로 인해 관리자, 사용자 모두 antisamy 통해서 저장하도록 변경)
	//				if(!localVO.getIsAdmin()){
						CleanResults cr = as.scan(xssContent, policy, AntiSamy.SAX);
						xssContent = cr.getCleanHTML();
	//				}
					boarddbVO.setContent(xssContent);
				}else{
					String xssContent = NullUtil.nullString(request.getParameter("content"));
					//관리자면 필터를 통과 (2019.04.15 웹취약점으로 인해 관리자, 사용자 모두 antisamy 통해서 저장하도록 변경)
	//				if(!localVO.getIsAdmin()){
						CleanResults cr = as.scan(xssContent, policy, AntiSamy.SAX);
						xssContent = cr.getCleanHTML();
	//				}
					boarddbVO.setContent(xssContent);
				}
	
				if(!"".equals(NullUtil.nullString(request.getParameter("date01")))){
					try{
						if(localVO.getBoardinfoVO().getDate01Opt().equals("date")){
							boarddbVO.setDate01(sdfDate.parse(request.getParameter("date01")));
						}else if(localVO.getBoardinfoVO().getDate01Opt().equals("datetime")){
							boarddbVO.setDate01(sdfDatetime.parse(request.getParameter("date01")));
						}
					} catch (NullPointerException e){
						log.error(e.getMessage());
					}catch(Exception e){
						log.error(e.getMessage());
					}
				}
				if(!"".equals(NullUtil.nullString(request.getParameter("date02")))){
					try{
						if(localVO.getBoardinfoVO().getDate02Opt().equals("date")){
							boarddbVO.setDate02(sdfDate.parse(request.getParameter("date02")));
						}else if(localVO.getBoardinfoVO().getDate02Opt().equals("datetime")){
							boarddbVO.setDate02(sdfDatetime.parse(request.getParameter("date02")));
						}
					} catch (NullPointerException e){
						log.error(e.getMessage());
					}catch(Exception e){
						log.error(e.getMessage());
					}
				}
	
				/**
				 * MediaEx 연계
				 */
				if(localVO.getBoardinfoVO().getBoardType().contains("media")){
					String imageSrc = "http://"+mediaExHost.trim()+":2935/"+boarddbVO.getExt18()+"_"+boarddbVO.getExt20()+".png";
					String attachFilePath = MEDIA_UPLOAD_PATH + SEPERATOR + boarddbVO.getExt18()+"_"+ boarddbVO.getExt20() +".jpg";
					URL voImageURL = new URL(imageSrc);
	
					//이미지에 해당하는 url을 통하여 커넥션을 진행
					HttpURLConnection voImageReponse = (HttpURLConnection) voImageURL
					        .openConnection();
	
					//200_OK 응답에 대해서만 처리
					if (voImageReponse.getResponseCode() == HttpURLConnection.HTTP_OK) {
					    InputStream is = voImageReponse.getInputStream();
	
					    //응답 코드를 C:\1.jpg에 저장
	
					    FileOutputStream fos = new FileOutputStream(attachFilePath);
					    BufferedInputStream bis = new BufferedInputStream(is);
					    BufferedOutputStream bos = new BufferedOutputStream(fos);
	
					    //응답 코드를 1024바이트 단위로 저장
					    int len = 0;
					    byte[] buf = new byte[1024];
					    while ((len = bis.read(buf, 0, 1024)) != -1) {
					        bos.write(buf, 0, len);
					        bos.flush();
					    }
					    if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
					    if(bis != null) try{bis.close();}catch(IOException e){log.error(e.getMessage());}
					    if(bos != null) try{bos.close();}catch(IOException e){log.error(e.getMessage());}
	
					} else {
					    log.debug("connection failed. code is : "
					            + voImageReponse.getResponseCode());
					    log.debug("failed connection url : " + voImageReponse.getURL());
					}
					String physical = boarddbVO.getExt18() +boarddbVO.getExt20() +".jpg";
					String thumbFilePath = MEDIA_UPLOAD_PATH + "thumb_" + physical;
	
					java.io.File thumbFile = new File(thumbFilePath);
	
					if(!thumbFile.exists()) {
						ThumbnailUtil.createThumbnail(attachFilePath, thumbFile.getPath(), 150);
						thumbFile = new File(thumbFilePath);
					}
				}
	
				boarddbVO.setHit(NullUtil.nullInt(request.getParameter("hit")));
				boarddbVO.setWriter(NullUtil.nullString(request.getParameter("writer")));
				//2014-07-21 by.나성재 수정 익명글은 mbr_id = null
				if(!"".equals(NullUtil.nullString(localVO.getLoginVO().getMbrId()))) boarddbVO.setMbrId(localVO.getLoginVO().getMbrId());
				boarddbVO.setMbrIp(request.getRemoteAddr());
				if(!"".equals(NullUtil.nullString(request.getParameter("created")))){
					try{
						boarddbVO.setCreated(sdfDatetime.parse(request.getParameter("created")));
					} catch (NullPointerException e){
						log.error(e.getMessage());
					}catch(Exception e){
						log.error(e.getMessage());
					}
				}
				boarddbVO.setSearchKeyword(request.getRequestURI());
				int cntId = jnitboarddbService.insert(boarddbVO);
				model.addAttribute("cntId",cntId);
	
	
				//첨부파일 처리
				String upPath = BOARD_UPLOAD_PATH+SEPERATOR+boardId;
				HashMap<String, EgovFormBasedFileVo> fileList = EgovFileUploadUtil.uploadFormFiles(request, upPath, maxFileSize);
				Iterator fileItr = fileList.keySet().iterator();
	
				int sortKey = 10;
				while(fileItr.hasNext()){
					String key = (String)fileItr.next();
	
					EgovFormBasedFileVo item = (EgovFormBasedFileVo)fileList.get(key);
					JnitboardfileVO fileVO = new JnitboardfileVO();
					fileVO.setBoardId(boardId);
					fileVO.setBoardCntId(cntId);
					fileVO.setFileNm(item.getPhysicalName());
					fileVO.setFileOnm(item.getFileName());
					fileVO.setFilePath(item.getServerSubPath());
					fileVO.setFileSize(item.getSize());
					fileVO.setIsmain(sortKey);
					sortKey = sortKey + 1;
	
					if(!NullUtil.nullString(request.getParameter("mainFileAlt")).equals("")){
						fileVO.setExt01(request.getParameter("mainFileAlt"));
					}
					if(!NullUtil.nullString(request.getParameter("upfileAlt"+(sortKey-10))).equals("")){
						fileVO.setExt01(request.getParameter("upfileAlt"+(sortKey-10)));
					}
					if(NullUtil.nullString(request.getParameter("moviefile")).equals(key)){
						fileVO.setIsmain(2);
					}
	
					if(item.getSize() > 0 && "mainfile".equals(key)){
						fileVO.setIsmain(1);
						fileService.insertJnitboardfile(fileVO);
					}else if(localVO.getBoardinfoVO().getUseFile()==1){
						fileService.insertJnitboardfile(fileVO);
					}
				}
	
	
				//위지윅에디터 이미지 처리
				if(localVO.getBoardinfoVO().getUseImage()==1){
					if(request.getParameterValues("tx_attach_image[]") != null ){
						String[] images = (String[])request.getParameterValues("tx_attach_image[]");
						JnitboardfileVO fileVO = new JnitboardfileVO();
						String fileid = "";
						for(int i = 0; i<images.length;i++){
							fileVO = new JnitboardfileVO();
							fileid = images[i];
							fileVO.setFileId(fileid);
							fileVO = fileService.selectJnitboardfile(fileVO);
							fileVO.setBoardId(boardId);
							fileVO.setBoardCntId(cntId);
							fileVO.setExt01("");
					    	String fileExp = "";
					    	try{
						    	String fileDot[] = fileVO.getFileOnm().split("\\.");
						    	fileExp = "."+fileDot[fileDot.length-1];
					    	} catch (NullPointerException e){
					    		fileExp = "";
					    	}catch(Exception e){
					    		fileExp = "";
					    	}
					    	String fileNm = new String(new Base64(true).encode(fileVO.getFileOnm().getBytes()));
							String fileUrl = "/board/file/" + fileVO.getBoardId() + "/" + String.valueOf(fileVO.getBoardCntId()) + "/" + fileVO.getFileId() + "/" + fileNm + fileExp;
							fileVO.setFileUrl(fileUrl);
							fileService.updateJnitboardfile(fileVO);
						}
					}
				}
				if(localVO.getBoardinfoVO().getUseFile() == 2){
					String fileIds = NullUtil.nullString(request.getParameter("fileuploadList"));
					String[] fileId = fileIds.split(",");
					for(int i=0;i<fileId.length;i++ ){
						JnitboardfileVO fileVO = new JnitboardfileVO();
						if(!fileId[i].equals("")){
							fileVO.setFileId(fileId[i]);
							fileVO = fileService.selectJnitboardfile(fileVO);
							fileVO.setBoardId(boardId);
							fileVO.setBoardCntId(cntId);
							String fileUrl = "/board/file/" + boardId + "/" + boarddbVO.getId() + "/" + fileId[i] + "/" + fileVO.getFileNm();
							fileVO.setFileUrl(fileUrl);
							fileService.updateJnitboardfile(fileVO);
						}
	
					}
				}
				//SMS발송
	
				if(localVO.getBoardinfoVO().getUseSms() == 1){
					String phoneTo = NullUtil.nullString(localVO.getBoardinfoVO().getSmsNum());
					String smsMsg = localVO.getBoardinfoVO().getBoardTitle() + isLanguage("에 새 게시물이 등록되었습니다.", lang);
					if(!"".equals(phoneTo)){
						SuremSMS.suremSendMessage("DEFAULT", "DEFAULT", phoneTo, "DEFAULT",  "", smsMsg, "AUTO", null);
					}
	
				}
			}
	    	model.addAttribute("boarddbVO" , boarddbVO);
		}
		if("edit".equals(proc)){
			boolean editGo = false;
			boolean passwdFalse = false;
			boarddbVO = new JnitboarddbVO();
			boarddbVO.setBoardId(boardId);
			boarddbVO.setId(NullUtil.nullInt(request.getParameter("cntId")));
			boarddbVO = jnitboarddbService.selectAnonymous(boarddbVO);
			//log.debug("edit GO!");
			if(NullUtil.nullString(boarddbVO.getMbrId()).equals("") && !localVO.getIsAdmin()){
				String password = NullUtil.nullString(request.getParameter("password"));
				//log.debug("password :"+password);
				password = EgovFileScrty.encryptPassword(password);
				if(password.equals(boarddbVO.getPassword())){
					editGo = true;
				}else{
					//model.addAttribute("error","올바르지 않은 암호입니다.");
					passwdFalse = true;
				}
			}else{
				boarddbVO = jnitboarddbService.selectAnonymous(boarddbVO);
				if(localVO.getLoginVO().getMbrId().equals(boarddbVO.getMbrId()) || localVO.getIsAdmin()){
					editGo = true;
				}
			}

			if(editGo){
				String category = NullUtil.nullString(request.getParameter("category"));
				String title = NullUtil.nullString(request.getParameter("title"));
				//if(request.getParameter("isSecret") != null)
				boarddbVO.setIsSecret(NullUtil.nullInt(request.getParameter("isSecret")));
				boarddbVO.setIsNotice(NullUtil.nullInt(request.getParameter("isNotice")));
				//boarddbVO.setIsHtml(NullUtil.nullInt(request.getParameter("isHtml")));
				boarddbVO.setIsHtml(localVO.getBoardinfoVO().getUseWyswyg()==1?1:0);
				if(!model.get("fixedCategory").equals("")){
					boarddbVO.setCategory(String.valueOf(model.get("fixedCategory")));
				}else{
					if(!"".equals(category))
						boarddbVO.setCategory(category);
				}
				if(!"".equals(title))
					boarddbVO.setTitle(NullUtil.nullString(request.getParameter("title")));
				/*
				if(!"".equals(content))
					boarddbVO.setContent(NullUtil.nullString(request.getParameter("content")));
				*/
				if(jnitboardinfoVO.getUseWyswyg() == 1){
					String xssContent = NullUtil.nullString(request.getParameter("origin_content"));
					if(xssContent.equals("")){
						xssContent = NullUtil.nullString(request.getParameter("content"));
					}
					//관리자면 필터를 통과 (2019.04.15 웹취약점으로 인해 관리자, 사용자 모두 antisamy 통해서 저장하도록 변경)
//					if(!localVO.getIsAdmin()){
						CleanResults cr = as.scan(xssContent, policy, AntiSamy.SAX);
						xssContent = cr.getCleanHTML();
//					}
					boarddbVO.setContent(xssContent);
				}else{
					String xssContent = NullUtil.nullString(request.getParameter("content"));
					//관리자면 필터를 통과 (2019.04.15 웹취약점으로 인해 관리자, 사용자 모두 antisamy 통해서 저장하도록 변경)
//					if(!localVO.getIsAdmin()){
						CleanResults cr = as.scan(xssContent, policy, AntiSamy.SAX);
						xssContent = cr.getCleanHTML();
//					}
					boarddbVO.setContent(xssContent);
				}
					boarddbVO.setExt01(NullUtil.nullString(request.getParameter("ext01")));
					boarddbVO.setExt02(NullUtil.nullString(request.getParameter("ext02")));
					boarddbVO.setExt03(NullUtil.nullString(request.getParameter("ext03")));
					boarddbVO.setExt04(NullUtil.nullString(request.getParameter("ext04")));
					boarddbVO.setExt05(NullUtil.nullString(request.getParameter("ext05")));
					boarddbVO.setExt06(NullUtil.nullString(request.getParameter("ext06")));
					boarddbVO.setExt07(NullUtil.nullString(request.getParameter("ext07")));
					boarddbVO.setExt08(NullUtil.nullString(request.getParameter("ext08")));
					boarddbVO.setExt09(NullUtil.nullString(request.getParameter("ext09")));
					boarddbVO.setExt10(NullUtil.nullString(request.getParameter("ext10")));
					boarddbVO.setExt11(NullUtil.nullString(request.getParameter("ext11")));
					boarddbVO.setExt12(NullUtil.nullString(request.getParameter("ext12")));
					boarddbVO.setExt13(NullUtil.nullString(request.getParameter("ext13")));
					boarddbVO.setExt14(NullUtil.nullString(request.getParameter("ext14")));
					boarddbVO.setExt15(NullUtil.nullString(request.getParameter("ext15")));
					boarddbVO.setExt16(NullUtil.nullString(request.getParameter("ext16")));
					boarddbVO.setExt17(NullUtil.nullString(request.getParameter("ext17")));
					boarddbVO.setExt18(NullUtil.nullString(request.getParameter("ext18")));
					boarddbVO.setExt19(NullUtil.nullString(request.getParameter("ext19")));
					boarddbVO.setExt20(NullUtil.nullString(request.getParameter("ext20")));
				boarddbVO.setTmp3(NullUtil.nullInt(request.getParameter("tmp3"))); //최근게시물 표시
				boarddbVO.setTmp4(infoService.makeTmp4JSON(request, jnitboardinfoVO).toString()); //icon 강제 노출

				if(!"".equals(NullUtil.nullString(request.getParameter("date01")))){
					try{
						if(localVO.getBoardinfoVO().getDate01Opt().equals("date")){
							boarddbVO.setDate01(sdfDate.parse(request.getParameter("date01")));
						}else if(localVO.getBoardinfoVO().getDate01Opt().equals("datetime")){
							boarddbVO.setDate01(sdfDatetime.parse(request.getParameter("date01")));
						}
					} catch (NullPointerException e){
						log.error(e.getMessage());
					}catch(Exception e){
						log.error(e.getMessage());
					}
				}
				if(!"".equals(NullUtil.nullString(request.getParameter("date02")))){
					try{
						if(localVO.getBoardinfoVO().getDate02Opt().equals("date")){
							boarddbVO.setDate02(sdfDate.parse(request.getParameter("date02")));
						}else if(localVO.getBoardinfoVO().getDate02Opt().equals("datetime")){
							boarddbVO.setDate02(sdfDatetime.parse(request.getParameter("date02")));
						}
					} catch (NullPointerException e){
						log.error(e.getMessage());
					}catch(Exception e){
						log.error(e.getMessage());
					}
				}
				if(request.getParameter("hit") != null)
					boarddbVO.setHit(NullUtil.nullInt(request.getParameter("hit")));
				if(request.getParameter("writer") != null)
					boarddbVO.setWriter(NullUtil.nullString(request.getParameter("writer")));

				//2014-07-21 by.나성재 수정 익명글은 mbr_id = null
				if(!"".equals(NullUtil.nullString(localVO.getLoginVO().getMbrId()))) boarddbVO.setMbrId(localVO.getLoginVO().getMbrId());

				if(!"".equals(NullUtil.nullString(request.getParameter("created")))){
					try{
						boarddbVO.setCreated(sdfDatetime.parse(request.getParameter("created")));
					} catch (NullPointerException e){
						log.error(e.getMessage());
					}catch(Exception e){
						log.error(e.getMessage());
					}
				}

				/**
				 * MediaEx 연계
				 */
				if(localVO.getBoardinfoVO().getBoardType().contains("media")){
					String imageSrc = "http://"+mediaExHost.trim()+":2935/"+boarddbVO.getExt18()+"_"+boarddbVO.getExt20()+".png";
					String attachFilePath = MEDIA_UPLOAD_PATH + SEPERATOR + boarddbVO.getExt18()+"_"+ boarddbVO.getExt20() +".jpg";
					URL voImageURL = new URL(imageSrc);

					//이미지에 해당하는 url을 통하여 커넥션을 진행
					HttpURLConnection voImageReponse = (HttpURLConnection) voImageURL
					        .openConnection();

					//200_OK 응답에 대해서만 처리
					if (voImageReponse.getResponseCode() == HttpURLConnection.HTTP_OK) {
					    InputStream is = voImageReponse.getInputStream();

					    //응답 코드를 C:\1.jpg에 저장

					    FileOutputStream fos = new FileOutputStream(attachFilePath);
					    BufferedInputStream bis = new BufferedInputStream(is);
					    BufferedOutputStream bos = new BufferedOutputStream(fos);

					    //응답 코드를 1024바이트 단위로 저장
					    int len = 0;
					    byte[] buf = new byte[1024];
					    while ((len = bis.read(buf, 0, 1024)) != -1) {
					        bos.write(buf, 0, len);
					        bos.flush();
					    }
					    if(fos != null) try{fos.close();}catch(IOException e){log.error(e.getMessage());}
					    if(bis != null) try{bis.close();}catch(IOException e){log.error(e.getMessage());}
					    if(bos != null) try{bos.close();}catch(IOException e){log.error(e.getMessage());}
					} else {
					    log.debug("connection failed. code is : "
					            + voImageReponse.getResponseCode());
					    log.debug("failed connection url : " + voImageReponse.getURL());
					}
					String physical = boarddbVO.getExt18() +boarddbVO.getExt20() +".jpg";
					String thumbFilePath = MEDIA_UPLOAD_PATH + "thumb_" + physical;

					java.io.File thumbFile = new File(thumbFilePath);

					if(!thumbFile.exists()) {
						ThumbnailUtil.createThumbnail(attachFilePath, thumbFile.getPath(), 150);
						thumbFile = new File(thumbFilePath);
					}
				}

				jnitboarddbService.update(boarddbVO);
				//bbs_1000000000000000 게시판
				JnitboarddbVO latestVO = boarddbVO;
				latestVO.setTmp1(boarddbVO.getBoardId());
				latestVO.setTmp2(Integer.toString(boarddbVO.getId()));
				latestVO.setTmp3(boarddbVO.getTmp3());
				latestVO.setBoardId("bbs_1000000000000000");
				latestVO.setUpdateCondition("1");
				jnitboarddbService.update(latestVO);

				String delFileStr = "";
				String[] delFiles = request.getParameterValues("delFile");
				if(delFiles != null){
					for(int i=0; i<delFiles.length; i++){
						String fileId = delFiles[i];
						JnitboardfileVO fileVO = new JnitboardfileVO();
						fileVO.setFileId(fileId);
						fileVO = fileService.selectJnitboardfile(fileVO);
						if(fileVO.getBoardCntId() == boarddbVO.getId() && boardId.equals(fileVO.getBoardId())){
							fileService.deleteJnitboardfile(fileVO);
						}
						delFileStr += (!"".equals(delFileStr) ? "," : "")+fileId;
					}
				}

				//파일첨부 alt수정
				if(localVO.getBoardinfoVO().getUseFile()==1){
					JnitboardfileDefaultVO fileDefaultVO = new JnitboardfileDefaultVO();
					fileDefaultVO.setSearchCondition("1");
					fileDefaultVO.setSearchKeyword(boardId);
					int totcnt = fileService.selectJnitboardfileListTotCnt(fileDefaultVO);
					for(int i = 1; i<=totcnt; i++){
						String fileId = NullUtil.nullString(request.getParameter("fileAltId"+i));
						String fileAlt = NullUtil.nullString(request.getParameter("fileAlt"+i));
						if(!fileId.equals("")){

						JnitboardfileVO fileVO = new JnitboardfileVO();
						fileVO.setFileId(fileId);
						fileVO = fileService.selectJnitboardfile(fileVO);
						fileVO.setExt01(fileAlt);
						fileService.updateJnitboardfile(fileVO);
						}
					}
				}

				//메인파일 alt 수정
				String mainFileAltId = NullUtil.nullString(request.getParameter("mainFileAltId"));
				String mainFileAlt = NullUtil.nullString(request.getParameter("mainFileAlt"));
				Boolean insert = false;
				if(!"".equals(mainFileAltId)){
					JnitboardfileVO fileVO = new JnitboardfileVO();
					fileVO.setFileId(mainFileAltId);
					fileVO.setExt01(mainFileAlt);
					fileVO.setUpdateCondition("2");
					fileService.updateJnitboardfile(fileVO);
				}

				//첨부파일 처리
				String upPath = BOARD_UPLOAD_PATH+SEPERATOR+boardId;
				HashMap<String, EgovFormBasedFileVo> fileList = EgovFileUploadUtil.uploadFormFiles(request, upPath, maxFileSize);
				Iterator fileItr = fileList.keySet().iterator();
				int sortKey = 1;
				while(fileItr.hasNext()){
					mainFileAltId = NullUtil.nullString(request.getParameter("mainFileAltId"));
					if(delFileStr.indexOf(mainFileAltId) > -1) mainFileAltId = "";
					String key = (String)fileItr.next();
					EgovFormBasedFileVo item = (EgovFormBasedFileVo)fileList.get(key);
					JnitboardfileVO fileVO = new JnitboardfileVO();
					fileVO.setBoardId(boardId);
					fileVO.setBoardCntId(boarddbVO.getId());
					fileVO.setFileNm(item.getPhysicalName());
					fileVO.setFileOnm(item.getFileName());
					fileVO.setFilePath(item.getServerSubPath());
					fileVO.setFileSize(item.getSize());

					if(!NullUtil.nullString(request.getParameter("upfileAlt"+(sortKey))).equals("")){
						fileVO.setExt01(request.getParameter("upfileAlt"+(sortKey)));
					}

					//메인파일
					if("mainfile".equals(key)){
						if(!NullUtil.nullString(request.getParameter("mainFileAlt")).equals("")){
							fileVO.setExt01(request.getParameter("mainFileAlt"));
						}
						fileVO.setIsmain(1);
					}else if("moviefile".equals(key)){
						fileVO.setIsmain(2);
						//동영상
						if(!NullUtil.nullString(request.getParameter("fileAlt"+(sortKey))).equals("")){
							fileVO.setExt01(request.getParameter("fileAlt"+(sortKey)));
						}
						if(!NullUtil.nullString(request.getParameter("fileAltId"+sortKey)).equals("")){
							mainFileAltId = NullUtil.nullString(request.getParameter("fileAltId"+sortKey));
							if(delFileStr.indexOf(mainFileAltId) > -1) mainFileAltId = "";
						}
					}

					//파일 존재시
					if(item.getSize() > 0){
						if("mainfile".equals(key) || "moviefile".equals(key)){
							if(!"".equals(mainFileAltId)){
								fileVO.setFileId(mainFileAltId);
								String fileUrl = "/board/file/" + fileVO.getBoardId() + "/" + String.valueOf(fileVO.getBoardCntId()) + "/" + mainFileAltId + "/" + fileVO.getFileNm();
								fileVO.setFileUrl(fileUrl);
								fileService.updateJnitboardfile(fileVO);
							}else{
								fileService.insertJnitboardfile(fileVO);
							}
						}else {
							if(localVO.getBoardinfoVO().getUseFile()==1){
								fileService.insertJnitboardfile(fileVO);
							}
						}
					}
					sortKey = sortKey+1;
				}
				//위지윅에디터 이미지 처리
				if(localVO.getBoardinfoVO().getUseImage()==1){
					JnitboardfileVO fileVO = new JnitboardfileVO();
					fileVO.setBoardId(boardId);
					fileVO.setBoardCntId(boarddbVO.getId());
					//fileService.deleteJnitboardfileWyswyg(fileVO); // TODO : board.js의 setModify()함수에 allattachments 구현하믄...
					if(request.getParameterValues("tx_attach_image[]") != null ){
						String[] images = (String[])request.getParameterValues("tx_attach_image[]");
						fileVO = new JnitboardfileVO();
						String fileid = "";
						for(int i = 0; i<images.length;i++){
							fileVO = new JnitboardfileVO();
							fileid = images[i];
							fileVO.setFileId(fileid);
							fileVO = fileService.selectJnitboardfile(fileVO);
							fileVO.setBoardId(boardId);
							fileVO.setBoardCntId(boarddbVO.getId());
							fileVO.setExt01("");
					    	String fileExp = "";
					    	try{
						    	String fileDot[] = fileVO.getFileOnm().split("\\.");
						    	fileExp = "."+fileDot[fileDot.length-1];
					    	} catch (NullPointerException e){
					    		fileExp = "";
					    	}catch(Exception e){
					    		fileExp = "";
					    	}
					    	String fileNm = new String(new Base64(true).encode(fileVO.getFileOnm().getBytes()));
							String fileUrl = "/board/file/" + fileVO.getBoardId() + "/" + String.valueOf(fileVO.getBoardCntId()) + "/" + fileVO.getFileId() + "/" + fileNm + fileExp;
							fileVO.setFileUrl(fileUrl);
							fileService.updateJnitboardfile(fileVO);
						}
					}
				}

				if(localVO.getBoardinfoVO().getUseFile() == 2){
					String fileIds = NullUtil.nullString(request.getParameter("fileuploadList"));
					String[] fileId = fileIds.split(",");
					for(int i=0;i<fileId.length;i++ ){
						JnitboardfileVO fileVO = new JnitboardfileVO();
						if(!fileId[i].equals("")){
							fileVO.setFileId(fileId[i]);
							fileVO = fileService.selectJnitboardfile(fileVO);
							fileVO.setBoardId(boardId);
							fileVO.setBoardCntId(boarddbVO.getId());
							String fileUrl = "/board/file/" + boardId + "/" + boarddbVO.getId() + "/" + fileId[i] + "/" + fileVO.getFileNm();
							fileVO.setFileUrl(fileUrl);
							fileService.updateJnitboardfile(fileVO);
						}

					}
				}
			}else{
				if(passwdFalse){
					model.addAttribute("proc","edit");
					model.addAttribute("cntId",boarddbVO.getId());
					model.addAttribute("NoPasswd", isLanguage("올바르지 않은 암호입니다.", lang));
				}else{
					model.addAttribute("error", isLanguage("수정 할 권한이 없습니다.", lang));
				}

			}


	    	model.addAttribute("boarddbVO" , boarddbVO);

		}

		if("delete".equals(proc)){

			JnitboarddbVO dbVO = new JnitboarddbVO();
			dbVO.setBoardId(boardId);
			dbVO.setId(NullUtil.nullInt(request.getParameter("cntId")));
			dbVO = jnitboarddbService.selectAnonymous(dbVO);
			//bbs_1000000000000000 게시판

			if(dbVO.getIsSecret() == 1){
				model.addAttribute("isSecret", "true");
				return model;
			}

			if(NullUtil.nullString(dbVO.getMbrId()).equals("") && !localVO.getIsAdmin()){
				String password = NullUtil.nullString(request.getParameter("yourinput"));
				if(!password.equals("")){
					password = EgovFileScrty.encryptPassword(password);
					if(dbVO.getPassword().equals(password)){
						jnitboarddbService.delete(dbVO);
						//bbs_1000000000000000 게시판
						JnitboarddbVO latestVO = dbVO;
						latestVO.setTmp1(dbVO.getBoardId());
						latestVO.setTmp2(Integer.toString(dbVO.getId()));
						latestVO.setTmp3(dbVO.getTmp3());
						latestVO.setBoardId("bbs_1000000000000000");
						latestVO.setDeleteCondition("1");
						jnitboarddbService.delete(latestVO);
					}else{
						model.addAttribute("NoPasswd", isLanguage("올바르지 않은 암호입니다.", lang));
					}
				}else{
					model.addAttribute("NoPasswd", isLanguage("암호를 입력하셔야 합니다.", lang));
					model.addAttribute("proc","delete");
					model.addAttribute("cntId",NullUtil.nullInt(request.getParameter("cntId")));
					this.isSecretCheck(boardId, request, model);
					return model;
				}
			}else{
				//삭제
				if(localVO.getIsAdmin() || NullUtil.nullString(localVO.getLoginVO().getMbrId()).equals(dbVO.getMbrId())){
					jnitboarddbService.delete(dbVO);
					//bbs_1000000000000000 게시판
					JnitboarddbVO latestVO = dbVO;
					latestVO.setTmp1(dbVO.getBoardId());
					latestVO.setTmp2(Integer.toString(dbVO.getId()));
					latestVO.setTmp3(dbVO.getTmp3());
					latestVO.setBoardId("bbs_1000000000000000");
					latestVO.setDeleteCondition("1");
					jnitboarddbService.delete(latestVO);

					JnitboardfileVO fileVO = new JnitboardfileVO();
					fileVO.setBoardId(boardId);
					fileVO.setBoardCntId(dbVO.getId());
					fileService.deleteJnitboardfileWyswyg(fileVO);
				}else{
					model.addAttribute("NoPasswd", isLanguage("권한이 없습니다.", lang));
				}
			}
		}

		if("recovery".equals(proc)){
			JnitboarddbVO dbVO = new JnitboarddbVO();
			dbVO.setBoardId(boardId);
			dbVO.setId(NullUtil.nullInt(request.getParameter("cntId")));
			dbVO = jnitboarddbService.selectAnonymous(dbVO);


			//복구
			if(localVO.getIsAdmin()){
				jnitboarddbService.recovery(dbVO);

				//bbs_1000000000000000 게시판
				JnitboarddbVO latestVO = dbVO;
				latestVO.setTmp1(dbVO.getBoardId());
				latestVO.setTmp2(Integer.toString(dbVO.getId()));
				latestVO.setTmp3(dbVO.getTmp3());
				latestVO.setBoardId("bbs_1000000000000000");
				latestVO.setRecoveryCondition("1");
				jnitboarddbService.recovery(latestVO);
			}
		}

		if("allDelete".equals(proc)){
			jnitboarddbService.dataDeleteAll(boardId,NullUtil. nullInt(request.getParameter("cntId")));
		}

		String retUrl = NullUtil.nullString(request.getParameter("retUrl"));
		model.addAttribute("returnPath", retUrl);
		//최근 게시물 업데이트
		jnitBoardDataService.latestBoardDataUpdate(request, boardId);
		return model;
	}

	@RequestMapping("/cms/board/delProc.do")
	public String boardDataDelete(HttpServletRequest request
			, @RequestParam("boardId") String boardId
			, Model model) throws Exception{

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);

		String inputMsg = NullUtil.nullString(request.getParameter("inputMsg"));
		String confirmMsg = NullUtil.nullString(request.getParameter("confirmMsg"));
		String remoteIp = NullUtil.nullString(request.getRemoteAddr());
		String mbrId = NullUtil.nullString(mbrVO.getMbrId());
		String mbrLogin = NullUtil.nullString(mbrVO.getMbrLogin());
		String eventTime = NullUtil.nullString(format.format(Calendar.getInstance().getTime()));

		if(mbrVO == null){
			model.addAttribute("alert", "로그인후에 이용해주세요.");
			return "/jnit/util/alertBack";
		}else if(!inputMsg.equals(confirmMsg)){
			model.addAttribute("alert", "삭제확인 메세지의 입력값이 다릅니다.");
			return "/jnit/util/alertBack";
		}

		JnitboarddbVO dbVO = new JnitboarddbVO();
		JnitboardfileVO fileVO = new JnitboardfileVO();

		dbVO.setBoardId(boardId);
		fileVO.setBoardId(boardId);
		if("true".equals(debug)){
			log.debug("------------------------BOARD_DATA_DELETE_INFOMATION------------------------");
			log.debug("BoardDeleteInfo / boardId : " + boardId + " / mbrId : " + mbrId + " / mbrLogin : " + mbrLogin + " / remoteIp : " + remoteIp + " / eventTime : " + eventTime);
			log.debug("----------------------------------------------------------------------------");
		}
		try{
			jnitboarddbService.deleteAll(dbVO);
			fileService.deleteJnitboardfileBoard(fileVO);
			JnitboarddbVO latestVO = dbVO;
			latestVO.setTmp1(dbVO.getBoardId());
			latestVO.setBoardId("bbs_1000000000000000");
			latestVO.setIsdelYn("N");
			latestVO.setDeleteCondition("1");
			jnitboarddbService.delete(latestVO);
		} catch (NullPointerException e){
			log.error(e.getMessage());
			log.debug("Baord Delete Error");
			model.addAttribute("alert", "삭제처리에 오류가 생겨 처리하지 못했습니다.");
			model.addAttribute("path", "/cms/board/list.do");
			return "/jnit/util/alertMove";
		}catch(Exception e){
			log.error(e.getMessage());
			log.debug("Baord Delete Error");
			model.addAttribute("alert", "삭제처리에 오류가 생겨 처리하지 못했습니다.");
			model.addAttribute("path", "/cms/board/list.do");
			return "/jnit/util/alertMove";
		}
		log.debug("Baord Delete Success");

		model.addAttribute("alert", "정상처리되었습니다.");
		model.addAttribute("path", "/cms/board/list.do");
		return "/jnit/util/alertMove";
		//return "redirect:"+request.getHeader("referer");
	}

	@RequestMapping("/broad/pupup.do")
	public String boardPupup(HttpServletRequest request, ModelMap model)throws Exception{
		String boardId = NullUtil.nullString(request.getParameter("boardId"));

		JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
		try {
			jnitboardinfoVO = JnitboardinfoController.getBoardInfoVO(request, boardId);
		}catch (FileNotFoundException e){
			jnitboardinfoVO.setBoardId(boardId);
			try {
				jnitboardinfoVO = infoService.selectJnitboardinfo(jnitboardinfoVO);
			} catch (NullPointerException e2){
				log.error(e2.getMessage());
			} catch (Exception e2) {
				log.error(e2.getMessage());
			}
		}catch (Exception e) {
			log.error(e.getMessage());
		}
		//쓰기 권한체크
		LocalVO localVO = new LocalVO();
		localVO.setBoardinfoVO(jnitboardinfoVO);
		String[] adminLVs = localVO.getBoardinfoVO().getAdmList().toUpperCase().replaceAll("'", "").split(",");
		String adminLV = "";
		for (int i = 0; i < adminLVs.length; i++) {
			if (!adminLVs[i].isEmpty()) {
				adminLV = adminLV + "," + "'" + adminLVs[i].toString()+ "'";
			}
		}
		adminLV = adminLV.replaceFirst(",", "");		
		//게시판 권한설정
		localVO = boardAccess(request, model, localVO, adminLV);
		if(!localVO.getPermWrite()){
			model.addAttribute("json", "false");
			return "/jnit/util/json";
		}
		model.addAttribute("lang", jnitboardinfoVO.getUseLanguage());
		model.addAttribute("jnitboardinfoVO", jnitboardinfoVO);
		return "/jnit/board/imageUploadPupUp";
	}

	@RequestMapping("/board/img/upload.do")
	public String boardImgUpload(HttpServletRequest request, ModelMap model)throws Exception{
		String root = PathUtil.getRealPath(request);
		String uploadDir = EgovProperties.getProperty("Globals.fileStorePath")+"editUpload/";
		String boardId = NullUtil.nullString(request.getParameter("boardId"));

		JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
		try {
			jnitboardinfoVO = JnitboardinfoController.getBoardInfoVO(request, boardId);
		}catch (FileNotFoundException e){
			jnitboardinfoVO.setBoardId(boardId);
			jnitboardinfoVO = infoService.selectJnitboardinfo(jnitboardinfoVO);
		}catch (Exception e) {
			log.error(e.getMessage());
		}
		//쓰기 권한체크
		LocalVO localVO = new LocalVO();
		localVO.setBoardinfoVO(jnitboardinfoVO);
		String[] adminLVs = localVO.getBoardinfoVO().getAdmList().toUpperCase().replaceAll("'", "").split(",");
		String adminLV = "";
		for (int i = 0; i < adminLVs.length; i++) {
			if (!adminLVs[i].isEmpty()) {
				adminLV = adminLV + "," + "'" + adminLVs[i].toString()+ "'";
			}
		}
		adminLV = adminLV.replaceFirst(",", "");		
		//게시판 권한설정
		localVO = boardAccess(request, model, localVO, adminLV);
		if(!localVO.getPermWrite()){
			model.addAttribute("json", "false");
			return "/jnit/util/json";
		}
		
		if(StringUtil.isExistString(request.getRequestURL().toString(), "local")){
			uploadDir = root +"upload/editUpload/";
		}
		File file = new File(uploadDir);
		if(!file.exists()){
			file.mkdirs();
		}

		int maxFileSize = 1024 * 1024 * 100;
		HashMap<String, EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFormFiles(request, uploadDir, maxFileSize);
		JSONObject JSON = new JSONObject();
		
		//허용되지 않은 파일을 업로드 했을때 오류 유도(사용자 페이지에서 확장자 체크하는 스크립트를 변조해서 들어왔을때 발생)
		if(list.containsKey("isError")){
			model.addAttribute("json", "isError");
			return "/jnit/util/json";
		}
		if(list.get("imgFile") != null){
			EgovFormBasedFileVo vo = list.get("imgFile");
			

			JSON.put("src", "upload/editUpload/"+vo.getServerSubPath()+"/"+vo.getPhysicalName());
			JSON.put("width", NullUtil.nullString(request.getParameter("imgWidth")));
			JSON.put("height", NullUtil.nullString(request.getParameter("imgHeight")));
			String alt = NullUtil.nullString(request.getParameter("imgalt"));
			if(alt.equals("")){
				JSON.put("alt", vo.getFileName()+isLanguage(" 이미지입니다.", jnitboardinfoVO.getUseLanguage()));
			}else{
				JSON.put("alt", alt);
			}

			String imgDir = uploadDir + vo.getServerSubPath()+"/"+vo.getPhysicalName();
			try {
				BufferedImage image = ImageIO.read(new File(imgDir));
				if(image != null){
					Integer width = image.getWidth();
					width = (width == null ? 0 : width);
					Integer height = image.getWidth();
					height = (height == null ? 0 : height);
					
					if("".equals(JSON.get("width"))) JSON.put("width", image.getWidth());
					if("".equals(JSON.get("height"))) JSON.put("height", image.getHeight());
				}
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (IIOException e) { //not read file
				log.error(e.getMessage());
			}
		}

		model.addAttribute("json", JSON.toString());
		return "/jnit/util/json";
	}

	@RequestMapping("/board/ajax/cmt.do")
	public String boardAjaxCmt(HttpServletRequest request, ModelMap model)throws Exception{
		String boardId = NullUtil.nullString(request.getParameter("boardId"));
		String cmtsubmitText = NullUtil.nullString(request.getParameter("cmtsubmit_text"));
		String cmtId = NullUtil.nullString(request.getParameter("cmtId"));
		if(!"".equals(cmtId)) cmtsubmitText = NullUtil.nullString(request.getParameter("cmtEditarea"));
		int cntId = NullUtil.nullInt(request.getParameter("cntId"));
		String type = NullUtil.nullString(request.getParameter("type"));
		String message = "";
		JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		LocalVO localVO = new LocalVO();
		String[] boardIds = boardId.split(",");
		boardId = boardIds[0];

		JnitboardinfoVO jnitboardinfoVO = new JnitboardinfoVO();
		jnitboardinfoVO.setBoardId(boardId);
		jnitboardinfoVO = infoService.selectJnitboardinfo(jnitboardinfoVO);
		try{
			localVO.setBoardinfoVO(JnitboardinfoController.getBoardInfoVO(request, boardId));
		}catch(FileNotFoundException e){
			log.error(e.getMessage());
			localVO.setBoardinfoVO(jnitboardinfoVO);
    		JSONObject infoJson = new JSONObject().fromObject(jnitboardinfoVO);
    		File infoDir = new File(JnitboardinfoController.getBoardInfoPath(request));
    		String infoPath =  JnitboardinfoController.getBoardInfoPath(request) + boardId.toUpperCase() + ".json";
    		if(!infoDir.exists()){
    			infoDir.mkdir();
    		}
    		FileWriter infoFileW = new FileWriter(infoPath);
    		infoFileW.write(infoJson.toString());
    		infoFileW.flush();
    		infoFileW.close();
		}catch(Exception e){
			localVO.setBoardinfoVO(jnitboardinfoVO);
			log.error(e.getMessage());
		}
		String[] adminLVs = localVO.getBoardinfoVO().getAdmList().toUpperCase().replaceAll("'", "").split(",");
		String adminLV = "";
		for (int i = 0; i < adminLVs.length; i++) {
			if (!adminLVs[i].isEmpty()) {
				adminLV = adminLV + "," + "'" + adminLVs[i].toString()+ "'";
			}
		}
		adminLV = adminLV.replaceFirst(",", "");
		//게시판 권한설정
		localVO = boardAccess(request, model, localVO, adminLV);

		JnitboardcmtVO cmtVO = new JnitboardcmtVO();
		cmtVO.setMbrId(loginVO.getMbrId());
		if(!"".equals(cmtsubmitText)){
			if("".equals(cmtId)){
				cmtVO.setBoardId(boardId);
				cmtVO.setBoardCntId(NullUtil.nullInt(request.getParameter("cntId")));
				cmtVO.setCmtText(cmtsubmitText);
				jnitboardcmtService.insertJnitboardcmt(cmtVO);
				message = isLanguage("정상처리 되었습니다.", lang);
			}else{
				cmtVO.setCmtId(cmtId);
				cmtVO.setCmtText(cmtsubmitText);
				cmtVO.setUpdateCondition("1");
				jnitboardcmtService.updateJnitboardcmt(cmtVO);
				message = isLanguage("수정 되었습니다.", lang);
			}
		}else if("delete".equals(type)){
			cmtVO.setCmtId(cmtId);
			jnitboardcmtService.deleteJnitboardcmt(cmtVO);
			message = isLanguage("삭제 되었습니다.", lang);
		}

		HashMap<String, String> permMap = new HashMap<String, String>();
		JnitboardcmtDefaultVO cmtDefaultVO = new JnitboardcmtDefaultVO();
		cmtDefaultVO.setCmtBoardId(boardId);
		cmtDefaultVO.setCmtBoardCntId(cntId);
		cmtDefaultVO.setSearchCondition("2");
		if(jnitboardcmtService.selectJnitboardcmtListTotCnt(cmtDefaultVO) >0){
			List cmtList = jnitboardcmtService.selectJnitboardcmtList(cmtDefaultVO);

			if(DBType.getDbTypeBoolean("oracle")){
				HashMap<String, String> cmtMap = new HashMap<String, String>();
				Iterator resultIterator = cmtList.iterator();
				for(int i=0; i<cmtList.size(); i++){
					EgovMap resultEgovMap = (EgovMap) resultIterator.next();

					String strId = String.valueOf(resultEgovMap.get("cmtId"));
					CLOB content = (CLOB) resultEgovMap.get("cmtText");
					if(content != null){
						StringBuffer sb = new StringBuffer();
						try {
							Reader reader = content.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);

							String line = "";
							while ((line = br.readLine()) != null) {
								sb.append(line+"\r\n");
							}
							br.close();
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						cmtMap.put(strId, sb.toString());
					}
				}
				model.addAttribute("cmtMap", cmtMap);
			}else if(DBType.getDbTypeBoolean("tibero")){
				HashMap<String, String> cmtMap = new HashMap<String, String>();
				Iterator resultIterator = cmtList.iterator();
				for(int i=0; i<cmtList.size(); i++){
					EgovMap resultEgovMap = (EgovMap) resultIterator.next();

					String strId = String.valueOf(resultEgovMap.get("cmtId"));
					com.tmax.tibero.jdbc.TbClob content = (com.tmax.tibero.jdbc.TbClob) resultEgovMap.get("cmtText");
					if(content != null){
						StringBuffer sb = new StringBuffer();
						try {
							Reader reader = content.getCharacterStream();
							BufferedReader br = new BufferedReader(reader);

							String line = "";
							while ((line = br.readLine()) != null) {
								sb.append(line+"\r\n");
							}
							br.close();
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						}
						cmtMap.put(strId, sb.toString());
					}
				}
				model.addAttribute("cmtMap", cmtMap);
			}
			model.addAttribute("cmtList", cmtList);

			//2015-02-15 by.나성재 isMine 자기자신글 체크
			Iterator cmsListItr = cmtList.iterator();
			for(int i=0; i<cmtList.size(); i++){
				EgovMap cmtListMap = (EgovMap) cmsListItr.next();
				String permCmtId = (String) cmtListMap.get("cmtId");
				String permisMine = (String) cmtListMap.get("mbrId");
				permMap.put(permCmtId, permisMine);
			}
			model.addAttribute("permMap", permMap);
		}


		//게시판 DB
		JnitboarddbVO boarddbVO = new JnitboarddbVO();
		boarddbVO.setBoardId(boardId);
		boarddbVO.setId(NullUtil.nullInt(request.getParameter("cntId")));
		boarddbVO = jnitboarddbService.selectAnonymous(boarddbVO);

		Boolean mobileMode = "true".equals(NullUtil.nullString(request.getParameter("isMobile"))) ? true : false;
		boardstaticVO.setIsMobile(mobileMode);
		model.addAttribute("mobileMode", mobileMode);

		model.addAttribute("DBType", DBType.getDbTypeString());
		if(!"".equals(message)) model.addAttribute("message", message);
		model.addAttribute("result", boarddbVO);
		model.addAttribute("myId",loginVO.getMbrId());
		model.addAttribute("boardinfoVO", jnitboardinfoVO);
		model.addAttribute("permList", localVO.getPermList()); //목록접근권한
		model.addAttribute("permView", localVO.getPermView()); //보기접근권한
		model.addAttribute("permWrite", localVO.getPermWrite()); //쓰기접근권한
		model.addAttribute("permCmt", localVO.getPermCmt()); //댓글쓰기접근권한
		model.addAttribute("isAdmin", localVO.getIsAdmin()); //관리자
		model.addAttribute("adminLV", adminLV); //관리자권한
		return "/jnit/board/board_cmt";
	}

	@RequestMapping("/board/ajax/file/downloadCount.do")
    public String downloadCount(HttpServletRequest request, ModelMap model)throws Exception{
    	String fileId = NullUtil.nullString(request.getParameter("fileId"));
    	JSONObject JSON = new JSONObject();
    	LocalVO localVO = new LocalVO();
    	JnitboardinfoVO boardInfoVO = new JnitboardinfoVO();
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);

    	if(!"".equals(fileId)){
    		JnitboardfileVO jnitboardfileVO = new JnitboardfileVO();
    		jnitboardfileVO.setFileId(fileId);
    		try {
    			jnitboardfileVO = jnitboardfileService.selectJnitboardfile(jnitboardfileVO);
        		boardInfoVO.setBoardId(jnitboardfileVO.getBoardId());
        		boardInfoVO = infoService.selectJnitboardinfo(boardInfoVO);
        		localVO.setBoardinfoVO(boardInfoVO);
        		localVO.setLoginVO(loginVO);
        		String[] adminLVs = NullUtil.nullString(localVO.getBoardinfoVO().getAdmList()).toUpperCase().replaceAll("'", "").split(",");
        		String adminLV = "";
        		for (int i = 0; i < adminLVs.length; i++) {
        			if (!adminLVs[i].isEmpty()) {
        				adminLV = adminLV + "," + "'" + adminLVs[i].toString()+ "'";
        			}
        		}
        		adminLV = adminLV.replaceFirst(",", "");
        		//게시판 권한설정
        		localVO = boardAccess(request, model, localVO, adminLV);
    			if(!localVO.getPermFileDown()){
    				if(loginVO.getMbrId() == null && !"".equals(NullUtil.nullString(localVO.getBoardinfoVO().getPermFileDown()))){
            			JSON.put("message", "FIAL 2");
        			}else{
        				JSON.put("message", "FIAL 1");
        			}
        			model.addAttribute("json", JSON.toString());
        			return "/jnit/util/json";
        		}
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
    		jnitboardfileVO.setFileDownloadCount(NullUtil.nullInt(Integer.toString(jnitboardfileVO.getFileDownloadCount()))+1);
	    	jnitboardfileVO.setUpdateCondition("1");
	    	jnitboardfileService.updateJnitboardfile(jnitboardfileVO);
	    	JSON.put("status", "success");
	    	JSON.put("count", jnitboardfileVO.getFileDownloadCount());
    	}
    	model.addAttribute("json", JSON.toString());
    	return "/jnit/util/json";
    }


	/**
	 * 게시판 권한 설정
	 * @param request
	 * @param model
	 * @param localVO
	 * @return modelAttribute
	 * @throws Exception
	 * {@link JnitboardController#board}
	 * {@link JnitboardController#boardAjaxCmt}
	 */
	public LocalVO boardAccess(HttpServletRequest request
			, ModelMap model
			, LocalVO localVO
			, String adminLV )throws Exception{
		localVO.setLoginVO((JnitcmsmbrVO)CmsHelper.getAuthMbr(request));

		HashMap<String, String> lvResult = null;
		JnitdbVO dbVO = new JnitdbVO();
		if(localVO.getLoginVO().getMbrId() != null){
			dbVO.setQuery("SELECT b.TYPE_LV as MBR_LV FROM JNITCMSMBR a, JNITCMSMBRTYPE b WHERE a.ISDEL=0 AND a.MBR_ID='"
					+ localVO.getLoginVO().getMbrId() + "' AND b.TYPE_ID=a.TYPE_ID");
			try {
				lvResult = (HashMap<String, String>) dbService.select(dbVO);
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}

		if (lvResult != null) {
			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermList().toCharArray()[0]) {
				localVO.setPermList(false);
			} else {
				localVO.setPermList(true);
			}

			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermView().toCharArray()[0]) {
				localVO.setPermView(false);
			} else {
				localVO.setPermView(true);
			}

			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermWrite().toCharArray()[0]) {
				localVO.setPermWrite(false);
			} else {
				localVO.setPermWrite(true);
			}

			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermReply().toCharArray()[0]) {
				localVO.setPermReply(false);
			} else {
				localVO.setPermReply(true);
			}

			if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int) localVO.getBoardinfoVO().getPermCmt().toCharArray()[0]) {
				localVO.setPermCmt(false);
			} else {
				localVO.setPermCmt(true);
			}
			try {
				if(localVO.getBoardinfoVO().getPermFileDown() != null  && !localVO.getBoardinfoVO().getPermFileDown().trim().equals("")){
					if ((int) lvResult.get("MBR_LV").toCharArray()[0] > (int)localVO.getBoardinfoVO().getPermFileDown().toCharArray()[0]) {
						localVO.setPermFileDown(false);
					} else {
						localVO.setPermFileDown(true);
					}
				}
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		} else {
			if (localVO.getBoardinfoVO().getAnonPermList() == 1) {
				localVO.setPermList(true);
			}
			if (localVO.getBoardinfoVO().getAnonPermView() == 1) {
				localVO.setPermView(true);
			}
			if (localVO.getBoardinfoVO().getAnonPermWrite() == 1) {
				localVO.setPermWrite(true);
			}
			if(!"".equals(NullUtil.nullString(localVO.getBoardinfoVO().getPermFileDown()))){
				localVO.setPermFileDown(false);
			}
		}
		String permListType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermListType()).split(",");
		if(StringUtil.isExistArray(permListType, localVO.getLoginVO().getTypeId())){
			localVO.setPermList(true);
		}
		String permViewType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermViewType()).split(",");
		if(StringUtil.isExistArray(permViewType, localVO.getLoginVO().getTypeId())){
			localVO.setPermView(true);
		}
		String permWriteType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermWriteType()).split(",");
		if(StringUtil.isExistArray(permWriteType, localVO.getLoginVO().getTypeId())){
			localVO.setPermWrite(true);
		}
		String permReplyType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermReplyType()).split(",");
		if(StringUtil.isExistArray(permReplyType, localVO.getLoginVO().getTypeId())){
			localVO.setPermReply(true);
		}

		String permCmtType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermCmtType()).split(",");
		if(StringUtil.isExistArray(permCmtType, localVO.getLoginVO().getTypeId())){
			localVO.setPermCmt(true);
		}
		if(!"".equals(NullUtil.nullString(localVO.getBoardinfoVO().getPermFileDownType()))){
			String permFileDownType[] = NullUtil.nullString(localVO.getBoardinfoVO().getPermFileDownType()).split(",");
			if(!StringUtil.isExistArray(permFileDownType, localVO.getLoginVO().getTypeId())){
				localVO.setPermFileDown(false);
			}
		}
		// 관리자 권한
		dbVO.setQuery("SELECT COUNT(*) FROM JNITCMSMBRTYPE WHERE TYPE_LV IN ("+adminLV+") AND TYPE_ID='"+localVO.getLoginVO().getTypeId()+"'");

		if(dbService.selectCnt(dbVO) != 0) {
			localVO.setIsAdmin(true);
		}
		String[] admExt = NullUtil.nullString(localVO.getBoardinfoVO().getAdmExt()).split(",");
		if(StringUtil.isExistArray(admExt,localVO.getLoginVO().getMbrId())){
			localVO.setIsAdmin(true);
			localVO.setPermList(true);
			localVO.setPermView(true);
			localVO.setPermWrite(true);
			localVO.setPermReply(true);
			localVO.setPermCmt(true);
			localVO.setPermFileDown(true);
		}
		if("true".equals(debug)){
			log.debug("IsAdmin : " + localVO.getIsAdmin());
			log.debug("PermList : " + localVO.getPermList());
			log.debug("PermView : " + localVO.getPermView());
			log.debug("PermWrite : " + localVO.getPermWrite());
			log.debug("PermReply : " + localVO.getPermReply());
			log.debug("PermCmt : " + localVO.getPermCmt());
			log.debug("PermFileDown : " + localVO.getPermFileDown());
		}
		return localVO;
	}

	/**
	 * 언어선택에 따라 문자열을 치환한다.
	 * @param str - 바꿀문자열
	 * @param lang - 언어종류
	 * @return str
	 * @throws Exception
	 */
	public static String isLanguage(String str, String lang)throws Exception{
		if("목록".equals(str)){
			if("eng".equals(lang)){
				str = "List";
			}else if("chi".equals(lang)){
				str = "目录";
			}else if("japan".equals(lang)){
				str = "表";
			}
		}else if("권한이 없습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Authorized persons only ";
			}else if("chi".equals(lang)){
				str = "无权限";
			}else if("japan".equals(lang)){
				str = "権限がありません。 \\n ログイン認証ページに移動します。";
			}
		}else if("등록".equals(str)){
			if("eng".equals(lang)){
				str = "Registation";
			}else if("chi".equals(lang)){
				str = "注册";
			}else if("japan".equals(lang)){
				str = "注册";
			}
		}else if("답변글 등록".equals(str)){
			if("eng".equals(lang)){
				str = "Answer registration";
			}else if("chi".equals(lang)){
				str = "答复注册";
			}else if("japan".equals(lang)){
				str = "回答文登録";
			}
		}else if("수정".equals(str)){
			if("eng".equals(lang)){
				str = "Correction";
			}else if("chi".equals(lang)){
				str = "修改";
			}else if("japan".equals(lang)){
				str = "水晶";
			}
		}else if("조회".equals(str)){
			if("eng".equals(lang)){
				str = "Search";
			}else if("chi".equals(lang)){
				str = "查看";
			}else if("japan".equals(lang)){
				str = "查找";
			}
		}else if("등록이".equals(str)){
			if("eng".equals(lang)){
				str = "Registered";
			}else if("chi".equals(lang)){
				str = "已注册";
			}else if("japan".equals(lang)){
				str = "登録";
			}
		}else if("수정이".equals(str)){
			if("eng".equals(lang)){
				str = "Modification";
			}else if("chi".equals(lang)){ //
				str = "修改";
			}else if("japan".equals(lang)){
				str = "修正が";
			}
		}else if("삭제가".equals(str)){
			if("eng".equals(lang)){
				str = "Deleted";
			}else if("chi".equals(lang)){
				str = "已删除";
			}else if("japan".equals(lang)){
				str = "削除";
			}
		}else if("복구가".equals(str)){
			if("eng".equals(lang)){
				str = "Restored";
			}else if("chi".equals(lang)){
				str = "已恢复";
			}else if("japan".equals(lang)){
				str = "回復が";
			}
		}else if("패스워드가 올바르지 않습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Invalid password";
			}else if("chi".equals(lang)){
				str = "密码错误";
			}else if("japan".equals(lang)){
				str = "パスワードが正しい正しくない。";
			}
		}else if("조회할 수 있는 권한이 없습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "You have no authority to access";
			}else if("chi".equals(lang)){
				str = "无查看权限";
			}else if("japan".equals(lang)){
				str = "照会する権限がありません。";
			}
		}else if("수정할 수 있는 권한이 없습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "You have no authority to correct";
			}else if("chi".equals(lang)){
				str = "无修改权限";
			}else if("japan".equals(lang)){
				str = "変更する権限がありません。";
			}
		}else if("에 새 게시물이 등록되었습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "New posting is registered";
			}else if("chi".equals(lang)){
				str = "新贴已注册";
			}else if("japan".equals(lang)){
				str = "新しい投稿が登録されました。";
			}
		}else if("올바르지 않은 암호입니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Invalid password";
			}else if("chi".equals(lang)){
				str = "错误密码";
			}else if("japan".equals(lang)){
				str = "正しくないパスワードです。";
			}
		}else if("수정 할 권한이 없습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "You have no authority to correct";
			}else if("chi".equals(lang)){
				str = "无修改权限";
			}else if("japan".equals(lang)){
				str = "変更する権限がありません。";
			}
		}else if("암호를 입력하셔야 합니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Please enter your password";
			}else if("chi".equals(lang)){
				str = "必须输入密码";
			}else if("japan".equals(lang)){
				str = "パスワードを入力する必要があります。";
			}
		}else if("로그인후에 이용해주세요.".equals(str)){
			if("eng".equals(lang)){
				str = "Please use after log-in";
			}else if("chi".equals(lang)){
				str = "请先登录再使用";
			}else if("japan".equals(lang)){
				str = "ログイン後、ご利用ください。";
			}
		}else if("삭제확인 메세지의 입력값이 다릅니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Entered information (for delete confirmation) is different";
			}else if("chi".equals(lang)){
				str = "删除确认信息输入值错误";
			}else if("japan".equals(lang)){
				str = "削除の確認メッセージの入力値が異なります。";
			}
		}else if(" 이미지입니다.".equals(str)){
			if("eng".equals(lang)){
				str = " Images";
			}else if("chi".equals(lang)){
				str = " 图片";
			}else if("japan".equals(lang)){
				str = " イメージです。";
			}
		}else if("숫자만 입력해주시기 바랍니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Enter numbers only";
			}else if("chi".equals(lang)){
				str = "只需输入数字";
			}else if("japan".equals(lang)){
				str = "数字のみを入力して下さい。";
			}
		}else if("사진첨부".equals(str)){
			if("eng".equals(lang)){
				str = "Attach photo";
			}else if("chi".equals(lang)){
				str = "附照片";
			}else if("japan".equals(lang)){
				str = "写真付き";
			}
		}else if("사진 첨부 확인".equals(str)){
			if("eng".equals(lang)){
				str = "Confirmation on photo attachment";
			}else if("chi".equals(lang)){
				str = "附照片确认";
			}else if("japan".equals(lang)){
				str = "写真付き確認";
			}
		}else if("가로".equals(str)){
			if("eng".equals(lang)){
				str = "Width";
			}else if("chi".equals(lang)){
				str = "横向";
			}else if("japan".equals(lang)){
				str = "横";
			}
		}else if("세로".equals(str)){
			if("eng".equals(lang)){
				str = "Height";
			}else if("chi".equals(lang)){
				str = "竖向";
			}else if("japan".equals(lang)){
				str = "縦";
			}
		}else if("취소".equals(str)){
			if("eng".equals(lang)){
				str = "Cancel";
			}else if("chi".equals(lang)){
				str = "取消";
			}else if("japan".equals(lang)){
				str = "取消";
			}
		}else if("이미지 업로드".equals(str)){
			if("eng".equals(lang)){
				str = "Image upload";
			}else if("chi".equals(lang)){
				str = "图片上传";
			}else if("japan".equals(lang)){
				str = "画像をアップロード";
			}
		}else if("완료되었습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Completed";
			}else if("chi".equals(lang)){
				str = "已完成";
			}else if("japan".equals(lang)){
				str = "完了しました。";
			}
		}else if("정말 이미지를 첨부 하시겠습니까?".equals(str)){
			if("eng".equals(lang)){
				str = "Do you really attach the image?";
			}else if("chi".equals(lang)){
				str = "是否附照片？";
			}else if("japan".equals(lang)){
				str = "実際に画像を添付しますか？";
			}
		}else if("선택".equals(str)){ //index.jsp
			if("eng".equals(lang)){
				str = "Select";
			}else if("chi".equals(lang)){
				str = "选择";
			}else if("japan".equals(lang)){
				str = "选择";
			}
		}else if("전체".equals(str)){
			if("eng".equals(lang)){
				str = "All";
			}else if("chi".equals(lang)){
				str = "全部";
			}else if("japan".equals(lang)){
				str = "满";
			}
		}else if("이동".equals(str)){
			if("eng".equals(lang)){
				str = "Move to";
			}else if("chi".equals(lang)){
				str = "移动";
			}else if("japan".equals(lang)){
				str = "满";
			}
		}else if("의 게시글 목록으로".equals(str)){
			if("eng".equals(lang)){
				str = "list composed of"; //This is "Free Posting" list composed of "number and title."
			}else if("chi".equals(lang)){
				str = "的贴子目录是由"; //自由公告栏”的贴子目录是由“序号、标题”组成。
			}else if("japan".equals(lang)){
				str = "职位列表";
			}
		}else if("로 구성되어 있습니다.".equals(str)){
			if("eng".equals(lang)){//
				str = "It is comprised.";
			}else if("chi".equals(lang)){
				str = "标题”组成";
			}else if("japan".equals(lang)){
				str = "由。";
			}
		}else if("공지".equals(str)){
			if("eng".equals(lang)){
				str = "Notice";
			}else if("chi".equals(lang)){
				str = "公告";
			}else if("japan".equals(lang)){
				str = "公告";
			}
		}else if("답변 게시물".equals(str)){
			if("eng".equals(lang)){
				str = "Answer posting";
			}else if("chi".equals(lang)){
				str = "答复贴子";
			}else if("japan".equals(lang)){
				str = "回答的帖子";
			}
		}else if("삭제글".equals(str)){
			if("eng".equals(lang)){
				str = "Deleted writing";
			}else if("chi".equals(lang)){
				str = "删除的贴";
			}else if("japan".equals(lang)){
				str = "删除帖子";
			}
		}else if("비밀 게시물".equals(str)){
			if("eng".equals(lang)){
				str = "Confidential posting";
			}else if("chi".equals(lang)){
				str = "保密公告";
			}else if("japan".equals(lang)){
				str = "秘密后";
			}
		}else if("비밀글".equals(str)){
			if("eng".equals(lang)){
				str = "Confidential writing";
			}else if("chi".equals(lang)){
				str = "保密贴";
			}else if("japan".equals(lang)){
				str = "秘密";
			}
		}else if("이동된 글".equals(str)){
			if("eng".equals(lang)){
				str = "Transferred writing";
			}else if("chi".equals(lang)){
				str = "已移动的贴";
			}else if("japan".equals(lang)){
				str = "进入文章";
			}
		}else if("파일 다운로드".equals(str)){
			if("eng".equals(lang)){
				str = "Download file";
			}else if("chi".equals(lang)){
				str = "文件下载";
			}else if("japan".equals(lang)){
				str = "下载";
			}
		}else if("조회된 게시물이 없습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "There is no searched posting";
			}else if("chi".equals(lang)){
				str = "没有可查看的公告";
			}else if("japan".equals(lang)){
				str = "后，不质疑。";
			}
		}else if("새창으로 열립니다".equals(str)){
			if("eng".equals(lang)){
				str = "Opened in new engine (box, window)";
			}else if("chi".equals(lang)){
				str = "在新窗口打开";
			}else if("japan".equals(lang)){
				str = "新窗口中打开";
			}
		}else if("검색 분류 선택".equals(str)){
			if("eng".equals(lang)){
				str = "Selection from search category";
			}else if("chi".equals(lang)){
				str = "搜索分类选择";
			}else if("japan".equals(lang)){
				str = "搜索类型";
			}
		}else if("제목".equals(str)){
			if("eng".equals(lang)){
				str = "Title";
			}else if("chi".equals(lang)){
				str = "标题";
			}else if("japan".equals(lang)){
				str = "主题";
			}
		}else if("내용".equals(str)){
			if("eng".equals(lang)){
				str = "Content";
			}else if("chi".equals(lang)){
				str = "内容";
			}else if("japan".equals(lang)){
				str = "内容";
			}
		}else if("검색어".equals(str)){
			if("eng".equals(lang)){
				str = "Search word";
			}else if("chi".equals(lang)){
				str = "关键字";
			}else if("japan".equals(lang)){
				str = "搜索";
			}
		}else if("검색".equals(str)){
			if("eng".equals(lang)){
				str = "Search";
			}else if("chi".equals(lang)){
				str = "搜索";
			}else if("japan".equals(lang)){
				str = "取回";
			}
		}else if("년".equals(str)){
			if("eng".equals(lang)){
				str = "Year";
			}else if("chi".equals(lang)){
				str = "年"; //checking
			}else if("japan".equals(lang)){
				str = "年";
			}
		}else if("월".equals(str)){
			if("eng".equals(lang)){
				str = "Month";
			}else if("chi".equals(lang)){
				str = "月";
			}else if("japan".equals(lang)){
				str = "星期一";
			}
		}else if("월의 날짜별로 일정정보를 안내합니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Schedules will be informed according to the date of"; //Schedules will be informed according to the date of May
			}else if("chi".equals(lang)){
				str = "月各个日期的日程信息"; //显示“5”月各个日期的日程信息
			}else if("japan".equals(lang)){
				str = "该月的指导，时间安排的信息。";
			}
		}else if("일정표".equals(str)){
			if("eng".equals(lang)){
				str = "Schedule";
			}else if("chi".equals(lang)){
				str = "日程表";
			}else if("japan".equals(lang)){
				str = "时间表";
			}
		}else if("일".equals(str)){
			if("eng".equals(lang)){
				str = "Sun";
			}else if("chi".equals(lang)){
				str = "星期天";
			}else if("japan".equals(lang)){
				str = "星期天";
			}
		}else if("화".equals(str)){
			if("eng".equals(lang)){
				str = "Tue";
			}else if("chi".equals(lang)){
				str = "星期二";
			}else if("japan".equals(lang)){
				str = "星期二";
			}
		}else if("수".equals(str)){
			if("eng".equals(lang)){
				str = "Wed";
			}else if("chi".equals(lang)){
				str = "星期三";
			}else if("japan".equals(lang)){
				str = "星期三";
			}
		}else if("목".equals(str)){
			if("eng".equals(lang)){
				str = "Thur";
			}else if("chi".equals(lang)){
				str = "星期四";
			}else if("japan".equals(lang)){
				str = "星期四";
			}
		}else if("금".equals(str)){
			if("eng".equals(lang)){
				str = "Fri";
			}else if("chi".equals(lang)){
				str = "星期五";
			}else if("japan".equals(lang)){
				str = "星期五";
			}
		}else if("토".equals(str)){
			if("eng".equals(lang)){
				str = "Sat";
			}else if("chi".equals(lang)){
				str = "星期六";
			}else if("japan".equals(lang)){
				str = "星期六";
			}
		}else if("번호".equals(str)){
			if("eng".equals(lang)){
				str = "Number";
			}else if("chi".equals(lang)){
				str = "序号";
			}else if("japan".equals(lang)){
				str = "数";
			}
		}else if("질문을 클릭하면 답변내용이 나옵니다.".equals(str)){
			if("eng".equals(lang)){
				str = "If you click question, answer comes out";
			}else if("chi".equals(lang)){
				str = "点击提问便显示答复内容";
			}else if("japan".equals(lang)){
				str = "点击我得到答案的问题。";
			}
		}else if("질문 이미지".equals(str)){
			if("eng".equals(lang)){
				str = "Question image";
			}else if("chi".equals(lang)){
				str = "提问图片";
			}else if("japan".equals(lang)){
				str = "图像问题";
			}
		}else if("관리".equals(str)){
			if("eng".equals(lang)){
				str = "Management";
			}else if("chi".equals(lang)){
				str = "管理";
			}else if("japan".equals(lang)){
				str = "管理";
			}
		}else if("답변 이미지".equals(str)){
			if("eng".equals(lang)){
				str = "Answer image";
			}else if("chi".equals(lang)){
				str = "答复图片";
			}else if("japan".equals(lang)){
				str = "回答图片";
			}
		}else if("월 달력의 날짜를 선택하면 해당 날짜의 상세 일정을 볼 수 있습니다".equals(str)){
			if("eng".equals(lang)){
				str = "If you select the date of calendar month, you can see detailed schedule of the very ";
			}else if("chi".equals(lang)){
				str = "选择月日历的日期 可查看当天的详细日程";
			}else if("japan".equals(lang)){
				str = "当您选择原定于该日之日起一个日历月，可以查看详细信息";
			}
		}else if("달력".equals(str)){
			if("eng".equals(lang)){
				str = "calendar";
			}else if("chi".equals(lang)){
				str = "日历";
			}else if("japan".equals(lang)){
				str = "日历";
			}
		}else if("오늘의 일정".equals(str)){
			if("eng".equals(lang)){
				str = "Today's schedule";
			}else if("chi".equals(lang)){
				str = "今天的日程";
			}else if("japan".equals(lang)){
				str = "今日节目表";
			}
		}else if("등록된 일정이 없습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "There is no registered schedule";
			}else if("chi".equals(lang)){
				str = "没有注册的日程";
			}else if("japan".equals(lang)){
				str = "没有事件注册。";
			}
		}else if("이전달".equals(str)){
			if("eng".equals(lang)){
				str = "The preceding month";
			}else if("chi".equals(lang)){
				str = "上一月";
			}else if("japan".equals(lang)){
				str = "上月";
			}
		}else if("다음달".equals(str)){
			if("eng".equals(lang)){
				str = "The following month";
			}else if("chi".equals(lang)){
				str = "下一月";
			}else if("japan".equals(lang)){
				str = "下个月";
			}
		}else if("최근행사".equals(str)){
			if("eng".equals(lang)){
				str = "Recent events";
			}else if("chi".equals(lang)){
				str = "近期活动";
			}else if("japan".equals(lang)){
				str = "近期活动";
			}
		}else if("에 글을 작성하기 위한 입력폼으로".equals(str)){
			if("eng".equals(lang)){
				str = "This is enter form and composed of"; //This is enter form for "Free Posting' and composed of "Number, Title."
			}else if("chi".equals(lang)){
				str = "序号"; //“自由公告栏”的输入格式由“序号、标题”组成
			}else if("japan".equals(lang)){
				str = "报名表格写作";
			}
		}else if("첨부".equals(str)){
			if("eng".equals(lang)){
				str = "Attach file";
			}else if("chi".equals(lang)){
				str = "附件";
			}else if("japan".equals(lang)){
				str = "附";
			}
		}else if("으로 구성되어 있습니다.".equals(str)){
			if("eng".equals(lang)){ //
				str = "It is comprised";
			}else if("chi".equals(lang)){ //
				str = "、标题";
			}else if("japan".equals(lang)){
				str = "由。";
			}
		}else if("비밀글 여부".equals(str)){
			if("eng".equals(lang)){
				str = "Whether confidential writing or not";
			}else if("chi".equals(lang)){
				str = "保密贴与否";
			}else if("japan".equals(lang)){
				str = "秘密状态";
			}
		}else if("입력폼".equals(str)){
			if("eng".equals(lang)){
				str = "Enter form";
			}else if("chi".equals(lang)){
				str = "输入格式";
			}else if("japan".equals(lang)){
				str = "报名表";
			}
		}else if("작성자".equals(str)){
			if("eng".equals(lang)){
				str = "Writer";
			}else if("chi".equals(lang)){
				str = "填写人";
			}else if("japan".equals(lang)){
				str = "通过";
			}
		}else if("비밀번호".equals(str)){
			if("eng".equals(lang)){
				str = "Personal code number";
			}else if("chi".equals(lang)){
				str = "密码";
			}else if("japan".equals(lang)){
				str = "密码";
			}
		}else if("사진업로드".equals(str)){
			if("eng".equals(lang)){
				str = "Photo upload";
			}else if("chi".equals(lang)){
				str = "上传照片";
			}else if("japan".equals(lang)){
				str = "上载";
			}
		}else if("대표".equals(str)){
			if("eng".equals(lang)){
				str = "Prime"; //Prime (photo, image)
			}else if("chi".equals(lang)){
				str = "代表";
			}else if("japan".equals(lang)){
				str = "表示";
			}
		}else if("섬네일이미지".equals(str)){
			if("eng".equals(lang)){
				str = "Thumbnail Image";
			}else if("chi".equals(lang)){
				str = "缩略图";
			}else if("japan".equals(lang)){
				str = "的缩略图";
			}
		}else if("동영상첨부".equals(str)){
			if("eng".equals(lang)){
				str = "Attach moving image";
			}else if("chi".equals(lang)){
				str = "附加视频";
			}else if("japan".equals(lang)){
				str = "附上的视频";
			}
		}else if("동영상파일".equals(str)){
			if("eng".equals(lang)){
				str = "Moving image file";
			}else if("chi".equals(lang)){
				str = "视频文件";
			}else if("japan".equals(lang)){
				str = "视频文件";
			}
		}else if("의 조회 테이블입니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Search table for"; //Search table for "Free Posting"
			}else if("chi".equals(lang)){
				str = "的查看桌面"; //“自由公告栏”的查看桌面
			}else if("japan".equals(lang)){
				str = "的查找表。";
			}
		}else if("첨부".equals(str)){
			if("eng".equals(lang)){
				str = "Attach File";
			}else if("chi".equals(lang)){
				str = "附件";
			}else if("japan".equals(lang)){
				str = "附件";
			}
		}else if("의 덧글입력 테이블입니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Comment enter table for"; //Comment enter table for "Free Posting"
			}else if("chi".equals(lang)){
				str = "的评论桌面"; //“自由公告栏”的评论桌面
			}else if("japan".equals(lang)){
				str = "输入表的注释。";
			}
		}else if("덧글 수정".equals(str)){
			if("eng".equals(lang)){
				str = "Correction of comment";
			}else if("chi".equals(lang)){
				str = "评论修改";
			}else if("japan".equals(lang)){
				str = "修改意见";
			}
		}else if("덧글 입력".equals(str)){
			if("eng".equals(lang)){
				str = "Enter comment";
			}else if("chi".equals(lang)){
				str = "评论输入";
			}else if("japan".equals(lang)){
				str = "发表评论进入";
			}
		}else if("추천 하기".equals(str)){
			if("eng".equals(lang)){
				str = "Recommend";
			}else if("chi".equals(lang)){
				str = "推荐";
			}else if("japan".equals(lang)){
				str = "喜欢";
			}
		}else if("게시물관리".equals(str)){
			if("eng".equals(lang)){
				str = "Management of posted items";
			}else if("chi".equals(lang)){
				str = "贴管理";
			}else if("japan".equals(lang)){
				str = "相关文章";
			}
		}else if("답변".equals(str)){
			if("eng".equals(lang)){
				str = "Answer";
			}else if("chi".equals(lang)){
				str = "答复";
			}else if("japan".equals(lang)){
				str = "答案";
			}
		}else if("의 조회 테이블로".equals(str)){
			if("eng".equals(lang)){
				str = "To search table of";
			}else if("chi".equals(lang)){
				str = "至 的查看桌面";
			}else if("japan".equals(lang)){
				str = "查找表";
			}
		}else if("미디어플레이어가 작동되지 않을경우".equals(str)){
			if("eng".equals(lang)){
				str = "Please click here when media player does not work";
			}else if("chi".equals(lang)){
				str = "视频播放器无法打开时请点击";
			}else if("japan".equals(lang)){
				str = "如果媒体播放器不能正常工作";
			}
		}else if("여기를 클릭해주세요.".equals(str)){
			if("eng".equals(lang)){ //
				str = "Click this.";
			}else if("chi".equals(lang)){
				str = "ここをクリックしてください";
			}else if("japan".equals(lang)){
				str = "点击这里";
			}
		}else if("에 글을 수정하기 위한 입력폼으로".equals(str)){
			if("eng".equals(lang)){
				str = "This is enter form to correct the writing and composed of"; //This is enter form to correct the writing at "Free Posting' and composed of "Number, Title."
			}else if("chi".equals(lang)){
				str = "的修改输入格式由"; //“自由公告栏”的修改输入格式由“序号、标题”组成
			}else if("japan".equals(lang)){
				str = "修改以书面报名表为";
			}
		}else if("수정폼".equals(str)){
			if("eng".equals(lang)){
				str = "Revision format";
			}else if("chi".equals(lang)){
				str = "修改格式";
			}else if("japan".equals(lang)){
				str = "修改后的形式";
			}
		}else if("공지글".equals(str)){
			if("eng".equals(lang)){
				str = "Notice";
			}else if("chi".equals(lang)){
				str = "公告贴";
			}else if("japan".equals(lang)){
				str = "公告文章";
			}
		}else if("파일삭제".equals(str)){
			if("eng".equals(lang)){
				str = "File deletion";
			}else if("chi".equals(lang)){
				str = "文件删除";
			}else if("japan".equals(lang)){
				str = "删除文件";
			}
		}else if("이미지 ALT".equals(str)){
			if("eng".equals(lang)){
				str = "Explanation on image";
			}else if("chi".equals(lang)){
				str = "图片说明";
			}else if("japan".equals(lang)){
				str = "图片ALT";
			}
		}else if("파일".equals(str)){
			if("eng".equals(lang)){
				str = "File";
			}else if("chi".equals(lang)){
				str = "文件";
			}else if("japan".equals(lang)){
				str = "文件";
			}
		}else if("삭제".equals(str)){
			if("eng".equals(lang)){
				str = "Deletion";
			}else if("chi".equals(lang)){
				str = "删除";
			}else if("japan".equals(lang)){
				str = "删除";
			}
		}else if("의 패스워드확인 테이블입니다.".equals(str)){
			if("eng".equals(lang)){
				str = "This is password confirm table of ";
			}else if("chi".equals(lang)){
				str = "的密码确认桌面"; //“自由公告栏”的密码确认桌面
			}else if("japan".equals(lang)){
				str = "のパスワードを確認し、テーブルです.";
			}
		}else if("최근게시물 표시".equals(str)){
			if("eng".equals(lang)){
				str = "Recent posts";
			}else if("chi".equals(lang)){
				str = "显示最近贴";
			}else if("japan".equals(lang)){
				str = "최근게시물 표시";
			}
		}else if("카테고리".equals(str)){
			if("eng".equals(lang)){
				str = "Category";
			}else if("chi".equals(lang)){
				str = "类型";
			}else if("japan".equals(lang)){
				str = "カテゴリー";
			}
		}else if("패스워드 확인".equals(str)){
			if("eng".equals(lang)){
				str = "Password confirmation";
			}else if("chi".equals(lang)){
				str = "密码确认";
			}else if("japan".equals(lang)){
				str = "パスワードの確認";
			}
		}else if("이전글".equals(str)){
			if("eng".equals(lang)){
				str = "Previous Posts";
			}else if("chi".equals(lang)){
				str = "以前的帖子";
			}else if("japan".equals(lang)){
				str = "前の記事";
			}
		}else if("다음글,현재글,이전글 목록입니다.".equals(str)){
			if("eng".equals(lang)){
				str = "The following article, the current article, the previous posts list.";
			}else if("chi".equals(lang)){
				str = "下面這篇文章，當前文章，以前的職位列表。";
			}else if("japan".equals(lang)){
				str = "次の記事は、現在の記事、前の記事の一覧です。";
			}
		}else if("다음글,이전글 목록입니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Previous Post, Next Post list.";
			}else if("chi".equals(lang)){
				str = "下面的文章列出了以前的文章";
			}else if("japan".equals(lang)){
				str = "次の記事、前の記事の一覧です";
			}
		}else if("복구".equals(str)){
			if("eng".equals(lang)){
				str = "Restore";
			}else if("chi".equals(lang)){
				str = "已恢";
			}else if("japan".equals(lang)){
				str = "回復";
			}
		}else if("정상처리 되었습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "The normal process";
			}else if("chi".equals(lang)){
				str = "正常的過程";
			}else if("japan".equals(lang)){
				str = "通常の処理された";
			}
		}else if("수정 되었습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Has been modified";
			}else if("chi".equals(lang)){
				str = "已修改";
			}else if("japan".equals(lang)){
				str = "修正されました";
			}
		}else if("삭제 되었습니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Has been removed.";
			}else if("chi".equals(lang)){
				str = "已被刪除";
			}else if("japan".equals(lang)){
				str = "削除されました.";
			}
		}else if("다음글".equals(str)){
			if("eng".equals(lang)){
				str = "Next";
			}else if("chi".equals(lang)){
				str = "下一頁";
			}else if("japan".equals(lang)){
				str = "次の記事";
			}
		}else if("관리 리스트".equals(str)){
			if("eng".equals(lang)){
				str = "Manage a list";
			}else if("chi".equals(lang)){
				str = "管理清單";
			}else if("japan".equals(lang)){
				str = "管理リスト";
			}
		}else if("관리자".equals(str)){
			if("eng".equals(lang)){
				str = "Manager";
			}else if("chi".equals(lang)){
				str = "經理";
			}else if("japan".equals(lang)){
				str = "管理者";
			}
		}else if("크기".equals(str)){
			if("eng".equals(lang)){
				str = "size";
			}else if("chi".equals(lang)){
				str = "大小";
			}else if("japan".equals(lang)){
				str = "サイズ";
			}
		}else if("파일을 업로드 하는 중 입니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Uploading files.";
			}else if("chi".equals(lang)){
				str = "上传文件。";
			}else if("japan".equals(lang)){
				str = "ファイルをアップロードしています。";
			}
		}else if("확인".equals(str)){
			if("eng".equals(lang)){
				str = "Confirm";
			}else if("chi".equals(lang)){
				str = "确认";
			}else if("japan".equals(lang)){
				str = "確認";
			}
		}else if("목록 이미지".equals(str)){
			if("eng".equals(lang)){
				str = "List image";
			}else if("chi".equals(lang)){
				str = "列表图像";
			}else if("japan".equals(lang)){
				str = "リスト画像";
			}
		}else if("아이콘 강제 노출".equals(str)){
			if("eng".equals(lang)){
				str = "Icon forced exposure";
			}else if("chi".equals(lang)){
				str = "图标强制曝光";
			}else if("japan".equals(lang)){
				str = "アイコン強制露出";
			}
		}else if("답변입니다.".equals(str)){
			if("eng".equals(lang)){
				str = "Answer.";
			}else if("chi".equals(lang)){
				str = "就是答案。";
			}else if("japan".equals(lang)){
				str = "答えです。";
			}
		}else if("영구삭제".equals(str)){
			if("eng".equals(lang)){
				str = "Permanently delete";
			}else if("chi".equals(lang)){
				str = "永久删除";
			}else if("japan".equals(lang)){
				str = "永久削除";
			}
		}
		return str;
	}
}