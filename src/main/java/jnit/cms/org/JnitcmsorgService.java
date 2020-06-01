/**
 * @version 3.2.0.1
 */
package jnit.cms.org;

import java.util.List;

/**
 * @Class Name : JnitcmsorgService.java
 * @Description : Jnitcmsorg Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsorgService {
	
	/**
	 * JNITCMSORG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsorgVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsorg(JnitcmsorgVO vo) throws Exception;
    
    /**
	 * JNITCMSORG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsorgVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertDbConnectorg(JnitcmsorgVO vo) throws Exception;
    
    /**
	 * JNITCMSORG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsorgVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsorg(JnitcmsorgVO vo) throws Exception;
    
    /**
	 * JNITCMSORG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsorgVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsorg(JnitcmsorgVO vo) throws Exception;
    
    /**
	 * JNITCMSORG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsorgVO
	 * @return 조회한 JNITCMSORG
	 * @exception Exception
	 */
    JnitcmsorgVO selectJnitcmsorg(JnitcmsorgVO vo) throws Exception;
    
    /**
	 * JNITCMSORG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSORG 목록
	 * @exception Exception
	 */
    List selectJnitcmsorgList(JnitcmsorgDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSORG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSORG 목록
	 * @exception Exception
	 */
    List selectcmsorgList(JnitcmsorgDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSORG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSORG 총 갯수
	 * @exception
	 */
    int selectJnitcmsorgListTotCnt(JnitcmsorgDefaultVO searchVO);
    
    /**
     * JNITCMSORG 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsorg() throws Exception;
}
