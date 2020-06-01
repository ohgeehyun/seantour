package jnit.board.data;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.allim.group.JnitallimGroupVO;
import jnit.board.JnitboardLatestController;
import jnit.board.db.JnitboarddbDefaultVO;
import jnit.board.db.JnitboarddbService;
import jnit.board.db.JnitboarddbVO;
import jnit.board.info.JnitboardinfoDefaultVO;
import jnit.board.info.JnitboardinfoService;
import jnit.cms.handler.CmsHandler;
import jnit.com.service.JnitDefaultServiceImpl;
import jnit.com.util.DBType;
import jnit.util.PathUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import oracle.sql.CLOB;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : JnitBoardDataServiceImpl.java
 * @Description : ServiceImpl
 * @Modification Information
 *
 * @author
 * @since 2016. 12.22
 * @version 1.0
 * @see Copyright (C) by 김문기 All right reserved.
 */
@Service("jnitBoardDataService")
public class JnitBoardDataServiceImpl extends JnitDefaultServiceImpl implements JnitBoardDataService {

	private Logger log = Logger.getLogger(this.getClass());
	private static final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String BOARD_LATEST_PATH = "board" + SEPERATOR + "_latest" + SEPERATOR;
    public static final String BOARD_UPLOAD_PATH = uploadDir + SEPERATOR + "board" + SEPERATOR;
	// ////////////////////// Resource 선언 영역 ///////////////////////////////////////////////////////////////////
	@Resource(name = "jnitBoardDataDao")
	private JnitBoardDataDao jnitBoardDataDao;

	@Resource(name = "jnitboarddbService")
	private JnitboarddbService jnitboarddbService;

	@Resource(name = "jnitboardinfoService")
	private JnitboardinfoService infoService;
	// ////////////////////// Resource 선언 영역 끝 /////////////////////////////////////////////////////////////////

	// //////////////////////서비스 메소드 선언 영역 ///////////////////////////////////////////////////////////////////
	/**
	 * 리스트
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public List<JnitBoardDataVO> selectJnitBoardDataList(JnitBoardDataVO searchVO) throws Exception {
		List<JnitBoardDataVO> list = (List<JnitBoardDataVO>)jnitBoardDataDao.selectJnitBoardDataList(searchVO);
		if(list != null){
			for(JnitBoardDataVO result:list){

			}
		}
		return list;
	}

	/**
	 * 총갯수
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public Integer selectJnitBoardDataTot(JnitBoardDataVO searchVO) throws Exception {
		return jnitBoardDataDao.selectJnitBoardDataTot(searchVO);
	}

	/**
	 * Pk데이터
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public JnitBoardDataVO selectJnitBoardData(JnitBoardDataVO searchVO) throws Exception {
		JnitBoardDataVO result = jnitBoardDataDao.selectJnitBoardData(searchVO);
		return result;
	}

	/**
	 * 키가져오기
	 *
	 * @return
	 * @throws Exception
	 */
	public String selectKey() throws Exception {
		return jnitBoardDataDao.selectKey();
	}

	/**
	 * 추가 / 수정
	 *
	 * @param searchVO
	 * @param detailList
	 * @throws Exception
	 */
	public void writeJnitBoardData(HttpServletRequest request,JnitBoardDataVO searchVO) throws Exception {
		String mbrId = getLoginID();
		searchVO.setCreatedMbrId(mbrId);
		searchVO.setModifiedMbrId(mbrId);
		String ids = searchVO.getDataBoardIds();
		if(ids.indexOf(",") == 0){
			ids = ids.substring(1);
			searchVO.setDataBoardIds(ids);
		}
		String id = NullUtil.nullString(searchVO.getDataId());
		if("".equals(id)){
			id = selectKey();
			searchVO.setDataId(id);
			jnitBoardDataDao.insertJnitBoardData(searchVO);
		}else{
			JnitBoardDataVO result = selectJnitBoardData(searchVO);
			id = result.getDataId();
			jnitBoardDataDao.updateJnitBoardData(searchVO);
		}
		latestBoardDataUpdate(request,searchVO.getDataBoardIds());

	}

