/**
 * @version 3.2.0.1
 */
package jnit.cms.search;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.com.utl.fcc.service.WebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.board.db.JnitboarddbDefaultVO;
import jnit.board.db.JnitboarddbService;
import jnit.board.info.JnitboardinfoDefaultVO;
import jnit.board.info.JnitboardinfoService;
import jnit.board.info.JnitboardinfoVO;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.cnt.JnitcmscntDefaultVO;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mbr.JnitcmsmbrDefaultVO;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbrtype.JnitcmsmbrtypeService;
import jnit.cms.mbrtype.JnitcmsmbrtypeVO;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.com.util.DBType;
import jnit.util.PathUtil;
import net.sf.json.JSONObject;
import oracle.sql.CLOB;

@Controller
public class CmsTotalSearchController {

	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

	@Resource(name = "jnitcmsmbrService")
	private JnitcmsmbrService jnitcmsmbrService;

	@Resource(name = "jnitcmscntService")
	private JnitcmscntService jnitcmscntService;

	@Resource(name = "jnitcmssiteService")
	private JnitcmssiteService jnitcmssiteService;

	@Resource(name = "jnitcmsmenuService")
	private JnitcmsmenuService jnitcmsmenuService;

	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService jnitboardinfoService;

	@Resource(name = "jnitcmsmbrtypeService")
	private JnitcmsmbrtypeService jnitcmsmbrtypeService;

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@RequestMapping("/total/search.do")
	public String totalSearch(@ModelAttribute("searchVO") JnitboarddbDefaultVO searchVO
			, @ModelAttribute("searchVO2") JnitcmsmbrDefaultVO  searchVO2
			, @ModelAttribute("searchVO3") JnitcmscntDefaultVO searchVO3
			, HttpServletRequest request
			, ModelMap model)throws Exception{

		String searchKeyword = NullUtil.nullString(request.getParameter("searchKeyword"));
		String contentPath = NullUtil.nullString(request.getParameter("contentPath"));
		if(!"/".equals(contentPath.substring(contentPath.length()-1)) && !"jsp".equals(contentPath.substring(contentPath.length()-3))) contentPath += "/";

		String uri = NullUtil.nullString(request.getParameter("uri"));
		String root = PathUtil.getRealPath(request);
		String mode = NullUtil.nullString(request.getParameter("mode"));
		String url = request.getRequestURL().toString();

		String sitePath = uri.substring(1, uri.indexOf("/",1));
		String searchJSONDir = root + "WEB-INF/jsp/jnit/cms/search/JSON/"+sitePath+"_search.json";
		File searchJSON = new File(searchJSONDir);
		if(!searchJSON.exists()){
			System.out.println("파일 없음");
			model.addAttribute("json","통합검색 설정파일을 읽어오지 못했습니다.");
			return "jnit/util/json";
		}
		JSONObject JSON = new JSONObject();
		String limitmbrYn = "";
		String limitCntYn = "";
		String limitBoardYn = "";
		if(searchJSON.exists()){
			JSON = new JSONObject().fromObject(CmsHandler.readFile(searchJSONDir));
			limitmbrYn = JSON.get("limitmbrYn").toString();
			limitCntYn = JSON.get("limitCntYn").toString();
			limitBoardYn = JSON.get("limitBoardYn").toString();
		}

		JnitcmssiteVO siteVO = new JnitcmssiteVO();
		siteVO.setSitePath(sitePath);
		siteVO.setSelectCondition("1");
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		if("".equals(mode)) mode = "search";

		if("search".equals(mode)){
			//통합검색
			model.addAllAttributes(list(JSON, searchKeyword, mode, searchVO, searchVO2, searchVO3, siteVO, request, model));
		}else if("searchBoard".equals(mode)){
			//게시판
			if("Y".equals(limitBoardYn)) model.addAllAttributes(boardMoalMap(JSON, searchKeyword, mode, searchVO,siteVO, request, model));
		}else if("searchOrg".equals(mode)){
			//직원검색
			if("Y".equals(limitmbrYn)) model.addAllAttributes(mbrModalMap(JSON, searchKeyword, mode, searchVO2, request, model));
		}else if("searchContent".equals(mode)){
			//콘텐츠검색
			if("Y".equals(limitCntYn)) model.addAllAttributes(contentModalMap(JSON, searchKeyword, mode, searchVO3, siteVO, request, model));
		}

		model.addAttribute("limitmbrYn", limitmbrYn);
		model.addAttribute("limitCntYn", limitCntYn);
		model.addAttribute("limitBoardYn", limitBoardYn);
		model.addAttribute("mode", mode);
		model.addAttribute("contentPath", contentPath);
		model.addAttribute("DBType", DBType.getDbTypeString());
		model.addAttribute("searchKeyword", searchKeyword);
		if(StringUtil.isExistString(url, "local")) model.addAttribute("localYn", "Y");
		return "/jnit/cms/search/import"; //return "/jnit/cms/search/search";
	}

