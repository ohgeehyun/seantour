/**
 * @version 3.2.0.1
 */
package jnit.visit.count;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitvisitcountServiceImpl.java
 * @Description : Jnitvisitcount Business Implement class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.11.30
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitvisitcountService")
public class JnitvisitcountServiceImpl extends EgovAbstractServiceImpl implements
        JnitvisitcountService {

    @Resource(name="jnitvisitcountDAO")
    private JnitvisitcountDAO jnitvisitcountDAO;
    
    /** ID Generation */
    //@Resource(name="{egovJnitvisitcountIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitvisitcount을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitvisitcountVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitvisitcount(JnitvisitcountVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	
    	
    	jnitvisitcountDAO.insertJnitvisitcount(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * jnitvisitcount을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitvisitcountVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitvisitcount(JnitvisitcountVO vo) throws Exception {
        jnitvisitcountDAO.updateJnitvisitcount(vo);
    }

    /**
	 * jnitvisitcount을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitvisitcountVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitvisitcount(JnitvisitcountVO vo) throws Exception {
        jnitvisitcountDAO.deleteJnitvisitcount(vo);
    }

    /**
	 * jnitvisitcount을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitvisitcountVO
	 * @return 조회한 jnitvisitcount
	 * @exception Exception
	 */
    public JnitvisitcountVO selectJnitvisitcount(JnitvisitcountVO vo) throws Exception {
        JnitvisitcountVO resultVO = jnitvisitcountDAO.selectJnitvisitcount(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    
    public JnitvisitcountVO selectJnitvisitTotalCount(JnitvisitcountVO vo) throws Exception {
        JnitvisitcountVO resultVO = jnitvisitcountDAO.selectJnitvisitTotalCount(vo);
        /*if (resultVO == null)
            throw processException("info.nodata.msg");*/
        return resultVO;
    }
    
    /**
	 * jnitvisitcount 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitvisitcount 목록
	 * @exception Exception
	 */
    public List<?> selectJnitvisitcountList(JnitvisitcountDefaultVO searchVO) throws Exception {
        return jnitvisitcountDAO.selectJnitvisitcountList(searchVO);
    }

    public List<?> selectJnitvisitSiteList(JnitvisitcountDefaultVO searchVO) throws Exception {
        return jnitvisitcountDAO.selectJnitvisitSiteList(searchVO);
    }
    /**
	 * jnitvisitcount 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitvisitcount 총 갯수
	 * @exception
	 */
    public int selectJnitvisitcountListTotCnt(JnitvisitcountDefaultVO searchVO) {
		return jnitvisitcountDAO.selectJnitvisitcountListTotCnt(searchVO);
	}
    
    /**
	 * jnitvisitcount HIT 총합을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitvisitcount 총 갯수
	 * @exception
	 */
    public int selectJnitvisitcountHitTotCnt(JnitvisitcountDefaultVO searchVO) {
		return jnitvisitcountDAO.selectJnitvisitcountHitTotCnt(searchVO);
	}
    
    /**
	 * 방문자 접속 통계를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitvisitcount 목록
	 * @exception Exception
	 */
	public List<?> selectJnitvisitcountStats(JnitvisitcountDefaultVO searchVO)
			throws Exception {
		return jnitvisitcountDAO.selectJnitvisitcountStats(searchVO);
	}
	
    /**
     * jnitvisitcount 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitvisitcount() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitvisitcountDAO.getLastIdJnitvisitcount() );
    }
}
