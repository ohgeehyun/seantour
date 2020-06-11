package geocni.travel.route.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.sql.SQLException;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.dao.TravelDestinationDAO;
import geocni.travel.route.dao.TravelRouteDAO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelRoute;
//import geocni.utils.PaginationInfo;
import geocni.travel.route.domain.TravelRouteDaily;

@Service("travelRouteService")
public class TravelRouteServiceImpl extends EgovAbstractServiceImpl implements TravelRouteService {

    @SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(TravelRouteServiceImpl.class);

    @Resource(name="travelRouteDAO")
    private TravelRouteDAO travelRouteDAO;
    
    @Resource(name="travelDestinationDAO")
    private TravelDestinationDAO travelDestinationDAO;

    @Resource(name="travelRouteIdGnrService")    
    private EgovIdGnrService routeIdGnrService;

    @Resource(name="egovMessageSource")
	private EgovMessageSource msgSrc;

	@Override
	public Map<String, Object> selectTravelRouteListMap(TravelRoute vo) throws Exception {
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	
    	PaginationInfo paginationInfo = makePagination(vo);
    	
    	int totCnt = travelRouteDAO.selectTravelRouteListCnt(vo);
    	paginationInfo.setTotalRecordCount(totCnt);
    	resultMap.put("paginationInfo", paginationInfo);
    	vo.setPageUnit(totCnt);
    	
    	@SuppressWarnings("unchecked")
		List<TravelRoute> list = (List<TravelRoute>) travelRouteDAO.selectTravelRouteList(vo);
    	
    	List<TravelRoute> resultList = makeTravelRouteDescription(list);
    	resultMap.put("resultList", resultList);
    	
    	//resultMap.put("resultList", list);
    	
    	int allCnt = travelRouteDAO.selectTravelRouteListCnt(vo);
    	resultMap.put("allCnt", allCnt);

    	return resultMap;
    }

	private List<TravelRoute> makeTravelRouteDescription(List<TravelRoute> list) throws Exception {
		List<TravelRoute> resultList = new ArrayList<TravelRoute>();
    	TravelRoute travelRoute;
		Iterator<TravelRoute> iter = list.iterator();
		while (iter.hasNext()) {
			travelRoute = (TravelRoute)iter.next();
			
			List<TravelRouteDaily> dailyList = travelRoute.getRouteDailyList();
			if(dailyList != null && dailyList.size() > 0) {
				List<TravelRouteDaily> newDailyList = new ArrayList<TravelRouteDaily>();
				TravelRouteDaily routeDaily;
				for (TravelRouteDaily daily : dailyList) {
					routeDaily = daily;
					if(!NullUtil.isEmpty(daily.getRoutWayPoint())) {
						String[] descList = daily.getRoutWayPoint().split("[|]");
						
						List<TravelDestination> destList = new ArrayList<TravelDestination>();
						TravelDestination destination = new TravelDestination();
						for(int i=0;descList.length > i ;i++){
							destination.setDestId(descList[i]);
							TravelDestination dest = new TravelDestination();
							dest = travelDestinationDAO.selectTravelDestination(destination);
							destList.add(dest);
							/*if(dest != null && i==0) {
								travelRoute.setRoutThumbPath(dest.getDestImgPath());
							}*/
						}
	//					travelRoute.setWayPointList(destList);
						routeDaily.setWayPointList(destList);
						
						newDailyList.add(routeDaily);
					}
				}
				travelRoute.setRouteDailyList(newDailyList);
			}
			
			resultList.add(travelRoute);
		}
		return resultList;
	}

	@Override
	public List<?> selectTravelRouteList(TravelRoute vo) throws Exception {
    	//return travelRouteDAO.selectTravelRouteList(vo);
		@SuppressWarnings("unchecked")
		List<TravelRoute> list = (List<TravelRoute>) travelRouteDAO.selectTravelRouteList(vo);
    	
    	List<TravelRoute> resultList = makeTravelRouteDescription(list);
    	return resultList;
	}

	@Override
	public int selectTravelRouteListCnt(TravelRoute vo) throws Exception {
    	return travelRouteDAO.selectTravelRouteListCnt(vo);
	}

	@Override
	public List<?> selectTravelRouteBestList(TravelRoute vo) throws Exception {
    	return travelRouteDAO.selectTravelRouteList(vo);
	}

	@Override
	public TravelRoute selectTravelRoute(TravelRoute vo) throws Exception {
		
		TravelRoute travelRoute = null;
		try {

			travelRoute= travelRouteDAO.selectTravelRoute(vo);
			
			List<TravelRouteDaily> dailyList = travelRoute.getRouteDailyList();
			if(dailyList != null && dailyList.size() > 0) {
				List<TravelRouteDaily> newDailyList = new ArrayList<TravelRouteDaily>();
				TravelRouteDaily routeDaily;
				for (TravelRouteDaily daily : dailyList) {
					routeDaily = daily;
					if(!NullUtil.isEmpty(daily.getRoutWayPoint())) {
						String[] descList = daily.getRoutWayPoint().split("[|]");
						
						List<TravelDestination> destList = new ArrayList<TravelDestination>();
						TravelDestination destination = new TravelDestination();
						for(int i=0;descList.length > i ;i++){
							destination.setDestId(descList[i]);
							TravelDestination dest = new TravelDestination();
							dest = travelDestinationDAO.selectTravelDestination(destination);
							destList.add(dest);
						}
						routeDaily.setWayPointList(destList);
						
						newDailyList.add(routeDaily);
					}
				}
				travelRoute.setRouteDailyList(newDailyList);
			}
			
		} catch (NullPointerException e) {
			LOGGER.debug(e.toString());
		} catch (SQLException e) {
			LOGGER.debug(e.toString());
		}
		
		return travelRoute;
	}
	
