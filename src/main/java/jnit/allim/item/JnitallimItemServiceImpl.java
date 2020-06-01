/**
 * @version 3.2.0.1
 */
package jnit.allim.item;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;
import jnit.allim.group.JnitallimGroupController;
import jnit.allim.group.JnitallimGroupService;
import jnit.allim.group.JnitallimGroupVO;
import jnit.cms.CmsManageSub3Controller;
import jnit.cms.CmsPageViewController;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mgmt.mgmtUtil;
import jnit.cms.site.JnitcmssiteVO;
import jnit.util.PathUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @Class Name : JnitallimItemServiceImpl.java
 * @Description : JnitallimItem Business Implement class
 * @Modification Information
 *
 * @author JNITALLIMITEM
 * @since 2012.04.24
 * @version 1.0
 * @see
 *
 *  Copyright (C)  All right reserved.
 */

@Service("jnitallimItemService")
public class JnitallimItemServiceImpl extends EgovAbstractServiceImpl implements
        JnitallimItemService {

	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitallimGroupService")
	private JnitallimGroupService jnitallimGroupService;

    @Resource(name="jnitallimItemDAO")
    private JnitallimItemDAO jnitallimItemDAO;

    /** ID Generation */
    @Resource(name="jnitALLIM_ITEM_IdGnrService")
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitallim_item을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitallimItemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitallimItem(JnitallimItemVO vo) throws Exception {

    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setItemId(id);

    	jnitallimItemDAO.insertJnitallimItem(vo);
    	//TODO 해당 테이블 정보에 맞게 수정
        return null;
    }

    /**
	 * jnitallim_item을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitallimItemVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitallimItem(JnitallimItemVO vo) throws Exception {
        jnitallimItemDAO.updateJnitallimItem(vo);
    }

    public void updateSort(JnitallimItemVO vo) throws Exception {
        jnitallimItemDAO.updateSort(vo);
    }

    /**
	 * jnitallim_item을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitallimItemVO
	 * @return void형
	 * @exception Exception
	 */
    public void deleteJnitallimItem(JnitallimItemVO vo) throws Exception {
        jnitallimItemDAO.deleteJnitallimItem(vo);
    }

    /**
	 * jnitallim_item을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitallimItemVO
	 * @return 조회한 jnitallim_item
	 * @exception Exception
	 */
    public JnitallimItemVO selectJnitallimItem(JnitallimItemVO vo) throws Exception {
        JnitallimItemVO resultVO = jnitallimItemDAO.selectJnitallimItem(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitallim_item 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_item 목록
	 * @exception Exception
	 */
    public List<?> selectJnitallimItemList(JnitallimItemDefaultVO searchVO) throws Exception {
        return jnitallimItemDAO.selectJnitallimItemList(searchVO);
    }

    /**
	 * jnitallim_item 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_item 목록
	 * @exception Exception
	 */
    public List<?> selectSortMax(JnitallimItemDefaultVO searchVO) throws Exception {
        return jnitallimItemDAO.selectSortMax(searchVO);
    }

    /**
	 * jnitallim_item 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_item 총 갯수
	 * @exception
	 */
    public int selectJnitallimItemListTotCnt(JnitallimItemDefaultVO searchVO) {
		return jnitallimItemDAO.selectJnitallimItemListTotCnt(searchVO);
	}

    /**
     * jnitallim_item 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitallimItem() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();

    	egovIdGnrStrategy.setPrefix("ITEM");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(4);

        return egovIdGnrStrategy.makeId( (String)jnitallimItemDAO.getLastIdJnitallimItem() );
    }

    /**
     * 알리미 기본 DB를 생성한다.
     * @param request
     * @param jnitcmssiteVO
     * @param mgmtType - 타입
     * @param fileCopyType - 파일경로
     * @throws Exception
     * {@link CmsManageSub3Controller#addJnitcmssite}
     */
    public void insertAllim(HttpServletRequest request,JnitcmssiteVO jnitcmssiteVO, String mgmtType, String fileCopyType)throws Exception{

    	Calendar calendar = Calendar.getInstance();
		Calendar calendar2 = Calendar.getInstance();
		calendar2.set((Calendar.YEAR+1), (Calendar.MONTH+1), Calendar.DATE);

    	JnitallimGroupVO groupVO = new JnitallimGroupVO();
    	groupVO.setGroupNm("SampleAllimView");
    	groupVO.setSearchCondition("3");
    	groupVO.setSearchKeyword("SampleAllimView");

    	int isExists = jnitallimGroupService.selectJnitallimGroupListTotCnt(groupVO);

    	if(isExists == 0){
    		groupVO.setGroupWidth("100");
        	groupVO.setGroupHeight("100");
        	groupVO.setGroupType(mgmtType);
        	groupVO.setGroupClassName("Sample");
        	groupVO.setGroupChangeTime("5");
        	groupVO.setGroupCategory("allimView");
        	String id = jnitallimGroupService.insertJnitallimGroup(groupVO);

        	JSONArray jsonArray = mgmtUtil.mgmtFileCopy(request, jnitcmssiteVO.getSitePath(), mgmtType, fileCopyType);

         	if(!jsonArray.isEmpty()){
         		for(int i=0; i<jsonArray.size(); i++){
         			JSONObject JSON =  (JSONObject) jsonArray.get(i);

         			if(JSON.get("fileJSON") != null){
         				JSONArray jsonArray2 = (JSONArray) JSON.get("fileJSON");

         				for(int j=0; j<jsonArray2.size(); j++){
         					JSONObject JSON2 = (JSONObject) jsonArray2.get(j);
         					JnitallimItemVO itemVO = new JnitallimItemVO();
             				itemVO.setGroupId(id);
             				itemVO.setItemType(mgmtType);
             				itemVO.setItemTarget("_blank");
             				itemVO.setItemStartdate(calendar.getInstance().getTime());
             				itemVO.setItemEnddate(calendar2.getInstance().getTime());
             				try {
             					itemVO.setItemLink(JSON2.get("itemLink").toString());
             					itemVO.setItemUrl(JSON2.get("itemUrl").toString());
             					itemVO.setItemOrigin(JSON2.get("itemOrigin").toString());
                 				itemVO.setItemAlt(JSON2.get("itemAlt").toString());
    						} catch (Exception e) {

    						}
    						insertJnitallimItem(itemVO);
         				}
         			}
         		}
         	}
    	}
    }

    public Boolean makeAllimJSP(HttpServletRequest request
			, String grpId
			, String groupCategory
			, String type)throws Exception{
		String root = PathUtil.getRealPath(request);
		StringBuffer sb = new StringBuffer();
        String html = "";
        String htmlDir = root +"WEB-INF/jsp/jnit/allim/make/"+type;
        HttpURLConnection conn = null;
        InputStreamReader isr = null;
        BufferedReader br = null;

		JnitallimGroupVO grpVO = new JnitallimGroupVO();
		grpVO.setGroupId(grpId);
		JnitallimGroupVO grpValue = jnitallimGroupService.selectJnitallimGroup(grpVO);

		JnitallimGroupVO groupVO = new JnitallimGroupVO();
		groupVO.setSearchCondition("0"); //3
		groupVO.setSearchKeyword(grpId);
		List grpResult = jnitallimGroupService.selectGroupList(groupVO);
		int grpResultSize = grpResult.size();

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




		JSONObject jsonObj = new JSONObject();
		ObjectMapper objectMapper = new ObjectMapper();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		objectMapper.setDateFormat(df);
		String carAsString = objectMapper.writeValueAsString(grpResult);
		String grpValueString = objectMapper.writeValueAsString(grpValue);
		jsonObj.put("resultList", carAsString);
		jsonObj.put("grpValue", grpValueString);

		String jsonString = jsonObj.toString().replaceAll("\"", "\\\\\"");
		jsonString = jsonString.replace("\\\\\"", "\\\\\\\"");
		jsonString = jsonString.replaceAll("<\\\\/", "</");
		jsonString = jsonString.replaceAll("\\\\r", " ");
		jsonString = jsonString.replaceAll("\\\\n", " ");
		sb.append(
				"<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>\r\n"
				+"<% \r\n"
				+"JsonValueProcessor beanProcessor = new JavaUtilDateJsonValueProcessor();\r\n"
				+"JsonConfig jsonConfig = new JsonConfig(); \r\n"
				+"jsonConfig.registerJsonValueProcessor(java.util.Date.class, beanProcessor);\r\n"
				+"String JsonStr = \""+ jsonString +"\"; \r\n"
				+"List originList = new ArrayList();\r\n"
				+"JSONObject jsonObj = new JSONObject();\r\n"
				+"jsonObj = JSONObject.fromObject(JsonStr, jsonConfig); \r\n"
				+"originList = (List) jsonObj.getJSONArray(\"resultList\");\r\n"
				+"request.setAttribute(\"originList\",originList);\r\n"
				+"request.setAttribute(\"grpValue\",jsonObj.getJSONObject(\"grpValue\"));\r\n"
				+"List resultList = new ArrayList();  \r\n"
				+"SimpleDateFormat sdf = new SimpleDateFormat(\"yyyy-MM-dd HH:mm\");  \r\n"
				+"Date today = new Date();  \r\n"
				+"Iterator resultIterator = originList.iterator();  \r\n"
				+"for(int i=0; i<originList.size(); i++){  \r\n"
				+" Map resultEgovMap = (Map) resultIterator.next();  \r\n"
				+" String itemStartdate = String.valueOf(resultEgovMap.get(\"itemStartdate\"));  \r\n"
				+" String itemEnddate = String.valueOf(resultEgovMap.get(\"itemEnddate\"));  \r\n"
				+" int startCompare = today.compareTo(sdf.parse(itemStartdate)); \r\n"
				+" int endCompare = today.compareTo(sdf.parse(itemEnddate)); \r\n"
				+" if( startCompare > 0 && endCompare < 0 ){ \r\n"
				+"  resultList.add(resultEgovMap); \r\n"
				+" } \r\n"
				+"} \r\n"
				+" request.setAttribute(\"resultList\",resultList); \r\n"

				+"%> \r\n");

		if("banner".equals(type)){
			sb.append("<jsp:include page=\"/_common/allim/banner/bannerHeader.jsp\"></jsp:include>\r");
		}

		try {

			File htmlDirectory = new File(htmlDir);
	        if(!htmlDirectory.exists()) htmlDirectory.mkdirs();

			String after = sb.toString();
        	String listFileDir = htmlDir+"/"+grpId+"_list.jsp";
            CmsHandler.writeFile(listFileDir, after);
		} catch (Exception e) {
			log.error(e.getMessage());
			return false;
		}

		sb = new StringBuffer();

        try {
        	//TODO makeAllimJSP
        	sb.append("<%@ include file=\"/WEB-INF/jsp/jnit/allim/make/"+type+"/"+grpId+"_list.jsp\" %>\r");

    		FileReader fr = new FileReader(root +"WEB-INF/jsp/jnit/allim/skin/"+grpValue.getGroupType()+"/"+groupCategory+".jsp");
        	br = new BufferedReader(fr);
        	String line = "";
	        while ((line = br.readLine()) != null) {
	        	html += line + "\r\n";
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		} finally {
			if(isr != null)isr.close();
			if(br != null)br.close();
			if(conn != null)conn.disconnect();
		}
        sb.append(html.trim());
		String after = sb.toString();

		File htmlDirectory = new File(htmlDir);
        if(!htmlDirectory.exists()) htmlDirectory.mkdirs();
        try {
        	String htmlFileDir = htmlDir+"/"+grpId+".jsp";
            CmsHandler.writeFile(htmlFileDir, after);
		} catch (Exception e) {
			log.error(e.getMessage());
			return false;
		}
		return true;
	}

    /**
    *
    * @param request
    * @param useSkinDir - 지정 경로
    * @param readDir - 문자열 리턴경로
    * @return JSON
    * @throws Exception
    * {@link JnitallimGroupController#allimAjaxSkin}
    */
   public JSONObject allimFileMake(HttpServletRequest request, String useSkinDir, String readDir, int isFile)throws Exception{
   	JSONObject JSON = new JSONObject();
   	try {
   		File useSkinFile = new File(useSkinDir);
       	if(!useSkinFile.exists()){
       		String skinSrc = CmsHandler.readFile(readDir);
       		String[] regex = {	//스킨생성시 전역변수,함수명 같을시 동작 오류 있음.
       							//allimView
       							"popup","autocontrolvar","changeTime","popnum","popBanner"
       							//allimAnimete
       							,"fn_setTimeOut","fn_animate_stop","fn_animate_back","fn_animate_next"
       							,"firstId","firstId_replace","str_function","allimActiveId","allimZindex"
       							,"allimAnimateVisual_ul","set_timeOut"
       							//allimPopupVisual
       							,"allimPopup","allimPopupCon","aillmid1","aillmid2"
       							//popup
       							,"setCookie","getCookie"
       							//"box","layer_ok","nameOfCookie","itemcheck"
       							//allimIcon
       							,"icon"
       						 };
       		//치환
       		skinSrc = allimReplcae(skinSrc, regex, isFile);
       		CmsHandler.writeFile(useSkinDir, skinSrc);
       		JSON.put("status", "success");
       	}else{
       		JSON.put("status", "error");
       		JSON.put("code", "FAIL 1");
       		//log.debug("exists ==="+useSkinDir);
       	}
		} catch (Exception e) {
			//log.error(e.getMessage());
			JSON.put("status", "error");
   		JSON.put("code", "FAIL 2");
   		//log.debug("Exception ==="+useSkinDir);
		}
   	return JSON;
   }


   /**
    * default 경로하위 폴더의 파일이름을 리스트로 반환한다.
    * @param request
    * @return ArrayList
    * @throws Exception
    * {@link CmsPageViewController#allimSkinModelMap}
    * {@link JnitallimGroupController#addJnitallimGroupView}
    * {@link JnitallimGroupController#updateJnitallimGroupView}
    */
   public ArrayList allimFileNameList(HttpServletRequest request, String type, String condition)throws Exception{

   	ArrayList resultList = new ArrayList();
   	condition = NullUtil.nullString(condition);
   	String root = PathUtil.getRealPath(request);
   	String filelistDir = root+"WEB-INF/jsp/jnit/allim/default/"+type;
		File fileList = new File(filelistDir);
		if(fileList.exists()){
			FilenameFilter filenameFilter = null;
			String regex = "_code\\.jsp";


			if("".equals(condition)){
				filenameFilter = new FilenameFilter() {
					public boolean accept(File dir, String name) {
						if(name.indexOf("_code") == -1 || ".svn".equals(name) || name.indexOf("bannerMore_code") > -1 || name.indexOf("bannerMore") > -1){
							return false;
						}else{
							return true;
						}
					}
				};
			}else if("1".equals(condition)){
				filenameFilter = new FilenameFilter() {
					public boolean accept(File dir, String name) {
						if(name.indexOf("bannerMore_code") > -1 && !".svn".equals(name)){
							return true;
						}else{
							return false;
						}
					}
				};
			}
			String[] fileNm = fileList.list(filenameFilter);
			for(int i=0; i<fileNm.length; i++){
				resultList.add(mgmtUtil.fileNmReplaceAll(fileNmRelaceAll(fileNm[i],regex)));
			}
		}
		return resultList;
   }

   /**
    * 문자열을 치환한다.
    * @param str - 문자열
    * @param regex - 정규식 바꾸기
    * @return str
    * {@link allimUtil#allimFileNameList}
    */
   public static String fileNmRelaceAll(String str, String regex){
   	str = NullUtil.nullString(str);
   	if(!"".equals(str)){
			str = str.replaceAll(regex, "");
   	}
   	return str;
   }

   /**
    * 알리미 스킨생성시 변수명 처리를 한다.
    * @param str - 소스
    * @param regex - 치환될 변수명
    * @param isFile - 변수명 + isFile
    * @return str
    * {@link JnitallimGroupController#allimAjaxSkin}
    */
   public static String allimReplcae(String str, String[] regex, int isFile ){
   	if(regex.length > 0){
   		for(int i =0; i<regex.length; i++){
   			str = str.replace(regex[i], regex[i]+isFile);
   		}
   	}
   	return str;
   }
}
