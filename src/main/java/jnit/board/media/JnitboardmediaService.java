package jnit.board.media;

import java.util.List;
import jnit.board.media.JnitboardmediaDefaultVO;
import jnit.board.media.JnitboardmediaVO;

/**
 * @Class Name : JnitboardmediaService.java
 * @Description : Jnitboardmedia Business class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitboardmediaService {
	
	/**
	 * Jnitboardmedia을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardmediaVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitboardmedia(JnitboardmediaVO vo) throws Exception;
    
    /**
	 * Jnitboardmedia을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardmediaVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitboardmedia(JnitboardmediaVO vo) throws Exception;
    
    /**
	 * Jnitboardmedia을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardmediaVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitboardmedia(JnitboardmediaVO vo) throws Exception;
    
    /**
	 * Jnitboardmedia을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardmediaVO
	 * @return 조회한 Jnitboardmedia
	 * @exception Exception
	 */
    JnitboardmediaVO selectJnitboardmedia(JnitboardmediaVO vo) throws Exception;
    
    /**
	 * Jnitboardmedia 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return Jnitboardmedia 목록
	 * @exception Exception
	 */
    List selectJnitboardmediaList(JnitboardmediaDefaultVO searchVO) throws Exception;
    
    /**
	 * Jnitboardmedia 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return Jnitboardmedia 총 갯수
	 * @exception
	 */
    int selectJnitboardmediaListTotCnt(JnitboardmediaDefaultVO searchVO);
    
    /**
     * Jnitboardmedia 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitboardmedia() throws Exception;
}
