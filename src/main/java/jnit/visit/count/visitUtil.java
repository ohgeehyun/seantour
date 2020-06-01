/**
 * @version 3.2.0.1
 */
package jnit.visit.count;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.WeakHashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.fcc.service.StringUtil;
import jnit.cms.mbr.JnitcmsmbrDefaultVO;
import jnit.cms.mbr.JnitcmsmbrService;
import jnit.cms.site.JnitcmssiteDefaultVO;
import jnit.cms.site.JnitcmssiteService;
import jnit.db.JnitDbUtil;
import jnit.menu.JnitmenuDefaultVO;
import jnit.menu.JnitmenuService;
import jnit.util.JavaUtilDateJsonValueProcessor;
import jnit.visit.log.JnitvisitlogDefaultVO;
import jnit.visit.log.JnitvisitlogService;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

public class visitUtil {

	private Log log = LogFactory.getLog(getClass());
    private final static String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
    public static final String SEPERATOR = File.separator;
    public static final String VISIT_PATH = "visit" + SEPERATOR;
    public static final String VISIT_LATEST_PATH = VISIT_PATH + "_latest" + SEPERATOR;
	
    public static JSONObject visitStats() throws ParseException, IOException{
    	
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    	
    	JnitvisitlogService jnitvisitlogService = (JnitvisitlogService) wContext.getBean("jnitvisitlogService");

    	
    	/* MainChartStats */
		JnitvisitlogDefaultVO countVO = new JnitvisitlogDefaultVO();		
    	int minusMin = 5;	//5분 간격(변경시 SQLMAP도 수정)
    	int count = 0;		//방문자 수 초기화
    	
    	Calendar todayMilly = Calendar.getInstance();
    	
    	Calendar todayTime1 = Calendar.getInstance();
    	Calendar todayTime2 = Calendar.getInstance();
    	Calendar yesterdayTime1 = Calendar.getInstance();
    	Calendar yesterdayTime2 = Calendar.getInstance();

    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	
    	Calendar cal = Calendar.getInstance();
    	Date now = cal.getTime();
    	String todayDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    	
		JSONObject jsonObjSet = new JSONObject();
		JSONObject jsonObjGet = new JSONObject();
    	
		String visitDirPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + VISIT_PATH;
    	String latestDirPath = request.getSession().getServletContext().getRealPath("") + SEPERATOR + VISIT_LATEST_PATH;
    	File visitDir = new File(visitDirPath);
    	File latestDir = new File(latestDirPath);
    	
    	String latestPathT =  latestDir + SEPERATOR + "VisitStats" + ".json";
    	
    	if(!visitDir.exists()){
    		visitDir.mkdir();
    	}
    	if(!latestDir.exists()){
			latestDir.mkdir();
		}
    	
		File dataFile = new File(latestPathT);
		Boolean hasFile = false;
		Boolean equalData = false;
		
		if(!dataFile.exists()){
			hasFile = false;
		}else{
			hasFile = true;
		}
		
		if(hasFile){	//파일이 존재하면
			
			todayTime1.setTime(dateFormat.parse(todayDateFormat));
			todayTime2.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime1.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime1.set(Calendar.DATE, yesterdayTime1.get(yesterdayTime1.DATE) - 1);
			yesterdayTime2.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime2.set(Calendar.DATE, yesterdayTime2.get(yesterdayTime2.DATE) - 1);
			
			if( (todayMilly.getTimeInMillis() - dataFile.lastModified()) < (60000 * 5)){				//5분 이하(equalData = false)
				
				JsonValueProcessor beanProcessor = new JavaUtilDateJsonValueProcessor();
				JsonConfig jsonConfig = new JsonConfig();
				jsonConfig.registerJsonValueProcessor(java.util.Date.class, beanProcessor);
			        
	    		String JsonStr = FileUtils.readFileToString(dataFile, "UTF-8");
	    		jsonObjGet = JSONObject.fromObject(JsonStr, jsonConfig);
				equalData = false;
				
			}else{		//5분 이상(equalData = true)
				equalData = true;
			}
			
		}else{			//파일이 존재하지 않으면
			
			todayTime1.setTime(dateFormat.parse(todayDateFormat));
			todayTime2.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime1.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime1.set(Calendar.DATE, yesterdayTime1.get(yesterdayTime1.DATE) - 1);
			yesterdayTime2.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime2.set(Calendar.DATE, yesterdayTime2.get(yesterdayTime2.DATE) - 1);
			
			for(int i=0, m=0; i<11; i++, m=m){		//i=10번 반복, m=초기값0 1번 돌고 5분 유지

				todayTime1.set(Calendar.MINUTE, todayTime1.get(todayTime1.MINUTE) - minusMin);
				todayTime2.set(Calendar.MINUTE, todayTime2.get(todayTime2.MINUTE) - m);
				
				countVO.setSearchCondition("2");
				countVO.setSearchKeyword(dateFormat.format(todayTime1));
				countVO.setSearchKeyword2(dateFormat.format(todayTime2));
				count = jnitvisitlogService.selectJnitvisitlogListTotCnt(countVO);							//오늘 접속자 조회
				
				jsonObjSet.put(i, count);
				
				yesterdayTime1.set(Calendar.MINUTE, yesterdayTime1.get(yesterdayTime1.MINUTE) - minusMin);
				yesterdayTime2.set(Calendar.MINUTE, yesterdayTime2.get(yesterdayTime2.MINUTE) - m);
				
				countVO.setSearchCondition("2");
				countVO.setSearchKeyword(dateFormat.format(yesterdayTime1));
				countVO.setSearchKeyword2(dateFormat.format(yesterdayTime2));
				count = jnitvisitlogService.selectJnitvisitlogListTotCnt(countVO);							//어제 접속자 조회
				
				jsonObjSet.put(i+200, count);																//어제 접속자는 100이상으로 구분
				
				m=5;
			}
			
			FileWriter latestFileT = new FileWriter(latestPathT);
			latestFileT.write(jsonObjSet.toString());
			latestFileT.flush();
			latestFileT.close();
			
			JsonValueProcessor beanProcessor = new JavaUtilDateJsonValueProcessor();
			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(java.util.Date.class, beanProcessor);
		        
    		String JsonStr = FileUtils.readFileToString(dataFile, "UTF-8");
    		jsonObjGet = JSONObject.fromObject(JsonStr, jsonConfig);
			
		}
		
		if(equalData){																							//5분 초과 데이터 리로드
			
			todayTime1.setTime(dateFormat.parse(todayDateFormat));
			todayTime2.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime1.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime1.set(Calendar.DATE, yesterdayTime1.get(yesterdayTime1.DATE) - 1);
			yesterdayTime2.setTime(dateFormat.parse(todayDateFormat));
			yesterdayTime2.set(Calendar.DATE, yesterdayTime2.get(yesterdayTime2.DATE) - 1);
			
			for(int i=0, m=0; i<11; i++, m=m){		//i=10번 반복자, m=초기값0 1번 돌고 5분 유지

				todayTime1.set(Calendar.MINUTE, todayTime1.get(todayTime1.MINUTE) - minusMin);
				todayTime2.set(Calendar.MINUTE, todayTime2.get(todayTime2.MINUTE) - m);
				
				countVO.setSearchCondition("2");
				countVO.setSearchKeyword(dateFormat.format(todayTime1));
				countVO.setSearchKeyword2(dateFormat.format(todayTime2));
				count = jnitvisitlogService.selectJnitvisitlogListTotCnt(countVO);								//오늘 접속자 조회
				
				jsonObjSet.put(i, count);
				
				yesterdayTime1.set(Calendar.MINUTE, yesterdayTime1.get(yesterdayTime1.MINUTE) - minusMin);
				yesterdayTime2.set(Calendar.MINUTE, yesterdayTime2.get(yesterdayTime2.MINUTE) - m);
				
				countVO.setSearchCondition("2");
				countVO.setSearchKeyword(dateFormat.format(yesterdayTime1));
				countVO.setSearchKeyword2(dateFormat.format(yesterdayTime2));
				count = jnitvisitlogService.selectJnitvisitlogListTotCnt(countVO);								//어제 접속자 조회
				
				jsonObjSet.put(i+200, count);
				
				m = 5;
			}
			
			FileWriter latestFileT = new FileWriter(latestPathT);
			latestFileT.write(jsonObjSet.toString());
			latestFileT.flush();
			latestFileT.close();
			
			JsonValueProcessor beanProcessor = new JavaUtilDateJsonValueProcessor();
			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(java.util.Date.class, beanProcessor);
		        
    		String JsonStr = FileUtils.readFileToString(dataFile, "UTF-8");
    		jsonObjGet = JSONObject.fromObject(JsonStr, jsonConfig);
    		
		}
		return jsonObjGet;
    }
    
