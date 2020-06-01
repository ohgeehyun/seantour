/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrsess;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmbrsessDAO.java
 * @Description : Jnitcmsmbrsess DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmbrsessDAO")
public class JnitcmsmbrsessDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMBRSESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrsessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception {
        return (String)insert("jnitcmsmbrsessDAO.insertJnitcmsmbrsess_S", vo);
    }

    /**
	 * JNITCMSMBRSESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrsessVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception {
        update("jnitcmsmbrsessDAO.updateJnitcmsmbrsess_S", vo);
    }

    /**
	 * JNITCMSMBRSESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrsessVO
	 * @return 조회한 JNITCMSMBRSESS
	 * @exception Exception
	 */
    public JnitcmsmbrsessVO selectJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception {
        return (JnitcmsmbrsessVO) select("jnitcmsmbrsessDAO.selectJnitcmsmbrsess_S", vo);
    }

    /**
	 * JNITCMSMBRSESS 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRSESS 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrsessListTotCnt(JnitcmsmbrsessDefaultVO searchVO) {
        return (Integer)select("jnitcmsmbrsessDAO.selectJnitcmsmbrsessListTotCnt_S", searchVO);
    }
}
