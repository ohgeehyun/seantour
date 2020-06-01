/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrlog;

import java.util.List;

/**
 * @Class Name : JnitcmsmbrlogService.java
 * @Description : Jnitcmsmbrlog Business class
 * @Modification Information
 *
 * @author JNITCMSMBRLOG
 * @since 2014.03.09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmbrlogService {
	
	/**
	 * JNITCMSMBRLOG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRLOG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrlogVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRLOG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrlogVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRLOG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrlogVO
	 * @return 조회한 JNITCMSMBRLOG
	 * @exception Exception
	 */
    JnitcmsmbrlogVO selectJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception;
    
    /**
	 * JNITCMSMBRLOG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRLOG 목록
	 * @exception Exception
	 */
    List selectJnitcmsmbrlogList(JnitcmsmbrlogDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMBRLOG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRLOG 목록
	 * @exception Exception
	 */
    List selectLeftcmsmbrlogList(JnitcmsmbrlogDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMBRLOG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRLOG 총 갯수
	 * @exception
	 */
    int selectJnitcmsmbrlogListTotCnt(JnitcmsmbrlogDefaultVO searchVO);
    
    /**
	 * JNITCMSMBRLOG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRLOG 총 갯수
	 * @exception
	 */
    int selectLeftcmsmbrlogListTotCnt(JnitcmsmbrlogDefaultVO searchVO);
    
    /**
     * JNITCMSMBRLOG 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmbrlog() throws Exception;
}
