package jnit.board.data;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

/**
 * @Class Name : JnitBoardDataService.java
 * @Description : 샘플 Service
 * @Modification Information
 *
 * @author
 * @since 2016. 12.22
 * @version 1.0
 * @see Copyright (C) by 김문기 All right reserved.
 */
public interface JnitBoardDataService {

	/**
	 * 리스트
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	List<JnitBoardDataVO> selectJnitBoardDataList(JnitBoardDataVO searchVO) throws Exception;

	/**
	 * 총갯수
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	Integer selectJnitBoardDataTot(JnitBoardDataVO searchVO) throws Exception;

	/**
	 * Pk데이터
	 *
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	JnitBoardDataVO selectJnitBoardData(JnitBoardDataVO searchVO) throws Exception;

	/**
	 * 키가져오기
	 *
	 * @return
	 * @throws Exception
	 */
	String selectKey() throws Exception;

	/**
	 * 추가/수정
	 *
	 * @param searchVO
	 * @throws Exception
	 */
	void writeJnitBoardData(HttpServletRequest request, JnitBoardDataVO searchVO) throws Exception;

	/**
	 * 삭제
	 *
	 * @param searchVO
	 * @throws Exception
	 */
	void deleteJnitBoardData(JnitBoardDataVO searchVO) throws Exception;

	/**
	 * 최근게시물 데이터 업데이트
	 *
	 * @param searchVO
	 * @throws Exception
	 */
	void latestBoardDataUpdate(HttpServletRequest request,String boardId) throws Exception;
}
