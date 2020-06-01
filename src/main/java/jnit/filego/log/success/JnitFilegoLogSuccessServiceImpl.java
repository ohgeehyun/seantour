package jnit.filego.log.success;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("jnitFilegoLogSuccessService")
public class JnitFilegoLogSuccessServiceImpl implements JnitFilegoLogSuccessService {

	@Resource(name="jnitFilegoLogSuccessDAO")
    private JnitFilegoLogSuccessDAO jnitFilegoLogSuccessDAO;
	
	/**
	 * 파일고 배포 성공목록 가져오기
	 * @searchVO
	 */
	public List selectListJnitFilegoLogSuccess(JnitFilegoLogSuccessDefaultVO searchVO) throws Exception{
		return jnitFilegoLogSuccessDAO.selectListJnitFilegoLogSuccess(searchVO);
	}
	
	/**
	 * 파일고 배포 성공상세 가져오기
	 * @searchVO
	 */
	public JnitFilegoLogSuccessVO selectJnitFilegoLogSuccess(JnitFilegoLogSuccessVO vo) throws Exception{
		return jnitFilegoLogSuccessDAO.selectJnitFilegoLogSuccess(vo);
	}
	
	/**
	 * 파일고 배포 성공갯수 가져오기
	 * @searchVO
	 */
	public int selectListTotJnitFilegoLogSuccess(JnitFilegoLogSuccessDefaultVO searchVO) throws Exception{
		return jnitFilegoLogSuccessDAO.selectListTotJnitFilegoLogSuccess(searchVO);
	}
}
