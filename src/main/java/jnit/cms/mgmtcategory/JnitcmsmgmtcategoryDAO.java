/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtcategory;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmgmtcategoryDAO.java
 * @Description : Jnitcmsmgmtcategory DAO Class
 * @Modification Information
 *
 * @author JNITCMSMGMTCATEGORY
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmgmtcategoryDAO")
public class JnitcmsmgmtcategoryDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMGMTCATEGORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception {
        return (String)insert("jnitcmsmgmtcategoryDAO.insertJnitcmsmgmtcategory_S", vo);
    }

    /**
	 * JNITCMSMGMTCATEGORY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception {
        update("jnitcmsmgmtcategoryDAO.updateJnitcmsmgmtcategory_S", vo);
    }

    /**
	 * JNITCMSMGMTCATEGORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception {
        delete("jnitcmsmgmtcategoryDAO.deleteJnitcmsmgmtcategory_S", vo);
    }

    /**
	 * JNITCMSMGMTCATEGORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return 조회한 JNITCMSMGMTCATEGORY
	 * @exception Exception
	 */
    public JnitcmsmgmtcategoryVO selectJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception {
        return (JnitcmsmgmtcategoryVO) select("jnitcmsmgmtcategoryDAO.selectJnitcmsmgmtcategory_S", vo);
    }

    /**
	 * JNITCMSMGMTCATEGORY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMGMTCATEGORY 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmgmtcategoryList(JnitcmsmgmtcategoryDefaultVO searchVO) throws Exception {
        return list("jnitcmsmgmtcategoryDAO.selectJnitcmsmgmtcategoryList_D", searchVO);
    }

    /**
	 * JNITCMSMGMTCATEGORY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMGMTCATEGORY 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmgmtcategoryListTotCnt(JnitcmsmgmtcategoryDefaultVO searchVO) {
        return (Integer)select("jnitcmsmgmtcategoryDAO.selectJnitcmsmgmtcategoryListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSMGMTCATEGORY 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmgmtcategory() {
    	return (String)select("jnitcmsmgmtcategoryDAO.getLastIdJnitcmsmgmtcategory_S");
    }
}
