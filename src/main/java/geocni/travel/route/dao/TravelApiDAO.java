package geocni.travel.route.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("travelApiDAO")
public class TravelApiDAO extends EgovComAbstractDAO {

	public List<?> selectTravelDestinationApi() throws Exception {
		return list("travelApiDAO.selectTravelDestinationApi");
	}
	
	public List<?> selectTravelrouteApi() throws Exception {
		return list("travelApiDAO.selectTravelrouteApi");
	}
	
	public List<?> selectTravelroutedailyApi() throws Exception {
		return list("travelApiDAO.selectTravelroutedailyApi");
	}
	
	public List<?> selectTravelareacodeApi() throws Exception {
		return list("travelApiDAO.selectTravelareacodeApi");
	}
	
	public List<?> selectTravelcontentApi() throws Exception {
		return list("travelApiDAO.selectTravelcontentApi");
	}
	public List<?> selectTravelbanfiltersApi() throws Exception {
		return list("travelApiDAO.selectTravelbanfiltersApi");
	}
	public List<?> selectTravelclipboardApi() throws Exception {
		return list("travelApiDAO.selectTravelclipboardApi");
	}
	
	public List<?> selectTravelfamehistoryApi() throws Exception {
		return list("travelApiDAO.selectTravelfamehistoryApi");
	}

	public List<?> selectTravelfamepointApi() throws Exception {
		return list("travelApiDAO.selectTravelfamepointApi");
	}

	public List<?> selectTravelimgfilesApi() throws Exception {
		return list("travelApiDAO.selectTravelimgfilesApi");
	}

	public List<?> selectTravelreactionApi() throws Exception {
		return list("travelApiDAO.selectTravelreactionApi");
	}



}