	public ModelMap list(JSONObject JSON
			, String searchKeyword
			, String mode
			, JnitboarddbDefaultVO searchVO
			, JnitcmsmbrDefaultVO searchVO2
			, JnitcmscntDefaultVO searchVO3
			, JnitcmssiteVO siteVO
			, HttpServletRequest request
			, ModelMap model)throws Exception{
		String limitmbrYn = "";
		String limitCntYn = "";
		String limitBoardYn = "";

		if(!JSON.isEmpty()){
			limitmbrYn = JSON.get("limitmbrYn").toString();
			limitCntYn = JSON.get("limitCntYn").toString();
			limitBoardYn = JSON.get("limitBoardYn").toString();
		}

		//게시판
		if("Y".equals(limitBoardYn)) model.addAllAttributes(boardMoalMap(JSON, searchKeyword, mode, searchVO, siteVO, request, model));

		//직원검색
		if("Y".equals(limitmbrYn)) model.addAllAttributes(mbrModalMap(JSON, searchKeyword, mode, searchVO2, request, model));

		//콘텐츠검색
		if("Y".equals(limitCntYn)) model.addAllAttributes(contentModalMap(JSON, searchKeyword, mode, searchVO3, siteVO, request, model));
		return model;
	}

	/**
	 * 게시판 정보를 반환한다.
	 * @param JSON
	 * @param searchKeyword - 검색어
	 * @param siteVO
	 * @param request
	 * @param model
	 * @return ModelMap
	 * @throws Exception
	 */
	public ModelMap boardMoalMap(JSONObject JSON
			, String searchKeyword
			, String mode
			, JnitboarddbDefaultVO searchVO
			, JnitcmssiteVO siteVO, HttpServletRequest request
			, ModelMap model)throws Exception{

		/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIdx());
		paginationInfo.setRecordCountPerPage("searchBoard".equals(mode) ? searchVO.getPageUnit() : 3);
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setSearchKeyword(searchKeyword);
		searchVO.setWithContent("1");
		searchVO.setSearchCondition("all");
		searchVO.setQueryYn("Y");
		searchVO.setBoardId("BBS_1000000000000000");
		searchVO.setQuery(boardFillter(JSON));
		String limitBoardSiteYn = JSON.get("limitBoardSiteYn").toString();
		if(limitBoardSiteYn.equals("Y")){//현재 사이트
			searchVO.setSearchType("total");
			searchVO.setSearchSite(siteVO.getSiteId());
		}


		if(!searchKeyword.equals("")){
			List boardList = jnitboarddbService.selectList(searchVO);

			HashMap<BigDecimal, String> contentMap = new HashMap<BigDecimal, String>();
			HashMap<String, String> boardWriterMap = new HashMap<String, String>();
			HashMap<String, String> boardTitleMap = new HashMap<String, String>();
			Iterator boardIterator = boardList.iterator();
			for(int i=0; i<boardList.size(); i++){
				EgovMap resultEgovMap = (EgovMap) boardIterator.next();
				if(DBType.getDbTypeBoolean("oracle")){
					String strId = String.valueOf(resultEgovMap.get("id"));
					BigDecimal id =  new BigDecimal(strId);
					CLOB content = (CLOB) resultEgovMap.get("content");
					contentMap = contentDeciMap(content, id, contentMap);
				}else if(DBType.getDbTypeBoolean("tibero")){
					String strId = String.valueOf(resultEgovMap.get("id"));
					BigDecimal id =  new BigDecimal(strId);
					com.tmax.tibero.jdbc.TbClob content = (com.tmax.tibero.jdbc.TbClob) resultEgovMap.get("content");
					contentMap = contentDeciMap(content, id, contentMap);
				}
				String tmp1 = (String) resultEgovMap.get("tmp1");
				JnitboardinfoVO infoVO = new JnitboardinfoVO();
				infoVO.setBoardId(tmp1);
				try {
					infoVO = jnitboardinfoService.selectJnitboardinfo(infoVO);
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				boardWriterMap.put(tmp1, infoVO.getBoardUrl());
				boardTitleMap.put(tmp1, infoVO.getBoardTitle());
			}
			int totCnt = jnitboarddbService.selectListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("boardWriterMap", boardWriterMap);
			model.addAttribute("boardTitleMap", boardTitleMap);

			model.addAttribute("contentMap", contentMap);
			model.addAttribute("boardSize", boardList.size());
			model.addAttribute("boardList", boardList);
			model.addAttribute("totCnt", totCnt);
		}
		if("searchBoard".equals(mode)) model.addAttribute("paginationInfo", paginationInfo);
		return model;
	}

