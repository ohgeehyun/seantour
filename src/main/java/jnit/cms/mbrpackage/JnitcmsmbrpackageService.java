/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrpackage;

import java.util.List;

/**
 * @Class Name : JnitcmsmbrpackageService.java
 * @Description : Jnitcmsmbrpackage Business class
 * @Modification Information
 *
 * @author JNITCMSMBRPACKAGE
 * @since 2014.05.27
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmbrpackageService {
	
	/**
	 * JNITCMSMBRPACKAGE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRPACKAGE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRPACKAGE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRPACKAGE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 조회한 JNITCMSMBRPACKAGE
	 * @exception Exception
	 */
    JnitcmsmbrpackageVO selectJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception;
    
    /**
	 * 해당 계정의 권한이 있는지 없는지 'Y' or 'N'으로 반환
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 조회한 JNITCMSMBRPACKAGE
	 * @exception Exception
	 */
    String selectJnitcmsmbrpackageQuery(String query) throws Exception;
    
    /**
	 * JNITCMSMBRPACKAGE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRPACKAGE 목록
	 * @exception Exception
	 */
    List selectJnitcmsmbrpackageList(JnitcmsmbrpackageDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMBRPACKAGE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRPACKAGE 총 갯수
	 * @exception
	 */
    int selectJnitcmsmbrpackageListTotCnt(JnitcmsmbrpackageDefaultVO searchVO);
    
    /**
     * JNITCMSMBRPACKAGE 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmbrpackage() throws Exception;
}
