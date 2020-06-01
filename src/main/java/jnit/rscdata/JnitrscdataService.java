/**
 * @version 3.2.0.1
 */
package jnit.rscdata;

import java.util.List;

/**
 * @Class Name : JnitrscdataService.java
 * @Description : Jnitrscdata Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.04
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitrscdataService {
	
	/**
	 * JNITRSCDATA을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitrscdataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitrscdata(JnitrscdataVO vo) throws Exception;
    
    /**
	 * JNITRSCDATA을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitrscdataVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitrscdata(JnitrscdataVO vo) throws Exception;
    
    /**
	 * JNITRSCDATA을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitrscdataVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitrscdata(JnitrscdataVO vo) throws Exception;
    
    /**
	 * JNITRSCDATA을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitrscdataVO
	 * @return 조회한 JNITRSCDATA
	 * @exception Exception
	 */
    JnitrscdataVO selectJnitrscdata(JnitrscdataVO vo) throws Exception;
    
    /**
	 * JNITRSCDATA 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITRSCDATA 목록
	 * @exception Exception
	 */
    List selectJnitrscdataList(JnitrscdataDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITRSCDATA 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITRSCDATA 총 갯수
	 * @exception
	 */
    int selectJnitrscdataListTotCnt(JnitrscdataDefaultVO searchVO);
    
    /**
     * JNITRSCDATA 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitrscdata() throws Exception;
}
