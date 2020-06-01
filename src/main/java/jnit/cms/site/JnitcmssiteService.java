/**
 * @version 3.2.0.1
 */
package jnit.cms.site;

import java.util.List;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;

/**
 * @Class Name : JnitcmssiteService.java
 * @Description : Jnitcmssite Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmssiteService {
	
	/**
	 * JNITCMSSITE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmssiteVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmssite(JnitcmssiteVO vo) throws Exception;
    
    /**
	 * JNITCMSSITE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmssiteVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmssite(JnitcmssiteVO vo) throws Exception;
    
    /**
	 * JNITCMSSITE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmssiteVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmssite(JnitcmssiteVO vo) throws Exception;
    
    /**
	 * JNITCMSSITE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmssiteVO
	 * @return 조회한 JNITCMSSITE
	 * @exception Exception
	 */
    JnitcmssiteVO selectJnitcmssite(JnitcmssiteVO vo) throws Exception;
    
    /**
	 * JNITCMSSITE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSSITE 목록
	 * @exception Exception
	 */
    List selectJnitcmssiteList(JnitcmssiteDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSSITE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSSITE 총 갯수
	 * @exception
	 */
    int selectJnitcmssiteListTotCnt(JnitcmssiteDefaultVO searchVO);
    
    /**
     * JNITCMSSITE 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmssite() throws Exception;
    
    /**
     * JNITCMSSITE 다음 등록 ORD를 조회한다
     * @param void
     * @return 다음 등록 ORD
     * @exception Exception
     */
    int getNextOrdJnitcmssite() throws Exception;
    
    /**
     * 사이트정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    List<CmmnDetailCode> selectSiteIdDetail(ComDefaultCodeVO vo) throws Exception;
}
