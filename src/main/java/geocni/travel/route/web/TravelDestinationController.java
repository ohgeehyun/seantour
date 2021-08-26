package geocni.travel.route.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovFileUploadUtil;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.common.files.domain.TravelFiles;
import geocni.travel.common.files.service.TravelFilesService;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelMain;
import geocni.travel.route.service.TravelDestinationService;
import geocni.travel.route.service.TravelMainService;
import geocni.travel.route.service.TravelRouteService;
import jnit.cms.mbr.JnitcmsmbrVO;
import jnit.mgov.module.JnitMgovUtil;
import jnit.util.PathUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@SessionAttributes(types = TravelDestination.class)
@RequestMapping(value = "/travel/destination/")
public class TravelDestinationController {

	@Resource(name = "travelDestinationService")
	private TravelDestinationService destService;

	@Resource(name = "travelRouteService")
	private TravelRouteService routeService;

	@Resource(name = "travelFilesService")
	private TravelFilesService travelFilesService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	@Resource(name = "travelMainService")
	protected TravelMainService travelmainService;

	@Resource(name = "egovMessageSource")
	private EgovMessageSource msgSrc;

	@SuppressWarnings("unused")
	@Autowired
	private DefaultBeanValidator beanValidator;

	private Log log = LogFactory.getLog(getClass());

	private long maxFileSize = 1024 * 1024 * 10;

	private String skinPath = "travel/destination/";

	private @ModelAttribute("travelDestination") TravelDestination selectTravelDestination(
			TravelDestination travelDestination) throws Exception {

		return travelDestination = destService.selectTravelDestination(travelDestination);
	}

	@RequestMapping(value = "list.do")
	public String destinationList(@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)
			throws Exception {
		
		try {
			
			 if(travelDestination.getDestCategory() == "") {
				 travelDestination.setTourism(null);
				 travelDestination.setLodgment(null);
				 travelDestination.setRestaurant(null);
				 travelDestination.setShopping(null);
				 travelDestination.setLeisure(null);
				 travelDestination.setDestRegion("");
				 travelDestination.setSearchKeyword("");
			 }	
			 if( travelDestination.getUrlparam().equals("관광지") && !travelDestination.getDestCategory().equals(travelDestination.getUrlparam())) {
				 travelDestination.setTourism(null);
				 travelDestination.setDestRegion("");
				 travelDestination.setSearchKeyword("");
			 }
			 if( travelDestination.getUrlparam().equals("숙박") && !travelDestination.getDestCategory().equals(travelDestination.getUrlparam())) {
				 travelDestination.setLodgment(null);
				 travelDestination.setDestRegion("");
				 travelDestination.setSearchKeyword("");
			 }
			 if( travelDestination.getUrlparam().equals("음식점") && !travelDestination.getDestCategory().equals(travelDestination.getUrlparam())) {
				 travelDestination.setRestaurant(null);
				 travelDestination.setDestRegion("");
				 travelDestination.setSearchKeyword("");
			 }
			 if( travelDestination.getUrlparam().equals("쇼핑") && !travelDestination.getDestCategory().equals(travelDestination.getUrlparam())) {
				 travelDestination.setShopping(null);
				 travelDestination.setDestRegion("");
				 travelDestination.setSearchKeyword("");
			 }
			 if( travelDestination.getUrlparam().equals("레져") && !travelDestination.getDestCategory().equals(travelDestination.getUrlparam())) {
				 travelDestination.setLeisure(null);
				 travelDestination.setDestRegion("");
				 travelDestination.setSearchKeyword("");
			 }
			 	
		
			}catch(NullPointerException e) {
				log.debug(e);
		 }
			
		try {
			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);

			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			if (!NullUtil.isEmpty(loginVO.getMbrId())) {
				travelDestination.setDestUserId(loginVO.getMbrId());
			}

			// travelDestination.setPageUnit(propertiesService.getInt("pageUnit"));
			travelDestination.setPageUnit(8);
			travelDestination.setPageSize(propertiesService.getInt("pageSize"));

			model.addAttribute("excelPageno", excelPageno);
			model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
			status.setComplete();

			model.addAttribute("travelDestination", travelDestination);

		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}

