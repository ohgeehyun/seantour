package geocni.travel.route.web;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.type.CalendarTimeType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.context.ApplicationEventPublisherAware;
import org.springframework.social.connect.ApiAdapter;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.json.simple.JSONObject;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import geocni.travel.route.dao.TravelMainDAO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelMain;
import geocni.travel.route.service.TravelMainService;

import com.google.api.services.analytics.Analytics.Data;
import com.sun.star.io.IOException;


import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import net.sf.json.JSONArray;


@Controller
@SessionAttributes(types=TravelMain.class)
@RequestMapping(value="/travel/")
public class TravelMainController {

    @Resource(name = "travelMainService")
    private TravelMainService mainService;
    
    @Resource(name="travelMainDAO")
    private TravelMainDAO travelMainDAO;
    
    @Resource(name="egovMessageSource")
    private EgovMessageSource msgSrc;
    
//    @SuppressWarnings("unused")
//	@Autowired
//    private DefaultBeanValidator beanValidator;

	private Log log = LogFactory.getLog(getClass());
	
	//메인페이지 신호등 조작 컨트롤러 
    @SuppressWarnings("unchecked")
	@RequestMapping(value="mainBeachCongestion.do", method=RequestMethod.POST)
    @ResponseBody
	public List<TravelMain> mainBeachCongestion(
			 HttpServletRequest request	
			,HttpServletResponse response 
            ,SessionStatus status
			,Model model) throws Exception {
		
		List<TravelMain> beachPerPopulationList = null;
		try {
			beachPerPopulationList =  (List<TravelMain>) mainService.selectBeachPerCnt();
		} catch(Exception e) {
			beachPerPopulationList = null;
		}
		int index=0;
		for(TravelMain i : beachPerPopulationList){
			if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion())==1)
				{
					System.out.println(beachPerPopulationList.get(index).getCongestion());
				}
			index++;
		}
		return beachPerPopulationList;
	}
    
    @RequestMapping(value="checkBeachCongestion.do")
    @ResponseBody
	public void checkBeachCongestion(
			 HttpServletRequest request	
			,HttpServletResponse response 
            ,SessionStatus status
			,Model model) throws Exception {
    	
    	String api_key = "NCSDUEW5R2MDNLJJ";
		String api_secret = "2YG5WXA0SZPLJBFHW41DCWYDD2AWSWUD";
		Message coolsms = new Message(api_key, api_secret);
		HashMap<String, String> params = new HashMap<String, String>();
		String text = "[해수욕장 예약시스템]\n";
		
		List<TravelMain> beachPerPopulationList = null;
		try {
			beachPerPopulationList =  (List<TravelMain>) mainService.selectBeachPerCnt();
		} catch(Exception e) {
			beachPerPopulationList = null;
		}
		int index=0;
		int count=0;
		for(TravelMain i : beachPerPopulationList){
			if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion())>1)
				{
					System.out.println(beachPerPopulationList.get(index).getCongestion());
					text += beachPerPopulationList.get(index).getCongestion()+"\n";
					text += "현재 혼잡 이상 입니다.";
					params.put("to", "01067779217");
					params.put("from", "0442005254");
				    params.put("text", text);
				    params.put("type", "lms"); // 문자 타입
				    count ++;
				}
			index++;
		}
		   try {
			   if(count>0) {
				   /*params.put("to", "01052721274");
				   params.put("from", "0442005254");
				   params.put("text", text);
				   params.put("type", "lms");*/
			      JSONObject obj = (JSONObject) coolsms.send(params);
			      System.out.println(obj.toString());
			      count= 0;
			   }
			    } catch (CoolsmsException e) {
			      System.out.println(e.getMessage());
			      System.out.println(e.getCode());
			    }
		
	
	}
    
    
    
    
  ///kt 서버에서 데이터를 가저와서 우리 서버에 저장된 파일을 자동으로 DB에 백업
	@RequestMapping(value="cronBeachCongestion.do")
	public void cronBeachCongestion(
			 SessionStatus status
			,Model model) throws Exception {
		//DB 호출해서 정보값 가져오도록 할것.
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String datestr = sdf.format(cal.getTime());
		
		String filePath = EgovProperties.getProperty("Globals.fileStorePath");		
		
		File dir = new File(filePath + "main/");
		File []fileList = dir.listFiles();
		List<?> congestion = mainService.selectCongestion();
		
		for(File file:fileList) {
			if(file.isFile()) {
				String fileNm = file.getName();
				String fileDate = fileNm.substring(14, 26);
				
				int viewList = mainService.selectDataExistCnt(fileDate);
				
				if(viewList > 0) {
					continue;
				}
				
				String tempfilePath = filePath + "main/" + fileNm;
				
				List<String> lines = Files.readAllLines(Paths.get(tempfilePath), StandardCharsets.UTF_8);
				
				for(String line:lines) {
					int count = 0;
					Map<?,?> tempcongest =  (Map<?, ?>) congestion.get(count);
					String[] temp = line.split("\\|");
					TravelMain travelMain = new TravelMain();
					travelMain.setEtlDt(temp[0]);
					travelMain.setSeqId(temp[1]);
					travelMain.setPoiNm(temp[2]);
					travelMain.setUniqPop(temp[3]);
		
					int capacity =  (int)((int)tempcongest.get("area")/4);
					if(Double.parseDouble(temp[3]) <= capacity){
					travelMain.setCongestion("1");
					}else if(Double.parseDouble(temp[3]) < (int)tempcongest.get("area")/2 ){
						travelMain.setCongestion("2");
					}else{
						travelMain.setCongestion("3");
					}
					
					//4.데이터 insert
					try {
						count++;
					mainService.insertBeachPer(travelMain);
					}catch(SQLException e) {
						log.debug(e);
					}catch(Exception e) {
						log.debug(e);
					}
					
					System.out.println(line);
				}
			}
		}
		
		
		///////////
	/*	String datestrtimechange = String.valueOf(Integer.valueOf(datestr.substring(8,10)));//시간변경
	
		int minute = Integer.valueOf(datestr.substring(10, 12));   // 분
		String datestrtemp = datestr.substring(0,8);               // 년도 월 일 부분 교체 하기 위함 
		
		if(datestrtimechange == "00" && minute <= 30)                              // 00시 일 경우 전 날 23시 30분 에 대한 정보가 필요
		{
			cal.add(Calendar.DATE, -1);                            //전날 
			datestr =sdf.format(cal.getTime());
			datestrtemp = datestr.substring(0,8);                  // 년도 월 일 
			datestrtimechange = "23"; //23시                                                     //시간        --> 최종적으로 datestrtemp+datestrtimechange 년도 월 일 시간 이 되어야함 
		}
		
																	//하나 추가 해야하는게 00시 30분일때 는 당일 00시에 대한정보를 가저와야한다 고로 이 부분을 추가해주자.
		
		
		if(minute > 0 && minute < 30) {                                                           
			if (Integer.parseInt(datestrtimechange) <= 10)
			{
			datestrtimechange= "0"+ String.valueOf(Integer.valueOf(datestrtimechange)-1);    //0분일 경우 전 시간에 대한 정보가 필요하다 또한 10시 미만일경우 int로 형변환후 계산시 숫자가 하나로 표기됨
			}else{
			datestrtimechange= String.valueOf(Integer.valueOf(datestrtimechange)-1);         // 시간에 -1 을 해도 2자리수일경우 굳이 "0"을 안붙혀줘도 된다. 
			}
			datestr = datestrtemp + datestrtimechange + "30";                               //끝에 30분 추가
		}else {
			datestr = Integer.valueOf(datestr.substring(0, 10)) + "00";                       // 30분 이상일 경우는 그 시간대에 00분 정보를 가저와야 함
		}
				
		//파일을 불러와서 DB에 파일 넣어줄것.
		String filePath = EgovProperties.getProperty("Globals.fileStorePath");
		filePath = filePath + "main/mof_beach_sum_" + datestr + ".txt";
		//mof_beach_sum_년월일시분.txt		
		
		List<String> lines = Files.readAllLines(Paths.get(filePath), StandardCharsets.UTF_8);
		StringBuffer sb = new StringBuffer();
		List<?> viewList = mainService.selectBeachPerCntInsert();
		List<?> congestion = mainService.selectCongestion();
		
	    
		for(String line:lines) {
			//1.테이블에서 해당 시간 count
			int count =0;
			Map<?,?> tempcongest =  (Map<?, ?>) congestion.get(count);
			
			//2.데이터 존재 여부 확인			
			if(viewList.size()==0)
			{
				//3.line에서 "|"로 split해서 travelMain 객체에 넣음 ( congest부분 -- 코드 깔끔하게 다시 다듬을 필요있음) 
				String[] temp = line.split("\\|");
				TravelMain travelMain = new TravelMain();
				travelMain.setEtlDt(temp[0]);
				travelMain.setSeqId(temp[1]);
				travelMain.setPoiNm(temp[2]);
				travelMain.setUniqPop(temp[3]);
				
				int capacity =  (int)((int)tempcongest.get("area")/4);
				if(Double.parseDouble(temp[3]) <= capacity){
				travelMain.setCongestion("1");
				}else if(Double.parseDouble(temp[3]) < (int)tempcongest.get("area")/2 ){
					travelMain.setCongestion("2");
				}else{
					travelMain.setCongestion("3");
				}
				//4.데이터 insert	
				try {
				count ++;
				mainService.insertBeachPer(travelMain);
				}catch(SQLException e) {
					log.debug(e);
				}catch(Exception e) {
					log.debug(e);
				}				
			}else {
				break;
			}
			
			System.out.println(line);
		}
		*/
	}
	

	
	@RequestMapping(value="getBeachCongestionApi.do")
	@ResponseBody
	public JSONObject responseApi() throws Exception{
	
		List<?> api = (List<?>) mainService.selectBeachPerCntapi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("Beach"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="checkBeachCongestion.do")
    @ResponseBody
	public void checkBeachCongestion(
			 HttpServletRequest request	
			,HttpServletResponse response 
            ,SessionStatus status
			,Model model) throws Exception {
    	
    	String api_key = "NCSDUEW5R2MDNLJJ";
		String api_secret = "2YG5WXA0SZPLJBFHW41DCWYDD2AWSWUD";
		Message coolsms = new Message(api_key, api_secret);
		HashMap<String, String> params = new HashMap<String, String>();
		String text = "[해수욕장 예약시스템]\n";
		
		List<TravelMain> beachPerPopulationList = null;
		try {
			beachPerPopulationList =  (List<TravelMain>) mainService.selectBeachPerCnt();
		} catch(Exception e) {
			beachPerPopulationList = null;
		}
		int index=0;
		int count=0;
		for(TravelMain i : beachPerPopulationList){
			if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion())>1)
				{
					System.out.println(beachPerPopulationList.get(index).getCongestion());
					text += beachPerPopulationList.get(index).getCongestion()+"\n";
					text += "현재 혼잡 이상 입니다.";
					params.put("to", "01028222484");
					params.put("from", "0442005254");
				    params.put("text", text);
				    params.put("type", "lms"); // 문자 타입
				    count ++;
				}
			index++;
		}
		   try {
			   if(count>0) {
				   /*params.put("to", "01052721274");
				   params.put("from", "0442005254");
				   params.put("text", text);
				   params.put("type", "lms");*/
			      JSONObject obj = (JSONObject) coolsms.send(params);
			      System.out.println(obj.toString());
			      count= 0;
			   }
			    } catch (CoolsmsException e) {
			      System.out.println(e.getMessage());
			      System.out.println(e.getCode());
			    }
		
	
	}
	
	
	
	
	
	
