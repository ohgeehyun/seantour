/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtitem;

import java.util.List;

/**
 * @Class Name : JnitcmsmgmtitemService.java
 * @Description : Jnitcmsmgmtitem Business class
 * @Modification Information
 *
 * @author JNITCMSMGMTITEM
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmgmtitemService {
	
	/**
	 * JNITCMSMGMTITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMTITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMTITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMTITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return 조회한 JNITCMSMGMTITEM
	 * @exception Exception
	 */
    JnitcmsmgmtitemVO selectJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMTITEM 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMTITEM 목록
	 * @exception Exception
	 */
    List selectJnitcmsmgmtitemList(JnitcmsmgmtitemDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMGMTITEM 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMTITEM 총 갯수
	 * @exception
	 */
    int selectJnitcmsmgmtitemListTotCnt(JnitcmsmgmtitemDefaultVO searchVO);
    
    /**
     * JNITCMSMGMTITEM 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmgmtitem() throws Exception;
}
