/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import jnit.cms.CmsHelper;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.com.util.DBType;
import jnit.mgov.addressbook.JnitMgovAddrDefaultVO;
import jnit.mgov.addressbook.JnitMgovAddrGrpVO;
import jnit.mgov.addressbook.JnitMgovAddrService;

@Controller
public class JnitMgovViewController {

	private Log log = LogFactory.getLog(getClass());
	
	@Resource(name = "jnitmgovService")
    private JnitMgovService jnitmgovService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	final static String DEFAULT_PATH = "/jnit/mgov/view/";
	
	@RequestMapping("/sms/view/page.do")
	public String SmsViewPage(HttpServletRequest request, Model model
			, @RequestParam(value="pageType", required=false, defaultValue="AddrSend") String pageType) throws IOException{
		
		JnitMgovUtil.initSmsProp();
		JnitMgovUtil.getSmsProperties();
		
		Properties configVO =  (Properties)request.getSession().getAttribute("smsConfig");
		JnitcmsmbrVO mbrVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
		
		if(pageType.equals("AddrSend") || pageType.equals("SmsAddr")){
			model.addAttribute("grpList", this.getAddrList());
		}
		
		model.addAttribute("configVO", configVO);
		return DEFAULT_PATH+pageType;
	}
	
	@RequestMapping("/sms/view/smsSendList.do")
	public String SmsSendList(HttpServletRequest request, Model model
			, @ModelAttribute("searchVO") JnitMgovDefaultVO searchVO) throws IOException{
		
		JnitcmsmbrVO mbrVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
		
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
		HashMap resultState = new HashMap(); 
		int totCnt = 0;
		
		try{
			jnitMgovList = jnitmgovService.selectJnitmgovList(searchVO);
			state = jnitmgovService.selectJnitmgovState(searchVO);
			totCnt = jnitmgovService.selectJnitmgovListTotCnt(searchVO);
			
			EgovMap map = (EgovMap)state.get(0);
			
			if(DBType.getDbTypeBoolean("mysql")){
				Long total = (Long)map.get("total");
				Long success = (Long)map.get("success");
				Long failed = (Long)map.get("failed");
				
				resultState.put("total", total);
				resultState.put("success", success);
				resultState.put("failed", failed);
			}else if(DBType.getDbTypeBoolean("cubrid")){
				int total = (Integer)map.get("total");
				int success = (Integer)map.get("success");
				int failed = (Integer)map.get("failed");
				
				resultState.put("total", total);
				resultState.put("success", success);
				resultState.put("failed", failed);
			}else if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
				String total = String.valueOf(map.get("total"));
				String success = String.valueOf(map.get("success"));
				String failed = String.valueOf(map.get("failed"));
				
				resultState.put("total", total);
				resultState.put("success", success);
				resultState.put("failed", failed);
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			
			if(DBType.getDbTypeBoolean("mysql")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}else if(DBType.getDbTypeBoolean("cubrid")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}else if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}
		}catch(Exception e){
			log.error(e.getMessage());
			
			if(DBType.getDbTypeBoolean("mysql")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}else if(DBType.getDbTypeBoolean("cubrid")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}else if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
        model.addAttribute("resultList", jnitMgovList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("resultDate", resultDate);
        model.addAttribute("resultState", resultState);
        model.addAttribute("smsType", smsType);
		
		return DEFAULT_PATH+"SmsSendList";
	}
	
	@RequestMapping("/sms/view/lmsSendList.do")
	public String LmsSendList(HttpServletRequest request, Model model
			, @ModelAttribute("searchVO") JnitMgovDefaultVO searchVO) throws IOException{
		
		JnitcmsmbrVO mbrVO = (JnitcmsmbrVO) CmsHelper.getAuthMbr(request);
		if(mbrVO.getMbrId() == null){
			model.addAttribute("alert", "로그인을 해주세요.");
			return "/jnit/util/alertBack";
		}
		
		String smsType = NullUtil.nullString(JnitMgovUtil.getSmsType());
    	
    	if(!smsType.equals("mgov")){
    		model.addAttribute("alert", "정부통합전산모듈에서만 LMS가 지원됩니다. SMS 리스트로 이동합니다.");
    		model.addAttribute("path", "/sms/view/smsSendList.do");
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
		HashMap resultState = new HashMap(); 
		int totCnt = 0;
		
		try{
			jnitMgovList = jnitmgovService.selectJnitmgovList(searchVO);
			state = jnitmgovService.selectJnitmgovState(searchVO);
			totCnt = jnitmgovService.selectJnitmgovListTotCnt(searchVO);
			
			EgovMap map = (EgovMap)state.get(0);
			
			if(DBType.getDbTypeBoolean("mysql")){
				Long total = (Long)map.get("total");
				Long success = (Long)map.get("success");
				Long failed = (Long)map.get("failed");
				
				resultState.put("total", total);
				resultState.put("success", success);
				resultState.put("failed", failed);
			}else if(DBType.getDbTypeBoolean("cubrid")){
				int total = (Integer)map.get("total");
				int success = (Integer)map.get("success");
				int failed = (Integer)map.get("failed");
				
				resultState.put("total", total);
				resultState.put("success", success);
				resultState.put("failed", failed);
			}else if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
				String total = String.valueOf(map.get("total"));
				String success = String.valueOf(map.get("success"));
				String failed = String.valueOf(map.get("failed"));
				
				resultState.put("total", total);
				resultState.put("success", success);
				resultState.put("failed", failed);
			}
		} catch (NullPointerException e){
			log.error(e.getMessage());
			
			if(DBType.getDbTypeBoolean("mysql")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}else if(DBType.getDbTypeBoolean("cubrid")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}else if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}
		}catch(Exception e){
			log.error(e.getMessage());
			
			if(DBType.getDbTypeBoolean("mysql")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}else if(DBType.getDbTypeBoolean("cubrid")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}else if(DBType.getDbTypeBoolean("oracle")||DBType.getDbTypeBoolean("tibero")){
				resultState.put("total", 0);
				resultState.put("success", 0);
				resultState.put("failed", 0);
			}
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
        model.addAttribute("resultList", jnitMgovList);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("resultDate", resultDate);
        model.addAttribute("resultState", resultState);
        model.addAttribute("smsType", smsType);
		
		return DEFAULT_PATH+"LmsSendList";
	}
	
	
	private static List<String> getAddrList(){
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
		
		JnitMgovAddrService jnitMgovAddrService = (JnitMgovAddrService)wContext.getBean("jnitMgovAddrService");
		
		JnitcmsmbrVO mbrVO = (JnitcmsmbrVO)CmsHelper.getAuthMbr(request);
    	String userMbr = NullUtil.nullString(mbrVO.getMbrLogin());
    	
    	JnitMgovAddrDefaultVO searchVO = new JnitMgovAddrDefaultVO();
    		searchVO.setSearchKeyword(userMbr);
    		
    	List grpList = new ArrayList();
    	try{
    		grpList = jnitMgovAddrService.selectJnitMgovAddrGrp(searchVO);
    		
    		if(grpList.size() < 1){
        		JnitMgovAddrGrpVO vo = new JnitMgovAddrGrpVO();
        			vo.setUserMbr(userMbr);
        			vo.setGrpNm("기본");
        		jnitMgovAddrService.insertJnitMgovAddrGrp(vo);
        		
        		grpList = jnitMgovAddrService.selectJnitMgovAddrGrp(searchVO);
        	}
    	} catch (NullPointerException e){
    		grpList = new ArrayList<String>();
    	}catch(Exception e){
    		grpList = new ArrayList<String>();
    	}
    	
    	return grpList;
		
	}
	
}
