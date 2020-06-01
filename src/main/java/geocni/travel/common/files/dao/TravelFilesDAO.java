package geocni.travel.common.files.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import geocni.travel.common.files.domain.TravelFiles;

@Repository("travelFilesDAO")
public class TravelFilesDAO extends EgovComAbstractDAO {

	public String insertTravelFiles(List<TravelFiles> fileList) throws Exception {
		return (String)insert("travelFilesDAO.insertTravelFiles", fileList);
	}
	
	public void updateTravelFiles(TravelFiles vo) throws Exception {
		update("travelFilesDAO.updateTravelFiles", vo);
	}
	
	public void deleteTravelFilesPhysically(TravelFiles vo) throws Exception {
		delete("travelFilesDAO.deleteTravelFilesPhysically", vo);
	}
	
	public TravelFiles selectTravelFiles(TravelFiles vo) throws Exception {
		return (TravelFiles)select("travelFilesDAO.selectTravelFiles", vo);
	}
	
    public List<?> selectTravelFilesList(TravelFiles vo) throws Exception {
    	return list("travelFilesDAO.selectTravelFilesList", vo);
    }
    
    public int selectTravelFilesListCnt(TravelFiles vo) {
    	return (Integer)select("travelFilesDAO.selectTravelFilesListCnt", vo);
    }
    
}
