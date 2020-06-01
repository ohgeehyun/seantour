/**
 * @version 3.2.0.1
 */
package jnit.board.good;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitboardgoodServiceImpl.java
 * @Description : Jnitboardgood Business Implement class
 * @Modification Information
 *
 * @author JNITBOARADGOOD
 * @since 2013.11.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitboardgoodService")
public class JnitboardgoodServiceImpl extends EgovAbstractServiceImpl implements
        JnitboardgoodService {

    @Resource(name="jnitboardgoodDAO")
    private JnitboardgoodDAO jnitboardgoodDAO;
    
    /** ID Generation */
    @Resource(name="jnitBOARDGOODIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitboardgood을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitboardgoodVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitboardgood(JnitboardgoodVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setIdx(id);
    	
    	jnitboardgoodDAO.insertJnitboardgood(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * jnitboardgood을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitboardgoodVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitboardgood(JnitboardgoodVO vo) throws Exception {
        jnitboardgoodDAO.updateJnitboardgood(vo);
    }

    /**
	 * jnitboardgood을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitboardgoodVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitboardgood(JnitboardgoodVO vo) throws Exception {
        jnitboardgoodDAO.deleteJnitboardgood(vo);
    }

    /**
	 * jnitboardgood을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitboardgoodVO
	 * @return 조회한 jnitboardgood
	 * @exception Exception
	 */
    public JnitboardgoodVO selectJnitboardgood(JnitboardgoodVO vo) throws Exception {
        JnitboardgoodVO resultVO = jnitboardgoodDAO.selectJnitboardgood(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitboardgood 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardgood 목록
	 * @exception Exception
	 */
    public List<?> selectJnitboardgoodList(JnitboardgoodDefaultVO searchVO) throws Exception {
        return jnitboardgoodDAO.selectJnitboardgoodList(searchVO);
    }

    /**
	 * jnitboardgood 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitboardgood 총 갯수
	 * @exception
	 */
    public int selectJnitboardgoodListTotCnt(JnitboardgoodDefaultVO searchVO) {
		return jnitboardgoodDAO.selectJnitboardgoodListTotCnt(searchVO);
	}
    
    /**
     * jnitboardgood 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitboardgood() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitboardgoodDAO.getLastIdJnitboardgood() );
    }
}
