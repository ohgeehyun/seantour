package geocni.travel.route.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
		rtnVal = false;	//해수욕장 예약 테스트 시 사용 : true=예약가능 / false=예약불가능
		return rtnVal;
	}
	
	/*@RequestMapping(value="area.do")
	public String reservationArea(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,SessionStatus status
			,Model model) throws Exception {
		//해수욕장 지역목록
		List<?> regionList = reseService.selectTravelReservationRegionList(travelReservation);
		model.addAttribute("regionList", regionList);
		//해수욕장 목록
		List<?> beachList = reseService.selectTravelReservationBeachList(travelReservation);
		model.addAttribute("beachList", beachList);
		//예약자주소 시/도
		List<?> areaList = reseService.selectTravelReservationAreaList(travelReservation);
		model.addAttribute("areaList", areaList);
		//예약자주소 구/군
		List<?> areaList2 = reseService.selectTravelReservationAreaList2(travelReservation);
		model.addAttribute("areaList2", areaList2);
		model.addAttribute("travelReservation", travelReservation);
		
		if(travelReservation.getMonth() != null && travelReservation.getDay() != null && travelReservation.getReseTime() != null) {
			travelReservation.setReseDate("2020" + travelReservation.getMonth() + travelReservation.getDay());
			travelReservation.setReseBeachId("R" + travelReservation.getReseBeachRegionCd() + travelReservation.getReseBeachNameCd());
			//해수욕장 개장여부 조회
			String openYn = reseService.selectTravelOpenYn(travelReservation);
			travelReservation.setOpenYn(openYn);
			if("Y".equals(openYn)) {	//해수욕장 개장인 경우
				//최대수용 인원 초과 체크
				String reservationYn = reseService.selectTravelReservationYn(travelReservation);
				travelReservation.setReservationYn(reservationYn);
				//해수욕장 예약가능인원 조회
				String reseAvaiCnt = reseService.selectTravelReservationPossCnt(travelReservation);
				travelReservation.setResePossCnt(reseAvaiCnt);
			}
		}
		
		//날짜 체크 - 7월 1일 09시 이후부터 예약 가능
		if(!compareDate()) {
			model.addAttribute("alert", "해수욕장 조기 폐장으로 인하여\\n예약시스템이 종료 되었습니다.");
			model.addAttribute("path", "/");
			return "/jnit/util/alertMove";
		}
		
		return skinPath + "area";
	}*/
	
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
					model.addAttribute("path", "/");
					return "/jnit/util/alertMove";
				}
				
				//최대수용 인원 초과 체크
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
				//인원 값 숫자여부와 1보다 작거나 5보다 큰 경우 오류
				if(Integer.parseInt(travelReservation.getResePersonnel()) < 1 || Integer.parseInt(travelReservation.getResePersonnel()) > 5 || !NumberUtil.isNumeric(travelReservation.getResePersonnel())) {
					model.addAttribute("alert", "오류가 발생 하였습니다.");
					return "jnit/util/alertBack";
				}
				
				//세종인 경우 0800으로 값 넣기
				if("08".equals(travelReservation.getReseAreaCd())) travelReservation.setReseAreaCd_2("0800");
				reseService.insertTravelReservation(travelReservation);
				
				//예약 후 SMS 보내기
				String api_key = "NCSDUEW5R2MDNLJJ";
				String api_secret = "2YG5WXA0SZPLJBFHW41DCWYDD2AWSWUD";
				Message coolsms = new Message(api_key, api_secret);
				
				HashMap<String, String> params = new HashMap<String, String>();
				String text = "[해수욕장 예약시스템]\n";
				text += travelReservation.getReseBeachName() + " 예약이 완료 되었습니다.\n";
				text += "날짜 : 2020년 " + travelReservation.getMonth() + "월 " + travelReservation.getDay() + "일\n시간 : ";
				if("R0012".equals(travelReservation.getReseBeachId()) || "R0013".equals(travelReservation.getReseBeachId()) || "R0014".equals(travelReservation.getReseBeachId())) {
					if("01".equals(travelReservation.getReseTime())) text += "10:00 ~ 13:00";
					else if("02".equals(travelReservation.getReseTime())) text += "13:00 ~ 16:00";
					else if("03".equals(travelReservation.getReseTime())) text += "16:00 ~ 19:00";
				} else {
					if("01".equals(travelReservation.getReseTime())) text += "9:00 ~ 12:00";
					else if("02".equals(travelReservation.getReseTime())) text += "12:00 ~ 15:00";
					else if("03".equals(travelReservation.getReseTime())) text += "15:00 ~ 18:00";
				}
				text += "시\n";
				text += "인원 : " + travelReservation.getResePersonnel() + "명\n";
				text += "예약조회 : https://tournmaster.com/seantour_map/travel/";
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
		
		return "redirect:/" + skinPath + "reserv_view.do?reseName=" + URLEncoder.encode(travelReservation.getReseName().trim(), "UTF-8") + "&reseTel=" + travelReservation.getReseTel().trim();
	}
	
	@RequestMapping(value="delete.do")
	public String reservationDelete(
			 TravelRoute travelRoute
			,TravelReservation travelReservation
			,HttpServletRequest request
			,SessionStatus status
			,Model model) throws Exception {
		
		reseService.deleteTravelReservation(travelReservation);
		
		String adminBeachId = (String)request.getSession().getAttribute("adminBeachId");
		if(!"".equals(adminBeachId) && adminBeachId != null && "Y".equals(travelReservation.getUseYn())) {
			return "redirect:/" + skinPath + "reserv_admin.do";
		}

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
		//예약자 이름 Encoding된 경우 Decoding
		while(reseName.indexOf("%") > -1) reseName = URLDecoder.decode(reseName, "UTF-8");
		String reseTel = request.getParameter("reseTel");
		
		travelReservation.setReseName(reseName.trim());
		travelReservation.setReseTel(reseTel.trim());
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
		
		//로그인 ID, PW로 해수욕장 ID 조회
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
		//로그인 여부 확인
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
		
		//페이징 세팅 - 한페이지에 보여지는 건수(50), 페이지수(10)
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
		//해수욕장 ID값 세션에서 제거
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
	
	@RequestMapping(value="reserv_admin_excelDown.do")
	public void reservationExcelDown(
			 TravelReservation travelReservation
			,HttpServletRequest request
			,HttpServletResponse response
			,Model model) throws Exception {
		travelReservation.setIsExcelDown("Y");
		Map<String, Object> resultMap = reseService.selectTravelReservationList(travelReservation);
		List<TravelReservation> excelList = (List<TravelReservation>) resultMap.get("reseList");
		
		// 워크북 생성
	    Workbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("Sheet1");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;

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
	    cell.setCellValue("예약번호");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("지역 / 해수욕장");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("날짜");
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("시간");
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("인원");
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("이름");
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("전화번호");
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("예약자주소");
	    cell = row.createCell(8);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("등록일자");

	    // 데이터 부분 생성
	    for(TravelReservation vo : excelList) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getReseNo());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getReseBeachName());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getReseDate().substring(0, 4) + "년 " + vo.getReseDate().substring(5, 7) + "월 " + vo.getReseDate().substring(8, 10) + "일");
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        String time = "";
	        if("R0012".equals(vo.getReseNo().substring(0, 5)) || "R0013".equals(vo.getReseNo().substring(0, 5)) || "R0014".equals(vo.getReseNo().substring(0, 5))) {
	        	if("01".equals(vo.getReseTime())) time = "10:00 ~ 13:00";
	        	else if("02".equals(vo.getReseTime())) time = "13:00 ~ 16:00";
	        	else if("03".equals(vo.getReseTime())) time = "16:00 ~ 19:00";
	        } else {
	        	if("01".equals(vo.getReseTime())) time = "9:00 ~ 12:00";
	        	else if("02".equals(vo.getReseTime())) time = "12:00 ~ 15:00";
	        	else if("03".equals(vo.getReseTime())) time = "15:00 ~ 18:00";
	        }
	        cell.setCellValue(time);
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getResePersonnel()));
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getReseName());
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        String telNo = "";
	        if(vo.getReseTel().length() == 10) {
	        	telNo = vo.getReseTel().substring(0, 3) + "-" + vo.getReseTel().substring(3, 6) + "-" + vo.getReseTel().substring(6, 10);
	        } else if(vo.getReseTel().length() == 11) {
	        	telNo = vo.getReseTel().substring(0, 3) + "-" + vo.getReseTel().substring(3, 7) + "-" + vo.getReseTel().substring(7, 11);
	        } else {
	        	telNo = vo.getReseTel();
	        }
	        cell.setCellValue(telNo);
	        cell = row.createCell(7);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getReseAreaName());
	        cell = row.createCell(8);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getReseRegDate());
	    }
	    
	    // 셀 크기 자동조절
	    for(int i=0; i<=8; i++) {
	    	sheet.autoSizeColumn(i);
	    	sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+512 );
	    }

	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=reservationList.xlsx");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
	@RequestMapping(value="reserv_admin_cond_excelDown.do")
	public void reservationCondExcelDown(
			 TravelReservation travelReservation
			,HttpServletRequest request
			,HttpServletResponse response
			,Model model) throws Exception {
		travelReservation.setIsExcelDown("Y");
		Map<String, Object> resultMap = reseService.selectBeachManagementList(travelReservation);
		List<TravelReservation> excelList = (List<TravelReservation>) resultMap.get("bList");
		
		// 워크북 생성
	    Workbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("Sheet1");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;

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
	    bodyStyle.setAlignment(CellStyle.ALIGN_CENTER);

	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("NO");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("해수욕장명");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("인원");
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("시간");

	    // 데이터 부분 생성
	    for(TravelReservation vo : excelList) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getSeq_id());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getPoi_nm());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getMax_uniq_pop()));
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getMax_time().substring(0, 4) + "년 " + vo.getMax_time().substring(5, 7) + "월 " + vo.getMax_time().substring(8, 10) + "일 " + vo.getMax_time().substring(11, 13) + "시" + vo.getMax_time().substring(14, 16) + "분");
	    }
	    
	    // 셀 크기 자동조절
	    for(int i=0; i<5; i++) {
	    	sheet.autoSizeColumn(i);
	    	sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+612 );
	    }
	    
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=reservationCondList.xlsx");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
	@RequestMapping(value="reserv_admin_time_excelDown.do")
	public void reservationTimeExcelDown(
			 TravelReservation travelReservation
			,HttpServletRequest request
			,HttpServletResponse response
			,Model model) throws Exception {
		travelReservation.setIsExcelDown("Y");
		Map<String, Object> resultMap = reseService.selectBeachTimeList(travelReservation);
		List<TravelReservation> excelList = (List<TravelReservation>) resultMap.get("timelist");
		
		// 워크북 생성
	    Workbook wb = new XSSFWorkbook();
	    Sheet sheet = wb.createSheet("Sheet1");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;

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
	    bodyStyle.setAlignment(CellStyle.ALIGN_CENTER);

	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("NO");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("해수욕장명");
	    int z = 2;
	    for(int x=0; x<24; x++) {
	    	for(int y=0; y<4; y=y+3) { 		
	    		cell = row.createCell(z);
	    	    cell.setCellStyle(headStyle);
	    	    cell.setCellValue(x+"시 " + y +"0분");
	    	    z++;
	    	}
	    }

	    // 데이터 부분 생성
	    for(TravelReservation vo : excelList) {
	        row = sheet.createRow(rowNo++);	        
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getSeq_id());	        
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(vo.getPoi_nm());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0000()));
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0030()));
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0100()));
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0130()));
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0200()));
	        cell = row.createCell(7);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0230()));
	        cell = row.createCell(8);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0300()));
	        cell = row.createCell(9);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0330()));
	        cell = row.createCell(10);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0400()));
	        cell = row.createCell(11);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0430()));
	        cell = row.createCell(12);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0500()));
	        cell = row.createCell(13);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0530()));
	        cell = row.createCell(14);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0600()));
	        cell = row.createCell(15);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0630()));
	        cell = row.createCell(16);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0700()));
	        cell = row.createCell(17);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0730()));
	        cell = row.createCell(18);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0800()));
	        cell = row.createCell(19);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0830()));
	        cell = row.createCell(20);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0900()));
	        cell = row.createCell(21);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime0930()));
	        cell = row.createCell(22);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1000()));
	        cell = row.createCell(23);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1030()));
	        cell = row.createCell(24);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1100()));
	        cell = row.createCell(25);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1130()));
	        cell = row.createCell(26);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1200()));
	        cell = row.createCell(27);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1230()));
	        cell = row.createCell(28);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1300()));
	        cell = row.createCell(29);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1330()));
	        cell = row.createCell(30);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1400()));
	        cell = row.createCell(31);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1430()));
	        cell = row.createCell(32);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1500()));
	        cell = row.createCell(33);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1530()));
	        cell = row.createCell(34);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1600()));
	        cell = row.createCell(35);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1630()));
	        cell = row.createCell(36);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1700()));
	        cell = row.createCell(37);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1730()));
	        cell = row.createCell(38);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1800()));
	        cell = row.createCell(39);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1830()));
	        cell = row.createCell(40);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1900()));
	        cell = row.createCell(41);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime1930()));
	        cell = row.createCell(42);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime2000()));
	        cell = row.createCell(43);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime2030()));
	        cell = row.createCell(44);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime2100()));
	        cell = row.createCell(45);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime2130()));
	        cell = row.createCell(46);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime2200()));
	        cell = row.createCell(47);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime2230()));
	        cell = row.createCell(48);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime2300()));
	        cell = row.createCell(49);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(Integer.parseInt(vo.getTime2330()));	        
	    }
	    
	    
	    // 셀 크기 자동조절
	    for(int i=0; i<50; i++) {
	    	sheet.autoSizeColumn(i);
	    	sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+612 );
	    }
	    
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=reseTimeList_"+ travelReservation.getSsyear() +travelReservation.getSsmonth() + travelReservation.getSsdate() + ".xlsx");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
	@RequestMapping(value="reserv_admin_cond.do")
	public String reservationintroAdminCond(
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
		
		travelReservation.setReseBeachId(adminBeachId);
		model.addAllAttributes(reseService.selectBeachManagementList(travelReservation));
		model.addAttribute("travelReservation", travelReservation);
		
		return skinPath + "reserv_admin_cond";
	}
	
	@RequestMapping(value="reserv_admin_time.do")
	public String reservationintroAdminTime(
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
		
		travelReservation.setReseBeachId(adminBeachId);
		model.addAllAttributes(reseService.selectBeachTimeList(travelReservation));
		model.addAttribute("travelReservation", travelReservation);
		
		return skinPath + "reserv_admin_time";
	}
	
}
