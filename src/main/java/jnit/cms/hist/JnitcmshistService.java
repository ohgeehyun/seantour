/**
 * @version 3.2.0.1
 */
package jnit.cms.hist;

import java.util.List;

/**
 * @Class Name : JnitcmshistService.java
 * @Description : Jnitcmshist Business class
 * @Modification Information
 *
 * @author tactful
 * @since 2012.12.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmshistService {
	
	/**
	 * jnitcmshist을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmshistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmshist(JnitcmshistVO vo) throws Exception;
    
    /**
	 * jnitcmshist을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmshistVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmshist(JnitcmshistVO vo) throws Exception;
    
    /**
	 * jnitcmshist을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmshistVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmshist(JnitcmshistVO vo) throws Exception;
    
    /**
	 * jnitcmshist을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmshistVO
	 * @return 조회한 jnitcmshist
	 * @exception Exception
	 */
    JnitcmshistVO selectJnitcmshist(JnitcmshistVO vo) throws Exception;
    
    /**
	 * jnitcmshist 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmshist 목록
	 * @exception Exception
	 */
    List selectJnitcmshistList(JnitcmshistDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitcmshist 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmshist 총 갯수
	 * @exception
	 */
    int selectJnitcmshistListTotCnt(JnitcmshistDefaultVO searchVO);
    
    /**
     * jnitcmshist 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmshist() throws Exception;
}
