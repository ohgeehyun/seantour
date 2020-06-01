package geocni.travel.route.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import geocni.travel.route.domain.TravelRoute;

@Repository("travelRouteDAO")
public class TravelRouteDAO extends EgovComAbstractDAO {

    public List<?> selectTravelRouteList(TravelRoute vo) throws Exception {
    	return list("travelRouteDAO.selectTravelRouteList", vo);
    }
    
    public int selectTravelRouteListCnt(TravelRoute vo) {
    	return (Integer)select("travelRouteDAO.selectTravelRouteListCnt", vo);
    }
    
    public TravelRoute selectTravelRoute(TravelRoute vo) throws Exception {
    	return (TravelRoute) select("travelRouteDAO.selectTravelRoute", vo);
    }
    
    public TravelRoute selectTravelRouteInfoByGroup(String routGroup) throws Exception {
    	return (TravelRoute) select("travelRouteDAO.selectTravelRouteInfoByGroup", routGroup);
    }
    
    /*@SuppressWarnings("unchecked")
	public Map<String,Object> selectTravelRouteDetails(TravelRoute vo) throws Exception {
    	return (Map<String, Object>) select("travelRouteDAO.selectTravelRouteDetails", vo);
    }*/
    
    public String insertTravelRoute(TravelRoute vo) throws Exception {
    	return (String)insert("travelRouteDAO.insertTravelRoute", vo);
    }
    
    public void updateTravelRoute(TravelRoute vo) throws Exception {
    	update("travelRouteDAO.updateTravelRoute", vo);
    }
    
    public void deleteTravelRoutePhysically(TravelRoute vo) throws Exception {
    	delete("travelRouteDAO.deleteTravelRoutePhysically", vo);
    }

    /*public void deleteTravelRouteLogically(TravelRoute vo) throws Exception {
    	update("travelRouteDAO.deleteTravelRouteLogically", vo);
    }*/
    
    public List<?> selectTravelRouteGroupList() throws Exception {
    	return list("travelRouteDAO.selectTravelRouteGroupList");
    }
    
}
