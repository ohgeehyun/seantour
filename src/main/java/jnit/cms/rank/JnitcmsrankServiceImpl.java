/**
 * @version 3.2.0.1
 */
package jnit.cms.rank;

import java.util.List;

import javax.annotation.Resource;

import jnit.cms.CmsManageSub2_1Controller;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitcmsrankServiceImpl.java
 * @Description : Jnitcmsrank Business Implement class
 * @Modification Information
 *
 * @author JNITCMSRANK
 * @since 2013.11.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsrankService")
public class JnitcmsrankServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsrankService {

    @Resource(name="jnitcmsrankDAO")
    private JnitcmsrankDAO jnitcmsrankDAO;
    
    /** ID Generation */
    @Resource(name="jnitCMSRANKIdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitcmsrank을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsrankVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsrank(JnitcmsrankVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setRankId(id);
    	
    	
    	jnitcmsrankDAO.insertJnitcmsrank(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }
    
    /**
	 * jnitcmsrank을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsrankVO
	 * @param nextid = 받지않음.
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertDbConnectrank(JnitcmsrankVO vo) throws Exception {
    	
    	
    	jnitcmsrankDAO.insertDbConnectrank(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * jnitcmsrank을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsrankVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsrank(JnitcmsrankVO vo) throws Exception {
        jnitcmsrankDAO.updateJnitcmsrank(vo);
    }

    /**
	 * jnitcmsrank을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitcmsrankVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitcmsrank(JnitcmsrankVO vo) throws Exception {
        jnitcmsrankDAO.deleteJnitcmsrank(vo);
    }

    /**
	 * jnitcmsrank을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsrankVO
	 * @return 조회한 jnitcmsrank
	 * @exception Exception
	 */
    public JnitcmsrankVO selectJnitcmsrank(JnitcmsrankVO vo) throws Exception {
        JnitcmsrankVO resultVO = jnitcmsrankDAO.selectJnitcmsrank(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitcmsrank 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsrank 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmsrankList(JnitcmsrankDefaultVO searchVO) throws Exception {
        return jnitcmsrankDAO.selectJnitcmsrankList(searchVO);
    }
    
    /**
	 * jnitcmsrank 목록을 조회한다.
	 * JNITCMSORG - LEFT JOIN
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @see CmsManageSub2_1Controller
	 * <code>{@link jnit.cms.CmsManageSub2_1Controller # updateJnitcmsmbrView}</code>
	 * <code>{@link jnit.cms.CmsManageSub2_1Controller # Ajax_0102}</code>  
	 * @return jnitcmsrank 목록
	 * @exception Exception
	 */
    public List<?> selectLeftJoinrankList(JnitcmsrankDefaultVO searchVO) throws Exception {
        return jnitcmsrankDAO.selectLeftJoinrankList(searchVO);
    }

    /**
	 * jnitcmsrank 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitcmsrank 총 갯수
	 * @exception
	 */
    public int selectJnitcmsrankListTotCnt(JnitcmsrankDefaultVO searchVO) {
		return jnitcmsrankDAO.selectJnitcmsrankListTotCnt(searchVO);
	}
    
    /**
     * jnitcmsrank 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitcmsrank() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("3");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(4);
    	
        return egovIdGnrStrategy.makeId( (String)jnitcmsrankDAO.getLastIdJnitcmsrank() );
    }
}
