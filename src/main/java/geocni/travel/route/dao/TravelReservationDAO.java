package geocni.travel.route.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import geocni.travel.route.domain.TravelReservation;

@Repository("travelReservationDAO")
public class TravelReservationDAO extends EgovComAbstractDAO {
	public List<?> selectTravelReservationRegionList(TravelReservation vo) throws Exception {
		return list("travelReservationDAO.selectTravelReservationRegionList", vo);
	}

	public List<?> selectTravelReservationBeachList(TravelReservation vo) throws Exception {
		return list("travelReservationDAO.selectTravelReservationBeachList", vo);
	}

	public String selectTravelOpenYn(TravelReservation vo) throws Exception {
		return (String)select("travelReservationDAO.selectTravelOpenYn", vo);
	}

	public String selectTravelReservationYn(TravelReservation vo) throws Exception {
		return (String)select("travelReservationDAO.selectTravelReservationYn", vo);
	}

	public String selectTravelReservationDuplYn(TravelReservation vo) throws Exception {
		return (String)select("travelReservationDAO.selectTravelReservationDuplYn", vo);
	}
	
	public String insertTravelReservation(TravelReservation vo) throws Exception {
		return (String)insert("travelReservationDAO.insertTravelReservation", vo);
	}
	
	public String deleteTravelReservation(TravelReservation vo) throws Exception {
		return (String)insert("travelReservationDAO.deleteTravelReservation", vo);
	}
	
	public List<?> selectTravelReservationViewList(TravelReservation vo) throws Exception {
		return list("travelReservationDAO.selectTravelReservationViewList", vo);
	}

	public String selectTravelReservationAdmin(TravelReservation vo) throws Exception {
		return (String)select("travelReservationDAO.selectTravelReservationAdmin", vo);
	}
	
	public List<?> selectTravelReservationList(TravelReservation vo) throws Exception {
		return list("travelReservationDAO.selectTravelReservationList", vo);
	}
	
	public int selectTravelReservationListCnt(TravelReservation vo) {
    	return (Integer)select("travelReservationDAO.selectTravelReservationListCnt", vo);
    }
}
