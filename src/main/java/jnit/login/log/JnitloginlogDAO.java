/**
 * @version 3.2.0.1
 */
package jnit.login.log;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitloginlogDAO.java
 * @Description : Jnitloginlog DAO Class
 * @Modification Information
 *
 * @author JNITLOGINLOG
 * @since 2013.07.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitloginlogDAO")
public class JnitloginlogDAO extends EgovComAbstractDAO {

	/**
	 * jnitloginlog을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitloginlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitloginlog(JnitloginlogVO vo) throws Exception {
        return (String)insert("jnitloginlogDAO.insertJnitloginlog_S", vo);
    }

    /**
	 * jnitloginlog을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitloginlogVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitloginlog(JnitloginlogVO vo) throws Exception {
        update("jnitloginlogDAO.updateJnitloginlog_S", vo);
    }

    /**
	 * jnitloginlog을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitloginlogVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitloginlog(JnitloginlogVO vo) throws Exception {
        delete("jnitloginlogDAO.deleteJnitloginlog_S", vo);
    }

    /**
	 * jnitloginlog을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitloginlogVO
	 * @return 조회한 jnitloginlog
	 * @exception Exception
	 */
    public JnitloginlogVO selectJnitloginlog(JnitloginlogVO vo) throws Exception {
        return (JnitloginlogVO) select("jnitloginlogDAO.selectJnitloginlog_S", vo);
    }

    /**
	 * jnitloginlog 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitloginlog 목록
	 * @exception Exception
	 */
    public List<?> selectJnitloginlogList(JnitloginlogDefaultVO searchVO) throws Exception {
        return list("jnitloginlogDAO.selectJnitloginlogList_D", searchVO);
    }
    
    /**
     * LEFT JOIN
     * JNITCMSMBR b
     * JNITCMSORG c
     * JNITCMSPOS d 
	 * jnitloginlog 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitloginlog 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoinloginlogList(JnitloginlogDefaultVO searchVO) throws Exception {
        return list("jnitloginlogDAO.selectLeftJoinloginlogList_D", searchVO);
    }

    /**
	 * jnitloginlog 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitloginlog 총 갯수
	 * @exception
	 */
    public int selectJnitloginlogListTotCnt(JnitloginlogDefaultVO searchVO) {
        return (Integer)select("jnitloginlogDAO.selectJnitloginlogListTotCnt_S", searchVO);
    }
    /**
     * LEFT JOIN
     * JNITCMSMBR b
     * JNITCMSORG c
     * JNITCMSPOS d
	 * jnitloginlog 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitloginlog 총 갯수
	 * @exception
	 */
    public int selectLeftJoinloginlogListTotCnt(JnitloginlogDefaultVO searchVO) {
        return (Integer)select("jnitloginlogDAO.selectLeftJoinloginlogListTotCnt_S", searchVO);
    }

    /**
	 * jnitloginlog 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitloginlog() {
    	return (String)select("jnitloginlogDAO.getLastIdJnitloginlog_S");
    }
}
