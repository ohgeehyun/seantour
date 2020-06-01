package geocni.travel.route.service;

import java.util.List;
import java.util.Map;

import geocni.travel.route.domain.TravelDestination;

public interface TravelDestinationService {

	Map<String, Object> selectTravelDestinationListMap(TravelDestination vo) throws Exception;

	List<?> selectTravelDestinationList(TravelDestination vo) throws Exception;

	int selectTravelDestinationListCnt(TravelDestination vo) throws Exception;
	
	TravelDestination selectTravelDestination(TravelDestination vo) throws Exception;
	
	String insertTravelDestination(TravelDestination vo) throws Exception;

	void updateTravelDestination(TravelDestination vo) throws Exception;
	
	void deleteTravelDestinationPhysically(TravelDestination vo) throws Exception;

	List<?> selectTravelDestinationRegionList(TravelDestination vo) throws Exception;
	
}
