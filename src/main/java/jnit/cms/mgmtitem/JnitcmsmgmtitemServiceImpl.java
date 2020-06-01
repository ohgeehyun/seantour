/**
 * @version 3.2.0.1
 */
package jnit.cms.mgmtitem;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsmgmtitemServiceImpl.java
 * @Description : Jnitcmsmgmtitem Business Implement class
 * @Modification Information
 *
 * @author JNITCMSMGMTITEM
 * @since 2014.09.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmgmtitemService")
public class JnitcmsmgmtitemServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmgmtitemService {

    @Resource(name="jnitcmsmgmtitemDAO")
    private JnitcmsmgmtitemDAO jnitcmsmgmtitemDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSMGMTITEM_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMGMTITEM을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setCategoryId(id);
    	
    	
    	jnitcmsmgmtitemDAO.insertJnitcmsmgmtitem(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSMGMTITEM을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception {
        jnitcmsmgmtitemDAO.updateJnitcmsmgmtitem(vo);
    }

    /**
	 * JNITCMSMGMTITEM을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception {
        jnitcmsmgmtitemDAO.deleteJnitcmsmgmtitem(vo);
    }

    /**
	 * JNITCMSMGMTITEM을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmgmtitemVO
	 * @return 조회한 JNITCMSMGMTITEM
	 * @exception Exception
	 */
    public JnitcmsmgmtitemVO selectJnitcmsmgmtitem(JnitcmsmgmtitemVO vo) throws Exception {
        JnitcmsmgmtitemVO resultVO = jnitcmsmgmtitemDAO.selectJnitcmsmgmtitem(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSMGMTITEM 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMTITEM 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmgmtitemList(JnitcmsmgmtitemDefaultVO searchVO) throws Exception {
        return jnitcmsmgmtitemDAO.selectJnitcmsmgmtitemList(searchVO);
    }

    /**
	 * JNITCMSMGMTITEM 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMGMTITEM 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmgmtitemListTotCnt(JnitcmsmgmtitemDefaultVO searchVO) {
		return jnitcmsmgmtitemDAO.selectJnitcmsmgmtitemListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSMGMTITEM 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmgmtitem() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsmgmtitemDAO.getLastIdJnitcmsmgmtitem() );
    }
}
