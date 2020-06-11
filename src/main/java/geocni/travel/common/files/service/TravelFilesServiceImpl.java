package geocni.travel.common.files.service;

import java.io.File;
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
import geocni.travel.common.files.dao.TravelFilesDAO;
import geocni.travel.common.files.domain.TravelFiles;
import jnit.util.PathUtil;
import java.sql.SQLException;

@Service("travelFilesService")
public class TravelFilesServiceImpl extends EgovAbstractServiceImpl implements TravelFilesService {

    @SuppressWarnings("unused")
	private static final Logger LOGGER = LoggerFactory.getLogger(TravelFilesServiceImpl.class);

    @Resource(name="travelFilesDAO")
    private TravelFilesDAO travelFilesDAO;
    
    /*@Resource(name="travelFileIdGnrService")
    private EgovIdGnrService travelFileIdGnrService;*/

    @Resource(name="egovMessageSource")
	private EgovMessageSource msgSrc;

	@Override
	public Map<String, Object> selectTravelFilesListMap(TravelFiles vo) throws Exception {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		PaginationInfo paginationInfo = makePagination(vo);
		
		int totCnt = travelFilesDAO.selectTravelFilesListCnt(vo);
		paginationInfo.setTotalRecordCount(totCnt);
		resultMap.put("paginationInfo", paginationInfo);
		vo.setPageUnit(totCnt);
		
		@SuppressWarnings("unchecked")
		List<TravelFiles> list = (List<TravelFiles>) travelFilesDAO.selectTravelFilesList(vo);
		
		/*List<TravelFiles> resultList = new ArrayList<TravelFiles>();
    	TravelFiles route;
    	TravelDestination destination = new TravelDestination();
		Iterator<TravelFiles> iter = list.iterator();
		while (iter.hasNext()) {
			route = (TravelFiles)iter.next();
			
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
		
		int allCnt = travelFilesDAO.selectTravelFilesListCnt(vo);
		resultMap.put("allCnt", allCnt);
		
		return resultMap;
	}
	
	@Override
	public List<?> selectTravelFilesList(TravelFiles vo) throws Exception {
		return travelFilesDAO.selectTravelFilesList(vo);
	}
	
	@Override
	public int selectTravelFilesListCnt(TravelFiles vo) throws Exception {
		return travelFilesDAO.selectTravelFilesListCnt(vo);
	}
	
	@Override
	public TravelFiles selectTravelFiles(TravelFiles vo) throws Exception {
		return travelFilesDAO.selectTravelFiles(vo);
	}
	
	@Override
	public void insertTravelFiles(List<TravelFiles> fileList) throws Exception {
		try {

			travelFilesDAO.insertTravelFiles(fileList);
			
		} catch (NullPointerException e) {
			LOGGER.debug("NullPointException");
		} catch (SQLException e) {
			LOGGER.debug("SQLException");
		}
	}
	
	@Override
	public void updateTravelFiles(TravelFiles vo) throws Exception {
		travelFilesDAO.updateTravelFiles(vo);
	}
	
	@Override
	public void deleteTravelFilesPhysically(TravelFiles vo) throws Exception {
		travelFilesDAO.deleteTravelFilesPhysically(vo);
	}
	
	@Override
	public void deleteTravelFilesPhysically(List<TravelFiles> travelFileList, String realPath) throws Exception {
		TravelFiles vo = new TravelFiles();
		if(travelFileList.size() > 0) {
			String imgRefId = travelFileList.get(0).getImgRefId();
			vo.setImgRefId(imgRefId);
		}
		for (TravelFiles list : travelFileList) {
        	File file = new File(realPath + list.getImgFilePath());
        	if(file.exists()){
        		file.delete();
        	}
		}
		travelFilesDAO.deleteTravelFilesPhysically(vo);
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

