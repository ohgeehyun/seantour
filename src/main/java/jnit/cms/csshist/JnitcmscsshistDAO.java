/**
 * @version 3.2.0.1
 */
package jnit.cms.csshist;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmscsshistDAO.java
 * @Description : Jnitcmscsshist DAO Class
 * @Modification Information
 *
 * @author JNITCMSCSSHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmscsshistDAO")
public class JnitcmscsshistDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSCSSHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmscsshistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmscsshist(JnitcmscsshistVO vo) throws Exception {
        return (String)insert("jnitcmscsshistDAO.insertJnitcmscsshist_S", vo);
    }

    /**
	 * JNITCMSCSSHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscsshistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmscsshist(JnitcmscsshistVO vo) throws Exception {
        update("jnitcmscsshistDAO.updateJnitcmscsshist_S", vo);
    }

    /**
	 * JNITCMSCSSHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmscsshistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmscsshist(JnitcmscsshistVO vo) throws Exception {
        delete("jnitcmscsshistDAO.deleteJnitcmscsshist_S", vo);
    }

    /**
	 * JNITCMSCSSHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscsshistVO
	 * @return 조회한 JNITCMSCSSHIST
	 * @exception Exception
	 */
    public JnitcmscsshistVO selectJnitcmscsshist(JnitcmscsshistVO vo) throws Exception {
        return (JnitcmscsshistVO) select("jnitcmscsshistDAO.selectJnitcmscsshist_S", vo);
    }

    /**
	 * JNITCMSCSSHIST 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCSSHIST 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmscsshistList(JnitcmscsshistDefaultVO searchVO) throws Exception {
        return list("jnitcmscsshistDAO.selectJnitcmscsshistList_D", searchVO);
    }

    /**
	 * JNITCMSCSSHIST 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCSSHIST 총 갯수
	 * @exception
	 */
    public int selectJnitcmscsshistListTotCnt(JnitcmscsshistDefaultVO searchVO) {
        return (Integer)select("jnitcmscsshistDAO.selectJnitcmscsshistListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSCSSHIST 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmscsshist() {
    	return (String)select("jnitcmscsshistDAO.getLastIdJnitcmscsshist_S");
    }
}
