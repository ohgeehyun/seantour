package geocni.travel.route.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.dao.TravelDestinationDAO;
import geocni.travel.route.domain.TravelDestination;
//import geocni.utils.PaginationInfo;

@Service("travelDestinationService")
public class TravelDestinationServiceImpl extends EgovAbstractServiceImpl implements TravelDestinationService {

    private static final Logger LOGGER = LoggerFactory.getLogger(TravelDestinationServiceImpl.class);

    @Resource(name="travelDestinationDAO")
    private TravelDestinationDAO travelDestinationDAO;
    
    @Resource(name="travelRouteIdGnrService")    
    private EgovIdGnrService routeIdGnrService;

    @Resource(name="egovMessageSource")
	private EgovMessageSource msgSrc;

	@Override
	public Map<String, Object> selectTravelDestinationListMap(TravelDestination vo) throws Exception {
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	
    	PaginationInfo paginationInfo = makePagination(vo);
    	
    	int totCnt = travelDestinationDAO.selectTravelDestinationListCnt(vo);
    	paginationInfo.setTotalRecordCount(totCnt);
    	resultMap.put("paginationInfo", paginationInfo);
    	vo.setPageUnit(totCnt);
    	
    	//List<?> resultList = travelDestinationDAO.selectTaxApplicationListByCond(vo);
    	@SuppressWarnings("unchecked")
		List<TravelDestination> list = (List<TravelDestination>) travelDestinationDAO.selectTravelDestinationList(vo);
    	/*List<TravelDestination> resultList = new ArrayList<TravelDestination>();
    	TravelDestination apps;
		Iterator<TravelDestination> iter = list.iterator();
		while (iter.hasNext()) {
			apps = (TravelDestination)iter.next();
			
			if(apps.getFamilyInfo() != null && !"".equals(apps.getFamilyInfo())) {
				Object familyObj = JSONValue.parse(apps.getFamilyInfo());
				apps.setFamilyObj(familyObj);
			}
			if(apps.getAdjustedItems() != null && !"".equals(apps.getAdjustedItems())) {
				Object itemsObj = JSONValue.parse(apps.getAdjustedItems());
				apps.setItemsObj(itemsObj);
			}
			
			resultList.add(apps);
		}
    	
    	resultMap.put("resultList", resultList);*/
    	
    	resultMap.put("resultList", list);
    	
    	int allCnt = travelDestinationDAO.selectTravelDestinationListCnt(vo);
    	resultMap.put("allCnt", allCnt);

    	return resultMap;
    }

	@Override
	public List<?> selectTravelDestinationList(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestinationList(vo);
	}

	@Override
	public int selectTravelDestinationListCnt(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestinationListCnt(vo);
	}

	@Override
	public TravelDestination selectTravelDestination(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestination(vo);
	}

	@Override
	public String insertTravelDestination(TravelDestination vo) throws Exception {
    	String id = routeIdGnrService.getNextStringId();
    	vo.setDestId(id);
		return travelDestinationDAO.insertTravelDestination(vo);
	}

	@Override
	public void updateTravelDestination(TravelDestination vo) throws Exception {
		travelDestinationDAO.updateTravelDestination(vo);
	}

	@Override
	public void deleteTravelDestinationPhysically(TravelDestination vo) throws Exception {
		travelDestinationDAO.deleteTravelDestinationPhysically(vo);
	}

	@Override
	public List<?> selectTravelDestinationRegionList(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestinationRegionList(vo);
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
