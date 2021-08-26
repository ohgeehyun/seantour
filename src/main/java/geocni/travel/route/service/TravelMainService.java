package geocni.travel.route.service;

import java.util.List;

import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelMain;

public interface TravelMainService {	

	List<?> selectBeachPerCnt() throws Exception;
	
	// 16:30 인원추출
	List<?> congestionExcel() throws Exception;
	
	//혼잡도엑셀 추출
	List<?> congestionOverExcel() throws Exception;
	
	void insertBeachPer(TravelMain vo) throws Exception;
	
	List<?> selectBeachInfo() throws Exception;
	
	List<?> selectBeachPerCntapi(String date) throws Exception;
	
	List<?> selectBeachDay() throws Exception;
	
	List<?> newselectBeachPerCnt() throws Exception;
	
	List<?> selectCongestion() throws Exception;

	List<?> selectBeachPerCntInsert() throws Exception;
	
	List<?> selectTravelMainDestination(TravelMain travelMain) throws Exception;
	
	List<?>selectTravelDestinationApi(TravelDestination traveldestination) throws Exception;
	
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
