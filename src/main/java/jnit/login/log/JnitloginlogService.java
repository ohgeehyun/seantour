/**
 * @version 3.2.0.1
 */
package jnit.login.log;

import java.util.List;

/**
 * @Class Name : JnitloginlogService.java
 * @Description : Jnitloginlog Business class
 * @Modification Information
 *
 * @author JNITLOGINLOG
 * @since 2013.07.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitloginlogService {
	
	/**
	 * jnitloginlog을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitloginlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitloginlog(JnitloginlogVO vo) throws Exception;
    
    /**
	 * jnitloginlog을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitloginlogVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitloginlog(JnitloginlogVO vo) throws Exception;
    
    /**
	 * jnitloginlog을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitloginlogVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitloginlog(JnitloginlogVO vo) throws Exception;
    
    /**
	 * jnitloginlog을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitloginlogVO
	 * @return 조회한 jnitloginlog
	 * @exception Exception
	 */
    JnitloginlogVO selectJnitloginlog(JnitloginlogVO vo) throws Exception;
    
    /**
	 * jnitloginlog 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitloginlog 목록
	 * @exception Exception
	 */
    List selectJnitloginlogList(JnitloginlogDefaultVO searchVO) throws Exception;
    
    /**
     * LEFT JOIN
     * JNITCMSMBR b
     * JNITCMSORG c
     * JNITCMSPOS d 
	 * jnitloginlog 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitloginlog 목록
	 * @exception Exception
	 */
    List selectLeftJoinloginlogList(JnitloginlogDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitloginlog 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitloginlog 총 갯수
	 * @exception
	 */
    int selectJnitloginlogListTotCnt(JnitloginlogDefaultVO searchVO);
    
    /**
     * LEFT JOIN
     * JNITCMSMBR b
     * JNITCMSORG c
     * JNITCMSPOS d 
	 * jnitloginlog 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitloginlog 총 갯수
	 * @exception
	 */
    int selectLeftJoinloginlogListTotCnt(JnitloginlogDefaultVO searchVO);
    
    /**
     * jnitloginlog 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitloginlog() throws Exception;
}
