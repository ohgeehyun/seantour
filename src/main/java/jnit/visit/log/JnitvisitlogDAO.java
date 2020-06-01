/**
 * @version 3.2.0.1
 */
package jnit.visit.log;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
/**
 * @Class Name : JnitvisitlogDAO.java
 * @Description : Jnitvisitlog DAO Class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitvisitlogDAO")
public class JnitvisitlogDAO extends EgovAbstractDAO {

	/**
	 * JNITVISITLOG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitvisitlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitvisitlog(JnitvisitlogVO vo) throws Exception {
        return (String)insert("jnitvisitlogDAO.insertJnitvisitlog_S", vo);
    }
    /**
	 * JNITVISITLOG 데이터를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITVISITLOG 총 갯수
	 * @exception
	 */
    public int selectJnitvisitlogDataCnt(JnitvisitlogVO jnitvisitlogVO) {
        return (Integer)select("jnitvisitlogDAO.dataCnt_S", jnitvisitlogVO);
    }

    /**
	 * JNITVISITLOG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitvisitlogVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitvisitlog(JnitvisitlogVO vo) throws Exception {
        update("jnitvisitlogDAO.updateJnitvisitlog_S", vo);
    }

    /**
	 * JNITVISITLOG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitvisitlogVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitvisitlog(JnitvisitlogVO vo) throws Exception {
        delete("jnitvisitlogDAO.deleteJnitvisitlog_S", vo);
    }

    /**
	 * JNITVISITLOG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitvisitlogVO
	 * @return 조회한 JNITVISITLOG
	 * @exception Exception
	 */
    public JnitvisitlogVO selectJnitvisitlog(JnitvisitlogVO vo) throws Exception {
        return (JnitvisitlogVO) select("jnitvisitlogDAO.selectJnitvisitlog_S", vo);
    }

    /**
	 * JNITVISITLOG 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITVISITLOG 목록
	 * @exception Exception
	 */
    public List<?> selectJnitvisitlogList(JnitvisitlogDefaultVO searchVO) throws Exception {
        return list("jnitvisitlogDAO.selectJnitvisitlogList_D", searchVO);
    }

    /**
	 * JNITVISITLOG 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITVISITLOG 총 갯수
	 * @exception
	 */
	public int selectJnitvisitlogListTotCnt(JnitvisitlogDefaultVO searchVO) {
        return (Integer)select("jnitvisitlogDAO.selectJnitvisitlogListTotCnt_S", searchVO);
    }

    /**
	 * JNITVISITLOG 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
	public String getLastIdJnitvisitlog() {
    	return (String)select("jnitvisitlogDAO.getLastIdJnitvisitlog_S");
    }
}
