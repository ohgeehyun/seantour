/**
 * @version 3.2.0.1
 */
package jnit.board.db;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.com.utl.fcc.service.NullUtil;

/**
 * @Class Name : jnitboarddbDAO.java
 * @Description : jnitboarddb DAO Class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2013.01.22
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitboarddbDAO")
public class JnitboarddbDAO extends EgovComAbstractDAO {

	/**
	 * jnitboarddb을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboarddbVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboarddb(JnitboarddbVO vo) throws Exception {
    	return (String)insert("jnitboarddbDAO.insert_S", vo);
    }

    /**
	 * jnitboarddb을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboarddbVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboarddb(JnitboarddbVO vo) throws Exception {
        update("jnitboarddbDAO.update_S", vo);
    }

    /**
	 * jnitboarddb의 조회수를 올린다.
	 * @param vo - 수정할 정보가 담긴 JnitboarddbVO
	 * @return void형
	 * @exception Exception
	 */
    public void hitJnitboarddb(JnitboarddbVO vo) throws Exception {
        update("jnitboarddbDAO.hit_S", vo);
    }

    /**
	 * jnitboarddb을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboarddbVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboarddb(JnitboarddbVO vo) throws Exception {
        delete("jnitboarddbDAO.delete_S", vo);
    }
    
    /**
	 * 해당 게시판의 데이터를 전체 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboarddbVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteAll(JnitboarddbVO vo) throws Exception {
        delete("jnitboarddbDAO.delete_All", vo);
    }
    
    /**
	 * jnitboarddb을 복구한다.
	 * @param vo - 복구할 정보가 담긴 JnitboarddbVO
	 * @return void형 
	 * @exception Exception
	 */
    public void recoveryJnitboarddb(JnitboarddbVO vo) throws Exception {
        update("jnitboarddbDAO.recovery_S", vo);
    }

	/**
	 * jnitboarddb을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboarddbVO
	 * @return 조회한 jnitboarddb
	 * @exception Exception
	 */
    public JnitboarddbVO selectJnitboarddb(JnitboarddbVO vo) throws Exception {
        return (JnitboarddbVO) select("jnitboarddbDAO.select_S", vo);
    }
    
    /**
	 * jnitboarddb조회 데이터중 익명의 사용자가 올린 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardtplVO
	 * @return 조회한 jnitboardtpl
	 * @exception Exception
	 */
    public JnitboarddbVO selectJnitboarddbAnony(JnitboarddbVO vo) throws Exception {
        return (JnitboarddbVO) select("jnitboarddbDAO.selectAnonymous_S", vo);
    }

    /**
	 * jnitboarddb 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboarddb 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboarddbList(JnitboarddbDefaultVO searchVO) throws Exception {
        return list("jnitboarddbDAO.select_D", searchVO);
    }
    
    /**
	 * jnitboarddb 이전글,다음글, 현재글의 답글 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboarddb 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboarddbPNList(JnitboarddbDefaultVO searchVO) throws Exception {
        return list("jnitboarddbDAO.selectPN_D", searchVO);
    }
    /**
	 * jnitboarddb 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return jnitboarddb 총 갯수
	 * @exception
	 */
    public int selectJnitboarddbListTotCnt(JnitboarddbDefaultVO searchVO) {
        return (Integer)select("jnitboarddbDAO.selectListTotCnt_S", searchVO);
    }

    /**
	 * jnitboarddb 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public int getLastIdJnitboard(JnitboarddbDefaultVO searchVO) {
    	return NullUtil.nullInt((String)select("jnitboarddbDAO.getLastIdJnitboard_S", searchVO));
    }
    /**
	 * jnitboarddb 다음 등록될 idx를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getNextIdx(JnitboarddbVO dbVO) {
    	String nextIdx = NullUtil.nullString((String)select("jnitboarddbDAO.getNextIdx_S", dbVO));
    	nextIdx = nextIdx.equals("") ? NullUtil.nullString(dbVO.getIdx()) + "A" : nextIdx;
    	return nextIdx;
    }
}
