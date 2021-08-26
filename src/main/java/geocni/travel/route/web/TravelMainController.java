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
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.type.CalendarTimeType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.context.ApplicationEventPublisherAware;
import org.springframework.social.connect.ApiAdapter;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.json.simple.JSONObject;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.dao.TravelMainDAO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelMain;
import geocni.travel.route.domain.TravelReservation;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelRoute;
import geocni.travel.route.domain.TravelRouteDaily;
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
    
    
    
	@Resource(name = "egovMessageSource")
	private EgovMessageSource msgSrc;

	// @SuppressWarnings("unused")
	// @Autowired
	// private DefaultBeanValidator beanValidator;

	private Log log = LogFactory.getLog(getClass());

	// 메인페이지 신호등 조작 컨트롤러
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "mainBeachCongestion.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TravelMain> mainBeachCongestion(HttpServletRequest request, HttpServletResponse response,
			SessionStatus status, Model model) throws Exception {

		List<TravelMain> beachPerPopulationList = null;
		try {
			beachPerPopulationList = (List<TravelMain>) mainService.selectBeachPerCnt();
		} catch (Exception e) {
			beachPerPopulationList = null;
		}
		int index = 0;
		for (TravelMain i : beachPerPopulationList) {
			
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 1) {
				/*	*/
			}
			index++;
		}
		return beachPerPopulationList;
	}

	@RequestMapping(value = "checkBeachCongestion.do")
	@ResponseBody
	public void checkBeachCongestion() throws Exception {

		String api_key = "NCSZPN7QJLDRD5N1";
		String api_secret = "10IG7LEYQRUA4BYFKE4FKFIWCXEWCZBJ";
		Message coolsms = new Message(api_key, api_secret);
		/*HashMap<String, String> params = new HashMap<String, String>(); // 도청*/
		
		HashMap<String, String> params2 = new HashMap<String, String>();// 시청
		String text = "[해수욕장 혼잡도 신호등]\n";
	
		List<TravelMain> beachPerPopulationList = null;
		List<TravelMain> beachinfo = null;
		try {
			beachPerPopulationList = (List<TravelMain>) mainService.selectBeachPerCnt();
		} catch (Exception e) {
			beachPerPopulationList = null;
		}
		
		try {
			beachinfo = (List<TravelMain>) mainService.selectBeachPerCnt();
		} catch (Exception e) {
			beachinfo = null;
		}
		
		
		String[] government = new String[10]; // 도청 전화번호
		government[0] = "01065991060,01046027948";// 강원도청
		government[1] = "01040395434,01099296136";// 경남도청
		government[2] = "01092772373,01050525852";// 경북도청
		government[3] = "01035146608,01045667560";// 부산시청
		government[4] = "01054864134,01099950806";// 울산시청
		government[5] = "01073448896,01033200198";// 인천시청
		government[6] = "01036075669,01095226371";// 전남도청
		government[7] = "01073707086,01040031075";// 전북도청
		government[8] = "01096215335,01087380696";// 제주시청
		government[9] = "01079339665,01041155959";// 충남도청
		
	
		for(TravelMain i : beachPerPopulationList){
			
		    if(i.getCongestion().equals("2") || i.getCongestion().equals("3"))
		    {
		    	text += "현재 "+ i.getPoiNm()+"해수욕장 혼잡 이상입니다.";
		    	try {
					params2.put("to", "01067779217,01042127518,01074502921,01097773630");
		    		/*params2.put("to", "01067779217");*/
					params2.put("from", "053-817-7312");
					params2.put("text", text);
					params2.put("type", "lms");
					JSONObject obj = (JSONObject) coolsms.send(params2);
					System.out.println(obj.toString());
					}catch(CoolsmsException e) {
					System.out.println(e);
					}	
		    	
		    	//강원도 강릉시
		    	if(Integer.parseInt(i.getSeqId()) <= 18) {
		    		try {
						params2.put("to", government[0]+",01022472897,01051081031");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//강원도 고성군
		    	if(Integer.parseInt(i.getSeqId()) > 18 && Integer.parseInt(i.getSeqId())<=46 ) {
		    		try {
						params2.put("to", government[0]+",01047034291,01083836347");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//강원도 동해시
		    	if(Integer.parseInt(i.getSeqId()) > 47 && Integer.parseInt(i.getSeqId())<=50 ) {
		    		try {
						params2.put("to", government[0]+",01033975455,01041804055");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//강원도 삼척시
		    	if(Integer.parseInt(i.getSeqId()) > 50 && Integer.parseInt(i.getSeqId())<=63 ) {
		    		try {
						params2.put("to", government[0]+",01099585844,01050996593");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//강원도 삼척시
		    	if(Integer.parseInt(i.getSeqId()) > 63 && Integer.parseInt(i.getSeqId())<=66 ) {
		    		try {
						params2.put("to", government[0]+",01026748312,01066674528");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//강원도 양양군
		    	if(Integer.parseInt(i.getSeqId()) > 66 && Integer.parseInt(i.getSeqId())<=87 ) {
		    		try {
						params2.put("to", government[0]+",01020283161,01029650240");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상남도 거제시
		    	if(Integer.parseInt(i.getSeqId()) > 87 && Integer.parseInt(i.getSeqId())<=103 ) {
		    		try {
						params2.put("to", government[1]+",01093105940,01041408932");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상남도 남해군
		    	if(Integer.parseInt(i.getSeqId()) > 103 && Integer.parseInt(i.getSeqId())<=108 ) {
		    		try {
						params2.put("to", government[1]+",01073581225,01091349810");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상남도 사천시
		    	if(Integer.parseInt(i.getSeqId()) == 109 ) {
		    		try {
						params2.put("to", government[1]+",01038386271,01041514196");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상남도 창원시
		    	if(Integer.parseInt(i.getSeqId()) == 110 ) {
		    		try {
						params2.put("to", government[1]+",01093132545,01046916151");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상남도 통영시
		    	if(Integer.parseInt(i.getSeqId()) > 110 && Integer.parseInt(i.getSeqId()) <= 113 ) {
		    		try {
						params2.put("to", government[1]+",01038486331,01093709941");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상북도 경주시
		    	if(Integer.parseInt(i.getSeqId()) > 113 && Integer.parseInt(i.getSeqId()) <= 118 ) {
		    		try {
						params2.put("to", government[2]+",01083881989, 01072514802");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상북도 영덕군
		    	if(Integer.parseInt(i.getSeqId()) > 118 && Integer.parseInt(i.getSeqId()) <= 125 ) {
		    		try {
						params2.put("to", government[2]+",01033851254, 01088584616");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상북도 울진군
		    	if(Integer.parseInt(i.getSeqId()) > 125 && Integer.parseInt(i.getSeqId()) <= 132 ) {
		    		try {
						params2.put("to", government[2]+",01036908315, 01092361651");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//경상북도 울진군
		    	if(Integer.parseInt(i.getSeqId()) > 132 && Integer.parseInt(i.getSeqId()) <= 138 ) {
		    		try {
						params2.put("to", government[3]+",01051418644, 01051724575");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//부산광역시 기장군
		    	if(Integer.parseInt(i.getSeqId()) > 138 && Integer.parseInt(i.getSeqId()) <= 140 ) {
		    		try {
						params2.put("to", government[3]+",01076616936, 01031202189");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//부산광역시 사하구
		    	if(Integer.parseInt(i.getSeqId())==141 ) {
		    		try {
						params2.put("to", government[3]+",01028288143, 01040895417");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//부산광역시 서구
		    	if(Integer.parseInt(i.getSeqId())==142 ) {
		    		try {
						params2.put("to", government[3]+",01085599824, 01084325255");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//부산광역시 수영구
		    	if(Integer.parseInt(i.getSeqId())==143 ) {
		    		try {
						params2.put("to", government[3]+",01092367390, 01063237067");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//부산광역시 해운대구
		    	if(Integer.parseInt(i.getSeqId()) >143 && Integer.parseInt(i.getSeqId()) <= 145 ) {
		    		try {
						params2.put("to", government[3]+",01095060356, 01045472108");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//울산 동구
		    	if(Integer.parseInt(i.getSeqId()) ==146 ) {
		    		try {
						params2.put("to", government[4]+",01092348786, 01040543451");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//울산 울주군
		    	if(Integer.parseInt(i.getSeqId()) ==147 ) {
		    		try {
						params2.put("to", government[4]+",01048715537, 01065870009");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//인천 옹진군
		    	if(Integer.parseInt(i.getSeqId()) >147 && Integer.parseInt(i.getSeqId()) <= 155) {
		    		try {
						params2.put("to", government[5]+",01046296110, 01071326631");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//인천 중구
		    	if(Integer.parseInt(i.getSeqId()) >155 && Integer.parseInt(i.getSeqId()) <= 158) {
		    		try {
						params2.put("to", government[5]+",01092697876, 01063903253");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 고흥군
		    	if(Integer.parseInt(i.getSeqId()) >158 && Integer.parseInt(i.getSeqId()) <= 169) {
		    		try {
						params2.put("to", government[6]+",01063479845, 01068508803");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 목포시
		    	if(Integer.parseInt(i.getSeqId())==170) {
		    		try {
						params2.put("to", government[6]+",01086072830, 01046164803");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 보성군
		    	if(Integer.parseInt(i.getSeqId())==171) {
		    		try {
						params2.put("to", government[6]+",01056484364, 01097006444");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 신안군
		    	if(Integer.parseInt(i.getSeqId())>171 && Integer.parseInt(i.getSeqId())<=186 ) {
		    		try {
						params2.put("to", government[6]+",01066266677, 01026259566");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 여수시
		    	if(Integer.parseInt(i.getSeqId())>186 && Integer.parseInt(i.getSeqId())<=201 ) {
		    		try {
						params2.put("to", government[6]+",01076515775, 01029300867");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 영광군
		    	if(Integer.parseInt(i.getSeqId())>201 && Integer.parseInt(i.getSeqId())<=203) {
		    		try {
						params2.put("to", government[6]+",01062570017, 01064175790");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 완도군
		    	if(Integer.parseInt(i.getSeqId())>203 && Integer.parseInt(i.getSeqId())<=213 ) {
		    		try {
						params2.put("to", government[6]+",01088205763, 01080743974");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 장흥군
		    	if(Integer.parseInt(i.getSeqId()) == 214 ) {
		    		try {
						params2.put("to", government[6]+",01085002873, 01046761548");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 진도군
		    	if(Integer.parseInt(i.getSeqId())>214 && Integer.parseInt(i.getSeqId())<= 218 ) {
		    		try {
						params2.put("to", government[6]+",01052117496, 01089254393");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 함평군
		    	if(Integer.parseInt(i.getSeqId())==219 ) {
		    		try {
						params2.put("to", government[6]+",01064196679, 01096670705");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전남 해남군
		    	if(Integer.parseInt(i.getSeqId())==220 ) {
		    		try {
						params2.put("to", government[6]+",01076254156, 01023754489");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전북 고창군
		    	if(Integer.parseInt(i.getSeqId())>220 && Integer.parseInt(i.getSeqId()) <=222 ) {
		    		try {
						params2.put("to", government[7]+",01026848835, 01030028638");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전북 군산시
		    	if(Integer.parseInt(i.getSeqId()) == 223 ) {
		    		try {
						params2.put("to", government[7]+",01075697770, 01031593125");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//전북 부안군
		    	if(Integer.parseInt(i.getSeqId()) > 223 && Integer.parseInt(i.getSeqId()) <= 228 ) {
		    		try {
						params2.put("to", government[7]+",01050389483, 01036614443");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//제주도 제주시
		    	if(Integer.parseInt(i.getSeqId()) > 228 && Integer.parseInt(i.getSeqId()) <= 236 ) {
		    		try {
						params2.put("to", government[8]+",01027980247, 01020805329");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//제주도 서귀포시
		    	if(Integer.parseInt(i.getSeqId()) > 236 && Integer.parseInt(i.getSeqId()) <= 240 ) {
		    		try {
						params2.put("to", government[8]+",01036946292, 01056331998");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//충남 당진시
		    	if(Integer.parseInt(i.getSeqId()) > 240 && Integer.parseInt(i.getSeqId()) <= 242 ) {
		    		try {
						params2.put("to", government[9]+",01052616176, 01049463865");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//충남 보령시
		    	if(Integer.parseInt(i.getSeqId()) == 243  ) {
		    		try {
						params2.put("to", government[9]+",01093043379, 01029305452");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//충남 보령시
		    	if(Integer.parseInt(i.getSeqId()) == 244  ) {
		    		try {
						params2.put("to", government[9]+",01088037071, 01099612090");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//충남 서천군
		    	if(Integer.parseInt(i.getSeqId()) == 245  ) {
		    		try {
						params2.put("to", government[9]+",01054940976, 01088815427");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		    	//충남 태안군
		    	if(Integer.parseInt(i.getSeqId()) >245 && Integer.parseInt(i.getSeqId()) <= 273 ) {
		    		try {
						params2.put("to", government[9]+",01074114960, 01097007131");
						params2.put("from", "053-817-7312");
						params2.put("text", text);
						params2.put("type", "lms");
						JSONObject obj = (JSONObject) coolsms.send(params2);
						System.out.println(obj.toString());
						break;
						}catch(CoolsmsException e) {
						System.out.println(e);
						}	
		    	}
		   
		    
		    }
		}
		/*try {
			params2.put("to", "01067779217");
			params2.put("from", "053-817-7312");
			params2.put("text", text4);
			params2.put("type", "lms");
			JSONObject obj = (JSONObject) coolsms.send(params2);
			System.out.println(obj.toString());
		}catch(CoolsmsException e) {
			System.out.println(e);
		}	*/
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
		//년월일 전역변수
		String filedate ;
		
		for(File file:fileList) {
			if(file.isFile()) {
				String fileNm = file.getName();
				String fileDate = fileNm.substring(14, 22);
				filedate = fileDate;
				int viewList = mainService.selectDataExistCnt(fileDate);
				
				if(viewList > 0) {
					continue;
				}
				
				String tempfilePath = filePath + "main/" + fileNm;
				
				List<String> lines = Files.readAllLines(Paths.get(tempfilePath), StandardCharsets.UTF_8);
				int count = 0;
				for(String line:lines) {
				
					Map<?,?> tempcongest =  (Map<?, ?>) congestion.get(count);
					String[] temp = line.split("\\|");
					TravelMain travelMain = new TravelMain();
					travelMain.setEtlDt(filedate+temp[0]);
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
	
	@RequestMapping(value="beachinfo.do")
	@ResponseBody
	public JSONObject beachInfo() throws Exception{
	
		List<?> api = (List<?>) mainService.selectBeachInfo();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{ 
			sObject.put("Jnumber"+ (i+1) , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="beachday.do")
	@ResponseBody
	public JSONObject beachDay() throws Exception{
	
		List<?> api = (List<?>) mainService.selectBeachDay();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("Jnumber"+ (i+1) , api.get(i));
		}
			
		return sObject;
	}

	
	@RequestMapping(value="getBeachCongestionApi.do")
	@ResponseBody
	public JSONObject responseApi(String date) throws Exception{
	 //민원요청으로 인한 급한 매개변수 추가
		if(date == null) {
		date="2021%";
		List<?> api = (List<?>) mainService.selectBeachPerCntapi(date);
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("Beach"+ i , api.get(i));
		}
			
		return sObject;
		}else {
			List<?> api = (List<?>) mainService.selectBeachPerCntapi(date);
			/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
			JSONObject sObject = new JSONObject();
			
			for(int i=0; i < api.size(); i++)
			{
				sObject.put("Beach"+ i , api.get(i));
			}
				
			return sObject;
			
			
		}
		
	}
	
	@RequestMapping(value="getroutedailyApi.do")
	@ResponseBody
	public JSONObject routedailyApi() throws Exception{
	
		List<?> api = (List<?>) mainService.selectTravelrouteDailyApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("Beach"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getDestinationApi.do")
	@ResponseBody
	public JSONObject destinationApi(TravelDestination traveldestination ,HttpServletRequest request) throws Exception{
	
		String season = request.getParameter("season");
		String region = request.getParameter("region");
		String category = request.getParameter("category");
		
		traveldestination.setDestSeason(season);
		traveldestination.setDestRegion(region);
		traveldestination.setDestCategory(category);
		List<?> api = (List<?>) mainService.selectTravelDestinationApi(traveldestination);	
		
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("Beach"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="getrouteApi.do")
	@ResponseBody
	public JSONObject routeApi() throws Exception{
	
		List<?> api = (List<?>) mainService.selectTravelrouteApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
		JSONObject sObject = new JSONObject();
		
		for(int i=0; i < api.size(); i++)
		{
			sObject.put("Beach"+ i , api.get(i));
		}
			
		return sObject;
	}
	
	@RequestMapping(value="beachExcelDown.do")
	public void beachExcelDown(
			 TravelReservation travelReservation
			,HttpServletRequest request
			,HttpServletResponse response
			,Model model) throws Exception {
		
		List<TravelMain> excelList = (List<TravelMain>) mainService.congestionExcel();
		List<TravelMain> excelList2 = (List<TravelMain>) mainService.congestionOverExcel();
		
		String date = new String();
		date = excelList.get(0).getEtlDt();
		
		
		
		// 워크북 생성
	    Workbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("해수욕장 인원 조사");
	    Sheet sheet2 = wb.createSheet("해수욕장 혼잡도 신호등");
	    Row row = null;
	    Cell cell = null;
	    Row row2 = null;
	    Cell cell2 = null;
	    int rowNo = 0;
	    int rowNo2 = 0;

	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();
	    // 가는 경계선
	    headStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
	    headStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    headStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    headStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);

	    // 헤더 배경색
	    headStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
	    headStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);

	    // 헤더 가운데 정렬
	    headStyle.setAlignment(CellStyle.ALIGN_CENTER);

	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
	    bodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    bodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    bodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);

	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("날짜 및 시각");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("해수욕장 번호");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("해수욕장 이름");
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("인원 수");
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("혼잡도");	    

	    // 데이터 부분 생성
	    for(TravelMain vo : excelList) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getEtlDt());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getSeqId());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getPoiNm());
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getUniqPop());
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getCongestion());
	        
	    }
	    
	    
	    /* 9:30 ~ 16:30분 사이의 데이터 중 신호등이 노랑(혼잡도가 2)이상인 데이터 추출 */
	    //해더생성2
	    row2 = sheet2.createRow(rowNo2++);
	    cell2 = row2.createCell(0);
	    cell2.setCellStyle(headStyle);
	    cell2.setCellValue("날짜 및 시각");
	    cell2 = row2.createCell(1);
	    cell2.setCellStyle(headStyle);
	    cell2.setCellValue("해수욕장 번호");
	    cell2 = row2.createCell(2);
	    cell2.setCellStyle(headStyle);
	    cell2.setCellValue("해수욕장 이름");
	    cell2 = row2.createCell(3);
	    cell2.setCellStyle(headStyle);
	    cell2.setCellValue("인원 수");
	    cell2 = row2.createCell(4);
	    cell2.setCellStyle(headStyle);
	    cell2.setCellValue("신호등");
	    
	    // 데이터 부분 생성2
	    for(TravelMain vo : excelList2) {
	    	row2 = sheet2.createRow(rowNo2++);
	        cell2 = row2.createCell(0);
	        cell2.setCellStyle(bodyStyle);
	        cell2.setCellValue(vo.getEtlDt());
	        cell2 = row2.createCell(1);
	        cell2.setCellStyle(bodyStyle);
	        cell2.setCellValue(vo.getSeqId());
	        cell2 = row2.createCell(2);
	        cell2.setCellStyle(bodyStyle);
	        cell2.setCellValue(vo.getPoiNm());
	        cell2 = row2.createCell(3);
	        cell2.setCellStyle(bodyStyle);
	        cell2.setCellValue(vo.getUniqPop());
	        cell2 = row2.createCell(4);
	        cell2.setCellStyle(bodyStyle);
	        String color = null;
	        switch(vo.getCongestion()) {
		        case "1" : color = "초록색"; break;
		        case "2" : color = "노란색"; break;
		        case "3" : color = "빨간색"; break;
		        default : color = "오류"; break;
	        }
	        cell2.setCellValue(color);
	        
	    }
	    
	    // 셀 크기 자동조절
	    for(int i=0; i<=8; i++) {
	    	sheet.autoSizeColumn(i);
	    	sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+512 );
	    	sheet2.autoSizeColumn(i);
	    	sheet2.setColumnWidth(i, (sheet.getColumnWidth(i))+512 );
	    }	    
	    
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=beachcongestion.xlsx");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
}
