package jnit.board.media;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import jnit.board.file.JnitboardfileVO;
import jnit.board.file.JnitboardfileDefaultVO;
import jnit.board.info.JnitboardinfoVO;

/**
 * @Class Name : JnitboardmediaDAO.java
 * @Description : Jnitboardmedia DAO Class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.01.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("JnitboardmediaDAO")
public class JnitboardmediaDAO extends EgovComAbstractDAO {

	/**
	 * Jnitboardmedia을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardmediaVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardmedia(JnitboardmediaVO vo) throws Exception {
    	//System.out.println(vo);
        return (String)insert("JnitboardmediaDAO.insertJnitboardmedia_S", vo);
    }

    /**
	 * Jnitboardmedia을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardmediaVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardmedia(JnitboardmediaVO vo) throws Exception {
        update("JnitboardmediaDAO.updateJnitboardmedia_S", vo);
    }

    /**
	 * Jnitboardmedia을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardmediaVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardmedia(JnitboardmediaVO vo) throws Exception {
        delete("JnitboardmediaDAO.deleteJnitboardmedia_S", vo);
    }

    /**
	 * Jnitboardmedia을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardmediaVO
	 * @return 조회한 Jnitboardmedia
	 * @exception Exception
	 */
    public JnitboardmediaVO selectJnitboardmedia(JnitboardmediaVO vo) throws Exception {
        return (JnitboardmediaVO) select("JnitboardmediaDAO.selectJnitboardmedia_S", vo);
    }
    
    /**
	 * Jnitboardmedia 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return Jnitboardmedia 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardmediaList(JnitboardmediaDefaultVO searchVO) throws Exception {
        return list("JnitboardmediaDAO.selectJnitboardmediaList_D", searchVO);
    }
    /**
	 * Jnitboardmedia 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return Jnitboardmedia 총 갯수
	 * @exception
	 */
    public int selectJnitboardmediaListTotCnt(JnitboardmediaDefaultVO searchVO) {
        return (Integer)select("JnitboardmediaDAO.selectJnitboardmediaListTotCnt_S", searchVO);
    }

    /**
	 * Jnitboardmedia 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitboardmedia() {
    	return (String)select("JnitboardmediaDAO.getLastIdJnitboardmedia_S");
    }
}
