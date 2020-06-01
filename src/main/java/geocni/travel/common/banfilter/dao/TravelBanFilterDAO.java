package geocni.travel.common.banfilter.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import geocni.travel.common.banfilter.domain.TravelBanFilters;

@Repository("travelBanFilterDAO")
public class TravelBanFilterDAO extends EgovComAbstractDAO {

    public List<?> selectTravelBanFilterList(TravelBanFilters vo) throws Exception {
    	return list("travelBanFilterDAO.selectTravelBanFilterList", vo);
    }
    
    public int selectTravelBanFilterListCnt(TravelBanFilters vo) {
    	return (Integer)select("travelBanFilterDAO.selectTravelBanFilterListCnt", vo);
    }
    
    public int selectTravelBanFilterIncludeCnt(List<String> banWordList) throws Exception {
    	return (Integer)select("travelBanFilterDAO.selectTravelBanFilterIncludeCnt", banWordList);
    }
    
   	public String upsertTravelBanFilter(List<String> banWordList) throws Exception {
    	return (String)insert("travelBanFilterDAO.upsertTravelBanFilter", banWordList);
    }
    
    public void deleteTravelBanFilterPhysically(String delWord) throws Exception {
    	delete("travelBanFilterDAO.deleteTravelBanFilterPhysically", delWord);
    }
    
}
