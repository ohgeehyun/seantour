/**
 * @version 3.2.0.1
 */
package jnit.board.cmt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitboardcmtServiceImpl.java
 * @Description : Jnitboardcmt Business Implement class
 * @Modification Information
 *
 * @author JNITBOARDCMT
 * @since 2013.07.11
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitboardcmtService")
public class JnitboardcmtServiceImpl extends EgovAbstractServiceImpl implements
        JnitboardcmtService {

    @Resource(name="jnitboardcmtDAO")
    private JnitboardcmtDAO jnitboardcmtDAO;
    
    /** ID Generation */
    @Resource(name="jnitBOARDCMTIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitboardcmt을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardcmtVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardcmt(JnitboardcmtVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setCmtId(id);
    	
    	jnitboardcmtDAO.insertJnitboardcmt(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * jnitboardcmt을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardcmtVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardcmt(JnitboardcmtVO vo) throws Exception {
        jnitboardcmtDAO.updateJnitboardcmt(vo);
    }

    /**
	 * jnitboardcmt을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardcmtVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardcmt(JnitboardcmtVO vo) throws Exception {
        jnitboardcmtDAO.deleteJnitboardcmt(vo);
    }

    /**
	 * jnitboardcmt을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardcmtVO
	 * @return 조회한 jnitboardcmt
	 * @exception Exception
	 */
    public JnitboardcmtVO selectJnitboardcmt(JnitboardcmtVO vo) throws Exception {
        JnitboardcmtVO resultVO = jnitboardcmtDAO.selectJnitboardcmt(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitboardcmt 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardcmt 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardcmtList(JnitboardcmtDefaultVO searchVO) throws Exception {
        return jnitboardcmtDAO.selectJnitboardcmtList(searchVO);
    }

    /**
	 * jnitboardcmt 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardcmt 총 갯수
	 * @exception
	 */
    public int selectJnitboardcmtListTotCnt(JnitboardcmtDefaultVO searchVO) {
		return jnitboardcmtDAO.selectJnitboardcmtListTotCnt(searchVO);
	}
    
    /**
     * jnitboardcmt 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitboardcmt() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitboardcmtDAO.getLastIdJnitboardcmt() );
    }
}
