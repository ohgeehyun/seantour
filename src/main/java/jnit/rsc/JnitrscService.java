/**
 * @version 3.2.0.1
 */
package jnit.rsc;

import java.util.List;

/**
 * @Class Name : JnitrscService.java
 * @Description : Jnitrsc Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitrscService {
	
	/**
	 * JNITRSC을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitrsc(JnitrscVO vo) throws Exception;
    
    /**
	 * JNITRSC을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitrsc(JnitrscVO vo) throws Exception;
    
    /**
	 * JNITRSC을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitrsc(JnitrscVO vo) throws Exception;
    
    /**
	 * JNITRSC을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscVO
	 * @return 조회한 JNITRSC
	 * @exception Exception
	 */
    JnitrscVO selectJnitrsc(JnitrscVO vo) throws Exception;
    
    /**
	 * JNITRSC 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITRSC 목록
	 * @exception Exception
	 */
    List selectJnitrscList(JnitrscDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITRSC 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITRSC 총 갯수
	 * @exception
	 */
    int selectJnitrscListTotCnt(JnitrscDefaultVO searchVO);
    
    /**
     * JNITRSC 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitrsc() throws Exception;

    JnitrscVO selectJnitrscByUrl(String url);
}
