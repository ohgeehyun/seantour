/**
 * @version 3.2.0.1
 */
package jnit.sms.data;

import java.util.List;

/**
 * @Class Name : SmsdataService.java
 * @Description : Smsdata Business class
 * @Modification Information
 *
 * @author JNITSMSDATA
 * @since 2014.02.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface SmsdataService {
	
	/**
	 * SMSDATA을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SmsdataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertSmsdata(SmsdataVO vo) throws Exception;
    
    /**
	 * SMSDATA을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SmsdataVO
	 * @return void형
	 * @exception Exception
	 */
    void updateSmsdata(SmsdataVO vo) throws Exception;
    
    /**
	 * SMSDATA을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SmsdataVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteSmsdata(SmsdataVO vo) throws Exception;
    
    /**
	 * SMSDATA을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SmsdataVO
	 * @return 조회한 SMSDATA
	 * @exception Exception
	 */
    SmsdataVO selectSmsdata(SmsdataVO vo) throws Exception;
    
    /**
	 * SMSDATA 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SMSDATA 목록
	 * @exception Exception
	 */
    List selectSmsdataList(SmsdataDefaultVO searchVO) throws Exception;
    
    /**
	 * SMSDATA 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SMSDATA 총 갯수
	 * @exception
	 */
    int selectSmsdataListTotCnt(SmsdataDefaultVO searchVO);
    
    /**
     * SMSDATA 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdSmsdata() throws Exception;
}
