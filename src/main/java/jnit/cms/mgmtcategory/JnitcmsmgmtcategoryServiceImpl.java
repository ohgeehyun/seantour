/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtcategory;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsmgmtcategoryServiceImpl.java
 * @Description : Jnitcmsmgmtcategory Business Implement class
 * @Modification Information
 *
 * @author JNITCMSMGMTCATEGORY
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmgmtcategoryService")
public class JnitcmsmgmtcategoryServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmgmtcategoryService {

    @Resource(name="jnitcmsmgmtcategoryDAO")
    private JnitcmsmgmtcategoryDAO jnitcmsmgmtcategoryDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSMGMTCATEGORY_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMGMTCATEGORY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMgmtCategoryId(id);
    	
    	
    	jnitcmsmgmtcategoryDAO.insertJnitcmsmgmtcategory(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITCMSMGMTCATEGORY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception {
        jnitcmsmgmtcategoryDAO.updateJnitcmsmgmtcategory(vo);
    }

    /**
	 * JNITCMSMGMTCATEGORY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception {
        jnitcmsmgmtcategoryDAO.deleteJnitcmsmgmtcategory(vo);
    }

    /**
	 * JNITCMSMGMTCATEGORY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtcategoryVO
	 * @return 조회한 JNITCMSMGMTCATEGORY
	 * @exception Exception
	 */
    public JnitcmsmgmtcategoryVO selectJnitcmsmgmtcategory(JnitcmsmgmtcategoryVO vo) throws Exception {
        JnitcmsmgmtcategoryVO resultVO = jnitcmsmgmtcategoryDAO.selectJnitcmsmgmtcategory(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSMGMTCATEGORY 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMTCATEGORY 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmgmtcategoryList(JnitcmsmgmtcategoryDefaultVO searchVO) throws Exception {
        return jnitcmsmgmtcategoryDAO.selectJnitcmsmgmtcategoryList(searchVO);
    }

    /**
	 * JNITCMSMGMTCATEGORY 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMTCATEGORY 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmgmtcategoryListTotCnt(JnitcmsmgmtcategoryDefaultVO searchVO) {
		return jnitcmsmgmtcategoryDAO.selectJnitcmsmgmtcategoryListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSMGMTCATEGORY 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmgmtcategory() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsmgmtcategoryDAO.getLastIdJnitcmsmgmtcategory() );
    }
}
