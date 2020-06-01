/**
 * @version 3.2.0.1
 */
package jnit.sms.data;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.impl.strategy.EgovIdGnrStrategyImpl;

/**
 * @Class Name : SmsdataServiceImpl.java
 * @Description : Smsdata Business Implement class
 * @Modification Information
 *
 * @author JNITSMSDATA
 * @since 2014.02.17
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("smsdataService")
public class SmsdataServiceImpl extends EgovAbstractServiceImpl implements
        SmsdataService {

    @Resource(name="smsdataDAO")
    private SmsdataDAO smsdataDAO;
    
    /** ID Generation */
    //@Resource(name="{egovSmsdataIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * SMSDATA을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SmsdataVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertSmsdata(SmsdataVO vo) throws Exception {
    	
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	
    	
    	smsdataDAO.insertSmsdata(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * SMSDATA을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SmsdataVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateSmsdata(SmsdataVO vo) throws Exception {
        smsdataDAO.updateSmsdata(vo);
    }

    /**
	 * SMSDATA을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SmsdataVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteSmsdata(SmsdataVO vo) throws Exception {
        smsdataDAO.deleteSmsdata(vo);
    }

    /**
	 * SMSDATA을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SmsdataVO
	 * @return 조회한 SMSDATA
	 * @exception Exception
	 */
    public SmsdataVO selectSmsdata(SmsdataVO vo) throws Exception {
        SmsdataVO resultVO = smsdataDAO.selectSmsdata(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * SMSDATA 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SMSDATA 목록
	 * @exception Exception
	 */
    public List<?> selectSmsdataList(SmsdataDefaultVO searchVO) throws Exception {
        return smsdataDAO.selectSmsdataList(searchVO);
    }

    /**
	 * SMSDATA 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return SMSDATA 총 갯수
	 * @exception
	 */
    public int selectSmsdataListTotCnt(SmsdataDefaultVO searchVO) {
		return smsdataDAO.selectSmsdataListTotCnt(searchVO);
	}
    
    /**
     * SMSDATA 다음 등록 SEQ를 조회한다
     * @param void
     * @return 다음 등록 SEQ
     * @exception Exception
     */
    public String getLastIdSmsdata() throws Exception {
    	EgovIdGnrStrategyImpl egovIdGnrStrategy = new EgovIdGnrStrategyImpl();
    	
    	egovIdGnrStrategy.setPrefix("");
    	egovIdGnrStrategy.setFillChar('0');
    	egovIdGnrStrategy.setCipers(10);
    	
        return egovIdGnrStrategy.makeId( (String)smsdataDAO.getLastIdSmsdata() );
    }
}
