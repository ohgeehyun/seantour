/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtcategory;

import java.util.List;

/**
 * @Class Name : JnitcmsmgmtcategoryService.java
 * @Description : Jnitcmsmgmtcategory Business class
 * @Modification Information
 *
 * @author JNITCMSMGMTCATEGORY
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmgmtcategoryService {
	
	/**
	 * JNITCMSMGMTCATEGORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMTCATEGORY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMTCATEGORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMTCATEGORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return 조회한 JNITCMSMGMTCATEGORY
	 * @exception Exception
	 */
    JnitcmsmgmtcategoryVO selectJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception;
    
    /**
	 * JNITCMSMGMTCATEGORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMTCATEGORY 목록
	 * @exception Exception
	 */
    List selectJnitcmsmgmtcategoryList(JnitcmsmgmtcategoryDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMGMTCATEGORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMTCATEGORY 총 갯수
	 * @exception
	 */
    int selectJnitcmsmgmtcategoryListTotCnt(JnitcmsmgmtcategoryDefaultVO searchVO);
    
    /**
     * JNITCMSMGMTCATEGORY 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmgmtcategory() throws Exception;
}
