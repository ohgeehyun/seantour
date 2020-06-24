package geocni.travel.route.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import geocni.travel.route.domain.TravelDestination;

@Repository("travelDestinationDAO")
public class TravelDestinationDAO extends EgovComAbstractDAO {

    public List<?> selectTravelDestinationList(TravelDestination vo) throws Exception {
    	return list("travelDestinationDAO.selectTravelDestinationList", vo);
    }
    
    public List<?> selectTravelDestinationSummerList(TravelDestination vo) throws Exception {
    	return list("travelDestinationDAO.selectTravelDestinationSummerList", vo);
    }
    
    public int selectTravelDestinationListCnt(TravelDestination vo) {
    	return (Integer)select("travelDestinationDAO.selectTravelDestinationListCnt", vo);
    }
    
    public int selectTravelDestinationSummerListCnt(TravelDestination vo) {
    	return (Integer)select("travelDestinationDAO.selectTravelDestinationSummerListCnt", vo);
    }
    public TravelDestination selectTravelDestination(TravelDestination vo) throws Exception {
    	return (TravelDestination) select("travelDestinationDAO.selectTravelDestination", vo);
    }
    
    public TravelDestination selectTravelDestinationDetail(TravelDestination vo) throws Exception {
    	return (TravelDestination) select("travelDestinationDAO.selectTravelDestinationDetail", vo);
    }
    
    public String insertTravelDestination(TravelDestination vo) throws Exception {
    	return (String)insert("travelDestinationDAO.insertTravelDestination", vo);
    }
    
    public void updateTravelDestination(TravelDestination vo) throws Exception {
    	update("travelDestinationDAO.updateTravelDestination", vo);
    }
    
    public void updateTravelDestinationStatPoint(TravelDestination vo) throws Exception {
    	update("travelDestinationDAO.updateTravelDestinationStatPoint", vo);
    }
    
    public void deleteTravelDestinationPhysically(TravelDestination vo) throws Exception {
    	delete("travelDestinationDAO.deleteTravelDestinationPhysically", vo);
    }

    /*public void deleteTravelDestinationLogically(TravelDestination vo) throws Exception {
    	update("travelDestinationDAO.deleteTravelDestinationLogically", vo);
    }*/
    
    public List<?> selectTravelDestinationRegionList(TravelDestination vo) throws Exception {
    	return list("travelDestinationDAO.selectTravelDestinationRegionList", vo);
    }
    
    public List<?> selectTravelDestiCategoryList(List<String> searchCatList) throws Exception {
    	return list("travelDestinationDAO.selectTravelDestiCategoryList", searchCatList);
    }
    
    public List<?> selectTravelDestinationStats(TravelDestination vo) throws Exception {
    	return list("travelDestinationDAO.selectTravelDestinationStats", vo);
    }
    
    public List<?> selectTravelDestinationNearPointList(TravelDestination vo) throws Exception {
    	return list("travelDestinationDAO.selectTravelDestinationNearPointList", vo);
    }
    
    public List<?> selectRecoDestinationlist(TravelDestination vo) throws Exception{
		return list("travelDestinationDAO.selectRecoDestinationlist",vo);
	}
    
    
}
