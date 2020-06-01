package geocni.travel.route.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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

    @Resource(name="travelRouteGroupIdGnrService")    
    private EgovIdGnrService routeGroupIdGnrService;
    
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
    	TravelRoute route;
    	TravelDestination destination = new TravelDestination();
		Iterator<TravelRoute> iter = list.iterator();
		while (iter.hasNext()) {
			route = (TravelRoute)iter.next();
			
			if(!NullUtil.isEmpty(route.getRoutDescription())) {
				String[] descList = route.getRoutDescription().split("[|]");
				
				List<TravelDestination> lst = new ArrayList<TravelDestination>();
				for(int i=0;descList.length > i ;i++){
					destination.setDestId(descList[i]);
					TravelDestination dest = new TravelDestination();
					dest = travelDestinationDAO.selectTravelDestination(destination);
					lst.add(dest);
					if(dest != null && i==0) {
						route.setRoutImgPath(dest.getDestImgPath());
					}
				}
				route.setRoutePointList(lst);
			}
			resultList.add(route);
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
	public TravelRoute selectTravelRouteInfoByGroup(String routGroup) throws Exception {

    	TravelRoute route = null;
    	try {
			route= travelRouteDAO.selectTravelRouteInfoByGroup(routGroup);
			TravelDestination destination = new TravelDestination();
			
			if(!NullUtil.isEmpty(route.getRoutDescription())) {
				String[] descList = route.getRoutDescription().split("[|]");
				
				List<TravelDestination> lst = new ArrayList<TravelDestination>();
				for(int i=0;descList.length > i ;i++){
					destination.setDestId(descList[i]);
					destination = travelDestinationDAO.selectTravelDestination(destination);
					lst.add(destination);
					if(destination != null && i==0) {
						route.setRoutImgPath(destination.getDestImgPath());
					}
				}
				route.setRoutePointList(lst);
			}

    	} catch (Exception e) {
			e.printStackTrace();
		}

    	return route;
	}

	@Override
	public TravelRoute selectTravelRoute(TravelRoute vo) throws Exception {
		
		TravelRoute route = null;
		try {
			route= travelRouteDAO.selectTravelRoute(vo);
			TravelDestination destination = new TravelDestination();
			
			if(!NullUtil.isEmpty(route.getRoutDescription())) {
				String[] descList = route.getRoutDescription().split("[|]");
				
				List<TravelDestination> lst = new ArrayList<TravelDestination>();
				for(int i=0;descList.length > i ;i++){
					destination.setDestId(descList[i]);
					destination = travelDestinationDAO.selectTravelDestination(destination);
					lst.add(destination);
					if(destination != null && i==0) {
						route.setRoutImgPath(destination.getDestImgPath());
					}
				}
				route.setRoutePointList(lst);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return route;
	}
	
	@Override
	public TravelRoute insertTravelRoute(TravelRoute vo) throws Exception {
    	try {
			String id = routeIdGnrService.getNextStringId();
			vo.setRoutId(id);

			if(NullUtil.isEmpty(vo.getRoutGroup())) {
				String group = routeGroupIdGnrService.getNextStringId();
				vo.setRoutGroup(group);
			} else {
				if(NullUtil.isEmpty(vo.getRoutTitle())) {
					TravelRoute route = travelRouteDAO.selectTravelRouteInfoByGroup(vo.getRoutGroup());
					vo.setRoutTitle(route.getRoutTitle());
				}
			}
			travelRouteDAO.insertTravelRoute(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	@Override
	public void updateTravelRoute(TravelRoute vo) throws Exception {
		travelRouteDAO.updateTravelRoute(vo);
	}

	@Override
	public void deleteTravelRoutePhysically(TravelRoute vo) throws Exception {
		travelRouteDAO.deleteTravelRoutePhysically(vo);
	}

    public List<?> selectTravelRouteGroupList() throws Exception {
    	return travelRouteDAO.selectTravelRouteGroupList();
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
