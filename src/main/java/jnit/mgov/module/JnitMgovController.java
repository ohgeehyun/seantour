/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.terracotta.agent.repkg.de.schlichtherle.io.FileInputStream;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrDefaultVO;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.addressbook.JnitMgovAddrDefaultVO;
import jnit.mgov.addressbook.JnitMgovAddrService;
import jnit.sms.mgov.JnitsmsmgovVO;
import jnit.util.PathUtil;

@Controller
public class JnitMgovController {

	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitmgovService")
    private JnitMgovService jnitmgovService;
	
	@Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "jnitMgovAddrService")
    private JnitMgovAddrService jnitMgovAddrService;
	
    /** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    
    public static final String SEPERATOR = File.separator;
    
    /**
	 * jnitsmsmgov 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 JnitsmsmgovDefaultVO
	 * @return "/jnit/tpl-temp/jnitsmsmgov/JnitsmsmgovList"
	 * @exception Exception
	 */
    @RequestMapping(value="/cms/sms/list.do")
    public String selectJnitmgovList(@ModelAttribute("searchVO") JnitMgovDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	
    	AdminUtil.setMenuId("m06060400");
    	
    	String smsType = NullUtil.nullString(JnitMgovUtil.getSmsType());
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	SimpleDateFormat yearFormat = new SimpleDateFormat("YYYY");
    	SimpleDateFormat dateFormat = new SimpleDateFormat("MM");
    	
    	String sYear = NullUtil.nullString(request.getParameter("sYear"));
    	String sDate = NullUtil.nullString(request.getParameter("sDate"));
    	String tableName = "nuri_msg_log_";
    	int msgType = 4;		//4 == sms or 6 == lms
    	HashMap<String, String> resultDate = new HashMap<String, String>();
    	
    	if(sYear.equals("")){
    		sYear = yearFormat.format(Calendar.getInstance().getTime());
    	}
    	if(sDate.equals("")){
    		sDate = dateFormat.format(Calendar.getInstance().getTime());
    	}
    	
    	if(smsType.equals("mgov")){
    		tableName = tableName + sYear + sDate;
    	}else{
    		tableName = "jnit_ltskorea_sms";
    	}
    	
    	resultDate.put("sYear", sYear);
    	resultDate.put("sDate", sDate);
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setSearchTableNm(tableName);
		searchVO.setSearchMsgType(msgType);
		
		List jnitMgovList = null;
		List state = null;
		HashMap<String, String> resultState = new HashMap<String, String>();
		
		int totCnt = 0;		
		String sTotal = "0";
		String sSuccess = "0";
		String sFailed = "0";
		
		try{
			jnitMgovList = jnitmgovService.selectJnitmgovList(searchVO);
			state = jnitmgovService.selectJnitmgovState(searchVO);
			totCnt = jnitmgovService.selectJnitmgovListTotCnt(searchVO);
			
			EgovMap map = (EgovMap)state.get(0);
			
			sTotal = map.get("total").toString();
			sSuccess = map.get("success").toString();
			sFailed = map.get("failed").toString();
		} catch (NullPointerException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
		}	
		resultState.put("total", sTotal);
		resultState.put("success", sSuccess);
		resultState.put("failed", sFailed);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
        model.addAttribute("resultList", jnitMgovList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("resultDate", resultDate);
        model.addAttribute("resultState", resultState);
        model.addAttribute("smsType", smsType);
        
        return "/jnit/mgov/list";
    }
    
    @RequestMapping(value="/cms/lms/list.do")
    public String selectJnitmgovLMSList(@ModelAttribute("searchVO") JnitMgovDefaultVO searchVO, 
    		ModelMap model, HttpServletRequest request)
            throws Exception {
    	
    	AdminUtil.setMenuId("m06060500");
    	
    	String smsType = NullUtil.nullString(JnitMgovUtil.getSmsType());
    	
    	if(!smsType.equals("mgov")){
    		model.addAttribute("alert", "정부통합전산모듈에서만 LMS가 지원됩니다. SMS 리스트로 이동합니다.");
    		model.addAttribute("path", "/cms/sms/list.do");
    		return "/jnit/util/alertMove";
    	}
    	
    	
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	SimpleDateFormat yearFormat = new SimpleDateFormat("YYYY");
    	SimpleDateFormat dateFormat = new SimpleDateFormat("MM");
    	
    	String sYear = NullUtil.nullString(request.getParameter("sYear"));
    	String sDate = NullUtil.nullString(request.getParameter("sDate"));
    	String tableName = "nuri_msg_log_";
    	int msgType = 6;		//4 == sms or 6 == lms
    	HashMap<String, String> resultDate = new HashMap<String, String>();
    	
    	if(sYear.equals("")){
    		sYear = yearFormat.format(Calendar.getInstance().getTime());
    	}
    	if(sDate.equals("")){
    		sDate = dateFormat.format(Calendar.getInstance().getTime());
    	}
    	tableName = tableName + sYear + sDate;
    	
    	resultDate.put("sYear", sYear);
    	resultDate.put("sDate", sDate);
    	
    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setSearchTableNm(tableName);
		searchVO.setSearchMsgType(msgType);
		
		List jnitMgovList = null;
		List state = null;
		HashMap<String, Integer> resultState = new HashMap<String, Integer>(); 
		int totCnt = 0;
		
		try{
			jnitMgovList = jnitmgovService.selectJnitmgovList(searchVO);
			state = jnitmgovService.selectJnitmgovState(searchVO);
			totCnt = jnitmgovService.selectJnitmgovListTotCnt(searchVO);
			
			EgovMap map = (EgovMap)state.get(0);
			
			int total = (Integer)map.get("total");
			int success = (Integer)map.get("success");
			int failed = (Integer)map.get("failed");
			
			resultState.put("total", total);
			resultState.put("success", success);
			resultState.put("failed", failed);
		} catch (NullPointerException e){
			log.error(e.getMessage());
			
			resultState.put("total", 0);
			resultState.put("success", 0);
			resultState.put("failed", 0);
		}catch(Exception e){
			log.error(e.getMessage());
			
			resultState.put("total", 0);
			resultState.put("success", 0);
			resultState.put("failed", 0);
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
        model.addAttribute("resultList", jnitMgovList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("resultDate", resultDate);
        model.addAttribute("resultState", resultState);
        
        return "/jnit/mgov/lmsList";
    }
    
    @RequestMapping("/cms/sms/sendMessage.do")
    public String sendMessage(HttpServletRequest request, Model model)throws Exception {
    	
    	AdminUtil.setMenuId("m06060200");

    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
    	String userMbr = NullUtil.nullString(mbrVO.getMbrLogin());
    	
    	JnitMgovAddrDefaultVO searchVO = new JnitMgovAddrDefaultVO();
    		searchVO.setSearchKeyword(userMbr);
    	
    	List grpList = jnitMgovAddrService.selectJnitMgovAddrGrp(searchVO);
    	
    	model.addAttribute("grpList", grpList);
    	
        model.addAttribute("jnitsmsmgovVO", new JnitsmsmgovVO());
        return "/jnit/mgov/add";
    }
    
    @RequestMapping("/cms/sms/addProc.do")
    public String addJnitmgov(Model model, HttpServletRequest request)throws Exception {

    	String view = NullUtil.nullString(request.getParameter("view"));
    	String title = NullUtil.nullString(request.getParameter("messageTitle"));
    	String msg = NullUtil.nullString(request.getParameter("msgTxt"));
    	String msgByteVal = NullUtil.nullString(request.getParameter("msgByteVal"));
    	int msgByteChk = 0;
    	int msgByteReq = 0;
    	String upFileChk = NullUtil.nullString(request.getParameter("upFileChk"));
    	String fromTel = NullUtil.nullString(request.getParameter("sendTel1"))
    					+NullUtil.nullString(request.getParameter("sendTel2"))
    					+NullUtil.nullString(request.getParameter("sendTel3"));
    	
    	String upFileNm = (String)request.getSession().getAttribute("upFileNm");
//    	String upDir = "E:/EclipseUpload";
    	String upDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/smsExcelDir/";
    	String filepath = upDir + SEPERATOR + upFileNm;
    	
    	String[] toArr = null;
    	String[] toNameArr = null;
    	String[] toPhoneArr = null;
    	
		Pattern msgPt = Pattern.compile("\\[성명\\]");
		Matcher msgMc = msgPt.matcher(msg);
		int count = 0;
		for(int i=0; msgMc.find(i); i=msgMc.end()){
			count++;
		}
		
		/*
		if(!msgByteVal.equals("")){
			try{
				msgByteReq = Integer.parseInt(msgByteVal);
			}catch(Exception e){
				model.addAttribute("alert","다시 전송해 주세요.");
				return "/jnit/util/alertBack";
			}
		}
		
		msgByteChk = msg.getBytes("euc-kr").length + (count*2);
		if(msgByteReq != msgByteChk){
			model.addAttribute("alert","메세지 내용 변조 의심");
			return "/jnit/util/alertBack";
		}
		if(msgByteChk <= 80){
			msgType = "SMS";
		}else{
			msgType = "MMS";
		}
		*/
		
		if(upFileNm == null && upFileChk.equals("pass")){
			model.addAttribute("alert","엑셀 파일을 다시 한번 파일검사 해주세요.");
			return "/jnit/util/alertBack";
		}
		
		if(upFileChk.equals("pass")){
			
			HashMap<String,List<String>> resultMap = null;
	    	try{
	    		resultMap = JnitMgovUtil.fileToMap(filepath);
	    	} catch (IOException e){
	    		log.error(e.getMessage());
	    		model.addAttribute("alert","엑셀 파일을 읽는 중 에러 검출");
	    		return "/jnit/util/alertBack";
	    	}catch(Exception e){
	    		log.error(e.getMessage());
	    		model.addAttribute("alert","엑셀 파일을 읽는 중 에러 검출");
	    		return "/jnit/util/alertBack";
	    	}
	    	
	    	List<String> nameList = (List<String>)resultMap.get("nameList");
	    	List<String> phoneList = (List<String>)resultMap.get("phoneList");
	    	
	    	toNameArr = (String[])nameList.toArray(new String[nameList.size()]);
	    	toPhoneArr = (String[])phoneList.toArray(new String[phoneList.size()]);

	    	JnitMgovUtil.initSmsProp();
	    	
	    	if(toNameArr.length == toPhoneArr.length){
	    		for(int i=0; i<toNameArr.length; i++){
		    		JnitMgovUtil.sendMessage("defaultNm0", toNameArr[i], fromTel, toPhoneArr[i], title, msg, "AUTO", null);
		    	}
	    	}
	    	
	    	File originFile = new File(filepath);
	    	originFile.delete();
	    	request.getSession().removeAttribute("upFileNm");
	    	
	    	if(view.equals("view")){
	    		return "redirect:/sms/view/smsSendList.do";
	    	}else{
	    		return "redirect:/cms/sms/list.do";
	    	}
		}else if(upFileChk.equals("error")){
			model.addAttribute("alert","엑셀파일 업로드 중 문제가 발생했습니다.");
			return "/jnit/util/alertBack";
		}
		
		if(upFileChk.equals("")){
	    	try{
	    		toArr = request.getParameterValues("phoneList");
	    	} catch (NullPointerException e){
	    		log.error(e.getMessage());
	    		model.addAttribute("alert", "보내는 사람의 핸드폰번호 및 이름을 확인해주세요.");
	            return "/jnit/util/alertBack";
	    	}catch(Exception e){
	    		log.error(e.getMessage());
	    		model.addAttribute("alert", "보내는 사람의 핸드폰번호 및 이름을 확인해주세요.");
	            return "/jnit/util/alertBack";
	    	}

	    	JnitMgovUtil.initSmsProp();
	    	for(int i=0; i<toArr.length; i++){
	    	
	    		String[] fromSplit = toArr[i].split(",");
	    		String toPhone = fromSplit[0];
	    		String toNm = fromSplit[1];
	    		
	    		/*
	    		sms.init();
	    		if(sms.sendMsg2(to, fromTel, fromNm, msg.replace("[성명]", fromNm))){
	    			log.debug("성공");
	    		}else{
	    			log.debug("실패");
	    		}
	    		*/
	    		JnitMgovUtil.sendMessage("defaultNm0", toNm, fromTel, toPhone, title, msg, "AUTO", null);
	    	}
	        model.addAttribute("alert", "요청되었습니다.");
	        
	        if(view.equals("view")){
	    		model.addAttribute("path", "/sms/view/smsSendList.do");
	    	}else{
	    		model.addAttribute("path", "/cms/sms/list.do");
	    	}
		}
        return "/jnit/util/alertMove";
    }
    
    @RequestMapping("/cms/sms/searchAjax.do")
    public String searchAjax(HttpServletRequest request, Model model) throws Exception{
    	
    	String searchNm = NullUtil.nullString(request.getParameter("searchNm"));
		String searchOrg = NullUtil.nullString(request.getParameter("searchOrg"));
		String searchPhone = NullUtil.nullString(request.getParameter("searchPhone"));
		
		String searchKeyword = "";
		String searchCondition = "";
		
		if(!searchNm.equals("")){
			searchCondition = "1";
			searchKeyword = searchNm;
		}else if(!searchOrg.equals("")){
			searchCondition = "2";
			searchKeyword = searchOrg;
		}else if(!searchPhone.equals("")){
			searchCondition = "3";
			searchKeyword = searchPhone;
		}
		
		JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
			searchVO.setSearchCondition(searchCondition);
			searchVO.setSearchKeyword(searchKeyword);
		List<String> result = jnitcmsmbrService.selectSearchList(searchVO);
		
		model.addAttribute("result", result);
    	
    	return "/jnit/mgov/smsAjax";
    }
    
    @RequestMapping("/mgov/searchAjax.do")
    public String MgovSearchAjax(HttpServletRequest request, Model model) throws Exception{
    	
    	String searchNm = NullUtil.nullString(request.getParameter("searchNm"));
		String searchOrg = NullUtil.nullString(request.getParameter("searchOrg"));
		String searchPhone = NullUtil.nullString(request.getParameter("searchPhone"));
		String searchPos = NullUtil.nullString(request.getParameter("searchPos"));
		
		String searchKeyword = "";
		String searchCondition = "";
		
		if(!searchNm.equals("")){
			searchCondition = "1";
			searchKeyword = searchNm;
		}else if(!searchOrg.equals("")){
			searchCondition = "2";
			searchKeyword = searchOrg;
		}else if(!searchPhone.equals("")){
			searchCondition = "3";
			searchKeyword = searchPhone;
		}else if(!searchPos.equals("")){
			searchCondition = "4";
			searchKeyword = searchPos;
		}
		
		JnitcmsmbrDefaultVO searchVO = new JnitcmsmbrDefaultVO();
			searchVO.setSearchCondition(searchCondition);
			searchVO.setSearchKeyword(searchKeyword);
		List<String> result = jnitcmsmbrService.selectSearchList(searchVO);
		
		model.addAttribute("result", result);
    	
    	return "/jnit/mgov/view/SearchAjax";
    }
    
    @RequestMapping("/cms/sms/excelUpload.do")
    public String excepUpload(HttpServletRequest request, Model model) throws Exception{
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSS");

    	String id = loginVO.getMbrLogin();
    	String formatTime = format.format(Calendar.getInstance().getTime());
    	String fileNm = id+"_"+formatTime;
//    	String upDir = "E:/EclipseUpload";
    	String upDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/smsExcelDir";
    	String upFileNm = fileNm+".xls";
    	String path = upDir + SEPERATOR + upFileNm;
    	String value = "";
    	String duplicate = NullUtil.nullString(request.getParameter("duplicate"));
    	String duplicateChk = "";
    	String duplicateStr = "";
    	int duplicateCount = 0;
    	
    	request.getSession().setAttribute("upFileNm", upFileNm);
    	
    	JSONArray jArr = new JSONArray();
    	List<String> saveList = new ArrayList<String>();
    	List<String> duplicateList = new ArrayList<String>();
    	
    	Pattern strChk = Pattern.compile("^[a-zA-Z가-힣 ]{1,10}+$");
		Pattern numChk = Pattern.compile("^[0-9]{10,11}+$");
		Pattern phoneChk = Pattern.compile("^[01]{2}[0,1,6,7,8,9]{1}[0-9]{7,8}+$");
		
		Matcher matcher = null;
    	
		File originFile = new File(path);
		File errorFile = null;
		
		try{
			JnitMgovUtil.uploadFormWorkFiles(path, request);
		} catch (NullPointerException e){
			log.error(e.getMessage());
			model.addAttribute("json", "ERROR\n업로드 관련 에러 입니다.");
			return "/jnit/util/json";
		}catch(Exception e){
			log.error(e.getMessage());
			model.addAttribute("json", "ERROR\n업로드 관련 에러 입니다.");
			return "/jnit/util/json";
		}
    	
    	File exist = new File(upDir);
    	if(!exist.exists()){
    		exist.mkdir();
    	}
    	
    	File excelFile = new File(path);
    	FileInputStream fis = null;
    	try {
    		fis = new FileInputStream(excelFile);
        	XSSFWorkbook workbook = new XSSFWorkbook(fis);
        	XSSFSheet sheet = workbook.getSheetAt(0);
        	
        	int rows = sheet.getPhysicalNumberOfRows();
        	int cells = sheet.getRow(0).getPhysicalNumberOfCells();
        	
        	if(rows >= 2){
        		for(int i=1; i<rows; i++){
        			XSSFRow row = sheet.getRow(i);
        			if(row != null || !"".equals(row.getCell(0).getStringCellValue())){
        				for(int c=0; c<cells; c++){
        					XSSFCell cell = row.getCell(c);
        					if(cell != null){
    							switch(cell.getCellType()){
    							case XSSFCell.CELL_TYPE_FORMULA:
    	                            value=cell.getCellFormula();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_NUMERIC:
    	                            value=""+cell.getNumericCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_STRING:
    	                            value=""+cell.getStringCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_BLANK:
    	                            value=""+cell.getBooleanCellValue();
    	                            //value="";
    	                            break;
    	                        case XSSFCell.CELL_TYPE_ERROR:
    	                            value=""+cell.getErrorCellValue();
    	                            break;
    	                        case XSSFCell.CELL_TYPE_BOOLEAN:
    	                        	value=""+cell.getBooleanCellValue();
    	                        	break;
    	                        default:
    							}
    						}else{
    							model.addAttribute("json", "ERROR<br /><br /><strong>엑셀에 공란이 존재합니다.<strong><br />(Excel File Line : "+(i+1)+")");
    							return "/jnit/util/json";
    						}
    						if(c == 0){
    							matcher = strChk.matcher(value);
    							if(!matcher.matches()){
    								model.addAttribute("json", "ERROR<br /><br /><strong>이름 입력 란에 [" + value + "] 잘못된 값이 있습니다.</strong><br />성명란에는 문자만 가능 합니다.1~10글자 까지만 입력 가능<br />현재 자릿수 : " + value.length()+"<br />(Excel File Line : "+(i+1)+")");
    								return "/jnit/util/json";
    							}
    						}else{
    							value = value.replace(" ", "").replace("-", "");
    							matcher = numChk.matcher(value);
    							
    							if(!matcher.matches()){
    								model.addAttribute("json", "ERROR<br /><br /><strong>핸드폰번호 입력 란에 [" + value + "] 잘못된 값이 있습니다.</strong><br />핸드폰 자릿수는 10~11자리까지만 가능<br />현재 자릿수 : " + value.length()+"<br />(Excel File Line : "+(i+1)+")");
    								return "/jnit/util/json";
    							}
    							
    							matcher = phoneChk.matcher(value);
    							if(!matcher.matches()){
    								model.addAttribute("json", "ERROR<br /><br /><strong>핸드폰 앞자리는 010,011,016,017,018,019만 지원합니다.</strong><br />잘못 입력된 번호 : [" + value + "]<br />(Excel File Line : "+(i+1)+")");
    								return "/jnit/util/json";
    							}
    							
    							if(duplicate.equals("Y")){
    								if(i >= 2){
    									if(StringUtil.isExistInList(saveList, value)){
    										duplicateCount++;
    										duplicateList.add(duplicateCount+".중복된 번호 : [" + value + "] (Excel File Line : "+(i+1)+")<br />");
    										if(!duplicateChk.equals("Y")){
    											duplicateChk = "Y";
    										}
    									}
    								}
    								saveList.add(value);
    							}
    						}
    						jArr.add(value);
        				}
        			}
        		}
        	}
        	
        	if(duplicate.equals("Y") && duplicateChk.equals("Y")){
    			duplicateStr += "<strong>====핸드폰 번호 중복 리스트==== (총 갯수 : " + duplicateList.size()+")</strong><br /><br />";
    			for(int k=0; k<duplicateList.size(); k++){
    				duplicateStr += duplicateList.get(k);
    			}
    			model.addAttribute("json", "ERROR<br />"+duplicateStr);
    			return "/jnit/util/json";
    		}
        	
        	model.addAttribute("json", jArr);
    	} catch (IOException e){
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		} finally {
			if(fis != null){
				fis.close();
			}
		}    	
    	return "/jnit/util/json";
    }
    
}
