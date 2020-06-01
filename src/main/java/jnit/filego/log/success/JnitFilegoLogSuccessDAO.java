package jnit.filego.log.success;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("jnitFilegoLogSuccessDAO")
public class JnitFilegoLogSuccessDAO extends EgovComAbstractDAO {

	/**
	 * 파일고 배포 성공목록 가져오기
	 * @searchVO
	 */
	public List<?> selectListJnitFilegoLogSuccess(JnitFilegoLogSuccessDefaultVO searchVO) throws Exception{
		return list("jnitFilegoLogSuccessDAO.selectListJnitFilegoLogSuccess", searchVO);
	}
	
	/**
	 * 파일고 배포 성공상세 가져오기
	 * @searchVO
	 */
	public JnitFilegoLogSuccessVO selectJnitFilegoLogSuccess(JnitFilegoLogSuccessVO vo) throws Exception{
		return (JnitFilegoLogSuccessVO) select("jnitFilegoLogSuccessDAO.selectJnitFilegoLogSuccess", vo);
	}
	
	/**
	 * 파일고 배포 성공갯수 가져오기
	 * @searchVO
	 */
	public int selectListTotJnitFilegoLogSuccess(JnitFilegoLogSuccessDefaultVO searchVO) throws Exception{
		return (Integer)select("jnitFilegoLogSuccessDAO.selectListTotJnitFilegoLogSuccess", searchVO);
	}
}
