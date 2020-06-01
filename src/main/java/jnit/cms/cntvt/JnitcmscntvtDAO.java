/**
 * @version 3.2.0.1
 */
package jnit.cms.cntvt;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmscntvtDAO.java
 * @Description : Jnitcmscntvt DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmscntvtDAO")
public class JnitcmscntvtDAO extends EgovComAbstractDAO {

    /**
	 * JNITCMSCNTVT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscntvtVO
	 * @return 조회한 JNITCMSCNTVT
	 * @exception Exception
	 */
    public JnitcmscntvtVO selectJnitcmscntvt(JnitcmscntvtVO vo) throws Exception {
        return (JnitcmscntvtVO) select("jnitcmscntvtDAO.selectJnitcmscntvt_S", vo);
    }

    /**
	 * JNITCMSCNTVT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCNTVT 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmscntvtList(JnitcmscntvtDefaultVO searchVO) throws Exception {
        return list("jnitcmscntvtDAO.selectJnitcmscntvtList_D", searchVO);
    }

    /**
	 * JNITCMSCNTVT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCNTVT 총 갯수
	 * @exception
	 */
    public int selectJnitcmscntvtListTotCnt(JnitcmscntvtDefaultVO searchVO) {
        return (Integer)select("jnitcmscntvtDAO.selectJnitcmscntvtListTotCnt_S", searchVO);
    }

}
