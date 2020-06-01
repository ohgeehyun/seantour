/**
 * @version 3.2.0.1
 */
package jnit.board.cmt;

import java.util.List;

/**
 * @Class Name : JnitboardcmtService.java
 * @Description : Jnitboardcmt Business class
 * @Modification Information
 *
 * @author JNITBOARDCMT
 * @since 2013.07.11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitboardcmtService {
	
	/**
	 * jnitboardcmt을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardcmtVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitboardcmt(JnitboardcmtVO vo) throws Exception;
    
    /**
	 * jnitboardcmt을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardcmtVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitboardcmt(JnitboardcmtVO vo) throws Exception;
    
    /**
	 * jnitboardcmt을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardcmtVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitboardcmt(JnitboardcmtVO vo) throws Exception;
    
    /**
	 * jnitboardcmt을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardcmtVO
	 * @return 조회한 jnitboardcmt
	 * @exception Exception
	 */
    JnitboardcmtVO selectJnitboardcmt(JnitboardcmtVO vo) throws Exception;
    
    /**
	 * jnitboardcmt 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardcmt 목록
	 * @exception Exception
	 */
    List selectJnitboardcmtList(JnitboardcmtDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitboardcmt 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardcmt 총 갯수
	 * @exception
	 */
    int selectJnitboardcmtListTotCnt(JnitboardcmtDefaultVO searchVO);
    
    /**
     * jnitboardcmt 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitboardcmt() throws Exception;
}
