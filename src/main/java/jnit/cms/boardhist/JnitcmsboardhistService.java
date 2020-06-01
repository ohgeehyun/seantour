/**
 * @version 3.2.0.1
 */
package jnit.cms.boardhist;

import java.util.List;

/**
 * @Class Name : JnitcmsboardhistService.java
 * @Description : Jnitcmsboardhist Business class
 * @Modification Information
 *
 * @author JNITCMSBOARDHIST
 * @since 2014.08.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsboardhistService {
	
	/**
	 * JNITCMSBOARDHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsboardhistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception;
    
    /**
	 * JNITCMSBOARDHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsboardhistVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception;
    
    /**
	 * JNITCMSBOARDHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsboardhistVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception;
    
    /**
	 * JNITCMSBOARDHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsboardhistVO
	 * @return 조회한 JNITCMSBOARDHIST
	 * @exception Exception
	 */
    JnitcmsboardhistVO selectJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception;
    
    /**
	 * JNITCMSBOARDHIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSBOARDHIST 목록
	 * @exception Exception
	 */
    List selectJnitcmsboardhistList(JnitcmsboardhistDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSBOARDHIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSBOARDHIST 총 갯수
	 * @exception
	 */
    int selectJnitcmsboardhistListTotCnt(JnitcmsboardhistDefaultVO searchVO);
    
    /**
     * JNITCMSBOARDHIST 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsboardhist() throws Exception;
}
