/**
 * @version 3.2.0.1
 */
package jnit.cms.menumgr;

import java.util.List;

/**
 * @Class Name : JnitcmsmenumgrService.java
 * @Description : Jnitcmsmenumgr Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmenumgrService {
	
	/**
	 * JNITCMSMENUMGR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenumgrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception;
    
    /**
	 * JNITCMSMENUMGR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenumgrVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception;
    
    /**
	 * JNITCMSMENUMGR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenumgrVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception;
    
    /**
	 * JNITCMSMENUMGR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenumgrVO
	 * @return 조회한 JNITCMSMENUMGR
	 * @exception Exception
	 */
    JnitcmsmenumgrVO selectJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception;
    
    /**
	 * JNITCMSMENUMGR 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENUMGR 목록
	 * @exception Exception
	 */
    List selectJnitcmsmenumgrList(JnitcmsmenumgrDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMENUMGR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENUMGR 총 갯수
	 * @exception
	 */
    int selectJnitcmsmenumgrListTotCnt(JnitcmsmenumgrDefaultVO searchVO);
    
    /**
     * JNITCMSMENUMGR 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmenumgr() throws Exception;
}
