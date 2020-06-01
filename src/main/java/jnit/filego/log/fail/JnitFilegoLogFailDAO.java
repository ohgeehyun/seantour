package jnit.filego.log.fail;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("jnitFilegoLogFailDAO")
public class JnitFilegoLogFailDAO extends EgovComAbstractDAO {

	/**
	 * 파일고 배포 실패목록 가져오기
	 * @searchVO
	 */
	public List<?> selectListJnitFilegoLogFail(JnitFilegoLogFailDefaultVO searchVO) throws Exception{
		return list("jnitFilegoLogFailDAO.selectListJnitFilegoLogFail", searchVO);
	}
	
	/**
	 * 파일고 배포 실패상세 가져오기
	 * @searchVO
	 */
	public JnitFilegoLogFailVO selectJnitFilegoLogFail(JnitFilegoLogFailVO vo) throws Exception{
		return (JnitFilegoLogFailVO) select("jnitFilegoLogFailDAO.selectJnitFilegoLogFail", vo);
	}
	
	/**
	 * 파일고 배포 실패 갯수 가져오기
	 * @searchVO
	 */
	public int selectListTotJnitFilegoLogFail(JnitFilegoLogFailDefaultVO searchVO) throws Exception{
		return (Integer)select("jnitFilegoLogFailDAO.selectListTotJnitFilegoLogFail", searchVO);
	}
	
	/**
	 * 파일고 배포 실패내역 제거
	 * @vo
	 */
	public void deleteJnitFilegoLog(JnitFilegoLogFailVO vo) throws Exception {
        delete("jnitFilegoLogFailDAO.jnitFilegoLogFailDelete", vo);
    }
}
