/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrpackage;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmbrpackageDAO.java
 * @Description : Jnitcmsmbrpackage DAO Class
 * @Modification Information
 *
 * @author JNITCMSMBRPACKAGE
 * @since 2014.05.27
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmbrpackageDAO")
public class JnitcmsmbrpackageDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMBRPACKAGE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception {
        return (String)insert("jnitcmsmbrpackageDAO.insertJnitcmsmbrpackage_S", vo);
    }

    /**
	 * JNITCMSMBRPACKAGE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception {
        update("jnitcmsmbrpackageDAO.updateJnitcmsmbrpackage_S", vo);
    }

    /**
	 * JNITCMSMBRPACKAGE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception {
        delete("jnitcmsmbrpackageDAO.deleteJnitcmsmbrpackage_S", vo);
    }

    /**
	 * JNITCMSMBRPACKAGE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 조회한 JNITCMSMBRPACKAGE
	 * @exception Exception
	 */
    public JnitcmsmbrpackageVO selectJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception {
        return (JnitcmsmbrpackageVO) select("jnitcmsmbrpackageDAO.selectJnitcmsmbrpackage_S", vo);
    }

    /**
	 * 해당 계정의 권한이 있는지 없는지 'Y' or 'N'으로 반환
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 조회한 JNITCMSMBRPACKAGE
	 * @exception Exception
	 */
    public String selectJnitcmsmbrpackageQuery(String query) throws Exception {
        return (String) select("jnitcmsmbrpackageDAO.selectJnitcmsmbrpackageQuery", query);
    }
    
    /**
	 * JNITCMSMBRPACKAGE 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRPACKAGE 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmbrpackageList(JnitcmsmbrpackageDefaultVO searchVO) throws Exception {
        return list("jnitcmsmbrpackageDAO.selectJnitcmsmbrpackageList_D", searchVO);
    }

    /**
	 * JNITCMSMBRPACKAGE 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBRPACKAGE 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrpackageListTotCnt(JnitcmsmbrpackageDefaultVO searchVO) {
        return (Integer)select("jnitcmsmbrpackageDAO.selectJnitcmsmbrpackageListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSMBRPACKAGE 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmbrpackage() {
    	return (String)select("jnitcmsmbrpackageDAO.getLastIdJnitcmsmbrpackage_S");
    }
}
