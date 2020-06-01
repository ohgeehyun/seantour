/**
 * @version 3.2.0.1
 */
package jnit.board.good;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitboardgoodDAO.java
 * @Description : Jnitboardgood DAO Class
 * @Modification Information
 *
 * @author JNITBOARADGOOD
 * @since 2013.11.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitboardgoodDAO")
public class JnitboardgoodDAO extends EgovComAbstractDAO {

	/**
	 * jnitboardgood을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardgoodVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardgood(JnitboardgoodVO vo) throws Exception {
        return (String)insert("jnitboardgoodDAO.insertJnitboardgood_S", vo);
    }

    /**
	 * jnitboardgood을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardgoodVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardgood(JnitboardgoodVO vo) throws Exception {
        update("jnitboardgoodDAO.updateJnitboardgood_S", vo);
    }

    /**
	 * jnitboardgood을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardgoodVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardgood(JnitboardgoodVO vo) throws Exception {
        delete("jnitboardgoodDAO.deleteJnitboardgood_S", vo);
    }

    /**
	 * jnitboardgood을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardgoodVO
	 * @return 조회한 jnitboardgood
	 * @exception Exception
	 */
    public JnitboardgoodVO selectJnitboardgood(JnitboardgoodVO vo) throws Exception {
        return (JnitboardgoodVO) select("jnitboardgoodDAO.selectJnitboardgood_S", vo);
    }

    /**
	 * jnitboardgood 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardgood 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardgoodList(JnitboardgoodDefaultVO searchVO) throws Exception {
        return list("jnitboardgoodDAO.selectJnitboardgoodList_D", searchVO);
    }

    /**
	 * jnitboardgood 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardgood 총 갯수
	 * @exception
	 */
    public int selectJnitboardgoodListTotCnt(JnitboardgoodDefaultVO searchVO) {
        return (Integer)select("jnitboardgoodDAO.selectJnitboardgoodListTotCnt_S", searchVO);
    }

    /**
	 * jnitboardgood 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitboardgood() {
    	return (String)select("jnitboardgoodDAO.getLastIdJnitboardgood_S");
    }
}
