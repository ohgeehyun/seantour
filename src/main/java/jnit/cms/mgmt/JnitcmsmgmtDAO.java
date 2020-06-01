/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmt;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmgmtDAO.java
 * @Description : Jnitcmsmgmt DAO Class
 * @Modification Information
 *
 * @author JNITCMSMGMT
 * @since 2014.04.16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmgmtDAO")
public class JnitcmsmgmtDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMGMT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception {
        return (String)insert("jnitcmsmgmtDAO.insertJnitcmsmgmt_S", vo);
    }

    /**
	 * JNITCMSMGMT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception {
        update("jnitcmsmgmtDAO.updateJnitcmsmgmt_S", vo);
    }

    /**
	 * JNITCMSMGMT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception {
        delete("jnitcmsmgmtDAO.deleteJnitcmsmgmt_S", vo);
    }

    /**
	 * JNITCMSMGMT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtVO
	 * @return 조회한 JNITCMSMGMT
	 * @exception Exception
	 */
    public JnitcmsmgmtVO selectJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception {
        return (JnitcmsmgmtVO) select("jnitcmsmgmtDAO.selectJnitcmsmgmt_S", vo);
    }

    /**
	 * JNITCMSMGMT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMGMT 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmgmtList(JnitcmsmgmtDefaultVO searchVO) throws Exception {
        return list("jnitcmsmgmtDAO.selectJnitcmsmgmtList_D", searchVO);
    }

    /**
	 * JNITCMSMGMT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMGMT 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmgmtListTotCnt(JnitcmsmgmtDefaultVO searchVO) {
        return (Integer)select("jnitcmsmgmtDAO.selectJnitcmsmgmtListTotCnt_S", searchVO);
    }
    
    /**
	 * JNITCMSMGMT MAX값을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMGMT MAX
	 * @exception
	 */
    public int selectMaxTotCnt(JnitcmsmgmtDefaultVO searchVO) {
        return (Integer)select("jnitcmsmgmtDAO.selectMaxTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSMGMT 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmgmt() {
    	return (String)select("jnitcmsmgmtDAO.getLastIdJnitcmsmgmt_S");
    }
}
