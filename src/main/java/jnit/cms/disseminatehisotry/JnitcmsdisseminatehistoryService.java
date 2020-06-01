/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminatehisotry;

import java.util.List;

/**
 * @Class Name : JnitcmsdisseminatehistoryService.java
 * @Description : Jnitcmsdisseminatehistory Business class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATEHISTORY
 * @since 2013.11.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsdisseminatehistoryService {
	
	/**
	 * jnitcmsdisseminatehistory을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception;
    
    /**
	 * jnitcmsdisseminatehistory을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception;
    
    /**
	 * jnitcmsdisseminatehistory을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception;
    
    /**
	 * jnitcmsdisseminatehistory을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return 조회한 jnitcmsdisseminatehistory
	 * @exception Exception
	 */
    JnitcmsdisseminatehistoryVO selectJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception;
    
    /**
	 * jnitcmsdisseminatehistory 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminatehistory 목록
	 * @exception Exception
	 */
    List selectJnitcmsdisseminatehistoryList(JnitcmsdisseminatehistoryDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitcmsdisseminatehistory 목록을 조회한다.
	 * LEFT JOIN JNITCMSSITE
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminatehistory 목록
	 * @exception Exception
	 */
    List selectLeftJoinhistoryList(JnitcmsdisseminatehistoryDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitcmsdisseminatehistory 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminatehistory 총 갯수
	 * @exception
	 */
    int selectJnitcmsdisseminatehistoryListTotCnt(JnitcmsdisseminatehistoryDefaultVO searchVO);
    
    /**
	 * jnitcmsdisseminatehistory 총 갯수를 조회한다.
	 * LEFT JOIN JNITCMSSITE
	 * LEFT JOIN JNITCMSMBR
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminatehistory 총 갯수
	 * @exception
	 */
    int selectLeftJoinListTotCnt(JnitcmsdisseminatehistoryDefaultVO searchVO);
    
    /**
     * jnitcmsdisseminatehistory 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsdisseminatehistory() throws Exception;
}
