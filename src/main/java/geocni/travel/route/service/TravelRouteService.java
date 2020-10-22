package geocni.travel.route.service;

import java.util.List;
import java.util.Map;
import java.sql.SQLException;
import geocni.travel.route.domain.TravelRoute;

public interface TravelRouteService {

	Map<String, Object> selectTravelRouteListMap(TravelRoute vo) throws Exception;

	List<?> selectTravelRouteAllListMap(TravelRoute vo) throws Exception;//백준현 모든 리스트가져오기

	List<?> selectTravelRouteList(TravelRoute vo) throws Exception;

	int selectTravelRouteListCnt(TravelRoute vo) throws Exception;
	
	List<?> selectTravelRouteBestList(TravelRoute vo) throws Exception;
	
	TravelRoute selectTravelRoute(TravelRoute vo) throws Exception;
	
	/*TravelRoute selectTravelRouteInfoByGroup(String routGroup) throws Exception;*/
	
	TravelRoute insertTravelRoute(TravelRoute vo) throws Exception;

	void updateTravelRoute(TravelRoute vo) throws Exception;
	
	void updateTravelRouteOpenStatus(TravelRoute vo) throws Exception;
	
	void updateTravelRouteHitCount(String routId) throws Exception;
	
	void deleteTravelRoutePhysically(TravelRoute vo) throws Exception;

	List<?> selectTravelRouteStats(Integer recordCountPerPage) throws Exception;

}
