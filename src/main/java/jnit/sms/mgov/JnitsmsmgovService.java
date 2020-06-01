/**
 * @version 3.2.0.1
 */
package jnit.sms.mgov;

import java.util.List;

/**
 * @Class Name : JnitsmsmgovService.java
 * @Description : Jnitsmsmgov Business class
 * @Modification Information
 *
 * @author JNITSMSMGOV
 * @since 2013.11.25
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitsmsmgovService {
	
	/**
	 * jnitsmsmgov을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitsmsmgovVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitsmsmgov(JnitsmsmgovVO vo) throws Exception;
    
    /**
	 * jnitsmsmgov을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitsmsmgovVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitsmsmgov(JnitsmsmgovVO vo) throws Exception;
    
    /**
	 * jnitsmsmgov을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitsmsmgovVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitsmsmgov(JnitsmsmgovVO vo) throws Exception;
    
    /**
	 * jnitsmsmgov을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitsmsmgovVO
	 * @return 조회한 jnitsmsmgov
	 * @exception Exception
	 */
    JnitsmsmgovVO selectJnitsmsmgov(JnitsmsmgovVO vo) throws Exception;
    
    /**
	 * jnitsmsmgov 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitsmsmgov 목록
	 * @exception Exception
	 */
    List selectJnitsmsmgovList(JnitsmsmgovDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitsmsmgov 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitsmsmgov 총 갯수
	 * @exception
	 */
    int selectJnitsmsmgovListTotCnt(JnitsmsmgovDefaultVO searchVO);
    
    /**
     * jnitsmsmgov 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitsmsmgov() throws Exception;
}
