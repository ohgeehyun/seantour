/**
 * @version 3.2.0.1
 */
package jnit.cms.rank;

import java.util.List;

import jnit.cms.CmsManageSub2_1Controller;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsrankDAO.java
 * @Description : Jnitcmsrank DAO Class
 * @Modification Information
 *
 * @author JNITCMSRANK
 * @since 2013.11.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsrankDAO")
public class JnitcmsrankDAO extends EgovComAbstractDAO {

	/**
	 * jnitcmsrank을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsrankVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsrank(JnitcmsrankVO vo) throws Exception {
        return (String)insert("jnitcmsrankDAO.insertJnitcmsrank_S", vo);
    }
    
    /**
	 * jnitcmsrank을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsrankVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertDbConnectrank(JnitcmsrankVO vo) throws Exception {
        return (String)insert("jnitcmsrankDAO.insertDbConnectrank_S", vo);
    }

    /**
	 * jnitcmsrank을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsrankVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsrank(JnitcmsrankVO vo) throws Exception {
        update("jnitcmsrankDAO.updateJnitcmsrank_S", vo);
    }

    /**
	 * jnitcmsrank을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsrankVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsrank(JnitcmsrankVO vo) throws Exception {
        delete("jnitcmsrankDAO.deleteJnitcmsrank_S", vo);
    }

    /**
	 * jnitcmsrank을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsrankVO
	 * @return 조회한 jnitcmsrank
	 * @exception Exception
	 */
    public JnitcmsrankVO selectJnitcmsrank(JnitcmsrankVO vo) throws Exception {
        return (JnitcmsrankVO) select("jnitcmsrankDAO.selectJnitcmsrank_S", vo);
    }

    /**
	 * jnitcmsrank 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsrank 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsrankList(JnitcmsrankDefaultVO searchVO) throws Exception {
        return list("jnitcmsrankDAO.selectJnitcmsrankList_D", searchVO);
    }
    
    /**
	 * jnitcmsrank 목록을 조회한다.
	 * JNITCMSORG - LEFT JOIN
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @see CmsManageSub2_1Controller
	 * <code>{@link jnit.cms.CmsManageSub2_1Controller # updateJnitcmsmbrView}</code>
	 * <code>{@link jnit.cms.CmsManageSub2_1Controller # Ajax_0102}</code>	 
	 * @return jnitcmsrank 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoinrankList(JnitcmsrankDefaultVO searchVO) throws Exception {
        return list("jnitcmsrankDAO.selectLeftJoinrankList_D", searchVO);
    }

    /**
	 * jnitcmsrank 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsrank 총 갯수
	 * @exception
	 */
    public int selectJnitcmsrankListTotCnt(JnitcmsrankDefaultVO searchVO) {
        return (Integer)select("jnitcmsrankDAO.selectJnitcmsrankListTotCnt_S", searchVO);
    }

    /**
	 * jnitcmsrank 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsrank() {
    	return (String)select("jnitcmsrankDAO.getLastIdJnitcmsrank_S");
    }
}
