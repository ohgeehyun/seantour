package geocni.travel.common.banfilter.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.SQLException;
import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.common.banfilter.dao.TravelBanFilterDAO;
import geocni.travel.common.banfilter.domain.TravelBanFilters;

@Service("travelBanFilterService")
public class TravelBanFilterServiceImpl extends EgovAbstractServiceImpl implements TravelBanFilterService {

    @SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(TravelBanFilterServiceImpl.class);

    @Resource(name="travelBanFilterDAO")
    private TravelBanFilterDAO travelBanFilterDAO;
    
    /*@Resource(name="travelFileIdGnrService")
    private EgovIdGnrService travelFileIdGnrService;*/

    @Resource(name="egovMessageSource")
	private EgovMessageSource msgSrc;

	@Override
	public Map<String, Object> selectTravelBanFilterListMap(TravelBanFilters vo) throws Exception {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		PaginationInfo paginationInfo = makePagination(vo);
		
		int totCnt = travelBanFilterDAO.selectTravelBanFilterListCnt(vo);
		paginationInfo.setTotalRecordCount(totCnt);
		resultMap.put("paginationInfo", paginationInfo);
		vo.setPageUnit(totCnt);
		
		@SuppressWarnings("unchecked")
		List<TravelBanFilters> list = (List<TravelBanFilters>) travelBanFilterDAO.selectTravelBanFilterList(vo);
		
		/*List<TravelBanFilter> resultList = new ArrayList<TravelBanFilter>();
    	TravelBanFilter route;
    	TravelDestination destination = new TravelDestination();
		Iterator<TravelBanFilter> iter = list.iterator();
		while (iter.hasNext()) {
			route = (TravelBanFilter)iter.next();
			
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
		
		int allCnt = travelBanFilterDAO.selectTravelBanFilterListCnt(vo);
		resultMap.put("allCnt", allCnt);
		
		return resultMap;
	}
	
	@Override
	public List<?> selectTravelBanFilterList(TravelBanFilters vo) throws Exception {
		return travelBanFilterDAO.selectTravelBanFilterList(vo);
	}
	
	@Override
	public int selectTravelBanFilterListCnt(TravelBanFilters vo) throws Exception {
		return travelBanFilterDAO.selectTravelBanFilterListCnt(vo);
	}
	
	@Override
	public int selectTravelBanFilterIncludeCnt(String sentence) throws Exception {
		List<String> banWordList = this.extractWords(sentence);
		int result = travelBanFilterDAO.selectTravelBanFilterIncludeCnt(banWordList);
		return result;
	}
	
	@Override
	public void upsertTravelBanFilter(List<String> banWordList) throws Exception {
		try {

			travelBanFilterDAO.upsertTravelBanFilter(banWordList);
			
		} catch (NullPointerException e) {
			LOGGER.debug("NullPointException");
		}catch (SQLException e ) {
			LOGGER.debug("SQLException");
		}
	}
	
	@Override
	public void deleteTravelBanFilterPhysically(String delWord) throws Exception {
		travelBanFilterDAO.deleteTravelBanFilterPhysically(delWord);
	}
	
	/*@Override
	public void deleteTravelBanFilterPhysically(List<TravelBanFilters> filterList) throws Exception {
		travelBanFilterDAO.deleteTravelBanFilterPhysically(filterList);
	}*/
	
	private List<String> extractWords(String words) {
		String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z\\s]";
		String repl =words.replaceAll(match, " ");
		
		String[] words1=repl.split(("\\s+"));

		List<String> wordList = new ArrayList<>();
	    for (String string : words1) {
	    	wordList.add(string.trim().toLowerCase());
		}
	    
	    return wordList;
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