	@Override
	public TravelRoute insertTravelRoute(TravelRoute vo) throws Exception {
    	try {
			String id = routeIdGnrService.getNextStringId();
			vo.setRoutId(id);

			//get 대표 썸네일 path 설정 후 insert
			if(!NullUtil.isEmpty(vo.getRouteDailyList()) && vo.getRouteDailyList().size() > 0) {
				TravelRouteDaily day = vo.getRouteDailyList().get(0);
				String[] descList = day.getRoutWayPoint().split("[|]");
				
				TravelDestination dest = new TravelDestination();
				dest.setDestId(descList[0]);
				dest = travelDestinationDAO.selectTravelDestination(dest);
				String thumbPath = "";
				if(dest.getTravelFileList().size() > 0) {
					thumbPath = dest.getTravelFileList().get(0).getImgFilePath(); 
				} else {
					thumbPath = dest.getDestImgPath();
				}
				vo.setRoutThumbPath(thumbPath);
			}
			travelRouteDAO.insertTravelRoute(vo);

			//일간 일정에 routId 설정 후 insert
			List<TravelRouteDaily> dailyList = vo.getRouteDailyList();
			if(dailyList != null && dailyList.size() > 0) {
				List<TravelRouteDaily> newDailyList = new ArrayList<TravelRouteDaily>();
				TravelRouteDaily routeDaily;
				for (TravelRouteDaily daily : dailyList) {
					routeDaily = daily;
					routeDaily.setRoutId(id);
					newDailyList.add(routeDaily);
				}
				travelRouteDAO.insertTravelRouteDaily(newDailyList);
			}

    	} catch (NullPointerException e) {
			LOGGER.debug(e.toString());
		}catch (SQLException e) {
			LOGGER.debug(e.toString());
		}
		return vo;
	}

	@Override
	public void updateTravelRoute(TravelRoute vo) throws Exception {
		//get 대표 썸네일 path 설정 후 insert
		if(!NullUtil.isEmpty(vo.getRouteDailyList()) && vo.getRouteDailyList().size() > 0) {
			TravelRouteDaily day = vo.getRouteDailyList().get(0);
			String[] descList = day.getRoutWayPoint().split("[|]");
			
			TravelDestination dest = new TravelDestination();
			dest.setDestId(descList[0]);
			dest = travelDestinationDAO.selectTravelDestination(dest);
			String thumbPath = "";
			if(dest.getTravelFileList().size() > 0) {
				thumbPath = dest.getTravelFileList().get(0).getImgFilePath(); 
			} else {
				thumbPath = dest.getDestImgPath();
			}
			vo.setRoutThumbPath(thumbPath);
		}
		travelRouteDAO.updateTravelRoute(vo);
		
		//개별 수정이 아닌 일괄 삭제 후 일괄 insert
		travelRouteDAO.deleteTravelRouteDaily(vo);
		
		//일간 일정에 routId 설정 후 insert
		List<TravelRouteDaily> dailyList = vo.getRouteDailyList();
		if(dailyList != null && dailyList.size() > 0) {
			List<TravelRouteDaily> newDailyList = new ArrayList<TravelRouteDaily>();
			TravelRouteDaily routeDaily;
			for (TravelRouteDaily daily : dailyList) {
				routeDaily = daily;
				routeDaily.setRoutId(vo.getRoutId());
				newDailyList.add(routeDaily);
			}
			travelRouteDAO.insertTravelRouteDaily(newDailyList);
		}

	}

	@Override
	public void updateTravelRouteOpenStatus(TravelRoute vo) throws Exception {
		travelRouteDAO.updateTravelRouteOpenStatus(vo);
	}
	
	@Override
	public void updateTravelRouteHitCount(String routId) throws Exception {
		travelRouteDAO.updateTravelRouteHitCount(routId);
	}
	
	@Override
	public void deleteTravelRoutePhysically(TravelRoute vo) throws Exception {
		travelRouteDAO.deleteTravelRoutePhysically(vo);
	}

	@Override
	public List<?> selectTravelRouteStats(Integer recordCountPerPage) throws Exception {
		@SuppressWarnings("unchecked")
		List<String> routeList = (List<String>) travelRouteDAO.selectTravelRouteStats(recordCountPerPage);
		
		List<TravelDestination> destList = new ArrayList<TravelDestination>();
		TravelDestination destination = new TravelDestination();
		for(int i=0;routeList.size() > i ;i++){
			destination.setDestId(routeList.get(i));
			TravelDestination dest = new TravelDestination();
			dest = travelDestinationDAO.selectTravelDestination(destination);
			destList.add(dest);
		}
		return destList;
	}

	private PaginationInfo makePagination(TravelDefaultVO vo) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageIndex());
		paginationInfo.setRecordCountPerPage(vo.getPageUnit());
		paginationInfo.setPageSize(vo.getPageSize());

		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		return paginationInfo;
	}

}
