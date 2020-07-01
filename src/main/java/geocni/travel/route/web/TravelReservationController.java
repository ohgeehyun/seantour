package geocni.travel.route.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelReservation;
import geocni.travel.route.domain.TravelRoute;
import geocni.travel.route.service.TravelDestinationService;
import geocni.travel.route.service.TravelReservationService;
import geocni.travel.route.service.TravelRouteService;
import jnit.cms.AdminUtil;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;
import jnit.util.NumberUtil;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
//@SessionAttributes(types=TravelRoute.class)
@RequestMapping(value="/travel/reservation")
public class TravelReservationController {
	@Resource(name = "travelReservationService")
	private TravelReservationService reseService;

	@SuppressWarnings("unused")
	@Autowired
    private DefaultBeanValidator beanValidator;

	private Log log = LogFactory.getLog(getClass());
	
	private String skinPath = "travel/reservation/";
	
	//날짜 체크 - 7월 1일 09시 이후부터 예약 가능
	public boolean compareDate() {
		boolean rtnVal = false;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH");
		Date resvStDate = new Date();
		try {
			resvStDate = dateFormat.parse("2020-07-01 09");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Date nowDate = new Date();
		int compare = nowDate.compareTo(resvStDate);
		if(compare < 0) {
			rtnVal = false;	//오늘 날짜가 해수욕장 예약 시작일(resvStDate) 이전인 경우 false
		} else {
			rtnVal = true;	//오늘 날짜가 해수욕장 예약 시작일(resvStDate) 이후인 경우 true
		}
		//rtnVal = true;	//해수욕장 예약 테스트 시 주석해제 -> 무조건 예약 가능
		return rtnVal;
	}
	
	@RequestMapping(value="area.do")
	public String reservationArea(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,SessionStatus status
			,Model model) throws Exception {
		List<?> regionList = reseService.selectTravelReservationRegionList(travelReservation);
		model.addAttribute("regionList", regionList);
		List<?> beachList = reseService.selectTravelReservationBeachList(travelReservation);
		model.addAttribute("beachList", beachList);
		model.addAttribute("travelReservation", travelReservation);
		
		if(travelReservation.getMonth() != null && travelReservation.getDay() != null && travelReservation.getReseTime() != null) {
			travelReservation.setReseDate("2020" + travelReservation.getMonth() + travelReservation.getDay());
			travelReservation.setReseBeachId("R" + travelReservation.getReseBeachRegionCd() + travelReservation.getReseBeachNameCd());
			String openYn = reseService.selectTravelOpenYn(travelReservation);
			travelReservation.setOpenYn(openYn);
			if("Y".equals(openYn)) {
				String reservationYn = reseService.selectTravelReservationYn(travelReservation);
				travelReservation.setReservationYn(reservationYn);
				String reseAvaiCnt = reseService.selectTravelReservationPossCnt(travelReservation);
				travelReservation.setResePossCnt(reseAvaiCnt);
			}
		}
		
		//날짜 체크 - 7월 1일 09시 이후부터 예약 가능
		if(!compareDate()) {
			model.addAttribute("alert", "2020년 7월 1일 9시 부터 예약 가능합니다.");
			return "jnit/util/alertBack";
		}
		
		return skinPath + "area";
	}
	
	@RequestMapping(value="insert.do")
	public String reservationInsert(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,SessionStatus status
			,Model model) throws Exception {
		try {
			if(travelReservation.getReseBeachRegionCd() != null && travelReservation.getReseBeachNameCd() != null
					&& travelReservation.getMonth() != null && travelReservation.getDay() != null && travelReservation.getReseTime() != null) {
				travelReservation.setReseDate("2020" + travelReservation.getMonth() + travelReservation.getDay());
				travelReservation.setReseBeachId("R" + travelReservation.getReseBeachRegionCd() + travelReservation.getReseBeachNameCd());
				travelReservation.setReseTel(travelReservation.getReseTel_01() + travelReservation.getReseTel_02() + travelReservation.getReseTel_03());
				
				//날짜 체크 - 7월 1일 09시 이후부터 예약 가능
				if(!compareDate()) {
					model.addAttribute("alert", "2020년 7월 1일 9시 부터 예약 가능합니다.");
					return "jnit/util/alertBack";
				}
				
				//최대수용 인원을 초과 체크
				String reservationYn = reseService.selectTravelReservationYn(travelReservation);
				if("N".equals(reservationYn)) {
					model.addAttribute("alert", "예약이 불가능 합니다.\\n최대수용 인원을 초과 하였습니다.");
					return "jnit/util/alertBack";
				}
				//중복 신청 체크
				String duplicationYn = reseService.selectTravelReservationDuplYn(travelReservation);
				if("N".equals(duplicationYn)) {
					model.addAttribute("alert", "예약이 불가능 합니다.\\n이미 신청한 내역이 있습니다.");
					return "jnit/util/alertBack";
				}
				//인원 값 숫자여부와 5보다 큰 경우 오류
				if(Integer.parseInt(travelReservation.getResePersonnel()) > 5 || !NumberUtil.isNumeric(travelReservation.getResePersonnel())) {
					model.addAttribute("alert", "오류가 발생 하였습니다.");
					return "jnit/util/alertBack";
				}
				
				reseService.insertTravelReservation(travelReservation);
				
				//예약 후 SMS 보내기
				String api_key = "NCSDUEW5R2MDNLJJ";
				String api_secret = "2YG5WXA0SZPLJBFHW41DCWYDD2AWSWUD";
				Message coolsms = new Message(api_key, api_secret);
				
				HashMap<String, String> params = new HashMap<String, String>();
				String text = "[해수욕장 예약시스템]\n";
				text += travelReservation.getReseBeachName() + " 예약이 완료 되었습니다.\n";
				text += "날짜 : 2020년 " + travelReservation.getMonth() + "월 " + travelReservation.getDay() + "일\n시간 : ";
				if("01".equals(travelReservation.getReseTime())) text += "9:00 ~ 12:00";
				else if("02".equals(travelReservation.getReseTime())) text += "12:00 ~ 15:00";
				else if("03".equals(travelReservation.getReseTime())) text += "15:00 ~ 18:00";
				text += "시\n";
				text += "인원 : " + travelReservation.getResePersonnel() + "명\n";
				text += "예약조회 : https://seantour.com/seantour_map/travel/";
				params.put("to", travelReservation.getReseTel());
				params.put("from", "0442005254");
			    params.put("text", text);
			    params.put("type", "lms"); // 문자 타입

			    try {
			      JSONObject obj = (JSONObject) coolsms.send(params);
			      System.out.println(obj.toString());
			    } catch (CoolsmsException e) {
			      System.out.println(e.getMessage());
			      System.out.println(e.getCode());
			    }
			}
		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}
		
		return "redirect:/" + skinPath + "reserv_view.do?reseName=" + URLEncoder.encode(travelReservation.getReseName(), "UTF-8") + "&reseTel=" + travelReservation.getReseTel();
	}
	
	@RequestMapping(value="delete.do")
	public String reservationDelete(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,HttpServletRequest request
			,SessionStatus status
			,Model model) throws Exception {
		
		reseService.deleteTravelReservation(travelReservation);

		return "redirect:/" + skinPath + "reserv_view.do?reseName=" + URLEncoder.encode(travelReservation.getReseName(), "UTF-8") + "&reseTel=" + travelReservation.getReseTel();
	}
	
	@RequestMapping(value="reserv_view.do")
	public String reservationView(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,SessionStatus status
			,HttpServletRequest request
			,Model model) throws Exception {
		String reseName = request.getParameter("reseName");
		String reseTel = request.getParameter("reseTel");
		
		travelReservation.setReseName(reseName);
		travelReservation.setReseTel(reseTel);
		List<?> viewList = reseService.selectTravelReservationViewList(travelReservation);
		
		if(viewList.size() == 0) {
			model.addAttribute("alert", "예약내역이 없습니다.");
			model.addAttribute("path", "/");

			return "/jnit/util/alertMove";
		}
		
		model.addAttribute("viewList", viewList);
		
		return skinPath + "reserv_view";
	}
	
	@RequestMapping(value="reserv_admin_login.do")
	public String reservationAdminLogin(
			 TravelRoute travelRoute
			,SessionStatus status
			,Model model) throws Exception {
		return skinPath + "reserv_admin_login";
	}
	
	@RequestMapping(value="reserv_login.do")
	public String reservationLogin(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,HttpServletRequest request
			,SessionStatus status
			,Model model) throws Exception {
		String reseAdminId = request.getParameter("reseAdminId");
		String reseAdminPw = request.getParameter("reseAdminPw");
		String enReseAdminPw = EgovFileScrty.encryptPassword(reseAdminPw);
		travelReservation.setReseAdminId(reseAdminId);
		travelReservation.setReseAdminPw(enReseAdminPw);
		
		String adminBeachId = reseService.selectTravelReservationAdmin(travelReservation);
		
		if("".equals(adminBeachId) || adminBeachId == null) {
			model.addAttribute("alert", "ID / 패스워드를 확인해 주세요.");
			return "jnit/util/alertBack";
		} else {
			request.getSession().setAttribute("adminBeachId", adminBeachId);
			return "redirect:/" + skinPath + "reserv_admin.do";
		}
	}
	
	@RequestMapping(value="reserv_admin.do")
	public String reservationAdmin(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,HttpServletRequest request
			,SessionStatus status
			,Model model) throws Exception {
		String adminBeachId = (String)request.getSession().getAttribute("adminBeachId");
		if("".equals(adminBeachId) || adminBeachId == null) {
			model.addAttribute("alert", "로그인 후 이용해 주세요.");
			model.addAttribute("path", "/travel/reservation/reserv_admin_login.do");
			return "/jnit/util/alertMove";
		}
		
		String searchCondition = request.getParameter("searchCondition");
		String searchKeyword = request.getParameter("searchKeyword");
		if(!"".equals(searchKeyword) && searchKeyword != null) {
			//전화번호 검색인 경우 하이픈(-) 제거
			if("1".equals(searchCondition)) searchKeyword = searchKeyword.replaceAll("-", "");
			travelReservation.setSearchCondition(searchCondition);
			travelReservation.setSearchKeyword(searchKeyword);
		}
		
		travelReservation.setPageUnit(50);
		travelReservation.setPageSize(10);
		
		travelReservation.setReseBeachId(adminBeachId);
		model.addAllAttributes(reseService.selectTravelReservationList(travelReservation));
		model.addAttribute("travelReservation", travelReservation);
		return skinPath + "reserv_admin";
	}
	
	@RequestMapping(value="reserv_logout.do")
	public String reservationLogout(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,HttpServletRequest request
			,SessionStatus status
			,Model model) throws Exception {
		request.getSession().setAttribute("adminBeachId", null);

		model.addAttribute("alert", "로그아웃 되었습니다.");
		model.addAttribute("path", "/travel/reservation/reserv_admin_login.do");

		return "/jnit/util/alertMove";
	}
	
	@RequestMapping(value="example.do")
	public String reservationexample(
			Model model) throws Exception {
		
	
		
		return skinPath + "example";
	}
	
	@RequestMapping(value="intro.do")
	public String reservationintro(
			Model model) throws Exception {
		
	
		
		return skinPath + "intro";
	}
}
