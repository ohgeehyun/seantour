/**
 * @version 3.2.0.1
 */
package jnit.cms.boardhist;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsboardhistDAO.java
 * @Description : Jnitcmsboardhist DAO Class
 * @Modification Information
 *
 * @author JNITCMSBOARDHIST
 * @since 2014.08.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsboardhistDAO")
public class JnitcmsboardhistDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSBOARDHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsboardhistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception {
        return (String)insert("jnitcmsboardhistDAO.insertJnitcmsboardhist_S", vo);
    }

    /**
	 * JNITCMSBOARDHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsboardhistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception {
        update("jnitcmsboardhistDAO.updateJnitcmsboardhist_S", vo);
    }

    /**
	 * JNITCMSBOARDHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsboardhistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception {
        delete("jnitcmsboardhistDAO.deleteJnitcmsboardhist_S", vo);
    }

    /**
	 * JNITCMSBOARDHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsboardhistVO
	 * @return 조회한 JNITCMSBOARDHIST
	 * @exception Exception
	 */
    public JnitcmsboardhistVO selectJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception {
        return (JnitcmsboardhistVO) select("jnitcmsboardhistDAO.selectJnitcmsboardhist_S", vo);
    }

    /**
	 * JNITCMSBOARDHIST 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSBOARDHIST 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsboardhistList(JnitcmsboardhistDefaultVO searchVO) throws Exception {
        return list("jnitcmsboardhistDAO.selectJnitcmsboardhistList_D", searchVO);
    }

    /**
	 * JNITCMSBOARDHIST 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSBOARDHIST 총 갯수
	 * @exception
	 */
    public int selectJnitcmsboardhistListTotCnt(JnitcmsboardhistDefaultVO searchVO) {
        return (Integer)select("jnitcmsboardhistDAO.selectJnitcmsboardhistListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSBOARDHIST 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsboardhist() {
    	return (String)select("jnitcmsboardhistDAO.getLastIdJnitcmsboardhist_S");
    }
}
