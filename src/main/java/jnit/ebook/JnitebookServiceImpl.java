/**
 * @version 3.2.0.1
 */
package jnit.ebook;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitebookServiceImpl.java
 * @Description : Jnitebook Business Implement class
 * @Modification Information
 *
 * @author JNITEBOOK
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitebookService")
public class JnitebookServiceImpl extends EgovAbstractServiceImpl implements
        JnitebookService {

    @Resource(name="jnitebookDAO")
    private JnitebookDAO jnitebookDAO;
    
    /** ID Generation */
    @Resource(name="jnitEBOOK_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITEBOOK을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitebookVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitebook(JnitebookVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setEbookId(id);
    	
    	
    	jnitebookDAO.insertJnitebook(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITEBOOK을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitebookVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitebook(JnitebookVO vo) throws Exception {
        jnitebookDAO.updateJnitebook(vo);
    }

    /**
	 * JNITEBOOK을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitebookVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitebook(JnitebookVO vo) throws Exception {
        jnitebookDAO.deleteJnitebook(vo);
    }

    /**
	 * JNITEBOOK을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitebookVO
	 * @return 조회한 JNITEBOOK
	 * @exception Exception
	 */
    public JnitebookVO selectJnitebook(JnitebookVO vo) throws Exception {
        JnitebookVO resultVO = jnitebookDAO.selectJnitebook(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITEBOOK 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITEBOOK 목록
	 * @exception Exception
	 */
    public List<?> selectJnitebookList(JnitebookDefaultVO searchVO) throws Exception {
        return jnitebookDAO.selectJnitebookList(searchVO);
    }

    /**
	 * JNITEBOOK 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITEBOOK 총 갯수
	 * @exception
	 */
    public int selectJnitebookListTotCnt(JnitebookDefaultVO searchVO) {
		return jnitebookDAO.selectJnitebookListTotCnt(searchVO);
	}
    
    /**
     * JNITEBOOK 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitebook() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitebookDAO.getLastIdJnitebook() );
    }
}
