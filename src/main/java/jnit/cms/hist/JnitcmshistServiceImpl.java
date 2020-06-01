/**
 * @version 3.2.0.1
 */
package jnit.cms.hist;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmshistServiceImpl.java
 * @Description : Jnitcmshist Business Implement class
 * @Modification Information
 *
 * @author tactful
 * @since 2012.12.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmshistService")
public class JnitcmshistServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmshistService {

    @Resource(name="jnitcmshistDAO")
    private JnitcmshistDAO jnitcmshistDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSHISTIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitcmshist을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmshistVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmshist(JnitcmshistVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setHistId(id);
    	
    	jnitcmshistDAO.insertJnitcmshist(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * jnitcmshist을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmshistVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmshist(JnitcmshistVO vo) throws Exception {
        jnitcmshistDAO.updateJnitcmshist(vo);
    }

    /**
	 * jnitcmshist을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmshistVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmshist(JnitcmshistVO vo) throws Exception {
        jnitcmshistDAO.deleteJnitcmshist(vo);
    }

    /**
	 * jnitcmshist을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmshistVO
	 * @return 조회한 jnitcmshist
	 * @exception Exception
	 */
    public JnitcmshistVO selectJnitcmshist(JnitcmshistVO vo) throws Exception {
        JnitcmshistVO resultVO = jnitcmshistDAO.selectJnitcmshist(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitcmshist 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmshist 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmshistList(JnitcmshistDefaultVO searchVO) throws Exception {
        return jnitcmshistDAO.selectJnitcmshistList(searchVO);
    }

    /**
	 * jnitcmshist 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmshist 총 갯수
	 * @exception
	 */
    public int selectJnitcmshistListTotCnt(JnitcmshistDefaultVO searchVO) {
		return jnitcmshistDAO.selectJnitcmshistListTotCnt(searchVO);
	}
    
    /**
     * jnitcmshist 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmshist() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmshistDAO.getLastIdJnitcmshist() );
    }
}
