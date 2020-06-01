/**
 * @version 3.2.0.1
 */
package jnit.cms.org;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsorgDAO.java
 * @Description : Jnitcmsorg DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsorgDAO")
public class JnitcmsorgDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSORG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsorgVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsorg(JnitcmsorgVO vo) throws Exception {
        return (String)insert("jnitcmsorgDAO.insertJnitcmsorg_S", vo);
    }
    
    /**
	 * JNITCMSORG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsorgVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertDbConnectorg(JnitcmsorgVO vo) throws Exception {
        return (String)insert("jnitcmsorgDAO.insertDbConnectorg_S", vo);
    }

    /**
	 * JNITCMSORG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsorgVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsorg(JnitcmsorgVO vo) throws Exception {
        update("jnitcmsorgDAO.updateJnitcmsorg_S", vo);
    }

    /**
	 * JNITCMSORG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsorgVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsorg(JnitcmsorgVO vo) throws Exception {
        delete("jnitcmsorgDAO.deleteJnitcmsorg_S", vo);
    }

    /**
	 * JNITCMSORG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsorgVO
	 * @return 조회한 JNITCMSORG
	 * @exception Exception
	 */
    public JnitcmsorgVO selectJnitcmsorg(JnitcmsorgVO vo) throws Exception {
        return (JnitcmsorgVO) select("jnitcmsorgDAO.selectJnitcmsorg_S", vo);
    }

    /**
	 * JNITCMSORG 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSORG 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsorgList(JnitcmsorgDefaultVO searchVO) throws Exception {
        return list("jnitcmsorgDAO.selectJnitcmsorgList_D", searchVO);
    }
    
    /**
	 * JNITCMSORG 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSORG 목록
	 * @exception Exception
	 */
    public List<?> selectcmsorgList(JnitcmsorgDefaultVO searchVO) throws Exception {
        return list("jnitcmsorgDAO.selectorgList_D", searchVO);
    }

    /**
	 * JNITCMSORG 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSORG 총 갯수
	 * @exception
	 */
    public int selectJnitcmsorgListTotCnt(JnitcmsorgDefaultVO searchVO) {
        return (Integer)select("jnitcmsorgDAO.selectJnitcmsorgListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSORG 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsorg() {
    	return (String)select("jnitcmsorgDAO.getLastIdJnitcmsorg_S");
    }
    
    /**
     * ORG_ID를 공용코드방식으로 불러온다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<CmmnDetailCode> selectOrgIdDetail(ComDefaultCodeVO vo) throws Exception {
    	return (List<CmmnDetailCode>) list("jnitcmsorgDAO.selectOrgIdDetail", vo);
    }
}
