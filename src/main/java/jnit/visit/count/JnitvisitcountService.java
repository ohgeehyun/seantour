/**
 * @version 3.2.0.1
 */
package jnit.visit.count;

import java.util.List;

/**
 * @Class Name : JnitvisitcountService.java
 * @Description : Jnitvisitcount Business class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.11.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitvisitcountService {
	
	/**
	 * jnitvisitcount을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitvisitcountVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitvisitcount(JnitvisitcountVO vo) throws Exception;
    
    /**
	 * jnitvisitcount을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitvisitcountVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitvisitcount(JnitvisitcountVO vo) throws Exception;
    
    /**
	 * jnitvisitcount을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitvisitcountVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitvisitcount(JnitvisitcountVO vo) throws Exception;
    
    /**
	 * jnitvisitcount을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitvisitcountVO
	 * @return 조회한 jnitvisitcount
	 * @exception Exception
	 */
    JnitvisitcountVO selectJnitvisitcount(JnitvisitcountVO vo) throws Exception;
    
    /* total갯수만 조회한다. */
    JnitvisitcountVO selectJnitvisitTotalCount(JnitvisitcountVO vo) throws Exception;
    /**
	 * jnitvisitcount 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitvisitcount 목록
	 * @exception Exception
	 */
    List selectJnitvisitcountList(JnitvisitcountDefaultVO searchVO) throws Exception;
    
    /*사이트 검색용*/
    List selectJnitvisitSiteList(JnitvisitcountDefaultVO searchVO) throws Exception;
    /**
	 * jnitvisitcount 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitvisitcount 총 갯수
	 * @exception
	 */
    int selectJnitvisitcountListTotCnt(JnitvisitcountDefaultVO searchVO);
    
    /**
	 * jnitvisitcount HIT 총합을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitvisitcount 총 갯수
	 * @exception
	 */
    int selectJnitvisitcountHitTotCnt(JnitvisitcountDefaultVO searchVO);
    
    /**
	 * 방문자 접속통계를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitvisitcount 목록
	 * @exception Exception
	 */
    List selectJnitvisitcountStats(JnitvisitcountDefaultVO searchVO) throws Exception;
    
    /**
     * jnitvisitcount 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitvisitcount() throws Exception;
}
