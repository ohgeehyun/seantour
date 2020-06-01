/**
 * @version 3.2.0.1
 */
package jnit.cms.site;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;
import jnit.cms.listener.ContextLoaderListener;

/**
 * @Class Name : JnitcmssiteServiceImpl.java
 * @Description : Jnitcmssite Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmssiteService")
public class JnitcmssiteServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmssiteService {

    @Resource(name="jnitcmssiteDAO")
    private JnitcmssiteDAO jnitcmssiteDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSSITEIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSSITE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmssiteVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmssite(JnitcmssiteVO vo) throws Exception {
    	if(!ContextLoaderListener.isValidLicense())throw new Exception("CMS License is not avialable!!");
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setSiteId(id);
    	
    	
    	jnitcmssiteDAO.insertJnitcmssite(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITCMSSITE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmssiteVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmssite(JnitcmssiteVO vo) throws Exception {
        jnitcmssiteDAO.updateJnitcmssite(vo);
    }

    /**
	 * JNITCMSSITE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmssiteVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmssite(JnitcmssiteVO vo) throws Exception {
        jnitcmssiteDAO.deleteJnitcmssite(vo);
    }

    /**
	 * JNITCMSSITE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmssiteVO
	 * @return 조회한 JNITCMSSITE
	 * @exception Exception
	 */
    public JnitcmssiteVO selectJnitcmssite(JnitcmssiteVO vo) throws Exception {
        JnitcmssiteVO resultVO = jnitcmssiteDAO.selectJnitcmssite(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSSITE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSSITE 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmssiteList(JnitcmssiteDefaultVO searchVO) throws Exception {
        return jnitcmssiteDAO.selectJnitcmssiteList(searchVO);
    }

    /**
	 * JNITCMSSITE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSSITE 총 갯수
	 * @exception
	 */
    public int selectJnitcmssiteListTotCnt(JnitcmssiteDefaultVO searchVO) {
		return jnitcmssiteDAO.selectJnitcmssiteListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSSITE 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmssite() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("SITE_");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(5);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmssiteDAO.getLastIdJnitcmssite() );
    }
    
    /**
     * JNITCMSSITE 다음 등록 ORD를 조회한다
     * @param void
     * @return 다음 등록 ORD
     * @exception Exception
     */
    public int getNextOrdJnitcmssite() throws Exception {    	
        return jnitcmssiteDAO.getNextOrdJnitcmssite();
    }
    
    /**
     * 사이트정보를 코드형태로 리턴한다.
     * 
     * @param 조회조건정보 vo
     * @return 그룹정보 List
     * @throws Exception
     */
    public List<CmmnDetailCode> selectSiteIdDetail(ComDefaultCodeVO vo) throws Exception {
   		return jnitcmssiteDAO.selectSiteIdDetail(vo);
    }
}
