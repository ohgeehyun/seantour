/**
 * @version 3.2.0.1
 */
package jnit.cms.csshist;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmscsshistServiceImpl.java
 * @Description : Jnitcmscsshist Business Implement class
 * @Modification Information
 *
 * @author JNITCMSCSSHIST
 * @since 2014.04.18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmscsshistService")
public class JnitcmscsshistServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmscsshistService {

    @Resource(name="jnitcmscsshistDAO")
    private JnitcmscsshistDAO jnitcmscsshistDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSCSSHIST_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSCSSHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmscsshistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmscsshist(JnitcmscsshistVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setHistId(id);
    	
    	jnitcmscsshistDAO.insertJnitcmscsshist(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSCSSHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmscsshistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmscsshist(JnitcmscsshistVO vo) throws Exception {
        jnitcmscsshistDAO.updateJnitcmscsshist(vo);
    }

    /**
	 * JNITCMSCSSHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmscsshistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmscsshist(JnitcmscsshistVO vo) throws Exception {
        jnitcmscsshistDAO.deleteJnitcmscsshist(vo);
    }

    /**
	 * JNITCMSCSSHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscsshistVO
	 * @return 조회한 JNITCMSCSSHIST
	 * @exception Exception
	 */
    public JnitcmscsshistVO selectJnitcmscsshist(JnitcmscsshistVO vo) throws Exception {
        JnitcmscsshistVO resultVO = jnitcmscsshistDAO.selectJnitcmscsshist(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSCSSHIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCSSHIST 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmscsshistList(JnitcmscsshistDefaultVO searchVO) throws Exception {
        return jnitcmscsshistDAO.selectJnitcmscsshistList(searchVO);
    }

    /**
	 * JNITCMSCSSHIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCSSHIST 총 갯수
	 * @exception
	 */
    public int selectJnitcmscsshistListTotCnt(JnitcmscsshistDefaultVO searchVO) {
		return jnitcmscsshistDAO.selectJnitcmscsshistListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSCSSHIST 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmscsshist() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmscsshistDAO.getLastIdJnitcmscsshist() );
    }
}
