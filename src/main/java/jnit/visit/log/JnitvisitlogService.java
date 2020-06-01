/**
 * @version 3.2.0.1
 */
package jnit.visit.log;

import java.util.List;

/**
 * @Class Name : JnitvisitlogService.java
 * @Description : Jnitvisitlog Business class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitvisitlogService {
	
	/**
	 * JNITVISITLOG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitvisitlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitvisitlog(JnitvisitlogVO vo) throws Exception;

    /**
	 * JNITVISITLOG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITVISITLOG 총 갯수
	 * @exception
	 */
    int selectJnitvisitlogDataCnt(JnitvisitlogVO jnitvisitlogVO);
    
    /**
	 * JNITVISITLOG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitvisitlogVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitvisitlog(JnitvisitlogVO vo) throws Exception;
    
    /**
	 * JNITVISITLOG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitvisitlogVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitvisitlog(JnitvisitlogVO vo) throws Exception;
    
    /**
	 * JNITVISITLOG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitvisitlogVO
	 * @return 조회한 JNITVISITLOG
	 * @exception Exception
	 */
    JnitvisitlogVO selectJnitvisitlog(JnitvisitlogVO vo) throws Exception;
    
    /**
	 * JNITVISITLOG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITVISITLOG 목록
	 * @exception Exception
	 */
    List selectJnitvisitlogList(JnitvisitlogDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITVISITLOG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITVISITLOG 총 갯수
	 * @exception
	 */
    int selectJnitvisitlogListTotCnt(JnitvisitlogDefaultVO searchVO);
    
    /**
     * JNITVISITLOG 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitvisitlog() throws Exception;
}
