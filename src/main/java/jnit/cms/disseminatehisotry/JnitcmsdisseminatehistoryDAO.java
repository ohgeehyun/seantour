/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminatehisotry;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsdisseminatehistoryDAO.java
 * @Description : Jnitcmsdisseminatehistory DAO Class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATEHISTORY
 * @since 2013.11.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsdisseminatehistoryDAO")
public class JnitcmsdisseminatehistoryDAO extends EgovComAbstractDAO {

	/**
	 * jnitcmsdisseminatehistory을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception {
        return (String)insert("jnitcmsdisseminatehistoryDAO.insertJnitcmsdisseminatehistory_S", vo);
    }

    /**
	 * jnitcmsdisseminatehistory을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception {
        update("jnitcmsdisseminatehistoryDAO.updateJnitcmsdisseminatehistory_S", vo);
    }

    /**
	 * jnitcmsdisseminatehistory을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception {
        delete("jnitcmsdisseminatehistoryDAO.deleteJnitcmsdisseminatehistory_S", vo);
    }

    /**
	 * jnitcmsdisseminatehistory을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return 조회한 jnitcmsdisseminatehistory
	 * @exception Exception
	 */
    public JnitcmsdisseminatehistoryVO selectJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception {
        return (JnitcmsdisseminatehistoryVO) select("jnitcmsdisseminatehistoryDAO.selectJnitcmsdisseminatehistory_S", vo);
    }

    /**
	 * jnitcmsdisseminatehistory 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminatehistory 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsdisseminatehistoryList(JnitcmsdisseminatehistoryDefaultVO searchVO) throws Exception {
        return list("jnitcmsdisseminatehistoryDAO.selectJnitcmsdisseminatehistoryList_D", searchVO);
    }
    
    /**
	 * jnitcmsdisseminatehistory 목록을 조회한다.
	 * LEFT JOIN JNITCMSSITE 
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminatehistory 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoinhistoryList(JnitcmsdisseminatehistoryDefaultVO searchVO) throws Exception {
        return list("jnitcmsdisseminatehistoryDAO.selectLeftJoinhistoryList_D", searchVO);
    }

    /**
	 * jnitcmsdisseminatehistory 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminatehistory 총 갯수
	 * @exception
	 */
    public int selectJnitcmsdisseminatehistoryListTotCnt(JnitcmsdisseminatehistoryDefaultVO searchVO) {
        return (Integer)select("jnitcmsdisseminatehistoryDAO.selectJnitcmsdisseminatehistoryListTotCnt_S", searchVO);
    }
    
    /**
	 * jnitcmsdisseminatehistory 총 갯수를 조회한다.
	 * LEFT JOIN JNITCMSSITE
	 * LEFT JOIN JNITCMSMBR
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminatehistory 총 갯수
	 * @exception
	 */
    public int selectLeftJoinListTotCnt(JnitcmsdisseminatehistoryDefaultVO searchVO) {
        return (Integer)select("jnitcmsdisseminatehistoryDAO.selectLeftJoinListTotCnt_S", searchVO);
    }

    /**
	 * jnitcmsdisseminatehistory 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsdisseminatehistory() {
    	return (String)select("jnitcmsdisseminatehistoryDAO.getLastIdJnitcmsdisseminatehistory_S");
    }
}
