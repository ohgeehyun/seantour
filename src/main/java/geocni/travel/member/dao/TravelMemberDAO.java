package geocni.travel.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import geocni.travel.member.domain.TravelClipboard;
import geocni.travel.member.domain.TravelFameHistory;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.domain.TravelReaction;

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
    
    public void upsertTravelFamePointByReco(TravelFamePoint vo) throws Exception {
    	insert("travelMemberDAO.upsertTravelFamePointByReco", vo);
    }
    
    public void upsertTravelFamePointByShare(TravelFamePoint vo) throws Exception {
    	insert("travelMemberDAO.upsertTravelFamePointByShare", vo);
    }
    
    public void updateTravelFamePointRanking() throws Exception {
    	update("travelMemberDAO.updateTravelFamePointRanking");
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
        
    public int selectTravelFameHistoryCntByUser(String fameHisRecUser) {
    	return (Integer)select("travelMemberDAO.selectTravelFameHistoryCntByUser", fameHisRecUser);
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
    
    public List<?> selectTravelClipDestinationList(TravelClipboard vo) throws Exception {
    	return list("travelMemberDAO.selectTravelClipDestinationList", vo);
    }
    
    public int selectTravelClipDestinationListCnt(TravelClipboard vo) {
    	return (Integer)select("travelMemberDAO.selectTravelClipDestinationListCnt", vo);
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
    public int selectTravelClipboardCnt(TravelClipboard vo) {
    	return (Integer)select("travelMemberDAO.selectTravelClipboardCnt", vo);
    }
    public void deleteclipboard(TravelClipboard vo)throws Exception { 
    	delete("travelMemberDAO.deleteclipboard",vo);
    }
    

    /*
     * 리액션
     * */
    public List<?> selectTravelReactionList(TravelReaction vo) throws Exception {
    	return list("travelMemberDAO.selectTravelReactionList", vo);
    }
    
    public int selectTravelReactionListCnt(TravelReaction vo) {
    	return (Integer)select("travelMemberDAO.selectTravelReactionListCnt", vo);
    }
    
    public TravelReaction selectTravelReaction(TravelReaction vo) throws Exception {
    	return (TravelReaction)select("travelMemberDAO.selectTravelReaction", vo);
    }
    
    public String insertTravelReaction(TravelReaction vo) throws Exception {
    	return (String)insert("travelMemberDAO.insertTravelReaction", vo);
    }
    
    public void updateTravelReaction(TravelReaction vo) throws Exception {
    	update("travelMemberDAO.updateTravelReaction", vo);
    }
    
    public void deleteTravelReactionPhysically(TravelReaction vo) throws Exception {
    	delete("travelMemberDAO.deleteTravelReactionPhysically", vo);
    }
    
    public int selectTravelReactionCnt(TravelReaction vo) {
    	return (Integer)select("travelMemberDAO.selectTravelReactionCnt", vo);
    }
    public void deleteLike(TravelReaction vo) throws Exception {
    	delete("travelMemberDAO.deleteLike", vo);
    }
    
}