    public static WeakHashMap totalMap(ModelMap model) throws Exception{
    	
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    	HttpSession session = request.getSession();
    	ServletContext context = session.getServletContext();
    	WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);
    	
    	JnitcmsmbrService jnitcmsmbrService = (JnitcmsmbrService)wContext.getBean("jnitcmsmbrService");
    	JnitcmssiteService jnitcmssiteService = (JnitcmssiteService)wContext.getBean("jnitcmssiteService");
    	JnitmenuService jnitmenuService = (JnitmenuService)wContext.getBean("jnitmenuService");
    	JnitvisitcountService jnitvisitcountService = (JnitvisitcountService)wContext.getBean("jnitvisitcountService");
    	JnitvisitlogService jnitvisitlogService = (JnitvisitlogService)wContext.getBean("jnitvisitlogService");
    	
    	WeakHashMap<String, Integer> totalMap = new WeakHashMap<String, Integer>();
    	int minusDate = 0;

    	Calendar cal = Calendar.getInstance();
    	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    	SimpleDateFormat formatMin = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	
    	Date now = cal.getTime();
    	String todayFormat = new SimpleDateFormat("yyyy-MM-dd").format(now);
    	String todayFormatMin = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    	
    	/* Total Site */
    	JnitcmssiteDefaultVO siteVO = new JnitcmssiteDefaultVO();
    	int totalSite = jnitcmssiteService.selectJnitcmssiteListTotCnt(siteVO);
    		totalMap.put("totalSite", totalSite);

