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
    
    public int selectTravelDestinationListCnt(TravelDestination vo) {
    	return (Integer)select("travelDestinationDAO.selectTravelDestinationListCnt", vo);
    }
    
    public TravelDestination selectTravelDestination(TravelDestination vo) throws Exception {
    	return (TravelDestination) select("travelDestinationDAO.selectTravelDestination", vo);
    }
    
    /*@SuppressWarnings("unchecked")
	public Map<String,Object> selectTravelDestinationDetails(TravelDestination vo) throws Exception {
    	return (Map<String, Object>) select("travelDestinationDAO.selectTravelDestinationDetails", vo);
    }*/
    
    public String insertTravelDestination(TravelDestination vo) throws Exception {
    	return (String)insert("travelDestinationDAO.insertTravelDestination", vo);
    }
    
    public void updateTravelDestination(TravelDestination vo) throws Exception {
    	update("travelDestinationDAO.updateTravelDestination", vo);
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
    
}
