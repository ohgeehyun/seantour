/**
 * @version 3.2.0.1
 */
package jnit.cms.tplhist;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmstplhistDAO.java
 * @Description : Jnitcmstplhist DAO Class
 * @Modification Information
 *
 * @author JNITCMSTPLHIST
 * @since 2014.05.02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmstplhistDAO")
public class JnitcmstplhistDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSTPLHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmstplhistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmstplhist(JnitcmstplhistVO vo) throws Exception {
        return (String)insert("jnitcmstplhistDAO.insertJnitcmstplhist_S", vo);
    }

    /**
	 * JNITCMSTPLHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmstplhistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmstplhist(JnitcmstplhistVO vo) throws Exception {
        update("jnitcmstplhistDAO.updateJnitcmstplhist_S", vo);
    }

    /**
	 * JNITCMSTPLHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplhistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmstplhist(JnitcmstplhistVO vo) throws Exception {
        delete("jnitcmstplhistDAO.deleteJnitcmstplhist_S", vo);
    }

    /**
	 * JNITCMSTPLHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmstplhistVO
	 * @return 조회한 JNITCMSTPLHIST
	 * @exception Exception
	 */
    public JnitcmstplhistVO selectJnitcmstplhist(JnitcmstplhistVO vo) throws Exception {
        return (JnitcmstplhistVO) select("jnitcmstplhistDAO.selectJnitcmstplhist_S", vo);
    }

    /**
	 * JNITCMSTPLHIST 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSTPLHIST 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmstplhistList(JnitcmstplhistDefaultVO searchVO) throws Exception {
        return list("jnitcmstplhistDAO.selectJnitcmstplhistList_D", searchVO);
    }

    /**
	 * JNITCMSTPLHIST 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSTPLHIST 총 갯수
	 * @exception
	 */
    public int selectJnitcmstplhistListTotCnt(JnitcmstplhistDefaultVO searchVO) {
        return (Integer)select("jnitcmstplhistDAO.selectJnitcmstplhistListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSTPLHIST 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmstplhist() {
    	return (String)select("jnitcmstplhistDAO.getLastIdJnitcmstplhist_S");
    }
}
