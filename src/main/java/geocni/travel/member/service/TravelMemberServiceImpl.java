package geocni.travel.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.member.dao.TravelMemberDAO;
import geocni.travel.member.domain.TravelClipboard;
import geocni.travel.member.domain.TravelFameHistory;
import geocni.travel.member.domain.TravelFamePoint;
import geocni.travel.member.domain.TravelReaction;

@Service("travelMemberService")
public class TravelMemberServiceImpl extends EgovAbstractServiceImpl implements TravelMemberService {

    @SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(TravelMemberServiceImpl.class);

    @Resource(name="travelMemberDAO")
    private TravelMemberDAO travelMemberDAO;
    
    @Resource(name="travelFameHisIdGnrService")
    private EgovIdGnrService fameHisIdGnrService;

    @Resource(name="travelClipIdGnrService")
    private EgovIdGnrService clipIdGnrService;
    
    @Resource(name="travelReactionIdGnrService")
    private EgovIdGnrService reactionIdGnrService;
    
    @Resource(name="egovMessageSource")
	private EgovMessageSource msgSrc;

	/*
	 * 명성 랭킹
	 * */
	@Override
	public Map<String, Object> selectTravelFamePointListMap(TravelFamePoint vo) throws Exception {
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	
    	PaginationInfo paginationInfo = makePagination(vo);
    	
    	int totCnt = travelMemberDAO.selectTravelFamePointListCnt(vo);
    	paginationInfo.setTotalRecordCount(totCnt);
    	resultMap.put("paginationInfo", paginationInfo);
    	vo.setPageUnit(totCnt);
    	
    	@SuppressWarnings("unchecked")
		List<TravelFamePoint> list = (List<TravelFamePoint>) travelMemberDAO.selectTravelFamePointList(vo);
    	
    	resultMap.put("resultList", list);
    	
    	int allCnt = travelMemberDAO.selectTravelFamePointListCnt(vo);
    	resultMap.put("allCnt", allCnt);

    	return resultMap;
    }

	@Override
	public List<?> selectTravelFamePointList(TravelFamePoint vo) throws Exception {
    	return travelMemberDAO.selectTravelFamePointList(vo);
	}

	@Override
	public int selectTravelFamePointListCnt(TravelFamePoint vo) throws Exception {
    	return travelMemberDAO.selectTravelFamePointListCnt(vo);
	}

	@Override
	public TravelFamePoint selectTravelFamePoint(String fameUserId) throws Exception {
    	return travelMemberDAO.selectTravelFamePoint(fameUserId);
	}

	@Override
	public void upsertTravelFamePoint(TravelFamePoint vo) throws Exception {
		travelMemberDAO.upsertTravelFamePoint(vo);
	}

	@Override
	public void upsertTravelFamePointByReco(TravelFamePoint vo) throws Exception {
		travelMemberDAO.upsertTravelFamePointByReco(vo);
	}
	
	@Override
	public void upsertTravelFamePointByShare(TravelFamePoint vo) throws Exception {
		travelMemberDAO.upsertTravelFamePointByShare(vo);
	}
	
	@Override
	public void updateTravelFamePointRanking() throws Exception {
		travelMemberDAO.updateTravelFamePointRanking();
	}

	/*@Override
	public void updateTravelFamePoint(TravelFamePoint vo) throws Exception {
		travelMemberDAO.updateTravelFamePoint(vo);
	}*/
	
	@Override
	public void deleteTravelFamePointPhysically(TravelFamePoint vo) throws Exception {
		travelMemberDAO.deleteTravelFamePointPhysically(vo);
	}

	
	/*
	 * 명성 지수
	 * */
	@Override
	public Map<String, Object> selectTravelFameHistoryListMap(TravelFameHistory vo) throws Exception {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		PaginationInfo paginationInfo = makePagination(vo);
		
		int totCnt = travelMemberDAO.selectTravelFameHistoryListCnt(vo);
		paginationInfo.setTotalRecordCount(totCnt);
		resultMap.put("paginationInfo", paginationInfo);
		vo.setPageUnit(totCnt);
		
		@SuppressWarnings("unchecked")
		List<TravelFameHistory> list = (List<TravelFameHistory>) travelMemberDAO.selectTravelFameHistoryList(vo);
		
		/*List<TravelFameHistory> resultList = new ArrayList<TravelFameHistory>();
    	TravelFameHistory route;
    	TravelDestination destination = new TravelDestination();
		Iterator<TravelFameHistory> iter = list.iterator();
		while (iter.hasNext()) {
			route = (TravelFameHistory)iter.next();
			
			if(!NullUtil.isEmpty(route.getRoutDescription())) {
				String[] descList = route.getRoutDescription().split("[|]");
				
				List<TravelDestination> lst = new ArrayList<TravelDestination>();
				for(int i=0;descList.length > i ;i++){
					destination.setDestId(descList[i]);
					destination = travelDestinationDAO.selectTravelDestination(destination);
					lst.add(destination);
					if(i==0) {
						route.setRoutImgPath(destination.getDestImgPath());
					}
				}
				route.setWayPointList(lst);
			}
			resultList.add(route);
		}
    	resultMap.put("resultList", resultList);*/
		
		resultMap.put("resultList", list);
		
		int allCnt = travelMemberDAO.selectTravelFameHistoryListCnt(vo);
		resultMap.put("allCnt", allCnt);
		
		return resultMap;
	}
	
