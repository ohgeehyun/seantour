/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminate;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsdisseminateDAO.java
 * @Description : Jnitcmsdisseminate DAO Class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATE
 * @since 2013.11.05
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsdisseminateDAO")
public class JnitcmsdisseminateDAO extends EgovComAbstractDAO {

	/**
	 * jnitcmsdisseminate을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        return (String)insert("jnitcmsdisseminateDAO.insertJnitcmsdisseminate_S", vo);
    }

    /**
	 * jnitcmsdisseminate을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        update("jnitcmsdisseminateDAO.updateJnitcmsdisseminate_S", vo);
    }
    
    /**
	 * jnitcmsdisseminate을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateNextdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        update("jnitcmsdisseminateDAO.updateNextdisseminate_S", vo);
    }

    /**
	 * jnitcmsdisseminate을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsdisseminateVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        delete("jnitcmsdisseminateDAO.deleteJnitcmsdisseminate_S", vo);
    }

    /**
	 * jnitcmsdisseminate을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 조회한 jnitcmsdisseminate
	 * @exception Exception
	 */
    public JnitcmsdisseminateVO selectJnitcmsdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        return (JnitcmsdisseminateVO) select("jnitcmsdisseminateDAO.selectJnitcmsdisseminate_S", vo);
    }
    
    /**
	 * jnitcmsdisseminate을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminateVO
	 * @return 조회한 jnitcmsdisseminate
	 * @exception Exception
	 */
    public JnitcmsdisseminateVO selectdisseminate(JnitcmsdisseminateVO vo) throws Exception {
        return (JnitcmsdisseminateVO) select("jnitcmsdisseminateDAO.selectdisseminate_S", vo);
    }

    /**
	 * jnitcmsdisseminate 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminate 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsdisseminateList(JnitcmsdisseminateDefaultVO searchVO) throws Exception {
        return list("jnitcmsdisseminateDAO.selectJnitcmsdisseminateList_D", searchVO);
    }
    /**
	 * jnitcmsdisseminate 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminate 목록
	 * @exception Exception
	 */
    public List<?> selectdisseminateList(JnitcmsdisseminateDefaultVO searchVO) throws Exception {
        return list("jnitcmsdisseminateDAO.selectdisseminateList_D", searchVO);
    }

    /**
	 * jnitcmsdisseminate 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    public int selectJnitcmsdisseminateListTotCnt(JnitcmsdisseminateDefaultVO searchVO) {
        return (Integer)select("jnitcmsdisseminateDAO.selectJnitcmsdisseminateListTotCnt_S", searchVO);
    }
    
    /**
	 * jnitcmsdisseminate JOIN 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    public int selectdisseminateListTotCnt(JnitcmsdisseminateDefaultVO searchVO) {
        return (Integer)select("jnitcmsdisseminateDAO.selectdisseminateListTotCnt_S", searchVO);
    }
    /**
	 * jnitcmsdisseminate JOIN 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitcmsdisseminate 총 갯수
	 * @exception
	 */
    public int maxTotCnt(JnitcmsdisseminateDefaultVO searchVO) {
        return (Integer)select("jnitcmsdisseminateDAO.maxTotCnt_S", searchVO);
    }
    /**
	 * jnitcmsdisseminate 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsdisseminate() {
    	return (String)select("jnitcmsdisseminateDAO.getLastIdJnitcmsdisseminate_S");
    }
}
