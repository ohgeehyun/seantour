/**
 * @version 3.2.0.1
 */
package jnit.cms.menumgr;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsmenumgrServiceImpl.java
 * @Description : Jnitcmsmenumgr Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmenumgrService")
public class JnitcmsmenumgrServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmenumgrService {

    @Resource(name="jnitcmsmenumgrDAO")
    private JnitcmsmenumgrDAO jnitcmsmenumgrDAO;
    
    /** ID Generation */
    //@Resource(name="{egovJnitcmsmenumgrIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMENUMGR을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmenumgrVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	
    	
    	jnitcmsmenumgrDAO.insertJnitcmsmenumgr(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * JNITCMSMENUMGR을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmenumgrVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception {
        jnitcmsmenumgrDAO.updateJnitcmsmenumgr(vo);
    }

    /**
	 * JNITCMSMENUMGR을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsmenumgrVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception {
        jnitcmsmenumgrDAO.deleteJnitcmsmenumgr(vo);
    }

    /**
	 * JNITCMSMENUMGR을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmenumgrVO
	 * @return 조회한 JNITCMSMENUMGR
	 * @exception Exception
	 */
    public JnitcmsmenumgrVO selectJnitcmsmenumgr(JnitcmsmenumgrVO vo) throws Exception {
        JnitcmsmenumgrVO resultVO = jnitcmsmenumgrDAO.selectJnitcmsmenumgr(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSMENUMGR 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENUMGR 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsmenumgrList(JnitcmsmenumgrDefaultVO searchVO) throws Exception {
        return jnitcmsmenumgrDAO.selectJnitcmsmenumgrList(searchVO);
    }

    /**
	 * JNITCMSMENUMGR 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMENUMGR 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmenumgrListTotCnt(JnitcmsmenumgrDefaultVO searchVO) {
		return jnitcmsmenumgrDAO.selectJnitcmsmenumgrListTotCnt(searchVO);
	}
    
    /**
     * JNITCMSMENUMGR 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsmenumgr() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsmenumgrDAO.getLastIdJnitcmsmenumgr() );
    }
}
