/**
 * @version 3.2.0.1
 */
package jnit.board.cmt;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitboardcmtDAO.java
 * @Description : Jnitboardcmt DAO Class
 * @Modification Information
 *
 * @author JNITBOARDCMT
 * @since 2013.07.11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitboardcmtDAO")
public class JnitboardcmtDAO extends EgovComAbstractDAO {

	/**
	 * jnitboardcmt을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardcmtVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardcmt(JnitboardcmtVO vo) throws Exception {
        return (String)insert("jnitboardcmtDAO.insertJnitboardcmt_S", vo);
    }

    /**
	 * jnitboardcmt을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardcmtVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardcmt(JnitboardcmtVO vo) throws Exception {
        update("jnitboardcmtDAO.updateJnitboardcmt_S", vo);
    }

    /**
	 * jnitboardcmt을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardcmtVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardcmt(JnitboardcmtVO vo) throws Exception {
        delete("jnitboardcmtDAO.deleteJnitboardcmt_S", vo);
    }

    /**
	 * jnitboardcmt을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardcmtVO
	 * @return 조회한 jnitboardcmt
	 * @exception Exception
	 */
    public JnitboardcmtVO selectJnitboardcmt(JnitboardcmtVO vo) throws Exception {
        return (JnitboardcmtVO) select("jnitboardcmtDAO.selectJnitboardcmt_S", vo);
    }

    /**
	 * jnitboardcmt 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardcmt 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardcmtList(JnitboardcmtDefaultVO searchVO) throws Exception {
        return list("jnitboardcmtDAO.selectJnitboardcmtList_D", searchVO);
    }

    /**
	 * jnitboardcmt 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardcmt 총 갯수
	 * @exception
	 */
    public int selectJnitboardcmtListTotCnt(JnitboardcmtDefaultVO searchVO) {
        return (Integer)select("jnitboardcmtDAO.selectJnitboardcmtListTotCnt_S", searchVO);
    }

    /**
	 * jnitboardcmt 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitboardcmt() {
    	return (String)select("jnitboardcmtDAO.getLastIdJnitboardcmt_S");
    }
}
