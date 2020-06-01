package geocni.travel.common.files.service;

import java.util.List;
import java.util.Map;

import geocni.travel.common.files.domain.TravelFiles;

public interface TravelFilesService {

	Map<String, Object> selectTravelFilesListMap(TravelFiles vo) throws Exception;
	
	List<?> selectTravelFilesList(TravelFiles vo) throws Exception;
	
	int selectTravelFilesListCnt(TravelFiles vo) throws Exception;
	
	TravelFiles selectTravelFiles(TravelFiles vo) throws Exception;
	
	void insertTravelFiles(List<TravelFiles> fileList) throws Exception;
	
	void updateTravelFiles(TravelFiles vo) throws Exception;
	
	void deleteTravelFilesPhysically(TravelFiles vo) throws Exception;
	
	void deleteTravelFilesPhysically(List<TravelFiles> travelFileList, String realPath) throws Exception;
	
}