	@Override
	public List<?> selectTravelFameHistoryList(TravelFameHistory vo) throws Exception {
		return travelMemberDAO.selectTravelFameHistoryList(vo);
	}
	
	@Override
	public int selectTravelFameHistoryListCnt(TravelFameHistory vo) throws Exception {
		return travelMemberDAO.selectTravelFameHistoryListCnt(vo);
	}
	
	@Override
	public TravelFameHistory selectTravelFameHistory(TravelFameHistory vo) throws Exception {
		return travelMemberDAO.selectTravelFameHistory(vo);
	}
	
	@Override
	public TravelFameHistory insertTravelFameHistory(TravelFameHistory vo) throws Exception {
		try {
			String id = fameHisIdGnrService.getNextStringId();
			vo.setFameHisId(id);
			
			//명성 적립 내역 추가
			travelMemberDAO.insertTravelFameHistory(vo);
			
			//명성 지수 정보 업데이트
			TravelFamePoint point = new TravelFamePoint();
			point.setFameUserId(vo.getFameHisRecUser());
			point.setFamePointSum(vo.getFameHisPoint());
			travelMemberDAO.upsertTravelFamePointByReco(point);
			
			//명성 랭킹 업데이트
			travelMemberDAO.updateTravelFamePointRanking();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	@Override
	public void updateTravelFameHistory(TravelFameHistory vo) throws Exception {
		travelMemberDAO.updateTravelFameHistory(vo);
	}
	
	@Override
	public void deleteTravelFameHistoryPhysically(TravelFameHistory vo) throws Exception {
		travelMemberDAO.deleteTravelFameHistoryPhysically(vo);
	}
	
	@Override
	public int selectTravelFameHistoryCntByUser(String fameHisRecUser) throws Exception {
		return travelMemberDAO.selectTravelFameHistoryCntByUser(fameHisRecUser);
	}
	
	
	/*
	 * 클립보드
	 * */
	@Override
	public Map<String, Object> selectTravelClipboardListMap(TravelClipboard vo) throws Exception {
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	
    	PaginationInfo paginationInfo = makePagination(vo);
    	
    	int totCnt = travelMemberDAO.selectTravelClipboardListCnt(vo);
    	paginationInfo.setTotalRecordCount(totCnt);
    	resultMap.put("paginationInfo", paginationInfo);
    	vo.setPageUnit(totCnt);
    	
    	@SuppressWarnings("unchecked")
		List<TravelClipboard> list = (List<TravelClipboard>) travelMemberDAO.selectTravelClipboardList(vo);
    	
    	resultMap.put("resultList", list);
    	
    	//int allCnt = travelMemberDAO.selectTravelClipboardListCnt(vo);
    	//resultMap.put("allCnt", allCnt);
    	resultMap.put("allCnt", totCnt);

    	return resultMap;
    }

	@Override
	public List<?> selectTravelClipboardList(TravelClipboard vo) throws Exception {
    	return travelMemberDAO.selectTravelClipboardList(vo);
	}

	@Override
	public int selectTravelClipboardListCnt(TravelClipboard vo) throws Exception {
    	return travelMemberDAO.selectTravelClipboardListCnt(vo);
	}

	public Map<String, Object> selectTravelClipDestinationListMap(TravelClipboard vo) throws Exception {
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	
    	PaginationInfo paginationInfo = makePagination(vo);
    	
    	int totCnt = travelMemberDAO.selectTravelClipDestinationListCnt(vo);
    	paginationInfo.setTotalRecordCount(totCnt);
    	resultMap.put("paginationInfo", paginationInfo);
    	vo.setPageUnit(totCnt);
    	
    	@SuppressWarnings("unchecked")
		List<TravelClipboard> list = (List<TravelClipboard>) travelMemberDAO.selectTravelClipDestinationList(vo);
    	
    	resultMap.put("resultList", list);
    	
    	resultMap.put("allCnt", totCnt);

    	return resultMap;
    }

	@Override
	public List<?> selectTravelClipDestinationList(TravelClipboard vo) throws Exception {
		return travelMemberDAO.selectTravelClipDestinationList(vo);
	}
	
	@Override
	public int selectTravelClipDestinationListCnt(TravelClipboard vo) throws Exception {
		return travelMemberDAO.selectTravelClipDestinationListCnt(vo);
	}
	
	@Override
	public TravelClipboard selectTravelClipboard(TravelClipboard vo) throws Exception {
    	return travelMemberDAO.selectTravelClipboard(vo);
	}

	@Override
	public TravelClipboard insertTravelClipboard(TravelClipboard vo) throws Exception {
    	try {
			String id = clipIdGnrService.getNextStringId();
			vo.setClipId(id);

			travelMemberDAO.insertTravelClipboard(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	@Override
	public void updateTravelClipboard(TravelClipboard vo) throws Exception {
		travelMemberDAO.updateTravelClipboard(vo);
	}

	@Override
	public void deleteTravelClipboardPhysically(TravelClipboard vo) throws Exception {
		travelMemberDAO.deleteTravelClipboardPhysically(vo);
	}

	@Override
	public int selectTravelClipboardCnt(TravelClipboard vo) throws Exception {
		return travelMemberDAO.selectTravelClipboardCnt(vo);
	}
	
	@Override
	public void deleteclipboard(TravelClipboard vo)throws Exception{
		travelMemberDAO.deleteclipboard(vo);
	}
	
	
	/*
	 * 리액션
	 * */
	@Override
	public Map<String, Object> selectTravelReactionListMap(TravelReaction vo) throws Exception {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		PaginationInfo paginationInfo = makePagination(vo);
		
		int totCnt = travelMemberDAO.selectTravelReactionListCnt(vo);
		paginationInfo.setTotalRecordCount(totCnt);
		resultMap.put("paginationInfo", paginationInfo);
		vo.setPageUnit(totCnt);
		
		@SuppressWarnings("unchecked")
		List<TravelReaction> list = (List<TravelReaction>) travelMemberDAO.selectTravelReactionList(vo);
		
		/*List<TravelReaction> resultList = new ArrayList<TravelReaction>();
    	TravelReaction route;
    	TravelDestination destination = new TravelDestination();
		Iterator<TravelReaction> iter = list.iterator();
		while (iter.hasNext()) {
			route = (TravelReaction)iter.next();
			
			if(!NullUtil.isEmpty(route.getRoutDescription())) {
				String[] descList = route.getRoutDescription().split("[|]");
				
				List<TravelDestination> lst = new ArrayList<TravelDestination>();
				for(int i=0;descList.length > i ;i++){
					destination.setDestId(descList[i]);
					destination = travelDestinationDAO.selectTravelDestination(destination);
					lst.add(destination);
					if(i==0) {
						route.setRoutImgPath(destination.getDestImgPath());
					}
				}
				route.setWayPointList(lst);
			}
			resultList.add(route);
		}
    	resultMap.put("resultList", resultList);*/
		
		resultMap.put("resultList", list);
		
		int allCnt = travelMemberDAO.selectTravelReactionListCnt(vo);
		resultMap.put("allCnt", allCnt);
		
		return resultMap;
	}
	
	@Override
	public List<?> selectTravelReactionList(TravelReaction vo) throws Exception {
		return travelMemberDAO.selectTravelReactionList(vo);
	}
	
	@Override
	public int selectTravelReactionListCnt(TravelReaction vo) throws Exception {
		return travelMemberDAO.selectTravelReactionListCnt(vo);
	}
	
	@Override
	public TravelReaction selectTravelReaction(TravelReaction vo) throws Exception {
		return travelMemberDAO.selectTravelReaction(vo);
	}
	
	@Override
	public TravelReaction insertTravelReaction(TravelReaction vo) throws Exception {
		try {
			String id = reactionIdGnrService.getNextStringId();
			vo.setRxnId(id);
			
			travelMemberDAO.insertTravelReaction(vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	@Override
	public void updateTravelReaction(TravelReaction vo) throws Exception {
		travelMemberDAO.updateTravelReaction(vo);
	}
	
	@Override
	public void deleteTravelReactionPhysically(TravelReaction vo) throws Exception {
		travelMemberDAO.deleteTravelReactionPhysically(vo);
	}
	
	@Override
	public int selectTravelReactionCnt(TravelReaction vo) throws Exception {
		return travelMemberDAO.selectTravelReactionCnt(vo);
	}
	@Override
	public void  deleteLike(TravelReaction vo) throws Exception {
		travelMemberDAO.deleteLike(vo);
	}
	
	private PaginationInfo makePagination(TravelDefaultVO vo) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getPageIndex());
		paginationInfo.setRecordCountPerPage(vo.getPageUnit());
		paginationInfo.setPageSize(vo.getPageSize());
		
		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		return paginationInfo;
	}
	
}

