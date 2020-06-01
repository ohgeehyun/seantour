package geocni.travel.common.banfilter.service;

import java.util.List;
import java.util.Map;

import geocni.travel.common.banfilter.domain.TravelBanFilters;

public interface TravelBanFilterService {

	Map<String, Object> selectTravelBanFilterListMap(TravelBanFilters vo) throws Exception;
	
	List<?> selectTravelBanFilterList(TravelBanFilters vo) throws Exception;
	
	int selectTravelBanFilterListCnt(TravelBanFilters vo) throws Exception;
	
	int selectTravelBanFilterIncludeCnt(String sentence) throws Exception;
	
	void upsertTravelBanFilter(List<String> banWordList) throws Exception;
	
	void deleteTravelBanFilterPhysically(String delWord) throws Exception;
	
	//void deleteTravelBanFilterPhysically(List<TravelBanFilters> filterList) throws Exception;
	
}
