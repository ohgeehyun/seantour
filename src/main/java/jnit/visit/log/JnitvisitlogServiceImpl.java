/**
 * @version 3.2.0.1
 */
package jnit.visit.log;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitvisitlogServiceImpl.java
 * @Description : Jnitvisitlog Business Implement class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitvisitlogService")
public class JnitvisitlogServiceImpl extends EgovAbstractServiceImpl implements
        JnitvisitlogService {

    @Resource(name="jnitvisitlogDAO")
    private JnitvisitlogDAO jnitvisitlogDAO;
    
    /** ID Generation */
    //@Resource(name="{egovJnitvisitlogIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITVISITLOG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitvisitlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitvisitlog(JnitvisitlogVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	
    	
    	jnitvisitlogDAO.insertJnitvisitlog(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }
    
    /**
	 * JNITVISITLOG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITVISITLOG 총 갯수
	 * @exception
	 */
    public int selectJnitvisitlogDataCnt(JnitvisitlogVO jnitvisitlogVO) {
		return jnitvisitlogDAO.selectJnitvisitlogDataCnt(jnitvisitlogVO);
	}
    

    /**
	 * JNITVISITLOG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitvisitlogVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitvisitlog(JnitvisitlogVO vo) throws Exception {
        jnitvisitlogDAO.updateJnitvisitlog(vo);
    }

    /**
	 * JNITVISITLOG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitvisitlogVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitvisitlog(JnitvisitlogVO vo) throws Exception {
        jnitvisitlogDAO.deleteJnitvisitlog(vo);
    }

    /**
	 * JNITVISITLOG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitvisitlogVO
	 * @return 조회한 JNITVISITLOG
	 * @exception Exception
	 */
    public JnitvisitlogVO selectJnitvisitlog(JnitvisitlogVO vo) throws Exception {
        JnitvisitlogVO resultVO = jnitvisitlogDAO.selectJnitvisitlog(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITVISITLOG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITVISITLOG 목록
	 * @exception Exception
	 */
    public List<?> selectJnitvisitlogList(JnitvisitlogDefaultVO searchVO) throws Exception {
        return jnitvisitlogDAO.selectJnitvisitlogList(searchVO);
    }

    /**
	 * JNITVISITLOG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITVISITLOG 총 갯수
	 * @exception
	 */
    public int selectJnitvisitlogListTotCnt(JnitvisitlogDefaultVO searchVO) {
		return jnitvisitlogDAO.selectJnitvisitlogListTotCnt(searchVO);
	}
    
    /**
     * JNITVISITLOG 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitvisitlog() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitvisitlogDAO.getLastIdJnitvisitlog() );
    }
}
