/**
 * @version 3.2.0.1
 */
package jnit.sms.mgov;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitsmsmgovDAO.java
 * @Description : Jnitsmsmgov DAO Class
 * @Modification Information
 *
 * @author JNITSMSMGOV
 * @since 2013.11.25
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitsmsmgovDAO")
public class JnitsmsmgovDAO extends EgovComAbstractDAO {

	/**
	 * jnitsmsmgov을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitsmsmgovVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitsmsmgov(JnitsmsmgovVO vo) throws Exception {
        return (String)insert("jnitsmsmgovDAO.insertJnitsmsmgov_S", vo);
    }

    /**
	 * jnitsmsmgov을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitsmsmgovVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitsmsmgov(JnitsmsmgovVO vo) throws Exception {
        update("jnitsmsmgovDAO.updateJnitsmsmgov_S", vo);
    }

    /**
	 * jnitsmsmgov을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitsmsmgovVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitsmsmgov(JnitsmsmgovVO vo) throws Exception {
        delete("jnitsmsmgovDAO.deleteJnitsmsmgov_S", vo);
    }

    /**
	 * jnitsmsmgov을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitsmsmgovVO
	 * @return 조회한 jnitsmsmgov
	 * @exception Exception
	 */
    public JnitsmsmgovVO selectJnitsmsmgov(JnitsmsmgovVO vo) throws Exception {
        return (JnitsmsmgovVO) select("jnitsmsmgovDAO.selectJnitsmsmgov_S", vo);
    }

    /**
	 * jnitsmsmgov 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitsmsmgov 목록
	 * @exception Exception
	 */
    public List<?> selectJnitsmsmgovList(JnitsmsmgovDefaultVO searchVO) throws Exception {
        return list("jnitsmsmgovDAO.selectJnitsmsmgovList_D", searchVO);
    }

    /**
	 * jnitsmsmgov 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitsmsmgov 총 갯수
	 * @exception
	 */
    public int selectJnitsmsmgovListTotCnt(JnitsmsmgovDefaultVO searchVO) {
        return (Integer)select("jnitsmsmgovDAO.selectJnitsmsmgovListTotCnt_S", searchVO);
    }

    /**
	 * jnitsmsmgov 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitsmsmgov() {
    	return (String)select("jnitsmsmgovDAO.getLastIdJnitsmsmgov_S");
    }
}
