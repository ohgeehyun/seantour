/**
 * @version 3.2.0.1
 */
package jnit.cms.tplhist;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmstplhistServiceImpl.java
 * @Description : Jnitcmstplhist Business Implement class
 * @Modification Information
 *
 * @author JNITCMSTPLHIST
 * @since 2014.05.02
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmstplhistService")
public class JnitcmstplhistServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmstplhistService {

    @Resource(name="jnitcmstplhistDAO")
    private JnitcmstplhistDAO jnitcmstplhistDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSTPLHIST_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSTPLHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmstplhistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmstplhist(JnitcmstplhistVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setHistId(id);
    	
    	
    	jnitcmstplhistDAO.insertJnitcmstplhist(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSTPLHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmstplhistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmstplhist(JnitcmstplhistVO vo) throws Exception {
        jnitcmstplhistDAO.updateJnitcmstplhist(vo);
    }

    /**
	 * JNITCMSTPLHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmstplhistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmstplhist(JnitcmstplhistVO vo) throws Exception {
        jnitcmstplhistDAO.deleteJnitcmstplhist(vo);
    }

    /**
	 * JNITCMSTPLHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmstplhistVO
	 * @return 조회한 JNITCMSTPLHIST
	 * @exception Exception
	 */
    public JnitcmstplhistVO selectJnitcmstplhist(JnitcmstplhistVO vo) throws Exception {
        JnitcmstplhistVO resultVO = jnitcmstplhistDAO.selectJnitcmstplhist(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSTPLHIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPLHIST 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmstplhistList(JnitcmstplhistDefaultVO searchVO) throws Exception {
        return jnitcmstplhistDAO.selectJnitcmstplhistList(searchVO);
    }

    /**
	 * JNITCMSTPLHIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSTPLHIST 총 갯수
	 * @exception
	 */
    public int selectJnitcmstplhistListTotCnt(JnitcmstplhistDefaultVO searchVO) {
		return jnitcmstplhistDAO.selectJnitcmstplhistListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSTPLHIST 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmstplhist() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmstplhistDAO.getLastIdJnitcmstplhist() );
    }
}
