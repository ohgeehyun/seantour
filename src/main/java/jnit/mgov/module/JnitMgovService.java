/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;

import java.util.List;

/**
 * @Class Name : JnitvisitlogService.java
 * @Description : Jnitvisitlog Business class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface JnitMgovService {
	
    String insertJnitmgov(JnitMsgdataVO vo) throws Exception;
    
    String insertJnitLtskoreaSms(JnitMsgdataVO vo) throws Exception;

    void insertJnitmgovMMS(JnitMmsContentsInfoVO vo) throws Exception;
    
    void deleteJnitmgov(JnitMsgdataVO vo) throws Exception;
    
    void updateMgovSeq() throws Exception;
    
    int getMgovSeq() throws Exception;
    
    int getMgovNextId() throws Exception;
    
    JnitMsgdataVO selectJnitmgov(JnitMsgdataVO vo) throws Exception;
    
    List selectJnitmgovList(JnitMgovDefaultVO searchVO) throws Exception;
    
    List selectJnitmgovState(JnitMgovDefaultVO searchVO) throws Exception;
    
    List selectJnitmgovLMSList(JnitMgovDefaultVO searchVO) throws Exception;
    
    int selectJnitmgovListTotCnt(JnitMgovDefaultVO searchVO);
    
    int selectJnitmgovLMSListTotCnt(JnitMgovDefaultVO searchVO);
    
    String getLastIdJnitmgov() throws Exception;
}
