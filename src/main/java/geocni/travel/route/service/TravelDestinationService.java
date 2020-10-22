package geocni.travel.route.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import geocni.travel.route.domain.TravelDestination;

public interface TravelDestinationService {

	Map<String, Object> selectTravelDestinationListMap(TravelDestination vo) throws Exception;

	List<?> selectTravelDestinationList(TravelDestination vo) throws Exception;

	int selectTravelDestinationListCnt(TravelDestination vo) throws Exception;
	
	TravelDestination selectTravelDestination(TravelDestination vo) throws Exception;
	
	TravelDestination selectTravelDestinationDetail(TravelDestination vo) throws Exception;
	
	String insertTravelDestination(TravelDestination vo) throws Exception;

	String insertTravelDestination(TravelDestination vo, HashMap<String, EgovFormBasedFileVo> files) throws Exception;
	
	void updateTravelDestination(TravelDestination vo) throws Exception;
	
	void updateTravelDestinationStatPoint(TravelDestination vo) throws Exception;
	
	void deleteTravelDestinationPhysically(TravelDestination vo) throws Exception;

	List<?> selectTravelDestinationRegionList(TravelDestination vo) throws Exception;

	Map<String, List<String>> selectTravelDestiCategoryList(List<String> searchCatList) throws Exception;

	Map<String,Integer> selectTravelDestinationStatsByTag(TravelDestination vo) throws Exception;

	Map<String, Object> selectTravelDestinationStatsBySeason(TravelDestination vo) throws Exception;

	TravelDestination selectTravelDestinationStatsByRegion(TravelDestination vo) throws Exception;

	List<?> selectTravelDestinationNearPointList(TravelDestination vo) throws Exception;
	
	List<?> selectRecoDestinationlist(TravelDestination vo) throws Exception;

	Map<String, Object> selectTravelDestinationSummerListMap(TravelDestination vo) throws Exception;

}
