/**
 * @version 3.2.0.1
 */
package jnit.board;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.Reader;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.board.db.JnitboarddbDefaultVO;
import jnit.board.db.JnitboarddbService;
import jnit.board.db.JnitboarddbVO;
import jnit.board.info.JnitboardinfoController;
import jnit.board.info.JnitboardinfoDefaultVO;
import jnit.board.info.JnitboardinfoService;
import jnit.board.info.JnitboardinfoVO;
import jnit.cms.handler.CmsHandler;
import jnit.com.util.DBType;
import jnit.com.util.FileStream;
import jnit.rsc.page.JnitrscpageService;
import jnit.util.JavaUtilDateJsonValueProcessor;
import jnit.util.PathUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import oracle.sql.CLOB;

@Controller
public class JnitboardLatestController {
	
	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService infoService;

	@Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

	@Resource(name = "jnitrscpageService")
    private JnitrscpageService jnitrscpageService;

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_LATEST_PATH = "board" + SEPERATOR + "_latest" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    /**
     * board_id : Board ID (Required)
     * fields : filed names for import (Seperator : , )(default : title,created)
     * count : Number for import articles
     * type : View Type
     * base_path : content page Base URL
     * wrap_class : view Wraper CSS Class
     * */
    @RequestMapping(value = "/board/latest.do")
	public String latest(
			@RequestParam("board_id") java.lang.String boardIds,
			HttpServletRequest request,
			ModelMap model)
	throws Exception {
		String error = "";
		String boardId = boardIds.split(",")[0];

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
		Calendar newCal = Calendar.getInstance();
		newCal.add(Calendar.DATE, -1);
		String today = sdfDate.format(newCal.getTime());
		model.addAttribute("today",today);
		JnitboardinfoVO infoVO = new JnitboardinfoVO();
		try{
			infoVO = JnitboardinfoController.getBoardInfoVO(request, boardId);
		}catch(FileNotFoundException e){
			//log.error(e.getMessage());
	    	infoVO.setBoardId(boardId);
	    	infoVO = infoService.selectJnitboardinfo(infoVO);
		}catch(Exception e){
			log.error(e.getMessage());
		}
		model.addAttribute("infoVO",infoVO);

		String fieldsValue = "".equals(NullUtil.nullString(request.getParameter("fields"))) ? "content,created" : request.getParameter("fields");
		String[] fields = fieldsValue.split(",");
		String root = PathUtil.getRealPath(request);
		String type = NullUtil.nullString(request.getParameter("type"));
		String skin = NullUtil.nullString(request.getParameter("skin"));
		String basePath = NullUtil.nullString(request.getParameter("base_path"));
		String wrapClass = NullUtil.nullString(request.getParameter("wrap_class"));
		String miniboardSkin = NullUtil.nullString(request.getParameter("miniboardSkin"));
		String siteId = NullUtil.nullString(request.getParameter("siteId"));
		String latestImgUrls = NullUtil.nullString(request.getParameter("latestImgUrls"));
		String useHit = NullUtil.nullString(request.getParameter("useHit"));
		String reload = NullUtil.nullString(request.getParameter("reload"));
		String category = NullUtil.nullString(request.getParameter("category"));

		int count = NullUtil.nullInt(request.getParameter("count"));
		int cntLen = NullUtil.nullInt(request.getParameter("cntLen"));
		cntLen = (cntLen == 0 ? 15 : cntLen);
		count = count == 0 ? 4 : count;

		//파일관리시스템 미니게시판 설정
		try {
			JSONObject mgmtJSON = new JSONObject().fromObject(CmsHandler.readFile(root+"board/_mgmt/"+miniboardSkin+".json"));
			type = NullUtil.nullString(mgmtJSON.get("boardSkin").toString());
			siteId = NullUtil.nullString(mgmtJSON.get("siteId").toString());
			skin = NullUtil.nullString(mgmtJSON.get("mgmtNm").toString());
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			if("true".equals(deDug)) log.debug(e.getMessage());
		}

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("fields", fieldsValue);
		Calendar cal = Calendar.getInstance();

		String latestDirPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + BOARD_LATEST_PATH;
		File latestDir = new File(latestDirPath);
		String fileNm =  boardIds.replace(",", "_") + "_" + count + "_" + miniboardSkin + "_" + useHit + "_" + cntLen + "_" + URLEncoder.encode(category, "UTF-8");
				//EgovFileScrty.encode(category);
		String latestPath =  latestDir + SEPERATOR + fileNm + ".json";

		if(!latestDir.exists()){
			latestDir.mkdir();
		}
		File dataFile = new File(latestPath);
		Boolean hasFile = false;
		Boolean equalData = false;
		if(!dataFile.exists()){
			hasFile = false;
		}else{
			hasFile = true;
		}

		if(hasFile){

			JsonValueProcessor beanProcessor = new JavaUtilDateJsonValueProcessor();
			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(java.util.Date.class, beanProcessor);

			try{
				String JsonStr = FileStream.readFileToString(dataFile, "UTF-8");
	    		jsonObj = JSONObject.fromObject(JsonStr, jsonConfig);

				//log.debug("time gap : " + (cal.getTimeInMillis() - dataFile.lastModified()));
				//5분미만일경우 최근게시물 캐싱 설정이 바뀌었는지 확인하고 바뀌거나 5분이 지난 데이터는 새로 로드한다.
				if( (cal.getTimeInMillis() - dataFile.lastModified()) < 60000 * 5){
					equalData = (jsonObj.get("fields").equals(fieldsValue) && jsonObj.getString("count").equals(String.valueOf(count)) );
				}else{
					equalData = false;
				}

			}catch(net.sf.json.JSONException e){
				log.debug("net.sf.json.JSONException");
				equalData = false;
			}


		}
		if("Y".equals(reload)){
			equalData = false;
		}
		List resultList = new ArrayList();
		List resultTotalList = new ArrayList();

		if(equalData){
			resultList = (List) jsonObj.getJSONArray("resultList");

			Iterator itr = resultList.iterator();
			while(itr.hasNext()){
				JsonValueProcessor beanProcessor = new JavaUtilDateJsonValueProcessor();
				JsonConfig jsonConfig = new JsonConfig();
				jsonConfig.registerJsonValueProcessor(java.util.Date.class, beanProcessor);
				JSONObject tmpMap = JSONObject.fromObject(itr.next(),jsonConfig);
				tmpMap.put("created",String.valueOf(String.valueOf(tmpMap.get("created"))));
				if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){

				}else{
					if(tmpMap.get("date01") != null && NullUtil.nullString(tmpMap.get("date01").toString()).equals("null")){
						tmpMap.put("date01",sdf.parse(String.valueOf(tmpMap.get("date01"))));
					}
					if(tmpMap.get("date02") != null && NullUtil.nullString(tmpMap.get("date02").toString()).equals("null")){
						tmpMap.put("date02",sdf.parse(String.valueOf(tmpMap.get("date02"))));
					}

				}
			}
		}else{

			//최근게시물 최초 접근시 기존 data json 파일을 기존데이터와 동일하게 만들면서 최종수정일 변경.
			this.latestBoardDataFile(root, latestPath);
			//변경후 data json을 갱신함. (파일 생성시 동시접속자가 많을때 모든 동시접속자가 DB 접근해서 파일 생성을 막기위함)

			JnitboarddbDefaultVO searchVO = new JnitboarddbDefaultVO();
			searchVO.setBoardId("bbs_1000000000000000");
			searchVO.setRecordCountPerPage(count);
			searchVO.setFirstIndex(0);
			searchVO.setLastIndex(count);//2014-01-27 오라클

			/*
			 * 불러오는 첫번째 게시판의 옵션을 정렬기준으로 정함.
			 * 만약에 최근게시물 노출 설정이 되어 있을경우 이 옵션 searchVO.setOrderbyCondition("1") 이 적용됨.
			 */
			searchVO.setOrderbyCondition(infoVO.getBoardSort());
			if("2".equals(infoVO.getBoardSort())){
				searchVO.setIdxCondition("0");
			}
			if(infoVO.getUseLatestlist() == 1) searchVO.setOrderbyCondition("1");

			if("schedule".equals(type) || "calendar".equals(type)){
				if("schedule".equals(type)){
					searchVO.setSearchDate(cal.getTime());
				}
				if("calendar".equals(type)){
					searchVO.setSearchMonth(cal.getTime());
				}
			}
			searchVO.setWithFile("1");
			searchVO.setWithContent("1");
			searchVO.setOrderbyHitYn("true".equals(useHit) ? "Y" : "N");
			searchVO.setLatestYn("Y");
			searchVO.setWithContent("1");
			searchVO.setFileQueryYn("Y");
			searchVO.setFileQuery(makeLatestFileQuery(request, boardIds));
			searchVO.setQueryYn("Y");
			searchVO.setQuery(makeLatestQuery(request, boardIds));
			if(!"".equals(category)){
				ArrayList<String> categoryList = new ArrayList();
				Collections.addAll(categoryList, category.split(","));
				searchVO.setPageYn("N");
				searchVO.setCategoryCondition("1");
				searchVO.setSelectList(categoryList);
			}
			resultTotalList = jnitboarddbService.selectList(searchVO);

			searchVO.setPageYn("Y");
			resultList = jnitboarddbService.selectList(searchVO);

			Iterator itr = resultList.iterator();
			while(itr.hasNext()){
				EgovMap tmpMap = (EgovMap) itr.next();
				String tmp1 = NullUtil.nullString(String.valueOf(tmpMap.get("tmp1")));
				String tmp2 = NullUtil.nullString(String.valueOf(tmpMap.get("tmp2")));
				JnitboarddbVO dbVO = new JnitboarddbVO();
				dbVO.setBoardId(tmp1);
				dbVO.setId(Integer.parseInt(tmp2));
				dbVO.setSelectCondition("1");
				try {
					dbVO = jnitboarddbService.select(dbVO);
					tmpMap.put("writer", dbVO.getWriter());
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					log.error(e.getMessage());
				}
				if(DBType.getDbTypeBoolean("oracle")){
					CLOB content = (CLOB) tmpMap.get("content");
					if(content != null){
						Reader reader = null;
						BufferedReader br = null;
						String contentSrc = "";
						try {
							reader = content.getCharacterStream();
							br = new BufferedReader(reader);
							String line = "";
							while ((line = br.readLine()) != null) {
								contentSrc += line+"\r\n";
							}
							tmpMap.put("content", contentSrc);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						} finally {
							br.close();
							reader.close();
						}
					}
				}else if(DBType.getDbTypeBoolean("tibero")){
					com.tmax.tibero.jdbc.TbClob content = (com.tmax.tibero.jdbc.TbClob) tmpMap.get("content");
					if(content != null){
						Reader reader = null;
						BufferedReader br = null;
						String contentSrc = "";
						try {
							reader = content.getCharacterStream();
							br = new BufferedReader(reader);
							String line = "";
							while ((line = br.readLine()) != null) {
								contentSrc += line+"\r\n";
							}
							tmpMap.put("content", contentSrc);
						} catch (NullPointerException e){
							log.error(e.getMessage());
						} catch (Exception e) {
							log.error(e.getMessage());
						} finally {
							br.close();
							reader.close();
						}
					}
				}
				if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){

				}else{
					tmpMap.put("created",String.valueOf(tmpMap.get("created")));
					if(tmpMap.get("date01") != null)
						tmpMap.put("date01",sdf.format(tmpMap.get("date01")));
					if(tmpMap.get("date02") != null)
						tmpMap.put("date02",sdf.format(tmpMap.get("date02")));
				}
			}
			jsonObj.put("resultTotalList", resultTotalList.size());
			jsonObj.put("fields", fieldsValue);
			jsonObj.put("count", count);
			jsonObj.put("resultList", new JSONArray().fromObject(resultList));

