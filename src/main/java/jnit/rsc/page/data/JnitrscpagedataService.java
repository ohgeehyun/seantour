/**
 * @version 3.2.0.1
 */
package jnit.rsc.page.data;

import java.util.List;

/**
 * @Class Name : JnitrscpagedataService.java
 * @Description : Jnitrscpagedata Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitrscpagedataService {
	
	/**
	 * jnitrscpagedata을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscpagedataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitrscpagedata(JnitrscpagedataVO vo) throws Exception;
    
    /**
	 * jnitrscpagedata을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscpagedataVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitrscpagedata(JnitrscpagedataVO vo) throws Exception;
    
    /**
	 * jnitrscpagedata을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscpagedataVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitrscpagedata(JnitrscpagedataVO vo) throws Exception;
    
    /**
	 * jnitrscpagedata을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscpagedataVO
	 * @return 조회한 jnitrscpagedata
	 * @exception Exception
	 */
    JnitrscpagedataVO selectJnitrscpagedata(JnitrscpagedataVO vo) throws Exception;
    
    /**
	 * jnitrscpagedata 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitrscpagedata 목록
	 * @exception Exception
	 */
    List selectJnitrscpagedataList(JnitrscpagedataDefaultVO searchVO) throws Exception;
    
    /**
	 * jnitrscpagedata 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitrscpagedata 총 갯수
	 * @exception
	 */
    int selectJnitrscpagedataListTotCnt(JnitrscpagedataDefaultVO searchVO);
    
    /**
     * jnitrscpagedata 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitrscpagedata() throws Exception;
}
