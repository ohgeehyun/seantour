package geocni.travel.route.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import geocni.travel.common.TravelDefaultVO;
import geocni.travel.common.files.domain.TravelFiles;
import geocni.travel.common.files.service.TravelFilesService;
import geocni.travel.route.dao.TravelDestinationDAO;
import geocni.travel.route.domain.TravelDestination;

@Service("travelDestinationService")
public class TravelDestinationServiceImpl extends EgovAbstractServiceImpl implements TravelDestinationService {

    @SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(TravelDestinationServiceImpl.class);

    @Resource(name="travelDestinationDAO")
    private TravelDestinationDAO travelDestinationDAO;
    
    @Resource(name="travelDestIdGnrService")    
    private EgovIdGnrService destIdGnrService;

    /*@Resource(name="travelFileIdGnrService")    
    private EgovIdGnrService travelFileIdGnrService;*/
    
    @Resource(name = "travelFilesService")
    private TravelFilesService travelFilesService;
    
    @Resource(name="egovMessageSource")
	private EgovMessageSource msgSrc;

	@Override
	public Map<String, Object> selectTravelDestinationListMap(TravelDestination vo) throws Exception {
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	
    	PaginationInfo paginationInfo = makePagination(vo);
    	
    	int totCnt = travelDestinationDAO.selectTravelDestinationListCnt(vo);
    	paginationInfo.setTotalRecordCount(totCnt);
    	resultMap.put("paginationInfo", paginationInfo);
    	vo.setPageUnit(totCnt);
    	
    	//List<?> resultList = travelDestinationDAO.selectTravelDestinationList(vo);
    	@SuppressWarnings("unchecked")
		List<TravelDestination> list = (List<TravelDestination>) travelDestinationDAO.selectTravelDestinationList(vo);
    	
    	resultMap.put("resultList", list);
    	
    	int allCnt = travelDestinationDAO.selectTravelDestinationListCnt(vo);
    	resultMap.put("allCnt", allCnt);

    	return resultMap;
    }
	
	@Override
	public Map<String, Object> selectTravelDestinationSummerListMap(TravelDestination vo) throws Exception {
    	Map<String,Object> resultMap = new HashMap<String,Object>();
    	
    	PaginationInfo paginationInfo = makePagination(vo);
    	
    	int totCnt = travelDestinationDAO.selectTravelDestinationSummerListCnt(vo);
    	paginationInfo.setTotalRecordCount(totCnt);
    	resultMap.put("paginationInfo", paginationInfo);
    	vo.setPageUnit(totCnt);
    	
    	//List<?> resultList = travelDestinationDAO.selectTravelDestinationList(vo);
    	@SuppressWarnings("unchecked")
		List<TravelDestination> list = (List<TravelDestination>) travelDestinationDAO.selectTravelDestinationSummerList(vo);
    	
    	resultMap.put("resultList", list);
    	
    	int allCnt = travelDestinationDAO.selectTravelDestinationSummerListCnt(vo);
    	resultMap.put("allCnt", allCnt);

    	return resultMap;
    }

	@Override
	public List<?> selectTravelDestinationList(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestinationList(vo);
	}
	@Override
	public List<?> selectRecoDestinationlist(TravelDestination vo) throws Exception{
		return travelDestinationDAO.selectRecoDestinationlist(vo);
	}
	
	@Override
	public int selectTravelDestinationListCnt(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestinationListCnt(vo);
	}

	@Override
	public TravelDestination selectTravelDestination(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestination(vo);
	}

	@Override
	public TravelDestination selectTravelDestinationDetail(TravelDestination vo) throws Exception {
		return travelDestinationDAO.selectTravelDestinationDetail(vo);
	}
	
	@Override
	public String insertTravelDestination(TravelDestination vo) throws Exception {
		String id = destIdGnrService.getNextStringId();
		vo.setDestId(id);
		travelDestinationDAO.insertTravelDestination(vo);
    	return id;
	}
	
	@Override
	public String insertTravelDestination(TravelDestination vo, HashMap<String, EgovFormBasedFileVo> files) throws Exception {
    	String id = this.insertTravelDestination(vo);

    	if(!files.isEmpty()) {
	    	List<TravelFiles> fileList = new ArrayList<>();
			String uploadDir = "/upload/travel/destination";
	    	Iterator<String> keys = files.keySet().iterator();
	    	int serialNo = 0;
	        while(keys.hasNext()) {
	            String key = keys.next();
	
	            EgovFormBasedFileVo fileVo = files.get(key);
	            String filePathUrl = uploadDir+"/"+fileVo.getPhysicalName();
//	            int serialNo = Integer.valueOf(key.split("_")[1]);
	            
	        	TravelFiles travelFile = new TravelFiles();
	        	travelFile.setImgRefId(id);
	        	travelFile.setImgFileNo(serialNo);
	        	travelFile.setImgFileName(fileVo.getFileName());
	        	travelFile.setImgFilePath(filePathUrl);
	        	travelFile.setImgFileSize(fileVo.getSize());
	        	travelFile.setImgFileExt(fileVo.getContentType());
	        	fileList.add(travelFile);
	        	
	        	serialNo++;
	        }
	        if(fileList.size() > 0) {
	        	travelFilesService.insertTravelFiles(fileList);
	        }
    	}
    	
    	return id;
	}

