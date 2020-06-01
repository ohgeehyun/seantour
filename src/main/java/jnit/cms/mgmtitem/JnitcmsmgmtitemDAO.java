/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtitem;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmgmtitemDAO.java
 * @Description : Jnitcmsmgmtitem DAO Class
 * @Modification Information
 *
 * @author JNITCMSMGMTITEM
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmgmtitemDAO")
public class JnitcmsmgmtitemDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMGMTITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception {
        return (String)insert("jnitcmsmgmtitemDAO.insertJnitcmsmgmtitem_S", vo);
    }

    /**
	 * JNITCMSMGMTITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception {
        update("jnitcmsmgmtitemDAO.updateJnitcmsmgmtitem_S", vo);
    }

    /**
	 * JNITCMSMGMTITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception {
        delete("jnitcmsmgmtitemDAO.deleteJnitcmsmgmtitem_S", vo);
    }

    /**
	 * JNITCMSMGMTITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return 조회한 JNITCMSMGMTITEM
	 * @exception Exception
	 */
    public JnitcmsmgmtitemVO selectJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception {
        return (JnitcmsmgmtitemVO) select("jnitcmsmgmtitemDAO.selectJnitcmsmgmtitem_S", vo);
    }

    /**
	 * JNITCMSMGMTITEM 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMGMTITEM 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmgmtitemList(JnitcmsmgmtitemDefaultVO searchVO) throws Exception {
        return list("jnitcmsmgmtitemDAO.selectJnitcmsmgmtitemList_D", searchVO);
    }

    /**
	 * JNITCMSMGMTITEM 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMGMTITEM 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmgmtitemListTotCnt(JnitcmsmgmtitemDefaultVO searchVO) {
        return (Integer)select("jnitcmsmgmtitemDAO.selectJnitcmsmgmtitemListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSMGMTITEM 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmgmtitem() {
    	return (String)select("jnitcmsmgmtitemDAO.getLastIdJnitcmsmgmtitem_S");
    }
}
