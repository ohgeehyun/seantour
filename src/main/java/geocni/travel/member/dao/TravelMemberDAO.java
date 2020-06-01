package geocni.travel.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import geocni.travel.member.domain.TravelClipboard;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.domain.TravelFameHistory;

@Repository("travelMemberDAO")
public class TravelMemberDAO extends EgovComAbstractDAO {

	/*
	 * 명성 랭킹
	 * */
    public List<?> selectTravelFamePointList(TravelFamePoint vo) throws Exception {
    	return list("travelMemberDAO.selectTravelFamePointList", vo);
    }
    
    public int selectTravelFamePointListCnt(TravelFamePoint vo) {
    	return (Integer)select("travelMemberDAO.selectTravelFamePointListCnt", vo);
    }
    
    public TravelFamePoint selectTravelFamePoint(String fameUserId) throws Exception {
    	return (TravelFamePoint)select("travelMemberDAO.selectTravelFamePoint", fameUserId);
    }
    
    public void upsertTravelFamePoint(TravelFamePoint vo) throws Exception {
    	insert("travelMemberDAO.upsertTravelFamePoint", vo);
    }
    
    /*public void updateTravelFamePoint(TravelFamePoint vo) throws Exception {
    	update("travelMemberDAO.updateTravelFamePoint", vo);
    }*/
    
    public void deleteTravelFamePointPhysically(TravelFamePoint vo) throws Exception {
    	delete("travelMemberDAO.deleteTravelFamePointPhysically", vo);
    }

    
    /*
     * 명성 지수
     * */
    public List<?> selectTravelFameHistoryList(TravelFameHistory vo) throws Exception {
    	return list("travelMemberDAO.selectTravelFameHistoryList", vo);
    }
    
    public int selectTravelFameHistoryListCnt(TravelFameHistory vo) {
    	return (Integer)select("travelMemberDAO.selectTravelFameHistoryListCnt", vo);
    }
    
    public TravelFameHistory selectTravelFameHistory(TravelFameHistory vo) throws Exception {
    	return (TravelFameHistory)select("travelMemberDAO.selectTravelFameHistory", vo);
    }
    
    public String insertTravelFameHistory(TravelFameHistory vo) throws Exception {
    	return (String)insert("travelMemberDAO.insertTravelFameHistory", vo);
    }
    
    public void updateTravelFameHistory(TravelFameHistory vo) throws Exception {
    	update("travelMemberDAO.updateTravelFameHistory", vo);
    }
    
    public void deleteTravelFameHistoryPhysically(TravelFameHistory vo) throws Exception {
    	delete("travelMemberDAO.deleteTravelFameHistoryPhysically", vo);
    }
        
    
	/*
	 * 클립보드
	 * */
    public List<?> selectTravelClipboardList(TravelClipboard vo) throws Exception {
    	return list("travelMemberDAO.selectTravelClipboardList", vo);
    }
    
    public int selectTravelClipboardListCnt(TravelClipboard vo) {
    	return (Integer)select("travelMemberDAO.selectTravelClipboardListCnt", vo);
    }
    
    public TravelClipboard selectTravelClipboard(TravelClipboard vo) throws Exception {
    	return (TravelClipboard)select("travelMemberDAO.selectTravelClipboard", vo);
    }
    
    public String insertTravelClipboard(TravelClipboard vo) throws Exception {
    	return (String)insert("travelMemberDAO.insertTravelClipboard", vo);
    }
    
    public void updateTravelClipboard(TravelClipboard vo) throws Exception {
    	update("travelMemberDAO.updateTravelClipboard", vo);
    }
    
    public void deleteTravelClipboardPhysically(TravelClipboard vo) throws Exception {
    	delete("travelMemberDAO.deleteTravelClipboardPhysically", vo);
    }

}
