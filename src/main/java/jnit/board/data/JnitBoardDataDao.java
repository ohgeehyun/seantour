package jnit.board.data;

import java.util.List;

import javax.annotation.Resource;

import jnit.com.service.JnitDefaultDAO;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : JnitBoardDataDao.java
 * @Description : dao
 * @Modification Information
 * @author
 * @since 2016. 09.24
 * @version 1.0
 * @see Copyright (C) by jnit All right reserved.
 */
@Repository("jnitBoardDataDao")
public class JnitBoardDataDao extends JnitDefaultDAO {

	private Logger log = Logger.getLogger(this.getClass());
	// ////////////////////// Resource 선언 영역 ///////////////////////////////////////////////////////////////////
	@Resource(name = "jnitBoardDataIdGnrService")
	private EgovIdGnrService idgenService;

	// ////////////////////// Resource 선언 영역 끝 /////////////////////////////////////////////////////////////////

	// //////////////////////서비스 메소드 선언 영역 ///////////////////////////////////////////////////////////////////
	/**
	 * 리스트
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public List<?> selectJnitBoardDataList(JnitBoardDataVO searchVO) throws Exception {
		return list("BoardDataDAO.selectList", searchVO);
	}

	/**
	 * 총갯수
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public int selectJnitBoardDataTot(JnitBoardDataVO searchVO) throws Exception {
		return (Integer) select("BoardDataDAO.selectTot", searchVO);
	}

	/**
	 * Pk데이터
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public JnitBoardDataVO selectJnitBoardData(JnitBoardDataVO searchVO) throws Exception {
		return (JnitBoardDataVO) select("BoardDataDAO.select", searchVO);
	}

	/**
	 * 키가져오기
	 *
	 * @return
	 * @throws Exception
	 */
	public String selectKey() throws Exception {
		return idgenService.getNextStringId();
	}

	/**
	 * 추가
	 *
	 * @param searchVO
	 * @throws Exception
	 */
	public void insertJnitBoardData(JnitBoardDataVO searchVO) throws Exception {
		update("BoardDataDAO.insert", searchVO);
	}

	/**
	 * 수정
	 *
	 * @param searchVO
	 * @throws Exception
	 */
	public void updateJnitBoardData(JnitBoardDataVO searchVO) throws Exception {
		update("BoardDataDAO.update", searchVO);
	}

	/**
	 * 삭제
	 *
	 * @param searchVO
	 * @throws Exception
	 */
	public void deleteJnitBoardData(JnitBoardDataVO searchVO) throws Exception {
		update("BoardDataDAO.delete", searchVO);
	}
	// //////////////////////서비스 메소드 선언 영역 끝 ///////////////////////////////////////////////////////////////////

	// /////////////////////private,protected 메소드 선언 영역 /////////////////////////////////////////////
	// /////////////////////private,protected 메소드 선언 영역 끝 //////////////////////////////////////////
}
