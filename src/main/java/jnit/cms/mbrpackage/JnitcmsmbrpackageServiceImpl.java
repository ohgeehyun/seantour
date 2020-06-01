/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrpackage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsmbrpackageServiceImpl.java
 * @Description : Jnitcmsmbrpackage Business Implement class
 * @Modification Information
 *
 * @author JNITCMSMBRPACKAGE
 * @since 2014.05.27
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmbrpackageService")
public class JnitcmsmbrpackageServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmbrpackageService {

    @Resource(name="jnitcmsmbrpackageDAO")
    private JnitcmsmbrpackageDAO jnitcmsmbrpackageDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSMBRPACKAGE_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMBRPACKAGE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	String id = egovIdGnrService.getNextStringId();
    	vo.setPackId(id);
    	
    	jnitcmsmbrpackageDAO.insertJnitcmsmbrpackage(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSMBRPACKAGE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception {
        jnitcmsmbrpackageDAO.updateJnitcmsmbrpackage(vo);
    }

    /**
	 * JNITCMSMBRPACKAGE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception {
        jnitcmsmbrpackageDAO.deleteJnitcmsmbrpackage(vo);
    }

    /**
	 * JNITCMSMBRPACKAGE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 조회한 JNITCMSMBRPACKAGE
	 * @exception Exception
	 */
    public JnitcmsmbrpackageVO selectJnitcmsmbrpackage(JnitcmsmbrpackageVO vo) throws Exception {
        JnitcmsmbrpackageVO resultVO = jnitcmsmbrpackageDAO.selectJnitcmsmbrpackage(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * 해당 계정의 권한이 있는지 없는지 'Y' or 'N'으로 반환
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrpackageVO
	 * @return 조회한 JNITCMSMBRPACKAGE
	 * @exception Exception
	 */
    public String selectJnitcmsmbrpackageQuery(String query) throws Exception {
        return jnitcmsmbrpackageDAO.selectJnitcmsmbrpackageQuery(query);
    }
    
    /**
	 * JNITCMSMBRPACKAGE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRPACKAGE 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmbrpackageList(JnitcmsmbrpackageDefaultVO searchVO) throws Exception {
        return jnitcmsmbrpackageDAO.selectJnitcmsmbrpackageList(searchVO);
    }

    /**
	 * JNITCMSMBRPACKAGE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRPACKAGE 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrpackageListTotCnt(JnitcmsmbrpackageDefaultVO searchVO) {
		return jnitcmsmbrpackageDAO.selectJnitcmsmbrpackageListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSMBRPACKAGE 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmbrpackage() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsmbrpackageDAO.getLastIdJnitcmsmbrpackage() );
    }
}
