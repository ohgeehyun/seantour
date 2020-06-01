/**
 * @version 3.2.0.1
 */
package jnit.board.good;

import java.util.List;

/**
 * @Class Name : JnitboardgoodService.java
 * @Description : Jnitboardgood Business class
 * @Modification Information
 *
 * @author JNITBOARADGOOD
 * @since 2013.11.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitboardgoodService {
	
	/**
	 * jnitboardgood을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardgoodVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitboardgood(JnitboardgoodVO vo) throws Exception;
    
    /**
	 * jnitboardgood을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardgoodVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitboardgood(JnitboardgoodVO vo) throws Exception;
    
    /**
	 * jnitboardgood을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardgoodVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitboardgood(JnitboardgoodVO vo) throws Exception;
    
    /**
	 * jnitboardgood을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardgoodVO
	 * @return 조회한 jnitboardgood
	 * @exception Exception
	 */
    JnitboardgoodVO selectJnitboardgood(JnitboardgoodVO vo) throws Exception;
    
    /**
	 * jnitboardgood 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardgood 목록
	 * @exception Exception
	 */
    List selectJnitboardgoodList(JnitboardgoodDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitboardgood 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardgood 총 갯수
	 * @exception
	 */
    int selectJnitboardgoodListTotCnt(JnitboardgoodDefaultVO searchVO);
    
    /**
     * jnitboardgood 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitboardgood() throws Exception;
}
