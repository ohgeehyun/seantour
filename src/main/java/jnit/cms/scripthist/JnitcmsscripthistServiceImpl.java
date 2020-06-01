/**
 * @version 3.2.0.1
 */
package jnit.cms.scripthist;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsscripthistServiceImpl.java
 * @Description : Jnitcmsscripthist Business Implement class
 * @Modification Information
 *
 * @author JNITCMSSCRIPTHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsscripthistService")
public class JnitcmsscripthistServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsscripthistService {

    @Resource(name="jnitcmsscripthistDAO")
    private JnitcmsscripthistDAO jnitcmsscripthistDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSSCRIPTHIST_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSSCRIPTHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsscripthistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setHistId(id);
    	
    	
    	jnitcmsscripthistDAO.insertJnitcmsscripthist(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSSCRIPTHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsscripthistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception {
        jnitcmsscripthistDAO.updateJnitcmsscripthist(vo);
    }

    /**
	 * JNITCMSSCRIPTHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsscripthistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception {
        jnitcmsscripthistDAO.deleteJnitcmsscripthist(vo);
    }

    /**
	 * JNITCMSSCRIPTHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsscripthistVO
	 * @return 조회한 JNITCMSSCRIPTHIST
	 * @exception Exception
	 */
    public JnitcmsscripthistVO selectJnitcmsscripthist(JnitcmsscripthistVO vo) throws Exception {
        JnitcmsscripthistVO resultVO = jnitcmsscripthistDAO.selectJnitcmsscripthist(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSSCRIPTHIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSSCRIPTHIST 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsscripthistList(JnitcmsscripthistDefaultVO searchVO) throws Exception {
        return jnitcmsscripthistDAO.selectJnitcmsscripthistList(searchVO);
    }

    /**
	 * JNITCMSSCRIPTHIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSSCRIPTHIST 총 갯수
	 * @exception
	 */
    public int selectJnitcmsscripthistListTotCnt(JnitcmsscripthistDefaultVO searchVO) {
		return jnitcmsscripthistDAO.selectJnitcmsscripthistListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSSCRIPTHIST 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsscripthist() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsscripthistDAO.getLastIdJnitcmsscripthist() );
    }
}
