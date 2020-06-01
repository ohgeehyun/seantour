/**
 * @version 3.2.0.1
 */
package jnit.db;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : JnitdbService.java
 * @Description : Jnitdb Business Implement class
 * @Modification Information
 *
 * @author JNIT
 * @since 2012.06.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("jnitdbService")
public class JnitdbService extends EgovAbstractServiceImpl {

    @Resource(name="jnitdbDAO")
    private JnitdbDAO jnitdbDAO;
    
    public String insert(JnitdbVO vo) throws Exception {
    	
    	
        return jnitdbDAO.insert(vo);
    }

    public void update(JnitdbVO vo) throws Exception {
        jnitdbDAO.update(vo);
    }

    public void delete(JnitdbVO vo) throws Exception {
        jnitdbDAO.delete(vo);
    }

    public Object select(JnitdbVO vo) throws Exception {
        Object resultObj = jnitdbDAO.select(vo);
        if (resultObj == null)
            throw processException("info.nodata.msg");
        return resultObj;
    }
    
    public List<?> selectList(JnitdbVO vo) throws Exception {
        return jnitdbDAO.selectList(vo);
    }
    
    public List<?> dbConnectList(JnitdbVO vo) throws Exception {
        return jnitdbDAO.dbConnectList(vo);
    }
    
    public int selectCnt(JnitdbVO vo) {
		return jnitdbDAO.selectCnt(vo);
	}
}