	/**
	 * 게시판 리스트를 필터링한다.
	 * @param JSON - 사이트_search.json
	 * @param resultEgovMap
	 * @return Boolean
	 * @throws Exception
	 */
	public String boardFillter(JSONObject JSON)throws Exception{
		String Query = "";
		if(!JSON.isEmpty()){
			String regx = ",";
			String[] limitNm = isStrings(JSON.get("limitNm").toString(), regx);
			String[] limitBoardId = isStrings(JSON.get("limitBoardId").toString(), regx);
			String[] limitBoardTitle = isStrings(JSON.get("limitBoardTitle").toString(), regx);
			String[] limitBoardContent = isStrings(JSON.get("limitBoardContent").toString(), regx);
			String[] limitMbrId = isStrings(JSON.get("limitMbrId").toString(), regx);
			//String content = NullUtil.nullString(String.valueOf(resultEgovMap.get("content")));
			String limitCommentYn = JSON.get("limitCommentYn").toString();
			String limitScriptYn = JSON.get("limitScriptYn").toString();

			/*
			if("N".equals(limitCommentYn)){ //주석 제거
				content = commentDel(content);
			}
			if("N".equals(limitScriptYn)){ //스크립트 제거
				content = scriptDel(content);
			}
			*/
			if(limitNm.length > 0){ //금칙어
				if(!"".equals(limitNm[0])){
					for(int i=0; i<limitNm.length; i++){
						Query += "AND (a.TITLE NOT LIKE '%"+limitNm[i]+"%' AND a.CONTENT NOT LIKE '%"+limitNm[i]+"%') ";
					}
				}
			}
			if(limitBoardId.length > 0){ //boardId 제한
				if(!"".equals(limitBoardId[0])){
					for(int i=0; i<limitBoardId.length; i++){
						Query += "AND (a.TMP1 NOT LIKE '%"+limitBoardId[i]+"%') ";
					}
				}
			}
			/* 만약 등록된 게시판만 출력되기 원할 경우 사용
			if(limitBoardId.length > 0){ //boardId 제한
				if(!"".equals(limitBoardId[0])){
					Query += "AND (";
					for(int i=0; i<limitBoardId.length; i++){
						Query += "(a.TMP1 LIKE '%"+limitBoardId[i]+"%')";
						System.out.println("i :"+i);
						System.out.println("limitBoardId.length : "+limitBoardId.length);
						if(i+1 != limitBoardId.length){
							Query += " OR ";
						}
					}
					Query += ")";
				}
			}
			*/
			if(limitBoardTitle.length > 0){ //title 제한
				if(!"".equals(limitBoardTitle[0])){
					for(int i=0; i<limitBoardTitle.length; i++){
						Query += "AND (a.TITLE NOT LIKE '%"+limitBoardTitle[i]+"%') ";
					}
				}
			}
			if(limitBoardContent.length > 0){ //내용 제한
				if(!"".equals(limitBoardContent[0])){
					for(int i=0; i<limitBoardContent.length; i++){
						Query += "AND (a.CONTENT NOT LIKE '%"+limitBoardContent[i]+"%') ";
					}
				}

			}
			if(limitMbrId.length > 0){ //글쓴이 제한
				if(!"".equals(limitMbrId[0])){
					for(int i=0; i<limitMbrId.length; i++){
						Query += "AND (a.MBR_ID NOT LIKE '%"+limitMbrId[i]+"%') ";
					}
				}
			}
		}
		return Query;
	}

