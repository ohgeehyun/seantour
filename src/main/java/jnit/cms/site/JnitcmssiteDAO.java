/**
 * @version 3.2.0.1
 */
package jnit.cms.site;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmssiteDAO.java
 * @Description : Jnitcmssite DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmssiteDAO")
public class JnitcmssiteDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSSITE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmssiteVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmssite(JnitcmssiteVO vo) throws Exception {
        return (String)insert("jnitcmssiteDAO.insertJnitcmssite_S", vo);
    }

    /**
	 * JNITCMSSITE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmssiteVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmssite(JnitcmssiteVO vo) throws Exception {
        update("jnitcmssiteDAO.updateJnitcmssite_S", vo);
    }

    /**
	 * JNITCMSSITE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmssiteVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmssite(JnitcmssiteVO vo) throws Exception {
        delete("jnitcmssiteDAO.deleteJnitcmssite_S", vo);
    }

    /**
	 * JNITCMSSITE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmssiteVO
	 * @return 조회한 JNITCMSSITE
	 * @exception Exception
	 */
    public JnitcmssiteVO selectJnitcmssite(JnitcmssiteVO vo) throws Exception {
        return (JnitcmssiteVO) select("jnitcmssiteDAO.selectJnitcmssite_S", vo);
    }

    /**
	 * JNITCMSSITE 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSSITE 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmssiteList(JnitcmssiteDefaultVO searchVO) throws Exception {
        return list("jnitcmssiteDAO.selectJnitcmssiteList_D", searchVO);
    }

    /**
	 * JNITCMSSITE 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSSITE 총 갯수
	 * @exception
	 */
    public int selectJnitcmssiteListTotCnt(JnitcmssiteDefaultVO searchVO) {
        return (Integer)select("jnitcmssiteDAO.selectJnitcmssiteListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSSITE 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmssite() {
    	return (String)select("jnitcmssiteDAO.getLastIdJnitcmssite_S");
    }
    
    /**
	 * JNITCMSSITE 다음 등록 ORD를 조회한다.
	 * @param void
	 * @return 다음 등록 ORD
	 * @exception
	 */
    public int getNextOrdJnitcmssite() {
    	return (Integer)select("jnitcmssiteDAO.getNextOrdJnitcmssite_S");
    }
    
    /**
     * SITE_ID를 공용코드방식으로 불러온다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<CmmnDetailCode> selectSiteIdDetail(ComDefaultCodeVO vo) throws Exception {
    	return (List<CmmnDetailCode>) list("jnitcmssiteDAO.selectSiteIdDetail", vo);
    }
}
