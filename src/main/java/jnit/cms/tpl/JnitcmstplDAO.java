/**
 * @version 3.2.0.1
 */
package jnit.cms.tpl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmstplDAO.java
 * @Description : Jnitcmstpl DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmstplDAO")
public class JnitcmstplDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSTPL을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmstplVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmstpl(JnitcmstplVO vo) throws Exception {
        return (String)insert("jnitcmstplDAO.insertJnitcmstpl_S", vo);
    }

    /**
	 * JNITCMSTPL을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmstplVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmstpl(JnitcmstplVO vo) throws Exception {
        update("jnitcmstplDAO.updateJnitcmstpl_S", vo);
    }

    /**
	 * JNITCMSTPL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmstpl(JnitcmstplVO vo) throws Exception {
        delete("jnitcmstplDAO.deleteJnitcmstpl_S", vo);
    }
    
    /**
	 * JNITCMSTPL을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmssitetpl(JnitcmstplVO vo) throws Exception {
        delete("jnitcmstplDAO.deleteJnitcmssitetpl_D", vo);
    }

    /**
	 * JNITCMSTPL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmstplVO
	 * @return 조회한 JNITCMSTPL
	 * @exception Exception
	 */
    public JnitcmstplVO selectJnitcmstpl(JnitcmstplVO vo) throws Exception {
        return (JnitcmstplVO) select("jnitcmstplDAO.selectJnitcmstpl_S", vo);
    }
    
    /**
	 * JNITCMSTPL을 조회한다.
	 * @param vo - 조회할 정보가 담긴 VO
	 * @return 조회한 JNITCMSTPL
	 * @exception Exception
	 */
    public JnitcmstplVO selectJnitcmstpltype(JnitcmstplDefaultVO searchVO) throws Exception {
        return (JnitcmstplVO) select("jnitcmstplDAO.selectJnitcmstpltype_S", searchVO);
    }

    /**
	 * JNITCMSTPL 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSTPL 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmstplList(JnitcmstplDefaultVO searchVO) throws Exception {
        return list("jnitcmstplDAO.selectJnitcmstplList_D", searchVO);
    }

    /**
	 * JNITCMSTPL 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSTPL 총 갯수
	 * @exception
	 */
    public int selectJnitcmstplListTotCnt(JnitcmstplDefaultVO searchVO) {
        return (Integer)select("jnitcmstplDAO.selectJnitcmstplListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSTPL 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSTPL 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmstplCopyList(JnitcmstplDefaultVO searchVO) throws Exception {
        return list("jnitcmstplDAO.selectJnitcmstplCopyList_D", searchVO);
    }

    /**
	 * JNITCMSTPL 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSTPL 총 갯수
	 * @exception
	 */
    public int selectJnitcmstplCopyListTotCnt(JnitcmstplDefaultVO searchVO) {
        return (Integer)select("jnitcmstplDAO.selectJnitcmstplCopyListTotCnt_S", searchVO);
    }
    

    /**
	 * JNITCMSTPL 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmstpl() {
    	return (String)select("jnitcmstplDAO.getLastIdJnitcmstpl_S");
    }
    
    /**
     * TPL_ID를 공용코드방식으로 불러온다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<CmmnDetailCode> selectTplIdDetail(ComDefaultCodeVO vo) throws Exception {
    	return (List<CmmnDetailCode>) list("jnitcmstplDAO.selectTplIdDetail", vo);
    }
}
