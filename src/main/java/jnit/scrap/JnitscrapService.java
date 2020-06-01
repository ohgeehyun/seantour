/**
 * @version 3.2.0.1
 */
package jnit.scrap;

import java.util.List;

/**
 * @Class Name : JnitscrapService.java
 * @Description : Jnitscrap Business class
 * @Modification Information
 *
 * @author tactful
 * @since 2013.03.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitscrapService {
	
	/**
	 * jnitscrap을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitscrapVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitscrap(JnitscrapVO vo) throws Exception;
    
    /**
	 * jnitscrap을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitscrapVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitscrap(JnitscrapVO vo) throws Exception;
    
    /**
	 * jnitscrap을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitscrapVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitscrap(JnitscrapVO vo) throws Exception;
    
    /**
	 * jnitscrap을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitscrapVO
	 * @return 조회한 jnitscrap
	 * @exception Exception
	 */
    JnitscrapVO selectJnitscrap(JnitscrapVO vo) throws Exception;
    
    /**
	 * jnitscrap 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitscrap 목록
	 * @exception Exception
	 */
    List selectJnitscrapList(JnitscrapDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitscrap 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitscrap 총 갯수
	 * @exception
	 */
    int selectJnitscrapListTotCnt(JnitscrapDefaultVO searchVO);
    
    /**
     * jnitscrap 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitscrap() throws Exception;
}
