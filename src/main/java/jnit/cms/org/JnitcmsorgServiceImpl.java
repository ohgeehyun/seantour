/**
 * @version 3.2.0.1
 */
package jnit.cms.org;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsorgServiceImpl.java
 * @Description : Jnitcmsorg Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsorgService")
public class JnitcmsorgServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsorgService {

    @Resource(name="jnitcmsorgDAO")
    private JnitcmsorgDAO jnitcmsorgDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSORGIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSORG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsorgVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsorg(JnitcmsorgVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setOrgId(id);
    	
    	
    	jnitcmsorgDAO.insertJnitcmsorg(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }
    
    /**
	 * JNITCMSORG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsorgVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertDbConnectorg(JnitcmsorgVO vo) throws Exception {
    	   	
    	
    	jnitcmsorgDAO.insertDbConnectorg(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSORG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsorgVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsorg(JnitcmsorgVO vo) throws Exception {
        jnitcmsorgDAO.updateJnitcmsorg(vo);
    }

    /**
	 * JNITCMSORG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsorgVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsorg(JnitcmsorgVO vo) throws Exception {
        jnitcmsorgDAO.deleteJnitcmsorg(vo);
    }

    /**
	 * JNITCMSORG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsorgVO
	 * @return 조회한 JNITCMSORG
	 * @exception Exception
	 */
    public JnitcmsorgVO selectJnitcmsorg(JnitcmsorgVO vo) throws Exception {
        JnitcmsorgVO resultVO = jnitcmsorgDAO.selectJnitcmsorg(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSORG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSORG 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsorgList(JnitcmsorgDefaultVO searchVO) throws Exception {
        return jnitcmsorgDAO.selectJnitcmsorgList(searchVO);
    }
    
    /**
	 * JNITCMSORG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSORG 목록
	 * @exception Exception
	 */
    public List<?> selectcmsorgList(JnitcmsorgDefaultVO searchVO) throws Exception {
        return jnitcmsorgDAO.selectcmsorgList(searchVO);
    }

    /**
	 * JNITCMSORG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSORG 총 갯수
	 * @exception
	 */
    public int selectJnitcmsorgListTotCnt(JnitcmsorgDefaultVO searchVO) {
		return jnitcmsorgDAO.selectJnitcmsorgListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSORG 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsorg() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("2");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(4);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsorgDAO.getLastIdJnitcmsorg() );
    }
}
