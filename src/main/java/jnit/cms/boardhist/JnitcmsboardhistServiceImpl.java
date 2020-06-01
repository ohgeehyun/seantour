/**
 * @version 3.2.0.1
 */
package jnit.cms.boardhist;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsboardhistServiceImpl.java
 * @Description : Jnitcmsboardhist Business Implement class
 * @Modification Information
 *
 * @author JNITCMSBOARDHIST
 * @since 2014.08.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsboardhistService")
public class JnitcmsboardhistServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsboardhistService {

    @Resource(name="jnitcmsboardhistDAO")
    private JnitcmsboardhistDAO jnitcmsboardhistDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSBOARDHIST_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSBOARDHIST을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsboardhistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setHistId(id);
    	
    	jnitcmsboardhistDAO.insertJnitcmsboardhist(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSBOARDHIST을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsboardhistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception {
        jnitcmsboardhistDAO.updateJnitcmsboardhist(vo);
    }

    /**
	 * JNITCMSBOARDHIST을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsboardhistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception {
        jnitcmsboardhistDAO.deleteJnitcmsboardhist(vo);
    }

    /**
	 * JNITCMSBOARDHIST을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsboardhistVO
	 * @return 조회한 JNITCMSBOARDHIST
	 * @exception Exception
	 */
    public JnitcmsboardhistVO selectJnitcmsboardhist(JnitcmsboardhistVO vo) throws Exception {
        JnitcmsboardhistVO resultVO = jnitcmsboardhistDAO.selectJnitcmsboardhist(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSBOARDHIST 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSBOARDHIST 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsboardhistList(JnitcmsboardhistDefaultVO searchVO) throws Exception {
        return jnitcmsboardhistDAO.selectJnitcmsboardhistList(searchVO);
    }

    /**
	 * JNITCMSBOARDHIST 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSBOARDHIST 총 갯수
	 * @exception
	 */
    public int selectJnitcmsboardhistListTotCnt(JnitcmsboardhistDefaultVO searchVO) {
		return jnitcmsboardhistDAO.selectJnitcmsboardhistListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSBOARDHIST 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsboardhist() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsboardhistDAO.getLastIdJnitcmsboardhist() );
    }
}
