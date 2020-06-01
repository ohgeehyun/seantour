/**
 * @version 3.2.0.1
 */
package jnit.cms.mbrsess;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : JnitcmsmbrsessServiceImpl.java
 * @Description : Jnitcmsmbrsess Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.xx.xx
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmsmbrsessService")
public class JnitcmsmbrsessServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmsmbrsessService {

    @Resource(name="jnitcmsmbrsessDAO")
    private JnitcmsmbrsessDAO jnitcmsmbrsessDAO;
    
    /** ID Generation */
    //@Resource(name="{egovJnitcmsmbrsessIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * JNITCMSMBRSESS을 등록한다.
	 * @param vo - 등록할 정보가 담긴 JnitcmsmbrsessVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception {
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	
    	String id = jnitcmsmbrsessDAO.insertJnitcmsmbrsess(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return id;
    }

    /**
	 * JNITCMSMBRSESS을 수정한다.
	 * @param vo - 수정할 정보가 담긴 JnitcmsmbrsessVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception {
        jnitcmsmbrsessDAO.updateJnitcmsmbrsess(vo);
    }

    /**
	 * JNITCMSMBRSESS을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmsmbrsessVO
	 * @return 조회한 JNITCMSMBRSESS
	 * @exception Exception
	 */
    public JnitcmsmbrsessVO selectJnitcmsmbrsess(JnitcmsmbrsessVO vo) throws Exception {
        JnitcmsmbrsessVO resultVO = jnitcmsmbrsessDAO.selectJnitcmsmbrsess(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSMBRSESS 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSMBRSESS 총 갯수
	 * @exception
	 */
    public int selectJnitcmsmbrsessListTotCnt(JnitcmsmbrsessDefaultVO searchVO) {
		return jnitcmsmbrsessDAO.selectJnitcmsmbrsessListTotCnt(searchVO);
	}
}
