/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmt;

import java.util.List;

/**
 * @Class Name : JnitcmsmgmtService.java
 * @Description : Jnitcmsmgmt Business class
 * @Modification Information
 *
 * @author JNITCMSMGMT
 * @since 2014.04.16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmgmtService {
	
	/**
	 * JNITCMSMGMT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtVO
	 * @return 조회한 JNITCMSMGMT
	 * @exception Exception
	 */
    JnitcmsmgmtVO selectJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMT 목록
	 * @exception Exception
	 */
    List selectJnitcmsmgmtList(JnitcmsmgmtDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMGMT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMT 총 갯수
	 * @exception
	 */
    int selectJnitcmsmgmtListTotCnt(JnitcmsmgmtDefaultVO searchVO);
    
    /**
	 * JNITCMSMGMT MAX값을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMT MAX
	 * @exception
	 */
    int selectMaxTotCnt(JnitcmsmgmtDefaultVO searchVO);
    
    /**
     * JNITCMSMGMT 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmgmt() throws Exception;
}
