/**
 * @version 3.2.0.1
 */
package jnit.cms.mbr;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import jnit.cms.CmsManageSub6Controller;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;

/**
 * @Class Name : JnitcmsmbrService.java
 * @Description : Jnitcmsmbr Business class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitcmsmbrService {
	
	/**
	 * JNITCMSMBR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertJnitcmsmbr(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    void updateJnitcmsmbr(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    void updateMbrLogin(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 수정한다.
	 * ISDEL=1
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    void updateIsdelMbrLogin(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    void updateTempmbr(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 탈퇴한다.
	 * @param vo - 탈퇴할 정보가 담긴 JnitcmsmbrVO
	 * @return void형 
	 * @exception Exception
	 */
    void leaveJnitcmsmbr(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteJnitcmsmbr(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    JnitcmsmbrVO selectJnitcmsmbr(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 조회한다.
	 * mbrLogin 조회
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    JnitcmsmbrVO selectmbrLogin(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    JnitcmsmbrVO selectDpJnitcmsmbr(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    List selectJnitcmsmbrList(JnitcmsmbrDefaultVO searchVO) throws Exception;
    
    
    /**
	 * JNITCMSMBR 목록을 조회한다.
	 * JNITCMSORG - LEFT JOIN
	 * JNITCMSPOS - LEFT JOIN
	 * JNITCMSRANK - LEFT JOIN
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @see CmsManageSub1_3Controller 
	 * <code>{@link jnit.cms.CmsManageSub1_3Controller # cmsManageSub1_0201}</code>
	 * @see CmsManageSub6Controller 
	 * <code>{@link jnit.cms.CmsManageSub6Controller # updateJnitcmsmenuView}</code> 
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    List selectLeftJoinmbrList(JnitcmsmbrDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMBR 검색 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    List selectSearchList(JnitcmsmbrDefaultVO searchVO) throws Exception;
    
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    int selectJnitcmsmbrListTotCnt(JnitcmsmbrDefaultVO searchVO);
    
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * JNITCMSORG - LEFT JOIN
	 * JNITCMSPOS - LEFT JOIN
	 * JNITCMSRANK - LEFT JOIN
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    int selectLeftJoinmbrListTotCnt(JnitcmsmbrDefaultVO searchVO);
    
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    int selectListTotCnt(JnitcmsmbrDefaultVO searchVO);
    
    /**
     * JNITCMSMBR 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    String getLastIdJnitcmsmbr() throws Exception;
    
    /**
     * 부서정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectOrgIdDetail(ComDefaultCodeVO vo) throws Exception;
    
    /**
     * 직급정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectPosIdDetail(ComDefaultCodeVO vo) throws Exception;
    
    /**
     * 회원유형정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectTypeIdDetail(ComDefaultCodeVO vo) throws Exception;
    
    /**
	 * 일반 로그인을 처리한다
	 * @param vo JnitcmsmbrVO
	 * @return JnitcmsmbrVO
	 * @exception Exception
	 */
    public JnitcmsmbrVO exeLogin(HttpServletRequest request, JnitcmsmbrVO vo) throws Exception;

    /**
	 * 일반 로그인을 체크한다
	 * @param vo JnitcmsmbrVO
	 * @return JnitcmsmbrVO
	 * @exception Exception
	 */
    public JnitcmsmbrVO chkLogin(JnitcmsmbrVO vo) throws Exception;
    
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * @param vo JnitcmsmbrVO - 조회할 MBR_LOGIN가 담긴 VO
	 * @return Boolean
	 * @exception
	 */
    Boolean hasJnitcmsmbr(JnitcmsmbrVO vo);
    
    /**
     * 기업회원 조회
     */
    JnitcmsmbrVO selectJnitcmsmbrDpSn(JnitcmsmbrVO vo);
    
    /**
     * 기업회원 조회 개수
     */
    int selectJnitcmsmbrDpSnTot(JnitcmsmbrVO vo);
    
    /**
     * 일정 횟수동안 로그인을 실패하여 잠긴 계정 해제
     * @throws Exception
     */
    void unlockLogin(String vo) throws Exception;
}
