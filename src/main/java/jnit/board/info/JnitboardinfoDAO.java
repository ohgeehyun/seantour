/**
 * @version 3.2.0.1
 */
package jnit.board.info;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitboardinfoDAO.java
 * @Description : Jnitboardinfo DAO Class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.21
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitboardinfoDAO")
public class JnitboardinfoDAO extends EgovComAbstractDAO {

	/**
	 * jnitboardinfo을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardinfoVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardinfo(JnitboardinfoVO vo) throws Exception {
        return (String)insert("jnitboardinfoDAO.insertJnitboardinfo_S", vo);
    }

    /**
	 * jnitboardinfo을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardinfoVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardinfo(JnitboardinfoVO vo) throws Exception {
        update("jnitboardinfoDAO.updateJnitboardinfo_S", vo);
    }

    /**
	 * jnitboardinfo을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardinfo(JnitboardinfoVO vo) throws Exception {
        delete("jnitboardinfoDAO.deleteJnitboardinfo_S", vo);
    }

    /**
	 * jnitboardinfo을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardinfoVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardinfoIsdel(JnitboardinfoVO vo) throws Exception {
        delete("jnitboardinfoDAO.deleteJnitboardinfoIsdel", vo);
    }
    /**
	 * jnitboardinfo을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardinfoVO
	 * @return 조회한 jnitboardinfo
	 * @exception Exception
	 */
    public JnitboardinfoVO selectJnitboardinfo(JnitboardinfoVO vo) throws Exception {
        return (JnitboardinfoVO) select("jnitboardinfoDAO.selectJnitboardinfo_S", vo);
    }
    /**
	 * jnitboardinfo 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardinfo 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardArticleList(JnitboardinfoDefaultVO searchVO) throws Exception {
        return list("jnitboardinfoDAO.selectJnitboardArticleList_D", searchVO);
    }
    /**
	 * jnitboardinfo 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardinfo 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardinfoList(JnitboardinfoDefaultVO searchVO) throws Exception {
        return list("jnitboardinfoDAO.selectJnitboardinfoList_D", searchVO);
    }

    /**
	 * jnitboardinfo 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboardinfo 총 갯수
	 * @exception
	 */
    public int selectJnitboardinfoListTotCnt(JnitboardinfoDefaultVO searchVO) {
        return (Integer)select("jnitboardinfoDAO.selectJnitboardinfoListTotCnt_S", searchVO);
    }

    /**
	 * jnitboardinfo 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitboardinfo() {
    	return (String)select("jnitboardinfoDAO.getLastIdJnitboardinfo_S");
    }
    
    /**
	 * 게시판 그룹 목록을 조회한다.
	 * @param searchMap
	 * @return BOARD_GROUP LIST
	 * @exception
	 */
	public List<?> selectJnitboardinfoGroupList(JnitboardinfoDefaultVO searchVO) throws Exception {
		return list("jnitbbsboardDAO.selectJnitboardinfoGroupList_D", searchVO);
	}

	/**
	 * 게시판을 생성한다
	 * @param type - 게시판타입, id - 게시판 아이디
	 * @return void
	 * @exception
	 */
	public void craeteNewBoard(String type, String id) {
		HashMap<String, String> tableMap = new HashMap<String, String>();
		tableMap.put("type", type);
		tableMap.put("id", id);
		update("jnitboardinfoDAO.createNewBoard", tableMap);
	}
	
    /**
	 * 게시판에 INDEX를 추가한다
	 * @param id - 게시판 아이디
	 * @return void
	 * @exception
	 */
	public void alterPrimaryKey(String id) {
		HashMap<String, String> tableMap = new HashMap<String, String>();
		tableMap.put("id", id);
		update("jnitboardinfoDAO.alterPrimaryKey", tableMap);
	}
}
