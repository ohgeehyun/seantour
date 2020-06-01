package jnit.filego.log.success;

import java.util.List;


public interface JnitFilegoLogSuccessService {

	/**
	 * 파일고 배포 성공목록 가져오기
	 * @searchVO
	 */
	List selectListJnitFilegoLogSuccess(JnitFilegoLogSuccessDefaultVO searchVO) throws Exception;
	
	/**
	 * 파일고 배포 성공상세 가져오기
	 * @searchVO
	 */
	JnitFilegoLogSuccessVO selectJnitFilegoLogSuccess(JnitFilegoLogSuccessVO vo) throws Exception;
	
	/**
	 * 파일고 배포 성공갯수 가져오기
	 * @searchVO
	 */
	int selectListTotJnitFilegoLogSuccess(JnitFilegoLogSuccessDefaultVO searchVO) throws Exception;
	
}
