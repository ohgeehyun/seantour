/**
 * @version 3.2.0.1
 */
package jnit.cms.cntvt;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : JnitcmscntvtServiceImpl.java
 * @Description : Jnitcmscntvt Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.07.12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitcmscntvtService")
public class JnitcmscntvtServiceImpl extends EgovAbstractServiceImpl implements
        JnitcmscntvtService {

    @Resource(name="jnitcmscntvtDAO")
    private JnitcmscntvtDAO jnitcmscntvtDAO;
    
    /** ID Generation */
    //@Resource(name="{egovJnitcmscntvtIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

    /**
	 * JNITCMSCNTVT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 JnitcmscntvtVO
	 * @return 조회한 JNITCMSCNTVT
	 * @exception Exception
	 */
    public JnitcmscntvtVO selectJnitcmscntvt(JnitcmscntvtVO vo) throws Exception {
        JnitcmscntvtVO resultVO = jnitcmscntvtDAO.selectJnitcmscntvt(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * JNITCMSCNTVT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNTVT 목록
	 * @exception Exception
	 */
    public List<?> selectJnitcmscntvtList(JnitcmscntvtDefaultVO searchVO) throws Exception {
        return jnitcmscntvtDAO.selectJnitcmscntvtList(searchVO);
    }

    /**
	 * JNITCMSCNTVT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return JNITCMSCNTVT 총 갯수
	 * @exception
	 */
    public int selectJnitcmscntvtListTotCnt(JnitcmscntvtDefaultVO searchVO) {
		return jnitcmscntvtDAO.selectJnitcmscntvtListTotCnt(searchVO);
	}
}
