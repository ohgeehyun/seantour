/**
 * @version 3.2.0.1
 */
package jnit.cms.disseminatehisotry;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsdisseminatehistoryServiceImpl.java
 * @Description : Jnitcmsdisseminatehistory Business Implement class
 * @Modification Information
 *
 * @author JNITCMSDISSEMINATEHISTORY
 * @since 2013.11.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsdisseminatehistoryService")
public class JnitcmsdisseminatehistoryServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsdisseminatehistoryService {

    @Resource(name="jnitcmsdisseminatehistoryDAO")
    private JnitcmsdisseminatehistoryDAO jnitcmsdisseminatehistoryDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSDISSEMINATEHISTORYIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitcmsdisseminatehistory을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setHistoryId(id);
    	
    	jnitcmsdisseminatehistoryDAO.insertJnitcmsdisseminatehistory(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * jnitcmsdisseminatehistory을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception {
        jnitcmsdisseminatehistoryDAO.updateJnitcmsdisseminatehistory(vo);
    }

    /**
	 * jnitcmsdisseminatehistory을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception {
        jnitcmsdisseminatehistoryDAO.deleteJnitcmsdisseminatehistory(vo);
    }

    /**
	 * jnitcmsdisseminatehistory을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsdisseminatehistoryVO
	 * @return 조회한 jnitcmsdisseminatehistory
	 * @exception Exception
	 */
    public JnitcmsdisseminatehistoryVO selectJnitcmsdisseminatehistory(JnitcmsdisseminatehistoryVO vo) throws Exception {
        JnitcmsdisseminatehistoryVO resultVO = jnitcmsdisseminatehistoryDAO.selectJnitcmsdisseminatehistory(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitcmsdisseminatehistory 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminatehistory 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsdisseminatehistoryList(JnitcmsdisseminatehistoryDefaultVO searchVO) throws Exception {
        return jnitcmsdisseminatehistoryDAO.selectJnitcmsdisseminatehistoryList(searchVO);
    }
    
    /**
	 * jnitcmsdisseminatehistory 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminatehistory 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoinhistoryList(JnitcmsdisseminatehistoryDefaultVO searchVO) throws Exception {
        return jnitcmsdisseminatehistoryDAO.selectLeftJoinhistoryList(searchVO);
    }

    /**
	 * jnitcmsdisseminatehistory 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminatehistory 총 갯수
	 * @exception
	 */
    public int selectJnitcmsdisseminatehistoryListTotCnt(JnitcmsdisseminatehistoryDefaultVO searchVO) {
		return jnitcmsdisseminatehistoryDAO.selectJnitcmsdisseminatehistoryListTotCnt(searchVO);
	}
    
    /**
	 * jnitcmsdisseminatehistory 총 갯수를 조회한다.
	 * LEFT JOIN JNITCMSSITE
	 * LEFT JOIN JNITCMSMBR
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsdisseminatehistory 총 갯수
	 * @exception
	 */
    public int selectLeftJoinListTotCnt(JnitcmsdisseminatehistoryDefaultVO searchVO) {
		return jnitcmsdisseminatehistoryDAO.selectLeftJoinListTotCnt(searchVO); 
	}
    
    /**
     * jnitcmsdisseminatehistory 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsdisseminatehistory() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(4);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsdisseminatehistoryDAO.getLastIdJnitcmsdisseminatehistory() );
    }
}
