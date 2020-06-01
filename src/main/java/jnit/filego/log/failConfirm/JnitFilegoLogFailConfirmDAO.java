package jnit.filego.log.failConfirm;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("jnitFilegoLogFailConfirmDAO")
public class JnitFilegoLogFailConfirmDAO extends EgovComAbstractDAO {

	/**
	 * 파일고 배포 실패확인목록 가져오기
	 * @searchVO
	 */
	public List<?> selectListJnitFilegoLogFailConfirm(JnitFilegoLogFailConfirmDefaultVO searchVO) throws Exception{
		return list("jnitFilegoLogFailConfirmDAO.selectListJnitFilegoLogFailConfirm", searchVO);
	}
	
	/**
	 * 파일고 배포 실패확인상세 가져오기
	 * @searchVO
	 */
	public JnitFilegoLogFailConfirmVO selectJnitFilegoLogFailConfirm(JnitFilegoLogFailConfirmVO vo) throws Exception{
		return (JnitFilegoLogFailConfirmVO) select("jnitFilegoLogFailConfirmDAO.selectJnitFilegoLogFailConfirm", vo);
	}
	
	/**
	 * 파일고 배포 실패확인상세 추가하기
	 * @searchVO
	 */
	public void insertJnitFilegoLogFailConfirm(JnitFilegoLogFailConfirmVO vo) throws Exception{
		insert("jnitFilegoLogFailConfirmDAO.insertJnitFilegoLogFailConfirm", vo);
	}
	
	/**
	 * 파일고 배포 실패확인갯수 가져오기
	 * @searchVO
	 */
	public int selectListTotJnitFilegoLogFailConfirm(JnitFilegoLogFailConfirmDefaultVO searchVO) throws Exception{
		return (Integer)select("jnitFilegoLogFailConfirmDAO.selectListTotJnitFilegoLogFailConfirm", searchVO);
	}
}