	/**
	 * 회원 정보를 반환한다.
	 * @param JSON
	 * @param searchKeyword
	 * @param request
	 * @param model
	 * @return ModelMap
 	 * @throws Exception
	 */
	public ModelMap mbrModalMap(JSONObject JSON
			, String searchKeyword
			, String mode
			, JnitcmsmbrDefaultVO searchVO2
			, HttpServletRequest request
			, ModelMap model)throws Exception{

		String orgId = NullUtil.nullString(request.getParameter("org"));
		String typeUse = NullUtil.nullString(request.getParameter("typeUse"));
    	String listUse = NullUtil.nullString(request.getParameter("listUse"));

		/** EgovPropertyService.sample */
		searchVO2.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO2.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo2 = new PaginationInfo();
		paginationInfo2.setCurrentPageNo(searchVO2.getPageIndex());
		paginationInfo2.setRecordCountPerPage("searchOrg".equals(mode) ? searchVO2.getPageUnit() : 3);
		paginationInfo2.setPageSize(searchVO2.getPageSize());

		searchVO2.setFirstIndex(paginationInfo2.getFirstRecordIndex());
		searchVO2.setLastIndex(paginationInfo2.getLastRecordIndex());
		searchVO2.setRecordCountPerPage(paginationInfo2.getRecordCountPerPage());

		if("searchOrg".equals(mode)){
    		if(!orgId.equals("")){
    			searchVO2.setSearchCondition("1");
    			searchVO2.setSearchKeyword(orgId);
    		}
		}
		if("".equals(NullUtil.nullString(searchVO2.getSearchCondition())) || "통합검색".equals(NullUtil.nullString(searchVO2.getSearchCondition()))){
			searchVO2.setSearchCondition("8");
		}
		searchVO2.setSearchKeyword(searchKeyword);
		searchVO2.setOrderByMbrIdYn("N");
		searchVO2.setOrderbyCondition("0");
		searchVO2.setQueryYn("Y");
		searchVO2.setQuery(mbrFillter(JSON));

		if(!searchKeyword.equals("")){
			List mbrList = jnitcmsmbrService.selectLeftJoinmbrList(searchVO2);

			int totCnt2 = jnitcmsmbrService.selectLeftJoinmbrListTotCnt(searchVO2);
			paginationInfo2.setTotalRecordCount(totCnt2);

			model.addAttribute("orgSize", mbrList.size());
			model.addAttribute("mbrList", mbrList);
			model.addAttribute("totCnt2", totCnt2);
			if("searchOrg".equals(mode)){
				model.addAttribute("org", orgId);
				model.addAttribute("listUse", listUse);
				model.addAttribute("typeUse", typeUse);

				model.addAttribute("orgList", mbrList);
				model.addAttribute("pageIndex", searchVO2.getPageIndex());
				model.addAttribute("searchCondition", searchVO2.getSearchCondition());
			}
		}
		if("searchOrg".equals(mode)) model.addAttribute("paginationInfo", paginationInfo2);
		return model;
	}

	/**
	 * 회원 리스트를 필터링한다.
	 * @param JSON
	 * @param mbrEgovMap
	 * @return
	 * @throws Exception
	 */
	public String mbrFillter(JSONObject JSON)throws Exception{
		String Query = "";
		if(!JSON.isEmpty()){
			String regx = ",";
			String[] limitNm = isStrings(JSON.get("limitNm").toString(), regx);
			String[] limitMbrId = isStrings(JSON.get("limitMbrId").toString(), regx);
			String[] limitMbrType = isStrings(JSON.get("limitMbrType").toString(), regx);

			if(limitNm.length > 0){ //금칙어
				if(!"".equals(limitNm[0])){
					for(int i=0; i<limitNm.length; i++){
						Query += "AND (a.MBR_NM NOT LIKE '%"+limitNm[i]+"%' ) ";
					}
				}
			}
			if(limitMbrId.length > 0){ //회원 ID 제한
				if(!"".equals(limitMbrId[0])){
					for(int i=0; i<limitMbrId.length; i++){
						Query += "AND (a.MBR_ID !='"+limitMbrId[i]+"' ) ";
					}
				}
			}
			if(limitMbrType.length > 0){ //회원유형 제한
				if(!"".equals(limitMbrType[0])){
					for(int i=0; i<limitMbrType.length; i++){
						Query += "AND (a.TYPE_ID !='"+limitMbrType[i]+"' ) ";
					}
				}
			}
		}

		return Query;
	}

