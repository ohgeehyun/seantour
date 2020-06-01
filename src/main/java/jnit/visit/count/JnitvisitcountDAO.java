/**
 * @version 3.2.0.1
 */
package jnit.visit.count;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitvisitcountDAO.java
 * @Description : Jnitvisitcount DAO Class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.11.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitvisitcountDAO")
public class JnitvisitcountDAO extends EgovComAbstractDAO {

	/**
	 * jnitvisitcount을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitvisitcountVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitvisitcount(JnitvisitcountVO vo) throws Exception {
        return (String)insert("jnitvisitcountDAO.insertJnitvisitcount_S", vo);
    }

    /**
	 * jnitvisitcount을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitvisitcountVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitvisitcount(JnitvisitcountVO vo) throws Exception {
        update("jnitvisitcountDAO.updateJnitvisitcount_S", vo);
    }

    /**
	 * jnitvisitcount을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitvisitcountVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitvisitcount(JnitvisitcountVO vo) throws Exception {
        delete("jnitvisitcountDAO.deleteJnitvisitcount_S", vo);
    }

    /**
	 * jnitvisitcount을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitvisitcountVO
	 * @return 조회한 jnitvisitcount
	 * @exception Exception
	 */
    public JnitvisitcountVO selectJnitvisitcount(JnitvisitcountVO vo) throws Exception {
        return (JnitvisitcountVO) select("jnitvisitcountDAO.selectJnitvisitcount_S", vo);
    }
    
    /* total갯수만 조회한다. */
    public JnitvisitcountVO selectJnitvisitTotalCount(JnitvisitcountVO vo) throws Exception {
        return (JnitvisitcountVO) select("jnitvisitcountDAO.selectJnitvisitTotalCount_S", vo);
    }

    /**
	 * jnitvisitcount 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitvisitcount 목록
	 * @exception Exception
	 */
    public List<?> selectJnitvisitcountList(JnitvisitcountDefaultVO searchVO) throws Exception {
        return list("jnitvisitcountDAO.selectJnitvisitcountList_D", searchVO);
    }
    
    public List<?> selectJnitvisitSiteList(JnitvisitcountDefaultVO searchVO) throws Exception {
        return list("jnitvisitcountDAO.selectJnitvisitSiteList", searchVO);
    }

    /**
	 * jnitvisitcount 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitvisitcount 총 갯수
	 * @exception
	 */
    public int selectJnitvisitcountListTotCnt(JnitvisitcountDefaultVO searchVO) {
        return (Integer)select("jnitvisitcountDAO.selectJnitvisitcountListTotCnt_S", searchVO);
    }
    
    
    public int selectJnitvisitcountHitTotCnt(JnitvisitcountDefaultVO searchVO) {
        return (Integer)select("jnitvisitcountDAO.selectJnitvisitcountHitTotCnt", searchVO);
    }
    
    /**
	 * 방문자 접속통계를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitvisitcount 목록
	 * @exception Exception
	 */
    public List<?> selectJnitvisitcountStats(JnitvisitcountDefaultVO searchVO) throws Exception {
        return list("jnitvisitcountDAO.selectJnitvisitcountStats", searchVO);
    }

    /**
	 * jnitvisitcount 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitvisitcount() {
    	return (String)select("jnitvisitcountDAO.getLastIdJnitvisitcount_S");
    }
}
