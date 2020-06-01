/**
 * @version 3.2.0.1
 */
package jnit.cms.mbr;

import java.util.List;

import jnit.cms.CmsManageSub2_1Controller;
import jnit.cms.CmsManageSub6Controller;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : JnitcmsmbrDAO.java
 * @Description : Jnitcmsmbr DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitcmsmbrDAO")
public class JnitcmsmbrDAO extends EgovComAbstractDAO {

	/**
	 * JNITCMSMBR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        return (String)insert("jnitcmsmbrDAO.insertJnitcmsmbr_S", vo);
    }

    /**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        update("jnitcmsmbrDAO.updateJnitcmsmbr_S", vo);
    }
    
    /**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMbrLogin(JnitcmsmbrVO vo) throws Exception {
        update("jnitcmsmbrDAO.updateMbrLogin_S", vo);
    }
    /**
	 * JNITCMSMBR을 수정한다.
	 * ISDEL = 1
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateIsdelMbrLogin(JnitcmsmbrVO vo) throws Exception {
        update("jnitcmsmbrDAO.updateIsdelMbrLogin_S", vo);
    }
    
    /**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateTempmbr(JnitcmsmbrVO vo) throws Exception {
        update("jnitcmsmbrDAO.updateTempmbr_S", vo);
    }

    /**
	 * JNITCMSMBR을 탈퇴한다.
	 * @param vo - 탈퇴할 정보가 담긴 JnitcmsmbrVO
	 * @return void형 
	 * @exception Exception
	 */
    public void leaveJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        delete("jnitcmsmbrDAO.leaveJnitcmsmbr_S", vo);
    }
    /**
	 * JNITCMSMBR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        delete("jnitcmsmbrDAO.deleteJnitcmsmbr_S", vo);
    }

    /**
	 * JNITCMSMBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    public JnitcmsmbrVO selectJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        return (JnitcmsmbrVO) select("jnitcmsmbrDAO.selectJnitcmsmbr_S", vo);
    }
    /**
	 * JNITCMSMBR을 조회한다.
	 * mbrLogin 조회
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    public JnitcmsmbrVO selectmbrLogin(JnitcmsmbrVO vo) throws Exception {
        return (JnitcmsmbrVO) select("jnitcmsmbrDAO.selectmbrLogin_S", vo);
    }
    /**
	 * JNITCMSMBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    public JnitcmsmbrVO selectDpJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        return (JnitcmsmbrVO) select("jnitcmsmbrDAO.selectDpJnitcmsmbr_S", vo);
    }

    /**
	 * JNITCMSMBR 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmbrList(JnitcmsmbrDefaultVO searchVO) throws Exception {
        return list("jnitcmsmbrDAO.selectJnitcmsmbrList_D", searchVO);
    }
    
    /**
	 * JNITCMSMBR 검색 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    public List<?> selectSearchList(JnitcmsmbrDefaultVO searchVO) throws Exception {
        return list("jnitcmsmbrDAO.selectSearchList", searchVO);
    }
    
    /**
	 * JNITCMSMBR 목록을 조회한다.
	 * JNITCMSORG - LEFT JOIN
	 * JNITCMSPOS - LEFT JOIN
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @see CmsManageSub1_3Controller 
	 * <code>{@link jnit.cms.CmsManageSub1_3Controller # cmsManageSub1_0201}</code>
	 * @see CmsManageSub6Controller 
	 * <code>{@link jnit.cms.CmsManageSub6Controller # updateJnitcmsmenuView}</code>
	 * @see  CmsManageSub2_1Controller
	 * <code>{@link jnit.cms.CmsManageSub2_1Controller # selectJnitcmsmbrList}</code>
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoinmbrList(JnitcmsmbrDefaultVO searchVO) throws Exception {
        return list("jnitcmsmbrDAO.selectLeftJoinmbrList_D", searchVO);
    }

    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrListTotCnt(JnitcmsmbrDefaultVO searchVO) {
        return (Integer)select("jnitcmsmbrDAO.selectJnitcmsmbrListTotCnt_S", searchVO);
    }
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * JNITCMSORG - LEFT JOIN
	 * JNITCMSPOS - LEFT JOIN
	 * JINTCMSRANK - LEFT JOIN
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    public int selectLeftJoinmbrListTotCnt(JnitcmsmbrDefaultVO searchVO) {
        return (Integer)select("jnitcmsmbrDAO.selectLeftJoinmbrListTotCnt_S", searchVO);
    }
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    public int selectListTotCnt(JnitcmsmbrDefaultVO searchVO) {
        return (Integer)select("jnitcmsmbrDAO.selectListTotCnt_S", searchVO);
    }

    /**
	 * JNITCMSMBR 다음 등록 SEQ를 조회한다.
	 * @param void
	 * @return 다음 등록 SEQ
	 * @exception
	 */
    public String getLastIdJnitcmsmbr() {
    	return (String)select("jnitcmsmbrDAO.getLastIdJnitcmsmbr_S");
    }
    
    /**
	 * JNITCMSMBR에서 일반로그인과 일치한 정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    public JnitcmsmbrVO exeLogin(JnitcmsmbrVO vo) throws Exception {
        return (JnitcmsmbrVO) select("jnitcmsmbrDAO.exeLoginJnitcmsmbr_S", vo);
    }
    /**
	 * JNITCMSMBR MBR_LOGIN을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    public int hasJnitcmsmbrCnt(JnitcmsmbrVO vo) {
        return (Integer)select("jnitcmsmbrDAO.hasJnitcmsmbr_S", vo);
    }
    
    /**
     * 기업회원 조회
     */
    public JnitcmsmbrVO selectJnitcmsmbrDpSn(JnitcmsmbrVO vo) {
    	return (JnitcmsmbrVO) select("jnitcmsmbrDAO.selectJnitcmsmbrDpSn", vo);
    }
    
    /**
     * 기업회원 조회 개수
     */
    public int selectJnitcmsmbrDpSnTot(JnitcmsmbrVO vo) {
    	return (Integer) select("jnitcmsmbrDAO.selectJnitcmsmbrDpSnTot", vo);
    }
    
    /**
     * 일정 횟수동안 로그인을 실패하여 잠긴 계정 해제
     */
    public void updateUnlockLogin(JnitcmsmbrVO vo) {
    	update("jnitcmsmbrDAO.updateUnlockLogin", vo);
    }
}
