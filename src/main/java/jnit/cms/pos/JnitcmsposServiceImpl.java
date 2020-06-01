/**
 * @version 3.2.0.1
 */
package jnit.cms.pos;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsposServiceImpl.java
 * @Description : Jnitcmspos Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsposService")
public class JnitcmsposServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsposService {

    @Resource(name="jnitcmsposDAO")
    private JnitcmsposDAO jnitcmsposDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSPOSIdGnrService")    
    private EgovIdGnrService egovIdGnrService;
	/**
	 * JNITCMSPOS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsposVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmspos(JnitcmsposVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setPosId(id);
    	
    	
    	jnitcmsposDAO.insertJnitcmspos(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }
    
    /**
	 * JNITCMSPOS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsposVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertDbConnectpos(JnitcmsposVO vo) throws Exception {
    	
    	
    	jnitcmsposDAO.insertDbConnectpos(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }
    
    /**
     * JNITCMSPOS 다음 ID를 조회한다
     * @param void
     * @return 다음ID
     * @exception Exception
     */
    public String getNextIdJnitcmspos() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("1");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(4);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsposDAO.getLastPosIdJnitcmspos() );
    }

    /**
	 * JNITCMSPOS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsposVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmspos(JnitcmsposVO vo) throws Exception {
        jnitcmsposDAO.updateJnitcmspos(vo);
    }

    /**
	 * JNITCMSPOS을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsposVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmspos(JnitcmsposVO vo) throws Exception {
        jnitcmsposDAO.deleteJnitcmspos(vo);
    }

    /**
	 * JNITCMSPOS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsposVO
	 * @return 조회한 JNITCMSPOS
	 * @exception Exception
	 */
    public JnitcmsposVO selectJnitcmspos(JnitcmsposVO vo) throws Exception {
        JnitcmsposVO resultVO = jnitcmsposDAO.selectJnitcmspos(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSPOS 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSPOS 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsposList(JnitcmsposDefaultVO searchVO) throws Exception {
        return jnitcmsposDAO.selectJnitcmsposList(searchVO);
    }

    /**
	 * JNITCMSPOS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSPOS 총 갯수
	 * @exception
	 */
    public int selectJnitcmsposListTotCnt(JnitcmsposDefaultVO searchVO) {
		return jnitcmsposDAO.selectJnitcmsposListTotCnt(searchVO);
	}
    
}
