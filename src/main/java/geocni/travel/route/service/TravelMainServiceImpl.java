package geocni.travel.route.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import geocni.travel.route.dao.TravelMainDAO;
import geocni.travel.route.domain.TravelMain;

@Service("travelMainService")
public class TravelMainServiceImpl extends EgovAbstractServiceImpl implements TravelMainService {

//  @SuppressWarnings("unused")
//	private static final Logger LOGGER = LoggerFactory.getLogger(TravelMainServiceImpl.class);

    @Resource(name="travelMainDAO")
    private TravelMainDAO travelMainDAO;
    
    @Resource(name="egovMessageSource")
	private EgovMessageSource msgSrc;
    	
	@Override
	public List<TravelMain> selectBeachPerCnt() throws Exception {
		//DB 호출해서 정보값 가져오도록 할것.
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String datestr = sdf.format(cal.getTime());
		
		int minute = Integer.valueOf(datestr.substring(10, 12));
		String datestrtemp = datestr.substring(0,8);
		int datestrtimechange = Integer.valueOf(datestr.substring(8,10));//시간변경
		
		if(datestrtimechange == 0)
		{
			cal.add(Calendar.DATE, -1);
			datestr =sdf.format(cal.getTime());
			datestrtemp = datestr.substring(0,8);
			datestrtimechange = 23; //23시
		}else {
			cal.add(Calendar.HOUR, -1);
			datestr =sdf.format(cal.getTime());
			datestrtemp = datestr.substring(0,8);
			datestrtimechange = datestrtimechange -1; // 13시 일경우 12시 30분의 데이터를 가저와야하기 때문 시간 -1 
		}
		
		if(minute > 0 && minute < 30) {
		
			datestr = datestrtemp + datestrtimechange+"30";
		}else {
			datestr = Integer.valueOf(datestr.substring(8, 10)) + "00";
		}

		
		System.out.println("------------------------"+datestr);
		return travelMainDAO.selectBeachPerCnt(datestr);
	}
	@Override
	public  void insertBeachPer(TravelMain vo) throws Exception{
		travelMainDAO.insertBeachPer(vo);
	}
//
//	@Override
//	public List<?> selectTravelRouteList(TravelRoute vo) throws Exception {
//    	//return travelRouteDAO.selectTravelRouteList(vo);
//		@SuppressWarnings("unchecked")
//		List<TravelRoute> list = (List<TravelRoute>) travelRouteDAO.selectTravelRouteList(vo);
//    	
//    	List<TravelRoute> resultList = makeTravelRouteDescription(list);
//    	return resultList;
//	}
//
//	@Override
//	public int selectTravelRouteListCnt(TravelRoute vo) throws Exception {
//    	return travelRouteDAO.selectTravelRouteListCnt(vo);
//	}
//
//	@Override
//	public List<?> selectTravelRouteBestList(TravelRoute vo) throws Exception {
//    	return travelRouteDAO.selectTravelRouteList(vo);
//	}
//
//	@Override
//	public TravelRoute selectTravelRoute(TravelRoute vo) throws Exception {
//		
//		TravelRoute travelRoute = null;
//		try {
//
//			travelRoute= travelRouteDAO.selectTravelRoute(vo);
//			
//			List<TravelRouteDaily> dailyList = travelRoute.getRouteDailyList();
//			if(dailyList != null && dailyList.size() > 0) {
//				List<TravelRouteDaily> newDailyList = new ArrayList<TravelRouteDaily>();
//				TravelRouteDaily routeDaily;
//				for (TravelRouteDaily daily : dailyList) {
//					routeDaily = daily;
//					if(!NullUtil.isEmpty(daily.getRoutWayPoint())) {
//						String[] descList = daily.getRoutWayPoint().split("[|]");
//						
//						List<TravelDestination> destList = new ArrayList<TravelDestination>();
//						TravelDestination destination = new TravelDestination();
//						for(int i=0;descList.length > i ;i++){
//							destination.setDestId(descList[i]);
//							TravelDestination dest = new TravelDestination();
//							dest = travelDestinationDAO.selectTravelDestination(destination);
//							destList.add(dest);
//						}
//						routeDaily.setWayPointList(destList);
//						
//						newDailyList.add(routeDaily);
//					}
//				}
//				travelRoute.setRouteDailyList(newDailyList);
//			}
//			
//		} catch (NullPointerException e) {
//			LOGGER.debug(e.toString());
//		} catch (SQLException e) {
//			LOGGER.debug(e.toString());
//		}
//		
//		return travelRoute;
//	}
//	
//	@Override
//	public TravelRoute insertTravelRoute(TravelRoute vo) throws Exception {
//    	try {
//			String id = routeIdGnrService.getNextStringId();
//			vo.setRoutId(id);
//
//			//get 대표 썸네일 path 설정 후 insert
//			if(!NullUtil.isEmpty(vo.getRouteDailyList()) && vo.getRouteDailyList().size() > 0) {
//				TravelRouteDaily day = vo.getRouteDailyList().get(0);
//				String[] descList = day.getRoutWayPoint().split("[|]");
//				
//				TravelDestination dest = new TravelDestination();
//				dest.setDestId(descList[0]);
//				dest = travelDestinationDAO.selectTravelDestination(dest);
//				String thumbPath = "";
//				if(dest.getTravelFileList().size() > 0) {
//					thumbPath = dest.getTravelFileList().get(0).getImgFilePath(); 
//				} else {
//					thumbPath = dest.getDestImgPath();
//				}
//				vo.setRoutThumbPath(thumbPath);
//			}
//			travelRouteDAO.insertTravelRoute(vo);
//
//			//일간 일정에 routId 설정 후 insert
//			List<TravelRouteDaily> dailyList = vo.getRouteDailyList();
//			if(dailyList != null && dailyList.size() > 0) {
//				List<TravelRouteDaily> newDailyList = new ArrayList<TravelRouteDaily>();
//				TravelRouteDaily routeDaily;
//				for (TravelRouteDaily daily : dailyList) {
//					routeDaily = daily;
//					routeDaily.setRoutId(id);
//					newDailyList.add(routeDaily);
//				}
//				travelRouteDAO.insertTravelRouteDaily(newDailyList);
//			}
//
//    	} catch (NullPointerException e) {
//			LOGGER.debug(e.toString());
//		}catch (SQLException e) {
//			LOGGER.debug(e.toString());
//		}
//		return vo;
//	}
//
//	@Override
//	public void updateTravelRoute(TravelRoute vo) throws Exception {
//		//get 대표 썸네일 path 설정 후 insert
//		if(!NullUtil.isEmpty(vo.getRouteDailyList()) && vo.getRouteDailyList().size() > 0) {
//			TravelRouteDaily day = vo.getRouteDailyList().get(0);
//			String[] descList = day.getRoutWayPoint().split("[|]");
//			
//			TravelDestination dest = new TravelDestination();
//			dest.setDestId(descList[0]);
//			dest = travelDestinationDAO.selectTravelDestination(dest);
//			String thumbPath = "";
//			if(dest.getTravelFileList().size() > 0) {
//				thumbPath = dest.getTravelFileList().get(0).getImgFilePath(); 
//			} else {
//				thumbPath = dest.getDestImgPath();
//			}
//			vo.setRoutThumbPath(thumbPath);
//		}
//		travelRouteDAO.updateTravelRoute(vo);
//		
//		//개별 수정이 아닌 일괄 삭제 후 일괄 insert
//		travelRouteDAO.deleteTravelRouteDaily(vo);
//		
//		//일간 일정에 routId 설정 후 insert
//		List<TravelRouteDaily> dailyList = vo.getRouteDailyList();
//		if(dailyList != null && dailyList.size() > 0) {
//			List<TravelRouteDaily> newDailyList = new ArrayList<TravelRouteDaily>();
//			TravelRouteDaily routeDaily;
//			for (TravelRouteDaily daily : dailyList) {
//				routeDaily = daily;
//				routeDaily.setRoutId(vo.getRoutId());
//				newDailyList.add(routeDaily);
//			}
//			travelRouteDAO.insertTravelRouteDaily(newDailyList);
//		}
//
//	}
//
//	@Override
//	public void updateTravelRouteOpenStatus(TravelRoute vo) throws Exception {
//		travelRouteDAO.updateTravelRouteOpenStatus(vo);
//	}
//	
//	@Override
//	public void updateTravelRouteHitCount(String routId) throws Exception {
//		travelRouteDAO.updateTravelRouteHitCount(routId);
//	}
//	
//	@Override
//	public void deleteTravelRoutePhysically(TravelRoute vo) throws Exception {
//		travelRouteDAO.deleteTravelRoutePhysically(vo);
//	}
//
//	@Override
//	public List<?> selectTravelRouteStats(Integer recordCountPerPage) throws Exception {
//		@SuppressWarnings("unchecked")
//		List<String> routeList = (List<String>) travelRouteDAO.selectTravelRouteStats(recordCountPerPage);
//		
//		List<TravelDestination> destList = new ArrayList<TravelDestination>();
//		TravelDestination destination = new TravelDestination();
//		for(int i=0;routeList.size() > i ;i++){
//			destination.setDestId(routeList.get(i));
//			TravelDestination dest = new TravelDestination();
//			dest = travelDestinationDAO.selectTravelDestination(destination);
//			destList.add(dest);
//		}
//		return destList;
//	}
//
//	private PaginationInfo makePagination(TravelDefaultVO vo) {
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(vo.getPageIndex());
//		paginationInfo.setRecordCountPerPage(vo.getPageUnit());
//		paginationInfo.setPageSize(vo.getPageSize());
//
//		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		vo.setLastIndex(paginationInfo.getLastRecordIndex());
//		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//		return paginationInfo;
//	}
	
}