    	/* Total Users */
    	JnitcmsmbrDefaultVO mbrVo = new JnitcmsmbrDefaultVO();
    	int totalMbr = jnitcmsmbrService.selectJnitcmsmbrListTotCnt(mbrVo);
    		totalMap.put("totalMbr", totalMbr);
    		
    	/* Total Pages */
    	JnitmenuDefaultVO menuVO = new JnitmenuDefaultVO();
    	int totalPage = jnitmenuService.selectJnitmenuListTotCnt(menuVO);
    		totalMap.put("totalPage", totalPage);
    	
    	/* 전체 방문자 수 */
    	JnitvisitcountDefaultVO totalVisitVO = new JnitvisitcountDefaultVO();
    	int totalVisit = 0;
    	try{
    		totalVisit = jnitvisitcountService.selectJnitvisitcountHitTotCnt(totalVisitVO);
    	} catch (NullPointerException e){
    		totalVisit = 0;
    	}catch(Exception e){
    		totalVisit = 0;
    	}
    		totalMap.put("totalVisit", totalVisit);
    	
    	/* 금일 방문자 수 */
    	JnitvisitcountVO todayVisitCountVO = new JnitvisitcountVO();
    	cal.setTime(format.parse(todayFormat));
    	todayVisitCountVO.setVdate(cal.getTime());
    	
    	JnitvisitcountVO today = new JnitvisitcountVO();
    	int totalToday = 0;
    	
    	/* 금일 방문자 수가 NULL이면 강제로 1을 지정 */
    	try{
    		today = jnitvisitcountService.selectJnitvisitTotalCount(todayVisitCountVO);
    		totalToday = today.getHit();
    	} catch (NullPointerException e){
    		totalToday = 1;
    	}catch(Exception e){
    		//log.error(e.getMessage());
    		totalToday = 1;
    	}
    		totalMap.put("totalToday", totalToday);
    		
    	/* 전일 방문자 수 */
    	JnitvisitcountVO yesterdayVisitCountVO = new JnitvisitcountVO();
    		minusDate = 0;
	    	minusDate = 1;																				//1일전
	    	cal.setTime(format.parse(todayFormat));
	    	cal.set(Calendar.DATE, cal.get(Calendar.DATE)-minusDate);
	    	yesterdayVisitCountVO.setVdate(cal.getTime());
	    try{
    	JnitvisitcountVO yesterday = jnitvisitcountService.selectJnitvisitTotalCount(yesterdayVisitCountVO);
    	
    	int totalYesterday = yesterday.getHit();
		totalMap.put("totalYesterday", totalYesterday);
	    } catch (NullPointerException e){
	    	int totalYesterday = 0;
			totalMap.put("totalYesterday", totalYesterday);
	    }catch(Exception e){
	    	int totalYesterday = 0;
			totalMap.put("totalYesterday", totalYesterday);
	    	//log.error(e.getMessage());
	    }
    		
