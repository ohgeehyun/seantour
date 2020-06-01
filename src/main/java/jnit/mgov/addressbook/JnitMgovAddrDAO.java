/**
 * @version 3.2.0.1
 */
package jnit.mgov.addressbook;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("jnitMgovAddrDAO")
public class JnitMgovAddrDAO extends EgovComAbstractDAO {

	public void insertJnitMgovAddrGrp(JnitMgovAddrGrpVO vo) throws Exception {
		insert("jnitsmsaddressbookDAO.insertJnitMgovAddrGrp", vo);
	}
	
	public void insertJnitMgovAddrList(JnitMgovAddrListVO vo) throws Exception {
		insert("jnitsmsaddressbookDAO.insertJnitMgovAddrList", vo);
	}
	
	public void deleteJnitMgovAddrGrp(JnitMgovAddrGrpVO vo) throws Exception {
		delete("jnitsmsaddressbookDAO.deleteJnitMgovAddrGrp", vo);
	}
	
	public void deleteJnitMgovAddrList(JnitMgovAddrListVO vo) throws Exception {
		delete("jnitsmsaddressbookDAO.deleteJnitMgovAddrList", vo);
	}
	
    public List<?> selectJnitMgovAddrGrp(JnitMgovAddrDefaultVO searchVO) throws Exception {
    	return list("jnitsmsaddressbookDAO.selectJnitMgovAddrGrp", searchVO);
    }
    
    public List<?> selectJnitMgovAddrList(JnitMgovAddrDefaultVO searchVO) throws Exception {
    	return list("jnitsmsaddressbookDAO.selectJnitMgovAddrList", searchVO);
    }

    public String getLastIdJnitMgovAddrGrp() {
    	return (String)select("jnitsmsaddressbookDAO.getLastIdJnitMgovAddrGrp");
    }
    
    public String getLastIdJnitMgovAddrList() {
    	return (String)select("jnitsmsaddressbookDAO.getLastIdJnitMgovAddrList");
    }
}
