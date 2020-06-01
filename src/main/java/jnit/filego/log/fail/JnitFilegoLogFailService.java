package jnit.filego.log.fail;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface JnitFilegoLogFailService {

	/**
	 * 파일고 배포 실패목록 가져오기
	 * @searchVO
	 */
	List<EgovMap> selectListJnitFilegoLogFail(JnitFilegoLogFailDefaultVO searchVO) throws Exception;
	
	/**
	 * 파일고 배포 실패상세 가져오기
	 * @searchVO
	 */
	JnitFilegoLogFailVO selectJnitFilegoLogFail(JnitFilegoLogFailVO searchVO) throws Exception;
	
	/**
	 * 파일고 배포 실패 갯수 가져오기
	 * @searchVO
	 */
	int selectListTotJnitFilegoLogFail(JnitFilegoLogFailDefaultVO searchVO) throws Exception;
	
	/**
	 * 파일고 배포 실패내역 제거
	 * @vo
	 */
	void deleteFilegoLogFail(JnitFilegoLogFailVO vo) throws Exception;
}
