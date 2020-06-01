package jnit.filego.log.failConfirm;

import java.util.List;


public interface JnitFilegoLogFailConfirmService {

	/**
	 * 파일고 배포 실패확인목록 가져오기
	 * @searchVO
	 */
	List selectListJnitFilegoLogFailConfirm(JnitFilegoLogFailConfirmDefaultVO searchVO) throws Exception;
	
	/**
	 * 파일고 배포 실패확인상세 가져오기
	 * @searchVO
	 */
	JnitFilegoLogFailConfirmVO selectJnitFilegoLogFailConfirm(JnitFilegoLogFailConfirmVO vo) throws Exception;
	
	/**
	 * 파일고 배포 실패확인상세 추가하기
	 * @searchVO
	 */
	void insertJnitFilegoLogFailConfirm(JnitFilegoLogFailConfirmVO vo) throws Exception;
	
	/**
	 * 파일고 배포 실패확인갯수 가져오기
	 * @searchVO
	 */
	int selectListTotJnitFilegoLogFailConfirm(JnitFilegoLogFailConfirmDefaultVO searchVO) throws Exception;
}