	@Override
	public void updateTravelDestination(TravelDestination vo) throws Exception {
		travelDestinationDAO.updateTravelDestination(vo);
	}

	@Override
	public void updateTravelDestinationStatPoint(TravelDestination vo) throws Exception {
		travelDestinationDAO.updateTravelDestinationStatPoint(vo);
	}
	
	@Override
	public void deleteTravelDestinationPhysically(TravelDestination vo) throws Exception {
		travelDestinationDAO.deleteTravelDestinationPhysically(vo);
	}

	@Override
	public List<?> selectTravelDestinationRegionList(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestinationRegionList(vo);
	}

	@Override
	public Map<String, List<String>> selectTravelDestiCategoryList(List<String> searchCatList) throws Exception {
		@SuppressWarnings("unchecked")
		List<Map<String,String>> catList = (List<Map<String, String>>) travelDestinationDAO.selectTravelDestiCategoryList(searchCatList);

		Map<String, List<String>> newCateList = new HashMap<String,List<String>>();
		List<String> list = new ArrayList<String>();

		for (Map<String,String> map : catList) {
			String name = map.get("dest_category");
			String val = map.get("dest_tag");
			if(!newCateList.containsKey(name)) {
				list = new ArrayList<String>();
			}
			list.add(val);
			newCateList.put(name, list);

		}

		return newCateList;
	}

	@Override
	public Map<String,Integer> selectTravelDestinationStatsByTag(TravelDestination vo) throws Exception {
		@SuppressWarnings("unchecked")
		List<TravelDestination> list = (List<TravelDestination>) travelDestinationDAO.selectTravelDestinationStats(vo);
		TravelDestination desti;
		Iterator<TravelDestination> iter = list.iterator();
		Map<String,Integer> tagMap = new HashMap<String,Integer>();
		while (iter.hasNext()) {
			desti = (TravelDestination)iter.next();
			
			if(desti.getDestTag() != null && !"".equals(desti.getDestTag())) {
				String tag = desti.getDestTag(); 
				if(tagMap.containsKey(tag)) {
					tagMap.put(tag, tagMap.get(tag) + 1);
				} else {
					tagMap.put(tag, 1);
				}
			}
		}
		
		return tagMap;
	}
	
	@Override
	public Map<String, Object> selectTravelDestinationStatsBySeason(TravelDestination vo) throws Exception {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		vo.setRecordCountPerPage(5);
		
		vo.setDestSeason("봄");
		List<?> springList = travelDestinationDAO.selectTravelDestinationStats(vo);
		resultMap.put("springList",	springList);
		
		vo.setDestSeason("여름");
		List<?> summerList = travelDestinationDAO.selectTravelDestinationStats(vo);
		resultMap.put("summerList",	summerList);
		
		vo.setDestSeason("가을");
		List<?> autumnList = travelDestinationDAO.selectTravelDestinationStats(vo);
		resultMap.put("autumnList",	autumnList);
		
		vo.setDestSeason("겨울");
		List<?> winterList = travelDestinationDAO.selectTravelDestinationStats(vo);
		resultMap.put("winterList",	winterList);
		
		vo.setDestSeason(null);
		vo.setDestRegion("경기");
		@SuppressWarnings("unchecked")
		List<TravelDestination> initRegion = (List<TravelDestination>) travelDestinationDAO.selectTravelDestinationStats(vo);
		resultMap.put("initRegion",	initRegion.size() > 0 ? initRegion.get(0) : null);
		
		return resultMap;
	}
	
	@Override
	public TravelDestination selectTravelDestinationStatsByRegion(TravelDestination vo) throws Exception {
		TravelDestination initRegion = new TravelDestination();
		@SuppressWarnings("unchecked")
		List<TravelDestination> initRegionList = (List<TravelDestination>) travelDestinationDAO.selectTravelDestinationStats(vo);
		if(initRegionList != null && initRegionList.size() > 0) {
			initRegion = initRegionList.get(0);
		}
		return initRegion;
	}
	
	@Override
	public List<?> selectTravelDestinationNearPointList(TravelDestination vo) throws Exception {
    	return travelDestinationDAO.selectTravelDestinationNearPointList(vo);
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

