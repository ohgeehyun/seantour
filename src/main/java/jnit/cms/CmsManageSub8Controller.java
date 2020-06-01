/**
 * @version 3.2.0.1
 */
package jnit.cms;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.Security;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.WebUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.cnt.JnitcmscntDefaultVO;
import jnit.cms.cnt.JnitcmscntService;
import jnit.cms.cnt.JnitcmscntVO;
import jnit.cms.cntvt.JnitcmscntvtService;
import jnit.cms.hist.JnitcmshistService;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.menu.JnitcmsmenuService;
import jnit.cms.menu.JnitcmsmenuVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.cms.site.JnitcmssiteVO;
import jnit.cms.tpl.JnitcmstplService;
import net.sf.json.JSONObject;

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
public class CmsManageSub8Controller {

	private Log log = LogFactory.getLog(getClass());
	
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

    @Resource(name = "jnitcmsmenuService")
    private JnitcmsmenuService jnitcmsmenuService;

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
	@RequestMapping(value="/cms/sub8/0101.do")
    public String selectJnitcmscntList(@ModelAttribute("searchVO") JnitcmscntDefaultVO searchVO,
    		HttpServletRequest request,
		    		ModelMap model)
		    throws Exception {
		AdminUtil.setMenuId("m05020000");
		if(CmsHelper.getSessionSiteId(request).equals("")) {
			return "jnit/cms/sub6_msg-nosite";
		}
		int selectList = NullUtil.nullInt(request.getParameter("selectList"));
		String assessList = NullUtil.nullString(request.getParameter("assessList"));

		JnitcmssiteVO siteSearchVO = new JnitcmssiteVO();
    	siteSearchVO.setSiteId(CmsHelper.getSessionSiteId(request));
		JnitcmssiteVO siteVO = jnitcmssiteService.selectJnitcmssite(siteSearchVO);

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(selectList == 0 ? propertiesService.getInt("pageUnit") :  selectList);//propertiesService.getInt("pageUnit")
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		searchVO.setSearchCondition("0");

		if(!assessList.equals("")){
			if(assessList.equals("0")){ // 평가대기
				searchVO.setSearchCondition("0");
			}else if(assessList.equals("1")){ //평가완료
				searchVO.setSearchCondition("1");
			}else if(assessList.equals("3")){ //평가제외
				searchVO.setSearchCondition("3");
			}
		}

		searchVO.setSearchKeyword(siteVO.getSiteId());
		searchVO.setPageUseYn("Y");

		List jnitcmscntvtList = jnitcmscntService.selectLeftJoincntList(searchVO);

		JnitcmsmenuVO menuVO;
		HashMap<String, String> menuPathMap = new HashMap<String, String>();
		HashMap<String, String> menuNameMap = new HashMap<String, String>();

		for(int i=0; i<jnitcmscntvtList.size(); i++) {
			menuVO = new JnitcmsmenuVO();
			menuVO.setSiteId(siteVO.getSiteId());
			menuVO.setMenuId((String)((EgovMap)jnitcmscntvtList.get(i)).get("menuId"));
			menuVO = jnitcmsmenuService.selectJnitcmsmenu(menuVO);

			menuPathMap.put(menuVO.getCntId(), (String)jnitcmsmenuService.makeMenuDirectoryName(menuVO, siteVO.getSitePath()) );
			menuNameMap.put(menuVO.getCntId(), (String)WebUtil.removeTag(jnitcmsmenuService.makeMenuNames(menuVO, siteVO.getSiteNm())) );
		}

		int totCnt = jnitcmscntService.selectLeftJoincntListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("selectList", selectList);
		model.addAttribute("assessList", assessList);
		model.addAttribute("siteVO", siteVO);
		model.addAttribute("menuPathMap", menuPathMap);
		model.addAttribute("menuNameMap", menuNameMap);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", jnitcmscntvtList);

        return "/jnit/cms/sub8_1-1";
    }

