package geocni.travel.route.service;

import java.util.List;
import java.util.Map;

import geocni.travel.route.domain.TravelReservation;

public interface TravelReservationService {
	List<?> selectTravelReservationRegionList(TravelReservation vo) throws Exception;
	
	List<?> selectTravelReservationBeachList(TravelReservation vo) throws Exception;
	
	String selectTravelOpenYn(TravelReservation vo) throws Exception;
	
	String selectTravelReservationYn(TravelReservation vo) throws Exception;
	
	String selectTravelReservationPossCnt(TravelReservation vo) throws Exception;
	
	String selectTravelReservationDuplYn(TravelReservation vo) throws Exception;
	
	String insertTravelReservation(TravelReservation vo) throws Exception;
	
	String deleteTravelReservation(TravelReservation vo) throws Exception;
	
	List<?> selectTravelReservationViewList(TravelReservation vo) throws Exception;
	
	String selectTravelReservationAdmin(TravelReservation vo) throws Exception;
	
	Map<String, Object> selectTravelReservationList(TravelReservation vo) throws Exception;
}
