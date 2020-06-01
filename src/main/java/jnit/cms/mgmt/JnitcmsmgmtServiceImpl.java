/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsmgmtServiceImpl.java
 * @Description : Jnitcmsmgmt Business Implement class
 * @Modification Information
 *
 * @author JNITCMSMGMT
 * @since 2014.04.16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmgmtService")
public class JnitcmsmgmtServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmgmtService {

    @Resource(name="jnitcmsmgmtDAO")
    private JnitcmsmgmtDAO jnitcmsmgmtDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSMGMT_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMGMT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMgmtId(id);
    	
    	
    	jnitcmsmgmtDAO.insertJnitcmsmgmt(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITCMSMGMT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception {
        jnitcmsmgmtDAO.updateJnitcmsmgmt(vo);
    }

    /**
	 * JNITCMSMGMT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception {
        jnitcmsmgmtDAO.deleteJnitcmsmgmt(vo);
    }

    /**
	 * JNITCMSMGMT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtVO
	 * @return 조회한 JNITCMSMGMT
	 * @exception Exception
	 */
    public JnitcmsmgmtVO selectJnitcmsmgmt(JnitcmsmgmtVO vo) throws Exception {
        JnitcmsmgmtVO resultVO = jnitcmsmgmtDAO.selectJnitcmsmgmt(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSMGMT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMT 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmgmtList(JnitcmsmgmtDefaultVO searchVO) throws Exception {
        return jnitcmsmgmtDAO.selectJnitcmsmgmtList(searchVO);
    }

    /**
	 * JNITCMSMGMT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMT 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmgmtListTotCnt(JnitcmsmgmtDefaultVO searchVO) {
		return jnitcmsmgmtDAO.selectJnitcmsmgmtListTotCnt(searchVO);
	}
    
    /**
	 * JNITCMSMGMT MAX값을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMT MAX
	 * @exception
	 */
    public int selectMaxTotCnt(JnitcmsmgmtDefaultVO searchVO) {
		return jnitcmsmgmtDAO.selectMaxTotCnt(searchVO);
	}
    
    /**
     * JNITCMSMGMT 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmgmt() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsmgmtDAO.getLastIdJnitcmsmgmt() );
    }
}
