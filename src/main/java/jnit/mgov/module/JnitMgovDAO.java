/**
 * @version 3.2.0.1
 */
package jnit.mgov.module;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : jnitmgovDAO.java
 * @Description : Jnitmgov DAO Class
 * @Modification Information
 *
 * @author Dael @ JNIT
 * @since 2012.10.29
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitmgovDAO")
public class JnitMgovDAO extends EgovComAbstractDAO {

    public String insertJnitmgov(JnitMsgdataVO vo) throws Exception {
        return (String)insert("jnitmgovDAO.insertJnitmgov_S", vo);
    }
    
    public String insertJnitLtskoreaSms(JnitMsgdataVO vo) throws Exception {
        return (String)insert("jnitmgovDAO.insertJnitLtskoreaSms_S", vo);
    }

    public void insertJnitmgovMMS(JnitMmsContentsInfoVO vo) throws Exception {
    	insert("jnitmgovDAO.insertJnitmgovMMS_S", vo);
    }
    
    public int getMgovSeq() throws Exception {
    	return (Integer) select("jnitmgovDAO.getMgovSeq");
    }
    
    public void updateMgovSeq() throws Exception {
    	update("jnitmgovDAO.updateMgovSeq", null);
    }
    
    public JnitMsgdataVO selectJnitmgov(JnitMsgdataVO vo) throws Exception {
        return (JnitMsgdataVO) select("jnitmgovDAO.selectJnitmgov_S", vo);
    }
    
    public void deleteJnitmgov(JnitMsgdataVO vo) throws Exception {
        delete("jnitmgovDAO.deleteJnitmgov_S", vo);
    }
    
    public int getMgovNextId() throws Exception {
    	return (Integer)select("jnitmgovDAO.getMgovNextId");
    }

    public List<?> selectJnitmgovList(JnitMgovDefaultVO searchVO) throws Exception {
        return list("jnitmgovDAO.selectJnitmgovList_D", searchVO);
    }
    
    public List<?> selectJnitmgovState(JnitMgovDefaultVO searchVO) throws Exception {
        return list("jnitmgovDAO.selectJnitmgovState", searchVO);
    }
    
    public List<?> selectJnitmgovLMSList(JnitMgovDefaultVO searchVO) throws Exception {
        return list("jnitmgovDAO.selectJnitmgovLMSList_D", searchVO);
    }

    public int selectJnitmgovListTotCnt(JnitMgovDefaultVO searchVO) {
        return (Integer)select("jnitmgovDAO.selectJnitmgovListTotCnt_S", searchVO);
    }
    
    public int selectJnitmgovLMSListTotCnt(JnitMgovDefaultVO searchVO) {
        return (Integer)select("jnitmgovDAO.selectJnitmgovLMSListTotCnt_S", searchVO);
    }

    public String getLastIdJnitmgov() {
    	return (String)select("jnitmgovDAO.getLastIdJnitmgov_S");
    }
    
}
