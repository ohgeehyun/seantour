/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrtype;

import java.util.List;

/**
 * @Class Name : JnitcmsmbrtypeService.java
 * @Description : Jnitcmsmbrtype Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmbrtypeService {
	
	/**
	 * JNITCMSMBRTYPE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRTYPE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception;
    
    void updateJnitcmsmbrtypetree(JnitcmsmbrtypeVO vo) throws Exception;
    
    
    /**
	 * JNITCMSMBRTYPE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRTYPE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return 조회한 JNITCMSMBRTYPE
	 * @exception Exception
	 */
    JnitcmsmbrtypeVO selectJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRTYPE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRTYPE 목록
	 * @exception Exception
	 */
    List selectJnitcmsmbrtypeList(JnitcmsmbrtypeDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMBRTYPE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRTYPE 총 갯수
	 * @exception
	 */
    int selectJnitcmsmbrtypeListTotCnt(JnitcmsmbrtypeDefaultVO searchVO);
    
    /**
     * JNITCMSMBRTYPE 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmbrtype() throws Exception;
}
