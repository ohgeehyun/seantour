/**
 * @version 3.2.0.1
 */
package jnit.cms.scripthist;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsscripthistDAO.java
 * @Description : Jnitcmsscripthist DAO Class
 * @Modification Information
 *
 * @author JNITCMSSCRIPTHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsscripthistDAO")
public class JnitcmsscripthistDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSSCRIPTHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsscripthistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception {
        return (String)insert("jnitcmsscripthistDAO.insertJnitcmsscripthist_S", vo);
    }

    /**
	 * JNITCMSSCRIPTHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsscripthistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception {
        update("jnitcmsscripthistDAO.updateJnitcmsscripthist_S", vo);
    }

    /**
	 * JNITCMSSCRIPTHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsscripthistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception {
        delete("jnitcmsscripthistDAO.deleteJnitcmsscripthist_S", vo);
    }

    /**
	 * JNITCMSSCRIPTHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsscripthistVO
	 * @return 조회한 JNITCMSSCRIPTHIST
	 * @exception Exception
	 */
    public JnitcmsscripthistVO selectJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception {
        return (JnitcmsscripthistVO) select("jnitcmsscripthistDAO.selectJnitcmsscripthist_S", vo);
    }

    /**
	 * JNITCMSSCRIPTHIST 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSSCRIPTHIST 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsscripthistList(JnitcmsscripthistDefaultVO searchVO) throws Exception {
        return list("jnitcmsscripthistDAO.selectJnitcmsscripthistList_D", searchVO);
    }

    /**
	 * JNITCMSSCRIPTHIST 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSSCRIPTHIST 총 갯수
	 * @exception
	 */
    public int selectJnitcmsscripthistListTotCnt(JnitcmsscripthistDefaultVO searchVO) {
        return (Integer)select("jnitcmsscripthistDAO.selectJnitcmsscripthistListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSSCRIPTHIST 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsscripthist() {
    	return (String)select("jnitcmsscripthistDAO.getLastIdJnitcmsscripthist_S");
    }
}
