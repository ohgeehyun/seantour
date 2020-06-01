/**
 * @version 3.2.0.1
 */
package jnit.cms.pos;

import java.util.List;

/**
 * @Class Name : JnitcmsposService.java
 * @Description : Jnitcmspos Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsposService {
	
	/**
	 * JNITCMSPOS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsposVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmspos(JnitcmsposVO vo) throws Exception;
    
    /**
	 * JNITCMSPOS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsposVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertDbConnectpos(JnitcmsposVO vo) throws Exception;
    
    /**
     * JNITCMSPOS 다음 ID를 조회한다
     * @param void
     * @return 다음ID
     * @exception Exception
     */
    String getNextIdJnitcmspos() throws Exception;
    
    /**
	 * JNITCMSPOS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsposVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmspos(JnitcmsposVO vo) throws Exception;
    
    /**
	 * JNITCMSPOS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsposVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmspos(JnitcmsposVO vo) throws Exception;
    
    /**
	 * JNITCMSPOS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsposVO
	 * @return 조회한 JNITCMSPOS
	 * @exception Exception
	 */
    JnitcmsposVO selectJnitcmspos(JnitcmsposVO vo) throws Exception;
    
    /**
	 * JNITCMSPOS 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSPOS 목록
	 * @exception Exception
	 */
    List selectJnitcmsposList(JnitcmsposDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSPOS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSPOS 총 갯수
	 * @exception
	 */
    int selectJnitcmsposListTotCnt(JnitcmsposDefaultVO searchVO);
    
}
