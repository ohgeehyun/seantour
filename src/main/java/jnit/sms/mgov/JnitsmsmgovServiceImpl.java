/**
 * @version 3.2.0.1
 */
package jnit.sms.mgov;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitsmsmgovServiceImpl.java
 * @Description : Jnitsmsmgov Business Implement class
 * @Modification Information
 *
 * @author JNITSMSMGOV
 * @since 2013.11.25
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitsmsmgovService")
public class JnitsmsmgovServiceImpl extends EgovAbstractServiceImpl implements
        JnitsmsmgovService {

    @Resource(name="jnitsmsmgovDAO")
    private JnitsmsmgovDAO jnitsmsmgovDAO;
    
    /** ID Generation */
    @Resource(name="jnitsmsmgovIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitsmsmgov을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitsmsmgovVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitsmsmgov(JnitsmsmgovVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setMsgKey(id);
    	
    	
    	jnitsmsmgovDAO.insertJnitsmsmgov(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * jnitsmsmgov을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitsmsmgovVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitsmsmgov(JnitsmsmgovVO vo) throws Exception {
        jnitsmsmgovDAO.updateJnitsmsmgov(vo);
    }

    /**
	 * jnitsmsmgov을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitsmsmgovVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitsmsmgov(JnitsmsmgovVO vo) throws Exception {
        jnitsmsmgovDAO.deleteJnitsmsmgov(vo);
    }

    /**
	 * jnitsmsmgov을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitsmsmgovVO
	 * @return 조회한 jnitsmsmgov
	 * @exception Exception
	 */
    public JnitsmsmgovVO selectJnitsmsmgov(JnitsmsmgovVO vo) throws Exception {
        JnitsmsmgovVO resultVO = jnitsmsmgovDAO.selectJnitsmsmgov(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitsmsmgov 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitsmsmgov 목록
	 * @exception Exception
	 */
    public List<?> selectJnitsmsmgovList(JnitsmsmgovDefaultVO searchVO) throws Exception {
        return jnitsmsmgovDAO.selectJnitsmsmgovList(searchVO);
    }

    /**
	 * jnitsmsmgov 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitsmsmgov 총 갯수
	 * @exception
	 */
    public int selectJnitsmsmgovListTotCnt(JnitsmsmgovDefaultVO searchVO) {
		return jnitsmsmgovDAO.selectJnitsmsmgovListTotCnt(searchVO);
	}
    
    /**
     * jnitsmsmgov 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitsmsmgov() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitsmsmgovDAO.getLastIdJnitsmsmgov() );
    }
}