//	@RequestMapping(value="latest.do")
//	public String routeLatestList(
//			 TravelRoute travelRoute
//			,@RequestParam(value="titleLen",required=false, defaultValue="350")String titleLen
//			,SessionStatus status
//			,Model model) throws Exception {
//		
//		//travelRoute.setPageUnit(propertiesService.getInt("pageUnit"));
//		travelRoute.setPageSize(propertiesService.getInt("pageSize"));
//		travelRoute.setRoutType("W");
//		
//		model.addAllAttributes(routeService.selectTravelRouteListMap(travelRoute));
//		status.setComplete();
//		
//		model.addAttribute("titleLen", titleLen);
////		model.addAttribute("travelRoute", travelRoute);
//		
//		return skinPath + "latest";
//	}
//	
//    @RequestMapping(value="detail.do")
//    public String destinationDetail(
//    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
//  			,TravelRoute travelRoute
//            ,HttpServletRequest req
//    		,ModelMap model) throws Exception {
//    	
//    	try{
//
//    		if(NullUtil.isEmpty(travelRoute.getRoutId())) {
//    			throw new NullPointerException("조회 대상 정보가 없습니다");
//    		}
//
//    		routeService.updateTravelRouteHitCount(travelRoute.getRoutId());
//
//    		model.addAttribute("travelRoute", routeService.selectTravelRoute(travelRoute));
//
//    	} catch (NullPointerException e){
//			log.error(e.getMessage());
//    	}catch(Exception e){
//    		log.error(e.getMessage());
//    	}
//    	
//    	return skinPath + "detail";
//    }
//
//    @RequestMapping(value="register.do")
//    public String registerTravelRoute(
//    		 TravelRoute travelRoute
// 			,TravelDestination travelDestination
//            ,HttpServletRequest req
//            ,SessionStatus status
//    		,Model model) throws Exception {
//
//    	String viewPath = skinPath + "register";
//    	/*Device device = DeviceUtils.getCurrentDevice(req);
//    	
//    	if(device != null && (device.isMobile() || device.isTablet())) {
//    		viewPath = skinPath + "register_mob";
//    		travelDestination.setPageUnit(5);
//    		travelDestination.setPageSize(5);
//
//    	} else {*/
//    		travelDestination.setPageUnit(6);
//    		travelDestination.setPageSize(10);
//    	/*}*/
//    	
//    	try{
//	
//			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
//			model.addAttribute("regionList", regionList);
//	    	
//			List<String> searchCatList = new ArrayList<>();
//			searchCatList.add("관광지");
//			searchCatList.add("숙박");
//			searchCatList.add("체험");
//			searchCatList.add("음식점");
//			searchCatList.add("쇼핑");
//			Map<?,?> catList = destService.selectTravelDestiCategoryList(searchCatList);
//			model.addAttribute("catList", catList);
//			
//	    	travelDestination.setDestRegion("강원");
//	    	travelDestination.setDestCategory("관광지");
//			model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
//	    	
////	    	model.addAttribute("thumbPath", "https://www.seantour.com");
//	    	model.addAttribute("thumbPath", "");
////	    	model.addAttribute("absPath", "/geocni/travel");
//
//			travelRoute.setRoutRegion(travelDestination.getDestRegion());
//	        model.addAttribute("travelRoute", travelRoute);
//	    	
//    	} catch (NullPointerException e){
//			log.error(e.getMessage());
//    	}catch(Exception e){
//    		log.error(e.getMessage());
//    	}
//    	
//    	return viewPath;
//    }
//
//	@ResponseBody
//	@RequestMapping(value="insertAsync.do", produces="application/text;charset=utf8", method=RequestMethod.POST)
//    public String insertTravelRouteAsync(
//    		 TravelRoute travelRoute
//            ,HttpServletRequest req
// 			,Model model) throws Exception {
//    	
//		JSONObject JSON = new JSONObject();
//		try {
//			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
//			travelRoute.setRoutRegMember(loginVO.getMbrId());
//
//			if(NullUtil.isEmpty(loginVO.getMbrId())) {
//				throw new NullPointerException();
//			}
//			
//			travelRoute.setRoutType("U"); //일정 타입(''U''-사용자, ''W''-작가)
//			travelRoute.setRoutOpen("N"); //공개 여부("Y"-공개, "N"-비공개)
//			travelRoute = routeService.insertTravelRoute(travelRoute);
//
//			JSON.put("status", "success");
//			JSON.put("routId", travelRoute.getRoutId());
//			JSON.put("title", travelRoute.getRoutTitle());
//
//		} catch (NullPointerException e){
//			JSON.put("status", "error");
//			JSON.put("result", e.getMessage());
//		} catch (Exception e) {
//			JSON.put("status", "error");
//		}
//
//		//return "";
//		return JSON.toString();
//    	
//    }
//    
//    @RequestMapping(value="insert.do", method=RequestMethod.POST)
//    public String insertTravelRoute(
//    		 @ModelAttribute("travelRoute") TravelRoute travelRoute
//            ,BindingResult bindingResult
//            ,SessionStatus status
//            ,HttpServletRequest req
//    		,Model model) throws Exception {
//    	
//		try {
//			
//			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
//			travelRoute.setRoutRegMember(loginVO.getMbrId());
//
//			if(NullUtil.isEmpty(loginVO.getMbrId())) {
//				throw new NullPointerException();
//			}
//			
//			travelRoute.setRoutType("U"); //일정 타입(''U''-사용자, ''W''-작가)
//			travelRoute.setRoutOpen("N"); //공개 여부("Y"-공개, "N"-비공개)
//			travelRoute = routeService.insertTravelRoute(travelRoute);
//
//		} catch (NullPointerException e){
//			e.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		return "redirect:/cms/travel/route/list.do";
//    }
//
//    @RequestMapping(value="modify.do")
//    public String modifyTravelRoute(
//    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
//    		,TravelRoute travelRoute
// 			,TravelDestination travelDestination
//            ,HttpServletRequest req
//    		,ModelMap model) throws Exception {
//    	
//    	String viewPath = skinPath + "register";
//    	/*Device device = DeviceUtils.getCurrentDevice(req);
//    	
//    	if(device != null && (device.isMobile() || device.isTablet())) {
//    		viewPath = skinPath + "register_mob";
//    		travelDestination.setPageUnit(5);
//    		travelDestination.setPageSize(5);
//
//    	} else {*/
//    		travelDestination.setPageUnit(6);
//    		travelDestination.setPageSize(10);
//    	/*}*/
//    	
//    	try{
//
//    		List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
//    		model.addAttribute("regionList", regionList);
//        	
//        	travelDestination.setDestRegion("강원");
//        	travelDestination.setDestCategory("관광지");
//			model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
//        	
////        	model.addAttribute("thumbPath", "https://www.seantour.com");
//        	model.addAttribute("thumbPath", "");
////        	model.addAttribute("absPath", "/geocni/travel");
//
//        	travelRoute = routeService.selectTravelRoute(travelRoute);
//
//        	JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
//			travelRoute.setRoutRegMember(loginVO.getMbrId());
//
//			if(NullUtil.isEmpty(loginVO.getMbrId())) {
//				throw new NullPointerException();
//			} else {
//				if(!loginVO.getMbrId().equals(travelRoute.getRoutRegMember())) {
//					return "redirect:/";
//				} else {
//					model.addAttribute("travelRoute", travelRoute);
//				}
//			}
//
//    	} catch (NullPointerException e){
//			log.error(e.getMessage());
//    	}catch(Exception e){
//    		log.error(e.getMessage());
//    	}
//    	
//    	return viewPath;
//    }
//
//	@ResponseBody
//	@RequestMapping(value="updateAsync.do", produces="application/text;charset=utf8", method=RequestMethod.POST)
//    public String updateTravelRouteAsync(
//    		 TravelRoute travelRoute
//            ,HttpServletRequest req
// 			,Model model) throws Exception {
//    	
//		JSONObject JSON = new JSONObject();
//		try {
//			
//			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
//			travelRoute.setRoutRegMember(loginVO.getMbrId());
//
//			if(NullUtil.isEmpty(loginVO.getMbrId())) {
//				throw new NullPointerException();
//			}
//			
//			if(NullUtil.isEmpty(travelRoute.getRoutId()) 
//					|| NullUtil.isEmpty(travelRoute.getRoutId())) {
//				throw new NullPointerException();
//			}
//			
//			TravelRoute route = new TravelRoute();
//			route.setRoutId(travelRoute.getRoutId());
//			route = routeService.selectTravelRoute(route);
//			if(NullUtil.isEmpty(route.getRoutRegMember()) 
//					|| !route.getRoutRegMember().equals(travelRoute.getRoutRegMember())) {
//				throw new Exception();
//			}
//			
//			travelRoute.setRoutType("U"); //일정 타입(''U''-사용자, ''W''-작가)
//			travelRoute.setRoutOpen("N"); //공개 여부("Y"-공개, "N"-비공개)
//			routeService.updateTravelRoute(travelRoute);
//
//			JSON.put("status", "success");
//			JSON.put("routId", travelRoute.getRoutId());
//			JSON.put("title", travelRoute.getRoutTitle());
//		
//		} catch (NullPointerException e){
//			JSON.put("status", "error");
//			JSON.put("result", e.getMessage());
//		} catch (Exception e) {
//			JSON.put("status", "error");
//		}
//
//		//return "";
//		return JSON.toString();
//    	
//    }
//    
//    @RequestMapping(value="update.do", method=RequestMethod.POST)
//    public String updateTravelRoute(
//    		 @ModelAttribute("searchVO") TravelDefaultVO searchVO
//     		,@ModelAttribute("travelRoute") TravelRoute travelRoute
//            ,BindingResult bindingResult
//            ,SessionStatus status
//            ,HttpServletRequest req
//    		,Model model) throws Exception {
//    	
//    		try {
//
//    			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
//    			travelRoute.setRoutRegMember(loginVO.getMbrId());
//
//    			if(NullUtil.isEmpty(loginVO.getMbrId())) {
//    				throw new NullPointerException();
//    			}
//    			
//    			if(NullUtil.isEmpty(travelRoute.getRoutId()) 
//    					|| NullUtil.isEmpty(travelRoute.getRoutId())) {
//    				throw new NullPointerException();
//    			}
//    			
//    			TravelRoute route = new TravelRoute();
//    			route.setRoutId(travelRoute.getRoutId());
//    			route = routeService.selectTravelRoute(route);
//    			if(NullUtil.isEmpty(route.getRoutRegMember()) 
//    					|| !route.getRoutRegMember().equals(travelRoute.getRoutRegMember())) {
//    				throw new Exception();
//    			}
//    			
//    			travelRoute.setRoutType("U"); //일정 타입(''U''-사용자, ''W''-작가)
//    			travelRoute.setRoutOpen("N"); //공개 여부("Y"-공개, "N"-비공개)
//
//    			routeService.updateTravelRoute(travelRoute);
//
//    		} catch (SQLException e) {
//				log.debug(e);;
//			} catch (NullPointerException e) {
//				log.debug(e);
//			}
//			
//    		return "redirect:/travel/member/myroute.do";
//    }
//    
//    @RequestMapping(value="delete.do", method=RequestMethod.POST)
//    public String deleteTravelRoute(
//    		 TravelRoute travelRoute
//            ,SessionStatus status
//            ,HttpServletRequest req
//    		,Model model) throws Exception {
//    	
//    		try {
//   				if(NullUtil.isEmpty(travelRoute.getRoutId())) {
//    				return "redirect:/travel/member/myroute.do";
//    			} else {
//    				routeService.deleteTravelRoutePhysically(travelRoute);
//    			}
//    			
//			} catch (SQLException e) {
//				log.debug(e);;
//			} catch (NullPointerException e) {
//				log.debug(e);
//			}
//			
//            status.setComplete();
//    		return "redirect:/travel/member/myroute.do";
//    }
//    
//    @RequestMapping(value="address.do")
//    public String searchAddress(
//    		 TravelRoute travelRoute
//            ,HttpServletRequest req
//            ,@RequestParam("status") String status
//            ,@RequestParam("idx") String idx
//    		,Model model) throws Exception {
//    	
////    	model.addAttribute("absPath", "/geocni/travel");
//    	model.addAttribute("status", status);
//    	model.addAttribute("idx", idx);
//
//    	return skinPath + "address";
//    }
//
//    @RequestMapping(value="searchpoint.do")
//    public String searchPoint(
//    		 HttpServletRequest req
//    		,@RequestParam("status") String status
//            ,@RequestParam("idx") String idx
//    		,Model model) throws Exception {
//    	
////    	model.addAttribute("absPath", "/geocni/travel");
//    	model.addAttribute("status", status);
//    	model.addAttribute("idx", idx);
//    	
//    	return skinPath + "searchPoint";
//    }
//    
}
