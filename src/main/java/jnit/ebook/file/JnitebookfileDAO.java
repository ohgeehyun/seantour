/**
 * @version 3.2.0.1
 */
package jnit.ebook.file;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitebookfileDAO.java
 * @Description : Jnitebookfile DAO Class
 * @Modification Information
 *
 * @author JNITEBOOKFILE
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitebookfileDAO")
public class JnitebookfileDAO extends EgovComAbstractDAO {

	/**
	 * JNITEBOOKFILE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitebookfileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitebookfile(JnitebookfileVO vo) throws Exception {
        return (String)insert("jnitebookfileDAO.insertJnitebookfile_S", vo);
    }

    /**
	 * JNITEBOOKFILE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitebookfileVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitebookfile(JnitebookfileVO vo) throws Exception {
        update("jnitebookfileDAO.updateJnitebookfile_S", vo);
    }

    /**
	 * JNITEBOOKFILE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitebookfileVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitebookfile(JnitebookfileVO vo) throws Exception {
        delete("jnitebookfileDAO.deleteJnitebookfile_S", vo);
    }

    /**
	 * JNITEBOOKFILE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitebookfileVO
	 * @return 조회한 JNITEBOOKFILE
	 * @exception Exception
	 */
    public JnitebookfileVO selectJnitebookfile(JnitebookfileVO vo) throws Exception {
        return (JnitebookfileVO) select("jnitebookfileDAO.selectJnitebookfile_S", vo);
    }

    /**
	 * JNITEBOOKFILE 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITEBOOKFILE 목록
	 * @exception Exception
	 */
    public List<?> selectJnitebookfileList(JnitebookfileDefaultVO searchVO) throws Exception {
        return list("jnitebookfileDAO.selectJnitebookfileList_D", searchVO);
    }

    /**
	 * JNITEBOOKFILE 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITEBOOKFILE 총 갯수
	 * @exception
	 */
    public int selectJnitebookfileListTotCnt(JnitebookfileDefaultVO searchVO) {
        return (Integer)select("jnitebookfileDAO.selectJnitebookfileListTotCnt_S", searchVO);
    }

    /**
	 * JNITEBOOKFILE 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitebookfile() {
    	return (String)select("jnitebookfileDAO.getLastIdJnitebookfile_S");
    }
}