		return skinPath + "list";
	}

	@RequestMapping(value = "recolist.do")
	public String redestinationList(TravelDestination travelDestination, SessionStatus status, Model model)
			throws Exception {

		List<?> resultList = destService.selectRecoDestinationlist(travelDestination);
		model.addAttribute("resultList", resultList);

		status.setComplete();
		return skinPath + "recolist";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "travelMainDestination.do", method = RequestMethod.GET)
	@ResponseBody
	public List<?> mainBeachCongestion(HttpServletRequest request, HttpServletResponse respons,
			@ModelAttribute("searchVO") TravelDefaultVO searchVO, TravelDestination travelDestination,
			SessionStatus status, HttpServletRequest req, ModelMap model, TravelMain travelMain) throws Exception {

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String datestr = sdf.format(cal.getTime());
		String datestrtemp = datestr.substring(0, 8);

		Calendar cal2 = Calendar.getInstance();
		cal2.get(Calendar.DATE);
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmm");
		String datestr2 = sdf2.format(cal2.getTime());
		String datestrtemp2 = datestr2.substring(0, 8);

		travelMain.setDatestrtemp(datestrtemp);
		travelMain.setDatestrtemp2(datestrtemp2);
		travelMain.setDestId(travelDestination.getDestId());

		List<?> travelMainDestination = travelmainService.selectTravelMainDestination(travelMain);
		/*
		 * JSONObject sObject = new JSONObject();
		 * 
		 * for(int i=0; i < travelMainDestination.size(); i++) {
		 * sObject.put(i,travelMainDestination.get(i)); }
		 */
		return travelMainDestination;
	}

	@RequestMapping(value = "detail.do")
	public String destinationDetail(@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status, HttpServletRequest req, ModelMap model,
			TravelMain travelMain) throws Exception {

		try {

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			String datestr = sdf.format(cal.getTime());
			String datestrtemp = datestr.substring(0, 8);

			Calendar cal2 = Calendar.getInstance();
			cal2.get(Calendar.DATE);
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmm");
			String datestr2 = sdf2.format(cal2.getTime());
			String datestrtemp2 = datestr2.substring(0, 8);

			travelMain.setDatestrtemp(datestrtemp);
			travelMain.setDatestrtemp2(datestrtemp2);
			travelMain.setDestId(travelDestination.getDestId());

			List<?> travelMainDestination = travelmainService.selectTravelMainDestination(travelMain);

			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			if (!NullUtil.isEmpty(loginVO.getMbrId())) {
				travelDestination.setDestUserId(loginVO.getMbrId());
			}
			model.addAttribute("travelMainDestination", travelMainDestination);
			travelDestination = destService.selectTravelDestination(travelDestination);
			model.addAttribute("travelDestination", travelDestination);

			travelDestination.setDistance(50000); // 거리 30km about
			travelDestination.setRecordCountPerPage(3);
			// 인근 숙박시설
			travelDestination.setDestCategory("숙박");
			List<?> nearStayPoints = destService.selectTravelDestinationNearPointList(travelDestination);
			model.addAttribute("nearStayPoints", nearStayPoints);
			// 인근 놀이시설
			travelDestination.setDestCategory("체험");
			List<?> nearPlayPoints = destService.selectTravelDestinationNearPointList(travelDestination);
			model.addAttribute("nearPlayPoints", nearPlayPoints);

			status.setComplete();

		} catch (NullPointerException e) {
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return skinPath + "detail";
	}
	
	@RequestMapping(value = "excelDetail.do")
	public String excelDestinationDetail(@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status, HttpServletRequest req, ModelMap model,
			TravelMain travelMain,HttpServletResponse response,
			@RequestParam(value = "destid", required = false, defaultValue = "1") String destid) throws Exception {

			travelDestination.setDestId(destid);
		try {

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			String datestr = sdf.format(cal.getTime());
			String datestrtemp = datestr.substring(0, 8);

			Calendar cal2 = Calendar.getInstance();
			cal2.get(Calendar.DATE);
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmm");
			String datestr2 = sdf2.format(cal2.getTime());
			String datestrtemp2 = datestr2.substring(0, 8);

			travelMain.setDatestrtemp(datestrtemp);
			travelMain.setDatestrtemp2(datestrtemp2);
			travelMain.setDestId(travelDestination.getDestId());

			List<?> travelMainDestination = travelmainService.selectTravelMainDestination(travelMain);

			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			if (!NullUtil.isEmpty(loginVO.getMbrId())) {
				travelDestination.setDestUserId(loginVO.getMbrId());
			}
			model.addAttribute("travelMainDestination", travelMainDestination);
			travelDestination = destService.selectTravelDestination(travelDestination);
			model.addAttribute("travelDestination", travelDestination);

			travelDestination.setDistance(50000); // 거리 30km about
			travelDestination.setRecordCountPerPage(3);
			// 인근 숙박시설
			travelDestination.setDestCategory("숙박");
			List<?> nearStayPoints = destService.selectTravelDestinationNearPointList(travelDestination);
			model.addAttribute("nearStayPoints", nearStayPoints);
			// 인근 놀이시설
			travelDestination.setDestCategory("체험");
			List<?> nearPlayPoints = destService.selectTravelDestinationNearPointList(travelDestination);
			model.addAttribute("nearPlayPoints", nearPlayPoints);

			status.setComplete();

		} catch (NullPointerException e) {
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=" + "DetailExcelfile.xls");

		return skinPath + "exceldetail";
	}
	
	

	@RequestMapping(value = "register.do")
	public String registerTravelDestination(TravelDestination travelDestination, HttpServletRequest req, ModelMap model)
			throws Exception {

		try {
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			if (loginVO == null || NullUtil.nullString(loginVO.getMbrId()).equals("")) {
				return "redirect:/travel/destination/list.do";
			}
			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);

			if (!model.containsAttribute("travelDestination")) {
				model.addAttribute("travelDestination", new TravelDestination());
			}

		} catch (NullPointerException e) {
			log.error(e.getMessage());
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return skinPath + "register";
	}

	@RequestMapping(value = "insert.do", method = RequestMethod.POST)
	public String insertTravelDestination(@ModelAttribute("travelDestination") TravelDestination travelDestination,
			BindingResult bindingResult, SessionStatus status, HttpServletRequest request, Model model)
			throws Exception {

		// String destId = travelDestination.getDestId();
		try {
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelDestination.setDestWriter(loginVO.getMbrId());

			/******** 파일업로드 ********/
			String uploadDir = "/upload/travel/destination";
			String root = PathUtil.getRealPath(request);
			String fileDir = root + uploadDir;
			String filename = "";
			String fileExt = "";
			boolean check = false;
			
			HashMap<String, EgovFormBasedFileVo> files = null;
			EgovFileUploadUtil.type = "noSubPath";
			files = EgovFileUploadUtil.uploadFormFiles(request, fileDir, maxFileSize);
			EgovFileUploadUtil.type = null;
			/******** 파일업로드 ********/
			for (Entry<String, EgovFormBasedFileVo> entry : files.entrySet()) {
		       filename = entry.getValue().getFileName();
		       fileExt = filename.substring(filename.lastIndexOf(".") + 1);
		       if(fileExt.equals("jpg")||fileExt.equals("jpeg")||fileExt.equals("bmp")||fileExt.equals("png")||fileExt.equals("png")){
		    	  check = true;
		       }else {
		    	   break;
		       }
			} 
			if(check==true) {
			destService.insertTravelDestination(travelDestination, files);
			}
		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}
		status.setComplete();

		// return "redirect:/travel/destination/detail.do?destId="+ destId;
		return "redirect:/travel/destination/list.do";
	}

	@RequestMapping(value = "modify.do")
	public String modifyTravelDestination(@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, HttpServletRequest req, ModelMap model) throws Exception {

		try {
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelDestination = destService.selectTravelDestination(travelDestination);
			if (loginVO == null || !loginVO.getMbrId().equals(travelDestination.getDestWriter())) {
				return "redirect:/travel/destination/list.do";
			}

			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);

			model.addAttribute("travelDestination", travelDestination);

		} catch (NullPointerException e) {
			log.error(e.getMessage());
			return "redirect:/travel/destination/list.do";
		} catch (Exception e) {
			log.error(e.getMessage());
			return "redirect:/travel/destination/list.do";
		}

		return skinPath + "register";
	}

	@RequestMapping(value = "update.do", method = RequestMethod.POST)
	public String updateTravelDestination(@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			@ModelAttribute("travelDestination") TravelDestination travelDestination, BindingResult bindingResult,
			SessionStatus status, HttpServletRequest request, Model model) throws Exception {

		try {

			/******** 파일업로드 ********/
			String uploadDir = "/upload/travel/destination";
			String root = PathUtil.getRealPath(request);
			String fileDir = root + uploadDir;
			String fileName ="";
			String fileExt = "";
			boolean check = true;
			HashMap<String, EgovFormBasedFileVo> files = null;
			EgovFileUploadUtil.type = "noSubPath";
			files = EgovFileUploadUtil.uploadFormFiles(request, fileDir, maxFileSize);

			List<TravelFiles> oldFileList = travelDestination.getTravelFileList();
			if (!files.isEmpty()) {
				List<TravelFiles> fileList = new ArrayList<>();
				Iterator<String> keys = files.keySet().iterator();
				int serialNo = oldFileList.size();
				while (keys.hasNext()) {
					String key = keys.next();

					EgovFormBasedFileVo fileVo = files.get(key);
					String filePathUrl = uploadDir + "/" + fileVo.getPhysicalName();
					int idx = Integer.valueOf(key.split("_")[1]);

					TravelFiles travelFile = new TravelFiles();
					travelFile.setImgRefId(travelDestination.getDestId());
					travelFile.setImgFileNo(serialNo);
					travelFile.setImgFileName(fileVo.getFileName());
					travelFile.setImgFilePath(filePathUrl);
					travelFile.setImgFileSize(fileVo.getSize());
					travelFile.setImgFileExt(fileVo.getContentType());

					if (oldFileList.size() > idx) {
						TravelFiles oldFile = oldFileList.get(idx);
						// 원본파일 삭제
						File file = new File(root + oldFile.getImgFilePath());
						if (file.exists()) {
							file.delete();
						}
						travelFile.setImgFileNo(idx);
						fileName=travelFile.getImgFileName();
						fileExt=fileName.substring(fileName.lastIndexOf(".") + 1);
						if(fileExt.equals("jpg")||fileExt.equals("jpeg")||fileExt.equals("bmp")||fileExt.equals("png")||fileExt.equals("png")) {
							travelFilesService.updateTravelFiles(travelFile);	
							check = true;
						}else {
							break;
						}
					} else {
						fileList.add(travelFile);
					}
					serialNo++;
				}
				
				if (fileList.size() > 0) {
					if(check) {
					travelFilesService.insertTravelFiles(fileList);
					}
				}
			}
			EgovFileUploadUtil.type = null;
			/******** 파일업로드 ********/
			if(check) {
			destService.updateTravelDestination(travelDestination);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		status.setComplete();

		return "redirect:/travel/destination/list.do";
	}

	@RequestMapping(value = "delete.do", method = RequestMethod.POST)
	public String deleteTravelRoute(@ModelAttribute("searchVO") TravelDefaultVO searchVO,
			TravelDestination travelDestination, SessionStatus status, HttpServletRequest request, Model model)
			throws Exception {

		try {

			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			travelDestination = destService.selectTravelDestination(travelDestination);
			if (loginVO == null || !loginVO.getMbrId().equals(travelDestination.getDestWriter())) {
				return "redirect:/travel/destination/list.do";
			}

			// 첨부파일 삭제
			String realPath = PathUtil.getRealPath(request);
			if (travelDestination.getTravelFileList().size() > 0) {
				travelFilesService.deleteTravelFilesPhysically(travelDestination.getTravelFileList(), realPath);
			}
			File file = new File(realPath + travelDestination.getDestImgPath());
			if (file.exists()) {
				file.delete();
			}

			destService.deleteTravelDestinationPhysically(travelDestination);

		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}

		status.setComplete();
		return "redirect:/travel/destination/list.do";
	}

	@ResponseBody
	@RequestMapping(value = "retrieveDestinationList.do", produces = "application/text;charset=utf8")
	public String retrieveDestinationList(TravelDestination travelDestination, SessionStatus status,
			HttpServletRequest req, Model model) throws Exception {

		String dest = null;
		try {
			if (!NullUtil.isEmpty(travelDestination.getDestTag())) {
				travelDestination.setDestTagList(travelDestination.getDestTag());
			}
			/*
			 * int pageUnit = travelDestination.getPageUnit() != 0 ?
			 * travelDestination.getPageUnit() : 6; int pageSize =
			 * travelDestination.getPageSize() != 0 ? travelDestination.getPageSize() : 10;
			 * travelDestination.setPageUnit(pageUnit);
			 * travelDestination.setPageSize(pageSize);
			 */
			travelDestination.setPageUnit(6);
			travelDestination.setPageSize(10);
			Map<String, Object> destList = destService.selectTravelDestinationListMap(travelDestination);

			status.setComplete();
			// com.fasterxml.jackson.databind.ObjectMapper mapper = new
			// com.fasterxml.jackson.databind.ObjectMapper();
			ObjectMapper mapper = new ObjectMapper();
			dest = mapper.writeValueAsString(destList);
		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}

		return dest;
	}

	@ResponseBody
	@RequestMapping(value = "retrieveDestinationDetail.do", produces = "application/text;charset=utf8")
	// public Map<String,Object> retrieveDestinationDetail(
	public String retrieveDestinationDetail(TravelDestination travelDestination, HttpServletRequest req, Model model)
			throws Exception {

		String dest = null;
		try {
			TravelDestination detail = destService.selectTravelDestination(travelDestination);
			ObjectMapper mapper = new ObjectMapper();
			dest = mapper.writeValueAsString(detail);
		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}

		return dest;
	}

	@RequestMapping(value = "stats.do")
	public String statList(@ModelAttribute("searchVO") TravelDefaultVO searchVO, TravelDestination travelDestination,
			SessionStatus status, Model model) throws Exception {

		try {
			// travelDestination.setPageUnit(propertiesService.getInt("pageUnit"));
			// travelDestination.setPageSize(propertiesService.getInt("pageSize"));
			travelDestination.setRecordCountPerPage(30);
			travelDestination.setDestSeason(null);
			travelDestination.setDestRegion(null);

			Map<?, ?> tagMap = destService.selectTravelDestinationStatsByTag(travelDestination);
			model.addAttribute("tagMap", tagMap);

			model.addAllAttributes(destService.selectTravelDestinationStatsBySeason(travelDestination));

			model.addAttribute("travelDestination", travelDestination);

			Integer recordCountPerPage = 6;
			List<?> routeList = routeService.selectTravelRouteStats(recordCountPerPage);
			model.addAttribute("routeList", routeList);

			status.setComplete();

		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}

		return skinPath + "stats";
	}
	
	@RequestMapping(value = "statsExcel.do")
	public String alldowexcel(TravelDestination travelDestination, HttpServletRequest request, HttpServletResponse response,
			 SessionStatus status, Model model)
			throws Exception {
	
		
		try {
			// travelDestination.setPageUnit(propertiesService.getInt("pageUnit"));
			// travelDestination.setPageSize(propertiesService.getInt("pageSize"));
			travelDestination.setRecordCountPerPage(30);
			travelDestination.setDestSeason(null);
			travelDestination.setDestRegion(null);

			Map<?, ?> tagMap = destService.selectTravelDestinationStatsByTag(travelDestination);
			model.addAttribute("tagMap", tagMap);

			model.addAllAttributes(destService.selectTravelDestinationStatsBySeason(travelDestination));

			model.addAttribute("travelDestination", travelDestination);

			Integer recordCountPerPage = 6;
			List<?> routeList = routeService.selectTravelRouteStats(recordCountPerPage);
			model.addAttribute("routeList", routeList);

			status.setComplete();

		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}

		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=" + "MyStatsExcelfile.xls");
		return skinPath + "statsExcelview";
	}

	@ResponseBody
	@RequestMapping(value = "retrieveDestinationRegion.do", produces = "application/text;charset=utf8")
	public String retrieveDestinationRegion(TravelDestination travelDestination, HttpServletRequest req,
			SessionStatus status, Model model) throws Exception {

		String dest = null;
		try {

			travelDestination.setDestSeason(null);
			travelDestination.setRecordCountPerPage(1);
			TravelDestination destination = destService.selectTravelDestinationStatsByRegion(travelDestination);
			ObjectMapper mapper = new ObjectMapper();
			dest = mapper.writeValueAsString(destination);

			// status.setComplete();

		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}

		return dest;
	}
	
	@RequestMapping(value = "checkbox.do")
	public String checkpox(Model model) throws Exception {

		return "travel/tpl/" + "checkbox";
	}
	
	
	/* 급하게 만든 컨트롤러 메인 복사 때문에 만들었기 때문에 따로 컨트롤러 및 MVC패턴 구축시 옮기고 삭제해도 무방 - 오지현 */

	@RequestMapping(value = "main.do")
	public String mainPage(Model model) throws Exception {

		return "travel/main/" + "main";
	}

	// 바다여행 엑셀파일 만드는 컨트롤러 -백준현
	@RequestMapping(value = "dowexcel.do")
	public String dowexcel(@ModelAttribute("searchVO") TravelDefaultVO searchVO, TravelDestination travelDestination,
			HttpServletResponse response, SessionStatus status,
			@RequestParam(value = "excelPageno", required = false, defaultValue = "1") String excelPageno, Model model)
			throws Exception {

		try {
			List<?> regionList = destService.selectTravelDestinationRegionList(travelDestination);
			model.addAttribute("regionList", regionList);
			JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
			if (!NullUtil.isEmpty(loginVO.getMbrId())) {
				travelDestination.setDestUserId(loginVO.getMbrId());
			}
			int iexcelPageno = Integer.parseInt(excelPageno);
			travelDestination.setPageIndex(iexcelPageno);
			travelDestination.setPageUnit(8);
			travelDestination.setPageSize(propertiesService.getInt("pageSize"));
			
			model.addAttribute("excelPageno", excelPageno);
			model.addAllAttributes(destService.selectTravelDestinationListMap(travelDestination));
			status.setComplete();
			model.addAttribute("allCnt", 1);
			
			model.addAttribute("travelDestination", travelDestination);
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + "DestinationExcelfile.xls");
		} catch (NullPointerException e) {
			log.debug(e);
		} catch (SQLException e) {
			log.debug(e);
		}

		return skinPath + "excelview";
	}
	// 바다여행 모든 엑셀파일 만드는 컨트롤러 -백준현
		@RequestMapping(value = "alldowexcel.do")
		public String alldowexcel(@ModelAttribute("searchVO") TravelDefaultVO searchVO, TravelDestination travelDestination,
				@RequestParam(value = "allCnt", required = false, defaultValue = "1") String allCnt,
				HttpServletResponse response, SessionStatus status,	Model model)
				throws Exception {
			try {								
				JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
				if (!NullUtil.isEmpty(loginVO.getMbrId())) {
					travelDestination.setDestUserId(loginVO.getMbrId());
				}
				status.setComplete();
				
				model.addAttribute("resultList", destService.selectTravelDestinationAllexcel(travelDestination));				
				model.addAttribute("travelDestination", travelDestination);			
				model.addAttribute("allCnt",allCnt);
				response.setContentType("application/vnd.ms-excel");
				response.setHeader("Content-Disposition", "attachment; filename=" + "AllDestinationExcelfile.xls");
			} catch (NullPointerException e) {
				log.debug(e);
			} catch (SQLException e) {
				log.debug(e);
			}
			return skinPath + "excelview";
		}

	  @RequestMapping(value="summerlist.do") public String summerList(
	  
	  @ModelAttribute("searchVO") TravelDefaultVO searchVO ,TravelDestination
	  travelDestination ,SessionStatus status ,Model model) throws Exception {
	 
	  try { List<?> regionList =
	  destService.selectTravelDestinationRegionList(travelDestination);
	  model.addAttribute("regionList", regionList);
	  
	  JnitcmsmbrVO loginVO = JnitMgovUtil.getLoginMember();
	  if(!NullUtil.isEmpty(loginVO.getMbrId())) {
	  travelDestination.setDestUserId(loginVO.getMbrId()); }
	  
	  //travelDestination.setPageUnit(propertiesService.getInt("pageUnit"));
	  travelDestination.setPageUnit(8);
	  travelDestination.setPageSize(propertiesService.getInt("pageSize"));
	  
	  model.addAllAttributes(destService.selectTravelDestinationSummerListMap(
	  travelDestination)); status.setComplete();
	  
	  model.addAttribute("travelDestination", travelDestination);
	  
	  } catch (NullPointerException e) { log.debug(e); } catch (SQLException e) {
	  log.debug(e); }
	 
	  return "travel/destination/" + "summer_list"; }
	 
}
