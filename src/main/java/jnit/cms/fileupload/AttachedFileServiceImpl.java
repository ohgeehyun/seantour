package jnit.cms.fileupload;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : AttachedFileServiceImpl.java
 * @Description : AttachedFile Business Implement class
 * @Modification Information
 *
 * @author YDH
 * @since 2016-08-12
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("attachedFileService")
public class AttachedFileServiceImpl extends EgovAbstractServiceImpl implements AttachedFileService {
        
    private static final Logger LOGGER = LoggerFactory.getLogger(AttachedFileServiceImpl.class);

    @Resource(name="attachedFileDAO")
    private AttachedFileDAO attachedFileDAO;

	/**
	 * 파일을 등록한다.
	 * @param vo - 등록할 정보가 담긴 AttachedFileVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    @Transactional(value="transactionManager", rollbackFor = Exception.class)
    public int insertAttachedFile(AttachedFileVO vo) throws Exception {
    	LOGGER.info("insertAttachedFile : "+vo.toString());

    	return attachedFileDAO.insertAttachedFile(vo);
    }
    
    /**
	 * 파일 정보를 수정한다.
	 * @param vo - 수정할 정보가 담긴 AttachedFileVO
	 * @return void형
	 * @exception Exception
	 */
    @Transactional(value="transactionManager", rollbackFor = Exception.class)
    public void updateAttachedFile(AttachedFileVO vo) throws Exception {
    	LOGGER.info("updateAttachedFile : "+vo.toString());

    	attachedFileDAO.updateAttachedFile(vo);    	
    }

    /**
	 * 파일정보를 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 AttachedFileVO
	 * @return void형 
	 * @exception Exception
	 */
    @Transactional(value="transactionManager", rollbackFor = Exception.class)
    public void deleteAttachedFile(AttachedFileVO vo) throws Exception {
    	LOGGER.info("deleteAttachedFile : "+vo.toString());

    	attachedFileDAO.deleteAttachedFile(vo);    	
    }

    /**
	 * AttachedFileVO을 1건 조회한다.
	 * @param vo - 조회할 정보가 담긴 AttachedFileVO
	 * @return 조회한 AttachedFileVO
	 * @exception Exception
	 */
    public AttachedFileVO getAttachedFile(AttachedFileVO vo) throws Exception {
    	LOGGER.info("getAttachedFile : "+vo.toString());

    	return attachedFileDAO.getAttachedFile(vo);    	
    }

    /**
	 * AttachedFileVO을 여러건 조회한다.
	 * @param vo - 조회할 정보가 담긴 AttachedFileVO
	 * @return 조회한 AttachedFileVO List
	 * @exception Exception
	 */
	public List<AttachedFileVO> getAttachedFileList(AttachedFileVO vo) throws Exception {
    	LOGGER.info("deleteAttachedFile : "+vo.toString());

    	return (List<AttachedFileVO>) attachedFileDAO.getAttachedFileList(vo);
    }    
}
