/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrtype;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsmbrtypeServiceImpl.java
 * @Description : Jnitcmsmbrtype Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmbrtypeService")
public class JnitcmsmbrtypeServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmbrtypeService {

    @Resource(name="jnitcmsmbrtypeDAO")
    private JnitcmsmbrtypeDAO jnitcmsmbrtypeDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSMBRTYPEIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMBRTYPE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setTypeId(id);
    	
    	jnitcmsmbrtypeDAO.insertJnitcmsmbrtype(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSMBRTYPE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception {
        jnitcmsmbrtypeDAO.updateJnitcmsmbrtype(vo);
    }
    
    public void updateJnitcmsmbrtypetree(JnitcmsmbrtypeVO vo) throws Exception {
        jnitcmsmbrtypeDAO.updateJnitcmsmbrtypetree(vo);
    }

    /**
	 * JNITCMSMBRTYPE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception {
        jnitcmsmbrtypeDAO.deleteJnitcmsmbrtype(vo);
    }

    /**
	 * JNITCMSMBRTYPE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrtypeVO
	 * @return 조회한 JNITCMSMBRTYPE
	 * @exception Exception
	 */
    public JnitcmsmbrtypeVO selectJnitcmsmbrtype(JnitcmsmbrtypeVO vo) throws Exception {
        JnitcmsmbrtypeVO resultVO = jnitcmsmbrtypeDAO.selectJnitcmsmbrtype(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSMBRTYPE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRTYPE 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmbrtypeList(JnitcmsmbrtypeDefaultVO searchVO) throws Exception {
        return jnitcmsmbrtypeDAO.selectJnitcmsmbrtypeList(searchVO);
    }

    /**
	 * JNITCMSMBRTYPE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRTYPE 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrtypeListTotCnt(JnitcmsmbrtypeDefaultVO searchVO) {
		return jnitcmsmbrtypeDAO.selectJnitcmsmbrtypeListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSMBRTYPE 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmbrtype() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("3");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(4);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsmbrtypeDAO.getLastIdJnitcmsmbrtype() );
    }
}
