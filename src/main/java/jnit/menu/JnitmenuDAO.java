package jnit.menu;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import jnit.menu.JnitmenuVO;
import jnit.menu.JnitmenuDefaultVO;

/**
 * @Class Name : JnitmenuDAO.java
 * @Description : Jnitmenu DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.08.28
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitmenuDAO")
public class JnitmenuDAO extends EgovComAbstractDAO {

	/**
	 * JNITMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitmenu(JnitmenuVO vo) throws Exception {
        return (String)insert("jnitmenuDAO.insertJnitmenu_S", vo);
    }

    /**
	 * JNITMENU을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitmenu(JnitmenuVO vo) throws Exception {
        update("jnitmenuDAO.updateJnitmenu_S", vo);
    }

    /**
	 * JNITMENU을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitmenuVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitmenu(JnitmenuVO vo) throws Exception {
        delete("jnitmenuDAO.deleteJnitmenu_S", vo);
    }

    /**
	 * JNITMENU을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitmenuVO
	 * @return 조회한 JNITMENU
	 * @exception Exception
	 */
    public JnitmenuVO selectJnitmenu(JnitmenuVO vo) throws Exception {
        return (JnitmenuVO) select("jnitmenuDAO.selectJnitmenu_S", vo);
    }
    
    /**
	 * JNITMENUMAP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitmenuVO
	 * @return 조회한 JNITMENU
	 * @exception Exception
	 */
    public HashMap selectJnitmenuMap(JnitmenuVO vo) throws Exception {
        return (HashMap) select("jnitmenuDAO.selectJnitmenuMap_S", vo);
    }

    /**
	 * JNITMENU 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITMENU 목록
	 * @exception Exception
	 */
    public List<?> selectJnitmenuList(JnitmenuDefaultVO searchVO) throws Exception {
        return list("jnitmenuDAO.selectJnitmenuList_D", searchVO);
    }

    /**
	 * JNITMENU 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITMENU 총 갯수
	 * @exception
	 */
    public int selectJnitmenuListTotCnt(JnitmenuDefaultVO searchVO) {
        return (Integer)select("jnitmenuDAO.selectJnitmenuListTotCnt_S", searchVO);
    }

    /**
	 * JNITMENU 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitmenu() {
    	return (String)select("jnitmenuDAO.getLastIdJnitmenu_S");
    }
}
