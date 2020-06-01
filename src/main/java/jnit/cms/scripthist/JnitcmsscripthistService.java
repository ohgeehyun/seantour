/**
 * @version 3.2.0.1
 */
package jnit.cms.scripthist;

import java.util.List;

/**
 * @Class Name : JnitcmsscripthistService.java
 * @Description : Jnitcmsscripthist Business class
 * @Modification Information
 *
 * @author JNITCMSSCRIPTHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsscripthistService {
	
	/**
	 * JNITCMSSCRIPTHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsscripthistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception;
    
    /**
	 * JNITCMSSCRIPTHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsscripthistVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception;
    
    /**
	 * JNITCMSSCRIPTHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsscripthistVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception;
    
    /**
	 * JNITCMSSCRIPTHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsscripthistVO
	 * @return 조회한 JNITCMSSCRIPTHIST
	 * @exception Exception
	 */
    JnitcmsscripthistVO selectJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception;
    
    /**
	 * JNITCMSSCRIPTHIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSSCRIPTHIST 목록
	 * @exception Exception
	 */
    List selectJnitcmsscripthistList(JnitcmsscripthistDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSSCRIPTHIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSSCRIPTHIST 총 갯수
	 * @exception
	 */
    int selectJnitcmsscripthistListTotCnt(JnitcmsscripthistDefaultVO searchVO);
    
    /**
     * JNITCMSSCRIPTHIST 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsscripthist() throws Exception;
}
