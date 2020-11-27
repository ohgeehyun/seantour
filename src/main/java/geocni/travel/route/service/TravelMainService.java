package geocni.travel.route.service;

import java.util.List;

import geocni.travel.route.domain.TravelMain;

public interface TravelMainService {	

	List<?> selectBeachPerCnt() throws Exception;
	
	void insertBeachPer(TravelMain vo) throws Exception;
	
	List<?> selectBeachPerCntapi() throws Exception;
	
	List<?> newselectBeachPerCnt() throws Exception;
	
	List<?> selectCongestion() throws Exception;

	List<?> selectBeachPerCntInsert() throws Exception;
	
	List<?> selectTravelMainDestination(TravelMain travelMain) throws Exception;
	
	List<?>selectTravelDestinationApi() throws Exception;
	
	List<?>selectTravelrouteApi() throws Exception;
	
	List<?>selectTravelrouteDailyApi() throws Exception;
	
	int selectDataExistCnt(String substring) throws Exception;
	
//	int selectTravelRouteListCnt(TravelRoute vo) throws Exception;
//	
//	List<?> selectTravelRouteBestList(TravelRoute vo) throws Exception;
//	
//	TravelRoute selectTravelRoute(TravelRoute vo) throws Exception;
//	
//	/*TravelRoute selectTravelRouteInfoByGroup(String routGroup) throws Exception;*/
//	
//	TravelRoute insertTravelRoute(TravelRoute vo) throws Exception;
//
//	void updateTravelRoute(TravelRoute vo) throws Exception;
//	
//	void updateTravelRouteOpenStatus(TravelRoute vo) throws Exception;
//	
//	void updateTravelRouteHitCount(String routId) throws Exception;
//	
//	void deleteTravelRoutePhysically(TravelRoute vo) throws Exception;
//
//	List<?> selectTravelRouteStats(Integer recordCountPerPage) throws Exception;
	
}
