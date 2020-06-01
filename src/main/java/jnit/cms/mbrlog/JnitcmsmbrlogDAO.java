/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrlog;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmbrlogDAO.java
 * @Description : Jnitcmsmbrlog DAO Class
 * @Modification Information
 *
 * @author JNITCMSMBRLOG
 * @since 2014.03.09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmbrlogDAO")
public class JnitcmsmbrlogDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMBRLOG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception {
        return (String)insert("jnitcmsmbrlogDAO.insertJnitcmsmbrlog_S", vo);
    }

    /**
	 * JNITCMSMBRLOG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrlogVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception {
        update("jnitcmsmbrlogDAO.updateJnitcmsmbrlog_S", vo);
    }

    /**
	 * JNITCMSMBRLOG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrlogVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception {
        delete("jnitcmsmbrlogDAO.deleteJnitcmsmbrlog_S", vo);
    }

    /**
	 * JNITCMSMBRLOG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrlogVO
	 * @return 조회한 JNITCMSMBRLOG
	 * @exception Exception
	 */
    public JnitcmsmbrlogVO selectJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception {
        return (JnitcmsmbrlogVO) select("jnitcmsmbrlogDAO.selectJnitcmsmbrlog_S", vo);
    }

    /**
	 * JNITCMSMBRLOG 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRLOG 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmbrlogList(JnitcmsmbrlogDefaultVO searchVO) throws Exception {
        return list("jnitcmsmbrlogDAO.selectJnitcmsmbrlogList_D", searchVO);
    }
    
    /**
	 * JNITCMSMBRLOG 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRLOG 목록
	 * @exception Exception
	 */
    public List<?> selectLeftcmsmbrlogList(JnitcmsmbrlogDefaultVO searchVO) throws Exception {
        return list("jnitcmsmbrlogDAO.selectLeftcmsmbrlogList_D", searchVO);
    }

    /**
	 * JNITCMSMBRLOG 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRLOG 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrlogListTotCnt(JnitcmsmbrlogDefaultVO searchVO) {
        return (Integer)select("jnitcmsmbrlogDAO.selectJnitcmsmbrlogListTotCnt_S", searchVO);
    }
    
    /**
	 * JNITCMSMBRLOG 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRLOG 총 갯수
	 * @exception
	 */
    public int selectLeftcmsmbrlogListTotCnt(JnitcmsmbrlogDefaultVO searchVO) {
        return (Integer)select("jnitcmsmbrlogDAO.selectLeftcmsmbrlogListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSMBRLOG 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmbrlog() {
    	return (String)select("jnitcmsmbrlogDAO.getLastIdJnitcmsmbrlog_S");
    }
}
