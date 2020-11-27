package geocni.travel.route.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import geocni.travel.route.dao.TravelApiDAO;



@Service("travelApiService")
public  class TravelApiServiceImpl extends EgovAbstractServiceImpl implements TravelApiService {
	
	
	@Resource(name="travelApiDAO")
    private TravelApiDAO travelApiDAO;
    
    @Override
	public List<?> selectTravelDestinationApi() throws Exception {
		return travelApiDAO.selectTravelDestinationApi();
	}
	
    @Override
  	public List<?> selectTravelrouteApi() throws Exception {
  		return travelApiDAO.selectTravelrouteApi();
  	}
  	
    @Override
  	public List<?> selectTravelroutedailyApi() throws Exception {
  		return travelApiDAO.selectTravelroutedailyApi();
  	}
    
    @Override
  	public List<?> selectTravelareacodeApi() throws Exception {
  		return travelApiDAO.selectTravelareacodeApi();
  	}
  	
    @Override
  	public List<?> selectTravelcontentApi() throws Exception {
  		return travelApiDAO.selectTravelcontentApi();
  	}
    
    @Override
  	public List<?> selectTravelbanfiltersApi() throws Exception {
  		return travelApiDAO.selectTravelbanfiltersApi();
  	}
    
    @Override
  	public List<?> selectTravelclipboardApi() throws Exception {
  		return travelApiDAO.selectTravelclipboardApi();
  	}
    
    @Override
  	public List<?> selectTravelfamehistoryApi() throws Exception {
  		return travelApiDAO.selectTravelfamehistoryApi();
  	}
    
    @Override
  	public List<?> selectTravelfamepointApi() throws Exception {
  		return travelApiDAO.selectTravelfamepointApi();
  	}
    
    @Override
  	public List<?> selectTravelimgfilesApi() throws Exception {
  		return travelApiDAO.selectTravelimgfilesApi();
  	}
    
    @Override
  	public List<?> selectTravelreactionApi() throws Exception {
  		return travelApiDAO.selectTravelreactionApi();
  	}
  	
  	

}
