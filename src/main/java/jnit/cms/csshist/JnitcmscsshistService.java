/**
 * @version 3.2.0.1
 */
package jnit.cms.csshist;

import java.util.List;

/**
 * @Class Name : JnitcmscsshistService.java
 * @Description : Jnitcmscsshist Business class
 * @Modification Information
 *
 * @author JNITCMSCSSHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmscsshistService {
	
	/**
	 * JNITCMSCSSHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmscsshistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmscsshist(JnitcmscsshistVO vo) throws Exception;
    
    /**
	 * JNITCMSCSSHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscsshistVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmscsshist(JnitcmscsshistVO vo) throws Exception;
    
    /**
	 * JNITCMSCSSHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmscsshistVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmscsshist(JnitcmscsshistVO vo) throws Exception;
    
    /**
	 * JNITCMSCSSHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscsshistVO
	 * @return 조회한 JNITCMSCSSHIST
	 * @exception Exception
	 */
    JnitcmscsshistVO selectJnitcmscsshist(JnitcmscsshistVO vo) throws Exception;
    
    /**
	 * JNITCMSCSSHIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCSSHIST 목록
	 * @exception Exception
	 */
    List selectJnitcmscsshistList(JnitcmscsshistDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSCSSHIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCSSHIST 총 갯수
	 * @exception
	 */
    int selectJnitcmscsshistListTotCnt(JnitcmscsshistDefaultVO searchVO);
    
    /**
     * JNITCMSCSSHIST 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmscsshist() throws Exception;
}
