/**
 * @version 3.2.0.1
 */
package jnit.scrap;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitscrapDAO.java
 * @Description : Jnitscrap DAO Class
 * @Modification Information
 *
 * @author tactful
 * @since 2013.03.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitscrapDAO")
public class JnitscrapDAO extends EgovComAbstractDAO {

	/**
	 * jnitscrap을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitscrapVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitscrap(JnitscrapVO vo) throws Exception {
        return (String)insert("jnitscrapDAO.insertJnitscrap_S", vo);
    }

    /**
	 * jnitscrap을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitscrapVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitscrap(JnitscrapVO vo) throws Exception {
        update("jnitscrapDAO.updateJnitscrap_S", vo);
    }

    /**
	 * jnitscrap을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitscrapVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitscrap(JnitscrapVO vo) throws Exception {
        delete("jnitscrapDAO.deleteJnitscrap_S", vo);
    }

    /**
	 * jnitscrap을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitscrapVO
	 * @return 조회한 jnitscrap
	 * @exception Exception
	 */
    public JnitscrapVO selectJnitscrap(JnitscrapVO vo) throws Exception {
        return (JnitscrapVO) select("jnitscrapDAO.selectJnitscrap_S", vo);
    }

    /**
	 * jnitscrap 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitscrap 목록
	 * @exception Exception
	 */
    public List<?> selectJnitscrapList(JnitscrapDefaultVO searchVO) throws Exception {
        return list("jnitscrapDAO.selectJnitscrapList_D", searchVO);
    }

    /**
	 * jnitscrap 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitscrap 총 갯수
	 * @exception
	 */
    public int selectJnitscrapListTotCnt(JnitscrapDefaultVO searchVO) {
        return (Integer)select("jnitscrapDAO.selectJnitscrapListTotCnt_S", searchVO);
    }

    /**
	 * jnitscrap 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitscrap() {
    	return (String)select("jnitscrapDAO.getLastIdJnitscrap_S");
    }
}
