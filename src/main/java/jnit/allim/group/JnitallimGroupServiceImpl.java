/**
 * @version 3.2.0.1
 */
package jnit.allim.group;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : JnitallimGroupServiceImpl.java
 * @Description : JnitallimGroup Business Implement class
 * @Modification Information
 *
 * @author JNITALLIM_GROUP
 * @since 2012.04.24
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitallimGroupService")
public class JnitallimGroupServiceImpl extends EgovAbstractServiceImpl implements
        JnitallimGroupService {

    @Resource(name="jnitallimGroupDAO")
    private JnitallimGroupDAO jnitallimGroupDAO;
    
    /** ID Generation */
    @Resource(name="jnitALLIM_GROUP_IdGnrService")    
    private EgovIdGnrService egovIdGnrService;

	/**
	 * jnitallim_group을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitallimGroupVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitallimGroup(JnitallimGroupVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	String id = egovIdGnrService.getNextStringId();
    	vo.setGroupId(id);
    	
    	jnitallimGroupDAO.insertJnitallimGroup(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * jnitallim_group을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitallimGroupVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitallimGroup(JnitallimGroupVO vo) throws Exception {
        jnitallimGroupDAO.updateJnitallimGroup(vo);
    }

    /**
	 * jnitallim_group을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 JnitallimGroupVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteJnitallimGroup(JnitallimGroupVO vo) throws Exception {
        jnitallimGroupDAO.deleteJnitallimGroup(vo);
    }

    /**
	 * jnitallim_group을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitallimGroupVO
	 * @return 조회한 jnitallim_group
	 * @exception Exception
	 */
    public JnitallimGroupVO selectJnitallimGroup(JnitallimGroupVO vo) throws Exception {
        JnitallimGroupVO resultVO = jnitallimGroupDAO.selectJnitallimGroup(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    public List<?> selectJnitallimGroupList(JnitallimGroupDefaultVO searchVO) throws Exception {
        return jnitallimGroupDAO.selectJnitallimGroupList(searchVO);
    }
    
    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    public List<?> selectGroupList(JnitallimGroupDefaultVO searchVO) throws Exception {
        return jnitallimGroupDAO.selectGroupList(searchVO);
    }
    
    /**
	 * jnitallim_group 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 목록
	 * @exception Exception
	 */
    public List<?> selectMoreList(JnitallimGroupDefaultVO searchVO) throws Exception {
        return jnitallimGroupDAO.selectMoreList(searchVO);
    }

    /**
	 * jnitallim_group 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 총 갯수
	 * @exception
	 */
    public int selectJnitallimGroupListTotCnt(JnitallimGroupDefaultVO searchVO) {
		return jnitallimGroupDAO.selectJnitallimGroupListTotCnt(searchVO);
	}
    
    /**
	 * jnitallim_group 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return jnitallim_group 총 갯수
	 * @exception
	 */
    public int selectGroupListTotCnt(JnitallimGroupDefaultVO searchVO) {
		return jnitallimGroupDAO.selectGroupListTotCnt(searchVO);
	}
    
    /**
     * jnitallim_group 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdJnitallimGroup() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)jnitallimGroupDAO.getLastIdJnitallimGroup() );
    }
}
