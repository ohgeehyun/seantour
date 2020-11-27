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
				System.out.println(beachPerPopulationList.get(index).getCongestion());
			}
			index++;
		}
		return beachPerPopulationList;
	}

	@RequestMapping(value = "checkBeachCongestion.do")
	@ResponseBody
	public void checkBeachCongestion() throws Exception {

		String api_key = "NCSDUEW5R2MDNLJJ";
		String api_secret = "2YG5WXA0SZPLJBFHW41DCWYDD2AWSWUD";
		Message coolsms = new Message(api_key, api_secret);
		HashMap<String, String> params = new HashMap<String, String>(); // 도청
		HashMap<String, String> params2 = new HashMap<String, String>();// 시청
		String text = "[해수욕장 혼잡도 신호등]\n";
		String text2 = "[해수욕장 혼잡도 신호등]\n";
		String text3 = "[해수욕장 혼잡도 신호등]\n";
		String text4 = "[해수욕장 혼잡도 신호등]\n";
		String text5 = "[해수욕장 혼잡도 신호등]\n";
		String text6 = "[해수욕장 혼잡도 신호등]\n";
		String text7 = "[해수욕장 혼잡도 신호등]\n";
		List<TravelMain> beachPerPopulationList = null;
		try {
			beachPerPopulationList = (List<TravelMain>) mainService.selectBeachPerCnt();
		} catch (Exception e) {
			beachPerPopulationList = null;
		}
		int index = 0; // beachPerPopulationList 리스트의 번호
		int count = 0; // 혼잡 이상의 숫자 카운트
		int taean = 0; // 태안군 분류
		int seachun = 0; //서천 분류
		int boryung = 0; //서천 분류
		int jeju = 0; //제주시
		int Seogwipo = 0; //서귀포시
		int donggu =0; //울산 동구
		int ulju =0; //울산 을주 
		int heaundaegu =0; //부산 해운대구
		int busanseogu =0;//부산 서구
		int sahagu =0; //부산 사하구
		int suyunggu =0;// 부산 수영구
		int gijanggu =0;//부산 기장구
		int yungduk =0;
		int gyunju =0;
		int gangleng =0;
		int yangyang =0;
		int sokcho = 0;
		int samchuck =0;
		int donghea =0;
		int gosung =0;
		String[] government = new String[10]; // 도청 전화번호
		government[0] = "01097951156,01089010442,01095114900,01086102805,01063217699,01028222484";// 강원도청
		government[1] = "01038872641,01040395434,01091707832,01086102805,01063217699,01028222484";// 경남도청
		government[2] = "01048995675,01092772373,01029076383,01086102805,01063217699,01028222484";// 경북도청
		government[3] = "01020559177,01077463664,01045667560,01086102805,01063217699,01028222484";// 부산시청
		government[4] = "01029670026,010548641347,01020762755,01086102805,01063217699,01028222484";// 울산시청
		government[5] = "01020165122,01073448896,01090721027,01086102805,01063217699,01028222484";// 인천시청
		government[6] = "01056159451,01036075669,01094709406,01086102805,01063217699,01028222484";// 전남도청
		government[7] = "01027765157,01073707086,01040031075,01086102805,01063217699,01028222484";// 전북도청
		government[8] = "01036908641,01046926996,01051892677,01086102805,01063217699,01028222484";// 제주시청
		government[9] = "01095590831,01079339665,01040658913,01086102805,01063217699,01028222484";// 충남도청

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 36
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 4
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 50
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 41
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 33
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 25
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 23
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 15) { // 충남도청
					if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다. \n";
						count++;
					}else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
						count++;
					}
					
					if(Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 15
							||Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 25
							||Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 33
							||Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 41
							||Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 50){ //태안군
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다. \n";
							taean++;
						}else {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							taean++;
						}			
					}else if(Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 23) {//서천군
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다. \n";
							seachun++;
						}else {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							seachun++;
						}
					}else {
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text4 += beachPerPopulationList.get(index).getPoiNm() +" 노란색 입니다. \n";		//보령
							boryung ++;
						}else {
							text4 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							boryung ++;
						}
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to", government[9]);
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		
		try {
			if (taean > 0) {
				text2 += "현재 신호등 상황 입니다.";
				params2.put("to", "01034859434,01020945896,01097007131");
				params2.put("from", "0442005254");
				params2.put("text", text2);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text2 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (seachun > 0) {
				text3 += "현재 신호등 상황 입니다.";
				params2.put("to", "01051088958,01054940976,01024066975");
				params2.put("from", "0442005254");
				params2.put("text", text3);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text3 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (boryung > 0) {
				text4 += "현재 신호등 상황 입니다.";
				params2.put("to", "01088163415,01093043379,01029305452");
				params2.put("from", "0442005254");
				params2.put("text", text4);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text4 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 17
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 20
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 24
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 27
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 35
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 37
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 30) { // 제주시청
					if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다. \n";	
						count++;
					}else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다. \n";	
						count++;
					}
					if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 17
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 20
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 24
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 27
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 37
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 30) { // 제주시
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다. \n";	
							jeju ++;
						}else {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다. \n";
							jeju ++;
						}
					}else {
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다. \n"; //서귀포시
							Seogwipo ++;
						}else {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다. \n";           
							Seogwipo ++;
						}
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to", government[8]);
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (jeju > 0) {
				text2 += "현재 신호등 상황 입니다.";
				params2.put("to", "01099269858,01052222749,01076237179");
				params2.put("from", "0442005254");
				params2.put("text", text2);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text2 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (Seogwipo > 0) {
				text3 += "현재 신호등 상황 입니다.";
				params2.put("to", "01020222989,01086223495,01063554199");
				params2.put("from", "0442005254");
				params2.put("text", text3);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text3 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 14) { // 전남도청 한 곳 이 끝
					if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다. \n";
						count++;
					}else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다. \n";
						count++;
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to", government[6]+",01041931911,01088205763,01050311738");
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 40
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 45) { // 인천시청
					if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다. \n";
						count++;
					}else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다. \n";
						count++;
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to", government[5]+",01028316024,01090505613,01041182737");
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 16
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 18) { // 울산시청
					if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
						count++;
					}else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
						count++;
					}
					if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 16) { // 울산 동구
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							donggu++;
						}else {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							donggu++;
						}
					}else {
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n"; // 울산 을주군
							ulju++;
						}else {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n"; 
							ulju++;
						}
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to", government[4]);
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		
		try {
			if (donggu > 0) {
				text2 += "현재 신호등 상황 입니다.";
				params2.put("to", "01035821995,01092348786,01040543451");
				params2.put("from", "0442005254");
				params2.put("text", text2);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text2 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		
		try {
			if (ulju > 0) {
				text3 += "현재 신호등 상황 입니다.";
				params2.put("to", "01053039073,01030585828,01065870009");
				params2.put("from", "0442005254");
				params2.put("text", text3);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text3 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 1
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 3
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 5
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 7
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 32
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 2
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 34) { // 부산시청
					if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
						count++;
					}else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
						count++;
					}
					if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 1			
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 7) { // 해운대구
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							heaundaegu++;
						}else {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							heaundaegu++;
						}
					}else if(Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 3) { //부산 서구
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							busanseogu++;
						}else {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							busanseogu++;
						}
					}else if(Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 5) { //부산 사하구
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text4 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							sahagu++;
						}else {
							text4 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							sahagu++;
						}
					}else if(Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 32
							||Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 34){ //부산 기장구
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text5 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							gijanggu++;
						}else {
							text5 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							gijanggu++;
						}
					}else {
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text6 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";               //부산 수영구
							suyunggu++;
						}else {
							text6 += beachPerPopulationList.get(index).getPoiNm() +  " 빨강색 입니다.\n";               
							suyunggu++;
						}
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to", government[3]);
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (heaundaegu > 0) {
				text2 += "현재 신호등 상황 입니다.";
				params2.put("to", "01063621302,010548641347,01020762755");
				params2.put("from", "0442005254");
				params2.put("text", text2);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text2 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (busanseogu > 0) {
				text3 += "현재 신호등 상황 입니다.";
				params2.put("to", "01028309342,01085599824,01051691470");
				params2.put("from", "0442005254");
				params2.put("text", text3);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text3 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (sahagu > 0) {
				text4 += "현재 신호등 상황 입니다.";
				params2.put("to", "01028288143,01040895417");
				params2.put("from", "0442005254");
				params2.put("text", text4);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text4 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (gijanggu > 0) {
				text5 += "현재 신호등 상황 입니다.";
				params2.put("to", "01077471822,01039071332,01063857924");
				params2.put("from", "0442005254");
				params2.put("text", text5);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text5 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (suyunggu > 0) {
				text6 += "현재 신호등 상황 입니다.";
				params2.put("to", "01065873304,01092367390,01055581698");
				params2.put("from", "0442005254");
				params2.put("text", text6);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text6 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 21
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 47) { // 경북도청
					if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
						count++;
					}else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
						count++;
					}
					if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 21) { // 경북도청 영덕군
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							yungduk++;
						}else {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							yungduk++;
						}
					}else {
						if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text3 += beachPerPopulationList.get(index).getPoiNm() +  " 노란색 입니다.\n";   // 경북도청 경주시
							gyunju++;
						}else {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";      
							gyunju++;
						}
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to",government[2]);
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		
		try {
			if (yungduk > 0) {
				text2 += "현재 신호등 상황 입니다.";
				params2.put("to", "01035484030,01067345003,01038603317");
				params2.put("from", "0442005254");
				params2.put("text", text2);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text2 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		
		try {
			if (gyunju > 0) {
				text3 += "현재 신호등 상황 입니다.";
				params2.put("to", "01035371979,01035016701,01026302943");
				params2.put("from", "0442005254");
				params2.put("text", text3);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text3 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 39) { // 경남도청
					if(Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
						count++;
					}else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
						count++;	
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to", government[1]+",01038644365,01073581225,01094507295");
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}

		for (TravelMain i : beachPerPopulationList) {
			if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) > 1) { // 혼잡도가 1이상 인 경우
				if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 38
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 6
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 8
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 9
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 10
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 11
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 12
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 13
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 19
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 22
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 26
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 28
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 29
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 31
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 42
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 43
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 44
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 46
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 48
						|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 49) { // 강원도청
					if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
						text += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
						count++;
					} else {
						text += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
						count++;
					}
					if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 38
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 6
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 38
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 42) { // 강원도청 강릉시
						if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							gangleng++;
						} else {
							text2 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							gangleng++;
						}
					} else if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 8
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 19
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 48) {// 강원도청 양양군
						if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							yangyang++;
						} else {
							text3 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							yangyang++;
						}
					} else if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 9
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 29
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 44) { // 강원도청 속초시
						if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text4 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							sokcho++;
						} else {
							text4 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							sokcho++;
						}
					} else if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 10
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 12
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 43) { // 강원도청 삼척시
						if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text5 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							samchuck++;
						} else {
							text5 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							samchuck++;
						}
					} else if (Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 11
							|| Integer.valueOf(beachPerPopulationList.get(index).getSeqId()) == 13) { // 강원도청 동해시
						if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text6 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";
							donghea++;
						} else {
							text6 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							donghea++;
						}
					} else {
						if (Integer.valueOf(beachPerPopulationList.get(index).getCongestion()) == 2) {
							text7 += beachPerPopulationList.get(index).getPoiNm() + " 노란색 입니다.\n";// 강원도청 고성군
							gosung++;
						} else {
							text7 += beachPerPopulationList.get(index).getPoiNm() + " 빨강색 입니다.\n";
							gosung++;
						}
					}
				}
			}
			index++;
			if (index == 50) {
				index = 0;
				break;
			}
		}
		try {
			if (count > 0) {
				text += "현재 신호등 상황 입니다.";
				params.put("to", government[0] );
				params.put("from", "0442005254");
				params.put("text", text);
				params.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params);
				System.out.println(obj.toString());
				count = 0;
				text = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (gangleng > 0) {
				text2 += "현재 신호등 상황 입니다.";
				params2.put("to", "01035263537,01033775137,01092050542");
				params2.put("from", "0442005254");
				params2.put("text", text2);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text2 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (yangyang > 0) {
				text3 += "현재 신호등 상황 입니다.";
				params2.put("to", "01067498215,01020283161,01029650240");
				params2.put("from", "0442005254");
				params2.put("text", text3);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text3 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (sokcho > 0) {
				text4 += "현재 신호등 상황 입니다.";
				params2.put("to", "01044899491,01026748312,01096902849");
				params2.put("from", "0442005254");
				params2.put("text", text4);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text4 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (samchuck > 0) {
				text5 += "현재 신호등 상황 입니다.";
				params2.put("to", "01033553109,01099585844,01050996593");
				params2.put("from", "0442005254");
				params2.put("text", text5);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text5 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (donghea > 0) {
				text6 += "현재 신호등 상황 입니다.";
				params2.put("to", "01025039263,01041509813,01040751870");
				params2.put("from", "0442005254");
				params2.put("text", text6);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text6 = "[해수욕장 혼잡도 신호등]\n";
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		try {
			if (gosung > 0) {
				text7 += "현재 신호등 상황 입니다.";
				params2.put("to", "01053793151,01066834660,01051792306");
				params2.put("from", "0442005254");
				params2.put("text", text7);
				params2.put("type", "lms");
				JSONObject obj = (JSONObject) coolsms.send(params2);
				System.out.println(obj.toString());
				text7 = "[해수욕장 혼잡도 신호등]\n";
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
				int count = 0;
				for(String line:lines) {
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
	public JSONObject destinationApi(TravelDestination traveldestination) throws Exception{
	
		List<?> api = (List<?>) mainService.selectTravelDestinationApi();
		/*List<?> data = (List<?>) mainService.selectBeachPerCnt();*/
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
	
	
	
	
	
	
}