    	/* 현재 방문자 수(실시간) */
    	cal.setTime(format.parse(todayFormat));
		String minusMinute = "-5";																		//5분전
    	JnitvisitlogDefaultVO visitantVO = new JnitvisitlogDefaultVO();
    		
    		Calendar nowTime1 = Calendar.getInstance();
    		Calendar nowTime2 = Calendar.getInstance();
    		nowTime1.setTime(formatMin.parse(todayFormatMin));
			nowTime2.setTime(formatMin.parse(todayFormatMin));
			
			nowTime1.set(Calendar.MINUTE, nowTime1.get(nowTime1.MINUTE) - 5);
			
			visitantVO.setSearchCondition("2");
			visitantVO.setSearchKeyword(formatMin.format(nowTime1));
			visitantVO.setSearchKeyword2(formatMin.format(nowTime2));
			
    	int nowVisit = jnitvisitlogService.selectJnitvisitlogListTotCnt(visitantVO)+1;					//5분간의 로그가 없을경우 0으로 나오니 자기자신을 +1
    		totalMap.put("nowVisit", nowVisit);
    		
    	/* 일일 증감율 */
    	int yesterCount = 0;
    	int beforeYesterCount = 0;
    	
		JnitvisitcountVO yesterVO = new JnitvisitcountVO();
			minusDate = 0;
	    	minusDate = 1;																				//1일전
	    	cal.setTime(format.parse(todayFormat));
	    	cal.set(Calendar.DATE, cal.get(Calendar.DATE)-minusDate);
	    	yesterVO.setVdate(cal.getTime());
	    	
	    try{	//1일전 Null 체크
	    	JnitvisitcountVO yester = jnitvisitcountService.selectJnitvisitTotalCount(yesterVO);
	    	yesterCount = yester.getHit();
	    } catch (NullPointerException e){
	    	yesterCount = 0;
	    }catch(Exception e){
	    	//log.error(e.getMessage());
	    	yesterCount = 0;
	    }
	    	
	    	JnitvisitcountVO beforeYesterVO = new JnitvisitcountVO();
	    		minusDate = 0;
		    	minusDate = 2;																			//2일전
		    	cal.setTime(format.parse(todayFormat));
		    	cal.set(Calendar.DATE, cal.get(Calendar.DATE)-minusDate);
		    	beforeYesterVO.setVdate(cal.getTime());
	    try{	//2일전 Null 체크
	    	JnitvisitcountVO beforeYester = jnitvisitcountService.selectJnitvisitTotalCount(beforeYesterVO);
	    	beforeYesterCount = beforeYester.getHit();
	    } catch (NullPointerException e){
	    	beforeYesterCount = 0;
	    }catch(Exception e){
	    	//log.error(e.getMessage());
	    	beforeYesterCount = 0;
	    }
	    
	    	String totalPersent = "";
	    	double totalPersentDouble = (double)(yesterCount - beforeYesterCount) / yesterCount * 100;
	    	totalPersent = String.format("%.1f", totalPersentDouble);
	    	
	    	if(totalPersent.equals("NaN") || totalPersent.equals("-Infinity")){							//yesterCount=0 and beforeYesterCount=0 이면 NaN
	    		totalPersent = String.format("%.1f", 0.0);
	    	}
	    	
	    	boolean check = StringUtil.isExistString(totalPersent, "-");							//음수, 양수 체크
	    	int minusCheck = 0;
	    		
	    	if(check == true){
	    		minusCheck = 0;
	    	}else{
	    		minusCheck = 1;
	    	}
	    	totalMap.put("minusCheck", minusCheck);
	    	model.addAttribute("totalPersent", totalPersent);
	    return totalMap;
    }
	
    public static void totalVisit(String sitePath){
    	
    	sitePath = NullUtil.nullString(sitePath);
    	
    	if(!sitePath.equals("")){
    		
    		HashMap<String, String> siteList = new HashMap<String, String>();
    		
    		if(siteList.get(sitePath) != null){
    			
    			//Insert
    			
    		}else{
	    		String type = "ADD";
	    		String tableNm = "hkstest";
	    		String column = sitePath.replace("/", "");
	    		String columnType = "VARCHAR2";
	    		String size = "20";
	    		String defaultValue = "'0'";
	    		
	    		JnitDbUtil.alterTable(type, tableNm, column, columnType, size, defaultValue);
    		}
    	}
    	
    }
    
}
