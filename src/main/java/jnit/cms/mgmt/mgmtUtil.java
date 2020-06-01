/**
 * @version 3.2.0.2
 */
package jnit.cms.mgmt;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jnit.cms.CmsHelper;
import jnit.cms.CmsManageSub3Controller;
import jnit.cms.CmsManageSub4_1Controller;
import jnit.cms.CmsManageSub4_2Controller;
import jnit.cms.csshist.JnitcmscsshistService;
import jnit.cms.csshist.JnitcmscsshistVO;
import jnit.cms.handler.CmsHandler;
import jnit.cms.mgmtcategory.JnitcmsmgmtcategoryService;
import jnit.cms.mgmtcategory.JnitcmsmgmtcategoryVO;
import jnit.cms.mgmtitem.JnitcmsmgmtitemDefaultVO;
import jnit.cms.mgmtitem.JnitcmsmgmtitemService;
import jnit.cms.mgmtitem.JnitcmsmgmtitemVO;
import jnit.cms.scripthist.JnitcmsscripthistService;
import jnit.cms.scripthist.JnitcmsscripthistVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplService;
import jnit.cms.tpl.JnitcmstplVO;
import jnit.com.util.FileCopy;
import jnit.filego.enums.JnitFilegoFileType;
import jnit.filego.util.JnitFilegoUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class mgmtUtil {
	
	public static Log log = LogFactory.getLog(mgmtUtil.class);
	
	private final static String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
	 public static final String BOARD_LATEST_PATH = "board/_latest";
	private final static String deDug = EgovProperties.getPathProperty("Globals.Debug");
	/**
	 * 세션값으로 조회한다.
	 * @return siteVO
	 * @throws Exception
	 */
	static JnitcmssiteVO getSiteVO()throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

		JnitcmssiteService jnitcmssiteService = (JnitcmssiteService) wContext.getBean("jnitcmssiteService");

		String siteId = CmsHelper.getSessionSiteId(request);
        JnitcmssiteVO siteVO = new JnitcmssiteVO();
        try {
        	siteVO.setSiteId(siteId);
            siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
        } catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return siteVO;
	}

	/**
	 * SearchCondition 제어하여 List 리턴한다.
	 * @param condition - 2 : MGMT_TYPE = 'css', 3 : MGMT_TYPE = 'js' 검색조건
	 * @return mgmtList
	 * @throws Exception
	 */
	public static List mgmtList(String condition, JnitcmssiteVO siteVO)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

		JnitcmsmgmtService jnitcmsmgmtService = (JnitcmsmgmtService) wContext.getBean("jnitcmsmgmtService");

		try {
			if(siteVO.getSiteId() == null) siteVO = getSiteVO();
		} catch (NullPointerException e) {
			siteVO = getSiteVO();
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		JnitcmsmgmtVO mgmtVO = new JnitcmsmgmtVO();
		mgmtVO.setSiteId(siteVO.getSiteId());
        mgmtVO.setSiteIdYn("Y");

        //추가 확장
		if("2".equals(condition)){
	        mgmtVO.setSearchCondition("2");
	        mgmtVO.setPageYn("N");
	        mgmtVO.setOrderbyCondition("1");
		}else if("3".equals(condition)){
			mgmtVO.setSearchCondition("3");
	        mgmtVO.setPageYn("N");
	        mgmtVO.setOrderbyCondition("1");
		}

        List mgmtList = jnitcmsmgmtService.selectJnitcmsmgmtList(mgmtVO);
        return mgmtList;
	}

	/**
	 * 검색조건은 제어하여 파일을 제어한다.
	 * @param where - 수정멘트 위치
	 * @param condition - 2 : MGMT_TYPE = 'css' , 3 : MGMT_TYPE = 'js' 검색조건
	 * @param sitePath - 원하는 사이트경로에 생성 null이면 siteVO의 값을 이용한다.
	 * @see {@link CmsManageSub3Controller#addJnitcmssite}
	 * {@link CmsManageSub4_1Controller#updateJnitcmstpl}
	 * {@link CmsManageSub4_2Controller#addJnitcmstpl},{@link CmsManageSub4_2Controller#updateJnitcmstpl}
	 * {@link JnitcmsmgmtController#addJnitcmsmgmt},{@link JnitcmsmgmtController#updateJnitcmsmgmt}
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean writeFile(String where, String cssCondition, String jsConditon, JnitcmssiteVO siteVO)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		try {
			Calendar calendar = Calendar.getInstance();

			try {
				if(siteVO.getSiteId() == null) siteVO = getSiteVO();
			}catch (NullPointerException e) {
				siteVO = getSiteVO();
			}catch (Exception e) {
				if("true".equals(deDug)) log.debug("========== siteVO Exception ==========");
			}

			String root = PathUtil.getRealPath(request);
			cssCondition = NullUtil.nullString(cssCondition);
			//CSS List
			List mgmtList = mgmtList(cssCondition, siteVO);

	        Iterator mgmtIterator = mgmtList.iterator();
	        StringBuffer sb = new StringBuffer();
	        String message = "<%-- "+calendar.get(Calendar.YEAR)+"-"+(calendar.get(Calendar.MONTH)+1)+"-"+calendar.get(Calendar.DATE)
	        				+" "+calendar.get(Calendar.HOUR)+"시 "+calendar.get(Calendar.MINUTE)+"분"
	        				+" by."+where+"에서 수정되었습니다."
        					+" 헤더 핸들링 파일입니다. 직접수정하지 말아주시기 바랍니다. --%>";
	        sb.append(message+"\r\n");
	        sb.append(""
	        			+"<%@ page import=\"jnit.cms.mgmt.mgmtUtil\" %>\r\n"
	        			+"<% "
		        			+"String cssUrl = (String)request.getAttribute(\"javax.servlet.forward.request_uri\");"
		        			+"if(cssUrl == null) cssUrl = request.getServletPath().toString();"
		        			+"if(pageContext.getAttribute(\"handingType\") != null) cssUrl = pageContext.getAttribute(\"handingType\").toString();"
	        			+" %>\r\n");
	        for(int i=0; i<mgmtList.size(); i++){
	        	EgovMap mgmtEgovMap = (EgovMap) mgmtIterator.next();
	        	int hearderYn = Integer.parseInt(String.valueOf(mgmtEgovMap.get("mgmtHearderYn")));
	        	String mgmtType = String.valueOf(mgmtEgovMap.get("mgmtType"));
	        	String mgmtScriptType = String.valueOf(mgmtEgovMap.get("mgmtScriptType"));
	        	String mgmtNm = String.valueOf(mgmtEgovMap.get("mgmtNm"));

	        	if(hearderYn == 1){
	        		String str = "";
	        		String src = "${pageContext.request.contextPath}/"+siteVO.getSitePath()+"/common/"+mgmtType+"/"+mgmtNm+"."+mgmtType;

	        		if("css".equals(mgmtType)){
	        			str = ""
	        				+"<% "
	        					+"if(mgmtUtil.isExistJSON(cssUrl,\""+mgmtNm+"\",\""+mgmtType+"\",\""+siteVO.getSitePath()+"\" )){"
	        				+" %>"
	        					+"<link type=\""+mgmtScriptType+"\" href=\""+src+"\" media='all' rel='stylesheet' />"
	        				+"<% "
	        					+"}"
	        				+" %>";
	        		}
	        		sb.append(str+"\r\n");
	        	}
	        }

	        //JS List
	        List jsMgmtList = mgmtList(jsConditon, siteVO);

	        Iterator jsMgmtIterator = jsMgmtList.iterator();
	        StringBuffer jsSb = new StringBuffer();
	        	message = "<%-- "+calendar.get(Calendar.YEAR)+"-"+(calendar.get(Calendar.MONTH)+1)+"-"+calendar.get(Calendar.DATE)
	        				+" "+calendar.get(Calendar.HOUR)+"시 "+calendar.get(Calendar.MINUTE)+"분"
	        				+" by."+where+"에서 수정되었습니다."
        					+" 헤더 핸들링 파일입니다. 직접수정하지 말아주시기 바랍니다. --%>";
	        jsSb.append(message+"\r\n");
	        jsSb.append(""
        			+"<%@ page import=\"jnit.cms.mgmt.mgmtUtil\" %>\r\n"
        			+"<% "
	        			+"String jsUrl = (String)request.getAttribute(\"javax.servlet.forward.request_uri\");"
	        			+"if(jsUrl == null) jsUrl = request.getServletPath().toString();"
	        			+"if(pageContext.getAttribute(\"handingType\") != null) jsUrl = pageContext.getAttribute(\"handingType\").toString();"
        			+" %>\r\n");
	        for(int i=0; i<jsMgmtList.size(); i++){
	        	EgovMap mgmtEgovMap = (EgovMap) jsMgmtIterator.next();
	        	int hearderYn = Integer.parseInt(String.valueOf(mgmtEgovMap.get("mgmtHearderYn")));
	        	String mgmtType = String.valueOf(mgmtEgovMap.get("mgmtType"));
	        	String mgmtScriptType = String.valueOf(mgmtEgovMap.get("mgmtScriptType"));
	        	String mgmtNm = String.valueOf(mgmtEgovMap.get("mgmtNm"));

	        	if(hearderYn == 1){
	        		String str = "";
	        		String src = "${pageContext.request.contextPath}/"+siteVO.getSitePath()+"/common/"+mgmtType+"/"+mgmtNm+"."+mgmtType;

	        		if("js".equals(mgmtType)){
	        			str = ""
	        				+"<% "
	        					+"if(mgmtUtil.isExistJSON(jsUrl,\""+mgmtNm+"\",\""+mgmtType+"\",\""+siteVO.getSitePath()+"\")){"
	        				+" %>"
	        					+ "<script type=\""+mgmtScriptType+"\" src=\""+src+"\"></script>"
	        				+"<% "
	        					+"}"
	        				+" %>";
	        		}
	        		jsSb.append(str+"\r\n");
	        	}
	        }

	        String handingDir = root + siteVO.getSitePath()+"/common/config/handing";

	        File handingPath = new File(handingDir);
	        if(!handingPath.exists()){
	        	handingPath.mkdirs();
	        }

	        String cssHanding = handingDir+"/cssHanding.jsp";
	        String jsHanding = handingDir+"/jsHanding.jsp";
	        try {
	        	CmsHandler.writeFile(cssHanding, sb.toString());
	        	CmsHandler.writeFile(jsHanding, jsSb.toString());
	        } catch (IOException e){
	        	if("true".equals(deDug)) log.debug("========== CmsHandler.writeFile Exception ==========");
			} catch (Exception e) {
				if("true".equals(deDug)) log.debug("========== CmsHandler.writeFile Exception ==========");
			}
		} catch (IOException e){
			if("true".equals(deDug) )log.debug("========== Exception ==========");
			return false;
		} catch (Exception e) {
			if("true".equals(deDug) )log.debug("========== Exception ==========");
			return false;
		}
		return true;
	}

	/**
	 * 파일관리 등록후 사이트경로에 파일을 생성한다.
	 * @param request
	 * @param siteVO
	 * @param mgmtNm - 파일이름
	 * @param mgmtType - 타입
	 * @param scriptType - 형식
	 * @param mbrActId - 수정자
	 * @param src - 내용
	 * @param fileCopyType - default/common/img 경로의 하위 디렉토리 copy 대상 구분
	 * {@link CmsManageSub3Controller#addJnitcmssite}
	 * @throws Exception
	 */
	public static String mgmtWrite(HttpServletRequest request, JnitcmssiteVO siteVO, String mgmtType, String mbrActId, String fileCopyType)throws Exception{
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

		JnitcmsmgmtService jnitcmsmgmtService = (JnitcmsmgmtService) wContext.getBean("jnitcmsmgmtService");
		JnitcmscsshistService jnitcmscsshistService = (JnitcmscsshistService) wContext.getBean("jnitcmscsshistService");
		JnitcmsscripthistService jnitcmsscripthistService = (JnitcmsscripthistService) wContext.getBean("jnitcmsscripthistService");

		String id = "";

		JnitcmsmgmtVO mgmtVO = new JnitcmsmgmtVO();
		mgmtVO.setSiteId(siteVO.getSiteId());
        mgmtVO.setMgmtType(mgmtType);
        mgmtVO.setMgmtActId(mbrActId);
        mgmtVO.setMgmtHearderYn(1);

		JSONArray jsonArray = mgmtFileCopy(request, siteVO.getSitePath(), mgmtType, fileCopyType);
		if(!jsonArray.isEmpty()){
			for(int i=0; i<jsonArray.size(); i++){
				JSONObject JSON = (JSONObject) jsonArray.get(i);
				if("img".equals(mgmtType)){
					if(JSON.get("fileJSON") != null){
						JSONArray jsonArray2 = (JSONArray) JSON.get("fileJSON");
						for(int j=0; j<jsonArray2.size(); j++){
							JSONObject JSON2 = (JSONObject) jsonArray2.get(j);
							try {
								mgmtVO.setMgmtNm(JSON2.get("fileNm").toString());
						        mgmtVO.setMgmtFileNm(JSON2.get("fileNm").toString());
						        mgmtVO.setMgmtFileOrigin(JSON2.get("fileNm").toString());
						        mgmtVO.setMgmtFilePath(JSON2.get("filePath").toString());
						        mgmtVO.setMgmtFileUrl(JSON2.get("fileUrl").toString());
						        mgmtVO.setMgmtFilePathUrl(JSON2.get("filePathUrl").toString());
							} catch (NullPointerException e) {
								log.error(e.getMessage());
							}
					        id = jnitcmsmgmtService.insertJnitcmsmgmt(mgmtVO);
					        if(mgmtVO.getMgmtFileUrl() != null){
					        	String fileUrl  = mgmtVO.getMgmtFileUrl()+"&mgmtId="+id+"&siteId="+siteVO.getSiteId();
				            	mgmtVO.setMgmtFileUrl(fileUrl);
				            	mgmtVO.setMgmtId(id);
				        		jnitcmsmgmtService.updateJnitcmsmgmt(mgmtVO);
					        }
						}
					}
				}else{
					if(JSON.get("fileJSON") != null){
						JSONArray jsonArray2 = (JSONArray) JSON.get("fileJSON");
						for(int j=0; j<jsonArray2.size(); j++){
							JSONObject JSON2 = (JSONObject) jsonArray2.get(j);
							try {
								mgmtVO.setSearchKeyword(mgmtType);
								mgmtVO.setSearchCondition("0");
								try {
									int sortMax = jnitcmsmgmtService.selectMaxTotCnt(mgmtVO);
									mgmtVO.setMgmtSort(sortMax+1);
								} catch (Exception e) {
									//log.error(e.getMessage());
								}
								mgmtVO.setMgmtNm(JSON2.get("mgmtNm").toString());
								mgmtVO.setMgmtContent(JSON2.get("src").toString());
								mgmtVO.setMgmtScriptType(JSON2.get("scriptType").toString());
								id = jnitcmsmgmtService.insertJnitcmsmgmt(mgmtVO);

								//히스토리
								if("css".equals(mgmtType)){
									JnitcmscsshistVO csshistVO = new JnitcmscsshistVO();
							        csshistVO.setSiteId(siteVO.getSiteId());
							        csshistVO.setMgmtId(id);
							        csshistVO.setContent(JSON2.get("src").toString());
							        csshistVO.setMgmtActId(mbrActId);
							        csshistVO.setMgmtActIp(StringUtil.isExistString(request.getRequestURL().toString(),"local") == true ? "local" : request.getRemoteHost());
							        jnitcmscsshistService.insertJnitcmscsshist(csshistVO);
								}else if("js".equals(mgmtType)){
									JnitcmsscripthistVO jshistVO = new JnitcmsscripthistVO();
							        jshistVO.setSiteId(siteVO.getSiteId());
							        jshistVO.setMgmtId(id);
							        jshistVO.setContent(JSON2.get("src").toString());
							        jshistVO.setMgmtActId(mbrActId);
							        jshistVO.setMgmtActIp(StringUtil.isExistString(request.getRequestURL().toString(),"local") == true ? "local" : request.getRemoteHost());
							        jnitcmsscripthistService.insertJnitcmsscripthist(jshistVO);
								}
								//카테고리 표시설정 JSON 생성
								makeSiteCategoryJSON(request, siteVO, mgmtType, JSON2.get("mgmtNm").toString());
							} catch (NullPointerException e){
								log.error(e.getMessage());
							} catch (Exception e) {
								log.error(e.getMessage());
							}
						}
					}
				}
			}
		}
        return id;
	}

	/**
	 * 원하는 경로에 복사한후 JSONArray로 리턴한다.
	 * @param request
	 * @param sitePath - 사이트경로
	 * @param type - img 경로의 하위 디렉토리 copy 대상 구분
	 * @return
	 * @throws Exception
	 * {@link mgmtUtil#mgmtWrite}
	 * {@link allimUtil#insertAllim}
	 */
	public static JSONArray mgmtFileCopy(HttpServletRequest request, String sitePath ,String mgmtType ,String type )throws Exception{
		String root = PathUtil.getRealPath(request);
		String rootSite = root + sitePath;
		JSONObject element = new JSONObject();
		JSONObject fileElement = new JSONObject();
		JSONArray fileArray = new JSONArray();
		JSONArray jsonArray = new JSONArray();

		//추가확장
		if("img".equals(mgmtType) || "board/ui_images".equals(mgmtType)){
			element.put("baseDir", root + "/default/common/img/"+type);
			element.put("copyDir", rootSite + "/common/img");
			String filePathDir = sitePath+"/common/img/";
			String fileDir = element.get("baseDir").toString();
			File fileList = new File(fileDir);
			if(fileList.exists()){
				FilenameFilter filenameFilter = new FilenameFilter() {
					public boolean accept(File dir, String name) {
						if(".svn".equals(name)){
							return false;
						}else{
							return true;
						}
					}
				};
				String[] fileNm = fileList.list(filenameFilter);
				for (int i = 0; i < fileNm.length; i++) {
					fileElement.put("fileNm", fileNm[i]);
					fileElement.put("filePath", "");
					fileElement.put("fileUrl", "/cms/getFile.do?file="+fileNm[i]+"&orgname="+fileNm[i]+"&filePath="+filePathDir);
					fileElement.put("filePathUrl", "/"+sitePath+"/common/img/"+fileNm[i]);
					fileArray.add(fileElement);
					fileElement.clear();
				}
			}
			element.put("fileJSON", fileArray);
		}else if("css".equals(mgmtType) || "js".equals(mgmtType)){
			element.put("baseDir", root + "/default/common/"+mgmtType+"/"+type);
			element.put("copyDir", rootSite + "/common/"+mgmtType);

			String fileDir = element.get("baseDir").toString();
			File fileList = new File(fileDir);
			if(fileList.exists()){
				FilenameFilter filenameFilter = new FilenameFilter() {
					public boolean accept(File dir, String name) {
						if(".svn".equals(name)){
							return false;
						}else{
							return true;
						}
					}
				};
				String[] fileNm = fileList.list(filenameFilter);
				for (int i = 0; i < fileNm.length; i++) {
					String[] extFileNm = fileNm[i].split("\\."+mgmtType);
					fileNm[i] = extFileNm[0];
					fileElement.put("mgmtNm", fileNm[i]);
					fileElement.put("src" , CmsHandler.readFile(element.get("baseDir").toString()+"/"+fileNm[i]+"."+mgmtType));
					if("css".equals(mgmtType)) fileElement.put("scriptType", "text/css");
					if("js".equals(mgmtType)) fileElement.put("scriptType", "text/javascript");
					fileArray.add(fileElement);
					fileElement.clear();
				}
				element.put("fileJSON", fileArray);
			}
		}else if("base/allim".equals(type)){
			String subPath = EgovFormBasedFileUtil.getTodayString();
			element.put("baseDir", root + "/default/common/"+type);
			element.put("copyDir", uploadDir+subPath);

			String fileDir = element.get("baseDir").toString();
			File fileList = new File(fileDir);
			if(fileList.exists()){
				FilenameFilter filenameFilter = new FilenameFilter() {
					public boolean accept(File dir, String name) {
						if(".svn".equals(name)){
							return false;
						}else{
							return true;
						}
					}
				};
				String[] fileNm = fileList.list(filenameFilter);
				for (int i = 0; i < fileNm.length; i++) {
					fileElement.put("itemOrigin", fileNm[i]);
					fileElement.put("itemUrl", "/cms/getFile.do?path="+subPath+"&file="+EgovFileUploadUtil.getPhysicalFileName()+"&orgname="+fileNm[i]);
					if("Sample1.jpg".equals(fileNm[i])){
						fileElement.put("itemLink", "http://www.naver.com1");
						fileElement.put("itemAlt", "샘플 1번째 이미지입니다.");
					}
					if("Sample2.jpg".equals(fileNm[i])){
						fileElement.put("itemLink", "http://www.naver.com2");
						fileElement.put("itemAlt", "샘플 2번째 이미지입니다.");
					}
					fileArray.add(fileElement);
					fileElement.clear();
				}
				element.put("fileJSON", fileArray);
			}
		}


		//Final Add
		jsonArray.add(element);
		try {
			for(int i=0; i<jsonArray.size(); i++){
				JSONObject JSON = (JSONObject) jsonArray.get(i);
				String baseDir = JSON.get("baseDir").toString();
				String copyDir = JSON.get("copyDir").toString();

				File baseFile = new File(baseDir);
				File copyFile = new File(copyDir);
				if(!copyFile.exists()){
					copyFile.mkdirs();
				}
				//파일 경로 복사
				FileCopy.copyDirectory(baseFile, copyFile);
			}
		} catch (NullPointerException e) {
			if("true".equals(deDug)) log.debug("====== NullPointerException =====");
			if("true".equals(deDug)) log.debug("jsonArray : "+jsonArray);
			log.error(e.getMessage());
		}

		return jsonArray;
	}

	/**
	 * 파일이름을 확장자 체크하여 리턴한다.
	 * @param fileNm - 치환될 문자열
	 * @return fileNm
	 * @throws Exception
	 */
	public static String fileNmReplaceAll(String fileNm)throws Exception{
		fileNm = NullUtil.nullString(fileNm);
		fileNm = fileNm.replaceAll("\\.\\./", "");
		fileNm = fileNm.replaceAll("\\.\\.\\\\", "");
		return fileNm;
	}

	/**
	 * 원하는 필드값을 가져온다.
	 * @param sitePath - 사이트경로
	 * @param mgmtType - 파일관리 타입
	 * @param mgmtNm - 파일관리 이름
	 * @param field - 추출하고싶은 필드값
	 * @return
	 * @throws Exception
	 */
	public static String getMgmtField(String sitePath, String mgmtType, String mgmtNm, String field)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

		JnitcmssiteService jnitcmssiteService = (JnitcmssiteService) wContext.getBean("jnitcmssiteService");
		JnitcmsmgmtService jnitcmsmgmtService = (JnitcmsmgmtService) wContext.getBean("jnitcmsmgmtService");

		field = NullUtil.nullString(field);
		JnitcmssiteVO siteVO = new JnitcmssiteVO();
		try {
			siteVO.setSitePath(sitePath);
			siteVO.setSelectCondition("1");
			siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
		} catch (NullPointerException e){
			log.error(e.getMessage());
			field = "FAIL";
			return field;
		} catch (Exception e) {
			log.error(e.getMessage());
			field = "FAIL";
			return field;
		}
		JnitcmsmgmtVO mgmtVO = new JnitcmsmgmtVO();
		try {
			mgmtVO.setSiteId(siteVO.getSitePath());
			mgmtVO.setMgmtNm(mgmtNm);
			mgmtVO.setMgmtType(mgmtType);
			mgmtVO.setSelectCondition("1");
			mgmtVO = jnitcmsmgmtService.selectJnitcmsmgmt(mgmtVO);
		} catch (NullPointerException e){
			log.error(e.getMessage());
			field = "FAIL";
			return field;
		} catch (Exception e) {
			log.error(e.getMessage());
			field = "FAIL";
			return field;
		}
		if(mgmtVO.getMgmtId() != null){
			JSONObject JSON = new JSONObject().fromObject(mgmtVO);
			try {
				field = JSON.get(field).toString();
			} catch (NullPointerException e) {
				log.error(e.getMessage());
				field = "FAIL";
				return field;
			}
		}
		return field;
	}

	public static String updateDownloadCount(String siteId, String mgmtId, String count)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		JnitcmssiteService jnitcmssiteService = (JnitcmssiteService) wContext.getBean("jnitcmssiteService");
		JnitcmsmgmtService jnitcmsmgmtService = (JnitcmsmgmtService) wContext.getBean("jnitcmsmgmtService");
		String root = request.getSession().getServletContext().getRealPath("");
		String varUploadDir = "";
		try {
			JnitcmssiteVO siteVO = new JnitcmssiteVO();
			siteVO.setSiteId(siteId);
			siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);

			JnitcmsmgmtVO mgmtVO= new JnitcmsmgmtVO();
			mgmtVO.setSiteId(siteId);
			mgmtVO.setMgmtId(mgmtId);
			mgmtVO = jnitcmsmgmtService.selectJnitcmsmgmt(mgmtVO);
			String mgmtFileDir = root + mgmtVO.getMgmtFilePathUrl();

			File mgmtFile = new File(mgmtFileDir);
			if(mgmtFile.exists()){
				mgmtVO.setMgmtDownloadCount(NullUtil.nullInt(Integer.toString(mgmtVO.getMgmtDownloadCount()))+1);
				if("Y".equals(count)) jnitcmsmgmtService.updateJnitcmsmgmt(mgmtVO);
				varUploadDir = root+"/"+siteVO.getSitePath()+"/common/"+mgmtVO.getMgmtType()+"/";
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return varUploadDir;
	}
	/**
	 * 파일관리 시스템의 치환코드를 이용하여 치환한다. return 을 입력할경우 역치환
	 * @param str - 대상 문자열
	 * @param mgmtType - 타입
	 * @param skin - 스킨종류
	 * @param type - 치환,역치환종류
	 * @return 치환된 문자열
	 * @throws Exception
	 */
	public static String replaceMgmtSrc(String str, String mgmtType, String skin, String type)throws Exception{
		str = NullUtil.nullString(str);
		if(!"".equals(str)){
			HashMap<String, String> mgmtChangeCode = mgmtChangeCode(mgmtType, skin, type);
			Iterator itr = mgmtChangeCode.keySet().iterator();
			while (itr.hasNext()) {
				String key = (String) itr.next();
				str = str.replace(key, mgmtChangeCode.get(key));
			}
		}
		return str;
	}

	/**
	 * 파일관리 시스템의 치환코드를 리턴한다.
	 * @param mgmtType - 타입
	 * @param skin - 스킨종류
	 * @param type - 치환,역치환 종류
	 * @return HashMap<String, String> mgmtChangeCode
	 * @throws Exception
	 */
	public static HashMap<String, String> mgmtChangeCode(String mgmtType,String skin,String type)throws Exception{
		HashMap<String, String> mgmtChangeCode = new HashMap<String, String>();
		//추가확장
		if("boardLatest".equals(mgmtType)){
			//공용
			mgmtChangeCode.put("{-LOOP_E-}","</c:forEach>");
			mgmtChangeCode.put("{-BOARD_MAIN_TITLE-}", "<c:out value=\"${result.title}\"/>");
			mgmtChangeCode.put("{-BOARD_MAIN_TITLELINK-}", "<a href=\"${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}\" class=\"title\"><c:out value=\"${result.title}\" /></a>");
			mgmtChangeCode.put("{-BOARD_MAIN_CONTENT-}", "<c:set var=\"boardLatestContent\" value=\"${jtag:removeHtmlTag(fn:replace(fn:replace(fn:replace(result.content,'&nbsp;',''),'&lt;','<'),'&gt;','>'))}\"/><c:out value=\"${fn:substring(boardLatestContent,0,15)}\" escapeXml=\"false\" /><c:out value=\"${fn:length(boardLatestContent) > 15 ? '...' : ''}\"/>");
			mgmtChangeCode.put("{-BOARD_MAIN_WRITER-}", "<c:out value=\"${result.writer}\"/>");
			mgmtChangeCode.put("{-BOARD_TITLE-}", "<c:out value=\"${infoVO.boardTitle}\"/>");
			mgmtChangeCode.put("{-BOARD-MEDIA-IMGURL-}", "/upload/media/thumb_${result.ext18}${result.ext20}.jpg");
			mgmtChangeCode.put("{-BOARD-MEDIA-IS-IMGURL-}", "${!empty result.ext20}");
			mgmtChangeCode.put("{-BOARD-MAIN-IMGURL-}", "${imgUrlMap[result.tmp1]}");
			mgmtChangeCode.put("{-BOARD-MAIN-CIF-IMGURL-}", "${!empty imgUrlMap[result.tmp1]}");
			mgmtChangeCode.put("{-BOARD-MAIN-HIT-}", "<c:out value=\"${result.hit}\" />");
			if("main".equals(skin) || "schedule".equals(skin)){
				mgmtChangeCode.put("{-LOOP_S-}","<c:forEach var=\"result\" items=\"${resultList}\" varStatus=\"status\"><c:set var=\"created\" value=\"${result.created}\" /><fmt:parseDate value=\"${result.created}\" var=\"created\" pattern=\"yyyy-MM-dd HH:mm:ss\"/>");
				mgmtChangeCode.put("{-BOARD_MAIN_CREATED-}", "<fmt:formatDate value=\"${created}\" pattern=\"yyyy.MM.dd\" />");
			}else if("calendar".equals(skin)){
				mgmtChangeCode.put("{-LOOP_S-}", "<c:forEach var=\"result\" items=\"${resultList}\"><c:if test=\"${!empty result.date01 && result.date01 != 'null'}\"><c:set var=\"date01\" value=\"${result.date01}\" /><fmt:parseDate value=\"${result.date01}\" var=\"date01\" pattern=\"yyyy-MM-dd HH:mm:ss\"/></c:if>");
				mgmtChangeCode.put("{-BOARD_MAIN_CREATED-}", "<c:if test=\"${!empty result.date01 && result.date01 != 'null'}\"><fmt:formatDate value=\"${date01}\" pattern=\"dd\"/></c:if><c:if test=\"${empty date01 && result.date01 == 'null'}\">시작날짜를 수정해주시기 바랍니다.</c:if>");
			}else if("gallery".equals(skin)){
				mgmtChangeCode.put("{-LOOP_S-}", ""
												+"<c:forEach var=\"result\" items=\"${resultList}\" varStatus=\"status\">"
												+"<%"
													+"String mgmtId = (String)request.getAttribute(\"mgmtId\");"
													+"Map rst = (Map)pageContext.getAttribute(\"result\");"
													+"if(rst.get(\"fileUrl\") != null && !\"\".equals(rst.get(\"fileUrl\")) ){"
														+"String fileUrl = (String)rst.get(\"fileUrl\");"
														+"String[] fileUrlArr = fileUrl.split(\"/\");"
														+"fileUrlArr[fileUrlArr.length-1] = mgmtId+\"_\"+ fileUrlArr[fileUrlArr.length-1];"
														+"fileUrl = StringUtils.join(fileUrlArr,\"/\");"
														+"request.setAttribute(\"fileUrl\",fileUrl);"
													+"}else{"
														+"request.setAttribute(\"fileUrl\",\"/images/noimg.gif\");"
													+"}"
												+"%>");

				mgmtChangeCode.put("{-BOARD_MAIN_IMAGE-}", ""
														//+"<a href=\"${basePath}?boardId=${boardId}&amp;mode=view&amp;cntId=${result.tmp2}\">"
														+"<a href=\"${ctxRoot}${basePathMap[result.tmp1] }?boardId=${result.tmp1}&amp;mode=view&amp;cntId=${result.tmp2}\">"
															+"<img src=\"<c:url value=\"${fileUrl}\" />\" alt=\"<c:out value=\"${empty result.fileExt01 ? result.title : result.fileExt01}\" /><c:out value=\"${empty result.fileExt01 ? ' 관련된 이미지 입니다' : ''}\" />\" />"
														+"</a>");

				mgmtChangeCode.put("{-BOARD_MAIN_CREATED-}","<c:out value=\"${fn:substring(result.created,0,10)}\" />");
			}
		}
		//역치환
		if("return".equals(type)){
			HashMap<String, String> changeCode = new HashMap<String, String>();

			Iterator itr = mgmtChangeCode.keySet().iterator();
			while (itr.hasNext()) {
				String key = (String) itr.next();
				changeCode.put(mgmtChangeCode.get(key), key);
			}
			mgmtChangeCode.clear();
			mgmtChangeCode = changeCode;
		}
		return mgmtChangeCode;
	}

	public static String setMgmtFileHeader(String mgmtType, String skin)throws Exception{
		String str = "";
		if("boardLatest".equals(mgmtType)){
			String strDefault = "<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"
								+"<%@ include file=\"../../../header.jsp\" %>"
								+"<%@ taglib prefix=\"jnit\" uri=\"/jnittag\" %>";
			if("main".equals(skin) || "calendar".equals(skin) || "schedule".equals(skin)){
				str = strDefault;
			}else if("gallery".equals(skin)){
				str = strDefault+"<%@ page import=\"org.apache.commons.lang.StringUtils\"%>";
			}
			str = "<% /* head_S */ %>" + str + "<% /* head_E */ %>";
		}
		return str;
	}

	public static String setMgmtBoardFileHeader(String mgmtType, String skin, String boardId)throws Exception{
		String str = "";
		String latestPath =  "/board/_latest/"+boardId+ ".jsp";
		String strDefault = "<%@ page contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"
							+"<%@ include file=\"../../../header.jsp\" %>"
							+"<%@ include file=\""+latestPath+"\" %>"
							+"<%@ taglib prefix=\"jnit\" uri=\"/jnittag\" %>";
		if("main".equals(skin) || "calendar".equals(skin) || "schedule".equals(skin)){
			str = strDefault;
		}else if("gallery".equals(skin)){
			str = strDefault+"<%@ page import=\"org.apache.commons.lang.StringUtils\"%>";
		}
		str = "<% /* head_S */ %>" + str + "<% /* head_E */ %>";

		return str;
	}

	/**
	 * 필터를 거쳐 원하는 내용을 반환한다.
	 * @param mgmtType - 타입
	 * @param skin - 스킨유형
	 * @param mgmtContent - 내용
	 * @return 필터거친 mgmtContent
	 * @throws Exception
	 */
	public static String mgmtContentFillter(String mgmtType, String skin, String mgmtContent)throws Exception{
		mgmtContent = NullUtil.nullString(mgmtContent);
		if(!"".equals(mgmtContent)){
			if("boardLatest".equals(mgmtType)){
				if(mgmtContent.indexOf("<% /* head_S */ %>") > -1){
					mgmtContent = mgmtContent.replace(mgmtContent.substring(mgmtContent.indexOf("<% /* head_S */ %>"), mgmtContent.indexOf("<% /* head_E */ %>")+18), "");
				}
			}
		}
		return mgmtContent;
	}

	/**
	 * 최근게시물 json 파일에 미니게시판 정보를 담는다.
	 * @param request
	 * @param jnitcmsmgmtVO
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean boardLatestJSON(HttpServletRequest request,JnitcmsmgmtVO jnitcmsmgmtVO)throws Exception{
    	String root = PathUtil.getRealPath(request);
    	File mgmtJSONFolder = new File(root+"board/_mgmt"); if(!mgmtJSONFolder.exists()) mgmtJSONFolder.mkdirs();
    	String jsonDir = root+"board/_mgmt/"+jnitcmsmgmtVO.getMgmtId()+".json";
    	if("boardLatest".equals(jnitcmsmgmtVO.getMgmtType())){
    		try {
    			JSONObject JSON = new JSONObject().fromObject(jnitcmsmgmtVO);
        		CmsHandler.writeFile(jsonDir, JSON.toString());
    		} catch (IOException e){
    			log.error(e.getMessage());
				return false;
			} catch (Exception e) {
				log.error(e.getMessage());
				return false;
			}
    	}
    	return true;
    }

	/**
	 * 사이트생성시 기본 카테고리 등록
	 * @param request
	 * @param siteId
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean insertSiteCategory(HttpServletRequest request, JnitcmssiteVO siteVO, String tplId)throws Exception{
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

		JnitcmsmgmtcategoryService jnitcmsmgmtcategoryService = (JnitcmsmgmtcategoryService) wContext.getBean("jnitcmsmgmtcategoryService");
		JnitcmsmgmtitemService jnitcmsmgmtitemService = (JnitcmsmgmtitemService) wContext.getBean("jnitcmsmgmtitemService");
		String siteId = NullUtil.nullString(siteVO.getSiteId());
		if(!"".equals(siteId)){
			JnitcmsmgmtcategoryVO categoryVO = new JnitcmsmgmtcategoryVO();
			categoryVO.setSiteId(siteId);
			String id = jnitcmsmgmtcategoryService.insertJnitcmsmgmtcategory(categoryVO);
			JnitcmsmgmtitemVO itemVO = new JnitcmsmgmtitemVO();
			itemVO.setModifiYn(1);
			itemVO.setMgmtCategoryId(id);
			itemVO.setCategoryNm("공통");
			itemVO.setCategoryVal("common");
			itemVO.setCategorySort(0);
			itemVO.setCategorySource("common");
			jnitcmsmgmtitemService.insertJnitcmsmgmtitem(itemVO);
			itemVO.setCategoryNm("메인템플릿");
			itemVO.setCategoryVal(siteVO.getSitePath()+"/index.jsp");
			itemVO.setCategorySort(1);
			itemVO.setCategorySource("tpl");
			jnitcmsmgmtitemService.insertJnitcmsmgmtitem(itemVO);
			itemVO.setCategoryNm("서브템플릿 Sample");
			itemVO.setCategoryVal(tplId);
			itemVO.setCategorySort(2);
			itemVO.setCategorySource("tpl");
			jnitcmsmgmtitemService.insertJnitcmsmgmtitem(itemVO);
		}else{
			return false;
		}
		return true;
	}

	/**
	 * 사이트생성시 각 파일에대한 JSON 파일을 생성한다.
	 * @param request
	 * @param siteVO
	 * @param mgmtType - 타입
	 * @param mgmtNm - 파일이름
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean makeSiteCategoryJSON(HttpServletRequest request, JnitcmssiteVO siteVO, String mgmtType, String mgmtNm )throws Exception{
		String categoryList = "";
		String root = PathUtil.getRealPath(request);
		String rootCategoryJSONDir = root +siteVO.getSitePath()+"/common/config/handing/"+mgmtType;
		File rootCategoryJSON = new File(rootCategoryJSONDir); if(!rootCategoryJSON.exists()) rootCategoryJSON.mkdirs();
		String categoryJSONDir = rootCategoryJSONDir+"/"+mgmtNm+".json";
		JSONObject JSON = new JSONObject();

		if("css".equals(mgmtType) || "js".equals(mgmtType)){
			String[] categoryLists = {"common"};
			for(int i=0; i<categoryLists.length; i++){
				categoryList += (!"".equals(categoryList) ? "," : "")+categoryLists[i];
			}
			JSON.put("categoryList", categoryList);
			try {
				CmsHandler.writeFile(categoryJSONDir, JSON.toString());
			} catch (IOException e){
				if("true".equals(deDug)) log.debug(e.getMessage());
				return false;
			} catch (Exception e) {
				if("true".equals(deDug)) log.debug(e.getMessage());
				return false;
			}
		}
		return true;
	}

	/**
	 * 사이트경로의 각파일에대한 설정값 JSON 파일을 생성한다.
	 * @param request
	 * @param siteVO
	 * @param mgmtVO
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean makeCategoryJSON(HttpServletRequest request, JnitcmssiteVO siteVO, JnitcmsmgmtVO mgmtVO)throws Exception{
		String categoryList = "";
		String root = PathUtil.getRealPath(request);
		String rootCategoryJSONDir = root +siteVO.getSitePath()+"/common/config/handing/"+mgmtVO.getMgmtType();
		File rootCategoryJSON = new File(rootCategoryJSONDir); if(!rootCategoryJSON.exists()) rootCategoryJSON.mkdirs();
		String categoryJSONDir = rootCategoryJSONDir+"/"+mgmtVO.getMgmtNm()+".json";
		JSONObject JSON = new JSONObject();

		if("css".equals(mgmtVO.getMgmtType()) || "js".equals(mgmtVO.getMgmtType())){
			if(request.getParameterValues("categoryList") != null){
				String[] categoryLists = request.getParameterValues("categoryList");
				for(int i=0; i<categoryLists.length; i++){
					categoryList += (!"".equals(categoryList) ? "," : "")+categoryLists[i];
				}
				JSON.put("categoryList", categoryList);
				try {
					CmsHandler.writeFile(categoryJSONDir, JSON.toString());
				} catch (IOException e){
					if("true".equals(deDug)) log.debug(e.getMessage());
					return false;
				} catch (Exception e) {
					if("true".equals(deDug)) log.debug(e.getMessage());
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * 파일관리시스템의 카테고리관리에 mgmtCategoryId를 리턴한다.
	 * @param request
	 * @param siteId
	 * @return mgmtCategoryId
	 * @throws Exception
	 */
	 public static String selectJnitcmsmgmtCatetoryId(HttpServletRequest request, String siteId)throws Exception{
	 	HttpSession session = request.getSession();
	 	ServletContext context = session.getServletContext();
	 	WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

	 	JnitcmsmgmtcategoryService jnitcmsmgmtcategoryService = (JnitcmsmgmtcategoryService) wContext.getBean("jnitcmsmgmtcategoryService");
	 	JnitcmssiteService jnitcmssiteService = (JnitcmssiteService) wContext.getBean("jnitcmssiteService");
	 	JnitcmstplService jnitcmstplService = (JnitcmstplService) wContext.getBean("jnitcmstplService");

    	String mgmtCategoryId = "";
    	JnitcmsmgmtcategoryVO categoryVO = new JnitcmsmgmtcategoryVO();
    	categoryVO.setSiteId(siteId);
    	categoryVO.setSelectCondition("1");
    	try {
    		categoryVO = jnitcmsmgmtcategoryService.selectJnitcmsmgmtcategory(categoryVO);
    		mgmtCategoryId = categoryVO.getMgmtCategoryId();
    	} catch (NullPointerException e){
    		if("true".equals(deDug)) log.debug(e.getMessage());
			JnitcmssiteVO siteVO = new JnitcmssiteVO();
			siteVO.setSiteId(siteId);
			try {
				siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
			} catch (NullPointerException e2){
				log.error(e2.getMessage());
			} catch (Exception e2) {
				if("true".equals(deDug)) log.debug(e2.getMessage());
			}

			JnitcmstplVO tplVO = new JnitcmstplVO();
			tplVO.setSiteId(siteId);
			tplVO.setTplType("B");
			try {
				tplVO = jnitcmstplService.selectJnitcmstpl(tplVO);
			} catch (NullPointerException e2){
				log.error(e2.getMessage());
			} catch (Exception e2) {
				if("true".equals(deDug)) log.debug(e2.getMessage());
			}

			if(insertSiteCategory(request, siteVO,tplVO.getTplId())){
				categoryVO = jnitcmsmgmtcategoryService.selectJnitcmsmgmtcategory(categoryVO);
	    		mgmtCategoryId = categoryVO.getMgmtCategoryId();
			}
		} catch (Exception e) {
			if("true".equals(deDug)) log.debug(e.getMessage());
			JnitcmssiteVO siteVO = new JnitcmssiteVO();
			siteVO.setSiteId(siteId);
			try {
				siteVO = jnitcmssiteService.selectJnitcmssite(siteVO);
			} catch (NullPointerException e2){
				log.error(e2.getMessage());
			} catch (Exception e2) {
				if("true".equals(deDug)) log.debug(e2.getMessage());
			}

			JnitcmstplVO tplVO = new JnitcmstplVO();
			tplVO.setSiteId(siteId);
			tplVO.setTplType("B");
			try {
				tplVO = jnitcmstplService.selectJnitcmstpl(tplVO);
			} catch (NullPointerException e2){
				log.error(e2.getMessage());
			} catch (Exception e2) {
				if("true".equals(deDug)) log.debug(e2.getMessage());
			}

			if(insertSiteCategory(request, siteVO,tplVO.getTplId())){
				categoryVO = jnitcmsmgmtcategoryService.selectJnitcmsmgmtcategory(categoryVO);
	    		mgmtCategoryId = categoryVO.getMgmtCategoryId();
			}
		}
    	return mgmtCategoryId;
    }

	/**
	 * 카테고리 리스트 내용을 반환한다.
	 * @param request
	 * @param model
	 * @param siteVO
	 * @param mgmtType - 타입
	 * @param mgmtNm - 파일이름
	 * @return ModelMap categoryList, ModelMap mgmtCategoryMap
	 * @throws Exception
	 */
	public static ModelMap categoryList(HttpServletRequest request, ModelMap model, JnitcmssiteVO siteVO, String mgmtType, String mgmtNm)throws Exception{
		String root = PathUtil.getRealPath(request);
		mgmtType = NullUtil.nullString(mgmtType);
		mgmtNm = NullUtil.nullString(mgmtNm);
		if("css".equals(mgmtType) || "js".equals(mgmtType)){
			HttpSession session = request.getSession();
			ServletContext context = session.getServletContext();
			WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

			JnitcmsmgmtitemService jnitcmsmgmtitemService = (JnitcmsmgmtitemService) wContext.getBean("jnitcmsmgmtitemService");

			JnitcmsmgmtitemDefaultVO itemVO = new JnitcmsmgmtitemDefaultVO();
			itemVO.setMgmtCategoryId(mgmtUtil.selectJnitcmsmgmtCatetoryId(request, siteVO.getSiteId()));
			itemVO.setPageYn("N");
			itemVO.setOrderbyCondition("1");
			List categoryList = jnitcmsmgmtitemService.selectJnitcmsmgmtitemList(itemVO);
			model.addAttribute("categoryList", categoryList);

			if(!"".equals(mgmtNm)){
				String categoryJSONDir = root+siteVO.getSitePath()+"/common/config/handing/"+mgmtType+"/"+mgmtNm+".json";
				try {
					JSONObject JSON = new JSONObject().fromObject(CmsHandler.readFile(categoryJSONDir));
					HashMap<String, String> mgmtCategoryMap = new HashMap<String, String>();
					String[] categoryLists = JSON.get("categoryList").toString().split(",");
					for(int i=0; i<categoryLists.length; i++){
						mgmtCategoryMap.put(categoryLists[i], "checked");
					}
					model.addAttribute("mgmtCategoryMap", mgmtCategoryMap);
				} catch (NullPointerException e){
					log.error(e.getMessage());
				} catch (Exception e) {
					if("true".equals(deDug)) log.debug(e.getMessage());
				}
			}
		}
		return model;
	}

	/**
	 * 각 사이트의 css,js 파일의 설정값을 이용하여 각페이지 표출 설정을 제어한다.
	 * @param url - JSON 파일의 비교할 값
	 * @param mgmtNm - 파일이름
	 * @param mgmtType - 타입
	 * @param sitePath - 사이트경로
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean isExistJSON(String url, String mgmtNm, String mgmtType, String sitePath)throws Exception{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String root = PathUtil.getRealPath(request);
		String servletPath =  request.getServletPath();
		Boolean bln = false;
		url = NullUtil.nullString(url);
		if(!"".equals(url)){
			//2015-05-18 by.나성재 메인템플릿 처리
			if(url.substring(url.length()-1).equals("/")){
				url += "index.jsp";
			}
			String JSONDir = root+sitePath+"/common/config/handing/"+mgmtType+"/"+mgmtNm+".json";
			try {
				JSONObject JSON = new JSONObject().fromObject(CmsHandler.readFile(JSONDir));
				String categoryList = JSON.get("categoryList").toString();
				String[] categoryLists = categoryList.split(",");
				if(StringUtil.isExistArrayIndexOf(categoryLists, url) || "common".equals(categoryList)){
					bln = true;
				}else{
					bln = false;
				}
				//해당 경로 따로 지정
				for(int i=0; i<categoryLists.length; i++){
					if(servletPath.indexOf(categoryLists[i]) > -1){
						bln = true;
					}
				}
				return bln;
			} catch (NullPointerException e){
				if("true".equals(deDug)) log.debug(e.getMessage());
				return false;
			} catch (Exception e) {
				if("true".equals(deDug)) log.debug(e.getMessage());
				return false;
			}
		}else{
			return false;
		}
	}

	/**
	 * 기본 파일설정의 각 파일순서를 재정렬 하여 업데이트를 한다.
	 * @param request
	 * @param siteId
	 * @param mgmtType - 각 타입
	 * @return Boolean
	 * @throws Exception
	 */
	public static Boolean updateMgmtSort(HttpServletRequest request, String siteId, String mgmtType)throws Exception{
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);

		JnitcmsmgmtService jnitcmsmgmtService = (JnitcmsmgmtService) wContext.getBean("jnitcmsmgmtService");
		siteId = NullUtil.nullString(siteId);
		String root = PathUtil.getRealPath(request);
		String mgmtDefaultFileDir = root+"WEB-INF/jsp/jnit/cms/mgmt/default/"+mgmtType+"/default.json";
		if(!"".equals(siteId)){
			try {
				JSONObject JSON = new JSONObject().fromObject(CmsHandler.readFile(mgmtDefaultFileDir));
				Iterator itr = JSON.keySet().iterator();
				while (itr.hasNext()) {
					String key = (String) itr.next();
					JnitcmsmgmtVO mgmtVO = new JnitcmsmgmtVO();
					mgmtVO.setSiteId(siteId);
					mgmtVO.setMgmtNm(key);
					mgmtVO.setMgmtSort(JSON.getInt(key));
					mgmtVO.setMgmtType(mgmtType);
					mgmtVO.setUpdateCondition("2");
					jnitcmsmgmtService.updateJnitcmsmgmt(mgmtVO);
				}
			} catch (NullPointerException e){
				if("true".equals(deDug)) log.debug(e.getMessage());
				return false;
			} catch (Exception e) {
				if("true".equals(deDug)) log.debug(e.getMessage());
				return false;
			}
		}
		return true;
	}
}