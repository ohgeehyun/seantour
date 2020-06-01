/**
 * @version 3.2.0.1
 */
package jnit.ebook;

import java.util.List;

/**
 * @Class Name : JnitebookService.java
 * @Description : Jnitebook Business class
 * @Modification Information
 *
 * @author JNITEBOOK
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitebookService {
	
	/**
	 * JNITEBOOK을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitebookVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitebook(JnitebookVO vo) throws Exception;
    
    /**
	 * JNITEBOOK을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitebookVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitebook(JnitebookVO vo) throws Exception;
    
    /**
	 * JNITEBOOK을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitebookVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitebook(JnitebookVO vo) throws Exception;
    
    /**
	 * JNITEBOOK을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitebookVO
	 * @return 조회한 JNITEBOOK
	 * @exception Exception
	 */
    JnitebookVO selectJnitebook(JnitebookVO vo) throws Exception;
    
    /**
	 * JNITEBOOK 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITEBOOK 목록
	 * @exception Exception
	 */
    List selectJnitebookList(JnitebookDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITEBOOK 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITEBOOK 총 갯수
	 * @exception
	 */
    int selectJnitebookListTotCnt(JnitebookDefaultVO searchVO);
    
    /**
     * JNITEBOOK 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitebook() throws Exception;
}