			FileWriter latestFileW = new FileWriter(latestPath);
			latestFileW.write(jsonObj.toString());
			latestFileW.flush();
			latestFileW.close();
		}

		if("schedule".equals(type) || "calendar".equals(type)){
			if("schedule".equals(type)){
				int dowInt = cal.get(Calendar.DAY_OF_WEEK); //요일
				int month = cal.get(Calendar.MONTH)+1; //요일
				HashMap<String,String> dow = new HashMap<String,String>();
				HashMap<String,String> day = new HashMap<String,String>();
				HashMap<String,String> fmtdate = new HashMap<String,String>();
				dow.put(String.valueOf(dowInt), "class=\"on\"");
				model.addAttribute("dow",dow);
				Calendar calTmp = Calendar.getInstance();
				calTmp.add(Calendar.DATE, -dowInt+1);
				for(int i=1;i<=7;i++){
					day.put(String.valueOf(i), String.valueOf(calTmp.get(Calendar.DATE)));
					fmtdate.put(String.valueOf(i), sdfDate.format(calTmp.getTime()));
					calTmp.add(Calendar.DATE, 1);
				}
				model.addAttribute("month",month);
				model.addAttribute("day",day);
				model.addAttribute("fmtdate",fmtdate);
			}
			if("calendar".equals(type)){
				//달력처리
				String searchDateStr = NullUtil.nullString(request.getParameter("searchDate"));
				try{
					if(!searchDateStr.equals("")) cal.setTime(sdfDate.parse(searchDateStr));
				} catch (NullPointerException e){
					log.error(e.getMessage());
				}catch(Exception e){
					log.error(e.getMessage());
				}
				String []weeks = {"일","월","화","수","목","금","토"};
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
				//어제
				cal.add(Calendar.DATE, -1);
				String calPrevDateStr = sdfDate.format(cal.getTime());
				//내일
				cal.add(Calendar.DATE, 2);
				String calNextDateStr = sdfDate.format(cal.getTime());
				cal.set(Calendar.DATE, 1);
				int calDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
				model.addAttribute("calPrevMonth", calPrevMonthStr);
				model.addAttribute("calNextMonth", calNextMonthStr);
				model.addAttribute("calPrevDate", calPrevDateStr);
				model.addAttribute("calNextDate", calNextDateStr);
				model.addAttribute("calLastDay", calLastDay);
				model.addAttribute("calCurrentDay", calCurrentDay);
				model.addAttribute("calCurrentWeek", calCurrentWeek);
				model.addAttribute("calCurrentStr", calCurrentStr);
				model.addAttribute("calCurrentYear", calCurrentYear);
				model.addAttribute("calCurrentMonth", calCurrentMonth);
				model.addAttribute("calCurrentDate", calCurrentDate);
				model.addAttribute("calDayOfWeek", calDayOfWeek);
				//End of 달력처리
			}
		}
		model.addAttribute("category", category);
		model.addAttribute("latestTotal", jsonObj.get("resultTotalList"));
		model.addAttribute("cntLen", cntLen);
		model.addAttribute("fileNm", fileNm);
		model.addAttribute("count", count);
		model.addAttribute("useHit", useHit);
		model.addAttribute("boardIds", boardIds);
		model.addAttribute("type", type);
		model.addAttribute("skin", skin);
		model.addAttribute("boardId", boardId);
		model.addAttribute("basePath", basePath);
		model.addAttribute("wrapClass", wrapClass);
		model.addAttribute("siteId", siteId);
		model.addAttribute("mgmtId", miniboardSkin);
		model.addAllAttributes(modelAttributeInfoVOMap(model, boardIds, basePath, "basePathMap"));					//콘텐츠 경로
		model.addAllAttributes(modelAttributeInfoVOMap(model, boardIds, latestImgUrls, "imgUrlMap"));				//이미지경로
		model.addAttribute("DBType", DBType.getDbTypeString());
		model.addAttribute("resultList", resultList);
		model.addAttribute("boardInfoMap", infoService.makeBoardInfoMap(request, boardIds));						//new icon 설정
		//if("true".equals(deDug)) log.debug("resultList ="+resultList);
		if("Y".equals(reload)){
			return "/jnit/util/json";
		}
		return "jnit/board/latest";
	}

    /**
	 * bbs_1000000000000000 게시판의 조회할 쿼리문을 생성한다.
	 * @param request
	 * @param boardIds - 여러개 boardId
	 * @param searchVO
	 * @return 쿼리문
	 * @throws Exception
	 */
	private String makeLatestQuery(HttpServletRequest request, String boardIds)throws Exception{
		String str = "";
		boardIds = NullUtil.nullString(boardIds);
		if(!"".equals(boardIds)){
			String[] boardId = boardIds.split(",");

			for(int i=0; i<boardId.length; i++){

				//게시판  ID 유효성 체크
				if(this.boardIdValidate(boardId[i])){
					str += (!"".equals(str) ? " OR " : "")+"TMP1 = '"+boardId[i]+"'";
				}
			}
			if(!"".equals(str)) str = "AND ("+str+")";
			if("true".equals(deDug)) log.debug("str ="+str);
		}
		return str;
	}

	/** 게시판이 존재하는지 유효성 체크
	 * @param boardId
	 * @return boolean
	 */
	private boolean boardIdValidate(String boardId) {

		boolean result = false;

		JnitboardinfoDefaultVO searchVO = new JnitboardinfoDefaultVO();
		searchVO.setSearchCondition("0");
		searchVO.setSearchKeyword(boardId);

		int cnt = infoService.selectJnitboardinfoListTotCnt(searchVO);

		if(cnt == 1){
			result = true;
		}else{
			result = false;
		}

		return result;

	}

	/**
	 * bbs_1000000000000000 게시판의 조회할 LEFT JON FILE 쿼리문을 생성한다.
	 * @param request
	 * @param boardIds - 여러개 boardId
	 * @param searchVO
	 * @return 쿼리문
	 * @throws Exception
	 */
	private String makeLatestFileQuery(HttpServletRequest request, String boardIds)throws Exception{
		String str = "";
		boardIds = NullUtil.nullString(boardIds);
		if(!"".equals(boardIds)){
			String[] boardId = boardIds.split(",");
			for(int i=0; i<boardId.length; i++){
				if(this.boardIdValidate(boardId[i])){
					str += (!"".equals(str) ? " OR " : "")+"BOARD_ID = '"+boardId[i]+"'";
				}
			}
			if(!"".equals(str)) str = "AND ("+str+")";
			if("true".equals(deDug)) log.debug("str ="+str);
		}
		return str;
	}

	private ModelMap modelAttributeInfoVOMap(ModelMap model, String boardIds, String strs, String mapName)throws Exception{
		if(!"".equals(strs) && !"".equals(boardIds)){
			String[] str = strs.split(",");
			String[] boardId = boardIds.split(",");
			HashMap<String, String> infoMap = new HashMap<String, String>();
			try {
				for(int i=0; i<boardId.length; i++){
					infoMap.put(boardId[i], str[i]);
				}
			} catch (NullPointerException e){
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			model.addAttribute(mapName, infoMap);
		}
		return model;
	}

	private boolean latestBoardDataFile(String root, String filePath) throws Exception{
		boolean isSuccess = false;
		FileWriter latestFileW = new FileWriter(filePath);
		String JsonStr = "";
		JSONObject jsonObj = new JSONObject();
		try{
			JsonStr = FileStream.readFileToString(new File(filePath), "UTF-8");
			isSuccess = true;
		}catch(FileNotFoundException e){
			JsonStr = jsonObj.toString();
		}catch(JSONException e){
			JsonStr = jsonObj.toString();
		}catch(Exception e){
			JsonStr = jsonObj.toString();
		}
		latestFileW.write(JsonStr);
		latestFileW.flush();
		latestFileW.close();
		return isSuccess;
	}
}