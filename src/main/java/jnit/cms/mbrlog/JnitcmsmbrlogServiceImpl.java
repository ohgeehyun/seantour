/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrlog;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsmbrlogServiceImpl.java
 * @Description : Jnitcmsmbrlog Business Implement class
 * @Modification Information
 *
 * @author JNITCMSMBRLOG
 * @since 2014.03.09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmbrlogService")
public class JnitcmsmbrlogServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmbrlogService {

    @Resource(name="jnitcmsmbrlogDAO")
    private JnitcmsmbrlogDAO jnitcmsmbrlogDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSMBRLOG_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMBRLOG을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrlogVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMbrlogId(id);
    	
    	jnitcmsmbrlogDAO.insertJnitcmsmbrlog(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSMBRLOG을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrlogVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception {
        jnitcmsmbrlogDAO.updateJnitcmsmbrlog(vo);
    }

    /**
	 * JNITCMSMBRLOG을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrlogVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception {
        jnitcmsmbrlogDAO.deleteJnitcmsmbrlog(vo);
    }

    /**
	 * JNITCMSMBRLOG을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrlogVO
	 * @return 조회한 JNITCMSMBRLOG
	 * @exception Exception
	 */
    public JnitcmsmbrlogVO selectJnitcmsmbrlog(JnitcmsmbrlogVO vo) throws Exception {
        JnitcmsmbrlogVO resultVO = jnitcmsmbrlogDAO.selectJnitcmsmbrlog(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSMBRLOG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRLOG 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmbrlogList(JnitcmsmbrlogDefaultVO searchVO) throws Exception {
        return jnitcmsmbrlogDAO.selectJnitcmsmbrlogList(searchVO);
    }
    
    /**
	 * JNITCMSMBRLOG 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRLOG 목록
	 * @exception Exception
	 */
    public List<?> selectLeftcmsmbrlogList(JnitcmsmbrlogDefaultVO searchVO) throws Exception {
        return jnitcmsmbrlogDAO.selectLeftcmsmbrlogList(searchVO);
    }    
    

    /**
	 * JNITCMSMBRLOG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRLOG 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrlogListTotCnt(JnitcmsmbrlogDefaultVO searchVO) {
		return jnitcmsmbrlogDAO.selectJnitcmsmbrlogListTotCnt(searchVO);
	}
    
    /**
	 * JNITCMSMBRLOG 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRLOG 총 갯수
	 * @exception
	 */
    public int selectLeftcmsmbrlogListTotCnt(JnitcmsmbrlogDefaultVO searchVO) {
		return jnitcmsmbrlogDAO.selectLeftcmsmbrlogListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSMBRLOG 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmbrlog() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsmbrlogDAO.getLastIdJnitcmsmbrlog() );
    }
}
