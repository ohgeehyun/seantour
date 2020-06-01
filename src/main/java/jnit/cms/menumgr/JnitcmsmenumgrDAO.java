/**
 * @version 3.2.0.1
 */
package jnit.cms.menumgr;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmenumgrDAO.java
 * @Description : Jnitcmsmenumgr DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmenumgrDAO")
public class JnitcmsmenumgrDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMENUMGR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenumgrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception {
        return (String)insert("jnitcmsmenumgrDAO.insertJnitcmsmenumgr_S", vo);
    }

    /**
	 * JNITCMSMENUMGR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenumgrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception {
        update("jnitcmsmenumgrDAO.updateJnitcmsmenumgr_S", vo);
    }

    /**
	 * JNITCMSMENUMGR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenumgrVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception {
        delete("jnitcmsmenumgrDAO.deleteJnitcmsmenumgr_S", vo);
    }

    /**
	 * JNITCMSMENUMGR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenumgrVO
	 * @return 조회한 JNITCMSMENUMGR
	 * @exception Exception
	 */
    public JnitcmsmenumgrVO selectJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception {
        return (JnitcmsmenumgrVO) select("jnitcmsmenumgrDAO.selectJnitcmsmenumgr_S", vo);
    }

    /**
	 * JNITCMSMENUMGR 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMENUMGR 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmenumgrList(JnitcmsmenumgrDefaultVO searchVO) throws Exception {
        return list("jnitcmsmenumgrDAO.selectJnitcmsmenumgrList_D", searchVO);
    }

    /**
	 * JNITCMSMENUMGR 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMENUMGR 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenumgrListTotCnt(JnitcmsmenumgrDefaultVO searchVO) {
        return (Integer)select("jnitcmsmenumgrDAO.selectJnitcmsmenumgrListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSMENUMGR 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmenumgr() {
    	return (String)select("jnitcmsmenumgrDAO.getLastIdJnitcmsmenumgr_S");
    }
}
