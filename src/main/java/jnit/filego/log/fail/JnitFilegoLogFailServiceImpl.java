package jnit.filego.log.fail;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("jnitFilegoLogFailService")
public class JnitFilegoLogFailServiceImpl implements JnitFilegoLogFailService {

	@Resource(name="jnitFilegoLogFailDAO")
    private JnitFilegoLogFailDAO jnitFilegoLogFailDAO;
	
	/**
	 * 파일고 배포 실패목록 가져오기
	 * @searchVO
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectListJnitFilegoLogFail(JnitFilegoLogFailDefaultVO searchVO) throws Exception{
		return (List<EgovMap>) jnitFilegoLogFailDAO.selectListJnitFilegoLogFail(searchVO);
	}
	
	/**
	 * 파일고 배포 실패상세 가져오기
	 * @searchVO
	 */
	public JnitFilegoLogFailVO selectJnitFilegoLogFail(JnitFilegoLogFailVO vo) throws Exception{
		return jnitFilegoLogFailDAO.selectJnitFilegoLogFail(vo);
	}
	
	/**
	 * 파일고 배포 실패 갯수 가져오기
	 * @searchVO
	 */
	public int selectListTotJnitFilegoLogFail(JnitFilegoLogFailDefaultVO searchVO) throws Exception{
		return jnitFilegoLogFailDAO.selectListTotJnitFilegoLogFail(searchVO);
	}
	
	/**
	 * 파일고 배포 실패내역 제거
	 * @vo
	 */
	public void deleteFilegoLogFail(JnitFilegoLogFailVO vo) throws Exception{
		jnitFilegoLogFailDAO.deleteJnitFilegoLog(vo);
	}
}
