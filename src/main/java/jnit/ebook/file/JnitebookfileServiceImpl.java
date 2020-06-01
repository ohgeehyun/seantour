/**
 * @version 3.2.0.1
 */
package jnit.ebook.file;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitebookfileServiceImpl.java
 * @Description : Jnitebookfile Business Implement class
 * @Modification Information
 *
 * @author JNITEBOOKFILE
 * @since 2014.02.07
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitebookfileService")
public class JnitebookfileServiceImpl extends EgovAbstractServiceImpl implements
        JnitebookfileService {

    @Resource(name="jnitebookfileDAO")
    private JnitebookfileDAO jnitebookfileDAO;
    
    /** ID Generation */
    @Resource(name="jnitEBOOKFILE_IDGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITEBOOKFILE을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitebookfileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitebookfile(JnitebookfileVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setFileId(id);
    	   	
		    	
    	jnitebookfileDAO.insertJnitebookfile(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITEBOOKFILE을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitebookfileVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitebookfile(JnitebookfileVO vo) throws Exception {    	
        jnitebookfileDAO.updateJnitebookfile(vo);
    }

    /**
	 * JNITEBOOKFILE을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitebookfileVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitebookfile(JnitebookfileVO vo) throws Exception {
        jnitebookfileDAO.deleteJnitebookfile(vo);
    }

    /**
	 * JNITEBOOKFILE을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitebookfileVO
	 * @return 조회한 JNITEBOOKFILE
	 * @exception Exception
	 */
    public JnitebookfileVO selectJnitebookfile(JnitebookfileVO vo) throws Exception {
        JnitebookfileVO resultVO = jnitebookfileDAO.selectJnitebookfile(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITEBOOKFILE 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITEBOOKFILE 목록
	 * @exception Exception
	 */
    public List<?> selectJnitebookfileList(JnitebookfileDefaultVO searchVO) throws Exception {
        return jnitebookfileDAO.selectJnitebookfileList(searchVO);
    }

    /**
	 * JNITEBOOKFILE 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITEBOOKFILE 총 갯수
	 * @exception
	 */
    public int selectJnitebookfileListTotCnt(JnitebookfileDefaultVO searchVO) {
		return jnitebookfileDAO.selectJnitebookfileListTotCnt(searchVO);
	}
    
    /**
     * JNITEBOOKFILE 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitebookfile() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitebookfileDAO.getLastIdJnitebookfile() );
    }
}