	/**
	 * 콘텐츠 정보를 반환한다.
	 * @param JSON
	 * @param searchKeyword - 검색어
	 * @param siteVO
	 * @param request
	 * @param model
	 * @return ModelMap
	 * @throws Exception
	 */
	public ModelMap contentModalMap(JSONObject JSON
			, String searchKeyword
			, String mode
			, JnitcmscntDefaultVO searchVO3
			, JnitcmssiteVO siteVO
			, HttpServletRequest request, ModelMap model)throws Exception{

		/** EgovPropertyService.sample */
		searchVO3.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO3.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo3 = new PaginationInfo();
    	paginationInfo3.setCurrentPageNo(searchVO3.getPageIndex());
    	paginationInfo3.setRecordCountPerPage("searchContent".equals(mode) ? searchVO3.getPageUnit() : 3);
    	paginationInfo3.setPageSize(searchVO3.getPageSize());

		searchVO3.setFirstIndex(paginationInfo3.getFirstRecordIndex());
		searchVO3.setLastIndex(paginationInfo3.getLastRecordIndex());
		searchVO3.setRecordCountPerPage(paginationInfo3.getRecordCountPerPage());

		String limitCntSite = JSON.get("limitCntSite").toString();
		if(limitCntSite.equals("N")){
			searchVO3.setSiteYn("N");
		}
		searchVO3.setSiteId(siteVO.getSiteId());
		searchVO3.setSearchKeyword(searchKeyword);
		searchVO3.setSearchCondition("4");
		searchVO3.setOrderbyCondition("0");
		searchVO3.setQueryYn("Y");
		searchVO3.setQuery(contentFillter(JSON));
		if(!searchKeyword.equals("")){
			List cntList = jnitcmscntService.selectLeftcntMenuList(searchVO3);

			HashMap<String, String> menuMap = new HashMap<String, String>();
			HashMap<String, String> cntMap = new HashMap<String, String>();
			HashMap<String, String> menuPathMap = new HashMap<String, String>();

			Iterator cntIterator = cntList.iterator();
			for(int i=0; i<cntList.size(); i++){
				EgovMap cntEgovMap = (EgovMap) cntIterator.next();
				String cntId = String.valueOf(cntEgovMap.get("cntId"));
				String menuId = String.valueOf(cntEgovMap.get("menuId"));
				String siteId = String.valueOf(cntEgovMap.get("siteId"));
				String siteNm = String.valueOf(cntEgovMap.get("siteNm"));
				String sitePath = String.valueOf(cntEgovMap.get("sitePath"));

				if(DBType.getDbTypeBoolean("oracle")){
					CLOB cntSrc = (CLOB) cntEgovMap.get("cntSrc");
					cntMap = contentMap(cntSrc, cntId, cntMap);
				}else if(DBType.getDbTypeBoolean("tibero")){
					com.tmax.tibero.jdbc.TbClob cntSrc = (com.tmax.tibero.jdbc.TbClob) cntEgovMap.get("cntSrc");
					cntMap = contentMap(cntSrc, cntId, cntMap);
				}

				JnitcmsmenuVO menuVO = new JnitcmsmenuVO();
				menuVO.setSiteId(siteId);
				menuVO.setMenuId(menuId);
				menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);
				//menuMap.put(cntId, WebUtil.removeTag(jnitcmsmenuService.makeMenuNames(menuVO, siteVO.getSitePath(), request)));
				String menuNames = (String)jnitcmsmenuService.makeMenuNames(menuVO, siteNm);
				menuMap.put(cntId, WebUtil.removeTag(menuNames));
				menuPathMap.put(cntId, (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO,sitePath));
			}

			int totCnt3 = jnitcmscntService.selectLeftcntMenuListTotCnt(searchVO3);
			paginationInfo3.setTotalRecordCount(totCnt3);

			model.addAttribute("totCnt3", totCnt3);
			model.addAttribute("menuPathMap", menuPathMap);
			model.addAttribute("menuMap", menuMap);
			model.addAttribute("cntMap", cntMap);
			model.addAttribute("cntList", cntList);
			model.addAttribute("cntSize", cntList.size());
		}
		if("searchContent".equals(mode)) model.addAttribute("paginationInfo", paginationInfo3);
		return model;
	}

	/**
	 * 콘텐츠 리스트를 필터링 한다.
	 * @param JSON
	 * @param cntEgovMap
	 * @param menuNm
	 * @return Boolean
	 * @throws Exception
	 */
	public String contentFillter(JSONObject JSON)throws Exception{
		String Query = "";
		if(!JSON.isEmpty()){
			String regx = ",";
			String[] limitNm = isStrings(JSON.get("limitNm").toString(), regx);
			String[] limitCntNm = isStrings(JSON.get("limitCntNm").toString(), regx);
			String[] limitCntSrc = isStrings(JSON.get("limitCntSrc").toString(), regx);
			String limitCommentYn = JSON.get("limitCommentYn").toString();
			String limitScriptYn = JSON.get("limitScriptYn").toString();
			/*
			if("N".equals(limitCommentYn)){ //주석 제거
				cntSrc = commentDel(cntSrc);
			}
			if("N".equals(limitScriptYn)){ //스크립트 제거
				cntSrc = scriptDel(cntSrc);
			}
			*/
			if(limitNm.length > 0){ //금칙어
				if(!"".equals(limitNm[0])){
					for(int i=0; i<limitNm.length; i++){
						Query += "AND (b.MENU_NM NOT LIKE '%"+limitNm[i]+"%' AND a.CNT_SRC NOT LIKE '%"+limitNm[i]+"%') ";
					}
				}
			}
			if(limitCntNm.length > 0){ //컨텐츠명 제한
				if(!"".equals(limitCntNm[0])){
					for(int i=0; i<limitCntNm.length; i++){
						Query += "AND (b.MENU_NM NOT LIKE '%"+limitCntNm[i]+"%' ) ";
					}
				}

			}
			if(limitCntSrc.length > 0){ //컨텐츠 내용 제한
				if(!"".equals(limitCntSrc[0])){
					for(int i=0; i<limitCntSrc.length; i++){
						Query += "AND (a.CNT_SRC NOT LIKE '%"+limitCntSrc[i]+"%' ) ";
					}
				}
			}
		}
		return Query;
	}

	/**
	 * CLOB 내용을 HashMap으로 반환한다.
	 * @param contentSrc - value 값
	 * @param id - key 값
	 * @param contentMap
	 * @return HashMap<String, String>
	 * @throws SQLException
	 * @throws IOException
	 */
	public HashMap<String, String> contentMap(CLOB contentSrc, String id, HashMap<String, String> contentMap) throws SQLException, IOException{
		if(contentSrc != null){
			StringBuffer cntsb = new StringBuffer();
			Reader cntReader = contentSrc.getCharacterStream();
			BufferedReader cntbf = new BufferedReader(cntReader);
			String line = "";
			while ((line = cntbf.readLine()) != null) {
				cntsb.append(line+"\r\n");
			}
			cntbf.close();
			contentMap.put(id, cntsb.toString());
		}
		return contentMap;
	}
	public HashMap<String, String> contentMap(com.tmax.tibero.jdbc.TbClob contentSrc, String id, HashMap<String, String> contentMap) throws SQLException, IOException{
		if(contentSrc != null){
			StringBuffer cntsb = new StringBuffer();
			Reader cntReader = contentSrc.getCharacterStream();
			BufferedReader cntbf = new BufferedReader(cntReader);
			String line = "";
			while ((line = cntbf.readLine()) != null) {
				cntsb.append(line+"\r\n");
			}
			cntbf.close();
			contentMap.put(id, cntsb.toString());
		}
		return contentMap;
	}
	/**
	 * CLOB 내용을 HashMap으로 반환한다.
	 * @param contentSrc - value 값
	 * @param id - key 값 타입 BigDecimal
	 * @param contentMap
	 * @return HashMap<BigDecimal, String>
	 * @throws SQLException
	 * @throws IOException
	 */
	public HashMap<BigDecimal, String> contentDeciMap(CLOB contentSrc, BigDecimal id, HashMap<BigDecimal, String> contentMap) throws SQLException, IOException{
		if(contentSrc != null){
			StringBuffer sb = new StringBuffer();
			try {
				Reader reader = contentSrc.getCharacterStream();
				BufferedReader br = new BufferedReader(reader);

				String line = "";
				while ((line = br.readLine()) != null) {
					sb.append(line+"\r\n");
				}
				br.close();
			} catch (IOException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			contentMap.put(id, sb.toString());
		}
		return contentMap;
	}
	public HashMap<BigDecimal, String> contentDeciMap(com.tmax.tibero.jdbc.TbClob contentSrc, BigDecimal id, HashMap<BigDecimal, String> contentMap) throws SQLException, IOException{
		if(contentSrc != null){
			StringBuffer sb = new StringBuffer();
			try {
				Reader reader = contentSrc.getCharacterStream();
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
		return contentMap;
	}

	@RequestMapping("/cms/search/total.do")
	public String searchTotal(@ModelAttribute("jnitcmssearchVO") JnitcmssearchVO jnitcmssearchVO
			,HttpServletRequest request
			, ModelMap model )throws Exception{

		AdminUtil.setMenuId("m06050000");

		String siteId = NullUtil.nullString(CmsHelper.getSessionSiteId(request));
		if("".equals(siteId)){
			return "/jnit/cms/sub4_msg-nosite";
		}

		JnitcmssiteVO siteVO = new JnitcmssiteVO();
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		String root = PathUtil.getRealPath(request);
		String searchJSONDir = root +"WEB-INF/jsp/jnit/cms/search/JSON/"+siteVO.getSitePath()+"_search.json";
		File searchJSON = new File(searchJSONDir);
		if(searchJSON.exists()){
			JSONObject JSON = new JSONObject().fromObject(CmsHandler.readFile(searchJSONDir));

			jnitcmssearchVO = (JnitcmssearchVO) JSON.toBean(JSON, JnitcmssearchVO.class);
		}
		model.addAttribute("jnitcmssearchVO", jnitcmssearchVO);
		return "/jnit/cms/search/searchConfig";
	}

	@RequestMapping("/cms/search/save.do")
	public String searchSave(@ModelAttribute("jnitcmssearchVO") JnitcmssearchVO jnitcmssearchVO
			, HttpServletRequest request
			, ModelMap model)throws Exception{

		String siteId = NullUtil.nullString(CmsHelper.getSessionSiteId(request));
		if("".equals(siteId)){
			return "/jnit/cms/sub4_msg-nosite";
		}

		JnitcmssiteVO siteVO = new JnitcmssiteVO();
		siteVO.setSiteId(siteId);
		siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

		String root = PathUtil.getRealPath(request);
		String jsonDir = root +"WEB-INF/jsp/jnit/cms/search/JSON";
		File json = new File(jsonDir);
		if(!json.exists()){
			json.mkdirs();
		}
		String searchJSONDir = jsonDir+"/"+siteVO.getSitePath()+"_search.json";

		JSONObject JSON = new JSONObject().fromObject(jnitcmssearchVO);
		if(!"".equals(siteId)){
			CmsHandler.writeFile(searchJSONDir, JSON.toString());
			model.addAttribute("alert", "저장하였습니다.");
		}else{
			model.addAttribute("alert", "저장 하지 못했습니다.");
		}

		model.addAttribute("path","/cms/search/total.do");
		return "/jnit/util/alertMove";
	}

	@RequestMapping("/cms/ajax/cnt/list.do")
	public String ajaxMenuList(HttpServletRequest request
			, ModelMap model)throws Exception{

		String siteId = CmsHelper.getSessionSiteId(request);
		String type = NullUtil.nullString(request.getParameter("type"));
		String searchKeyword = NullUtil.nullString(request.getParameter("searchKeyword"));
		String searchCondition = NullUtil.nullString(request.getParameter("searchCondition"));

		if("CntNm".equals(type)){
			JnitcmscntDefaultVO searchVO =  new JnitcmscntDefaultVO();
			/** EgovPropertyService.sample */
	    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
	    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

	    	/** pageing */
	    	PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(NullUtil.nullInt(request.getParameter("pageIndex")) == 0 ? 1 : NullUtil.nullInt(request.getParameter("pageIndex")));
			paginationInfo.setRecordCountPerPage(5); //searchVO.getPageUnit()
			paginationInfo.setPageSize(searchVO.getPageSize());

			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			searchVO.setSiteId(siteId);
			searchVO.setSearchCondition("5");
			searchVO.setSearchKeyword(searchKeyword);
			List resultLsit = jnitcmscntService.selectLeftcntMenuList(searchVO);

			int totCnt = jnitcmscntService.selectLeftcntMenuListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("resultList", resultLsit);
			model.addAttribute("searchVO", searchVO);
		}else if("BoardId".equals(type) || "BoardTitle".equals(type)){
			JnitboardinfoDefaultVO searchVO = new JnitboardinfoDefaultVO();
			/** EgovPropertyService.sample */
	    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
	    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

	    	/** pageing */
	    	PaginationInfo paginationInfo = new PaginationInfo();
	    	paginationInfo.setCurrentPageNo(NullUtil.nullInt(request.getParameter("pageIndex")) == 0 ? 1 : NullUtil.nullInt(request.getParameter("pageIndex")));
			paginationInfo.setRecordCountPerPage(5); //searchVO.getPageUnit()
			paginationInfo.setPageSize(searchVO.getPageSize());

			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			searchVO.setSearchBoardGroup(siteId);
			searchVO.setSearchCondition("1");
			searchVO.setSearchKeyword(searchKeyword);
			searchVO.setSearchCondition(searchCondition);
			List resultLsit = jnitboardinfoService.selectJnitboardinfoList(searchVO);

			int totCnt = jnitboardinfoService.selectJnitboardinfoListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("resultList", resultLsit);
			model.addAttribute("searchVO", searchVO);
		}else if("MbrId".equals(type) || "MbrType".equals(type)){
			JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
			/** EgovPropertyService.sample */
	    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
	    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

	    	/** pageing */
	    	PaginationInfo paginationInfo = new PaginationInfo();
	    	paginationInfo.setCurrentPageNo(NullUtil.nullInt(request.getParameter("pageIndex")) == 0 ? 1 : NullUtil.nullInt(request.getParameter("pageIndex")));
			paginationInfo.setRecordCountPerPage(5); //searchVO.getPageUnit()
			paginationInfo.setPageSize(searchVO.getPageSize());

			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			searchVO.setSearchCondition(searchCondition);
			searchVO.setSearchKeyword(searchKeyword);
			List resultLsit = jnitcmsmbrService.selectLeftJoinmbrList(searchVO);

			HashMap<String, String> mbrtypeMap = new HashMap<String, String>();
			HashMap<String, String> mbrtypeLvMap = new HashMap<String, String>();

			Iterator resultIterator = resultLsit.iterator();
			for(int i=0; i<resultLsit.size(); i++){
				EgovMap resultEgovMap = (EgovMap) resultIterator.next();
				String mbrId = String.valueOf(resultEgovMap.get("mbrId"));
				String typeId = NullUtil.nullString(String.valueOf(resultEgovMap.get("typeId")));
				if(!"".equals(typeId)){
					JnitcmsmbrtypeVO typeVO = new JnitcmsmbrtypeVO();
					typeVO.setTypeId(typeId);
					try {
						typeVO = jnitcmsmbrtypeService.selectJnitcmsmbrtype(typeVO);
						mbrtypeMap.put(mbrId, typeVO.getTypeNm());
						mbrtypeLvMap.put(mbrId, typeVO.getTypeLv());
					} catch (NullPointerException e){
						log.error(e.getMessage());
					} catch (Exception e) {
						log.error(e.getMessage());
					}
				}
			}

			int totCnt = jnitcmsmbrService.selectLeftJoinmbrListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);

			model.addAttribute("mbrtypeLvMap", mbrtypeLvMap);
			model.addAttribute("mbrtypeMap", mbrtypeMap);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("resultList", resultLsit);
			model.addAttribute("searchVO", searchVO);
		}

		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("type", type);
		return "/jnit/cms/search/searchList";
	}

	public String[] isStrings(String str,String regx)throws Exception{
		String[] strs = {""};
		if(!"".equals(str)){
			strs = str.split(regx);
		}
		return strs;
	}

	/**
	 * 주석을 삭제하고 문자열을 반환한다. <%-- --%><!-- -->
	 * @param str
	 * @return str
	 */
	public String commentDel(String str){
		str = NullUtil.nullString(str);
		if(!"".equals(str)){
			for(int i=0; i<20; i++){
	    		try {
	    			str = str.replace(str.substring(str.indexOf("<%--"), str.indexOf("--%>")+4), "");
	    			str = str.replace(str.substring(str.indexOf("<!--"), str.indexOf("-->")+3), "");
	    		} catch (NullPointerException e){
	    			log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
	    	}
		}
		return str;
	}
	/**
	 * 스크립트을 삭제하고 문자열을 반환한다.
	 * @param str
	 * @return str
	 */
	public String scriptDel(String str){
		str = NullUtil.nullString(str);
		if(!"".equals(str)){
			for(int i=0; i<20; i++){
	    		try {
	    			str = str.replace(str.substring(str.indexOf("<script"), str.indexOf("</script>")+9), "");
	    		} catch (NullPointerException e){
	    			log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
	    	}
		}
		return str;
	}
}
