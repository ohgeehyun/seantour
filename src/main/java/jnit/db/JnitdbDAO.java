/**
 * @version 3.2.0.1
 */
package jnit.db;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

/**
 * @Class Name : jnitdbDAO.java
 * @Description : Jnitcmsmbrtype DAO Class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("jnitdbDAO")
public class JnitdbDAO extends EgovComAbstractDAO {

    public String insert(JnitdbVO vo) throws Exception {
        return (String)insert("jnitdbDAO.insert_S", vo);
    }

    public void update(JnitdbVO vo) throws Exception {
        update("jnitdbDAO.update_S", vo);
    }
    
    public void delete(JnitdbVO vo) throws Exception {
        delete("jnitdbDAO.delete_S", vo);
    }


    public Object select(JnitdbVO vo) {
        return select("jnitdbDAO.select_S", vo);
    }
    
    public List<?> selectList(JnitdbVO vo) throws Exception {
        return list("jnitdbDAO.selectList_D", vo);
    }
    public List<?> dbConnectList(JnitdbVO vo) throws Exception {
        return list("jnitdbDAO.dbConnectList_D", vo);
    }

    public int selectCnt(JnitdbVO vo) {
        return (Integer)select("jnitdbDAO.selectCnt_S", vo);
    }
}
