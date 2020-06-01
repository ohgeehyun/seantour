/**
 * @version 3.2.0.1
 */
package jnit.sms.data;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : SmsdataDAO.java
 * @Description : Smsdata DAO Class
 * @Modification Information
 *
 * @author JNITSMSDATA
 * @since 2014.02.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("smsdataDAO")
public class SmsdataDAO extends EgovComAbstractDAO {

	/**
	 * SMSDATA을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SmsdataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSmsdata(SmsdataVO vo) throws Exception {
        return (String)insert("smsdataDAO.insertSmsdata_S", vo);
    }

    /**
	 * SMSDATA을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SmsdataVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSmsdata(SmsdataVO vo) throws Exception {
        update("smsdataDAO.updateSmsdata_S", vo);
    }

    /**
	 * SMSDATA을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SmsdataVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSmsdata(SmsdataVO vo) throws Exception {
        delete("smsdataDAO.deleteSmsdata_S", vo);
    }

    /**
	 * SMSDATA을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SmsdataVO
	 * @return 조회한 SMSDATA
	 * @exception Exception
	 */
    public SmsdataVO selectSmsdata(SmsdataVO vo) throws Exception {
        return (SmsdataVO) select("smsdataDAO.selectSmsdata_S", vo);
    }

    /**
	 * SMSDATA 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SMSDATA 목록
	 * @exception Exception
	 */
    public List<?> selectSmsdataList(SmsdataDefaultVO searchVO) throws Exception {
        return list("smsdataDAO.selectSmsdataList_D", searchVO);
    }

    /**
	 * SMSDATA 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return SMSDATA 총 갯수
	 * @exception
	 */
    public int selectSmsdataListTotCnt(SmsdataDefaultVO searchVO) {
        return (Integer)select("smsdataDAO.selectSmsdataListTotCnt_S", searchVO);
    }

    /**
	 * SMSDATA 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdSmsdata() {
    	return (String)select("smsdataDAO.getLastIdSmsdata_S");
    }
}