    @RequestMapping("/cms/sub8/webStandard.do")
    public String webStandard(@ModelAttribute("searchVO") JnitcmscntDefaultVO searchVO,
    		HttpServletRequest request, ModelMap model)throws Exception{
    	String host = NullUtil.nullString(request.getParameter("host"));
    	String url = NullUtil.nullString(request.getParameter("url"));
		String cntId = NullUtil.nullString(request.getParameter("cntId"));
		String type = NullUtil.nullString(request.getParameter("type"));

    	StringBuffer reRootURL = request.getRequestURL();
    	String reRootURI = request.getRequestURI();
    	//String ctxRoot = reRootURL.toString().replace(reRootURI, "")+url;
    	String contextPath = request.getContextPath();
    	String webUrl = host+contextPath+url;
    	JSONObject json = new JSONObject();



    	int errorIndex = -1;
    	int warningIndex = -1;
    	int notFond = -1;
		Document doc = null;
		Elements errors = null;
		/*
		try {
			//doc = Jsoup.connect(ctxRoot).get();
			doc = Jsoup.connect(webUrl).get();
		} catch (java.io.IOException e) {
			json.put("status", "error");

			if(!StringUtil.isExistString(webUrl, "local")){
				json.put("message", "해당파일이 존재하지않습니다.\n\n"+
						"콘텐츠 저장버튼을 클릭하신후 재평가 해주시기 바랍니다.\n\n"+
						"콘텐츠 경로 : "+webUrl);
			}else{
				json.put("message", "로컬 URL은 검사 할 수 없습니다.\n\n"+
						"콘텐츠 경로 : "+webUrl);
			}
			model.addAttribute("json", json.toString());
			return "jnit/util/json";
		}
		errors = doc.select(".wrapper h1");
		errorIndex = errors.text().indexOf("Error: 404");
		if(errorIndex > -1){
			json.put("status", "error");
			json.put("message", "해당파일이 존재하지않습니다.\n\n"+
					"콘텐츠 저장버튼을 클릭하신후 재평가 해주시기 바랍니다.\n\n"+
					"콘텐츠 경로 : "+webUrl);
			model.addAttribute("json", json.toString());
			return "jnit/util/json";
		}
		*/
		if(!type.equals("")){
			if(type.equals("standard")){
				try {
					doc =  Jsoup.connect("http://validator.w3.org/check?uri="+webUrl+"&charset=%28detect+automatically%29&doctype=Inline&group=0").get();
					errors = doc.select(".invalid");
				} catch (SocketTimeoutException e) {  //Read timed out Exception
					JnitcmscntVO setCntVO = new JnitcmscntVO();
	        		setCntVO.setCntId(cntId);
	        		setCntVO.setSearchCondition("1");
	        		JnitcmscntVO cntVO = jnitcmscntService.selectJnitcmscnt(setCntVO);
	        		cntVO.setCntWebStandard(4);
	        		jnitcmscntService.updateWebcnt(cntVO);

	        		json.put("status", "error");
	        		json.put("message", "서버 연결이 원활하지않아 검사가 중지되었습니다.");
	        		model.addAttribute("json", json.toString());
	            	return "/jnit/util/json";
				} catch (java.io.IOException e) { //IOEx
					json.put("status", "error");
					json.put("message", "해당파일이 존재하지않습니다.\n\n"+
							"콘텐츠 저장버튼을 클릭하신후 재평가 해주시기 바랍니다.\n\n"+
							"콘텐츠 경로 :"+webUrl);
					model.addAttribute("json", json.toString());
					return "jnit/util/json";
				}finally{

				}
				for (Element e : errors) {
	    			errorIndex = e.text().indexOf("에러");
	    			if(errorIndex == -1) errorIndex = e.text().indexOf("Errors");
	    			warningIndex = e.text().indexOf("경고");
	    			if(warningIndex == -1) warningIndex = e.text().indexOf("Warning");
	    			notFond = e.text().indexOf("이 문서를 체크할 수 없습니다.");
	    			if(notFond == -1) notFond = e.text().indexOf("This document cannot be checked");
				}
			}else if(type.equals("standardCss")){
				HttpURLConnection conn = null;
				BufferedReader reader = null;
				String line;
				String standardCsslog = "";

				try {
					URL standardCss = new URL("http://jigsaw.w3.org/css-validator/validator?uri="+webUrl);
					conn = (HttpURLConnection) standardCss.openConnection();
					conn.setRequestMethod("GET");
					conn.setConnectTimeout(2000);
					conn.setReadTimeout(30000);
					try {
						reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
					} catch (java.io.IOException e) {
						if(conn != null){
							conn.disconnect();
							json.put("status", "error");
							json.put("message", "해당파일이 존재하지않습니다.\n\n"+
									"콘텐츠 저장버튼을 클릭하신후 재평가 해주시기 바랍니다.\n\n"+
									"콘텐츠 경로 :"+webUrl);
							model.addAttribute("json", json.toString());
							return "jnit/util/json";
						}
					} catch (Exception e) {
						log.error(e.getMessage());
					}
					while ((line = reader.readLine()) != null) {
						standardCsslog += line + "\r\n";
					}
				}catch (SocketTimeoutException e) {  //Read timed out Exception
					JnitcmscntVO setCntVO = new JnitcmscntVO();
	        		setCntVO.setCntId(cntId);
	        		setCntVO.setSearchCondition("1");
	        		JnitcmscntVO cntVO = jnitcmscntService.selectJnitcmscnt(setCntVO);
	        		cntVO.setCntWebAccess(4);
	        		jnitcmscntService.updateWebcnt(cntVO);

	        		json.put("status", "error");
	    			json.put("message", "서버 연결이 원활하지않아 검사가 중지되었습니다.");
	    			model.addAttribute("json", json.toString());
	    			return "jnit/util/json";
				}catch (Exception e) {
					log.error(e.getMessage());
				}finally {
					if(conn != null){
						conn.disconnect();
					}
					if(reader != null){
						reader.close();
					}

				}
				errorIndex = standardCsslog.indexOf("Sorry!");
				notFond = standardCsslog.indexOf("I/O Error");
			}else if(type.equals("access")){
				InputStream is   =  null;
				InputStreamReader isr =  null;
				BufferedReader br  =  null;
				StringBuffer sb = new StringBuffer();
				OutputStreamWriter wr = null;
		    	try {
		    		System.setProperty ( "java.protocol.handler.pkgs","com.sun.net.ssl.internal.www.protocol");
		    		com.sun.net.ssl.internal.ssl.Provider provider = new com.sun.net.ssl.internal.ssl.Provider();
		    		Security.addProvider(provider);
		    		// Construct data
		            String data = URLEncoder.encode("url", "UTF-8") + "=" + URLEncoder.encode(webUrl+"/", "UTF-8");
		    		//String data = URLEncoder.encode("ace_id", "UTF-8") + "=" + URLEncoder.encode("2521", "UTF-8");
		            // Send data
		            URL accessUrl = new URL("https://accessibility.kr/nia/check.php");
		            URLConnection   huc = accessUrl.openConnection();
		            // If you invoke the method setDoOutput(true) on the URLConnection, it will always use the POST method.
		            huc.setDoInput(true);
		            huc.setDoOutput(true);
		            huc.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		            huc.addRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0");
		            wr = new OutputStreamWriter(huc.getOutputStream());
		            wr.write(data);
		            wr.flush();
		            // Get the response
		            try {
		            	huc.connect();
		            	is = huc.getInputStream();
		            	isr = new InputStreamReader(is);
		            	br = new BufferedReader(isr);
		            	String line = null;
		                while((line=br.readLine()) != null){
		                      sb.append(line);
		                }
					} catch (java.io.IOException e) {
						try {
							//주소가 https://accessibility.kr/nia/?ace_id=2410 로 나와서 올바른 주소로 변경 후 다시 시도
							String retuenVal = huc.getURL().getQuery();
							System.setProperty ( "java.protocol.handler.pkgs","com.sun.net.ssl.internal.www.protocol");
				    		provider = new com.sun.net.ssl.internal.ssl.Provider();
				    		Security.addProvider(provider);
							accessUrl = new URL("https://accessibility.kr/nia/check.php");
							huc = accessUrl.openConnection();
							huc.setDoInput(true);
				            huc.setDoOutput(true);
				            huc.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
				            huc.addRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0");
				            data = URLEncoder.encode("ace_id", "UTF-8") + "=" + URLEncoder.encode(retuenVal, "UTF-8");
				            wr = new OutputStreamWriter(huc.getOutputStream());
				            wr.write(data);
				            wr.flush();

							huc.connect();
			            	is = huc.getInputStream();
			            	isr = new InputStreamReader(is);
			            	br = new BufferedReader(isr);
			            	String line = null;
			                while((line=br.readLine()) != null){
			                      sb.append(line);
			                }

						} catch (java.io.IOException e2) {
							json.put("status", "error");
							json.put("message", "해당파일이 존재하지않거나 \n\n"+
									"검사 페이지에 접근을 실패하였습니다.\n\n"+
									"콘텐츠 경로 :"+webUrl);
							model.addAttribute("json", json.toString());
							return "jnit/util/json";
						}
					}
		            String line;
		            while((line=br.readLine()) != null){
	                      sb.append(line);
	                }

		        } catch (SocketTimeoutException e) {  //Read timed out Exception
					JnitcmscntVO setCntVO = new JnitcmscntVO();
	        		setCntVO.setCntId(cntId);
	        		setCntVO.setSearchCondition("1");
	        		JnitcmscntVO cntVO = jnitcmscntService.selectJnitcmscnt(setCntVO);
	        		cntVO.setCntWebAccess(4);
	        		jnitcmscntService.updateWebcnt(cntVO);

	        		json.put("status", "error");
					json.put("message", "서버 연결이 원활하지않아 검사가 중지되었습니다.");
					model.addAttribute("json", json.toString());
					return "jnit/util/json";
				}finally{
					if(is != null){
						is.close();
					}
					if(isr != null){
						isr.close();
					}
					if(wr != null){
						wr.close();
					}
					if(br != null){
						br.close();
					}
				}
		    	notFond = sb.toString().indexOf("Unable to test");
		    	errorIndex = sb.toString().indexOf("<span class=\"fail\">");
			}else if(type.equals("except")){
				JnitcmscntVO cntVO = new JnitcmscntVO();
				cntVO.setCntId(cntId);
        		cntVO.setCntWebStandard(3);
        		cntVO.setCntWebStandardCss(3);
        		cntVO.setCntWebAccess(3);
        		jnitcmscntService.updateWebcnt(cntVO);

        		json.put("status", "success");
				json.put("message", "평가제외 되었습니다.");
				model.addAttribute("json", json.toString());
				return "jnit/util/json";

			}else if(type.equals("restore")){
				JnitcmscntVO cntVO = new JnitcmscntVO();
				cntVO.setCntId(cntId);
        		cntVO.setCntWebStandard(0);
        		cntVO.setCntWebStandardCss(0);
        		cntVO.setCntWebAccess(0);
        		jnitcmscntService.updateWebcnt(cntVO);

        		json.put("status", "success");
				json.put("message", "평가복구 되었습니다.");
				model.addAttribute("json", json.toString());
				return "jnit/util/json";
			}
		}
    	JnitcmscntVO setCntVO;
    	if(notFond > -1){
    		json.put("status", "error");
    		json.put("message", "해당파일이 존재하지않거나 \n\n"+
					"검사 페이지에 접근을 실패하였습니다.\n\n"+
					"콘텐츠 경로 :"+webUrl);
			model.addAttribute("json", json.toString());
			return "jnit/util/json";
    	}else{
    		if(errorIndex > -1 || warningIndex > -1){ //불합격
        		setCntVO = new JnitcmscntVO();
        		setCntVO.setCntId(cntId);
        		setCntVO.setSearchCondition("1");
        		JnitcmscntVO cntVO = jnitcmscntService.selectJnitcmscnt(setCntVO);

        		cntVO.setCntId(cntId);
        		if(type.equals("standard")){
        			cntVO.setCntWebStandard(2);
        		}else if(type.equals("standardCss")){
        			cntVO.setCntWebStandardCss(2);
        		}else if(type.equals("access")){
        			cntVO.setCntWebAccess(2);
        		}
        		jnitcmscntService.updateWebcnt(cntVO);
        	}else{ //합격
        		setCntVO = new JnitcmscntVO();
        		setCntVO.setCntId(cntId);
        		setCntVO.setSearchCondition("1");
        		JnitcmscntVO cntVO = jnitcmscntService.selectJnitcmscnt(setCntVO);

        		cntVO.setCntId(cntId);
        		if(type.equals("standard")){
        			cntVO.setCntWebStandard(1);
        		}else if(type.equals("standardCss")){
        			cntVO.setCntWebStandardCss(1);
        		}else if(type.equals("access")){
        			cntVO.setCntWebAccess(1);
        		}
        		jnitcmscntService.updateWebcnt(cntVO);
        	}
    	}
    	json.put("status", "success");
		json.put("message", "평가되었습니다.");
		model.addAttribute("json", json.toString());
		return "jnit/util/json"; //"/jnit/cms/sub8_1-1-Ajax";
    }
}
