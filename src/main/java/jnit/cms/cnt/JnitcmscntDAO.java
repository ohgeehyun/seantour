/**
 * @version 3.2.0.1
 */
package jnit.cms.cnt;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmscntDAO.java
 * @Description : Jnitcmscnt DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmscntDAO")
public class JnitcmscntDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSCNT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmscntVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmscnt(JnitcmscntVO vo) throws Exception {
        return (String)insert("jnitcmscntDAO.insertJnitcmscnt_S", vo);
    }
    
    /**
     * 
     * JNITCMSCNT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmscntVO
	 * @return 등록 결과
	 * @exception Exception
     */
    public String insertSelectJnitcmscnt(JnitcmscntVO vo) throws Exception {
        return (String)insert("jnitcmscntDAO.insertSelectJnitcmscnt", vo);
    }

    /**
	 * JNITCMSCNT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmscnt(JnitcmscntVO vo) throws Exception {
        update("jnitcmscntDAO.updateJnitcmscnt_S", vo);
    }
    
    /**
	 * JNITCMSCNT OPT를 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmscntOpt(JnitcmscntVO vo) throws Exception {
        update("jnitcmscntDAO.updateJnitcmscntOpt_S", vo);
    }
    
    /**
	 * JNITCMSCNT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscntVO
	 * @param cntWebStandard - 웹표준
	 * @param cntWebStandardCss - 웹표준css
	 * @param cntWebAccess - 웹접근성
	 * @return void형
	 * @exception Exception
	 */
    public void updateWebcnt(JnitcmscntVO vo) throws Exception {
        update("jnitcmscntDAO.updateWebcnt_S", vo);
    }
    
    /** 외국어 사이트 동시 변경 */
    public void updateJnitcmscntLanguage(JnitcmscntVO vo) throws Exception{
    	update("jnitcmscntDAO.updateJnitcmscntLanguage", vo);
    }

    /**
	 * JNITCMSCNT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmscntVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmscnt(JnitcmscntVO vo) throws Exception {
        delete("jnitcmscntDAO.deleteJnitcmscnt_S", vo);
    }

    /**
	 * JNITCMSCNT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscntVO
	 * @return 조회한 JNITCMSCNT
	 * @exception Exception
	 */
    public JnitcmscntVO selectJnitcmscnt(JnitcmscntVO vo) throws Exception {
        return (JnitcmscntVO) select("jnitcmscntDAO.selectJnitcmscnt_S", vo);
    }

    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmscntList(JnitcmscntDefaultVO searchVO) throws Exception {
        return list("jnitcmscntDAO.selectJnitcmscntList_D", searchVO);
    }
    
    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    public List<?> selectLeftcntMenuList(JnitcmscntDefaultVO searchVO) throws Exception {
        return list("jnitcmscntDAO.selectLeftcntMenuList_D", searchVO);
    }
    /**
	 * JNITCMSCNT 목록을 조회한다.
	 * LEFT JOIN JNITCMSMENU 
	 * LEFT JOIN JNITCMSTPL
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCNT 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoincntList(JnitcmscntDefaultVO searchVO) throws Exception {
        return list("jnitcmscntDAO.selectLeftJoincntList_D", searchVO);
    }

    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    public int selectJnitcmscntListTotCnt(JnitcmscntDefaultVO searchVO) {
        return (Integer)select("jnitcmscntDAO.selectJnitcmscntListTotCnt_S", searchVO);
    }
    
    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    public int selectLeftcntMenuListTotCnt(JnitcmscntDefaultVO searchVO) {
        return (Integer)select("jnitcmscntDAO.selectLeftcntMenuListTotCnt_S", searchVO);
    }
    
    /**
	 * JNITCMSCNT 총 갯수를 조회한다.
	 * LEFT JOIN JNITCMSMENU.
	 * LEFT JOIN JNITCMSTPL.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSCNT 총 갯수
	 * @exception
	 */
    public int selectLeftJoincntListTotCnt(JnitcmscntDefaultVO searchVO) {
        return (Integer)select("jnitcmscntDAO.selectLeftJoincntListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSCNT 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmscnt() {
    	return (String)select("jnitcmscntDAO.getLastIdJnitcmscnt_S");
    }
}
