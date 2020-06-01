/**
 * @version 3.2.0.1
 */
package jnit.cms.pos;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsposDAO.java
 * @Description : Jnitcmspos DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsposDAO")
public class JnitcmsposDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSPOS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsposVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmspos(JnitcmsposVO vo) throws Exception {
        return (String)insert("jnitcmsposDAO.insertJnitcmspos_S", vo);
    }
    
    /**
	 * JNITCMSPOS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsposVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertDbConnectpos(JnitcmsposVO vo) throws Exception {
        return (String)insert("jnitcmsposDAO.insertDbConnectpos_S", vo);
    }

    /**
	 * JNITCMSPOS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsposVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmspos(JnitcmsposVO vo) throws Exception {
        update("jnitcmsposDAO.updateJnitcmspos_S", vo);
    }

    /**
	 * JNITCMSPOS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsposVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmspos(JnitcmsposVO vo) throws Exception {
        delete("jnitcmsposDAO.deleteJnitcmspos_S", vo);
    }
    
    /**
	 * JNITCMSPOS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsposVO
	 * @return 조회한 JNITCMSPOS
	 * @exception Exception
	 */
    public JnitcmsposVO selectJnitcmspos(JnitcmsposVO vo) throws Exception {
        return (JnitcmsposVO) select("jnitcmsposDAO.selectJnitcmspos_S", vo);
    }

    /**
	 * JNITCMSPOS 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSPOS 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsposList(JnitcmsposDefaultVO searchVO) throws Exception {
        return list("jnitcmsposDAO.selectJnitcmsposList_D", searchVO);
    }

    /**
	 * JNITCMSPOS 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSPOS 총 갯수
	 * @exception
	 */
    public int selectJnitcmsposListTotCnt(JnitcmsposDefaultVO searchVO) {
        return (Integer)select("jnitcmsposDAO.selectJnitcmsposListTotCnt_S", searchVO);
    }

    public String getLastPosIdJnitcmspos() {
    	return (String)select("jnitcmsposDAO.selectJnitcmsposListLastId_S");
    }
    
    
    /**
     * POS_ID를 공용코드방식으로 불러온다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<CmmnDetailCode> selectPosIdDetail(ComDefaultCodeVO vo) throws Exception {
    	return (List<CmmnDetailCode>) list("jnitcmsposDAO.selectPosIdDetail", vo);
    }
}
