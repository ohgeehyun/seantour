/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.terracotta.agent.repkg.de.schlichtherle.io.FileInputStream;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import jnit.cms.AdminUtil;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.addressbook.JnitMgovAddrDefaultVO;
import jnit.mgov.addressbook.JnitMgovAddrGrpVO;
import jnit.mgov.addressbook.JnitMgovAddrListVO;
import jnit.mgov.addressbook.JnitMgovAddrService;
import jnit.util.PathUtil;

@Controller
public class JnitMgovAddress {

	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitMgovAddrService")
    private JnitMgovAddrService jnitMgovAddrService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "jnitcmsmbrService")
    private JnitcmsmbrService jnitcmsmbrService;
    
    public static final String SEPERATOR = File.separator;

    
    
    
    @RequestMapping("/cms/mgov/addrList.do")
    public String addrList(HttpServletRequest request, Model model)throws Exception{
    	
    	AdminUtil.setMenuId("m06060300");
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	String userMbr = NullUtil.nullString(mbrVO.getMbrLogin());
    	
    	JnitMgovAddrDefaultVO searchVO = new JnitMgovAddrDefaultVO();
    		searchVO.setSearchKeyword(userMbr);
    		
    	List grpList = jnitMgovAddrService.selectJnitMgovAddrGrp(searchVO);
    	
    	if(grpList.size() < 1){
    		JnitMgovAddrGrpVO vo = new JnitMgovAddrGrpVO();
    			vo.setUserMbr(userMbr);
    			vo.setGrpNm("기본");
    		jnitMgovAddrService.insertJnitMgovAddrGrp(vo);
    		
    		grpList = jnitMgovAddrService.selectJnitMgovAddrGrp(searchVO);
    	}
    	
    	model.addAttribute("grpList", grpList);
    	
    	return "/jnit/mgov/AddrList";
    }
    
    @RequestMapping("/cms/mgov/addrGrpAdd.do")
    public String addrGrpAdd(HttpServletRequest request, Model model)throws Exception{
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	if(mbrVO == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	String userMbr = NullUtil.nullString(mbrVO.getMbrLogin());
    	
    	String grpNm = NullUtil.nullString(request.getParameter("grpNm"));
    	
    	JnitMgovAddrGrpVO vo = new JnitMgovAddrGrpVO();
    		vo.setGrpNm(grpNm);
    		vo.setUserMbr(userMbr);
    	
    	jnitMgovAddrService.insertJnitMgovAddrGrp(vo);
    	
    	model.addAttribute("json", "ok");
    	
    	return "/jnit/util/json";
    }
    
    @RequestMapping("/cms/mgov/addrGrpDel.do")
    public String addrGrpDel(HttpServletRequest request, Model model){
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));
    	String result = "";
    	
    	JnitMgovAddrGrpVO vo = new JnitMgovAddrGrpVO();
    		vo.setGrpId(grpId);
    		
    	try{
    		jnitMgovAddrService.deleteJnitMgovAddrGrp(vo);
    		result = "success";
    	} catch (NullPointerException e){
    		log.error(e.getMessage());
    		result = "failed";
    	}catch(Exception e){
    		log.error(e.getMessage());
    		result = "failed";
    	}
    	model.addAttribute("json", result);
    	return "/jnit/util/json";
    	
    }
    
    
    @RequestMapping("/cms/mgov/addrAjax.do")
    public String addAjax(HttpServletRequest request, Model model)throws Exception{
    	
    	String grpId = NullUtil.nullString(request.getParameter("grpId"));
    	
    	JnitMgovAddrDefaultVO searchVO = new JnitMgovAddrDefaultVO();
    		searchVO.setSearchKeyword(grpId);
    	List resultList = jnitMgovAddrService.selectJnitMgovAddrList(searchVO);
    	
    	model.addAttribute("resultList", resultList);
    	return "/jnit/mgov/AddrAjax";
    }
    
    
    @RequestMapping("/cms/mgov/addrAddProc.do")
    public String addrAddProc(HttpServletRequest request, Model model)throws Exception{
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	String view = NullUtil.nullString(request.getParameter("view"));
    	String addrNm = NullUtil.nullString(request.getParameter("addrNm"));
    	String addrPhone = NullUtil.nullString(request.getParameter("addrPhone"));
    	String grpId = NullUtil.nullString(request.getParameter("grpType"));
    	
    	if(view.equals("view")){
	    	if(addrNm.equals("")){
	    		model.addAttribute("alert", "성명을 입력해주세요.");
	    		model.addAttribute("path", "/sms/view/page.do?pageType=SmsAddr");
	    		return "/jnit/mgov/alertMove";
	    	}else if(addrPhone.equals("")){
	    		model.addAttribute("alert", "핸드폰 번호를 입력해주세요.");
	    		model.addAttribute("path", "/sms/view/page.do?pageType=SmsAddr");
	    		return "/jnit/mgov/alertMove";
	    	}else if(grpId.equals("")){
	    		model.addAttribute("alert", "주소록 유형을 선택해주세요.");
	    		model.addAttribute("path", "/sms/view/page.do?pageType=SmsAddr");
	    		return "/jnit/mgov/alertMove";
	    	}
    	}else{
    		if(addrNm.equals("")){
	    		model.addAttribute("alert", "성명을 입력해주세요.");
	    		model.addAttribute("path", "/cms/mgov/addrList.do");
	    		return "/jnit/mgov/alertMove";
	    	}else if(addrPhone.equals("")){
	    		model.addAttribute("alert", "핸드폰 번호를 입력해주세요.");
	    		model.addAttribute("path", "/cms/mgov/addrList.do");
	    		return "/jnit/mgov/alertMove";
	    	}else if(grpId.equals("")){
	    		model.addAttribute("alert", "주소록 유형을 선택해주세요.");
	    		model.addAttribute("path", "/cms/mgov/addrList.do");
	    		return "/jnit/mgov/alertMove";
	    	}
    	}
    	
    	JnitMgovAddrListVO vo = new JnitMgovAddrListVO();
    		vo.setMbrNm(addrNm);
    		vo.setPhone(addrPhone);
    		vo.setGrpId(grpId);
    		
    	jnitMgovAddrService.insertJnitMgovAddrList(vo);
    	
    	if(view.equals("view")){
    		return "redirect:/sms/view/page.do?pageType=SmsAddr";
    	}else{
    		return "redirect:/cms/mgov/addrList.do";
    	}
    }
    
    
    @RequestMapping("/cms/mgov/addrDelProc.do")
    public String addrDelProc(HttpServletRequest request, Model model)throws Exception{
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	String view = NullUtil.nullString(request.getParameter("view"));
    	String[] values = request.getParameterValues("chkBox");
    	String split[] = null;
    	String listId = "";
    	int size = values.length;
    	
    	if(size < 1){
    		model.addAttribute("alert", "체크박스를 선택해주세요.");
    		
    		if(view.equals("view")){
    			model.addAttribute("path", "/sms/view/page.do?pageType=SmsAddr");
    		}else{
    			model.addAttribute("path", "/cms/mgov/addrList.do");
    		}
    		return "/jnit/util/alertMove";
    	}else if(size == 1){
    		try{
	    		split = values[0].split(",");
	    		listId = split[0];
	    		
	    		JnitMgovAddrListVO vo = new JnitMgovAddrListVO();
	    		vo.setListId(listId);
	    		
	    		jnitMgovAddrService.deleteJnitMgovAddrList(vo);
    		} catch (NullPointerException e){
    			log.error(e.getMessage());
    		}catch(Exception e){
    			log.error(e.getMessage());
    		}
    	}else if(size > 1){
    		
    		for(int i=0; i<values.length; i++){
    			
    			try{
	    			split = values[i].split(",");
	    			listId = split[0];
	    			
	    			JnitMgovAddrListVO vo = new JnitMgovAddrListVO();
	        		vo.setListId(listId);
	        		
	        		jnitMgovAddrService.deleteJnitMgovAddrList(vo);
    			} catch (NullPointerException e){
    				log.error(e.getMessage());
    				continue;
    			}catch(Exception e){
    				log.error(e.getMessage());
    				continue;
    			}
    		}
    		
    	}
    	
    	if(view.equals("view")){
    		return "redirect:/sms/view/page.do?pageType=SmsAddr";
    	}else{
    		return "redirect:/cms/mgov/addrList.do";
    	}
    }
    
    
    @RequestMapping("/cms/mgov/AddrExcelChk.do")
    public String excelUploadChk(HttpServletRequest request, Model model) throws Exception{
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSS");

    	String id = NullUtil.nullString(loginVO.getMbrLogin());
    	String formatTime = format.format(Calendar.getInstance().getTime());
    	String fileNm = id+"_"+formatTime;
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
		
		try{
			String result = JnitMgovUtil.uploadFormWorkFiles(path, request);
			
			if(!(result.equals(".xls") || result.equals(".xlsx"))){
				model.addAttribute("json", "ERROR/n엑셀 파일을 업로드 해주세요.");
				return "/jnit/util/json";
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			model.addAttribute("json", "ERROR/n업로드 관련 에러 입니다.");
			return "/jnit/util/json";
		}catch(Exception e){
			log.error(e.getMessage());
			model.addAttribute("json", "ERROR/n업로드 관련 에러 입니다.");
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
    							upFileNm = fileNm+"(ErrSpace)"+".xls";
    					    	path = upDir + SEPERATOR + upFileNm;
    							model.addAttribute("json", "ERROR<br /><br /><strong>엑셀에 공란이 존재합니다.<strong><br />(Excel File Line : "+(i+1)+")");
    							return "/jnit/util/json";
    						}
    						if(c == 0){
    							matcher = strChk.matcher(value);
    							if(!matcher.matches()){
    								upFileNm = fileNm+"(ErrName)"+".xls";
    						    	path = upDir + SEPERATOR + upFileNm;
    								model.addAttribute("json", "ERROR<br /><br /><strong>이름 입력 란에 [" + value + "] 잘못된 값이 있습니다.</strong><br />성명란에는 문자만 가능 합니다.1~10글자 까지만 입력 가능<br />현재 자릿수 : " + value.length()+"<br />(Excel File Line : "+(i+1)+")");
    								return "/jnit/util/json";
    							}
    						}else{
    							value = value.replace(" ", "").replace("-", "");
    							matcher = numChk.matcher(value);
    							
    							if(!matcher.matches()){
    								upFileNm = fileNm+"(ErrPhone)"+".xls";
    						    	path = upDir + SEPERATOR + upFileNm;
    								model.addAttribute("json", "ERROR<br /><br /><strong>핸드폰번호 입력 란에 [" + value + "] 잘못된 값이 있습니다.</strong><br />핸드폰 자릿수는 10~11자리까지만 가능<br />현재 자릿수 : " + value.length()+"<br />(Excel File Line : "+(i+1)+")");
    								return "/jnit/util/json";
    							}
    							
    							matcher = phoneChk.matcher(value);
    							if(!matcher.matches()){
    								upFileNm = fileNm+"(ErrFrontNum)"+".xls";
    						    	path = upDir + SEPERATOR + upFileNm;
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
    
    
    @RequestMapping("/cms/mgov/AddrExcelUpload.do")
    public String smsAddrExcelUpload(HttpServletRequest request, Model model) throws Exception{

    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	JnitcmsmbrVO loginVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	String view = NullUtil.nullString(request.getParameter("view"));
    	String grpId = NullUtil.nullString(request.getParameter("grpType"));
    	String mbrId = NullUtil.nullString(loginVO.getMbrLogin());
    	String upFileChk = NullUtil.nullString(request.getParameter("upFileChk"));
    	String upFileNm = (String)request.getSession().getAttribute("upFileNm");
    	String upDir = PathUtil.getRealPath(request)+"WEB-INF/config/jnit/smsExcelDir";
    	String filepath = upDir + SEPERATOR + upFileNm;
    	
    	List<String> confirmList = new ArrayList<String>();
    	
    	
    	if(grpId.equals("")){
    		model.addAttribute("alert","주소록 유형을 선택해주세요.");
    		model.addAttribute("path","/cms/mgov/addrList.do");
    		return "/jnit/util/alertMove";
    	}else if(upFileNm == null){
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
	    	
	    	JnitMgovAddrDefaultVO searchVO = new JnitMgovAddrDefaultVO();
	    		searchVO.setSearchKeyword(grpId);
	    		
	    	List resultList = jnitMgovAddrService.selectJnitMgovAddrList(searchVO);
	    	Iterator itr = resultList.iterator();
	    	while(itr.hasNext()){
	    		EgovMap map = (EgovMap) itr.next();
	    		confirmList.add(map.get("phone").toString());
	    	}
	    	
	    	List<String> nameList = (List<String>)resultMap.get("nameList");
	    	List<String> phoneList = (List<String>)resultMap.get("phoneList");
	    	
	    	JnitMgovAddrListVO vo = new JnitMgovAddrListVO();
	    	if(nameList.size() == phoneList.size()){
	    		
	    		for(int i=0; i<nameList.size(); i++){
	    			if(!StringUtil.isExistInList(confirmList, phoneList.get(i).replace("-", "").replace(" ", ""))){
	    				vo.setGrpId(grpId);
	    				vo.setMbrNm(nameList.get(i));
	    				vo.setPhone(phoneList.get(i).replace("-", "").replace(" ", ""));
	    				jnitMgovAddrService.insertJnitMgovAddrList(vo);
	    			}
	    		}
	    		
	    	}else{
	    		model.addAttribute("alert","다시 한번 파일검사를 해주세요.");
	    		return "/jnit/util/alertBack";
	    	}
	    	
	    	File originFile = new File(filepath);
	    	originFile.delete();
	    	request.getSession().removeAttribute("upFileNm");
		}
    	
		if(view.equals("view")){
			return "redirect:/sms/view/page.do?pageType=SmsAddr";
		}else{
			return "redirect:/cms/mgov/addrList.do";
		}
    }
    
    
    @RequestMapping("/cms/mgov/AddrSendMsg.do")
    public String addrSendMsg(HttpServletRequest request, Model model) throws Exception{
    	
    	JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	
    	if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
    	
    	String view = NullUtil.nullString(request.getParameter("view"));
    	String[] chkBoxArr = request.getParameterValues("chkBox");
    	String name = "";
    	String phone = "";
    	String fromTel = NullUtil.nullString(request.getParameter("addrFromTel"));
    	String title = NullUtil.nullString(request.getParameter("title"));
    	String msg = NullUtil.nullString(request.getParameter("addrMsg"));
    	String[] toNameArr = null;
    	String[] toPhoneArr = null;
    	
    	try{
	    	if(chkBoxArr[0] != null){
	    		
	    		if(chkBoxArr.length >= 2){
	    			toNameArr = new String[chkBoxArr.length];
	    			toPhoneArr = new String[chkBoxArr.length];
	    			for(int i=0; i<chkBoxArr.length; i++){
	    				name = chkBoxArr[i].split(",")[1];
	    				phone = chkBoxArr[i].split(",")[2];
	    				toNameArr[i] = name;
	    				toPhoneArr[i] = phone;
	    				
	    				JnitMgovUtil.initSmsProp();
	        			JnitMgovUtil.sendMessage("defaultNm0", toNameArr[i], fromTel, toPhoneArr[i], title, msg, "AUTO", null);
	    			}
	    		}else{
	    			name = chkBoxArr[0].split(",")[1];
	    			phone = chkBoxArr[0].split(",")[2];
	    			
	    			JnitMgovUtil.initSmsProp();
	    			JnitMgovUtil.sendMessage("defaultNm0", name, fromTel, phone, title, msg, "AUTO", null);
	    		}
	    	}else{
	    		model.addAttribute("alert", "주소록에서 체크 박스를 체크해 주세요.");
	    		return "/jnit/util/alertBack";
	    	}
    	} catch (IOException e){
    		log.error(e.getMessage());
    		model.addAttribute("alert", "주소록에서 체크 박스를 체크해 주세요.");
    		return "/jnit/util/alertBack";
    	}catch(Exception e){
    		log.error(e.getMessage());
    		model.addAttribute("alert", "주소록에서 체크 박스를 체크해 주세요.");
    		return "/jnit/util/alertBack";
    	}
    	
    	if(view.equals("view")){
    		return "redirect:/sms/view/page.do?pageType=SmsAddr";
    	}else{
    		return "redirect:/cms/sms/list.do";
    	}
    }
    
}
