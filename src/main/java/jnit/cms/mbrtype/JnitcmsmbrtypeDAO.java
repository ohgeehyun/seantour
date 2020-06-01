/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrtype;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmbrtypeDAO.java
 * @Description : Jnitcmsmbrtype DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmbrtypeDAO")
public class JnitcmsmbrtypeDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMBRTYPE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception {
        return (String)insert("jnitcmsmbrtypeDAO.insertJnitcmsmbrtype_S", vo);
    }

    /**
	 * JNITCMSMBRTYPE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception {
        update("jnitcmsmbrtypeDAO.updateJnitcmsmbrtype_S", vo);
    }

    public void updateJnitcmsmbrtypetree(JnitcmsmbrtypeVO vo) throws Exception {
        update("jnitcmsmbrtypeDAO.updateJnitcmsmbrtype_tree", vo);
    }
    
    /**
	 * JNITCMSMBRTYPE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception {
        delete("jnitcmsmbrtypeDAO.deleteJnitcmsmbrtype_S", vo);
    }

    /**
	 * JNITCMSMBRTYPE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return 조회한 JNITCMSMBRTYPE
	 * @exception Exception
	 */
    public JnitcmsmbrtypeVO selectJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception {
        return (JnitcmsmbrtypeVO) select("jnitcmsmbrtypeDAO.selectJnitcmsmbrtype_S", vo);
    }

    /**
	 * JNITCMSMBRTYPE 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRTYPE 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmbrtypeList(JnitcmsmbrtypeDefaultVO searchVO) throws Exception {
        return list("jnitcmsmbrtypeDAO.selectJnitcmsmbrtypeList_D", searchVO);
    }

    /**
	 * JNITCMSMBRTYPE 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRTYPE 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrtypeListTotCnt(JnitcmsmbrtypeDefaultVO searchVO) {
        return (Integer)select("jnitcmsmbrtypeDAO.selectJnitcmsmbrtypeListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSMBRTYPE 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmbrtype() {
    	return (String)select("jnitcmsmbrtypeDAO.getLastIdJnitcmsmbrtype_S");
    }
    
    /**
     * TYPEID를 공용코드방식으로 불러온다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<CmmnDetailCode> selectTypeIdDetail(ComDefaultCodeVO vo) throws Exception {
    	return (List<CmmnDetailCode>) list("jnitcmsmbrtypeDAO.selectTypeIdDetail", vo);
    }
}
