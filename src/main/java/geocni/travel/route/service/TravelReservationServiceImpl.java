package geocni.travel.route.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.route.dao.TravelReservationDAO;
import geocni.travel.route.domain.TravelReservation;

@Service("travelReservationService")
public class TravelReservationServiceImpl extends EgovAbstractServiceImpl implements TravelReservationService {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(TravelReservationServiceImpl.class);

	@Resource(name="travelReservationDAO")
	private TravelReservationDAO travelReservationDAO;
	
	@Override
	public List<?> selectTravelReservationRegionList(TravelReservation vo) throws Exception {
		return travelReservationDAO.selectTravelReservationRegionList(vo);
	}
	
	@Override
	public List<?> selectTravelReservationBeachList(TravelReservation vo) throws Exception {
		return travelReservationDAO.selectTravelReservationBeachList(vo);
	}
	
	@Override
	public String selectTravelOpenYn(TravelReservation vo) throws Exception {
		return travelReservationDAO.selectTravelOpenYn(vo);
	}
	
	@Override
	public String selectTravelReservationYn(TravelReservation vo) throws Exception {
		return travelReservationDAO.selectTravelReservationYn(vo);
	}
	
	@Override
	public String selectTravelReservationPossCnt(TravelReservation vo) throws Exception {
		return travelReservationDAO.selectTravelReservationPossCnt(vo);
	}
	
	@Override
	public String selectTravelReservationDuplYn(TravelReservation vo) throws Exception {
		return travelReservationDAO.selectTravelReservationDuplYn(vo);
	}
	
	@Override
	public String insertTravelReservation(TravelReservation vo) throws Exception {
		travelReservationDAO.insertTravelReservation(vo);
		return "";
	}
	
	@Override
	public String deleteTravelReservation(TravelReservation vo) throws Exception {
		travelReservationDAO.deleteTravelReservation(vo);
		return "";
	}
	
	@Override
	public List<?> selectTravelReservationViewList(TravelReservation vo) throws Exception {
		return travelReservationDAO.selectTravelReservationViewList(vo);
	}
	
	@Override
	public String selectTravelReservationAdmin(TravelReservation vo) throws Exception {
		return travelReservationDAO.selectTravelReservationAdmin(vo);
	}
	
	@Override
	public Map<String, Object> selectTravelReservationList(TravelReservation vo) throws Exception {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		PaginationInfo paginationInfo = makePagination(vo);
		
		int totCnt = travelReservationDAO.selectTravelReservationListCnt(vo);
    	paginationInfo.setTotalRecordCount(totCnt);
    	resultMap.put("paginationInfo", paginationInfo);
    	
    	List<TravelReservation> list = (List<TravelReservation>) travelReservationDAO.selectTravelReservationList(vo);
    	resultMap.put("reseList", list);
    	
		return resultMap;
	}
	
	
	@Override
	public Map<String, Object> selectBeachManagementList(TravelReservation vo) throws Exception {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
    	List<TravelReservation> blist = (List<TravelReservation>) travelReservationDAO.selectBeachManagementList(vo);
    	resultMap.put("bList", blist);
    	
		return resultMap;
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
