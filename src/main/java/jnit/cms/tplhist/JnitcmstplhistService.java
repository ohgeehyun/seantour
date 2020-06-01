/**
 * @version 3.2.0.1
 */
package jnit.cms.tplhist;

import java.util.List;

/**
 * @Class Name : JnitcmstplhistService.java
 * @Description : Jnitcmstplhist Business class
 * @Modification Information
 *
 * @author JNITCMSTPLHIST
 * @since 2014.05.02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmstplhistService {
	
	/**
	 * JNITCMSTPLHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmstplhistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmstplhist(JnitcmstplhistVO vo) throws Exception;
    
    /**
	 * JNITCMSTPLHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmstplhistVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmstplhist(JnitcmstplhistVO vo) throws Exception;
    
    /**
	 * JNITCMSTPLHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplhistVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmstplhist(JnitcmstplhistVO vo) throws Exception;
    
    /**
	 * JNITCMSTPLHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmstplhistVO
	 * @return 조회한 JNITCMSTPLHIST
	 * @exception Exception
	 */
    JnitcmstplhistVO selectJnitcmstplhist(JnitcmstplhistVO vo) throws Exception;
    
    /**
	 * JNITCMSTPLHIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPLHIST 목록
	 * @exception Exception
	 */
    List selectJnitcmstplhistList(JnitcmstplhistDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSTPLHIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPLHIST 총 갯수
	 * @exception
	 */
    int selectJnitcmstplhistListTotCnt(JnitcmstplhistDefaultVO searchVO);
    
    /**
     * JNITCMSTPLHIST 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmstplhist() throws Exception;
}
