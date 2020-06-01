package geocni.travel.member.service;

import java.util.List;
import java.util.Map;

import geocni.travel.member.domain.TravelClipboard;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.domain.TravelFameHistory;

public interface TravelMemberService {

	/*
	 * 명성 랭킹
	 * */
	Map<String, Object> selectTravelFamePointListMap(TravelFamePoint vo) throws Exception;

	List<?> selectTravelFamePointList(TravelFamePoint vo) throws Exception;

	int selectTravelFamePointListCnt(TravelFamePoint vo) throws Exception;

	TravelFamePoint selectTravelFamePoint(String fameUserId) throws Exception;
	
	void upsertTravelFamePoint(TravelFamePoint vo) throws Exception;

	/*void updateTravelFamePoint(TravelFamePoint vo) throws Exception;*/
	
	void deleteTravelFamePointPhysically(TravelFamePoint vo) throws Exception;

	/*
	 * 명성 지수
	 * */
	Map<String, Object> selectTravelFameHistoryListMap(TravelFameHistory vo) throws Exception;
	
	List<?> selectTravelFameHistoryList(TravelFameHistory vo) throws Exception;
	
	int selectTravelFameHistoryListCnt(TravelFameHistory vo) throws Exception;
	
	TravelFameHistory selectTravelFameHistory(TravelFameHistory vo) throws Exception;
	
	TravelFameHistory insertTravelFameHistory(TravelFameHistory vo) throws Exception;
	
	void updateTravelFameHistory(TravelFameHistory vo) throws Exception;
	
	void deleteTravelFameHistoryPhysically(TravelFameHistory vo) throws Exception;
	
	/*
	 * 클립보드
	 * */
	Map<String, Object> selectTravelClipboardListMap(TravelClipboard vo) throws Exception;

	List<?> selectTravelClipboardList(TravelClipboard vo) throws Exception;

	int selectTravelClipboardListCnt(TravelClipboard vo) throws Exception;
	
	TravelClipboard selectTravelClipboard(TravelClipboard vo) throws Exception;
	
	TravelClipboard insertTravelClipboard(TravelClipboard vo) throws Exception;

	void updateTravelClipboard(TravelClipboard vo) throws Exception;
	
	void deleteTravelClipboardPhysically(TravelClipboard vo) throws Exception;

}
