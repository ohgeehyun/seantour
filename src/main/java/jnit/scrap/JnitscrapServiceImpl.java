/**
 * @version 3.2.0.1
 */
package jnit.scrap;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitscrapServiceImpl.java
 * @Description : Jnitscrap Business Implement class
 * @Modification Information
 *
 * @author tactful
 * @since 2013.03.03
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitscrapService")
public class JnitscrapServiceImpl extends EgovAbstractServiceImpl implements
        JnitscrapService {

    @Resource(name="jnitscrapDAO")
    private JnitscrapDAO jnitscrapDAO;
    
    /** ID Generation */
    @Resource(name="jnitSCRAPIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitscrap을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitscrapVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitscrap(JnitscrapVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setScrapId(id);
    	
    	
    	jnitscrapDAO.insertJnitscrap(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * jnitscrap을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitscrapVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitscrap(JnitscrapVO vo) throws Exception {
        jnitscrapDAO.updateJnitscrap(vo);
    }

    /**
	 * jnitscrap을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitscrapVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitscrap(JnitscrapVO vo) throws Exception {
        jnitscrapDAO.deleteJnitscrap(vo);
    }

    /**
	 * jnitscrap을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitscrapVO
	 * @return 조회한 jnitscrap
	 * @exception Exception
	 */
    public JnitscrapVO selectJnitscrap(JnitscrapVO vo) throws Exception {
        JnitscrapVO resultVO = jnitscrapDAO.selectJnitscrap(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitscrap 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitscrap 목록
	 * @exception Exception
	 */
    public List<?> selectJnitscrapList(JnitscrapDefaultVO searchVO) throws Exception {
        return jnitscrapDAO.selectJnitscrapList(searchVO);
    }

    /**
	 * jnitscrap 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitscrap 총 갯수
	 * @exception
	 */
    public int selectJnitscrapListTotCnt(JnitscrapDefaultVO searchVO) {
		return jnitscrapDAO.selectJnitscrapListTotCnt(searchVO);
	}
    
    /**
     * jnitscrap 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitscrap() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitscrapDAO.getLastIdJnitscrap() );
    }
}
