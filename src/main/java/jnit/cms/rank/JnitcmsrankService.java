/**
 * @version 3.2.0.1
 */
package jnit.cms.rank;

import java.util.List;

/**
 * @Class Name : JnitcmsrankService.java
 * @Description : Jnitcmsrank Business class
 * @Modification Information
 *
 * @author JNITCMSRANK
 * @since 2013.11.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsrankService {
	
	/**
	 * jnitcmsrank을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsrankVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsrank(JnitcmsrankVO vo) throws Exception;
    
    /**
	 * jnitcmsrank을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsrankVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertDbConnectrank(JnitcmsrankVO vo) throws Exception;
    
    /**
	 * jnitcmsrank을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsrankVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsrank(JnitcmsrankVO vo) throws Exception;
    
    /**
	 * jnitcmsrank을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsrankVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsrank(JnitcmsrankVO vo) throws Exception;
    
    /**
	 * jnitcmsrank을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsrankVO
	 * @return 조회한 jnitcmsrank
	 * @exception Exception
	 */
    JnitcmsrankVO selectJnitcmsrank(JnitcmsrankVO vo) throws Exception;
    
    /**
	 * jnitcmsrank 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsrank 목록
	 * @exception Exception
	 */
    List selectJnitcmsrankList(JnitcmsrankDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitcmsrank 목록을 조회한다.
	 * JNTCMSORG - LEFT JOIN
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsrank 목록
	 * @exception Exception
	 */
    List selectLeftJoinrankList(JnitcmsrankDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitcmsrank 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsrank 총 갯수
	 * @exception
	 */
    int selectJnitcmsrankListTotCnt(JnitcmsrankDefaultVO searchVO);
    
    /**
     * jnitcmsrank 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsrank() throws Exception;
}