	/**
	 * 삭제
	 *
	 * @param searchVO
	 * @throws Exception
	 */
	public void deleteJnitBoardData(JnitBoardDataVO searchVO) throws Exception {
		String mbrId = getLoginID();
		searchVO.setCreatedMbrId(mbrId);
		searchVO.setModifiedMbrId(mbrId);
		jnitBoardDataDao.deleteJnitBoardData(searchVO);
	}
	/**
	 * 최근게시물 데이터 업데이트
	 *
	 * @param searchVO
	 * @throws Exception
	 */
	public void latestBoardDataUpdate(HttpServletRequest request,String boardId) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		JnitBoardDataVO searchVO = new JnitBoardDataVO();
		searchVO.setSearchKeyword(boardId);
		searchVO.setSearchCondition("boardIds");
		searchVO.setRecordCountPerPage(0);
		List boardDataList = jnitBoardDataDao.selectJnitBoardDataList(searchVO);
		Iterator boarditr = boardDataList.iterator();
		while(boarditr.hasNext()){
			JnitBoardDataVO resultMap = (JnitBoardDataVO)boarditr.next();
			String ids = NullUtil.nullString(resultMap.getDataBoardIds());//,bbs_001,bbs_002,bbs_003
			String category = NullUtil.nullString(resultMap.getDataCategory());
			
			JnitboarddbDefaultVO dbDefaultVO = new JnitboarddbDefaultVO();
			dbDefaultVO.setBoardId("bbs_1000000000000000");
			dbDefaultVO.setRecordCountPerPage(resultMap.getDataLimit());
			dbDefaultVO.setFirstIndex(0);
			dbDefaultVO.setLastIndex(resultMap.getDataLimit());
			dbDefaultVO.setOrderbyCondition(String.valueOf(resultMap.getDataOrder()));

			if("2".equals(String.valueOf(resultMap.getDataOrder()))){
				dbDefaultVO.setIdxCondition("0");
			}

			dbDefaultVO.setWithFile("1");
			dbDefaultVO.setWithContent("1");
			//dbDefaultVO.setOrderbyHitYn("true".equals(useHit) ? "Y" : "N");
			dbDefaultVO.setLatestYn("Y");
			dbDefaultVO.setWithContent("1");
			dbDefaultVO.setFileQueryYn("Y");
			dbDefaultVO.setFileQuery(makeLatestFileQuery(ids));

			dbDefaultVO.setQueryYn("Y");
			dbDefaultVO.setQuery(makeLatestQuery(ids));
			if(!"".equals(category)){
				ArrayList<String> categoryList = new ArrayList();
				Collections.addAll(categoryList, category.split(","));
				dbDefaultVO.setPageYn("N");
				dbDefaultVO.setCategoryCondition("1");
				dbDefaultVO.setSelectList(categoryList);
			}
			List resultTotalList = jnitboarddbService.selectList(dbDefaultVO);

			dbDefaultVO.setPageYn("Y");
			List resultList = jnitboarddbService.selectList(dbDefaultVO);

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
				} catch (Exception e) {

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
			StringBuffer sb = new StringBuffer();
			JSONObject jsonObj = new JSONObject();
			try{

				ObjectMapper objectMapper = new ObjectMapper();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				objectMapper.setDateFormat(df);
				String carAsString = objectMapper.writeValueAsString(resultList);
				jsonObj.put("resultList", carAsString);
				jsonObj.put("boardIds", boardId);
				String jsonString = jsonObj.toString().replaceAll("\"", "\\\\\"");
				jsonString = jsonString.replace("\\\\\"", "\\\\\\\"");
				jsonString = jsonString.replaceAll("<\\\\/", "</");
				jsonString = jsonString.replaceAll("\\\\r", " ");
				jsonString = jsonString.replaceAll("\\\\n", " ");

				sb.append(
						"<%@page import=\"net.sf.json.*\" %>"
						+"<%@ page import=\"jnit.util.JavaUtilDateJsonValueProcessor\"%>\r\n"
						+"<%@ page import=\"java.util.List\"%>\r\n"
						+"<%@ page import=\"java.util.ArrayList\"%>\r\n"
						+"<%@ page import=\"jnit.util.JavaUtilDateJsonValueProcessor\"%>\r\n"
						+"<%@ page import=\"net.sf.json.processors.JsonValueProcessor\"%>\r\n"
						+"<%@ page import=\"java.util.Date\"%>\r\n"
						+"<%@ page import=\"java.util.Iterator\"%>\r\n"
						+"<%@ page import=\"java.util.Map\"%>\r\n"
						+"<%@ page import=\"java.text.SimpleDateFormat\"%>\r\n");

				sb.append(
						"<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>\r\n"
						+"<% \r\n"
						+"JsonValueProcessor beanProcessor = new JavaUtilDateJsonValueProcessor();\r\n"
						+"JsonConfig jsonConfig = new JsonConfig(); \r\n"
						+"jsonConfig.registerJsonValueProcessor(java.util.Date.class, beanProcessor);\r\n"
						+"String JsonStr = \""+ jsonString +"\"; \r\n"
						+"List resultList = new ArrayList();\r\n"
						+"JSONObject jsonObj = new JSONObject();\r\n"
						+"jsonObj = JSONObject.fromObject(JsonStr, jsonConfig); \r\n"
						+"resultList = (List) jsonObj.getJSONArray(\"resultList\");\r\n"
						+"request.setAttribute(\"resultList\",resultList);\r\n"
						+"String basePath = NullUtil.nullString(request.getParameter(\"base_path\"));\r\n"
						+"String boardIds = jsonObj.get(\"boardIds\").toString();\r\n"
						+"if(!\"\".equals(basePath) && !\"\".equals(boardIds)){\r\n"
						+"	String[] str = basePath.split(\",\");\r\n"
						+"	String[] boardId = boardIds.split(\",\");\r\n"
						+"	HashMap<String, String> infoMap = new HashMap<String, String>();\r\n"
						+"	try {\r\n"
						+"		for(int i=0; i<boardId.length; i++){\r\n"
						+"			infoMap.put(boardId[i], str[i]);\r\n"
						+"		}\r\n"
						+"	} catch (Exception e) {\r\n"
						+"	}\r\n"
						+"	request.setAttribute(\"basePathMap\", infoMap);\r\n"
						+"}\r\n"
						+"%> \r\n");

				String latestDirPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + BOARD_LATEST_PATH;
				File latestDir = new File(latestDirPath);
				if(!latestDir.exists()){
					latestDir.mkdir();
				}

				String latestPath =  latestDir + SEPERATOR + resultMap.getDataId() + ".jsp";
				String after = sb.toString();
	            CmsHandler.writeFile(latestPath, after);
			}catch(Exception e){
				log.error(e.getMessage());
			}

		}

	}

	 /**
		 * bbs_1000000000000000 게시판의 조회할 쿼리문을 생성한다.
		 * @param boardIds - 여러개 boardId
		 * @param searchVO
		 * @return 쿼리문
		 * @throws Exception
		 */
		private String makeLatestQuery(String boardIds)throws Exception{
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
			}
			return str;
		}

	/**
	 * bbs_1000000000000000 게시판의 조회할 LEFT JON FILE 쿼리문을 생성한다.
	 * @param boardIds - 여러개 boardId
	 * @param searchVO
	 * @return 쿼리문
	 * @throws Exception
	 */
	private String makeLatestFileQuery( String boardIds)throws Exception{
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


	// //////////////////////서비스 메소드 선언 영역 끝 ///////////////////////////////////////////////////////////////////

	// /////////////////////private,protected 메소드 선언 영역
	// ///////////////////////////////////////////////////////////////////
	// /////////////////////private,protected 메소드 선언 영역 끝
	// ///////////////////////////////////////////////////////////////////
}
