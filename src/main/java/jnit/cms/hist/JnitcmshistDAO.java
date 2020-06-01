/**
 * @version 3.2.0.1
 */
package jnit.cms.hist;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmshistDAO.java
 * @Description : Jnitcmshist DAO Class
 * @Modification Information
 *
 * @author tactful
 * @since 2012.12.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmshistDAO")
public class JnitcmshistDAO extends EgovComAbstractDAO {

	/**
	 * jnitcmshist을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmshistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmshist(JnitcmshistVO vo) throws Exception {
        return (String)insert("jnitcmshistDAO.insertJnitcmshist_S", vo);
    }

    /**
	 * jnitcmshist을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmshistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmshist(JnitcmshistVO vo) throws Exception {
        update("jnitcmshistDAO.updateJnitcmshist_S", vo);
    }

    /**
	 * jnitcmshist을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmshistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmshist(JnitcmshistVO vo) throws Exception {
        delete("jnitcmshistDAO.deleteJnitcmshist_S", vo);
    }

    /**
	 * jnitcmshist을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmshistVO
	 * @return 조회한 jnitcmshist
	 * @exception Exception
	 */
    public JnitcmshistVO selectJnitcmshist(JnitcmshistVO vo) throws Exception {
        return (JnitcmshistVO) select("jnitcmshistDAO.selectJnitcmshist_S", vo);
    }

    /**
	 * jnitcmshist 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmshist 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmshistList(JnitcmshistDefaultVO searchVO) throws Exception {
        return list("jnitcmshistDAO.selectJnitcmshistList_D", searchVO);
    }

    /**
	 * jnitcmshist 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmshist 총 갯수
	 * @exception
	 */
    public int selectJnitcmshistListTotCnt(JnitcmshistDefaultVO searchVO) {
        return (Integer)select("jnitcmshistDAO.selectJnitcmshistListTotCnt_S", searchVO);
    }

    /**
	 * jnitcmshist 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmshist() {
    	return (String)select("jnitcmshistDAO.getLastIdJnitcmshist_S");
    }
}
