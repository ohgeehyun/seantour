package geocni.travel.route.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import geocni.travel.route.domain.TravelDestination;
import geocni.travel.route.domain.TravelMain;

@Repository("travelMainDAO")
public class TravelMainDAO extends EgovComAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<TravelMain> selectBeachPerCnt(String datestr) throws Exception {		
		return (List<TravelMain>) list("travelMainDAO.selectBeachPerCnt", datestr);
	}
	
	@SuppressWarnings("unchecked")
	public List<TravelMain> congestionExcel() throws Exception {		
		return (List<TravelMain>) list("travelMainDAO.congestionExcel");
	}
	
	@SuppressWarnings("unchecked")
	public List<TravelMain> congestionOverExcel() throws Exception {		
		return (List<TravelMain>) list("travelMainDAO.congestionOverExcel");
	}	
	
	@SuppressWarnings("unchecked")
	public List<TravelMain> newselectBeachPerCnt(String datestr) throws Exception {		
		return (List<TravelMain>) list("travelMainDAO.newselectBeachPerCnt", datestr);
	}
	
	@SuppressWarnings("unchecked")
	public List<TravelMain> selectTravelMainDestination(TravelMain travelMain) throws Exception {		
		return (List<TravelMain>) list("travelMainDAO.selectTravelMainDestination",travelMain);
	}
	
	public void  insertBeachPer(TravelMain vo) throws Exception {		
		insert("travelMainDAO.insertBeachPer", vo);
	}
	
	public List<?> selectBeachInfo() throws Exception {		
		return  list("travelMainDAO.selectBeachInfo");
	}
	
	public List<?> selectBeachDay() throws Exception {		
		return  list("travelMainDAO.selectBeachDay");
	}
	
	public List<?> selectBeachPerCntapi(String date) throws Exception {		
		return  list("travelMainDAO.selectBeachPerCntapi", date);
	}
	
	@SuppressWarnings("unchecked")
	public List<?> selectCongestion() throws Exception {		
		return (List<TravelMain>) list("travelMainDAO.selectCongestion");
	}

	@SuppressWarnings("unchecked")
	public List<TravelMain> selectBeachPerCntInsert(String datestr) throws Exception {		
		return (List<TravelMain>) list("travelMainDAO.selectBeachPerCntInsert", datestr);
	}
	
	public int selectDataExistCnt(String substring) {
		return (int) select("travelMainDAO.selectDataExistCnt", substring);
	}
	
	public List<?> selectTravelDestinationApi(TravelDestination traveldestination) throws Exception {
		return list("travelMainDAO.selectTravelDestinationApi",traveldestination);
	}

	public List<?> selectTravelrouteApi() throws Exception {
		return list("travelMainDAO.selectTravelrouteApi");
	}

	public List<?> selectTravelrouteDailyApi() throws Exception {
		return list("travelMainDAO.selectTravelrouteDailyApi");
	}

//
//    public List<?> selectTravelRouteList(TravelRoute vo) throws Exception {
////    	return list("travelRouteDAO.selectTravelRouteList", vo);
//    	return list("travelRouteDAO.selectTravelRouteListAll", vo);
//    }
//    
//    public int selectTravelRouteListCnt(TravelRoute vo) {
//    	return (Integer)select("travelRouteDAO.selectTravelRouteListCnt", vo);
//    }
//    
//    public List<?> selectTravelRouteBestList(TravelRoute vo) throws Exception {
//    	return list("travelRouteDAO.selectTravelRouteBestList", vo);
//    }
//    
//    public TravelRoute selectTravelRoute(TravelRoute vo) throws Exception {
//    	//return (TravelRoute) select("travelRouteDAO.selectTravelRoute", vo);
//    	return (TravelRoute) select("travelRouteDAO.selectTravelRouteAll", vo);
//    }
//    
//    /*public TravelRoute selectTravelRouteInfoByGroup(String routGroup) throws Exception {
//    	return (TravelRoute) select("travelRouteDAO.selectTravelRouteInfoByGroup", routGroup);
//    }*/
//    
//    /*@SuppressWarnings("unchecked")
//	public Map<String,Object> selectTravelRouteDetails(TravelRoute vo) throws Exception {
//    	return (Map<String, Object>) select("travelRouteDAO.selectTravelRouteDetails", vo);
//    }*/
//    
//    public String insertTravelRoute(TravelRoute vo) throws Exception {
//    	return (String)insert("travelRouteDAO.insertTravelRoute", vo);
//    }
//    
//    public String insertTravelRouteDaily(List<TravelRouteDaily> list) throws Exception {
//    	return (String)insert("travelRouteDAO.insertTravelRouteDaily", list);
//    }
//    
//    public void updateTravelRoute(TravelRoute vo) throws Exception {
//    	update("travelRouteDAO.updateTravelRoute", vo);
//    }
//    
//    public void updateTravelRouteOpenStatus(TravelRoute vo) throws Exception {
//    	update("travelRouteDAO.updateTravelRouteOpenStatus", vo);
//    }
//    
//    public void updateTravelRouteHitCount(String routId) throws Exception {
//    	update("travelRouteDAO.updateTravelRouteHitCount", routId);
//    }
//    
//    public void deleteTravelRoutePhysically(TravelRoute vo) throws Exception {
//    	delete("travelRouteDAO.deleteTravelRoutePhysically", vo);
//    }
//
//    public void deleteTravelRouteDaily(TravelRoute vo) throws Exception {
//    	delete("travelRouteDAO.deleteTravelRouteDaily", vo);
//    }
//    
//    public List<?> selectTravelRouteStats(Integer recordCountPerPage) throws Exception {
//    	return list("travelRouteDAO.selectTravelRouteStats", recordCountPerPage);
//    }
//    
//    /*public void deleteTravelRouteLogically(TravelRoute vo) throws Exception {
//    	update("travelRouteDAO.deleteTravelRouteLogically", vo);
//    }*/
//    
//    /*public List<?> selectTravelRouteGroupList() throws Exception {
//    	return list("travelRouteDAO.selectTravelRouteGroupList");
//    }*/
    
	
}
