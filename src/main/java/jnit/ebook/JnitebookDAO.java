/**
 * @version 3.2.0.1
 */
package jnit.ebook;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitebookDAO.java
 * @Description : Jnitebook DAO Class
 * @Modification Information
 *
 * @author JNITEBOOK
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitebookDAO")
public class JnitebookDAO extends EgovComAbstractDAO {

	/**
	 * JNITEBOOK을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitebookVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitebook(JnitebookVO vo) throws Exception {
        return (String)insert("jnitebookDAO.insertJnitebook_S", vo);
    }

    /**
	 * JNITEBOOK을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitebookVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitebook(JnitebookVO vo) throws Exception {
        update("jnitebookDAO.updateJnitebook_S", vo);
    }

    /**
	 * JNITEBOOK을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitebookVO
	 * @return void형 
	 * @exception Exception
	 */
	    public void deleteJnitebook(JnitebookVO vo) throws Exception {
	        delete("jnitebookDAO.deleteJnitebook_S", vo);
	    }

    /**
	 * JNITEBOOK을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitebookVO
	 * @return 조회한 JNITEBOOK
	 * @exception Exception
	 */
    public JnitebookVO selectJnitebook(JnitebookVO vo) throws Exception {
        return (JnitebookVO) select("jnitebookDAO.selectJnitebook_S", vo);
    }

    /**
	 * JNITEBOOK 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITEBOOK 목록
	 * @exception Exception
	 */
    public List<?> selectJnitebookList(JnitebookDefaultVO searchVO) throws Exception {
        return list("jnitebookDAO.selectJnitebookList_D", searchVO);
    }

    /**
	 * JNITEBOOK 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITEBOOK 총 갯수
	 * @exception
	 */
    public int selectJnitebookListTotCnt(JnitebookDefaultVO searchVO) {
        return (Integer)select("jnitebookDAO.selectJnitebookListTotCnt_S", searchVO);
    }

    /**
	 * JNITEBOOK 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitebook() {
    	return (String)select("jnitebookDAO.getLastIdJnitebook_S");
    }
}
