/**
 * @version 3.2.0.1
 */
package jnit.cms.menu;

import java.util.List;

import jnit.rsc.page.JnitrscpageController;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmenuDAO.java
 * @Description : Jnitcmsmenu DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.08
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmenuDAO")
public class JnitcmsmenuDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmenu(JnitcmsmenuVO vo) throws Exception {
        return (String)insert("jnitcmsmenuDAO.insertJnitcmsmenu_S", vo);
    }
    
    /**
	 * JNITCMSMENU을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenuVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSelect(JnitcmsmenuVO vo) throws Exception {
        return (String)insert("jnitcmsmenuDAO.insertSelect", vo);
    }

    /**
	 * JNITCMSMENU을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenu(JnitcmsmenuVO vo) throws Exception {
        update("jnitcmsmenuDAO.updateJnitcmsmenu_S", vo);
    }
    
    /**
	 * JNITCMSMENU Method를 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenuMethod(JnitcmsmenuVO vo) throws Exception {
        update("jnitcmsmenuDAO.updateJnitcmsmenuMethod_S", vo);
    }

    /**
	 * JNITCMSMENU MenuNm을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenuTitle(JnitcmsmenuVO vo) throws Exception {
        update("jnitcmsmenuDAO.updateJnitcmsmenuTitle_S", vo);
    }
    
    /**
	 * JNITCMSMENU Method를 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenuVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenuChMethod(JnitcmsmenuChMethodVO vo) throws Exception {
    	if( vo.getMoveMode() == "down" ) {
	        update("jnitcmsmenuDAO.updateJnitcmsmenuChMethod1_S", vo);
	        update("jnitcmsmenuDAO.updateJnitcmsmenuChMethod2_S", vo);
	        update("jnitcmsmenuDAO.updateJnitcmsmenuChMethod3_S", vo);
    	}
    	if( vo.getMoveMode() == "up" ) {
	        update("jnitcmsmenuDAO.updateJnitcmsmenuChMethod1up_S", vo);
	        update("jnitcmsmenuDAO.updateJnitcmsmenuChMethod2up_S", vo);
	        update("jnitcmsmenuDAO.updateJnitcmsmenuChMethod3up_S", vo);
    	}
    }
    
    /**
	 * JNITCMSMENU을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenuVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmenu(JnitcmsmenuVO vo) throws Exception {
        delete("jnitcmsmenuDAO.deleteJnitcmsmenu_S", vo);
    }

    /**
	 * JNITCMSMENU을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenuVO
	 * @see JnitrscpageController
	 * <code>{@link jnit.rsc.page.JnitrscpageController# addJnitrscpageView }</code>
	 * @return 조회한 JNITCMSMENU
	 * @exception Exception
	 */
    public JnitcmsmenuVO selectJnitcmsmenu(JnitcmsmenuVO vo) throws Exception {
        return (JnitcmsmenuVO) select("jnitcmsmenuDAO.selectJnitcmsmenu_S", vo);
    }

    /**
	 * JNITCMSMENU 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMENU 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmenuList(JnitcmsmenuDefaultVO searchVO) throws Exception {
        return list("jnitcmsmenuDAO.selectJnitcmsmenuList_D", searchVO);
    }
    
    /**
	 * JNITCMSMENU 전체 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMENU 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmenuListAll(JnitcmsmenuDefaultVO searchVO) throws Exception {
        return list("jnitcmsmenuDAO.selectJnitcmsmenuListAll_D", searchVO);
    }

    /**
	 * JNITCMSMENU 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenuListTotCnt(JnitcmsmenuDefaultVO searchVO) {
        return (Integer)select("jnitcmsmenuDAO.selectJnitcmsmenuListTotCnt_S", searchVO);
    }
    
    /**
	 * JNITCMSMENU 다음 Method를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenuNextMethod(JnitcmsmenuVO vo) {
        return (Integer)select("jnitcmsmenuDAO.selectJnitcmsmenuNextMethod_S", vo);
    }
    
    /**
	 * JNITCMSMENU 다음 Path를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    public String selectJnitcmsmenuNextPath(JnitcmsmenuVO vo) {
        return (String)select("jnitcmsmenuDAO.selectJnitcmsmenuNextPath_S", vo);
    }

    /**
	 * JNITCMSMENU Max Method를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMENU 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenuMaxMethod(JnitcmsmenuVO vo) {
        return (Integer)select("jnitcmsmenuDAO.selectJnitcmsmenuMaxMethod_S", vo);
    }
    
    /**
	 * JNITCMSMENU 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmenu() {
    	return (String)select("jnitcmsmenuDAO.getLastIdJnitcmsmenu_S");
    }
    
    /**
	 * 해당 메뉴의 기본 하위메뉴 vo조회
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenuVO
	 * @return 조회한 JNITCMSMENU
	 * @exception Exception
	 */
	public JnitcmsmenuVO selectJnitcmsmenuDef(JnitcmsmenuVO vo) {
		return (JnitcmsmenuVO) select("jnitcmsmenuDAO.selectJnitcmsmenuDef_S", vo);
	}
	
	/** SITE_ID, MENU_ID GET */
	public CaseInsensitiveMap getSiteAndMenuInfo(CaseInsensitiveMap ciMap) {
		return (CaseInsensitiveMap) select("jnitcmsmenuDAO.getSiteAndMenuInfo", ciMap);
	}
	
	/**
	 * JNITCMSMENU 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public int getDuplicationCount(JnitcmsmenuVO vo) {
    	return (Integer)select("jnitcmsmenuDAO.getDuplicationCount", vo);
    }
}
